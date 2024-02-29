Return-Path: <linux-kernel+bounces-87538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD37586D5A5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 156251C2340B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C784214EA23;
	Thu, 29 Feb 2024 20:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vZvrrRto"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB0E145673
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 20:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709240165; cv=none; b=I9BWoqf57nEaE0cXqZ87Ha1obbgcpkwlgTH9lhJ53HIu1IYuuKoUuf6/RWfqDPDDmsgcnQYzA5BFVHER+hJeJge74qdnWPbHebhT9w9LOFL3ywXIcLJen7/X6w8Z/o6fXcqhuXKMv5njqqEfM/buOxk1JF4xuq54y2DZH6HWSoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709240165; c=relaxed/simple;
	bh=XwGOf1MLWzPXiuaGkXStpdLvB4FPo5vk4nLwFw1ga6k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qkHGM7dW9zWeLvZiMe4EFxD81RYhU17RkSPNYuhnYsmQ3No5nP4J28AYcWeOqy8E0O8Blp6bz+6Ad+DaLRi/h++eXjjQWYGfroLgZse8aXNBL1CEgegOQqnlJtZlGxQpoPCksWlS2LhjAwcie+cUdwyMGsqV7eR26wlA8urFyMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vZvrrRto; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-365169e0938so4008725ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 12:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709240163; x=1709844963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TGWJjaxvrYhNIssQekJJrsQHyV2VIpv1G8S6HOh3hAI=;
        b=vZvrrRtoJ0d9uTr6s3Pb/ceg1M0WUShdeXro7vTkFOuyMhhCxWOBFuU2vqDIMYMbx6
         1p10cO8/kLLuKXEdFnXVzAQIlPL6RG436NEt/5Rwbr6MQgNhyR3nYpzdNPA8aEqS9GX/
         L7nWkkoY259bDUvFZxZtQVuJandsi1M9vCy/fr3uNBCtIbHjWxU23ABTel1RfWDhjfb3
         jYBkqSKnZiscII1i+2l9mZuhkrlbZAF2MkyGc9PjB7a8Pobb6dbuz+pXcUyxA/8NIZCM
         G/p0Svhvp4q7v78mMdfpipj/SuQyTGlWoexXe9A2Pov9eniDYEG1ujo5gizx2vS8T8Qr
         JCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709240163; x=1709844963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TGWJjaxvrYhNIssQekJJrsQHyV2VIpv1G8S6HOh3hAI=;
        b=uAZ2nXzTSLw28GMBVbb8cmIcfbO6DVEFpXcegp41DvFyozTsCi39N4/20l4hjK0WwI
         YK4aySTMBPo2DBooTPbnBOPTzTokEd6wuXcidGERupxys0yx62GDaiVlv1xvTRWcp4cL
         WW6DsLu1avG6YXN69rNuSOrUeDo/V4aIZvKLuU+jw2SbLYhFoVzqqoGAuu3sKMWxADlW
         C9/ZmszovLmADK6JpSTB3SGMuRW7XRzttlAMBPwOmgBDF4X3UyW4I5wqmCp/8oiufoAr
         wtw6PYhPTFV3LvAxwtw2odGiK8n1yNbepEur3KoLx8gFEOGhpJ0KJfwoFhjLRNPle4HR
         Bd0w==
X-Forwarded-Encrypted: i=1; AJvYcCWWuydNOq5d2JStWVeRu20mKAiblon1/v8swcikuZ8ocnAYE5Qnkcw62MGJsI4aBdszEiUJVWs+ChC9RYp19BJB2k4rZ0RCObm1KJ7M
X-Gm-Message-State: AOJu0YwYzYZ5H2RKv1WvyWxE46mORIc9EVtN5Vg6Lqw25dgopDFQM1R5
	6k1yRv3GDvkFgMeTOTN0PSlo+ovD14DpTs4UIkNYKwYxgl5ArKNqYQTjZOwAnfI=
