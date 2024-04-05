Return-Path: <linux-kernel+bounces-132627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 799BC89976D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F4C41F224E0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B605A143C79;
	Fri,  5 Apr 2024 08:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="0xc75gkM"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842C0143C63;
	Fri,  5 Apr 2024 08:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712304140; cv=none; b=QieViMekJj8tXXgEf8GwoUDt7dWkenQesEgksBDWZfGJKR2EEPqYr50z0cgmZ6RyYL8DWHgqWgHt4X1Qaw8bibAZ9UcOzzPttaUaXrZC4IfMraOZqeH+MpAu1xqJSCo7vp8PiGVxqf05fAp2oOB3o0xfjrYR2f8QH6HeqBqr0Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712304140; c=relaxed/simple;
	bh=CjtjJtjRiqvhZdhjYHsoFltjRD2g3Zr+JWz9NxI7jIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XihfvMZh9udJr99irZXU23pxVLronhY4SQa7TyEHr3mx54CTINIwKjls3hFtv7tDA5IXLzp/qXKWvGeYwGuuuTips7KUhmiuNoZpnt0QumGr+b6nFyJlz4VJEX1lXnKDwo7WTqw2DVLAVKzK1C7co3HCqIx/gYrIefPquntB6fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=0xc75gkM; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712304136;
	bh=CjtjJtjRiqvhZdhjYHsoFltjRD2g3Zr+JWz9NxI7jIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0xc75gkMn8sFUlL7654mLLQOxyLz463AurAjag5uB+6FtKBMRaEG0QW5uK4C1xOWK
	 RkWBz4KmFkxujxbID+gs3Kf1M59ayEVw5cMkmJeDPyFmQpdUTlp3hEBjDQrozfan27
	 KHa/3eXacdMCzoa+sMgt36gaOrmBP/QNdDkqaC3hidmNmclhlj5INVsKs4gRZ/BEEh
	 U4lGDjTV1Rc3gEGi8w1w7FcMXwjRjT3QYlUPWpISnbCDuSxeuSVAymdesMEeqeS2s3
	 Fc+98rEXIQgJHvFsTBriO7mKmZ4ayV3oMOBWrnmXYmXGZWRvvgNTuSV74zatwb1ggE
	 71CLxQubw4o+A==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A1E17378212E;
	Fri,  5 Apr 2024 08:02:15 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sam Shih <sam.shih@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Daniel Golle <daniel@makrotopia.org>,
	Frank Wunderlich <frank-w@public-files.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: Re: [PATCH 1/3] arm64: dts: mediatek: mt7986: drop invalid properties from ethsys
Date: Fri,  5 Apr 2024 10:02:09 +0200
Message-ID: <171230386964.52006.14938631024589400868.b4-ty@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240213053739.14387-1-zajec5@gmail.com>
References: <20240213053739.14387-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 13 Feb 2024 06:37:37 +0100, Rafał Miłecki wrote:
> Mediatek ethsys controller / syscon binding doesn't allow any subnodes
> so "#address-cells" and "#size-cells" are redundant (actually:
> disallowed).
> 
> This fixes:
> arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dtb: syscon@15000000: '#address-cells', '#size-cells' do not match any of the regexes: 'pinctrl-[0-9]+'
>         from schema $id: http://devicetree.org/schemas/clock/mediatek,ethsys.yaml#
> 
> [...]

Applied to v6.9-fixes/dts64, thanks!

[1/3] arm64: dts: mediatek: mt7986: drop invalid properties from ethsys
      commit: 3b449bfd2ff6c5d3ceecfcb18528ff8e1b4ac2fd
[2/3] arm64: dts: mediatek: mt7986: drop "#reset-cells" from Ethernet controller
      commit: 9bd88afc94c3570289a0f1c696578b3e1f4e3169
[3/3] arm64: dts: mediatek: mt7986: drop invalid thermal block clock
      commit: 970f8b01bd7719a22e577ba6c78e27f9ccf22783

Cheers,
Angelo


