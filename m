Return-Path: <linux-kernel+bounces-82562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71590868664
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94A081C26B8B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1744255C1B;
	Tue, 27 Feb 2024 01:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmf8mgKp"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237BD55775;
	Tue, 27 Feb 2024 01:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708998475; cv=none; b=bCU74ajuBgnyZFZX/CtP529c2En6v+dwzKjOFWSBjj2XnBt2u/atRp7OeJDA6ZE1QNVsOylftBXq937iOcNE/6t2MyP64V6tqjskD4tWvLM8FPJz1/kTo1Y9DVdoJCNduEKgLfIfbSdtQQ4esTDjXEZGEJ1xAK19Vpweoy6rICU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708998475; c=relaxed/simple;
	bh=X0UY5Fy16i6PgOrRoeHTZtsituUOV5zLRDOsElqb+1M=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n90e6fHR+rfoAwr94MaCAJK9ENqkHiqUUdhyjH1BEO9UMNRpcp+KJRwahOtvHsDghSQD079JsnYqvW+cVS37YhGb0Oq7+VQTARuCR5ylWl3Ok7IExF8wot2T/bPM12wQqg/ygLSVpxiod7MHNIpanzEG/LTRFOIHJo2o4Y5kGmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gmf8mgKp; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dc139ed11fso25385015ad.0;
        Mon, 26 Feb 2024 17:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708998473; x=1709603273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xrsvdI1lEYG0uIgU/VTd61D6Q1rZXhoZ89VFb5WgrsQ=;
        b=gmf8mgKp+ZYnmqaHAH32N9omZhi/egDvXIz6NeM7pYXmZQ+8ZT3MbDCkqB7PevSfcW
         sFEMYLeclh+pgNmF6cYGbBoUIaiW+CHjdfq6tOtAKDLWtwVmVAuC/KL0NgSYmDi23Znz
         jjKwqV1OzEGFrIbyNQNZ/TwEndgTDrFao3YLAY5/+HOPAIauu4QUJXjEmHp8WFZ42ckG
         Tu1Os6VUOKfISmApwteKPcTgP/RFUFV37FJEZpTdRER2j7hBXAbhKv2/RdY9x7I/cXJh
         srYHa1BPgvF1QlBkI+8hFuY/EKIcM5mPCUxJVYDH6E/1qCnuVGUHKTkgNMtxtUsvvWQE
         cfBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708998473; x=1709603273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xrsvdI1lEYG0uIgU/VTd61D6Q1rZXhoZ89VFb5WgrsQ=;
        b=O8nphrH4m3atEdHIeceHsIySmKmZOYSbg/62RBTedeuz48Fm1imi3l21u9BfQe+nDy
         tDA2FmOy2FTsOIReQ7F6ntysz9F7jN5UF74xwOiZuk3WiAR2vpmAizVp7fnWZF4oKkZh
         XueJhwdmmn4Vfu2raQEzg6SqPst/zhDcWw1jObGQCuMO9x/FBPrTVYD2Xw+obPfdv1XB
         n6KVGFRiMMKd4qMcte3vGJdnq0ifmflW2/4wAmKX2OyYJ3aiqSqUk0/T3gon0HfMNoPZ
         0ixpu0lg/B9Tt/oI0Nb23AuhHAtRcHsrOzyN1YQSwJLOvxfdWTgdtBfnYJR5XagtV70/
         rGOw==
X-Forwarded-Encrypted: i=1; AJvYcCV8FiPpBoWWh1PQHXbQtm68+gIR/wj3iK7ZiYJ3PNuNkyQTzOO3Kowmy4UrGaS261I8/H5Ty4YA5s+lXbZuxJ6UA1B6lBwtxf+jsYi0G9lWMteL7mn0Nanb13rW3jQClMwpitMRyKAZTQ==
X-Gm-Message-State: AOJu0YxeUMQ3qhu6Ki4VtKSYSZECoxqoJGo+oVkTgKigahdpaxwFzixV
	H0LbYDvZdWXCVkwJ+q35JL22IcEoKWkblDX6+5G4f/qhkmkJkbld
X-Google-Smtp-Source: AGHT+IH1epM57xXjOkh3hVvEgpaSGXhUd8RokuHIrZStTeRvVbdlTK3D3B+Zt3WIw8AxLNLwL73gNw==
X-Received: by 2002:a17:902:c946:b0:1dc:8546:1584 with SMTP id i6-20020a170902c94600b001dc85461584mr10319395pla.0.1708998473472;
        Mon, 26 Feb 2024 17:47:53 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e381-af24-f369-7cbc-56bf-1d54.emome-ip6.hinet.net. [2001:b400:e381:af24:f369:7cbc:56bf:1d54])
        by smtp.gmail.com with ESMTPSA id kl14-20020a170903074e00b001db4b3769f6sm318893plb.280.2024.02.26.17.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 17:47:53 -0800 (PST)
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
Subject: [PATCH v4 10/10] ARM: dts: aspeed: Harma: Revise node name
Date: Tue, 27 Feb 2024 09:47:19 +0800
Message-Id: <20240227014719.3037588-11-peteryin.openbmc@gmail.com>
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

Revise max31790 and delta_brick node name.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 7dd48c384a4d..530f69005857 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -192,7 +192,7 @@ &kcs3 {
 &i2c0 {
 	status = "okay";
 
-	max31790@5e{
+	pwm@5e{
 		compatible = "max31790";
 		reg = <0x5e>;
 		#address-cells = <1>;
@@ -218,7 +218,7 @@ eeprom@50 {
 &i2c2 {
 	status = "okay";
 
-	max31790@5e{
+	pwm@5e{
 		compatible = "max31790";
 		reg = <0x5e>;
 		#address-cells = <1>;
@@ -262,7 +262,7 @@ eeprom@52 {
 		reg = <0x52>;
 	};
 
-	delta_brick@69 {
+	power-monitor@69 {
 		compatible = "pmbus";
 		reg = <0x69>;
 	};
-- 
2.25.1


