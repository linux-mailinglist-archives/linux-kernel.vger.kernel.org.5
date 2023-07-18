Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46DE757E56
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbjGRNz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232982AbjGRNzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:55:50 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786E38F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:55:48 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qLlB2-0008Bb-2X;
        Tue, 18 Jul 2023 13:55:44 +0000
Date:   Tue, 18 Jul 2023 14:55:31 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] nvmem: core: clear sysfs attributes for each NVMEM device
Message-ID: <ZLaZ03PzkbPNJQ3b@makrotopia.org>
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

Set nvmem_cells_group.bin_attrs to NULL in case of an NVMEM device not
having any cells in order to make sure sysfs attributes of a previously
registered NVMEM device are not accidentally reused for a follow-up
device which doesn't have any cells.

Fixes: 757f8b3835c9 ("nvmem: core: Expose cells through sysfs")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/nvmem/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 6c04a9cf6919f..70e951088826d 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -458,9 +458,10 @@ static int nvmem_populate_sysfs_cells(struct nvmem_device *nvmem)
 
 	mutex_lock(&nvmem_mutex);
 
-	if (list_empty(&nvmem->cells))
+	if (list_empty(&nvmem->cells)) {
+		nvmem_cells_group.bin_attrs = NULL;
 		goto unlock_mutex;
-
+	}
 	/* Allocate an array of attributes with a sentinel */
 	ncells = list_count_nodes(&nvmem->cells);
 	cells_attrs = devm_kcalloc(&nvmem->dev, ncells + 1,
-- 
2.41.0

