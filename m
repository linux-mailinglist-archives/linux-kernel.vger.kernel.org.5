Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610767516EE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 05:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbjGMDxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 23:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbjGMDxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 23:53:20 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000911BF2;
        Wed, 12 Jul 2023 20:53:18 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qJnOE-0005w0-1M;
        Thu, 13 Jul 2023 03:53:15 +0000
Date:   Thu, 13 Jul 2023 04:52:59 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ye Bin <yebin10@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Seunghui Lee <sh043.lee@samsung.com>
Subject: [PATCH] mmc: core: set card fwnode_handle
Message-ID: <ZK91G1qd8JwFEpIX@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also set card's device fwnode in case it isn't set yet and of_node is
present.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/mmc/core/bus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 2c3074a605fc4..ecf6e23e4c307 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -361,6 +361,8 @@ int mmc_add_card(struct mmc_card *card)
 
 	mmc_add_card_debugfs(card);
 	card->dev.of_node = mmc_of_find_child_device(card->host, 0);
+	if (card->dev.of_node && !card->dev.fwnode)
+		card->dev.fwnode = &card->dev.of_node->fwnode;
 
 	device_enable_async_suspend(&card->dev);
 
-- 
2.41.0
