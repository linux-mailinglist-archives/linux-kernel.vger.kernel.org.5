Return-Path: <linux-kernel+bounces-136659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C961C89D6C2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 421491F2207E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481611327E2;
	Tue,  9 Apr 2024 10:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="C+Il1Jf6"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D47131180
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 10:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712657653; cv=none; b=oTQnc3SZrJC60i9s1uMeOqOM9lLReh5uC+2ISvQeYZO+QFbthwTDKd0Oh4GxZm8cGt2jR/xUeO4cGarKdlhjDx82LeOgSCST5fmEXa5WFSjSN10IywEww4M5B+mPBP1PpEgec1/UaytJIpOBnt4w/OsGa1k7r4Niw45U+KTq9qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712657653; c=relaxed/simple;
	bh=uSzLvOfclK6XqDtrVAYhNkEKbGoFUCZ/BcUUGGGjtWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SSbSx+2xlH87ezowVE3EPCD88DuWhnEJ5UqGgf/HQn7MiiGaPnAI+lKVhUtOnaZAaXlRizsRgwTmEQv5TGnEd2NfPxKr3sg7r0TAOMCWGjOQAhb8IhOkYkL7xKRhHFL7jmrcxPe/5CQm7keXhXVmZZ7SaUJcKMuEQYe9VTAiQxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=C+Il1Jf6; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-416b66163a9so1557455e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 03:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712657648; x=1713262448; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PlNVVt0wcqoKbTlcpTD2Av1BFgB4YmPyV+Qn5GBtCCs=;
        b=C+Il1Jf62ISvX1o03J/QSt1hKq1AV0Z0UKYzp0n+lPKga6ZsCbnwbVfUJIpj8nICdA
         /V2LVppBjpl5/C8I+wDtY/vGKMeUmWtmPIjRArf/eKx8sXXAoyirf7R8bO/oiJVInZFp
         giM8YoPVpcAuiNht4EpKXoZ81WF3PCUyz44dyDf4wUTLQ6yoVIj4aV65gu0BiGbV2TX2
         OIAbpD2e32iqvQygvStKEgqo+uE7ZkRtF2yoQ0y1x2LfiHggIn68i90wAIcZfkWIHDC7
         trfnFuz7wzV/B1faFFMTMAiOI8FFIEd6h48SrCkDwaANweJ9HHxfWjqbJsCClY1BSdM9
         f3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712657648; x=1713262448;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PlNVVt0wcqoKbTlcpTD2Av1BFgB4YmPyV+Qn5GBtCCs=;
        b=NSLxC/onvxbamu1zDpSCrEAGK+iC1vz2pzxjI4kMINThrgrUWl7QtD/A6CVxvQI6LX
         LUcn4oBoMI+VIdVqwzlw9S3z7mJumGbMxCdGpKEH8h8ltQIVAsF9UCPs6hCEru5P+qgZ
         Hjc49xsEkhk1SE6hic4yuM+/Q2M+fIm4lX2A0MCRXKE3JM92ot616ZWc2zHP9IOQMZMP
         6z6DhPitnWV5UDItbJqZEgnY/TCUwvAL5RF+OTrAWeGtoqhURX6nKSGeuvqvb66wvbW2
         7Rb1o7vsN1wWCLFYcCHkx4nsnX9vnog2FN1UP5p8pTKcC32vcDyYXdPlxR1DmlY98rCw
         RGgA==
X-Forwarded-Encrypted: i=1; AJvYcCVW+rZEyRlv3uPpUyw268DJJf1rnBGZoq0zM6VDf0bQiH6lsQ+8wwFKyJ9kFpuQTWBGqydPgHwt6H0mHaT60ReZuiYJBv7MMfU1DOqx
X-Gm-Message-State: AOJu0YxbQXHpWVqAg1Uhmrlmbki2/RM3UHlarq/o2jvpGE3ncUTXtRLd
	02FVTnZN2wXWIcek4mHHPSNoJJymgQR+wTFLoM7W2W32apTyyTjZ4heLS0WLxKT+88XagihwGVW
	BbQ8=
X-Google-Smtp-Source: AGHT+IH93tvacaOiFnd4nqmc7gPsI2OQnyM0ybPS1MyBc1NNs/vnBJCMth9sI4K2Y7Z5nTAcW1vKuQ==
X-Received: by 2002:a05:600c:1986:b0:416:4973:4d87 with SMTP id t6-20020a05600c198600b0041649734d87mr7777580wmq.3.1712657648192;
        Tue, 09 Apr 2024 03:14:08 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id r7-20020a05600c458700b00416b035c2d8sm1124149wmo.3.2024.04.09.03.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 03:14:07 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Tue, 09 Apr 2024 12:13:39 +0200
