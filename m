Return-Path: <linux-kernel+bounces-119249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C97B088C624
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64D781F65CCA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE22613C67C;
	Tue, 26 Mar 2024 15:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjU4W7wx"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E477613C83A;
	Tue, 26 Mar 2024 15:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711465241; cv=none; b=p5f50SVApDewA0N/gt3TaksJYPbx/pdFaJ8wJtrzUiOj6UKggD97deHct5kyRkdB1t/y3/PMMZgV05Y3FSHst7s7jNMPvX4P6wJuVICPj3oQrnENBj8kyfCWuC+0jktAw4itowxzoD5DOQkMWwLHInWV+zrew9uIcUcI9zKJ8+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711465241; c=relaxed/simple;
	bh=i2IRRjTZyiYex34MyWLMNAUhtzs5XV3CN9xcafzB4wU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T7osnzqbJvoEaFmovetjlk6OYn1geB8X5y97XAqqi3nxo76S1lU+TGJJBqCEMwKL1HCJGNFenRr61bSle/IrCE5LRGR15Snpm1+4S4Ae4lAaoVm0U0yzOXKb5BG44NK0AJtH1jegnhU0jSJbHGCAnqFOvUa0p10S5yd5kKEnTCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FjU4W7wx; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e6ee9e3cffso3887821b3a.1;
        Tue, 26 Mar 2024 08:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711465239; x=1712070039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=axYCeiGWmH5zGIGoROlm87X0Iv4FCoHgVdnjtyDTc9Q=;
        b=FjU4W7wxr07abBFfNBohDfZ+Q7A9/tlO1W/VwuLFqrwmfsTlDrVDMsHWuhhc9mzsKh
         WJu4j7LXuWsYiTaI8ItPmYMGntaouRJy+w9WhFf1uEbOHOJqk+I/4KrmTvlZko3xSNVE
         E2c9ojBGjQKdwJn5ADLEDHsRQWjpA2BICPXlE9N8qQXftO22e5K+US1gmjfFv12DYJt/
         4rKIbtT2Cvf3JZasQa6jl5JVSPBXZwq6/mevS3r9PEUzpnoTAgPHwBdFGrpZylTneS8E
         6ov4XBuvPM36JP/hM3j/PphT5v7pZ2Ee42guhiz20NxoGy2Y1tHCjgJY0wT297eQbWmM
         CnrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711465239; x=1712070039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=axYCeiGWmH5zGIGoROlm87X0Iv4FCoHgVdnjtyDTc9Q=;
        b=pELer4G0oQ/20RDFTxyMaYhPRLPG1IMrCt/rV/pgouMs+MzkHV/X3OIjiY4tmhurA4
         VhKxDNnHKBa0qAwvnfhHgumpIJ2c9c+/Fs6wwVx4PDH0ujA0NHwOS+kmNYmhcPv9zLJd
         79WkUZ7QuX3Xk9kbjy8OQn7BgYB+rHrnGqKZ2RF9p56ZF526UhANZq/VuW3v+TnhiG9h
         14c/0Du4zMZvFpPwKtR3KUe5vEkmzEEmDrrpGRuk5uNGnn+WkGKuxR4QKTFXrA/CZQpN
         o4UaHu0hGfzNRVxGGZGI3EeUQ4Oc+rW+GhjKtxksZRz6Bk/zWjhxeb4R9dZ0HQ61b25J
         JAnQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8wa5xB6d6cypZb3Pw5B84byNOxEHd2mc3xMVqPM5OpvLHHmLQ4PFV8hpLBqTTqBjlZgZKITysb7ICeH4cfA3mtS2fuVgiarFfS0KAeoKfIeYOzj+3npWulnotXspz1MOz7FWwlBV6NyuIkU0KEYxQW8+HBYz8MQjh4cxCqNrs67tUECu90dba
X-Gm-Message-State: AOJu0YxMluG3SnCzpPyc6MZEVHO1dJvpuWEcY+NdGzASPJ4mX2iwOibm
	MBRtGh8tdj0/Tik2BStuy9qpX6tEYcU6jDy1oY529VrwXHlVDAjT
X-Google-Smtp-Source: AGHT+IF0agEOL3Fig3++nGEEQ7VbXvH89pPROnJTx7czX7BhvNTMXX3BGpNPSZ/xbiPnOM52Kd7b+g==
X-Received: by 2002:a05:6a20:958b:b0:1a3:dd51:1922 with SMTP id iu11-20020a056a20958b00b001a3dd511922mr1436278pzb.7.1711465239120;
        Tue, 26 Mar 2024 08:00:39 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id l27-20020a635b5b000000b005dcbb855530sm7658404pgm.76.2024.03.26.08.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 08:00:38 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] ARM: dts: aspeed: Add the AST2500 WDT with SCU register
Date: Tue, 26 Mar 2024 23:00:24 +0800
Message-Id: <20240326150027.3015958-2-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240326150027.3015958-1-peteryin.openbmc@gmail.com>
References: <20240326150027.3015958-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AST2500 WDT references the System Control Unit
register for its operation.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g5.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
index 04f98d1dbb97..5fd12c057c31 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
@@ -410,12 +410,14 @@ wdt1: watchdog@1e785000 {
 				compatible = "aspeed,ast2500-wdt";
 				reg = <0x1e785000 0x20>;
 				clocks = <&syscon ASPEED_CLK_APB>;
+				aspeed,scu = <&syscon>;
 			};
 
 			wdt2: watchdog@1e785020 {
 				compatible = "aspeed,ast2500-wdt";
 				reg = <0x1e785020 0x20>;
 				clocks = <&syscon ASPEED_CLK_APB>;
+				aspeed,scu = <&syscon>;
 			};
 
 			wdt3: watchdog@1e785040 {
@@ -423,6 +425,7 @@ wdt3: watchdog@1e785040 {
 				reg = <0x1e785040 0x20>;
 				clocks = <&syscon ASPEED_CLK_APB>;
 				status = "disabled";
+				aspeed,scu = <&syscon>;
 			};
 
 			pwm_tacho: pwm-tacho-controller@1e786000 {
-- 
2.25.1


