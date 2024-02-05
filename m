Return-Path: <linux-kernel+bounces-53044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D486849FE3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E60521F23F76
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A80E482F0;
	Mon,  5 Feb 2024 16:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xg64uf4B"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A68B47796;
	Mon,  5 Feb 2024 16:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707151754; cv=none; b=HK/Y06IemDTbmCIsW5nRCrVYuFosP9zVpj0+QMM6DKDBzCsKhRNcSM6odlzw6xSrRZbY3a+dZiVIetimLvQ4EDS3kLSvBdnT4JNVItLtVAahFlkFbpcMFst+JLdFVPvbhRSNmj3soHPq+XQmB7Maxy0rnpdns1n7zYg+DptnHa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707151754; c=relaxed/simple;
	bh=mG+KMNv/A3mLJpuaFQD/GBoSpPY4XzSaY9y3kPO1C5A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YmRDehx8u236e4NCnZA/2gHjdl3t2l0fwzfjk7CCnG4n/0mmqfo+jPUt/lmeUUDrMS6Bhf4iJ170/sl4iq6iVxz8ohOJjj1httPcBIfPLdMPwMNEStVM3DqTPttJM4FdGBQ9wtkS55jrUdZEeildlUwlxoB0pV4Zz3cVoi5Jv6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xg64uf4B; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40fb3b5893eso38065025e9.0;
        Mon, 05 Feb 2024 08:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707151750; x=1707756550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MCJZjdTnS6Uq1X+PLH0vDHoWwK/834bPA12yZFCUGH4=;
        b=Xg64uf4B7iqs9vzSCnAVB7P6ckktfC9TkGc4J4Wzt2zcSkEwsVXgXlp3KPj3iNdwoN
         sc4khUzX7n6dT4j7yC6vciRTyNAoQGUUJNP1NSbZCdppiRHEmKq4XO5KHsBEVeU+/0xN
         CndH6th8MRQuTEXEwq0zuMWF4ui0o7gA7SvlAQ3RSxs7nLhrgZ/IRdh+AxacfYcfh/AS
         jXUmoeGK0M/y+MryYIF7C2m7Ej1JqbJ7PH4wnAFcrueY5ExUmc6G7Wc6rNgdcpl8IrL5
         V4qhgKJU+B6x/CU1c6ko1rseTq2mZ8YWifOA4gVCKAVaX8UqTpEPNkDV2QriXMEexk+N
         /I6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707151750; x=1707756550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MCJZjdTnS6Uq1X+PLH0vDHoWwK/834bPA12yZFCUGH4=;
        b=tYh4zpY6wm2FFrYVKYA9hFcw80uQacdjkqNAUIi0I1b+8WJnS6XShK/CUfyDialyW+
         xoSzR+WUvzseOueRb4mhuVTyz9wfpJMFQ0D0BMa30ZOSrhMI86N+Q8woCgKJ2Lmy4HlX
         zbOZolFOzUGRY2gdUBUH1LucvynoTe7DkdVCusHz12jeAPDx1vfy6kznVZh3uX/Y1PvK
         JGSXvAY8xGNq8WVMLSZLefogOaH4JjUvPxG5RNjKofrLVVArUsZkmwAeunRfzuQljLK0
         elnn1CCJsfJeZ3z+iw84SwFNUOQiNK3F/vIf/GhkC8AM+i8qGppoEqB4gT4CdMpupYgF
         OrOg==
X-Gm-Message-State: AOJu0Yx815ekoIsl2YnlOlvsC9hn2K/M70XnQCDU0WyVaH+DilM0wG+9
	1bv3RzM7K6BJtksBscs70srwrFbbKxoeryyW2tF0AjnqG8ocKk78
