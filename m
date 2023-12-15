Return-Path: <linux-kernel+bounces-986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA06F8148DE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18DDC1C23AB1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE202DB80;
	Fri, 15 Dec 2023 13:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCyTOKhE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA61347BB;
	Fri, 15 Dec 2023 13:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40c580ba223so7859215e9.3;
        Fri, 15 Dec 2023 05:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702646141; x=1703250941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iioDY7je2sF6fbSitgQ396/5pChLBrfWf7mOLks6Yho=;
        b=ZCyTOKhE0KwYiedZI6dbSYo52ZaISBE9ABpD706skGS+98cM6Ah2e7bcr6ARiVas8O
         2adUzumroQhPSd0ZzWVrrU7t7YpdQSHtM38FIbExs05auT85O+gMbTEAzYr1/7j59UBo
         hP+2OZWTNJBv4fFGK3ZRMVAzyDfvvtPpQ59JzQiwKd7whOTzQPCXMfcMKJNABXiVF0U2
         wNn4gwgYzmPvKAtZ0P6UK+THflAqljMe6m7nUFyIXaCE4vY8+FRV699YHhv6pKLLDSck
         S1yb0TAdvq9VfrOrnvI8aIZ0dkyEvJF1ywJDXrNtwVGf5uKeg/ENXORI/PK6dszDTnHh
         AdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702646141; x=1703250941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iioDY7je2sF6fbSitgQ396/5pChLBrfWf7mOLks6Yho=;
        b=dtyjqpHWWhl7z/N0q/1jEydqFV2r2qPblOUOdajIoZ/a72IVkzXu8+4Z/oKh/EyqQt
         3SfpO1Yp/8D5ZYyLn7cSsWvhXIFXrca2C0yx7465ShjGKioL1THe8JqLjqBSRksCEOO7
         5aUOzM+vaiJnq1j8Wx74dLOqRSUpA1fvLuMxrz7DV7tYJhtzCyzS/i9I3PemtTfjlSZx
         mbTCVUOl6KcDAbFinVVAb8SZ9fvBbJL/Z58LqkjlzJQOXJGeTzy66wlAHuq18aTYKljo
         4yEjr492llCTwl+9C4UZP2tkjHowMWx8R6WKq32jyCb1VRmIgRxhzOjkOmKqyQ+oWjUu
         DrdQ==
X-Gm-Message-State: AOJu0YzoRjG/Jxy61OmoSPuf495rHL8imWNo9Q1pPoxF7VIhjNCuVCyD
	nlid8QxXSN/cwjFpxOiMf2g=
X-Google-Smtp-Source: AGHT+IGJCc5NWUcC+ZTn2Zrb75hqVJTfQ0bFf9TjtohNJLb0TrTcSIEl4CTj4UVoGQG9/P+mtm2z+w==
X-Received: by 2002:a05:600c:221a:b0:40c:313a:f7c0 with SMTP id z26-20020a05600c221a00b0040c313af7c0mr6920223wml.7.1702646141057;
        Fri, 15 Dec 2023 05:15:41 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id fc7-20020a05600c524700b0040c44cb251dsm21618324wmb.46.2023.12.15.05.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 05:15:40 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Epping <david.epping@missinglinkelectronics.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Harini Katakam <harini.katakam@amd.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [net-next PATCH v8 1/4] net: phy: make addr type u8 in phy_package_shared struct
Date: Fri, 15 Dec 2023 14:15:31 +0100
Message-Id: <20231215131534.7188-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231215131534.7188-1-ansuelsmth@gmail.com>
References: <20231215131534.7188-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch addr type in phy_package_shared struct to u8.

The value is already checked to be non negative and to be less than
PHY_MAX_ADDR, hence u8 is better suited than using int.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
Changes v8:
- Add Reviewed-by tag
Changes v7:
- Add this patch

 include/linux/phy.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index e5f1f41e399c..e5e29fca4d17 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -338,7 +338,7 @@ struct mdio_bus_stats {
  * phy_package_leave().
  */
 struct phy_package_shared {
-	int addr;
+	u8 addr;
 	refcount_t refcnt;
 	unsigned long flags;
 	size_t priv_size;
-- 
2.40.1


