Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5CD87EC024
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 11:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbjKOJyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 04:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234773AbjKOJyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 04:54:50 -0500
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id CABAF106;
        Wed, 15 Nov 2023 01:54:45 -0800 (PST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 35B63602806DA;
        Wed, 15 Nov 2023 17:54:40 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
To:     vkoul@kernel.org, yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com
Cc:     Su Hui <suhui@nfschina.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] soundwire: amd: add an error code check in amd_sdw_clock_stop_exit
Date:   Wed, 15 Nov 2023 17:54:08 +0800
Message-Id: <20231115095407.1059704-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang static analyzer complains that value stored to 'ret' is never read.
Add an error code check and print an error message if 'readl_poll_timeout'
failed.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/soundwire/amd_manager.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index 3a99f6dcdfaf..f391b541f4b7 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -1029,6 +1029,10 @@ static int amd_sdw_clock_stop_exit(struct amd_sdw_manager *amd_manager)
 		ret = readl_poll_timeout(amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL, val,
 					 (val & AMD_SDW_CLK_RESUME_DONE), ACP_DELAY_US,
 					 AMD_SDW_TIMEOUT);
+		if (ret)
+			dev_err(amd_manager->dev, "%s: timed out: %pe\n", __func__,
+				ERR_PTR(ret));
+
 		if (val & AMD_SDW_CLK_RESUME_DONE) {
 			writel(0, amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL);
 			ret = sdw_bus_exit_clk_stop(&amd_manager->bus);
-- 
2.30.2

