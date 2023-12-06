Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED706807C39
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 00:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjLFXRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 18:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379625AbjLFXRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 18:17:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D24D6D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 15:17:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE161C433C8;
        Wed,  6 Dec 2023 23:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701904657;
        bh=0Qw8myzJlI3KvHO4ZZ9sYNzQlLdb50E+KYoJvBETQBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qAxZ9aTSAhvoOKJ3eMtfYllXKM8tyzCzwF0nY3H0T7478W3tIEvmsSp7Wg7bfvNMm
         sATZj5/cS+X8srz04BDBgDT119KuKL89gaBl5B/mgH1C2P/r7FoDVc+DCu7qvsAVXJ
         E8Ct3p4XBEyyU46XyBq6rNT2TYcDXS0kXvidAmIuNitbkulQcwXjlI+4tb5O/czBPP
         vciad4Q00mi9IbLeywfL80hvUx9QGLGY69JpCkqsu8WAjWPqHTXyUqW4iGpBihRqoJ
         oEndnjKfQIfbgritGCDZi3BMI6SZEBVEGDbdjbwtCphk7OCvV1/kIWERQHQSeQM0QN
         ZTAIx7m4IRM+w==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Fei Shao <fshao@chromium.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: [PATCH 7/8] spmi: Return meaningful errors in spmi_controller_alloc()
Date:   Wed,  6 Dec 2023 15:17:30 -0800
Message-ID: <20231206231733.4031901-8-sboyd@kernel.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231206231733.4031901-1-sboyd@kernel.org>
References: <20231206231733.4031901-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fei Shao <fshao@chromium.org>

spmi_controller_alloc() currently returns NULL to all types of errors,
which can be improved.

Use appropriate error code in returns and pass the errors from used
functions where possible.

Signed-off-by: Fei Shao <fshao@chromium.org>
Link: https://lore.kernel.org/r/20230824104101.4083400-6-fshao@chromium.org
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/spmi/spmi-devres.c | 4 ++--
 drivers/spmi/spmi.c        | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spmi/spmi-devres.c b/drivers/spmi/spmi-devres.c
index 7683e6fdb18f..62c4b3f24d06 100644
--- a/drivers/spmi/spmi-devres.c
+++ b/drivers/spmi/spmi-devres.c
@@ -20,9 +20,9 @@ struct spmi_controller *devm_spmi_controller_alloc(struct device *parent, size_t
 		return ERR_PTR(-ENOMEM);
 
 	ctrl = spmi_controller_alloc(parent, size);
-	if (!ctrl) {
+	if (IS_ERR(ctrl)) {
 		devres_free(ptr);
-		return ERR_PTR(-ENOMEM);
+		return ctrl;
 	}
 
 	*ptr = ctrl;
diff --git a/drivers/spmi/spmi.c b/drivers/spmi/spmi.c
index 7313d4c18a04..5f11ced3f8b9 100644
--- a/drivers/spmi/spmi.c
+++ b/drivers/spmi/spmi.c
@@ -445,11 +445,11 @@ struct spmi_controller *spmi_controller_alloc(struct device *parent,
 	int id;
 
 	if (WARN_ON(!parent))
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	ctrl = kzalloc(sizeof(*ctrl) + size, GFP_KERNEL);
 	if (!ctrl)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	device_initialize(&ctrl->dev);
 	ctrl->dev.type = &spmi_ctrl_type;
@@ -463,7 +463,7 @@ struct spmi_controller *spmi_controller_alloc(struct device *parent,
 		dev_err(parent,
 			"unable to allocate SPMI controller identifier.\n");
 		spmi_controller_put(ctrl);
-		return NULL;
+		return ERR_PTR(id);
 	}
 
 	ctrl->nr = id;
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

