Return-Path: <linux-kernel+bounces-92816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 766D7872671
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C9DCB23EF5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B5C18645;
	Tue,  5 Mar 2024 18:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="f+aoQw1v"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD4D17C73
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 18:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709662740; cv=none; b=JVG6iXMBEJEvFF9nd259SgZxrTO8p0BUcZTkwzD/Eak4Py9VFWQ5QAxHQoePwc7HwdGw0Gs9nnUVTjYtlFXRJKgRzFiyNeG2NTs4Lm80sFDk7FRBC7J2a4gHSuv7UL8QhBFzHM7Yx3octA61DIQE+Dn0Zwzv2sxTLoHv7/8I0Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709662740; c=relaxed/simple;
	bh=MtUhEwdZhD08cYNDeoVJ869oD8ivWXm6QaLStsSVeu0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LS6zw5YR11y9OKuWx1alA+v2m2qcqsHkqlJcFXmunoCHCrlr2NtXii7V5CtPpthS7wz/eV8a9w9ICT/eBuJL5KsD0EO8kLNLie+3jKWELM7rqH62ih4rPuamG8CgxndW8w7jPuYASmbZw3YB5yffc8il4ttAzwlUTKXXtrw6HFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=f+aoQw1v; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dd10a37d68so22615155ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 10:18:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709662738; x=1710267538;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HI8MIcEEjpVSHq6tmixm5MdGRtSK9TQ269Plf4i1Nbc=;
        b=c8s1BbUPAHKxScvBEuSky1lMy+lMjQS5fEGG0MTXGUOxD7V6jyEvF6NUvtFYtQcE3G
         xX7+EEfZGgybPPcNDdR3qOajZZfMdTzSUMh1XDqaB9AXcaYR0qXaOgclAzcEjQPbixs/
         wjLdIS78z5sPNor4EJR7JCV/pak5APS040JbM41QGyu3Vqzz7WsLJFTwguQoxRcfAb04
         eR0Yuw7CISgfqjdnwoYLRWE3ypecPTSAcdjGeO5hCNFTB8c/TWWGpC/mVe6fOC/Mmmb1
         lncRLzu99E8zuTHhJ0f+/sh7edjg74RB5PkVEQiLquMLyB5HS993t5PDpB+2HeTNmglJ
         +qZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAy8bGy0D0bB29DbFAb9d+NZpoxpdLp+mOL3ec1a9S/OTJguJJg6Ijz9eEFDKwOcXSAo8ZlNUl22NOH9hIaM8aEKt7bB4VbsgmGtEx
X-Gm-Message-State: AOJu0YxXbZ13XM2962oiS2Zl2TgbLvABOllx6KmTR8VZm3vAE3FnpGKE
	OUkOCLNHbaZNA3+RVU/Xnaq/gdH3o9EDc4TlWbf658DZkcjOxHiL
X-Google-Smtp-Source: AGHT+IHWTpTarFj5TMDKd9wHITF96/ovlRR+Xq9KPffH+QHtDH+oRMS1p0CIfMCSAsGTjloFdNYHfQ==
X-Received: by 2002:a17:902:f688:b0:1db:e41f:bc0 with SMTP id l8-20020a170902f68800b001dbe41f0bc0mr3332848plg.30.1709662738049;
        Tue, 05 Mar 2024 10:18:58 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id d11-20020a170903208b00b001dcc109a621sm10858683plc.184.2024.03.05.10.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 10:18:57 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709662736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HI8MIcEEjpVSHq6tmixm5MdGRtSK9TQ269Plf4i1Nbc=;
	b=f+aoQw1vwJrWWobBExg1clhjh0AEXqLxrpDT750sMETiFtQ6hMTy5rJ8FeShDis0V8x4LD
	3BjupLESMB40QFADO2NrtMjMxYf52Wqe62ejrL6l8fXlWRn6m/SKdDtRhGITsHFOdEi7ix
	P/RZbqsefGMwcvtedFZuiwGxWT7f59I/OnEua73ISf3HTTeVZTzoZ0n2Gyn1KT+JInWIrC
	+92cnD2HjIiE7ZzaZfdpmDlI9uPudcRP+bdWDkMKIxs0YGKix8f/va0+jvbEoRTGZxR8rV
	Nf7ut25EGKsr9kmEdysLLb9BsrNbStzT1Lg4SiiBnNjRq+jDath1EJseDmJpPA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 05 Mar 2024 15:18:51 -0300
