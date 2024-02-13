Return-Path: <linux-kernel+bounces-64365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A821853D80
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B52A5289CE2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A1E69951;
	Tue, 13 Feb 2024 21:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noK6NEm/"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353EB62161;
	Tue, 13 Feb 2024 21:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707860452; cv=none; b=DSjjVEQvlbqkwqJyY8FJBthq9Xgs52zuNQSRXBD5aaQyH2DRw8l+7rg3FtXvNLTtSd4AYPiaAWJy3SKujKdB8inbGmXwKYoEoiEbmcH/K/1BrHm2x9ULPIS3q2bYhNZ+bWUIoGggTnU+t1Vcu6GmglQKAcZdKNzxcxJOTwTReMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707860452; c=relaxed/simple;
	bh=pRcdcoxkVJGtQ6+zrBcyvGZMZIiduD7CkrhQ43AOJAU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WBo4xP3bvIpQDPl54jg0i6dYpJE51CFsl5YfBrayLp/Tf683ReTwEwKz+VdWT6OmEkkrd/jsuAFcx+Msc67q9cPx3xhGsoiAKy+Fv2B1kKYL3H1lKXGS4IqgN9eHHuPrPOV9puAtRIRJt7f/cphuqWH1Op2cN1RCNMWCvfMNEKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=noK6NEm/; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55ee686b5d5so6499134a12.0;
        Tue, 13 Feb 2024 13:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707860449; x=1708465249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8PqblJIkzW09NwcQ9gaSDOjPumdVAsEfe3x36fJn/I=;
        b=noK6NEm/pdnMoHber9tXtDRZjOB4kTkLolNOWD1HiKCyayT5eXGKr7xxxas6o9SHo0
         w8AOp9b7imtms0sRaWN6DVaMifDQyEV/7HhJ7KvpwflvehAjdROmFzcXdDSDyZfzyz0X
         qJ9q2WT1THgaoMkyZASyt50V/pCGu+eLO57UEg7ZuCcfq0Qi4tysSISnag081+7hANfp
         FMOdGfBATo9t7DaW9xsvietKuBHvK6sfFOUV8Uyb5nXrXQBcl1fWfDf6WhyIXMOHWOnk
         FL3jAR049amEuGBpkMrF5iqiE2YBNT+WTUVcdHS16lFCecLlTNc3kvsAdJBzg+rVtape
         L9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707860449; x=1708465249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8PqblJIkzW09NwcQ9gaSDOjPumdVAsEfe3x36fJn/I=;
        b=gCxY417ZR0ctxBUGDADgYQ38njsQsrYR2gX17mWLmfiZx2DuMWsfv9Nbi4GfeRRnP5
         7jRFLDqhPszF931iVy/XnaYzrJCKlkvfb1QmNj+Cm5KOXOWZtU5NfP1AuvlfU1kkxwOt
         Bei6U/GfqDhXyR6w5WC00Z3/OPtFVPJevpZyboy5mGx18BuNmpZbIJYUSDS68EoHYGNc
         mTtWVET9PXDZ/hLRmZSQt70EgCiz09x19OkP8YneE1MwmAl2Q6k/u37VSxfMv5eQa6a6
         bjrfKhiU/cyKOBf4Xj2VdLePO9octWby7rdwAor9Qqv9p//ZKd4PMfhKw4TmMK5Dym3z
         5jeg==
X-Forwarded-Encrypted: i=1; AJvYcCVZRjtSFOTWkp0CJER7XzKFTXE9m3uI/bf+fpES5H24umAZv49Lw9UhaqwpB8gKcM7XyeMx5Re8KSJFnHfVfBLSW9jRPRBIcb6kLToBbDnWtRrYgdCWPmKbe+2E4GGtsL4TxSnj
X-Gm-Message-State: AOJu0YxYJAI0NUZvs8ibNbFX8tRQEednTPFlwftERgQMkWT06RP6ZNEp
	kTC/UmyELx0Qn9FECBNN+iXAPKuf+WpirIW/Dn1QmLQ4iI/h4rtg
X-Google-Smtp-Source: AGHT+IEVuEMoAI90cYOn23eXM8cyYaoRlmTxsYuyz+NAaVvHgsAM44eRVWnFYav3+6hC07/n79XPtw==
X-Received: by 2002:aa7:c1d2:0:b0:560:64f4:cbd1 with SMTP id d18-20020aa7c1d2000000b0056064f4cbd1mr677922edp.19.1707860449430;
        Tue, 13 Feb 2024 13:40:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVdmb7A2UKEC+H/R6KQtwBPExW7oB3qaBGB7q4U40CzGdIY1GkiyzYVh5fTq6NZmQD0Q3PDGsrY7gDQ9rHHHXzcSEtpPnHMzfwNJKzKxhTbxvKLg8cUQV0IUXsk0a4H1swFTeO15/7XRFamqp6RnQRz+hjCTjESiyTNNXnqMTcUiF0gvjLZvVz3QysKj0gBhX6VcP34I1gR+e/4Ot29FpEjAL1t1S9+UIrSa+/YwuM+87/DVuBSdqEyuoT5+/JdF/hi7l32Jc9IIOizIJeRqwymHL4n5wAjQB4y74gZwFzatktkKEgUit1M9wlQvTDa2O8Ep2O3md8HO3myY3FDec0nxxE=
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id k23-20020a05640212d700b005612987a525sm4003913edx.89.2024.02.13.13.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 13:40:49 -0800 (PST)
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
Subject: [PATCH v6 net-next 13/14] net: phy: marvell-88q2xxx: remove duplicated assignment of pma_extable
Date: Tue, 13 Feb 2024 22:39:52 +0100
Message-Id: <20240213213955.178762-14-dima.fedrau@gmail.com>
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

Remove assignment of phydev->pma_extable in mv88q222x_revb0_config_init.
It is already done in mv88q2xxx_config_init, just call
mv88q2xxx_config_init.

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/net/phy/marvell-88q2xxx.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index 64b96ca83a0f..7afaa693316f 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -700,12 +700,6 @@ static int mv88q222x_revb0_config_init(struct phy_device *phydev)
 			return ret;
 	}
 
-	/* The 88Q2XXX PHYs do have the extended ability register available, but
-	 * register MDIO_PMA_EXTABLE where they should signalize it does not
-	 * work according to specification. Therefore, we force it here.
-	 */
-	phydev->pma_extable = MDIO_PMA_EXTABLE_BT1;
-
 	/* Configure interrupt with default settings, output is driven low for
 	 * active interrupt and high for inactive.
 	 */
@@ -714,7 +708,7 @@ static int mv88q222x_revb0_config_init(struct phy_device *phydev)
 					MDIO_MMD_PCS_MV_GPIO_INT_CTRL,
 					MDIO_MMD_PCS_MV_GPIO_INT_CTRL_TRI_DIS);
 
-	return 0;
+	return mv88q2xxx_config_init(phydev);
 }
 
 static int mv88q222x_cable_test_start(struct phy_device *phydev)
-- 
2.39.2


