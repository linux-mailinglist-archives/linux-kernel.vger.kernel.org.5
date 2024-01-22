Return-Path: <linux-kernel+bounces-34194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A94C0837566
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC1F41C26147
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EAB4D5AB;
	Mon, 22 Jan 2024 21:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwwPSwqb"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81E74D13C;
	Mon, 22 Jan 2024 21:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705959012; cv=none; b=ewO2e1c9NGL4Hu2W9UxjmfaYQBTv3TOHsaT3lHS2fLW0+yWxgbm2MvzLhcGMKrIZ6oEThY21hfiLeGgrMSG85XgVTQrz0/pEaBpRIXKUISomhHLpEcCmu+mW/+RDfWi3XBBcJjO0qjPGaAcnsZ+6WoYodctYHqjNhBSwQsZU0GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705959012; c=relaxed/simple;
	bh=3c1kyapsmhYjTrjxTlzTOIoGyA4EaMTb1a6wJCs6mDM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YBjUEIcIe6r4Q3mqz0NfzNYIVVp7TqtPygzPGP+JsNUjjaU+vNJHxwOLcYa5tg7FIfg4WIN6oe0QkUtpWYKs0bkLS/9i/KGEnnH0W18eB60Nj5HYCbWgL6UdLmUYcOsA7NZw3mZpXdfcV1fCkS3tm0ks1J8CeUz3ym9a6LAvx8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwwPSwqb; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50ea9e189ebso3786062e87.3;
        Mon, 22 Jan 2024 13:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705959009; x=1706563809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Shwh36aSxCxZjdxLJZjEG9Pe0NenbHGEeLdgmjb+AU=;
        b=bwwPSwqbniEybdhFgVYzwtuV6+B7N0UQ0JaSu8MZw1AtBuTAFbdiqJ5vINQsb14GHF
         j8+dbw2mjHnAjO9EAO2LReZb++vzeEslXek4Pmckz13XyWuA4P4TE9iq/4CRrpaxmBlr
         gCxzhxbjf4RG+3mr3d3uKDlS3tdsSn3+8MXF4FzOyGceSkIP9aKLyz0P0cW02kd+Lz24
         6S64YyayEARF8ir4YbW7GY9ZNfLvv6cmJZ+nJ3CzceKVBxMNefUl65u5OFykZRtSk7o5
         kCAVqpspd/gnhgggId4DG3iv/K/QCRd7m3iUOnfTcGJXJzvPjX6tg+EwLRCTa1xgHdUm
         B67w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705959009; x=1706563809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Shwh36aSxCxZjdxLJZjEG9Pe0NenbHGEeLdgmjb+AU=;
        b=rF+D2FGkf0lWVe/B4n+ANUfb1yx10DH0zPJBVYpeY5+zW9TY8JEA4faLav9iR9YhKs
         a/zB8wg2OrY+wtUPgTMouq2M7P24nJNduGwX6uOJmKt8A68IhFC8ooc45SByZxjsYLAl
         tarvKqL/uNzY3SANz0+FZkhZXvdjmu3TrH97a/VeBIyQedStQbueIxkSjRTkI/cxfGKI
         q3RSe0+kdHD+1U9k+xOlUBo3WCDZxUQRVwKQrDG3KdjxjAolivphdPGE30U36/Wfog/X
         6TLmMtF3gHvf85GlG6FKvbLbK7fYPbBJGgtk3TDghKmMN53xF04Ys6RCuZwJ0soSqsRY
         +Rng==
X-Gm-Message-State: AOJu0YwK+pbK5YloH1wal/RvPkQC32i78vvaYD+w9u4qHrLeH8k/97dR
	mc34GVhyoVMjpMbwlKaFyfOCmqoRgPHuH8U1Wjelf4HJsO0lb2Hm
X-Google-Smtp-Source: AGHT+IGUKCVZ8Hr0I37alZ/CIjUa101djK4Dg+UrpfTYJ+Et84b39JrLGQg6n7eGjnk2+0e9+OyhUw==
X-Received: by 2002:ac2:58e1:0:b0:50f:72f:cf8a with SMTP id v1-20020ac258e1000000b0050f072fcf8amr1473425lfo.137.1705959008897;
        Mon, 22 Jan 2024 13:30:08 -0800 (PST)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id j25-20020a1709066dd900b00a26af4d96c6sm13823336ejt.4.2024.01.22.13.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 13:30:08 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 net-next 13/13] net: phy: marvell-88q2xxx: remove redundant code
Date: Mon, 22 Jan 2024 22:28:46 +0100
Message-Id: <20240122212848.3645785-14-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240122212848.3645785-1-dima.fedrau@gmail.com>
References: <20240122212848.3645785-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove redundant code in mv88q222x_revb0_config_init,
phydev->pma_extable is already set in mv88q2xxx_config_init. Just call
mv88q2xxx_config_init in mv88q222x_revb0_config_init.

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/net/phy/marvell-88q2xxx.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index 081ed110c87e..6df580442b6b 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -373,6 +373,14 @@ static int mv88q2xxx_config_init(struct phy_device *phydev)
 	 */
 	phydev->pma_extable = MDIO_PMA_EXTABLE_BT1;
 
+	/* Configure interrupt with default settings, output is driven low for
+	 * active interrupt and high for inactive.
+	 */
+	if (phy_interrupt_is_valid(phydev))
+		return phy_set_bits_mmd(phydev, MDIO_MMD_PCS,
+					MDIO_MMD_PCS_MV_GPIO_INT_CTRL,
+					MDIO_MMD_PCS_MV_GPIO_INT_CTRL_TRI_DIS);
+
 	return 0;
 }
 
@@ -703,21 +711,7 @@ static int mv88q222x_revb0_config_init(struct phy_device *phydev)
 			return ret;
 	}
 
-	/* The 88Q2XXX PHYs do have the extended ability register available, but
-	 * register MDIO_PMA_EXTABLE where they should signalize it does not
-	 * work according to specification. Therefore, we force it here.
-	 */
-	phydev->pma_extable = MDIO_PMA_EXTABLE_BT1;
-
-	/* Configure interrupt with default settings, output is driven low for
-	 * active interrupt and high for inactive.
-	 */
-	if (phy_interrupt_is_valid(phydev))
-		return phy_set_bits_mmd(phydev, MDIO_MMD_PCS,
-					MDIO_MMD_PCS_MV_GPIO_INT_CTRL,
-					MDIO_MMD_PCS_MV_GPIO_INT_CTRL_TRI_DIS);
-
-	return 0;
+	return mv88q2xxx_config_init(phydev);
 }
 
 static int mv88q222x_cable_test_start(struct phy_device *phydev)
-- 
2.39.2


