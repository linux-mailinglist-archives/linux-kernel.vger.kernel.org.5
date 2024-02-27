Return-Path: <linux-kernel+bounces-82558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E4C86865C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A43391C2640C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7417510A34;
	Tue, 27 Feb 2024 01:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2Vo7eLd"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7775745036;
	Tue, 27 Feb 2024 01:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708998463; cv=none; b=g5pMAAJOqN6eDFA92syMaFVd0AzUgDr8jZuWbRu4htm4jW1Pjnuoe3w8ayBqfhdvty/+rP5r4XkLLqejlnt8I8QvGs7+Pt+nY+KsbwpkDCTrN6cw9aqdEHeSoJIVd4TAZ06rIMPM/6yAMI+K5VlCzDnJSljSKd4tYSVCqmGFi2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708998463; c=relaxed/simple;
	bh=XPSN/8fKOe9wSk+OzqVpG4SSnbM9P4l84A0yuzwgCRA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=poX30b52UYv7psiqExhYqtulJVijQqCFCNdurZylJeLxcBAhTQFEuIBtIiarn0fNvMjisZCnjNi3RNebdC2NZjTjpOPHlyidTb4pE71ueEUcSPLjcI+Z94tTdkf21rZM6DdlT6AprXDPcjnVOuTnLkrCGTJR8S5OqvXVBDH/vQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2Vo7eLd; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dc96f64c10so15625455ad.1;
        Mon, 26 Feb 2024 17:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708998462; x=1709603262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eE+ArNThktHqxq53xyc4RaWaWv+q0sBFJ+ThRmH5j0U=;
        b=Q2Vo7eLdHlq0k93X3TcthYtNDwv4D2j/oJp9Zgr2C6poVnvqXAD1Y9YB2dh5Ok0rD8
         0SP5kZWg5X1pjztxVl3ZgENZfmZd3yPI2qfYISBTJO2/bHYevSIrjIAJqrPbrpA4LyJO
         snjyFFYiUo9qluJ2CJTaGWr78C3T9meZhoQ6vn1apUrTMEGZVoq6DYxBvceqbG3KiOtp
         UJCmMiWTTo6Hq8N3qnVd5wXpzjUIpgsa8nAcQ8BdbFT8WVrkRu6ZUEn3Pw4Idwa4vCOc
         ZAgaw+rZ9K75gB03XtJamfjrNxxRIh/F885jE4Ih/bq8OsuiQbPDYajtrrGMJssFIDpV
         SicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708998462; x=1709603262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eE+ArNThktHqxq53xyc4RaWaWv+q0sBFJ+ThRmH5j0U=;
        b=Xyi2P33cwhFARG/AWHAncCNXa2DDDdDucjlKwzQroa0OhsoAiiQGn0DArNV2N+nQ+7
         TEH1qrHvidrLStLwo1XKBAEzFBCPHE56Us6S1JfSP3kWqAXwihZooMVkf9UpLGD9yB51
         lEbwvqqKOOehrSpeIWDp7Y2GJZIGgo2MWloM4PrM9pYFpZFnjZwCKYGZhP0nzyYLZdyO
         jkt3ZyPfSKf7fh88/HTOmdgWZuWVBerdgJBTOlRIplhdEMHAQPtt8asHch89dVgws4iz
         j2maZT9w46sZaeKXyXLHdmEv8C3Ikvu1NYYAH+coKAI4w4ldOKtbzNV5FwHVZzmio+vE
         rGvw==
X-Forwarded-Encrypted: i=1; AJvYcCXfd24kmdVe5BMDraDHT4yrAaoCr3HbuZOHOobct30jcA79RhWh6Kx0Myecj/USyeniGcjLoOfclK2NfdrZDKHZ4ruAeLdoSYR9cWIi9BDWeJERE8aS7NITEljaYu+L0wfUMDpEzO4PqA==
X-Gm-Message-State: AOJu0YyruQgGH5/OGLigX7pepixZv7G/RDN0AnnS616Q7yXyIhHaLwyc
	+k5cyh7jpIPjVbDYCKqwrx+2+qZruwtjJeIC/Csm0d3ZJFYRBuac
X-Google-Smtp-Source: AGHT+IGUkrUYzuWekhnfwHEaJElaB5YlO8KX43Tz0JCPBvqLuayKsT3ekwmZgSKD3IxpMHae2CmDbg==
X-Received: by 2002:a17:902:6e10:b0:1dc:6152:7c24 with SMTP id u16-20020a1709026e1000b001dc61527c24mr6961774plk.43.1708998461762;
        Mon, 26 Feb 2024 17:47:41 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e381-af24-f369-7cbc-56bf-1d54.emome-ip6.hinet.net. [2001:b400:e381:af24:f369:7cbc:56bf:1d54])
        by smtp.gmail.com with ESMTPSA id kl14-20020a170903074e00b001db4b3769f6sm318893plb.280.2024.02.26.17.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 17:47:41 -0800 (PST)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@aj.id.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 06/10] ARM: dts: aspeed: Harma: Add PDB temperature
Date: Tue, 27 Feb 2024 09:47:15 +0800
Message-Id: <20240227014719.3037588-7-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240227014719.3037588-1-peteryin.openbmc@gmail.com>
References: <20240227014719.3037588-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add PDB temperature sensor.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index ca3052cce0e0..5c3fa8bbaced 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -203,7 +203,7 @@ max31790@30{
 &i2c1 {
 	status = "okay";
 
-	tmp75@4b {
+	temperature-sensor@4b {
 		compatible = "ti,tmp75";
 		reg = <0x4b>;
 	};
@@ -260,6 +260,11 @@ delta_brick@69 {
 		compatible = "pmbus";
 		reg = <0x69>;
 	};
+
+	temperature-sensor@49 {
+		compatible = "ti,tmp75";
+		reg = <0x49>;
+	};
 };
 
 &i2c5 {
-- 
2.25.1


