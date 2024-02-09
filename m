Return-Path: <linux-kernel+bounces-59707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D51784FABD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F69F1C21812
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43E97EEEF;
	Fri,  9 Feb 2024 17:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b="z0og/ach"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD957BAE4
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 17:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707498713; cv=none; b=SNFYzfc1JETHbHmSqyQY30A0D9vQlumK3Fr7DhUqSxaBbgE6qR8npjJq7h+gI1wXplcLJ3lbqciBkIu2wiKjJiAb/cbi0iZMotHyCL0JBGrGLIWmyKVsWMEb2ksROjAW0scvmKBBkHfuC8W5WAXW948UEooI6jrxs++i1LAvGGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707498713; c=relaxed/simple;
	bh=pU444VR2MwBF7EKORvFSL5kRdlp16m+GcFlxgCwXC3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q2x9Plm3ys9ySEVoGcj0rs1kRoKfqhLEjAQ/+YWJgNQRqU961Kn5WXdK2jwiFoA+HOLyu6b6QUBF+fLbEdkIMwLGn2bcVEUJhxMEJp1AJg2WJdN6IpS4lor6zXKTN3d6PAEYdglxS+A2y1mTuOGQ4TfrQB/gReYQxsJ0KNH3fWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b=z0og/ach; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4101565d20bso10775805e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 09:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1707498710; x=1708103510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+dMezPy7Z8IlkSblQ1TNf+lGFLcC7KJPcuNV88kKu60=;
        b=z0og/achpH6L6DdWgxLTQV9yUh7BAb8TrkgNloNtOogjBReubWe5lGvQnj/3aUxNSk
         iQdj0oWvKIYasUXBKezOUn2eE1FgF/0UsRbL5sQk4fxPjOXmnGblnWiiC6suDRcj0pq2
         itMlvjXDfQr15abeWT1anza/QtRxQsjYCcEt9UYNma9BOIVIP+aTygvEev6lxvTkFXOo
         EhqTZOwWVmDoMF5yJW1AAnUcXBIFZYVnHdq7uMiAAGCXhYMqpGO79lclcIGNuSNLZjmi
         x5LC4KM7CoYB0joVKmA4YpOoOnc4oHFxdm/quu8BK/qepfs4rD75J95ayWkGK8sUf4fF
         ZGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707498710; x=1708103510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+dMezPy7Z8IlkSblQ1TNf+lGFLcC7KJPcuNV88kKu60=;
        b=mjZ2N4S/GJa1/gfJ48VQA+UzE3UM07oyGB5AJAP8K44G1eiM8cw1VtCfiLqWa5xFOR
         d7Es6dkffRt8Hn7GwsjAktjVBmo3KaFLyCIYanFYr2Rj3eM9buOr6JsHzFZkgLzKnNCu
         2USs6Xdo7RfnyJ68Bs33sFZiwZpc/x5l4LOxmfFrmOTrF0jRbwTbhQrS538thu6Fne9o
         P/b36QbAjREOdcMoB4H48Qe8ad+xUL3xRajhKjMxfHjE5p4TGQeP1Ib4IozWRwzlXjD3
         VSCd9iPFkA5uWqN7rRpBMcc4EbtGx85PgA71RRI0U+CTeJtf8bcFCpq8AfvWaDWxZ6rk
         mYWQ==
X-Gm-Message-State: AOJu0YzgL+7mtXmET9Chl1ZDSuflmU0wpE/arFKJ504DtQskcRmTK07a
	48p4Byav/VZXbhiWn9mSJx+YDFY3WeGtWgj9P5+o/77GLtFU/ugwg0LiaY56gEas625OyeqQW4q
	P
X-Google-Smtp-Source: AGHT+IEynWPshXsRwRlkf4uRadX5FfqUMljHK7RezRibLJLz3N8KjLbFaJz1AGuMHemYdr4hQyVyAw==
X-Received: by 2002:a05:600c:4511:b0:40f:d280:612f with SMTP id t17-20020a05600c451100b0040fd280612fmr1641979wmo.30.1707498710188;
        Fri, 09 Feb 2024 09:11:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX3JjG5yMWZfol2W5d7LuIwSoIC008nDdNGToBntF1qg8FMA/ghJ1fUdfVD8KRYhUo5xZ7NMMGYI4hRsO+beylB2CHemQVYHglpb19g2bLNmUdInSZyKKV1OSluU7KqVcduv4zP9fjALlLCXRsxam9Gd81CP9Yd5Ht4rIduDmvzXWyhvSh6QJ8TevAU0Lsqq88X/ZFoWQtaS2/Ry96/PMznCmHcowoGLNxNoZWtovrP1WulYcjKi8nUDeHHMUdDR7vs7leA8fNZWEqrQcAVaLcsIxVgahkks2tvVqsTvVjpMH9phZobCRURxSliYfrnAYEdMX2wRyZ9voMpq5L+
Received: from P-NTS-Evian.home (2a01cb05945b7e009bdc688723a24f31.ipv6.abo.wanadoo.fr. [2a01:cb05:945b:7e00:9bdc:6887:23a2:4f31])
        by smtp.gmail.com with ESMTPSA id a20-20020a05600c225400b004104ecb39d1sm1154711wmm.32.2024.02.09.09.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 09:11:49 -0800 (PST)
From: Romain Naour <romain.naour@smile.fr>
To: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	conor+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	kristo@kernel.org,
	vigneshr@ti.com,
	nm@ti.com
Cc: Romain Naour <romain.naour@smile.fr>,
	Neha Malcom Francis <n-francis@ti.com>
Subject: [PATCH v2 2/2] arm64: dts: ti: k3-j721e-sk: fix PMIC interrupt number
Date: Fri,  9 Feb 2024 18:11:46 +0100
Message-ID: <20240209171146.307465-2-romain.naour@smile.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209171146.307465-1-romain.naour@smile.fr>
References: <20240209171146.307465-1-romain.naour@smile.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tps659413 and tps659411 nodes set WKUP_GPIO0_7 (G28) pin as input
to be used as PMIC interrupt but uses 9 (WKUP_GPIO0_9) as
"interrupts" property.

Replace 9 by 7 for both tps659413 and tps659411 after checking in the
board schematic [1].

[1] https://www.ti.com/tool/SK-TDA4VM

Fixes: b808cef0be46 ("arm64: dts: ti: k3-j721e-sk: Add TPS6594 family PMICs")
Cc: Neha Malcom Francis <n-francis@ti.com>
Signed-off-by: Romain Naour <romain.naour@smile.fr>
---
v2: update tps659411 interrupts parameter too.
---
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
index 188dfe291a32..658764f7d544 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
@@ -574,7 +574,7 @@ tps659413: pmic@48 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pmic_irq_pins_default>;
 		interrupt-parent = <&wkup_gpio0>;
-		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
+		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
 		gpio-controller;
 		#gpio-cells = <2>;
 		ti,primary-pmic;
@@ -651,7 +651,7 @@ tps659411: pmic@4c {
 		reg = <0x4c>;
 		system-power-controller;
 		interrupt-parent = <&wkup_gpio0>;
-		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
+		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
 		gpio-controller;
 		#gpio-cells = <2>;
 		buck1234-supply = <&vsys_3v3>;
-- 
2.43.0