X-Google-Smtp-Source: AGHT+IFiZEOjl8Eg1h5669qLC0O7+SdSht2D0xZWN6IxWmQVMl7eENwv3Y4e2KBM5sTVa/64RKullw==
X-Received: by 2002:a05:6e02:2195:b0:365:1c5:7a5a with SMTP id j21-20020a056e02219500b0036501c57a5amr24688ila.4.1709240163486;
        Thu, 29 Feb 2024 12:56:03 -0800 (PST)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id h14-20020a056e020d4e00b003658fbcf55dsm521551ilj.72.2024.02.29.12.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 12:56:03 -0800 (PST)
From: Alex Elder <elder@linaro.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: mka@chromium.org,
	andersson@kernel.org,
	quic_cpratapa@quicinc.com,
	quic_avuyyuru@quicinc.com,
	quic_jponduru@quicinc.com,
	quic_subashab@quicinc.com,
	elder@kernel.org,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/7] net: ipa: pass a platform device to ipa_reg_init()
Date: Thu, 29 Feb 2024 14:55:50 -0600
Message-Id: <20240229205554.86762-4-elder@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240229205554.86762-1-elder@linaro.org>
References: <20240229205554.86762-1-elder@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than using the platform device pointer field in the IPA
pointer, pass a platform device pointer to ipa_reg_init().  Use
that pointer throughout that function.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_main.c | 2 +-
 drivers/net/ipa/ipa_reg.c  | 8 ++++----
 drivers/net/ipa/ipa_reg.h  | 4 +++-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
index 6cf5c1280aa4e..5c9c1b0ef8de5 100644
--- a/drivers/net/ipa/ipa_main.c
+++ b/drivers/net/ipa/ipa_main.c
@@ -866,7 +866,7 @@ static int ipa_probe(struct platform_device *pdev)
 	ipa->modem_route_count = data->modem_route_count;
 	init_completion(&ipa->completion);
 
-	ret = ipa_reg_init(ipa);
+	ret = ipa_reg_init(ipa, pdev);
 	if (ret)
 		goto err_kfree_ipa;
 
diff --git a/drivers/net/ipa/ipa_reg.c b/drivers/net/ipa/ipa_reg.c
index 6a3203ae6f1ef..98625956e0bb4 100644
--- a/drivers/net/ipa/ipa_reg.c
+++ b/drivers/net/ipa/ipa_reg.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2019-2023 Linaro Ltd.
  */
 
+#include <linux/platform_device.h>
 #include <linux/io.h>
 
 #include "ipa.h"
@@ -132,9 +133,9 @@ static const struct regs *ipa_regs(enum ipa_version version)
 	}
 }
 
-int ipa_reg_init(struct ipa *ipa)
+int ipa_reg_init(struct ipa *ipa, struct platform_device *pdev)
 {
-	struct device *dev = &ipa->pdev->dev;
+	struct device *dev = &pdev->dev;
 	const struct regs *regs;
 	struct resource *res;
 
@@ -146,8 +147,7 @@ int ipa_reg_init(struct ipa *ipa)
 		return -EINVAL;
 
 	/* Setup IPA register memory  */
-	res = platform_get_resource_byname(ipa->pdev, IORESOURCE_MEM,
-					   "ipa-reg");
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ipa-reg");
 	if (!res) {
 		dev_err(dev, "DT error getting \"ipa-reg\" memory property\n");
 		return -ENODEV;
diff --git a/drivers/net/ipa/ipa_reg.h b/drivers/net/ipa/ipa_reg.h
index 2998f115f12c7..62c62495b7968 100644
--- a/drivers/net/ipa/ipa_reg.h
+++ b/drivers/net/ipa/ipa_reg.h
@@ -12,6 +12,8 @@
 #include "ipa_version.h"
 #include "reg.h"
 
+struct platform_device;
+
 struct ipa;
 
 /**
@@ -643,7 +645,7 @@ extern const struct regs ipa_regs_v5_5;
 
 const struct reg *ipa_reg(struct ipa *ipa, enum ipa_reg_id reg_id);
 
-int ipa_reg_init(struct ipa *ipa);
+int ipa_reg_init(struct ipa *ipa, struct platform_device *pdev);
 void ipa_reg_exit(struct ipa *ipa);
 
 #endif /* _IPA_REG_H_ */
-- 
2.40.1


