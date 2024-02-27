Return-Path: <linux-kernel+bounces-82700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5446686885A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 05:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C153A1F2518E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB22E57885;
	Tue, 27 Feb 2024 04:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="F3GzW5st"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B25E55E5E
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 04:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709008944; cv=none; b=lCnoi611FkHA03l7m9WCp3HjKMrsL39M2rNm5AYDpkB8RkFG/bejNieMSYDfeFEnkqv0LnTKxVY0OwbyulMz2tCayHpyKzlKpmsGmRfEbZ8fVWnl6dfegsUaegZR07tjApguXKE/7/uuEBdYVf5m7AIjlpTp1BZjHBqOhixjriw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709008944; c=relaxed/simple;
	bh=GCNq+oVNnt+RZlMwVce8p37iY6XXUp2uX11yzmD+FkY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JGwGg1GIDuzszJL5AQtw/NaVIR8FbBnjewhjuSpMrl0QnPdQ2mXLQynd6vF7ExOKdk2PcahlzkClcQk2Xpg4riOa+fXalFHqv5SCNnVl3dUXcr+zIRing/SNx+w20gMwsfWKYqvYLDI5VUjyZYVgXTVVI7PoElru95uEHkekJq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=F3GzW5st; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-21ea1aae402so1995153fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 20:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1709008941; x=1709613741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YHS2iHHeZrTRnRLklghWgHy9r146lY/Nmb3FNJzmtMk=;
        b=F3GzW5stMoGbL6xcnrwfm4xHa2UeQqdAGDBZwMFciaRfJMm31opA7Ml5ObgeKEUjtn
         gnJpkWWFAgHquEvCOGpFvmuU5ZCu2wX1k1RCCLVzS9UeYPXG68zkHpWf99Z3Q0GF7ITW
         Fx9X+6y4r7/SpdZynnXaymPdoHolRhECu7B7F7j0Jr8SP00+Xph2yzN2+5wxRB+MzG8b
         fu0PJHxfqZlYvlc22DGoXSAdUd3MmAwo43cxUnKykizWNJx1YTT9kz4XD2L+aieNpSuq
         7EQPE8R9gXpqm+XOdPkEOzz5FkwwscQazveVHluYC7SbJoEBniFgeN6Wv8ZytETZevMw
         5POg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709008941; x=1709613741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YHS2iHHeZrTRnRLklghWgHy9r146lY/Nmb3FNJzmtMk=;
        b=s/SKaJImfQrx3S5LQgaXroXdi6IoAiM/EUYBSb3tg7NeL0Sxp29SjkjEP/nMZOTnip
         yQiIV4gFrlYF+hB3zrcHptBA1zjEAILBAc/DolBGSFcFJWtP/2/Qa6zcqTVN4D2eucla
         bdidramjnUVdNhCRmvwMxwO//icT4Dv4wzE9NdxndFYjxJyQxA8GBSSkqNVph7YFuyBx
         ZK0f0wsVc3oLFNCNCj/cY2SUD1+EHt2NKmEK7Yb2yYcZopLY66ZPGIZLgxf9T1dLGbDH
         uKs4T6ct6EAkaEDSQhCj0ZTYMsiCjhSc6bRHVvVFU6XZkUbFxUWxfeFc5ulNYO65x6mD
         E0lg==
X-Forwarded-Encrypted: i=1; AJvYcCWWnrwMctCsNcwXdvMdFywDcnyxhe/U+kSFune6DPQ9+9NlT59pElYmodUea372J5/tU0Idqx6KPbDCBSY/RV3Bk2BhvA4nrH40ouyj
X-Gm-Message-State: AOJu0YwGcdoLyEb1ro6RdDSXqekfEMjNCcZp9UOwkRbvXXT7J0oqz3c/
	OMaO3p63ZUzHc/FSWaaDawNYO2t4ktFfrWxJDt2AFv5BhQBRDom2lfRtERI2wNc=
X-Google-Smtp-Source: AGHT+IG/mgkan0BMJNDF/FisSsjPJe78YViGAJ404w6kJK8YEcbudpCIZokvAlwynNiKTI473SQX2w==
X-Received: by 2002:a05:6870:63a5:b0:21e:4e29:a001 with SMTP id t37-20020a05687063a500b0021e4e29a001mr10426983oap.2.1709008941699;
        Mon, 26 Feb 2024 20:42:21 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id e30-20020aa798de000000b006e4ecc3e394sm4899782pfm.79.2024.02.26.20.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 20:42:21 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 18/20] Staging: rtl8192e: Rename reference AllowAllDestAddrHandler
Date: Mon, 26 Feb 2024 20:41:55 -0800
Message-Id: <20240227044157.407379-19-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240227044157.407379-1-tdavies@darkphysics.net>
References: <20240227044157.407379-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable AllowAllDestAddrHandler to allow_all_dest_addr_handler
to fix checkpatch warning Avoid CamelCase,

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: Fix checkpatch alignment warning
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h            | 5 +++--
 drivers/staging/rtl8192e/rtllib_softmac.c    | 4 ++--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index f99cc5b639fe..fc5014f719d7 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -661,7 +661,7 @@ static void _rtl92e_init_priv_handler(struct net_device *dev)
 						rtl92e_is_halfn_supported_by_ap;
 
 	priv->rtllib->set_hw_reg_handler = rtl92e_set_reg;
-	priv->rtllib->AllowAllDestAddrHandler = rtl92e_set_monitor_mode;
+	priv->rtllib->allow_all_dest_addr_handler = rtl92e_set_monitor_mode;
 	priv->rtllib->init_gain_handler = rtl92e_init_gain;
 	priv->rtllib->rtllib_ips_leave_wq = rtl92e_rtllib_ips_leave_wq;
 	priv->rtllib->rtllib_ips_leave = rtl92e_rtllib_ips_leave;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index a5925fe75a6a..d2f192fa9304 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1493,8 +1493,9 @@ struct rtllib_device {
 					   u8 Operation);
 	void (*set_hw_reg_handler)(struct net_device *dev, u8 variable, u8 *val);
 
-	void (*AllowAllDestAddrHandler)(struct net_device *dev,
-					bool bAllowAllDA, bool WriteIntoReg);
+	void (*allow_all_dest_addr_handler)(struct net_device *dev,
+					    bool bAllowAllDA,
+					    bool WriteIntoReg);
 
 	void (*rtllib_ips_leave_wq)(struct net_device *dev);
 	void (*rtllib_ips_leave)(struct net_device *dev);
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index d19895220878..c335b24fa08b 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -355,7 +355,7 @@ void rtllib_enable_net_monitor_mode(struct net_device *dev,
 
 	netdev_info(dev, "========>Enter Monitor Mode\n");
 
-	ieee->AllowAllDestAddrHandler(dev, true, !init_state);
+	ieee->allow_all_dest_addr_handler(dev, true, !init_state);
 }
 
 /* Disables network monitor mode. Only packets destinated to
@@ -367,7 +367,7 @@ void rtllib_disable_net_monitor_mode(struct net_device *dev, bool init_state)
 
 	netdev_info(dev, "========>Exit Monitor Mode\n");
 
-	ieee->AllowAllDestAddrHandler(dev, false, !init_state);
+	ieee->allow_all_dest_addr_handler(dev, false, !init_state);
 }
 
 static void rtllib_send_probe(struct rtllib_device *ieee)
-- 
2.39.2


