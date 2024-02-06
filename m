Return-Path: <linux-kernel+bounces-55130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0279D84B819
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B3751F242AD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F6712FB2F;
	Tue,  6 Feb 2024 14:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jBmxg05D"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFF912D157
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 14:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707230285; cv=none; b=YmccoXWTHYW/Xy9VDIVN32qr/lb+71wvapJEd8M/0vJikzSPWvxmwJiTuQr6Flf8S5ciRYs/nuLq47uZgmPUJZKe4AzWGPsh4PIz1lpNbeKp7ZLnJ+A84URIaQmNsFAc/NJ1fOkUsCRpgYtggdMhzFuN3AYYEOaZjCPXwNwVwtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707230285; c=relaxed/simple;
	bh=f/2cueG3Db+hUw8yHz3480LbSCbMp3PrxDGJJ7LSl0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ry7DO01fiYCWRlBgB7M5JJGXulue51Ck9UnPksaLgl3Vvh4IChPcFANLU2N/RmW/A1lvEnvU0xBKb2WNn2N93e+FwwfyjwUqTzJO+vjdpKiIjpRrdOMkBBSi5WgAK1ZzRRgkjwVoYE9WFqomM0GZvS4Zgzo7A+EW9z5D72pZhYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jBmxg05D; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a384a7e6103so30326666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 06:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707230282; x=1707835082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mF/Kh9xpZHCKBcFBIr8xXoDa+aUxtWpcGMnQGhXMLkY=;
        b=jBmxg05Dm5E3NktloA/xRoS5uZ4xl9neYw7iVqBflK4DDvmOBKVQbeyaYJr+mG/F2C
         VqrZ6wukyCEE0Xmbw7Zye7P0LJHoTdQRhDJ1AxyFrS1ExZtBGR3uxR8a6RkNOYkBR9UL
         BzoWeaSsAVH89tnU+zlM+Mteu41EqGXtY2urXDE5Nzav4KVEExQ4U3K/IONgYw972l1j
         TvZWESFtxEg5EN1S1v/j0uiG4Kh6Y9mTVAFqe6lZIkBqpOBYM8FMXLuSn0tkacD0YUiL
         RBJxjHkTSez4RBHVdc40CDoXffC+bRNMrvAvhN5jdL5rN6wgejQ1GunvUh3vy2mfYhqc
         IVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707230282; x=1707835082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mF/Kh9xpZHCKBcFBIr8xXoDa+aUxtWpcGMnQGhXMLkY=;
        b=lJXFp7SmgKE9SsaXb9ZV9uR9044NbeZ2su7GSZYwRgKECzTPnpA6iwl+9QmCgPPUgj
         vSKJiEsukddNYbchwizedkX/U4EueM/ZrVRu2d4tiqDiAK59IMEId+bBqtI2t1cFDWX+
         CYSseem9GS3siwgdWfyB0gWbzB5tLBtvmd9HrZXyBXcaBhbURy4NtZXGKo5uljAUppBk
         XIpmx1c6osgFVDBQSwF8a0zGNKT6Hno7srUbGDetaAvhZ16Zbvx371rVYbVuK3zTOczl
         0Fc+x+TtCI9WimnQ/1l5b2p5WGaEJtpOF34fbF6gt/GJS+J4mC1GfhuQZkBUAxo1iz7X
         MCSg==
X-Gm-Message-State: AOJu0YxTs1olcHFRx+eXncMZaQfq6WhT0Q2o7FCMaU1AvpuYwlhe2zel
	AVzYCtIch2gBt9OJ4P03R+DrJcD5PZntStIlr8sRtpq34KyNx4UWSNsxbDA3Ulo=
X-Google-Smtp-Source: AGHT+IHZfXlRztOFWyUn+W5rBXN6rG8fTnzJ55i3wn/3ulNLFu5Yebta9oiXtBwhzBua28ZaBdpg+g==
X-Received: by 2002:a17:906:3153:b0:a38:52f0:4c49 with SMTP id e19-20020a170906315300b00a3852f04c49mr62055eje.64.1707230281826;
        Tue, 06 Feb 2024 06:38:01 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWF7Gbu3yiSZnF1ETXTHDiJ8j6rUVsH9sOiCmFo5k2yFXDoldLJ1izSQQaA9RXmZZmNp+qLlULjPfXHqm7ogWNcOZLhw4IC9HCMNsX46i+jfx322iexmcNPklL+RqQP9Rg/+jCY4jPJa0TVRmAQk2YWTarNeFdv26AMZgPkx4hORRzSNXMUqjRxJj51rLnsFUTcF9w9laW/S33d8koZvlJiQIT+W3XrF9B0vtMhIkEg6D0Op46FxUbc1MxMn7JZC25/a3IUxGGhj0iUNaEywe0KGk1UTlKXXIETHfBKfPV/+fSkJOXrwU20C+2qsMDmEEK2+e37VY6obU7yaYO3/1PcWC0hhSX69LkUoGujCEpVGA77Zg3NkL0f7o289CNaocrofjeVb0PQ4oYTGI9EI/dKhbUTmMIlVXXMWUEZ510E+j1M78VE
Received: from blmsp.fritz.box ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id e22-20020a1709062c1600b00a37585d5dcesm1224418ejh.51.2024.02.06.06.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 06:38:01 -0800 (PST)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Santosh Shilimkar <ssantosh@kernel.org>
Cc: Andrew Davis <afd@ti.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH 4/4] arm64: dts: ti: k3-am62-wakeup: Add chip efuse nodes
Date: Tue,  6 Feb 2024 15:37:11 +0100
Message-ID: <20240206143711.2410135-5-msp@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206143711.2410135-1-msp@baylibre.com>
References: <20240206143711.2410135-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add efuse nodes describing chip variant and speed grade.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi | 36 +++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
index fef76f52a52e..14419df43624 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
@@ -14,10 +14,44 @@ wkup_conf: syscon@43000000 {
 		#size-cells = <1>;
 		ranges = <0x0 0x00 0x43000000 0x20000>;
 
+		wkup_efuse: efuse@0 {
+			compatible = "socionext,uniphier-efuse";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x0 0x200>;
+
+			nvmem-layout {
+				compatible = "fixed-layout";
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				chip_manufacturer: jtagidmfg@14 {
+					reg = <0x14 0x2>;
+					bits = <1 11>;
+				};
+
+				chip_partno: jtagidpartno@15 {
+					reg = <0x15 0x3>;
+					bits = <4 16>;
+				};
+
+				chip_variant: jtagidvariant@17 {
+					reg = <0x17 0x1>;
+					bits = <4 4>;
+				};
+
+				chip_speed: jtaguseridspeed@18 {
+					reg = <0x18 0x4>;
+					bits = <6 5>;
+				};
+			};
+		};
+
 		chipid: chipid@14 {
 			bootph-all;
 			compatible = "ti,am654-chipid";
-			reg = <0x14 0x4>;
+			nvmem-cells = <&chip_variant>, <&chip_partno>, <&chip_manufacturer>;
+			nvmem-cell-names = "chipvariant", "chippartno", "chipmanufacturer";
 		};
 	};
 
-- 
2.43.0


