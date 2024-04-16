Return-Path: <linux-kernel+bounces-146401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2288A64CB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 773071F22448
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBF915D5D1;
	Tue, 16 Apr 2024 07:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Z4m62yBD"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8200215CD76;
	Tue, 16 Apr 2024 07:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713251702; cv=none; b=fy+qpJoMmLRtBnjnHKAZO9wmR9TrTGgUXogc9FstfBQ5TFwaWFfnLolk6lZ/AdHS/4XVhcWEHzC0ehbhsYyLaVLWb1PWpVvHpkIxmC7shRfk3dSVIBZ8ipxtdjFeUD7/XwBcew/hcSrqUZCLhu793vc9jdBzYO9Wn3H234UyFmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713251702; c=relaxed/simple;
	bh=+JfrTVgrO4JkC6c7ui1/Sey7vbzN8l8IbPUAys7zK+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+BQi+knaRtOrjJOO/IYPV7wyPnWyPmtuwnyReGoHAPFl6E2cgBzi26fdV9RFu0qRfK5K8A9kX4EH3YXYLGeh+3X50brHLCiQcq5YQ1hb6lBx/JKEtN6VcBBxIL54+faKyyYSLNGSKjLMFTFR9vm39nBzFl84FPkNQak9ImxeGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Z4m62yBD; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713251699;
	bh=+JfrTVgrO4JkC6c7ui1/Sey7vbzN8l8IbPUAys7zK+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z4m62yBDtA+bF8qt+D4/JNUHrWxWKHTlqZlENRyUayMuEvVEh+oeWVdLagxjdo0ym
	 Sp98TZT+64AGJ03y3vqFyZ+JTQpfn4JlqN2g7AtbRQm/D6Vn9o2vt2eEVcHJyDj6ur
	 N09wMpYdwx9Gkshh3qAwkA6uNXKDc9hIcxnO7nrMK3fGo6LZAhiyC8xSM5Hmt334TD
	 gsYmJ3W+/2cLU2GyQtyH0MtionLZYIGYJF43zfEg8MElyF/L7/4E+yzNKP/F0LlIne
	 0XSIx3hGmYq7scyzbTfAmWi/wS5khWaADryJmEfwoMOs2y9TtINtIwxfR3xx/epyDR
	 hmZ75XFx7gWrA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id CFA6B3782134;
	Tue, 16 Apr 2024 07:14:56 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: broonie@kernel.org
Cc: wenst@chromium.org,
	lgirdwood@gmail.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	trevor.wu@mediatek.com,
	maso.huang@mediatek.com,
	xiazhengqiao@huaqin.corp-partner.google.com,
	arnd@arndb.de,
	kuninori.morimoto.gx@renesas.com,
	shraash@google.com,
	amergnat@baylibre.com,
	nicolas.ferre@microchip.com,
	u.kleine-koenig@pengutronix.de,
	dianders@chromium.org,
	frank.li@vivo.com,
	allen-kh.cheng@mediatek.com,
	eugen.hristev@collabora.com,
	claudiu.beznea@tuxon.dev,
	jarkko.nikula@bitmer.com,
	jiaxin.yu@mediatek.com,
	alpernebiyasak@gmail.com,
	ckeepax@opensource.cirrus.com,
	zhourui@huaqin.corp-partner.google.com,
	nfraprado@collabora.com,
	alsa-devel@alsa-project.org,
	shane.chien@mediatek.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v5 17/18] arm64: dts: mediatek: mt8195-cherry: Specify sound DAI links and routing
Date: Tue, 16 Apr 2024 09:14:09 +0200
Message-ID: <20240416071410.75620-18-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416071410.75620-1-angelogioacchino.delregno@collabora.com>
References: <20240416071410.75620-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The drivers and bindings acquired support for specifying audio hardware
and links in device tree: describe and link the sound related HW of this
machine.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../boot/dts/mediatek/mt8195-cherry.dtsi      | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index 4a11918da370..e35adff02469 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -240,6 +240,7 @@ adsp_device_mem: memory@60e80000 {
 	spk_amplifier: rt1019p {
 		compatible = "realtek,rt1019p";
 		label = "rt1019p";
+		#sound-dai-cells = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&rt1019p_pins_default>;
 		sdb-gpios = <&pio 100 GPIO_ACTIVE_HIGH>;
@@ -366,6 +367,7 @@ &disp_pwm0 {
 &dp_tx {
 	status = "okay";
 
+	#sound-dai-cells = <0>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&dptx_pin>;
 
@@ -436,6 +438,7 @@ audio_codec: codec@1a {
 		/* Realtek RT5682i or RT5682s, sharing the same configuration */
 		reg = <0x1a>;
 		interrupts-extended = <&pio 89 IRQ_TYPE_EDGE_BOTH>;
+		#sound-dai-cells = <0>;
 		realtek,jd-src = <1>;
 
 		AVDD-supply = <&mt6359_vio18_ldo_reg>;
@@ -1162,6 +1165,48 @@ &sound {
 		"AFE_SOF_DL2", "AFE_SOF_DL3", "AFE_SOF_UL4", "AFE_SOF_UL5";
 	pinctrl-names = "default";
 	pinctrl-0 = <&aud_pins_default>;
+
+	audio-routing =
+		"Headphone", "HPOL",
+		"Headphone", "HPOR",
+		"IN1P", "Headset Mic",
+		"Ext Spk", "Speaker";
+
+	mm-dai-link {
+		link-name = "ETDM1_IN_BE";
+		mediatek,clk-provider = "cpu";
+	};
+
+	hs-playback-dai-link {
+		link-name = "ETDM1_OUT_BE";
+		mediatek,clk-provider = "cpu";
+		codec {
+			sound-dai = <&audio_codec>;
+		};
+	};
+
+	hs-capture-dai-link {
+		link-name = "ETDM2_IN_BE";
+		mediatek,clk-provider = "cpu";
+		codec {
+			sound-dai = <&audio_codec>;
+		};
+	};
+
+	spk-playback-dai-link {
+		link-name = "ETDM2_OUT_BE";
+		mediatek,clk-provider = "cpu";
+		codec {
+			sound-dai = <&spk_amplifier>;
+		};
+	};
+
+	displayport-dai-link {
+		link-name = "DPTX_BE";
+		codec {
+			sound-dai = <&dp_tx>;
+		};
+	};
 };
 
 &spi0 {
-- 
2.44.0


