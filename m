Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A10786CFB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 12:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240848AbjHXKmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 06:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240733AbjHXKmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 06:42:05 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673961991
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 03:42:03 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bf078d5f33so52270075ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 03:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692873723; x=1693478523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5Mj2qxwRu6ImbCbgKZB2mTmZc1sJ7FaGws4X/FyAcE=;
        b=hZcQz83MuTgtVUHEdO3LOPIFB0JNUEtBmCMJCDx9VL+8o4UxqsI1LRU5qOk/EXIyhZ
         96mdg+nhN+nkSlIDrvQ9tWxN32QvRpmMl2z70EA4VSyUSViZZ1Zz/K9JfTVjQ3fkYxaF
         gw+rR/aaoD2Q5MAoxZQg20nwNEbqER36/p6cE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692873723; x=1693478523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R5Mj2qxwRu6ImbCbgKZB2mTmZc1sJ7FaGws4X/FyAcE=;
        b=gCFuA10l4kjLX+c2o9r9SVkVCyDg+b/JyUDwtDwnnoh07+muwuvvtVBJGXwAXJAkmX
         dYa2xnnP3cksk7hchVMbYgjhMs+efRCzkGFi7cWYKv+H6sUIfcYVJqgTQBt/QE0aPkEP
         hRxRY+GBEDQ2ynaLcPz5T5yzokgbK+uduABtxFMrtam0Kgy3fxtQSLjMBLsw8w58zdE7
         tsyIz4yY6ANCWL7XfZ196a02AIxifHq5CKBkGzCsQ+FT3rF95O6NEYb8rK4C1+he0XsU
         gWWYzINkAbmqhNY4AF9ydqVnb1wVibAz21hgmB2ByJGvkoq3z9zbV0XaOQe9igsPX4jN
         9nQA==
X-Gm-Message-State: AOJu0Yws8ogpgnv+POQIUmOPc5pPvgVr/ySR/sItUftoGioKFbDbTb8w
        9XqrsgANXk0duhhxncqAtkvQ7ZoCq6I2NzjWezo=
X-Google-Smtp-Source: AGHT+IGao9Th9qVXpav06rwJB33LMdKfO90d0/0YX0Nw2S957J/ZS1b/jA6DEO74HGdi3p7m7JgSFw==
X-Received: by 2002:a17:903:264d:b0:1bf:364:f013 with SMTP id je13-20020a170903264d00b001bf0364f013mr13653715plb.45.1692873722931;
        Thu, 24 Aug 2023 03:42:02 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:ed6d:42e3:a23:8316])
        by smtp.gmail.com with ESMTPSA id q2-20020a170902dac200b001b5247cac3dsm12524645plx.110.2023.08.24.03.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 03:42:02 -0700 (PDT)
From:   Fei Shao <fshao@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wenst@chromium.org>
Cc:     linux-mediatek@lists.infradead.org, Fei Shao <fshao@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] spmi: Return meaningful errors in spmi_controller_alloc()
Date:   Thu, 24 Aug 2023 18:40:12 +0800
Message-ID: <20230824104101.4083400-6-fshao@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230824104101.4083400-1-fshao@chromium.org>
References: <20230824104101.4083400-1-fshao@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

spmi_controller_alloc() currently returns NULL to all types of errors,
which can be improved.

Use appropriate error code in returns and pass the errors from used
functions where possible.

Signed-off-by: Fei Shao <fshao@chromium.org>
---

 drivers/spmi/devres.c | 4 ++--
 drivers/spmi/spmi.c   | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spmi/devres.c b/drivers/spmi/devres.c
index f18cbbe28812..c19f09243bc3 100644
--- a/drivers/spmi/devres.c
+++ b/drivers/spmi/devres.c
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
2.42.0.rc1.204.g551eb34607-goog

