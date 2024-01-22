Return-Path: <linux-kernel+bounces-34193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF804837564
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98563283C5C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91564D12C;
	Mon, 22 Jan 2024 21:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lU8OpCQT"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B244D10A;
	Mon, 22 Jan 2024 21:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705959009; cv=none; b=Vq0c6qU0pXzqeWn6mU1CSdeuN/AXYwta5eFf7/ztLENhKZbjhwvO3wOu5zNNgBUnpnRqjFlWujEoPyFUiALy5bIynHjRezIGQmtY5ri3EmCzJncL1vM87i0HVfKyuwWpDBO6glbWXyy7EbQ6NGu3DAR9AIRZDGTCcRmCxxWLuGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705959009; c=relaxed/simple;
	bh=Xbs3AnTc9csSfK29sKF5fp95p3udNX6YqDARYVknopE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b2St7tCoV/LbLEsPu184KeJwTTjCDNjs1s/gwBT7OxhFOLavvayxdsh+ouxlBcj9FnR9SXA3RaYIqH6ynhffPQfEwjkc4dIg3jFLhU+6TH3DaMC/xth8lpG8HXJSxeU3Oyv/KW+xfZVvfLqGvjfLUCAf5wvytf/6dC2HifL0Zfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lU8OpCQT; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3046221b0eso129017566b.1;
        Mon, 22 Jan 2024 13:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705959006; x=1706563806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wp3PDqcQ843HUpCCrZHURGwVfYPdbuicc18GeVDax0s=;
        b=lU8OpCQT2yQrexlWtYUAgArV1qoInyq9n0YkAiecokXT2c0NNcgLL6tIh5K0kAvsq0
         h1gELfEtWXnAiAQXHeWBOrNdA/X5XZf72JXl8A8LHoR9R7IXwvm7KAyyoZGWVq8dKgtZ
         2WKDQLyBR+/1gPJDkbNkvNNIHUIldo5M3Z10kVEfU/KmN8foYSMWigQY4ozADXOLenqX
         QTdF/MQA9fTuGo4K2YTD2ABPD8ilng28Rz2r7pmiw8/b6snmhS+wXUpxNSTBcRvoSeYt
         fX0yFCCsfwOCTcXP20rsCIakYEvZCWILf4MtFkx3dBwdtSZtaVBIi2iLTu8SeP9eSwGF
         kIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705959006; x=1706563806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wp3PDqcQ843HUpCCrZHURGwVfYPdbuicc18GeVDax0s=;
        b=GR507+Slb5mAxpbhrQZ+5Pi8lb6bHVCLhMqKEDPkytnTsZgImn/q2yb5VbnWdJPUWn
         EllBV1Xuxl+DUY24DDpFh0kLHa4jZos3tDOVB6rABLrItPGTf7ckrvuxZCK7hrv7geBq
         XjuxaZghaPfH2WZBc6ZRWqT2ZT5a6OGHCtWztlDEVnkhg4hYXMoUqwBn/tJvBiq3A2ya
         A7hFuRE1UncnnM70VU4NkFo41PFtanpjzTJM+8laEeaGTz96uO/6ps+V6RtH8wxel06n
         U7wThiEegSFzl/iJC2MSF2mxgB9lPxtigoZlg3HdcgsVWWI6Ro56KAYsLoBkyzL/ZVX4
         jpPQ==
X-Gm-Message-State: AOJu0YzisrTBabl6vVswSHL2m0v6cvgte5LSduXyr4Pin3BwP7AKPpmx
	CVbBcbAkzrX+iP/LBZW60jPpRCr3PQyKQE5bTQmbM851qjKaE8Do
X-Google-Smtp-Source: AGHT+IHEhBGonalKKMqCCXpoEQck36ZJuK2jtZTrbMzi52ezwULTwXiW+6jxfOFhb/2Rk/EMhqyqPA==
X-Received: by 2002:a17:906:da86:b0:a2e:93d6:3680 with SMTP id xh6-20020a170906da8600b00a2e93d63680mr2849749ejb.43.1705959005906;
        Mon, 22 Jan 2024 13:30:05 -0800 (PST)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id j25-20020a1709066dd900b00a26af4d96c6sm13823336ejt.4.2024.01.22.13.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 13:30:05 -0800 (PST)
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
Subject: [PATCH v5 net-next 12/13] net: phy: marvell-88q2xxx: cleanup mv88q2xxx_config_init
Date: Mon, 22 Jan 2024 22:28:45 +0100
Message-Id: <20240122212848.3645785-13-dima.fedrau@gmail.com>
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

mv88q2xxx_config_init calls genphy_c45_read_pma which is done by
mv88q2xxx_read_status, it calls also mv88q2xxx_config_aneg which is
also called by the PHY state machine. Let the PHY state machine handle
the phydriver ops in their intendend way.

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/net/phy/marvell-88q2xxx.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index e40ea351fcde..081ed110c87e 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -367,20 +367,13 @@ static int mv88q2xxx_config_aneg(struct phy_device *phydev)
 
 static int mv88q2xxx_config_init(struct phy_device *phydev)
 {
-	int ret;
-
 	/* The 88Q2XXX PHYs do have the extended ability register available, but
 	 * register MDIO_PMA_EXTABLE where they should signalize it does not
 	 * work according to specification. Therefore, we force it here.
 	 */
 	phydev->pma_extable = MDIO_PMA_EXTABLE_BT1;
 
-	/* Read the current PHY configuration */
-	ret = genphy_c45_read_pma(phydev);
-	if (ret)
-		return ret;
-
-	return mv88q2xxx_config_aneg(phydev);
+	return 0;
 }
 
 static int mv88q2xxx_get_sqi(struct phy_device *phydev)
-- 
2.39.2