Subject: [PATCH] net: phy: core: make phy_class constant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-class_cleanup-phy-v1-1-106013a644dc@marliere.net>
X-B4-Tracking: v=1; b=H4sIAApi52UC/x3MSwqAMAwA0atI1hZq/SBeRURijRqQWhoUpXh3i
 8u3mIkgFJgEuixCoIuFD5dQ5BnYDd1KiudkMNpUutS1sjuKjHYndKdXfntU07RYVO1k0M6QOh9
 o4ft/9sP7foC0dVhjAAAA
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2768; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=MtUhEwdZhD08cYNDeoVJ869oD8ivWXm6QaLStsSVeu0=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl52IMzuzrSBdu88Sk6J8FL+ZjpyXhYGoTCLRjK
 cbF37OLdCKJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZediDAAKCRDJC4p8Y4ZY
 pvypEACRI3I07T9suJ6lkiDx7vvEBsJOmhwk2c+MTOmUANvxLGIjKEYEirKAH7aB1CxO2YRG54Z
 /NRAugoybDeVCa/SRGp+jwii81xgVNlVFlcpuKzvYBouO72GfZz3irSK5Yjse3Trwdxv6XNnMHE
 Lfd3c1SjZhUdeNBlNQzp8Wi39aemZboJtJ6SR1FwUxGRUG3ZGlj5nmjqqjx9abdE8NFut5BQt+8
 vUQ3ew2mgsemHhYS9UeQH+Ijmhro5Fm2eBpgJvuqXLWWxUEH92A3G5+U8ToDfB9T0s0LQtvgLgb
 zt0s3MwUenJ2YzAqZG2RRKRGhYzup4QP/q6WqvywmW1ysD9C6NOgdhiSrsWR1+V2Q/oSMeKpQI4
 UX7EV8k6rR71tlEiERG3nkrUkx7wucusA6eWZIbySjpIxRr73Wwx7A/OfhMw2y3LKBB6TzRA+d0
 8cNFF5LeJ57yNO/+Cc8P+pSUd+dnAhGnJ2C57adV7HYDbpykiKZs/F2CPyEnR6oghzoKMYo85CF
 LFHy+bBVf7Ju501+0x04K2exgyn5sn3suPl4LiD2mKOvW/f6e+XtVUsgpJ5wJSnKG1u9HeoShm4
 nqM6MRanucU7oxeuFAHA9KARpDvFF+8oQxgUezIT6L6s5FR+zybbb2UpvC9WhHxtOlBTisbBS4/
 v3xVveiSDFN0VXQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the phy_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/phy/phy-core.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 7f9b4de772ee..5776d44fd32f 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -20,7 +20,12 @@
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 
-static struct class *phy_class;
+static void phy_release(struct device *dev);
+static const struct class phy_class = {
+	.name = "phy",
+	.dev_release = phy_release,
+};
+
 static struct dentry *phy_debugfs_root;
 static DEFINE_MUTEX(phy_provider_mutex);
 static LIST_HEAD(phy_provider_list);
@@ -706,7 +711,7 @@ struct phy *of_phy_simple_xlate(struct device *dev,
 	struct phy *phy;
 	struct class_dev_iter iter;
 
-	class_dev_iter_init(&iter, phy_class, NULL, NULL);
+	class_dev_iter_init(&iter, &phy_class, NULL, NULL);
 	while ((dev = class_dev_iter_next(&iter))) {
 		phy = to_phy(dev);
 		if (args->np != phy->dev.of_node)
@@ -969,7 +974,7 @@ struct phy *phy_create(struct device *dev, struct device_node *node,
 	device_initialize(&phy->dev);
 	mutex_init(&phy->mutex);
 
-	phy->dev.class = phy_class;
+	phy->dev.class = &phy_class;
 	phy->dev.parent = dev;
 	phy->dev.of_node = node ?: dev->of_node;
 	phy->id = id;
@@ -1238,14 +1243,13 @@ static void phy_release(struct device *dev)
 
 static int __init phy_core_init(void)
 {
-	phy_class = class_create("phy");
-	if (IS_ERR(phy_class)) {
-		pr_err("failed to create phy class --> %ld\n",
-			PTR_ERR(phy_class));
-		return PTR_ERR(phy_class);
-	}
+	int err;
 
-	phy_class->dev_release = phy_release;
+	err = class_register(&phy_class);
+	if (err) {
+		pr_err("failed to register phy class");
+		return err;
+	}
 
 	phy_debugfs_root = debugfs_create_dir("phy", NULL);
 
@@ -1256,6 +1260,6 @@ device_initcall(phy_core_init);
 static void __exit phy_core_exit(void)
 {
 	debugfs_remove_recursive(phy_debugfs_root);
-	class_destroy(phy_class);
+	class_unregister(&phy_class);
 }
 module_exit(phy_core_exit);

---
base-commit: 00ca8a15dafa990d391abc37f2b8256ddf909b35
change-id: 20240305-class_cleanup-phy-668a148b2acd

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


