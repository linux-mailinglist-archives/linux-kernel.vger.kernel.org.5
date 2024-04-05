Return-Path: <linux-kernel+bounces-132629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF64899773
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC9F11C21F96
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5FC14535E;
	Fri,  5 Apr 2024 08:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="zhwSRWkz"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F9E144303;
	Fri,  5 Apr 2024 08:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712304142; cv=none; b=eAhboCxn4Cum2NBuCPy5h35o53VpNO/zVyVKsgXLrS7Cd+tjaRPtGkEg3Kmt5nYR9nXhXCkGRzWFpJ/k0ZHvhJBB/wy8wxrEmvJ9FSSHNg1KRYGkBvFlW8ETlBqNwXeoeJMqbcdPXqCfJcmBvxHhtq+6kD/g5vxhtzRggkmrH5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712304142; c=relaxed/simple;
	bh=dk1AV/tMxCdJseJTFKfjUVE3T4iRp/NXN+zjwy+TBgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j0sRQrth8mviqgDfXqB2HujwNnD7yCdrya9vjo/78+GLqXyunGgR25M8qTZ3UR10jn4XHoiB+5LL9fLcxSyY8o0eDkXQMqycaz50FlATBCbBWzUW+GI08Zje51w183K3ZWO3Es6IAv9/enDHOIuFvDn9W/gZ5tXpHtB01ew2IXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=zhwSRWkz; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712304139;
	bh=dk1AV/tMxCdJseJTFKfjUVE3T4iRp/NXN+zjwy+TBgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zhwSRWkzU3FhoLtWDElf7x0PqLoXTjmnR1qtcW3aj6qc6j6CLT+oazulwMoSmX2yF
	 LX2pektrxwZUfbjrsvwBg13udgwqrZXPT94gKy6HMt7YvTagjuCGS1HrsJx3a0Posm
	 f3hoJ1K9P61pyXWkEvk2nCrDb2P/tkCtT3JIlXFtNoBGN4NZNSYu3BvKwgWaUlnz5s
	 Pro2DwMoZSiaRmAjYLBUmvWXHcRQZ/Me0YuOyK2HDJ2r4W+aayXUuLN7fZsYtNj/GP
	 x5jRgavtgtLOXsnEM+chsdannp+IeGActJikaHLv7dDALcr27kE0ipxVNt5iWRT+Js
	 bWkfNFcP69LBA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 30A74378212D;
	Fri,  5 Apr 2024 08:02:18 +0000 (UTC)
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
Subject: Re: [PATCH] arm64: dts: mediatek: mt7986: prefix BPI-R3 cooling maps with "map-"
Date: Fri,  5 Apr 2024 10:02:11 +0200
Message-ID: <171230386964.52006.161397169645189062.b4-ty@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240213061459.17917-1-zajec5@gmail.com>
References: <20240213061459.17917-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 13 Feb 2024 07:14:59 +0100, Rafał Miłecki wrote:
> This fixes:
> arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dtb: thermal-zones: cpu-thermal:cooling-maps: 'cpu-active-high', 'cpu-active-low', 'cpu-active-med' do not match any of the regexes: '^map[-a-zA-Z0-9]*$', 'pinctrl-[0-9]+'
>         from schema $id: http://devicetree.org/schemas/thermal/thermal-zones.yaml#
> 
> 

Applied to v6.9-fixes/dts64, thanks!

[1/1] arm64: dts: mediatek: mt7986: prefix BPI-R3 cooling maps with "map-"
      commit: f8c65a5e4560781f2ea175d8f26cd75ac98e8d78

Cheers,
Angelo


