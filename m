Return-Path: <linux-kernel+bounces-58719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF76D84EA71
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B933282EC2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 21:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386264F8AC;
	Thu,  8 Feb 2024 21:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b="RmTV4/cP"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150B84F1E8
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 21:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707427491; cv=none; b=Aj6qYxmlYWU84Q9USbY1HrPi+fe0zJIJL4i17NnIwC4D+QmuNJ9us2CjG9VyuePXVyiJjkcpQGEoOy6VsUEgkwSBe8UUMow7W9CfFmt0C1XV82+qsf8l6kBDOSxpG1XgSuHaCYOsMQJhVvSoKg90p9txSHl1SsJkik5vRhCfPPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707427491; c=relaxed/simple;
	bh=Bjsp+KZtyL8O80qh9O9Z57mm54YKxPF3W3gwM9bSRzs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jWeXiKZTjaN4lawR7INvfbUgc4n7x2uZCWRkwc/XAOHg2drRT9cAUp6ti+USDNm9RfGawgVpqobDupL9yMlyt0brZfYGr/aqJ9RVST3GoMJfkmO8J/B/3BNsgX09VC0s5eE5gSKfPg5CPsdj2AHGEzQFd4fTr00AoaFQzWjzSiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b=RmTV4/cP; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33b2960ff60so826377f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 13:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1707427486; x=1708032286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ue3Hv5Tp9scHSTy47Ds5eoq01BRybMaUAWCl5QsfxDE=;
        b=RmTV4/cPY9B4pJbvERfOm8xMTHvqQyul3UIKMTnpCyBMObx+w+ujJal6PfOHt97ksg
         cJJpO12nIGStey7m2F0/bpmdLQu0Je/SbOJlSM1S9ZpzcaRsdiug/QvlbVL7Bsv1u2du
         BD1J6sHpfKLTblJK7nULgPUpkWSNII2BmxpdLvATNieSmcxYkIANeu23eyUEzFVBuZfD
         aB5CDmUeBMP33+kySp7q3z+oFMzECK77RMzlgliCZYma7cuJ1XIV437WPrDgke1r4Hhd
         6oo0bhb7AkfC5aA2tVVjuSPeUazUwveBwPxMdpJovowSL7IwjfHIT9ItzR8/SptzemFg
         eENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707427486; x=1708032286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ue3Hv5Tp9scHSTy47Ds5eoq01BRybMaUAWCl5QsfxDE=;
        b=O+h5o+dkVaWFDM90b8mJ8X+aAqsx/AImB06AkbqSXsnAtwHHSZrCijrLWUcO5v4/w0
         NYsBZJjq1tl8PhFUj6koniU0cARMfU48Q/4YNDz8KKA1QW8JYz5WVC57va6Noz3y075V
         nAJUvUKt6Q6dKqHraIO0xezifixEzjWGO0ciqYzP75ElTklerFslLGcJrW49pHwotd+n
         HhhmDJ+zjIpci6I9tqkMp4y8D6nqpQCThmsOQSyWoV63Tv1ZOQKg5SRVuttxJWfZWrU6
         3Pr+cvlZPsWETqHZoUD/QNKTw7Za9sV8S6dAaninjF5fGTV/o3LR7MOylNzqqRegZEd4
         gtQw==
X-Gm-Message-State: AOJu0YyYllNjO7F2NUAYPApFPSly9W+7S4wz+8faivvj6FGWtUF/MFNX
	HGi3T+r3zAqeB6fgxqd5bcJmIqeHTWib87Wwt2wm6+5Xxvk3kVFRz4g2Kka8el4nFaCr6xPyGku
	N
X-Google-Smtp-Source: AGHT+IEvfGlve63gugRzGCdewUU1Q9SjV28hrhTqbwiN23IJqj3Jpckw6XciNmP2H+uqsNHmTASxsg==
X-Received: by 2002:a5d:62c4:0:b0:33b:3c97:b4b1 with SMTP id o4-20020a5d62c4000000b0033b3c97b4b1mr553797wrv.15.1707427486146;
        Thu, 08 Feb 2024 13:24:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXh3K2bsuSwpkElhnbrJDcTvK5Iz1X+GamWvtivXCO7NT78ivnWDiWl3FbUmfFUrvU8mDR+FlI0/Kj9yzvLZ2eJ8ziT7g0s0FhJJe5AYtORrSh37sz3HJYKGeKI/6xr2PE0p5XiL8RwNSRaROWF2eoRV+twcT30lpipb/CNCvFBV1g6wDjZgA6kTc22a//L1Q83+dS5lGkXG9P69RrnERwfc3ipXird2sv70Va3TJYhIC/urY+XItIEngGGHP4z00z2V+5nS2cXiTnvrojOc4UCZ26GwUmATjlAHHtt2DppeiL0goD+rvQUY3Lv0BKqGEdVMjLLF5vaRnIHjtKR
Received: from P-NTS-Evian.home (2a01cb05945b7e009bdc688723a24f31.ipv6.abo.wanadoo.fr. [2a01:cb05:945b:7e00:9bdc:6887:23a2:4f31])
        by smtp.gmail.com with ESMTPSA id bk27-20020a0560001d9b00b0033b55661f32sm228721wrb.9.2024.02.08.13.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 13:24:45 -0800 (PST)
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
Subject: [PATCH 1/2] arm64: dts: ti: k3-am69-sk: fix PMIC interrupt number
Date: Thu,  8 Feb 2024 22:24:21 +0100
Message-ID: <20240208212422.213693-1-romain.naour@smile.fr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tps659413 node set WKUP_GPIO0_83 (AA37) pin as input to be used as
PMIC interrupt but uses 39 (WKUP_GPIO0_39) as "interrupts" property.

Replace 39 by 83 after checking in the board schematic [1].

[1] https://www.ti.com/tool/SK-AM69

Fixes: 865a1593bf99 ("arm64: dts: ti: k3-am69-sk: Add support for TPS6594 PMIC")
Cc: Neha Malcom Francis <n-francis@ti.com>
Signed-off-by: Romain Naour <romain.naour@smile.fr>
---
 arch/arm64/boot/dts/ti/k3-am69-sk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
index 8da591579868..95c9d3da59d3 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
@@ -646,7 +646,7 @@ tps659413: pmic@48 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pmic_irq_pins_default>;
 		interrupt-parent = <&wkup_gpio0>;
-		interrupts = <39 IRQ_TYPE_EDGE_FALLING>;
+		interrupts = <83 IRQ_TYPE_EDGE_FALLING>;
 		gpio-controller;
 		#gpio-cells = <2>;
 		ti,primary-pmic;
-- 
2.43.0


