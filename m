Return-Path: <linux-kernel+bounces-132628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4219689976F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1F571F218A5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39F9142E70;
	Fri,  5 Apr 2024 08:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kSmhNO5h"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AA6144306;
	Fri,  5 Apr 2024 08:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712304141; cv=none; b=kE/rT7H9Ofp5BOXn1iZrdsyTKXlW4rlTKI1RAB4L02OIbn2q/PfYDpeXvKtT2hVjFxl8XKEvoSRFZqlIj6GPL+hjEnPZ9ZGQl8bwOYj0+n1hV1P1upxsIUy5wKxLbMpd0HW4ZXvn3W6AXeykgIYEJT31uDvM+B5VqMzJLFY9M2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712304141; c=relaxed/simple;
	bh=sVI13Nt7Fp//lImiaOTziIE4cX0l5nWa4MyNYpW6L2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uk+AJB5xozy70kayIAoPHiNf/Ut8tI4QWJFYY0kWtzd0mnCBRu+eq9BqptcIBi0N6OylKlgkmN0GBvyv8s7lNBegiz8Jgn4Ulzy6bWWP38naxfPvXWxPD3IwGpYUkOxqZUmKGm1qCgWkxnKOva39oy3l+Z6DT/iyHNwUDtogR0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kSmhNO5h; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712304138;
	bh=sVI13Nt7Fp//lImiaOTziIE4cX0l5nWa4MyNYpW6L2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kSmhNO5hcDDTMff4yRpdTdu3N94W9LIAWso6pYMHabIlEqdyZZyCWZdipyK/VyDtl
	 egDYzJcbP5pGXSfhJxRDZUz9D8bb2T0CP2YjYk+a4XUSO3cH2ywztiYMxBl11z43le
	 EvfntqOZ9Slc8Kac6vPVZ3Nv0SEetM+xLG97KMoONEcxlNEWHfEpNuj4fLgvcxazUU
	 PE0J4exObd5XV3XgOQEc3mdm3VfoJXXmlkdNo46hRpznrqGPZ4Z38S8kZsqrM25OvV
	 LyPWrkgkKNeF3ggPcpyLftt8AHPpRoztiiJl+hF9po4CfqABcyaCr6kWk1ciy2TazY
	 0F6p2eVqoZGEQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E1B28378212F;
	Fri,  5 Apr 2024 08:02:16 +0000 (UTC)
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
Subject: Re: [PATCH] arm64: dts: mediatek: mt2712: fix validation errors
Date: Fri,  5 Apr 2024 10:02:10 +0200
Message-ID: <171230386964.52006.15929846137869479168.b4-ty@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240301074741.8362-1-zajec5@gmail.com>
References: <20240301074741.8362-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 01 Mar 2024 08:47:41 +0100, Rafał Miłecki wrote:
> 1. Fixup infracfg clock controller binding
>    It also acts as reset controller so #reset-cells is required.
> 2. Use -pins suffix for pinctrl
> 
> This fixes:
> arch/arm64/boot/dts/mediatek/mt2712-evb.dtb: syscon@10001000: '#reset-cells' is a required property
>         from schema $id: http://devicetree.org/schemas/arm/mediatek/mediatek,infracfg.yaml#
> arch/arm64/boot/dts/mediatek/mt2712-evb.dtb: pinctrl@1000b000: 'eth_default', 'eth_sleep', 'usb0_iddig', 'usb1_iddig' do not match any of the regexes: 'pinctrl-[0-9]+', 'pins$'
>         from schema $id: http://devicetree.org/schemas/pinctrl/mediatek,mt65xx-pinctrl.yaml#
> 
> [...]

Applied to v6.9-fixes/dts64, thanks!

[1/1] arm64: dts: mediatek: mt2712: fix validation errors
      commit: 3baac7291effb501c4d52df7019ebf52011e5772

Cheers,
Angelo


