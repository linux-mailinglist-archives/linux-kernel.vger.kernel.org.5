Return-Path: <linux-kernel+bounces-67180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 892288567D3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F9A1B21EC7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6E413342B;
	Thu, 15 Feb 2024 15:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYt1Y9IX"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB335133412;
	Thu, 15 Feb 2024 15:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708011022; cv=none; b=LhEYYBoYF9cX9P+iKnEnl3ECBvPlOirVp2a4EW5eH6G5xvEZ0QPYZJSsBVkcNtr9HxA8r+3vKbg+Q3+qDg1Dyr896STMK2FtJTJvueQNvRGrBBwHxN1bu4AKUZnwblQyHR72CEC0QEdLmY1TXe4F2Z2EcWUqR3BVyVFRieM3YPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708011022; c=relaxed/simple;
	bh=zJC9CXq4dcvLk4nahJYJkn9RNZzyk2capY7kPps0jfg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Jf8GO54g48daf6UFpnWfT6VZv/+knLKC1lrNRmlnDdfsjtNp3lCy2tBFGFh9RpaU8WcEIqdcQwjNbyRT2rHUDJIX2/PGbjC1FPBqEOqS1D+Eoh9/fKtKl1hYx31/wSNZ8RKJj6j9QqQxwwFRqikFG1ZSNrpilhetvw3lc5pojRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYt1Y9IX; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33934567777so583450f8f.1;
        Thu, 15 Feb 2024 07:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708011019; x=1708615819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=EzxJs9cxp9wBXtsvla3RFm6+Tnd21QJFktLvuH+bRvc=;
        b=FYt1Y9IXb613l1zUAVUyMDMt6MAk/hDI/KcYS6Zb/yH1mcG8oYAFN33tzqTcoFGaVa
         qe4Dqm9xxAAzobc5OsJw+O6IVIzXrFCb4jGBgf3hRpqJU7oJhqaNjQJrSvcvUhkrzmfy
         lfW1Po8VfA4OLXk7c/QXtf3NeI+y7DgylVP3ayOAAecqYsX4pC64Kppal1KFMSIaUwzQ
         Nfa+MkTsuf4iwzZwic5Gt4PfA/sxT4+t1b6wvi+SO2EzPlsXVuwGWlwtDwtNFK0eMaHO
         AdhyOgHfBCUeoTReV/Po5HrV4RrGqVT6sNoANBivIHFG6Y7Bw+GEwCETilP2URDX+Be+
         x7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708011019; x=1708615819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EzxJs9cxp9wBXtsvla3RFm6+Tnd21QJFktLvuH+bRvc=;
        b=Js9xy8DeMDsj0bKwoIFbFW/omDT0bGqZzWghA99vXe26UtJP2cteZxtrOnwYYRnL2n
         hAXIEXOamanZqLLpvYBHp1Yc9KEjdppyeke6kONv3FG2XnNYgU2DCNtoyjDdITecN1uf
         0ZL5HE2koHPgvX2mi3k8pEgm1MIdd3Ya207V7URFKL7D2jxhkHehou8N91r1YAZaQqEV
         g/VTPv4jRlcfHCBS8AVPPCTIcngIxZcbapRK2D07UfpaxLR8uj/6fFEF7D3gqOpEJTsa
         JO9O9r8TFhtuCiiGTZGPocG8HoHT12UNyKslG+Pn8kJjL9KJn4zaGDMzSXi+LsSyXJsf
         i84A==
X-Forwarded-Encrypted: i=1; AJvYcCWjQPbeDxcdUIl8SoKD9wAgRl0QnaqbMmuYYUWooP5RfsTEPg+ZARkjtQ9bOzt4w09/sgDSf45tK9GZ0Amu4YPipNkmyfvI7357Gh25HHDmal72m+uOwZBRGETy+rP2dqAQfqUk
X-Gm-Message-State: AOJu0YyAINrsJSbHUK0Bu82dbkGiE1TnHu0VWOUv26B0fFH7yi3wPKLA
	x/kUOWqhUsMA9wVoC0PZ+JRiIf6/e5IHA7uZx2/R7IdYc/V/+aP5
X-Google-Smtp-Source: AGHT+IHF7rKg/9MCZPVlX/Ke7iQnZQZu+vy6LFb1PkdX9Co6PiiXKJmEo79kh4rjUsb+iAPXp7V0Yg==
X-Received: by 2002:a5d:43d0:0:b0:33c:d9fb:2277 with SMTP id v16-20020a5d43d0000000b0033cd9fb2277mr1503222wrr.40.1708011018678;
        Thu, 15 Feb 2024 07:30:18 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id x4-20020a5d54c4000000b00337d6f0013esm2046141wrv.107.2024.02.15.07.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 07:30:18 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Robert Marko <robimarko@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next PATCH v2] net: phy: aquantia: add AQR113 PHY ID
Date: Thu, 15 Feb 2024 16:30:05 +0100
Message-ID: <20240215153010.2129-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Aquantia AQR113 PHY ID. Aquantia AQR113 is just a chip size variant of
the already supported AQR133C where the only difference is the PHY ID
and the hw chip size.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
Changes v2:
- Rebase on top of net-next
- Add Reviewed-by tag

 drivers/net/phy/aquantia/aquantia_main.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index 109387acabeb..a6a7980585f5 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -26,6 +26,7 @@
 #define PHY_ID_AQR111B0	0x03a1b612
 #define PHY_ID_AQR112	0x03a1b662
 #define PHY_ID_AQR412	0x03a1b712
+#define PHY_ID_AQR113	0x31c31c40
 #define PHY_ID_AQR113C	0x31c31c12
 
 #define MDIO_PHYXS_VEND_IF_STATUS		0xe812
@@ -922,6 +923,25 @@ static struct phy_driver aqr_driver[] = {
 	.get_stats	= aqr107_get_stats,
 	.link_change_notify = aqr107_link_change_notify,
 },
+{
+	PHY_ID_MATCH_MODEL(PHY_ID_AQR113),
+	.name		= "Aquantia AQR113",
+	.probe          = aqr107_probe,
+	.get_rate_matching = aqr107_get_rate_matching,
+	.config_init    = aqr113c_config_init,
+	.config_aneg    = aqr_config_aneg,
+	.config_intr    = aqr_config_intr,
+	.handle_interrupt       = aqr_handle_interrupt,
+	.read_status    = aqr107_read_status,
+	.get_tunable    = aqr107_get_tunable,
+	.set_tunable    = aqr107_set_tunable,
+	.suspend        = aqr107_suspend,
+	.resume         = aqr107_resume,
+	.get_sset_count = aqr107_get_sset_count,
+	.get_strings    = aqr107_get_strings,
+	.get_stats      = aqr107_get_stats,
+	.link_change_notify = aqr107_link_change_notify,
+},
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR113C),
 	.name           = "Aquantia AQR113C",
@@ -957,6 +977,7 @@ static struct mdio_device_id __maybe_unused aqr_tbl[] = {
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR111B0) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR112) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR412) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR113) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_AQR113C) },
 	{ }
 };
-- 
2.43.0


