Return-Path: <linux-kernel+bounces-159320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2888B2D16
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A26D51C21FB5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB227156674;
	Thu, 25 Apr 2024 22:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExmlrgZa"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80B414D71D;
	Thu, 25 Apr 2024 22:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714084064; cv=none; b=Oly3uPeUjCruzSUh2+RGepF12z7fiuS+CZGaJVAsp3bKKK9v4unEzGhtlPDkdWV/C/X8NJSDEQxvJPLTVGqLSFQAGJjsh9aDV15D3FZjx8nYLMEPbu6HKtulKDaJgn4ZvYMxUjEhU9QsI5eXA8c5b40dN6t5Q7f7zGLpVl7Cz/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714084064; c=relaxed/simple;
	bh=1SF70NTHCTRYZByoZHjPlVMIlx5+KlolbViI5fbMAFc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hrF9FObiGeDMEdD65VDVu4D3Tv0qUGiGBEkqnbazEYnTdo8+bx42QGoRJDEGPEl/MLxgcaZ+SH0/YJ86HPl7hIjRQhZxEvlSGtprqxjSXukac4h+61IBX40b84TxEuqjSZ9ERq2fLlIawWHzYpCPVrKL+nUXjoDwK8NxqnPHuGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ExmlrgZa; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5ad2a15374eso964590eaf.3;
        Thu, 25 Apr 2024 15:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714084062; x=1714688862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o13Arm3Rvf2gFBkSt1a4X4Ztws3UYrTbZey0ecJRfQk=;
        b=ExmlrgZaqLUex8UJ5qLXEOMvb+ESMuOVE+D5hClr9ut894NeYsOHDyahiYXzRZYHF1
         mdecKfwqmvduKzxf2lCM+bP20SnES9PhJKfB1dHP/bV//gHD3bzHupkVqidDJ+w/torz
         WMiCrIDfWIS5hVToPKT3sHePwNpt79QnyCcn2ixyKtVvUIgmzUVO7u9kqVegqFaaIPId
         +YprjhQE9LNC0moW9G11nYmAb1pixIMzFkTaSmNvrRP4iOhgXcr4LlBiwLuC2Bjg2Ilx
         mEyHYlXuG1va2XlTnrdLsqtTXBSAcbGA3YTUmM/6hzGQue7AD0Ah10xoeVKY5nkc5trz
         1IVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714084062; x=1714688862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o13Arm3Rvf2gFBkSt1a4X4Ztws3UYrTbZey0ecJRfQk=;
        b=Ckw11fzZihZdj596oSvilDbhuRwxIr7yWVqbt+ZN7u7gFwBd4Ps+JdlCx8FeUYilff
         wWlEuLi2zH7zrqQohvM68qwaJswsUCdXSlIY10Zxf6K1N62Hr6ZaGW+uvNUQ9spZFmTa
         VrC3ihQmSWxbhU3FB7oRIGfmrFncNDxuWadPEUoR3KZ3ihRMYJvEHi2Xab+GGP+/vJRb
         Aurj2RJEjq3g/xiU5ZpQOJvP8JWQN3y0i27qEVljBN7f89QFiMFELdivmj4QexBocG8z
         B5TBnmmDLva46Lv55ZkOxU0WUvGVhuZUpsiRum38VZH1/KDNUIg3RmkpB8p+3dNJMwO8
         Kp2g==
X-Forwarded-Encrypted: i=1; AJvYcCUmmxGStjdyO0Fa8eL7TmnNukop7EuwE22IagqL0yaPV+97xWYg5n0ZaMIyrz2DU0MerrzoT2xY4ODk08u7sQ/IBe0JZxPNnIDQIh7oi4Z80JzEVVkVc3iP59oewX6/5OMjMGIHo3tMrKaYLICblWTRh2D/lPEpxoXyN5V1
X-Gm-Message-State: AOJu0YwYfBXP4G/XH7n6pziJ+KbYreY+xp2nG8NGaVI3TUK4+p+ZUxAW
	Z9IcCpY6Ok9+3hlGEBVjUEXZ4icb1PLfIYQq7hoZmzD3y9YiJmnD
X-Google-Smtp-Source: AGHT+IGlq59lF+/gx5a6kAGQzJHbB8V/nHLNXKwd0uO8DwdWe7w21FRrv3KKpn1mffLOhlplDRFYqg==
X-Received: by 2002:a05:6358:2744:b0:18d:7ba5:ccaf with SMTP id p4-20020a056358274400b0018d7ba5ccafmr627086rwd.26.1714084061904;
        Thu, 25 Apr 2024 15:27:41 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id t4-20020a05622a180400b004371724f711sm7341928qtc.80.2024.04.25.15.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 15:27:41 -0700 (PDT)
From: Doug Berger <opendmb@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Doug Berger <opendmb@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/3] net: bcmgenet: synchronize EXT_RGMII_OOB_CTRL access
Date: Thu, 25 Apr 2024 15:27:19 -0700
Message-Id: <20240425222721.2148899-2-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425222721.2148899-1-opendmb@gmail.com>
References: <20240425222721.2148899-1-opendmb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The EXT_RGMII_OOB_CTRL register can be written from different
contexts. It is predominantly written from the adjust_link
handler which is synchronized by the phydev->lock, but can
also be written from a different context when configuring the
mii in bcmgenet_mii_config().

The chances of contention are quite low, but it is conceivable
that adjust_link could occur during resume when WoL is enabled
so use the phydev->lock synchronizer in bcmgenet_mii_config()
to be sure.

Fixes: afe3f907d20f ("net: bcmgenet: power on MII block for all MII modes")
Cc: stable@vger.kernel.org
Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/net/ethernet/broadcom/genet/bcmmii.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index 9ada89355747..86a4aa72b3d4 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -2,7 +2,7 @@
 /*
  * Broadcom GENET MDIO routines
  *
- * Copyright (c) 2014-2017 Broadcom
+ * Copyright (c) 2014-2024 Broadcom
  */
 
 #include <linux/acpi.h>
@@ -275,6 +275,7 @@ int bcmgenet_mii_config(struct net_device *dev, bool init)
 	 * block for the interface to work, unconditionally clear the
 	 * Out-of-band disable since we do not need it.
 	 */
+	mutex_lock(&phydev->lock);
 	reg = bcmgenet_ext_readl(priv, EXT_RGMII_OOB_CTRL);
 	reg &= ~OOB_DISABLE;
 	if (priv->ext_phy) {
@@ -286,6 +287,7 @@ int bcmgenet_mii_config(struct net_device *dev, bool init)
 			reg |= RGMII_MODE_EN;
 	}
 	bcmgenet_ext_writel(priv, reg, EXT_RGMII_OOB_CTRL);
+	mutex_unlock(&phydev->lock);
 
 	if (init)
 		dev_info(kdev, "configuring instance for %s\n", phy_name);
-- 
2.34.1


