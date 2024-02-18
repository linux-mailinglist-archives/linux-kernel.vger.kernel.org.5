Return-Path: <linux-kernel+bounces-70523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED738598D5
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3B1A282037
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2019671B53;
	Sun, 18 Feb 2024 19:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blQQNtMw"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2236F503;
	Sun, 18 Feb 2024 19:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708282849; cv=none; b=EFgCmRkW2emJXiv5M7RriLnaCr91CpXEL4nQph8X2JB69xhi9rzdzt1n51Seg4XuSmEQcd2yZtnO7yrVUnG26bR5v9NFEv8xp/1YHi1yPCZX3MknjII8gUaLegcKQAdlmKJerQjVuiFP/Sw+uBAfrNDtaUDwjywlrx5PSstLAIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708282849; c=relaxed/simple;
	bh=haKYsHp4CkJD0gLwDin3HMHYGes9vTGE16+z/nBaGT4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ojKA2/7R901SRg/G7yRRL2Is8PvbRGoQFk3hLaThO6z3zO9GLAZfdc9am9N50oQBcGHbNZ6eM84i3FYY2LZ+xjuxBklm9ZZPzeJzRvdvqcN2W84Sp5Ofe8DnELmDUbYhF90ecC5Pa/WMpuk36loQwfm7VqLqGwK2mqLpQbdObI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blQQNtMw; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4126144d931so6064135e9.2;
        Sun, 18 Feb 2024 11:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708282846; x=1708887646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RlNoi7vy5vrkW9XYEYtxG7NDJi03n4jp5ZDDUFrxYTc=;
        b=blQQNtMwegXV0YkExG+ho3A2LXoKry1KOMIMmwxvSq2zdkKRClfI2h+m+tfdgBVOSl
         shVP7BE2hECjIF8BvUZNVBD9v1WeNVC6G1w5D+WaxNUEqIkIrlDxCsLOMUBsPqNP4j25
         B50E+26+NuBJla1zpGNJfjEVcXdy3pRsZ+f7UONWUt/2MttLjg/WK/RpznSja4oYzVTJ
         NtZs4y0sPvKUMPWaoGQSQUraXtt6I0fTUqqW0wc80OrYeu3zlgMmFXlPGaUG7DltwvPn
         NC/5/2K1ZbFFfqUD/NMEXsfKz4olDfg9FhOn/c5/jADXZGFZn//I7e41U9+VNIalP2B0
         domA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708282846; x=1708887646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RlNoi7vy5vrkW9XYEYtxG7NDJi03n4jp5ZDDUFrxYTc=;
        b=dT1DR1bKOPOYLjPIx4OPKiNABQ9MV5pemM9lebfurhCkyptu8IuLV8V4m8ibUt+YTC
         /aA6Ypk1M5yZIeufyWGPLXDoIj3eda0fLxFo1wXFOBNXljZrYkHhEo1yBBjecy9l8TiD
         ACMudy2QdexUp9HGWvrVJwa1JVApgIJ7nwWyNMYInWj8U/K8UJVRrWdXuVYICbg7q3np
         K4JPzH9mcLgqnO99FuwDD1pXhNlqEE37Sz/qHDfWQPkjU3DuGUeZNF46WmNv/GSiYICc
         FsBMZZsDSAV8b/Du6JaSbKWipWaTlgpvsOJfPyGZZ+gRaLI/NxVIFveI5/l+kGH+YH5B
         zvGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKhEeM0l1xdTXFIr0ujXsRukk3Fz/OKSm2flGp5bVMOxY8rclu1Pp5M6EvtPZa9GODGJPeuLo9BCAaqfCCOXNvmbor78jiBTgFM+Or4BII4Um7nBigo5efgCrygTmBNEd3adac
X-Gm-Message-State: AOJu0Yzfbg7Efdax6snobG/xo8bkhNsHmIp0a2mx98UCyNgiJIwIP36m
	YJ/JRVL+fFRuS0+6eIe6W6p01HJ43B9fTKnrrOIUMRYuWIYieiCV
X-Google-Smtp-Source: AGHT+IGvvtB311ZhJD2F7yqS1jaordKewugWpMML8evIW0pEHeWIVjmqSJjSgC7o6ewbFaPXYWbpQQ==
X-Received: by 2002:a5d:5487:0:b0:33d:3ee3:cc0c with SMTP id h7-20020a5d5487000000b0033d3ee3cc0cmr1403020wrv.48.1708282845633;
        Sun, 18 Feb 2024 11:00:45 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id m15-20020a056000008f00b0033b728190c1sm8115762wrx.79.2024.02.18.11.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 11:00:45 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Robert Marko <robimarko@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Puneet Gupta <puneet.gupta@amd.com>,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Umang Jain <umang.jain@ideasonboard.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next RFC PATCH 2/6] net: phy: fill phy_id with C45 PHY
Date: Sun, 18 Feb 2024 20:00:28 +0100
Message-ID: <20240218190034.15447-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240218190034.15447-1-ansuelsmth@gmail.com>
References: <20240218190034.15447-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With C45 PHYs that provide PHY ID in C45 Package regs, PHY device
phy_id is not filled.

Correctly fill .phy_id from matching dev_id or phy_driver info.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phy_device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 9b96357e4de8..60a60f182729 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3476,6 +3476,10 @@ static int phy_probe(struct device *dev)
 		phy_dev_id->phy_id_mask = phydrv->phy_id_mask;
 	}
 
+	/* Fill PHY ID with dev_id if empty and PHY is C45 */
+	if (!phydev->phy_id && phydev->is_c45)
+		phydev->phy_id = phy_dev_id->phy_id;
+
 	/* Disable the interrupt if the PHY doesn't support it
 	 * but the interrupt is still a valid one
 	 */
-- 
2.43.0


