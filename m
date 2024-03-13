Return-Path: <linux-kernel+bounces-101401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F9D87A6A5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E60F1F225D1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3557657883;
	Wed, 13 Mar 2024 11:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JNmKMdd+"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB7A56770;
	Wed, 13 Mar 2024 11:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710327770; cv=none; b=AR5ewRlS0Iv+qrifqEkOZIDEQn+RvveIIpxyfpNo5FIj+n8RSgd2hCumShe+/PULLFfAOvw5FqcJZJG8+TvhBWPMtqmzUSQqwMBJzGISSONo9+zVKlzF3KVmyoQL5kf1vPBNOsJcBQm9j1eEzPYB7EEVHoZiheIXsrDcAfctfO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710327770; c=relaxed/simple;
	bh=jy17j4GnL9+x3VVzlB6GUuhq0JWZqZM8wbSx/KQK9R0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kqtHtlLL2nF5m53RqNr9N2sQRqNcCPaxkElrgcl0HlaAyycfQwk48kfTpLCZnpRizOtC/aA0cYEVLwA5SX5X9zFSZ8QKYqtC3CvNxqcXbLhEFaAotBVWcW/UaKEXZPyxlYDOiBaFqxqA/Bjfcz9wbUuLSyjdTdTD+mgbtj6AIsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JNmKMdd+; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710327767;
	bh=jy17j4GnL9+x3VVzlB6GUuhq0JWZqZM8wbSx/KQK9R0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JNmKMdd+LL/hqyid/LM+DBI6BeaIV3fWIjMkFTPDYL7nMlx3sLd2xtBHWrHPncIAM
	 7KJyUhvFd8q8E1kVZ+dZezUBIyMDWhQar2zfco1tvLHFwIF2uArh6rwbNONyj5Y5YQ
	 MH+WAqXGQu87Nx4MuK8SkA+GNNTj6WuLBYztaZ8oPLa6grHX4oyuJ+UAodaSsDwwJu
	 WBshp+5yc7kKNwqaW3YBpB3k8n1jLlCo+5bxHj1+qfEn9ixLkIuIvYkIPafGiCZW63
	 O1x+qKJiK8rxPzw+VglDf9Lh/L0X1pOefZzNU4KxDNw+SfYUEAvP/+yc9Rry4GbuVh
	 H3DlDm2g493mQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7363637820C6;
	Wed, 13 Mar 2024 11:02:45 +0000 (UTC)
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
Subject: [PATCH v3 21/22] arm64: dts: mediatek: mt8195-cherry: Specify sound DAI links and routing
Date: Wed, 13 Mar 2024 12:01:46 +0100
Message-ID: <20240313110147.1267793-22-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240313110147.1267793-1-angelogioacchino.delregno@collabora.com>
References: <20240313110147.1267793-1-angelogioacchino.delregno@collabora.com>
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
index eb07cad1991f..86d283ffe807 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -242,6 +242,7 @@ adsp_device_mem: memory@60e80000 {
 	spk_amplifier: rt1019p {
 		compatible = "realtek,rt1019p";
 		label = "rt1019p";
+		#sound-dai-cells = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&rt1019p_pins_default>;
 		sdb-gpios = <&pio 100 GPIO_ACTIVE_HIGH>;
@@ -336,6 +337,7 @@ &disp_pwm0 {
 &dp_tx {
 	status = "okay";
 
+	#sound-dai-cells = <0>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&dptx_pin>;
 
@@ -406,6 +408,7 @@ audio_codec: codec@1a {
 		/* Realtek RT5682i or RT5682s, sharing the same configuration */
 		reg = <0x1a>;
 		interrupts-extended = <&pio 89 IRQ_TYPE_EDGE_BOTH>;
+		#sound-dai-cells = <0>;
 		realtek,jd-src = <1>;
 
 		AVDD-supply = <&mt6359_vio18_ldo_reg>;
@@ -1132,6 +1135,48 @@ &sound {
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


