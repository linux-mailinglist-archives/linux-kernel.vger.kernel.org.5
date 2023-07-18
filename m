Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2FD0757E97
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjGRN4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjGRN4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:56:32 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4391712
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:56:11 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qLlBQ-0008CI-03;
        Tue, 18 Jul 2023 13:56:08 +0000
Date:   Tue, 18 Jul 2023 14:55:57 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] nvmem: core: append offset to cell name in sysfs
Message-ID: <ZLaZ7fzUSsa0Igx1@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device tree node names are not required to be unique. Append the
offset to the name to make cell nodes with identical names become
accessible via sysfs and avoid kernel stackdump caused by
sysfs: cannot create duplicate filename '...'

Fixes: 757f8b3835c9 ("nvmem: core: Expose cells through sysfs")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/nvmem/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 70e951088826d..90fe9dc30f8ba 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -480,7 +480,9 @@ static int nvmem_populate_sysfs_cells(struct nvmem_device *nvmem)
 	/* Initialize each attribute to take the name and size of the cell */
 	list_for_each_entry(entry, &nvmem->cells, node) {
 		sysfs_bin_attr_init(&attrs[i]);
-		attrs[i].attr.name = devm_kstrdup(&nvmem->dev, entry->name, GFP_KERNEL);
+		attrs[i].attr.name = devm_kasprintf(&nvmem->dev, GFP_KERNEL,
+						    "%s@%d", entry->name,
+						    entry->offset);
 		attrs[i].attr.mode = 0444;
 		attrs[i].size = entry->bytes;
 		attrs[i].read = &nvmem_cell_attr_read;
-- 
2.41.0

