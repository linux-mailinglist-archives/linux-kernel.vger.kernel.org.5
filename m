Return-Path: <linux-kernel+bounces-64364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4B1853D7E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADC8D1C26D19
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8776C664C7;
	Tue, 13 Feb 2024 21:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSuvsoOH"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4360065BC3;
	Tue, 13 Feb 2024 21:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707860449; cv=none; b=IcT9Y9Gu2vb3eEdcSNbR5+kEOwjr0PMmPiU017BzgO1whjT/x+IyM8fwElAOmmXtAsA1CzzMVho2rc551sA+Uqoq+1HNacvLYUDcgvnfEGHpyJAs5DSFq/eFXHutWXZjTAtHVToHTnLmZWn7PymWntNPob1Z57Z4dSRmSuZrcS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707860449; c=relaxed/simple;
	bh=zjOBgi4Hrdw7U4QoP3k6BIf6OXaan7rQIvpuLsKQHzU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pkc7USEKpK9GP6XCOmNJizjaUW6T/xgU6b2DZ1Rx573aRXCbCARfi4T2byjP5EDFJqU6H8K3B5g2JzEBifLTdWx8AiijhrrKqWXOwpoWZzxYSezfH1JSdst0gBEeLk/bj3Csx8t3pQJt1PlYciZNflWBMh92zIK7q66776pv1VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSuvsoOH; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so6552227a12.0;
        Tue, 13 Feb 2024 13:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707860446; x=1708465246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WgXAQTRVrWScNTXURozFbod63VKwU8QH9NP3SL+91b8=;
        b=fSuvsoOHIOsiZlXt+RTlrAWtZK/wfbavhzsK2RWp2dMfoDpA8OBJVBP7BW/iXXLKpi
         ioaeL+SHv10iO504clNXY/rJJNKey63fZY+usguJ8Ma0dMNQmRtFMJ8N54XBqPONg0OT
         a3xA2iBrc2uWw1+TWV9LYaN2n0Bq8R/BloUz8VzYExGDvfs6Zp3gj1J4r3/DYZMUPWSI
         /ULhrT8tQJjX+mrjKB2UKsw/74YaJ3tXI6wZKN8ba41MBKp/jt/lKJq19NIWPDLGyywa
         wH5B3J4JTckc5W6p9gD1rsjWZWsZXeaea2pBc7oZJ1QxY5uKeTxv87oZJb+F5y5KWHnU
         tHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707860446; x=1708465246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WgXAQTRVrWScNTXURozFbod63VKwU8QH9NP3SL+91b8=;
        b=CR7u2bSabhkoI+cSQi+6kRypBP8vA0qopZt8UiXq5KXMU4LOLKP/dbiw/uebmfT8p0
         wZ0ePWtAVq0QjJyKTQD7lqIEVlm2LdSH4bFvkEYGpzOejjWeC6o9EhaIquORTol3k/Gn
         zNOi8T/2e6IDvpTJ4pqvkADL4ENrdiqTdDdxzFEcqRTZVop6ZutvbGiXjTTYEwrSmgbn
         SAdxpKea+nMCGvSO6dCy6g6wb1pZV1mIBTZC8hsiKa9KuAruobt7m5UD2pUCjEA4COMa
         3oUlgx8N3RVhbA4t8a+VcOp2WkJVdVwhnIqNdEDLJXbyDyG/c8hsOggGSI/Y09ekGOzD
         V/1w==
X-Forwarded-Encrypted: i=1; AJvYcCXNXNwwNpv8W+DBnEiaz90xJaU8JviE6BExxPk0GQ9vorDYIou/XvkCdiKxo3MGFg992v3hNTctetORBU4VBsv5IVdxhwN62Hg2oUPHgQuXixUFpUwAxcq+FcoLbILV5u4SBFoY
X-Gm-Message-State: AOJu0YwMBVAV0ovlFIuzpAT1PkGhmrDclHnufSgy8dU4uOh7fu0cWke3
	UXP2oeKe/Qyz1TVKNfn7qYvMSTm5DD7TMXStmsEERwORZQjBqTCM
X-Google-Smtp-Source: AGHT+IFjPDXdbCGM179BEc59/bniy63XsWiKxumFZaSWWQmBoWnGtFKX4oao3YDW5cdaJED3Ml+78A==
X-Received: by 2002:aa7:dcc1:0:b0:55f:31f7:4279 with SMTP id w1-20020aa7dcc1000000b0055f31f74279mr659292edu.12.1707860446505;
        Tue, 13 Feb 2024 13:40:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVMGXPawz8pRYRevPBeF5CP7Zz3SJ0gO8Ru3kc7hmgdFoQxyadt5ncflR8RA1q8oAhApmiDPzINd3+nq/evts1C6kHEugJQ+9D0LpePwi+3+5rTAKKFFr09HyoSatlLY6fgm6GA8DjZ/T9jqGzQ9caHXbclAzEygxY4XVtyGlCnGyELOwEZb8Q7sjEbPh+8L1hVsWuCpjwXka97mka3x3sLXxArP7PmhCjiy5kQbhYdq0a34oGu16kU+a8rMlhReIHYAeyw9zU5+I5DbUnizaKEgy6VlHY+xdBsKVqteU0nKnFY27mxJ8WKtsUp/oZ1varRe+xARqWdR04aYd7zygfX29c=
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id k23-20020a05640212d700b005612987a525sm4003913edx.89.2024.02.13.13.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 13:40:46 -0800 (PST)
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
Subject: [PATCH v6 net-next 12/14] net: phy: marvell-88q2xxx: cleanup mv88q2xxx_config_init
Date: Tue, 13 Feb 2024 22:39:51 +0100
Message-Id: <20240213213955.178762-13-dima.fedrau@gmail.com>
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

mv88q2xxx_config_init calls genphy_c45_read_pma which is done by
mv88q2xxx_read_status, it calls also mv88q2xxx_config_aneg which is
also called by the PHY state machine. Let the PHY state machine handle
the phydriver ops in their intendend way.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/net/phy/marvell-88q2xxx.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index 58140dfd75cb..64b96ca83a0f 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -369,20 +369,13 @@ static int mv88q2xxx_config_aneg(struct phy_device *phydev)
 
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


