Return-Path: <linux-kernel+bounces-119586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9801688CABE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA16F1C66408
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD6B208B4;
	Tue, 26 Mar 2024 17:26:08 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14898200CB;
	Tue, 26 Mar 2024 17:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711473968; cv=none; b=aZ87cXW8zg227izgsMTFszDG8LZSa76HpJl2yQb5Pkvjr2OCCj3z7DAENOVMECiotGhjWm9NJPsNsEVhCRAIo+Hft2Inmv6A1eZrbcGcydGYdCPBPZGJkVO4XeEO3RXcw82lsn2gjXUzHRWIBooEAetitIPE4gY1xxicDvm9a+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711473968; c=relaxed/simple;
	bh=Ka0BqODwFrLwyN3SMEtrICxiPAvB0WKMvGb82tkKccg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C2JSPCH3eJ8xIUQEBkCWsjVdopmioIKCbJRRrvJqKKGTijIKMb9FMrahk1PyhvMmdLuijB347PnZiB9lWwOHOL7JA8y9Cq+vHPalSWj+CUVlMGPZiJGAnShtF00UfbxoM+NPuETQgT9QRA6OgYf75nN1tuyAPbQBKSwRCSUX8Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rpAYb-000658-2p; Tue, 26 Mar 2024 18:25:53 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Jaroslav Kysela <perex@perex.cz>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Takashi Iwai <tiwai@suse.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: (subset) [PATCH v4 0/7] Add support for the internal RK3308 audio codec
Date: Tue, 26 Mar 2024 18:25:50 +0100
Message-Id: <171147393346.1162935.3469121716836265382.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240305-rk3308-audio-codec-v4-0-312acdbe628f@bootlin.com>
References: <20240305-rk3308-audio-codec-v4-0-312acdbe628f@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 05 Mar 2024 15:36:27 +0100, Luca Ceresoli wrote:
> This series adds a driver for the internal audio codec of the Rockchip
> RK3308 SoC, along with some related patches. This codec is internally
> connected to the I2S peripherals on the same chip, and it has some
> peculiarities arising from that interconnection.
> 
> For proper bidirectional operation with the internal codec at any possible
> combination of sampling rates, the I2S peripheral needs two clock sources
> (tx and rx), while connection with an external codec commonly needs only
> one.
> 
> [...]

Applied, thanks!

[5/7] arm64: defconfig: enable Rockchip RK3308 internal audio codec driver
      commit: 9fdd7b45da18b84d5e7d5a6b8b4b0167910f2d13
[6/7] arm64: dts: rockchip: add i2s_8ch_2 and i2s_8ch_3
      commit: b5ffc424360eaced41f405f0e38bcabe61fecf39
[7/7] arm64: dts: rockchip: add the internal audio codec
      commit: 30d72458624bb1ba7bab1c7a1d5f4c42f512010c

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

