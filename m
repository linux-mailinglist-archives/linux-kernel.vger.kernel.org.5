Return-Path: <linux-kernel+bounces-129560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC02896C8E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D0AF1C2776E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DEB1474D2;
	Wed,  3 Apr 2024 10:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EqKeAqTP"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC60146588;
	Wed,  3 Apr 2024 10:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712140287; cv=none; b=RlOX5B1w7at3JpuR0NNV2VsFxjFJGEnvlLwULNck0FIxG090GC+A8pffXZCZXB3O3JDv73vQI6AFQHhawbHPrYvU0yWyojlIPQRJ+3nQD28AjUDjdC8L7/AKrTrmjTxrDcWNRXbZbjnmBWeFqEVPEsVlIV87yaOYXFhVwcpcIuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712140287; c=relaxed/simple;
	bh=PYIRmUFghpI8A50oiu40PS5xDa+QI8EerqhE598Bz9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cln0zliJyD16AIEHoByA9l+FrHvzOUBhvTKCdv5CoWgmKoDXeuJvAnAXvYVVsq21MaGp+2DsraRlM2b01mfGaaJL2egWXY2sJG35wVN3P9NSjDS1PJ043T5yjdHNixb9SQPYLuu4C/F5t2iRkJS3eq02Pmd1wEyOd6IKY3V4Eg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=EqKeAqTP; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712140284;
	bh=PYIRmUFghpI8A50oiu40PS5xDa+QI8EerqhE598Bz9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EqKeAqTPlb3pmbIe6dSIwV4CVEgMpzMxoOltEpWseRBh8y5x0vQCHFN0zZhqmBrq+
	 eSrGqLka7CpdA+Pwng7gKj+Ef7Iiy/DJfolP83Vt5+FxweMO4FeSy6x7ImqMp+KMyZ
	 OzzNip2Ujt5vMjeBIfYvNShisxHjGJ7fZQiIiBHYC5TuZ4KVZmf4iwhZzJS+N0+hUJ
	 4LwXesTio/2PpGob7izm9ptQkpK5f8ibFvdMcsmUr5Jg5xJUiFhhmB2JOc1VOsJMqR
	 GqckyLXmFTkxxWXBzs+ZpsNohaBe3VJp7CmJ92pXi+ixaT4hFYX/0NV7OwEnfmsE0M
	 pYfJdzN9WWsxQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EE9B737820F3;
	Wed,  3 Apr 2024 10:31:22 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
	Tinghan Shen <tinghan.shen@mediatek.com>,
	"Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
	"Nancy.Lin" <nancy.lin@mediatek.com>,
	kernel@collabora.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Chen-Yu Tsai <wenst@chromium.org>,
	Hsin-Yi Wang <hsinyi@chromium.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sean Wang <sean.wang@mediatek.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: Re: [PATCH V3 0/4] dts: mediatek: add Cudy WR3000 V1 wireless router
Date: Wed,  3 Apr 2024 12:30:59 +0200
Message-ID: <171213179798.60933.728917515471078236.b4-ty@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240317223206.22033-1-zajec5@gmail.com>
References: <20240317223206.22033-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 17 Mar 2024 23:32:02 +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Cudy WR3000 V1 is a MediaTek Filogic 820 based 802.11ax wireless router.
> 
> https://www.cudy.com/productinfo/1637722.html
> 
> Rafał Miłecki (4):
>   dt-bindings: vendor-prefixes: add Cudy
>   dt-bindings: arm64: dts: mediatek: Add Cudy WR3000 V1 router
>   arm64: dts: mediatek: mt7981: add pinctrl
>   arm64: dts: mediatek: Add Cudy WR3000 V1
> 
> [...]

Applied to v6.9-next/dts64, thanks!

[1/4] dt-bindings: vendor-prefixes: add Cudy
      (no commit info)
[2/4] dt-bindings: arm64: dts: mediatek: Add Cudy WR3000 V1 router
      (no commit info)
[3/4] arm64: dts: mediatek: mt7981: add pinctrl
      (no commit info)
[4/4] arm64: dts: mediatek: Add Cudy WR3000 V1
      (no commit info)

Cheers,
Angelo


