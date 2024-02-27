Return-Path: <linux-kernel+bounces-83589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE427869BF0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C4281C2087C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838BF149E04;
	Tue, 27 Feb 2024 16:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvcvmJCd"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2881487E0;
	Tue, 27 Feb 2024 16:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709050840; cv=none; b=HAGJPHr5p82528JTZ5iAh0xdUn03wgXDPGBWLkVAGt5dMKdY5GpqJ59CJQIkc09BrrS1CxjKClKf+yo2SCogOufJoB/spimKxaR3nshXjvkf0A90oTv46Y6UrC614Xur7Ul3N3zqsW/YKx94qAwzDFhJdCOerCZW+P04ihquixM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709050840; c=relaxed/simple;
	bh=VWJnljO5roj8jgQx0F8UPygZZWNqRqDHuffrxf6uMJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VUO+X/3gpE37pIFo/SLLQV61ojeNFqiRDVHzZB3bZkrJandCba7oPBt/ZpeUDZl3PSYfWkHJGQxbVb0Yd7e0JoxSignXquT0za88cu+6dt4DaB6/wlS0z79f0eswaHQ3y0DwmQKAU7Zj4+2C6CQD3xqNM/O5+tyu/j482o4RvSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MvcvmJCd; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a293f2280c7so678158066b.1;
        Tue, 27 Feb 2024 08:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709050837; x=1709655637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Azg6H0FwOctwfvAjeTgtmxVXq63+kkt8Z6mGZ51a5Cc=;
        b=MvcvmJCdAfeSeN2EIpR87kU4wP1mJ9aPu196RqYz0IkzCOer8AEXZB0Eu4wmq5nlz4
         xbUXn9q6RTJLKyIloaptzqrfu3YHbiRHIRFNlegP+jUeoPP4+emAwt85Jrs8/8MBa2vx
         MglWPGqrxMnme4cKLK4BREh/6roPVW2g3e86Pcf/6OBy1zZ4/Q8WMxmsajCmMDvTEdcU
         49xPffFDBBYBByLOYoocQPZwMfdY521tqRWH3ealRN2Bk33+SVtYGc6yffb5+llHJ8p7
         8Os5ZKbPn98jGG42Q850IivAAvNp7gegjzb0ADQcjv+P/cENetC7zNwMCUsAbBQ0TnBM
         FSQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709050837; x=1709655637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Azg6H0FwOctwfvAjeTgtmxVXq63+kkt8Z6mGZ51a5Cc=;
        b=hVuRm4A00EUT5txkxFiySKvFU8JeGANRo2G/l+4TgOpW+IOU3iYP8BcFumf6VhpY6W
         HlqGYZ/ghmHcGSTtFL6mH8gpG9yrhliig2ihoOsO8W9BpOstAxVxWMRq0rZQWNZXwCQa
         Ygs42HHq7Re8RIKPbdLKrilMQzMFOXbbq0veeuXGkX+PzdJFvNcSBZ+//kdli+Z9wmzD
         L3v1d8FDnm+AFFGCHRmLa54REPfLuhl118blcbjybdZIhym7mTAqDwemvkzkvOW32DA+
         t4wuKrdrfcV4onazA3HLrwL4qbbRtAh78c8Gh1iauppIn+GI/VdttGjV0xTLaVOuzCnf
         RWQw==
X-Forwarded-Encrypted: i=1; AJvYcCV8O1qwB/bjCrSCdBm0S082GlMgW8aUF3AM+sVxxrzYz9SC0n19+1sBLMt1NGx0fcWn1G/7fJCdOlyktZVC/KbM2JqxnvgzyYR2xAb/Aaxxtk7tepfK1jj4ep7bXAOu8w4ebuBWFzEe062prZWff67UfEjotcPxN7hxEXR5b9w9a0ym4Q==
X-Gm-Message-State: AOJu0YyK10+ehA9BKpjAqzeaXrzQ1mpiwEdhP5BfMkIbfEKM6Ie2OIoD
	IJ9aMaH8BN+5k8quZUthmZTAvIkb812ghmyvs0GUMm4xLeqeLiJM
X-Google-Smtp-Source: AGHT+IF+TlKW6J/+J0lHc8CKuUmEDfhVXbMwNHUYkfNX+BtCQjj+whPWY++yKwPNKePOTIHHAPtzug==
X-Received: by 2002:a17:906:1818:b0:a3f:9629:d305 with SMTP id v24-20020a170906181800b00a3f9629d305mr6688585eje.28.1709050837616;
        Tue, 27 Feb 2024 08:20:37 -0800 (PST)
Received: from fedora.. (cpe-109-60-83-139.zg3.cable.xnet.hr. [109.60.83.139])
        by smtp.googlemail.com with ESMTPSA id tb25-20020a1709078b9900b00a43df459013sm107570ejc.131.2024.02.27.08.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 08:20:37 -0800 (PST)
From: Robert Marko <robimarko@gmail.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	andersson@kernel.org,
	konrad.dybcio@linaro.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ansuelsmth@gmail.com
Cc: Robert Marko <robimarko@gmail.com>
Subject: [PATCH net-next 2/2] net: phy: qcom: qca808x: fill in possible_interfaces
Date: Tue, 27 Feb 2024 17:19:29 +0100
Message-ID: <20240227162030.2728618-3-robimarko@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240227162030.2728618-1-robimarko@gmail.com>
References: <20240227162030.2728618-1-robimarko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently QCA808x driver does not fill the possible_interfaces.
2.5G QCA808x support SGMII and 2500Base-X while 1G model only supports
SGMII, so fill the possible_interfaces accordingly.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/net/phy/qcom/qca808x.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/phy/qcom/qca808x.c b/drivers/net/phy/qcom/qca808x.c
index 16c94e77646f..bd36f5b90391 100644
--- a/drivers/net/phy/qcom/qca808x.c
+++ b/drivers/net/phy/qcom/qca808x.c
@@ -170,6 +170,16 @@ static bool qca808x_is_1g_only(struct phy_device *phydev)
 		return false;
 }
 
+static void qca808x_fill_possible_interfaces(struct phy_device *phydev)
+{
+	unsigned long *possible = phydev->possible_interfaces;
+
+	__set_bit(PHY_INTERFACE_MODE_SGMII, possible);
+
+	if (!qca808x_is_1g_only(phydev))
+		__set_bit(PHY_INTERFACE_MODE_2500BASEX, possible);
+}
+
 static int qca808x_probe(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
@@ -234,6 +244,8 @@ static int qca808x_config_init(struct phy_device *phydev)
 		}
 	}
 
+	qca808x_fill_possible_interfaces(phydev);
+
 	/* Configure adc threshold as 100mv for the link 10M */
 	return at803x_debug_reg_mask(phydev, QCA808X_PHY_DEBUG_ADC_THRESHOLD,
 				     QCA808X_ADC_THRESHOLD_MASK,
-- 
2.43.2


