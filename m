Return-Path: <linux-kernel+bounces-24766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E00082C21A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF1281F25499
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A736EB6C;
	Fri, 12 Jan 2024 14:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="eEUbToyn"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0D16E2B6
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 14:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a2d04888d3dso4309766b.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 06:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1705070951; x=1705675751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAtJVjLEM4PpD1LfLOq0lj7khrRF1/PVKMI6rTwwftg=;
        b=eEUbToyn+aojBH4dJXC09lvGAsPlEP/3Wu0b8Bb4bt+QTnPTD3XCVVj+Uuc20Qvsat
         dY0JXlBSTjVWfxLjJu2TmIQVQhGRinyoCjfu09ldt8lp4G+b1+bGY2kBTnCmzWi3LTK1
         t6UoaH6MitDQRq750PHJ/ipT2CTcX02TIT/zY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705070951; x=1705675751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QAtJVjLEM4PpD1LfLOq0lj7khrRF1/PVKMI6rTwwftg=;
        b=NRTFSoVUlCGxgWTxaeJvqxVlMnJ9J9jprC4MOW3zPicU7G0NbxnCaC8q3BcgM1qo9Y
         aejVtBmmnodbI7pov5lQr4p0KovIm4FjzcudgKnJcyc+q3OVFxqC+Giwz/bQcVxLHSgo
         II/A+eCwH2Xy/OcUvSSwzfxh5A2ri+Ngm2IcLrH8IJGAzRMuAuj7WgVbAktPd0bMBefI
         m9HhlLAR5Z72Y1XDOX8BDUYPX0KVN6dZxnrJ9aQV5j+D8ighPkvwzCjlJ8oxwkB+zyWT
         +RnPUn6B3Cb0Ir27+Lb/WP3LYY29/ZLkGLmMTRAJk2Ag58Dtjqf7rfNcuxdNsoGAj3gO
         iqaA==
X-Gm-Message-State: AOJu0YxMr0UEzgs8UgQuw+iqjD5Jtvm66ivYelwr8fOqPeTYFhW3JbLU
	oJtm1sah3r39V3HxdtBTCm3o+4f0YpDqdwSgPpjdu9r+3rY=
X-Google-Smtp-Source: AGHT+IGnASLVa+5h7B/dg8g2MVP/TIO2T1WEegpWrRvX6D1NsF09O7sDLnBQYxbYnr6URa2E6UrKUQ==
X-Received: by 2002:a17:906:1e89:b0:a2c:2094:5d46 with SMTP id e9-20020a1709061e8900b00a2c20945d46mr679423ejj.81.1705070951050;
        Fri, 12 Jan 2024 06:49:11 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it ([95.236.91.90])
        by smtp.gmail.com with ESMTPSA id y11-20020a170906524b00b00a233515c39esm1869372ejm.67.2024.01.12.06.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 06:49:10 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Lee Jones <lee@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v8 3/5] ARM: dts: stm32: rename mmc_vcard to vcc-3v3 on stm32f769-disco
Date: Fri, 12 Jan 2024 15:48:23 +0100
Message-ID: <20240112144902.40044-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240112144902.40044-1-dario.binacchi@amarulasolutions.com>
References: <20240112144902.40044-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the schematics of document UM2033, the power supply for the micro SD
card is the same 3v3 voltage that is used to power other devices on the
board. By generalizing the name of the voltage regulator, it can be
referenced by other nodes in the device tree without creating
misunderstandings.

This patch is preparatory for future developments.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>

---

Changes in v8:
- Add Reviewed-by tag of Raphael Gallais-Pou

 arch/arm/boot/dts/st/stm32f769-disco.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/st/stm32f769-disco.dts b/arch/arm/boot/dts/st/stm32f769-disco.dts
index 5d12ae25b327..8632bd866272 100644
--- a/arch/arm/boot/dts/st/stm32f769-disco.dts
+++ b/arch/arm/boot/dts/st/stm32f769-disco.dts
@@ -92,9 +92,9 @@ usbotg_hs_phy: usb-phy {
 		clock-names = "main_clk";
 	};
 
-	mmc_vcard: mmc_vcard {
+	vcc_3v3: vcc_3v3 {
 		compatible = "regulator-fixed";
-		regulator-name = "mmc_vcard";
+		regulator-name = "vcc_3v3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 	};
@@ -128,7 +128,7 @@ &rtc {
 
 &sdio2 {
 	status = "okay";
-	vmmc-supply = <&mmc_vcard>;
+	vmmc-supply = <&vcc_3v3>;
 	cd-gpios = <&gpioi 15 GPIO_ACTIVE_LOW>;
 	broken-cd;
 	pinctrl-names = "default", "opendrain", "sleep";
-- 
2.43.0


