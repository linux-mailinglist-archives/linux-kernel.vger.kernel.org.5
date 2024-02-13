Return-Path: <linux-kernel+bounces-64362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F09E4853D7A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABB36284F38
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCF9651A4;
	Tue, 13 Feb 2024 21:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkO1oyIb"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A57164CE6;
	Tue, 13 Feb 2024 21:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707860443; cv=none; b=IzCuL/sHnd8gFJdGh9rtQ1wkks5eViiPZLEDZafflCITOkNfvCsCY7yho0ygQhd9Pyo2afmb/Ekil/WzeLQ+PDZo8oM4dbqTcHupWLL1BGlBXL8lJ1udTL8pv6zPIct0de+2qn0HQps0ECuUm4ibLb4MxO7wzkZ0JETGl8yNEUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707860443; c=relaxed/simple;
	bh=Dv4JQqXsRVOgyAhAhDhlHkEqIxr/ZQjBsmY/eJgPTZA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p02cQCpPEQzpz9qDNMLs3Q7uh79vZZuO8O9FZutlw24MXEDmA/vIJVuDhNduQvdwtouVA9W0fkP4DI3/Ku3h9awe4PDBnAKvdJsKLyYoy/Ov1S35F0j6u5RlKVihMVBiU0iNRFh7mSPYTZqrHrsVNBI1X6A2uoeJUCVaWI37ga4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkO1oyIb; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5610c233b95so5355030a12.0;
        Tue, 13 Feb 2024 13:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707860440; x=1708465240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ia2MQQyP30BsuKczKS1Eq7Fn1i/O5F4KTy96rfmHjic=;
        b=YkO1oyIbmyFOp+Jd7l32Wehgco1evWIBVhMESHuleGsEu5NzndDOHUcaHwEm4LREds
         zlAilvqyEBfYdelAYVjfxA6CNambt6+XjTcRviIqQBqmHqlJcnsEseyFpWlk6JtXkQgs
         Rk/uEea2hTf8qASkCbOnmlzDDmTfn+jD7fGpADBDtWW37ozl3Bp5m0L7/kTHDznq5Gpx
         WuOJUrWIWsJqI938jM4wni3ORSv82nBEaSGFi1pjJXlFndZizmG2cQFm48dKVr6C1Sy4
         5U11EjS/W6r0yc8garV7J1a41+0s5Lc6cZy3T5XOV2q2HJrdFzwRUMVosiHVfwUtEUmy
         BECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707860440; x=1708465240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ia2MQQyP30BsuKczKS1Eq7Fn1i/O5F4KTy96rfmHjic=;
        b=KzNEppCkFe1dWCogMyVeCGeOLyK+ImyAljoePO6I8Uauwds5p4jHQ6wKNHBMXVLQwP
         MryqKTyBjFLjfdh+PK7Tf+myaJziln3GYsFDbdzWhicwFPaKk2l7AR+2oq31xpWvC06o
         GsdrPDYw6B65nBlysbto6QYdvAnpY4cQy19WL3lxMkSqcQIqRxUURUmwl38qa5N8b572
         w0GRs+OZ5kg39CJ0vx8myAWWUksig8djqJZM2wwQOSud1HmEIAH+OIkqrhJe0HW23+1r
         j3CEUPnAzJWzC+Kh7AgiLnpmk2eHosncZqzOHtgR1jpEtnJUGgwlWq20NUo1UYRwZQUV
         sCTg==
X-Forwarded-Encrypted: i=1; AJvYcCXpr8Ob5DyD0TA4WZKYi2+2l6r0WE4eQoMzhmIVAWlplztEkJ2MB8o8Kws869fMvv1XxZ4/1/kOgAak3kWLRg88mkVpkFPLYYkc8qjMmaLdOuRhovlIOhRFj9jGk9Z3ZZCvQ9N/
X-Gm-Message-State: AOJu0YzoeOYc6I8ErO8L8eTEMpTQvzpT22RDJ9zJy8yce88G6BB76v9e
	48bWSe2tGkxJqIng9t/JglLcvO4fUMfeeHkxpA5wRwEx6GvMcfIt
X-Google-Smtp-Source: AGHT+IGSUKgROOhvq4eEy7dlbmODrpkNJVRJyCklGl9cVZ6ZKDkGWrIUrU9iAZlz8H9VuvXy0uI31w==
X-Received: by 2002:a05:6402:505:b0:55f:c930:8b8a with SMTP id m5-20020a056402050500b0055fc9308b8amr594471edv.6.1707860440647;
        Tue, 13 Feb 2024 13:40:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUvQNYxBg9kVTpyiqL0lglnt2jwlwzdZ0sXU0XWDprqFV8g+85awMjZgFdUaW7UnRM9QSd2+o2X9F55zFATpQQubL72GvX9FBv22FDr0SbPoaIiaDmZEqV0OKoxoUZBwGjtllADKTVVUBbGqPz/PHq0A15XcONobuCWUR8Q0MLJK1+DN/hpHvzgkSdZn/uThHhVrU5Ab97LmIrSjNzI9Kr/lRiSIZPgsOsN5uSaDqBam/OvnOPoIksR8L8KisiOcXMEYf6MPF22Q9Wk0ycq/z518THRCWKGERuaKYjjNypgFeeXuMaeLHl9btASAEgdpuw/kLlN+e0Ay+wMx62yFiklrtQ=
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id k23-20020a05640212d700b005612987a525sm4003913edx.89.2024.02.13.13.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 13:40:40 -0800 (PST)
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
Subject: [PATCH v6 net-next 10/14] net: phy: marvell-88q2xxx: make mv88q2xxx_config_aneg generic
Date: Tue, 13 Feb 2024 22:39:49 +0100
Message-Id: <20240213213955.178762-11-dima.fedrau@gmail.com>
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

Marvell 88Q2xxx devices follow the same scheme, after configuration they
need a soft reset. Soft resets differ between devices, so we use the
soft_reset callback instead of creating .config_aneg callbacks for each
device.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/net/phy/marvell-88q2xxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index 93a6a9dff722..fa75d34d1d04 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -364,7 +364,7 @@ static int mv88q2xxx_config_aneg(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	return mv88q2xxx_soft_reset(phydev);
+	return phydev->drv->soft_reset(phydev);
 }
 
 static int mv88q2xxx_config_init(struct phy_device *phydev)
-- 
2.39.2


