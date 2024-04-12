Return-Path: <linux-kernel+bounces-142873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A54178A313A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46D991F21B8B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB1A1442FF;
	Fri, 12 Apr 2024 14:46:53 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F341785285;
	Fri, 12 Apr 2024 14:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712933212; cv=none; b=UDFaXUNl9kJoxNwuB3ydlqZRRV+1RRPO6MVFscLCTCExjKtEjqxR0TYO9/6Bmj21I6MU2BXRFQlS8HhaSLep+qNz/UrStsEvxSSIUqd0LLFbdHceAYGFqCHtUsG/yp7BlFb8vS2CFsgoX0byp+ddQf9ChlyhjJHh8iPQkuskEdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712933212; c=relaxed/simple;
	bh=1KgtVhE8CgezqO9ecO9m17CIujO5EbtHZDpD8dOfIJE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tNuePmk+wc09vp3J/FyqZ6D86ZyfeRNByV7xjtO2O6ZgHA6FGMSBbfqaNc1v1Hx46pyaCJu7eSBcca8Aw1QgZG9jGnY7S0Zje1eEJY3UIbbrNWLuSGSxq7ucIuOdN+DXCODsr2k37vCZRJFCsXU/xwbTsvqxa0WJahKZGKkozfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e8616c3.versanet.de ([94.134.22.195] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rvIAu-00025n-Vl; Fri, 12 Apr 2024 16:46:45 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-rockchip@lists.infradead.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-phy@lists.infradead.org
Cc: Heiko Stuebner <heiko@sntech.de>,
	Frank Wang <frank.wang@rock-chips.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Kever Yang <kever.yang@rock-chips.com>,
	Conor Dooley <conor+dt@kernel.org>,
	kernel@collabora.com,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: (subset) [PATCH v5 00/10] RK3588 USBDP support
Date: Fri, 12 Apr 2024 16:46:43 +0200
Message-Id: <171293314494.1912962.2483494926339362221.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240408225109.128953-1-sebastian.reichel@collabora.com>
References: <20240408225109.128953-1-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 9 Apr 2024 00:50:27 +0200, Sebastian Reichel wrote:
> This adds Rockchip RK3588 USBDP PHY support, which is used for two of the three
> USB3 controllers in the RK3588 (the third one uses a different PHY, which is
> already supported). The USBDP PHY offers USB3 dual-role and DisplayPort. The
> driver and bindings being upstreamed contains the DP parts, but only USB3 has
> been tested by me (upstream does not yet have a DRM DP bridge driver for this
> platform).
> 
> [...]

Applied, thanks!

[03/10] arm64: defconfig: enable Rockchip Samsung USBDP PHY
        commit: 7cdf7efefc02189cf9a228d4c5c4253d273e9b1a
[04/10] arm64: dts: rockchip: fix usb2phy nodename for rk3588
        commit: 4e07a95f7402de092cd71b2cb96c69f85c98f251
[05/10] arm64: dts: rockchip: reorder usb2phy properties for rk3588
        commit: abe68e0ca71dddce0e5419e35507cb464d61870d
[06/10] arm64: dts: rockchip: add USBDP phys on rk3588
        commit: e18e5e8188f2671abf63abe7db5f21555705130f
[07/10] arm64: dts: rockchip: add USB3 DRD controllers on rk3588
        commit: 33f393a2a990e16f56931ca708295f31d2b44415
[08/10] arm64: dts: rockchip: add USB3 to rk3588-evb1
        commit: b37146b5a555dd871cb0805446826ab2fc8d285a
[09/10] arm64: dts: rockchip: add upper USB3 port to rock-5a
        commit: af7ec140ddc1815bc462109792d95bcad05cfbc4
[10/10] arm64: dts: rockchip: add lower USB3 port to rock-5b
        commit: 494532921aacb496529d544fedfdb3a7b43dfef0

I've rearranged some things in the evb1 patch:
- vbus* before vcc*
- some newlines between properties and subnodes around
  the endpoints

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

