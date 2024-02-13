Return-Path: <linux-kernel+bounces-64354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0C5853D66
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CDAD1F2371A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216BD629E1;
	Tue, 13 Feb 2024 21:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yj8Y5Wli"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A93627F7;
	Tue, 13 Feb 2024 21:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707860423; cv=none; b=JHbIhsekX/e3LgJC16Plg9u+mwdTn2Nqznp112nyYysO78A0t3D3U7KSguJDC5dRPlhVHdZ8eLxsHKBLSePC25982tLZ7uolwU7ZF+Ze8bcvsBychmblsBaq6excMHLYshmqTfXoWLX5am6nnojw3H2jMsEStEaYC4oolDM9KLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707860423; c=relaxed/simple;
	bh=cFyzorVyt7pR+oxl9oSqdJVk3CnfNL+zpcN7YvtmWuI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mcmcBJXle0vb2kS6+3ZSAAYE3HO04ikdqTIVJh0cpXH2WFohrdxFuCl3Ut2chB0n+kjk+LMN+IxlrE16AEZZHBkrgdEC+p+HMEfpZm5Kf5sCQkQoDUJflpaoz4+VFEnkgB7Z5Q2Lruj+T4EmWPrVaZB28OUdsdKi8fDSNROWzwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yj8Y5Wli; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56001d49cc5so6053713a12.2;
        Tue, 13 Feb 2024 13:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707860420; x=1708465220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AH7FjojSelKl6RFjaMdeJGd9WEI2qrfj4ii5ApRFD+M=;
        b=Yj8Y5Wli3o5mx+vto7xy18gphrhWWWVm8xG8Qb5+vtMGqbWMZnoq8TMlpFt/v7Qx6j
         Dr6giy6QiMokvwpomDtBpJ4utsHrkWGFgIJtwR7xb7U3d0fOUyJA6n0bdnWf6qNRAA3h
         I4sWiizFD85Jv7gc3jOuOTsBOQ+UNHAtFAa+WB/YE9l1Ew3zONF/dKIyHRecZrGCxPsV
         6ZODIHPNPXZEEEFb2IGveP6b1fKOE0RJQwKNKnGzWS6t5vvU1jU9FT0+PB8rEay4dYzD
         LiXgg8Lj7cL6nGhBSc6yNwN+Tae6UT6eIE70hgmzHeQAmjWxpnmT3U6fc+Ht7HACRKMk
         JNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707860420; x=1708465220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AH7FjojSelKl6RFjaMdeJGd9WEI2qrfj4ii5ApRFD+M=;
        b=SeHm1agnaQwvi3q4LmR6EFqPebuNk7/IT2Q2X7o67+VhYb7kFx3Ssn/CP2olWXhtLr
         lR3sHH/fO1g1y++MGc4f2uEM/9RSIMovfSn7MBbCrAbSHwotOCRbLjAGA4F7Bw7Xa7XZ
         vVh5xNK0fCG2mfZQyjp63ep0JiD3aKGNNclhQQPi0egxcXPMSW1W4tRI2A/M5LKJWedV
         7aeahf5LghHc+C0fTyKF0t35shdeVOoCwWNlWfqMXFNGZ0TsonZKiHnU88OiSXESDdAZ
         IlFZj0CDQwOmRgv6eTr5fkyn09MJTq2ny7bimgboWogZbi+iL/QOpQiZFzxzZlGlbZ0R
         lfTg==
X-Forwarded-Encrypted: i=1; AJvYcCUS093wW2+wEXP8NgqaPr/v3mgTDy2jUQNfPudDv4/WeMANop+DZx5v/bfnjcEGhFXQ2WxBwKu1YGu6XDpswvybV1P2Qz9234M9HRRYjsFkbh6piiCC8XLPdiGOGbl1HTpoPeqx
X-Gm-Message-State: AOJu0YxWNcarblHmDHFjL+us+m9JRoT3DypNxJ3hLuZ/8510KyZi3EMy
	gsxgXxQG9R9EXeXHu0ikXUCeVRAZ5XkO/QQbz4eANZL+GsTPQBbT
X-Google-Smtp-Source: AGHT+IFpWcx6761os9cY463iuCWj1XL4UFa7Ld5yCw6fna2rdMN3IzUFuO9OuDGXe4y1loKdEOgQnQ==
X-Received: by 2002:a05:6402:6c7:b0:55e:ef54:a4dc with SMTP id n7-20020a05640206c700b0055eef54a4dcmr640135edy.23.1707860419584;
        Tue, 13 Feb 2024 13:40:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXQ9zxyD1Pggf8hY8RG7yzYR1rUCtJlOfqguf2JMEViHGgeozHqBSMHfcHcq18/kVmc8lbBlvYfCqaPW8DN13ZvkUJro2NfdJX+YRmyPqOs0bX9EpLSsppaI5EUnxABecsqYr9L+hmUjWOzcMG82Klfoha28LfRnT43kqbWBlQsR+eXrKK/kpuefAUY3PnYvhYwiGjsQIZh4cJo4kGCTwJOj/tceNzvVbCXshXisED05st5gn8Bek2fM+WxHPPMmX1EvoBZEMXcBWuDT+H65FjXEMv9u/NAhx/WnHHZLpFa73NzpdAMC/DXqKo+epyhfAKF0Zx+7IuIaXNBDcgBlOLTF7s=
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id k23-20020a05640212d700b005612987a525sm4003913edx.89.2024.02.13.13.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 13:40:19 -0800 (PST)
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
Subject: [PATCH v6 net-next 03/14] net: phy: c45: detect 100/1000BASE-T1 linkmode advertisements
Date: Tue, 13 Feb 2024 22:39:42 +0100
Message-Id: <20240213213955.178762-4-dima.fedrau@gmail.com>
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

Set 100BT1 and 1000BT1 linkmode advertisement bits to adv_l_mask to
enable detection.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/net/phy/phy-c45.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 747d14bf152c..de8f5dc8be12 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -208,7 +208,8 @@ static int genphy_c45_baset1_an_config_aneg(struct phy_device *phydev)
 
 	adv_l_mask = MDIO_AN_T1_ADV_L_FORCE_MS | MDIO_AN_T1_ADV_L_PAUSE_CAP |
 		MDIO_AN_T1_ADV_L_PAUSE_ASYM;
-	adv_m_mask = MDIO_AN_T1_ADV_M_MST | MDIO_AN_T1_ADV_M_B10L;
+	adv_m_mask = MDIO_AN_T1_ADV_M_1000BT1 | MDIO_AN_T1_ADV_M_100BT1 |
+		MDIO_AN_T1_ADV_M_MST | MDIO_AN_T1_ADV_M_B10L;
 
 	switch (phydev->master_slave_set) {
 	case MASTER_SLAVE_CFG_MASTER_FORCE:
-- 
2.39.2