Subject: [PATCH v2 18/18] arm64: dts: mediatek: add audio support for
 mt8365-evk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240226-audio-i350-v2-18-3043d483de0d@baylibre.com>
References: <20240226-audio-i350-v2-0-3043d483de0d@baylibre.com>
In-Reply-To: <20240226-audio-i350-v2-0-3043d483de0d@baylibre.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lee Jones <lee@kernel.org>, Flora Fu <flora.fu@mediatek.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Rob Herring <robh@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3962; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=uSzLvOfclK6XqDtrVAYhNkEKbGoFUCZ/BcUUGGGjtWY=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmFRTTPFBV6yfp7E/gtZ8jajBrd4nrGJXU7zuvHqAn
 MYzj5GiJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZhUU0wAKCRArRkmdfjHURd7sD/
 0d7oIOsEwKg1zZ6wKlZHYUcZVM3MBOkC/s+el2n0OhNu8d0vnDZUAx+2NSBnPNMYQIop5CXn599unK
 zTB9ZeemTVqcMLVooBi6G4H5zf1lXsZ0agCq1THO622I/7O/KyLM9HjgyytiVUS3YuIV7DmWnJyGDu
 JWxyOmTQoU5uvqQUYIowraVjoLhkxK3w+BoqD4+vcVUZnTPHDQkKsy2Yee+HqURFMKbREfaB68KkhC
 wacoL0XJvC2lG6ZkP5zkaO7QqqigeYrlE0QMlqnVxtrOb3STiREQptLDQy5W9iomslHnnwrirzTNXt
 wkvQnflZmuetIt96UlaJ7EfwpUfpcSnSyvIECFNKmEtBMlzzQcbBWvoRAR4crLjNi5Ni7VJMEive9T
 ZcNWB9rmdABfIoaj1hgs2V4kiA/cdx4C7/N2csgJGJfbfKN7KCDYtETjmaTZvrmfPtgWOd+KcQEu0F
 Scb6Cwuj55Hc7Yvvv6xQ9X9O82nSU8gyZ12H14H4jFh787GExA6h33K1MJwN0WAuok1upuW7MFqYkZ
 iitq8obavvUIfmBnqn9zRN++w1YJ3yvkdGcWPiJGV3vy4Mfi9isOq1jgOiSHCL+fhBPxBqImEsENqO
 LBlB7ibM5IOmfrPDyZ4N8yx3kZJR4+icLeV0DNeOR6m5LqtiDNRvLaxwtt9A==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

Add the sound node which is linked to the MT8365 SoC AFE and
the MT6357 audio codec.

Update the file header.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 98 +++++++++++++++++++++++++++--
 1 file changed, 94 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
index 50cbaefa1a99..bf15d3c7a965 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (c) 2021-2022 BayLibre, SAS.
- * Authors:
- * Fabien Parent <fparent@baylibre.com>
- * Bernhard Rosenkränzer <bero@baylibre.com>
+ * Copyright (c) 2024 BayLibre, SAS.
+ * Authors: Fabien Parent <fparent@baylibre.com>
+ *	    Bernhard Rosenkränzer <bero@baylibre.com>
+ *	    Alexandre Mergnat <amergnat@baylibre.com>
  */
 
 /dts-v1/;
@@ -86,6 +86,29 @@ optee_reserved: optee@43200000 {
 			reg = <0 0x43200000 0 0x00c00000>;
 		};
 	};
