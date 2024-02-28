Return-Path: <linux-kernel+bounces-84980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A20E086AE74
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D31721C24640
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA21973525;
	Wed, 28 Feb 2024 11:54:07 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECF67351D;
	Wed, 28 Feb 2024 11:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709121247; cv=none; b=d4geILPwv+bgsKR/Ih2fAyEiX+XrRAim08AZnZAK6kkk0a2rMJ9CpP8l53D63z8az2rPLeLkMp4CFgCoEkpyOiHu0RzyMCGcccc8RYn2agpJ1w3skkNzmgLHRPLs3Z5I1Xf0E0Q+4KMCSy98d49HOn2XbzImOCTSFEEFfxgUXm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709121247; c=relaxed/simple;
	bh=2Zrc5durpoQSNnz0Dgs2PCHagqWa26Fx2LnD0iIMZJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dK0F7RT88XpdP+09rP58Bi5iRbZFzlcsi8kC7muNLSh9t2X6mri2d1DAT27D+05M2gUAF0lpH4jJ5GMvefjantUIM3E5eIPjmTlANrol0iaGeIOlxSI4ZbzGsGyaqt6L+voOU+eX7XNdu898x8keDYeWmG7Bt61rq8wDSoOjdjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b6c.versanet.de ([83.135.91.108] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rfIVc-0001Gf-2b; Wed, 28 Feb 2024 12:54:00 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Wang <frank.wang@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>, kernel@collabora.com,
 Zhang Yubing <yubing.zhang@rock-chips.com>
Subject: Re: [PATCH v3 02/10] phy: rockchip: add usbdp combo phy driver
Date: Wed, 28 Feb 2024 12:53:59 +0100
Message-ID: <1891069.1xdlsreqCQ@diego>
In-Reply-To: <20240216170514.75200-3-sebastian.reichel@collabora.com>
References:
 <20240216170514.75200-1-sebastian.reichel@collabora.com>
 <20240216170514.75200-3-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Freitag, 16. Februar 2024, 18:01:17 CET schrieb Sebastian Reichel:
> This adds a new USBDP combo PHY with Samsung IP block driver.
> 
> The driver get lane mux and mapping info in 2 ways, supporting
> DisplayPort alternate mode or parsing from DT. When parsing from DT,
> the property "rockchip,dp-lane-mux" provide the DP mux and mapping
> info. This is needed when the PHY is not used with TypeC Alt-Mode.
> For example if the USB3 interface of the PHY is connected to a USB
> Type A connector and the DP interface is connected to a DisplayPort
> connector.
> 
> When do DP link training, need to set lane number, link rate, swing,
> and pre-emphasis via PHY configure interface.
> 
> Co-developed-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Co-developed-by: Zhang Yubing <yubing.zhang@rock-chips.com>
> Signed-off-by: Zhang Yubing <yubing.zhang@rock-chips.com>
> Co-developed-by: Frank Wang <frank.wang@rock-chips.com>
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Not sure how that relates to me being listed a Co-developer, but this
works nicely on both rk3588-jaguar (real type-c) and rk3588-tiger-haikou
(micro-usb3 as dual-role port and usb3-a host port), so

Tested-by: Heiko Stuebner <heiko@sntech.de>

It would be nice if patches 1+2 could go through the phy-tree and I'd
be able to pick up the devicetree patches after that, to minimize conflict


Thanks
Heiko




