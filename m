Return-Path: <linux-kernel+bounces-64363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD88853D7C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B2CA1C26A81
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C202365BAF;
	Tue, 13 Feb 2024 21:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEdMQfwg"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F90D657A9;
	Tue, 13 Feb 2024 21:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707860447; cv=none; b=VNkEXHcX7PHYXpLnXAaPXi94AaFyNix9z7DfqWZFX6+BJhCOP1wUEhXfpv/7580m0pAiixeZa/JMc5EcDsqEmXyT3ceuxBHqwP3GdujaRtynLwTW3t41jMB1IKLizB4ALjuIRI8rJT0aJJ0z71aE8865PFWJS25PpPqSfA3VDrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707860447; c=relaxed/simple;
	bh=HvCSJOpeH5pQW9J3p8kulTcz0xoYilN7jOhQKK+kq4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XtXl3MY/1DU/JeB8/k+nks9rwbjP24351FsmNtPX6+4PJBG9afejqiFng86G3jmrC1uITymn6xEX1ut570tXLPd39XDu4ow9iBl/PpdzjK8GfmojXQZXbwtMB57SUzjcOtpS/Gwf6BswnOPhMq5Ip4pN/ddPImDbQVv7dTZbX4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEdMQfwg; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-561f4bc306fso1370902a12.1;
        Tue, 13 Feb 2024 13:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707860443; x=1708465243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJuPqD+a90aENqljuSvhOuOykmDYIIKd0gcpkEo0slI=;
        b=PEdMQfwg29DO7myQTNCDiRsM8zGq8uYt289TiOh8+QgXafHXr2KYA6tGwA/LwQl8d/
         mPYmLjgMB4aiWyur2hI2QsCnZBqkC33MB5tcxnMGo0h7GJhZbAzgV1bhPFPrZdHTJWig
         8noEwY8g5MFJoSy6JCciPiZYOtlgMYGM8jInE9ap3M2oOOISmz4yYFX7Gp9j5Ku85lle
         NViIlE0RD1ZczpW33T0Sa6PzujwPLS9nxi549OlkwAT6tbwMhAzdMn/+c6PRHDHR92bM
         Ab95I6Af5xq0tx9Nwr/wHoBd0IwAMdYSxZ5C8IUN3s+lZ5Maa82BE7tIRHpi2vs2bsbH
         JUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707860443; x=1708465243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJuPqD+a90aENqljuSvhOuOykmDYIIKd0gcpkEo0slI=;
        b=Ar5iyKcuoYJieK4O0ThhIFe3RXsTkk7nHkuAWyHC9PxiXugajo0yEZEkqIY/hbu98G
         OcYdd3qFIaapi9YWXws7SSCdGuaOEe33AqSiR7nmD+uKFSayZajDxOtpWkisySRwNHa1
         8ysepAHNFQl/JOeXrwHrx/KREk7cS71NMbZXxscNRkpJPtl+gcbQ6H5aGQJUbXRrGLJ7
         Aksq0z15xdWGcnPz9NI9W5AhMDZdIr81gnjxO2bSje+zCLD9+2PCYlzLWpPLQKGdB2pO
         qb9A3hgsPyQ3zl5lysN7gxBlWKJ/ijuRksZg7SMAXpHp8Vo8W9ve6gs4u9vgeFULtZAb
         etig==
X-Forwarded-Encrypted: i=1; AJvYcCWJF41xVrOsUAv9rAA1WnI8zvR8mhLvMnIKm1raZ7hYms2+IgJ8+71jcbbcAtFzgNLvf0uaqyzbVdmSRVg9zS7QAJhoMtIkrvZziFkWyL+tYP65agGUh884NluqzpDAaT9xvZhB
X-Gm-Message-State: AOJu0Yz/X0on6zpA2z88HNtgUeijlDLCUmt2sFPbT/gBo7Eh+GhXyPXe
	EQCjSNwjFYfuvkps9jTH8pO5LEXhuzrnPuqMl1shMspNMT5o+fdA
X-Google-Smtp-Source: AGHT+IE9Vrkq8h2N6UyYOUpULJAvqduP2Nvme8pWxvSZnqu2zuitwxMDCxECyGXFW9zejXbYND4ccw==
X-Received: by 2002:aa7:da18:0:b0:560:d8f:7def with SMTP id r24-20020aa7da18000000b005600d8f7defmr667803eds.17.1707860443602;
        Tue, 13 Feb 2024 13:40:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUTwELy5w9Mom+o2eWrZeYJjg4s1I8kQcU2nOtsNkCFthdwU+s7XPQzOEC+YKJLWYFoIdMi87ay5lQt437kCwPtEkVkAKc7ELDiHTnND3GDHBAvJK0Ozv43i0FCa6ldkaIZBKbJ3kwQy0YijQJI/TpTEHfJI55ChRNqE7IZhN7YxzaD6L3LdIS1tI8ENQJJT18xt1IrJOUfVby3/oRcpIte3+8aW807LV7I/ImqQx3B1nT/mtfaIiUB4vFJWe1iQne3kgsHMD/Lv1cgqdmz8Kw1gTTj0UHAp7FN1zN+fj5nuZafswDBuLO7EBy3A09VBul1707OI1NTOK1u4oMfSIlvqFc=
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id k23-20020a05640212d700b005612987a525sm4003913edx.89.2024.02.13.13.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 13:40:43 -0800 (PST)
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
Subject: [PATCH v6 net-next 11/14] net: phy: marvell-88q2xxx: switch to mv88q2xxx_config_aneg
Date: Tue, 13 Feb 2024 22:39:50 +0100
Message-Id: <20240213213955.178762-12-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213213955.178762-1-dima.fedrau@gmail.com>
References: <20240213213955.178762-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch to mv88q2xxx_config_aneg for Marvell 88Q2220 devices and remove
the mv88q222x_config_aneg function which is basically a copy of the
mv88q2xxx_config_aneg function.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/net/phy/marvell-88q2xxx.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index fa75d34d1d04..58140dfd75cb 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -685,17 +685,6 @@ static int mv88q222x_soft_reset(struct phy_device *phydev)
 	return 0;
 }
 
-static int mv88q222x_config_aneg(struct phy_device *phydev)
-{
-	int ret;
-
-	ret = genphy_c45_config_aneg(phydev);
-	if (ret)
-		return ret;
-
-	return mv88q222x_soft_reset(phydev);
-}
-
 static int mv88q222x_revb0_config_init(struct phy_device *phydev)
 {
 	int ret, i;
@@ -829,7 +818,7 @@ static struct phy_driver mv88q2xxx_driver[] = {
 		.flags			= PHY_POLL_CABLE_TEST,
 		.probe			= mv88q2xxx_probe,
 		.get_features		= mv88q2xxx_get_features,
-		.config_aneg		= mv88q222x_config_aneg,
+		.config_aneg		= mv88q2xxx_config_aneg,
 		.aneg_done		= genphy_c45_aneg_done,
 		.config_init		= mv88q222x_revb0_config_init,
 		.read_status		= mv88q2xxx_read_status,
-- 
2.39.2