X-Google-Smtp-Source: AGHT+IEDEPzgMRIb7uIB+twc14/N29RzHH+LkwnK/Nt6G+0n+6ccjSFmOowkYPV2YdLZ1FjBeuzp5g==
X-Received: by 2002:a05:600c:1c02:b0:40e:46b6:bc48 with SMTP id j2-20020a05600c1c0200b0040e46b6bc48mr230699wms.41.1707151750255;
        Mon, 05 Feb 2024 08:49:10 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXYbMPE+KrWwopIcUqLHL16J9m6BrOCevgdpd2u1GVnbEiPmgZjMoN85aoaPGSanbLLOrnRdBQl8GeWH8dRPmXZWfx1irZM+1N4VtIOCOR9cwDSj0+o52pJxbHrk+zqKeAvk2qH6TVBTfE4E3FHo0mCd2QTFNX01UOf64BNM4Ciqmpzl5BjUIobL4RyMnJN4Rk7Gikwk266UOaAiMtrJv09ZmSbGmzoa5jRkic4cn6mGu7wupM/fxfvrG/V2hrtZ7kxi8qsVThlEuNyhHzFEWT8Re+m6AhtJJXlCHC7Bmpajg3EkbMgso+hrMvHd637o+G2WEbEns+LY0XcujdimL7ShEajJxOzt6yU/8IYZeGxha/Ea1u4vTZWKxrIq5TJoJdDVS4FP3Wu2L5mHR4b49C3XebXKc6IrXPZLdaVEtac/e0lAdZ59H4rAsSvS2agQfGvK+DcD0rQD2ROgLhKzeMgv4I4NZMOakd7UpQrpEGTQBLAfyge0DjDijckp7jWflw5Q7PyXJZv0yWDpJPRtorDWvm6/OCspzGQ8UEnPcMstHyDs5qm/W6hRZryEEjKoxUbd1LQpXT9FXnl2NS9UnhNbevgtrAWHlDOnkaYy93+U+DQYJTDkbFku5h9oDgyVjiXyTUfHcswaupC7bfDjWR1oEN8tQS9G7NReVpcPx+ReT0fpNgRbA==
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id k2-20020a05600c1c8200b0040fafd84095sm9140567wms.41.2024.02.05.08.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 08:49:09 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Robert Marko <robert.marko@sartura.hr>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [net-next PATCH v6 06/10] net: phy: provide whether link has changed in c37_read_status
Date: Mon,  5 Feb 2024 17:48:38 +0100
Message-ID: <20240205164851.1351-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205164851.1351-1-ansuelsmth@gmail.com>
References: <20240205164851.1351-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some PHY driver might require additional regs call after
genphy_c37_read_status() is called.

Expand genphy_c37_read_status to provide a bool wheather the link has
changed or not to permit PHY driver to skip additional regs call if
nothing has changed.

Every user of genphy_c37_read_status() is updated with the new
additional bool.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/broadcom.c    |  3 ++-
 drivers/net/phy/phy_device.c  | 11 +++++++++--
 drivers/net/phy/qcom/at803x.c |  3 ++-
 include/linux/phy.h           |  2 +-
 4 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index 312a8bb35d78..370e4ed45098 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -665,10 +665,11 @@ static int bcm54616s_config_aneg(struct phy_device *phydev)
 static int bcm54616s_read_status(struct phy_device *phydev)
 {
 	struct bcm54616s_phy_priv *priv = phydev->priv;
+	bool changed;
 	int err;
 
 	if (priv->mode_1000bx_en)
-		err = genphy_c37_read_status(phydev);
+		err = genphy_c37_read_status(phydev, &changed);
 	else
 		err = genphy_read_status(phydev);
 
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index c30907dc9fb7..b36839414dfc 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2617,12 +2617,15 @@ EXPORT_SYMBOL(genphy_read_status);
 /**
  * genphy_c37_read_status - check the link status and update current link state
  * @phydev: target phy_device struct
+ * @changed: pointer where to store if link changed
  *
  * Description: Check the link, then figure out the current state
  *   by comparing what we advertise with what the link partner
  *   advertises. This function is for Clause 37 1000Base-X mode.
+ *
+ *   If link has changed, @changed is set to true, false otherwise.
  */
-int genphy_c37_read_status(struct phy_device *phydev)
+int genphy_c37_read_status(struct phy_device *phydev, bool *changed)
 {
 	int lpa, err, old_link = phydev->link;
 
@@ -2632,9 +2635,13 @@ int genphy_c37_read_status(struct phy_device *phydev)
 		return err;
 
 	/* why bother the PHY if nothing can have changed */
-	if (phydev->autoneg == AUTONEG_ENABLE && old_link && phydev->link)
+	if (phydev->autoneg == AUTONEG_ENABLE && old_link && phydev->link) {
+		*changed = false;
 		return 0;
+	}
 
+	/* Signal link has changed */
+	*changed = true;
 	phydev->duplex = DUPLEX_UNKNOWN;
 	phydev->pause = 0;
 	phydev->asym_pause = 0;
diff --git a/drivers/net/phy/qcom/at803x.c b/drivers/net/phy/qcom/at803x.c
index 3e3ee4c1d4bc..4717c59d51d0 100644
--- a/drivers/net/phy/qcom/at803x.c
+++ b/drivers/net/phy/qcom/at803x.c
@@ -912,9 +912,10 @@ static int at8031_config_intr(struct phy_device *phydev)
 static int at8031_read_status(struct phy_device *phydev)
 {
 	struct at803x_priv *priv = phydev->priv;
+	bool changed;
 
 	if (priv->is_1000basex)
-		return genphy_c37_read_status(phydev);
+		return genphy_c37_read_status(phydev, &changed);
 
 	return at803x_read_status(phydev);
 }
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 2aed925e6c23..8f7f0101de13 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1876,7 +1876,7 @@ int genphy_write_mmd_unsupported(struct phy_device *phdev, int devnum,
 
 /* Clause 37 */
 int genphy_c37_config_aneg(struct phy_device *phydev);
-int genphy_c37_read_status(struct phy_device *phydev);
+int genphy_c37_read_status(struct phy_device *phydev, bool *changed);
 
 /* Clause 45 PHY */
 int genphy_c45_restart_aneg(struct phy_device *phydev);
-- 
2.43.0


