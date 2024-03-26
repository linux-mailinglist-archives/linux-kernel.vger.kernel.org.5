Return-Path: <linux-kernel+bounces-119147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DC088C4D1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BF51B24FA1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07A812C53C;
	Tue, 26 Mar 2024 14:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdbRuFIM"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD83A12BF02;
	Tue, 26 Mar 2024 14:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711462384; cv=none; b=F7vjHb9cqR6MWYHEH4uTWbnGICNtXDFI6eW3NcPN1JEfV6adWV/YpU7TAOlxQlV6H1E71GDPPNi21CCmOZ28/cPkfZikhiwtp5AxQdNRG9zqGtTIAq0l57QQkwzsXzw68jyOZvwLy8LEXTwb7iqgIC7TQkJ+29G7GzhQURG1nEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711462384; c=relaxed/simple;
	bh=FhtNZLQWuyLFu7dDdT12isku2y5LiTvNqB0gI4titEg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u+ujBrZfXeBgMmNxD0mxp2SDGw/69OYpKvUz3bzKvlTfiGuLZrN3BbZysVsPMfNIz7L5seYIpNngGwUW9l6nM3adTE5HVYVChjP58KcRjst7529Fyy8+rlye3Kqe5Sktojv3L4BkL7FUZ2hRzpjq+B1BA4/YnaA4x3wJcXX2o/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IdbRuFIM; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a45f257b81fso648644966b.0;
        Tue, 26 Mar 2024 07:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711462380; x=1712067180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qLHRRxSI4Hl56G/+UarRDoZK1Wj/9ZIxTRiWiXAgPnQ=;
        b=IdbRuFIMs/SGOMn8ny5swhNJSlNNOM7bfKJRbY2tHZSOsjf7Dhc6Su17D+i8nfs5Gl
         Ji0ATmQM1n3c48/gCeempYK6psQ1k4PI3Oo0LIlPGpXlrkNyoguXC8JVV1AarixvhHWT
         MoJ9LpxGapL7moKZOEbo2yF38dpXgwlzbSi+xpEek1kLKZ+7U/0VObrcT8Q+9A+cRmki
         G15QXlT+uZF6/yOQbGfsq6Vz9n2ShedcA8J6FDa5OKpBN8FAj8/IBnhd/lKYUE7F9uQP
         iwcJecQKzvSY/DD2B54QswSZGzmjFw6+UJ7hEhBsR1Z/qH4nJ11X9iqMG9KUxFt1MCzb
         zVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711462380; x=1712067180;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qLHRRxSI4Hl56G/+UarRDoZK1Wj/9ZIxTRiWiXAgPnQ=;
        b=ttp/ySxlYu6iO0Kpve7uYKjHLqHlKgdO3jKBbGuvGYLhwpYiVe7Oo0P7G1EZIo+W75
         Z/oUo6FX14YSbOe0FDhqVzoGcrkMUaRzKjrf5YZIo8XDTU5sv/kRMZySsBXpivaTlvUz
         JaBM+xGgnzv7YakmW9j7ro5Yf72HLJCH2H+mjxksoff6JF9M2br1hL4LPzwtZt8NuVf9
         U2HPS3dTnqGTLU/8HED85QK/jioL2titcXG6YVvw/mhzL7oKtVnNyBWirPAVaC1h7EL3
         Eknjx+qscAH/I0vhityQhIrmqyhyMGnQsz/j6eQL108Nl9CQwDJW0jhd6aunBFGlTxWk
         9xMw==
X-Forwarded-Encrypted: i=1; AJvYcCXxrRzQO5ZISxiotkgxxxy3sbeNZe3tRyC5yKtlNeV8+cNpPhhBz2x6KVxUHBvedcJcDv/LVh7NPwAb9gi21ueCT/Jh1cAia1QmalZC
X-Gm-Message-State: AOJu0YxWYr1rRcCt0yMUynhcWEUqiuTxyEQ6rcxbgcv/Qp3VKfryeuLn
	27TRCr8AWAxA/oDymryDCFXk3uNEOLZ0FA2mwGdseVY/Gu3LQHAr93e+j6f65rI=
X-Google-Smtp-Source: AGHT+IGsVcoN+1x6FIYzS/p2U4qw+4XpV/UTj6G66QyIUFm13sLxUw+Smj8kV0oO3H0gHD5xJtVXBg==
X-Received: by 2002:a17:906:33d2:b0:a47:31aa:142d with SMTP id w18-20020a17090633d200b00a4731aa142dmr7382520eja.70.1711462380393;
        Tue, 26 Mar 2024 07:13:00 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id t21-20020a170906179500b00a468bf8586bsm4324094eje.174.2024.03.26.07.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 07:12:59 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] net: phy: marvell: add basic support of 88E308X/88E609X family
Date: Tue, 26 Mar 2024 15:12:35 +0100
Message-Id: <20240326141238.2315974-1-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch implements only basic support.

It covers PHY used in multiple IC:
PHY: 88E3082, 88E3083
Switch: 88E6096, 88E6097

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
 drivers/net/phy/marvell.c   | 13 +++++++++++++
 include/linux/marvell_phy.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index 42ed013385bf..fae7eb57ee2c 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -3289,6 +3289,18 @@ static struct phy_driver marvell_drivers[] = {
 		.get_strings = marvell_get_strings,
 		.get_stats = marvell_get_stats,
 	},
+	{
+		.phy_id = MARVELL_PHY_ID_88E3082,
+		.phy_id_mask = MARVELL_PHY_ID_MASK,
+		.name = "Marvell 88E308X/88E609X Family",
+		/* PHY_BASIC_FEATURES */
+		.probe = marvell_probe,
+		.config_init = marvell_config_init,
+		.aneg_done = marvell_aneg_done,
+		.read_status = marvell_read_status,
+		.resume = genphy_resume,
+		.suspend = genphy_suspend,
+	},
 	{
 		.phy_id = MARVELL_PHY_ID_88E1112,
 		.phy_id_mask = MARVELL_PHY_ID_MASK,
@@ -3742,6 +3754,7 @@ module_phy_driver(marvell_drivers);
 
 static struct mdio_device_id __maybe_unused marvell_tbl[] = {
 	{ MARVELL_PHY_ID_88E1101, MARVELL_PHY_ID_MASK },
+	{ MARVELL_PHY_ID_88E3082, MARVELL_PHY_ID_MASK },
 	{ MARVELL_PHY_ID_88E1112, MARVELL_PHY_ID_MASK },
 	{ MARVELL_PHY_ID_88E1111, MARVELL_PHY_ID_MASK },
 	{ MARVELL_PHY_ID_88E1111_FINISAR, MARVELL_PHY_ID_MASK },
diff --git a/include/linux/marvell_phy.h b/include/linux/marvell_phy.h
index 693eba9869e4..88254f9aec2b 100644
--- a/include/linux/marvell_phy.h
+++ b/include/linux/marvell_phy.h
@@ -7,6 +7,7 @@
 
 /* Known PHY IDs */
 #define MARVELL_PHY_ID_88E1101		0x01410c60
+#define MARVELL_PHY_ID_88E3082		0x01410c80
 #define MARVELL_PHY_ID_88E1112		0x01410c90
 #define MARVELL_PHY_ID_88E1111		0x01410cc0
 #define MARVELL_PHY_ID_88E1118		0x01410e10
-- 
2.25.1


