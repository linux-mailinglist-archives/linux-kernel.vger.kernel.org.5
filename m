Return-Path: <linux-kernel+bounces-14460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AED1821D4A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E02081F22B98
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F153014F9A;
	Tue,  2 Jan 2024 14:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKijXRKW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB38F14AB9;
	Tue,  2 Jan 2024 14:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40d5ac76667so46739365e9.1;
        Tue, 02 Jan 2024 06:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704204221; x=1704809021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUohTBda7ifVie9oF2zeFzpU4spjHotK8dJMRsvSxYc=;
        b=VKijXRKWadf1g9R9WVnwTIsLieRj1TNncnM+dQyBcCHbvYkJXnB1OpLe9PsgpVulGp
         i6sjjw8+8ycLADviEGywndF7wTI6NYz0Vy3+RObC5B4gazQWAqECtqIbPbf7DlyIJhIB
         R2p/xBDJfO9sPWi8I/bljiCK8lyedDNKP+iodmvEDpt0q6Ari5dZ6Aj1OQ0cjvfuRX/j
         2qxILrmca5DjMcj+F2u2B8sekRURsxajei1G7tAmUd0xqVPkouCmasAvABNnV7dCaGrU
         Vb0gB7I/MytERw8amJtmly5cGWDbDwvZEdLD5jplX9OL3/PaGoSXmFNEBCWVnRAqbs1P
         K+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704204221; x=1704809021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PUohTBda7ifVie9oF2zeFzpU4spjHotK8dJMRsvSxYc=;
        b=FSLKUXnR3hvy4lYWdtuNd7ZZhiRCRRuGnvIaOjpHH+gw16D6VuM/oZBFEtXOF+wu88
         ZgIm3Y9wzj0yXL8DWXWLPYRID3rYR3zAwtZpmOJ1QGSi90J7V6suNIisxRUOYy/wlHQa
         J0GAfw/3JDZr+JyfwUiuDG+RiHufveN7jPQ2CQKMLlQdxRD812k71SOrIKTFQYS60E3O
         48Vo5MtwB3gtTd4fyTGHsqASV+V+okMoMa0ItvT0s0bZYTyqapGJL49hPt/i0QVBE8qC
         /nvL4xHLojoa3wjItfYDpYdiVoSE66ppw6fbfPwmfs00BkvZThwOC9bhJ5hdAbUXLAhv
         p6uQ==
X-Gm-Message-State: AOJu0YwGNRKtEVtf6BQw96ELZleiggLFDAkIujiRIfmjUVMmmvt/E+pT
	xUqdOdmnjBDqvnmnCew/JhQ=
X-Google-Smtp-Source: AGHT+IHdT+SiGBCceiEvIazi80O4z5amVqB2gkqmNiMgKcLPui4d13e+d1QRWfF9tlBPTkh8xA336A==
X-Received: by 2002:a05:600c:13c3:b0:40d:350f:dc8f with SMTP id e3-20020a05600c13c300b0040d350fdc8fmr9558667wmg.87.1704204221242;
        Tue, 02 Jan 2024 06:03:41 -0800 (PST)
Received: from localhost.localdomain (host-87-10-250-100.retail.telecomitalia.it. [87.10.250.100])
        by smtp.googlemail.com with ESMTPSA id e17-20020a5d5311000000b0033672cfca96sm28427527wrv.89.2024.01.02.06.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 06:03:40 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH v2 4/4] net: phy: at803x: make read_status more generic
Date: Tue,  2 Jan 2024 15:03:28 +0100
Message-ID: <20240102140330.7371-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240102140330.7371-1-ansuelsmth@gmail.com>
References: <20240102140330.7371-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make read_status more generic in preparation on moving it to shared
library as other PHY Family Driver will have the exact same
implementation.

The only specific part was a check for AR8031/33 if 1000basex was used.
The check is moved to a dedicated function specific for those PHYs.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/at803x.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 3d3d34ef594c..d52b0ec81994 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -1087,13 +1087,9 @@ static int at803x_read_specific_status(struct phy_device *phydev,
 
 static int at803x_read_status(struct phy_device *phydev)
 {
-	struct at803x_priv *priv = phydev->priv;
 	struct at803x_ss_mask ss_mask = { 0 };
 	int err, old_link = phydev->link;
 
-	if (priv->is_1000basex)
-		return genphy_c37_read_status(phydev);
-
 	/* Update the link, but return if there was an error */
 	err = genphy_update_link(phydev);
 	if (err)
@@ -1685,6 +1681,17 @@ static int at8031_config_intr(struct phy_device *phydev)
 	return at803x_config_intr(phydev);
 }
 
+/* AR8031 and AR8033 share the same read status logic */
+static int at8031_read_status(struct phy_device *phydev)
+{
+	struct at803x_priv *priv = phydev->priv;
+
+	if (priv->is_1000basex)
+		return genphy_c37_read_status(phydev);
+
+	return at803x_read_status(phydev);
+}
+
 /* AR8031 and AR8035 share the same cable test get status reg */
 static int at8031_cable_test_get_status(struct phy_device *phydev,
 					bool *finished)
@@ -2568,7 +2575,7 @@ static struct phy_driver at803x_driver[] = {
 	.read_page		= at803x_read_page,
 	.write_page		= at803x_write_page,
 	.get_features		= at803x_get_features,
-	.read_status		= at803x_read_status,
+	.read_status		= at8031_read_status,
 	.config_intr		= at8031_config_intr,
 	.handle_interrupt	= at803x_handle_interrupt,
 	.get_tunable		= at803x_get_tunable,
-- 
2.43.0