+
+	sound: sound {
+		compatible = "mediatek,mt8365-mt6357";
+		pinctrl-names = "default",
+				"dmic",
+				"miso_off",
+				"miso_on",
+				"mosi_off",
+				"mosi_on";
+		pinctrl-0 = <&aud_default_pins>;
+		pinctrl-1 = <&aud_dmic_pins>;
+		pinctrl-2 = <&aud_miso_off_pins>;
+		pinctrl-3 = <&aud_miso_on_pins>;
+		pinctrl-4 = <&aud_mosi_off_pins>;
+		pinctrl-5 = <&aud_mosi_on_pins>;
+		mediatek,platform = <&afe>;
+		status = "okay";
+	};
+};
+
+&afe {
+	mediatek,dmic-mode = <1>;
+	status = "okay";
 };
 
 &cpu0 {
@@ -174,6 +197,12 @@ &mmc1 {
 	status = "okay";
 };
 
+&mt6357_codec {
+	vaud28-supply = <&mt6357_vaud28_reg>;
+	mediatek,micbias0-microvolt = <1900000>;
+	mediatek,micbias1-microvolt = <1700000>;
+};
+
 &mt6357_pmic {
 	interrupts-extended = <&pio 145 IRQ_TYPE_LEVEL_HIGH>;
 	interrupt-controller;
@@ -181,6 +210,67 @@ &mt6357_pmic {
 };
 
 &pio {
+	aud_default_pins: audiodefault-pins {
+		pins {
+		pinmux = <MT8365_PIN_72_CMDAT4__FUNC_I2S3_BCK>,
+			 <MT8365_PIN_73_CMDAT5__FUNC_I2S3_LRCK>,
+			 <MT8365_PIN_74_CMDAT6__FUNC_I2S3_MCK>,
+			 <MT8365_PIN_75_CMDAT7__FUNC_I2S3_DO>;
+		};
+	};
+
+	aud_dmic_pins: audiodmic-pins {
+		pins {
+		pinmux = <MT8365_PIN_117_DMIC0_CLK__FUNC_DMIC0_CLK>,
+			 <MT8365_PIN_118_DMIC0_DAT0__FUNC_DMIC0_DAT0>,
+			 <MT8365_PIN_119_DMIC0_DAT1__FUNC_DMIC0_DAT1>;
+		};
+	};
+
+	aud_miso_off_pins: misooff-pins {
+		pins {
+		pinmux = <MT8365_PIN_53_AUD_CLK_MISO__FUNC_GPIO53>,
+			 <MT8365_PIN_54_AUD_SYNC_MISO__FUNC_GPIO54>,
+			 <MT8365_PIN_55_AUD_DAT_MISO0__FUNC_GPIO55>,
+			 <MT8365_PIN_56_AUD_DAT_MISO1__FUNC_GPIO56>;
+		input-enable;
+		bias-pull-down;
+		drive-strength = <MTK_DRIVE_2mA>;
+		};
+	};
+
+	aud_miso_on_pins: misoon-pins {
+		pins {
+		pinmux = <MT8365_PIN_53_AUD_CLK_MISO__FUNC_AUD_CLK_MISO>,
+			 <MT8365_PIN_54_AUD_SYNC_MISO__FUNC_AUD_SYNC_MISO>,
+			 <MT8365_PIN_55_AUD_DAT_MISO0__FUNC_AUD_DAT_MISO0>,
+			 <MT8365_PIN_56_AUD_DAT_MISO1__FUNC_AUD_DAT_MISO1>;
+		drive-strength = <MTK_DRIVE_6mA>;
+		};
+	};
+
+	aud_mosi_off_pins: mosioff-pins {
+		pins {
+		pinmux = <MT8365_PIN_49_AUD_CLK_MOSI__FUNC_GPIO49>,
+			 <MT8365_PIN_50_AUD_SYNC_MOSI__FUNC_GPIO50>,
+			 <MT8365_PIN_51_AUD_DAT_MOSI0__FUNC_GPIO51>,
+			 <MT8365_PIN_52_AUD_DAT_MOSI1__FUNC_GPIO52>;
+		input-enable;
+		bias-pull-down;
+		drive-strength = <MTK_DRIVE_2mA>;
+		};
+	};
+
+	aud_mosi_on_pins: mosion-pins {
+		pins {
+		pinmux = <MT8365_PIN_49_AUD_CLK_MOSI__FUNC_AUD_CLK_MOSI>,
+			 <MT8365_PIN_50_AUD_SYNC_MOSI__FUNC_AUD_SYNC_MOSI>,
+			 <MT8365_PIN_51_AUD_DAT_MOSI0__FUNC_AUD_DAT_MOSI0>,
+			 <MT8365_PIN_52_AUD_DAT_MOSI1__FUNC_AUD_DAT_MOSI1>;
+		drive-strength = <MTK_DRIVE_6mA>;
+		};
+	};
+
 	ethernet_pins: ethernet-pins {
 		phy_reset_pins {
 			pinmux = <MT8365_PIN_133_TDM_TX_DATA1__FUNC_GPIO133>;

-- 
2.25.1


