Return-Path: <linux-kernel+bounces-41178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C19D683ECF6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 12:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52808B2307E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 11:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44052033E;
	Sat, 27 Jan 2024 11:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="B1cO5iIC"
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4315200BF;
	Sat, 27 Jan 2024 11:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706355827; cv=none; b=QD2mxO+EfTw5xF+JVMdr71x3nkX51L8U3c9/i7EK1RRMBMmLRq8m8hingGb7C/Nj2kzwmh+F5KlRMKtVwB1nOU2G58Y7CELE8MkvLatNXmA1Y3Oiyd3wQenzkm2/T8DLEoK5T2UkWIWy7RgRTRKZ33R9zwipZJMxfuB/Wll1sIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706355827; c=relaxed/simple;
	bh=DwL4arpEzXWec++owa4mghw2Jbc0zA8jYLA9Oc9uFco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qy2wF8iktuOuu/Vba2aH/1ZEV7d3jD3BMmel5mYRanF73KJXc502sNdE1VdGUAg3eGr2LBuC80cm1odAwUeOcIlRZxVKaUl0Wt2biABcw1ueF/JRXqve/XhOqebfgT/d2RhwBQ7Odq8Z3iOF5pv2dGra6SLcAnGKUHXPFnF3hck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=B1cO5iIC; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4TMXZk1VqjzDqFf;
	Sat, 27 Jan 2024 11:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1706355391; bh=DwL4arpEzXWec++owa4mghw2Jbc0zA8jYLA9Oc9uFco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B1cO5iICyRmgAJiJG9CFWboHg9qYa2wTt56r24VzWxhNPvQyh3G6YLKd8ycOTZGpA
	 EXvdnQ04gJc0HuOXoK3pubBBkT9OGygapXT3To0cQTnNFzoHpdiPKCJPmoLliKPNzP
	 lrBDkjOpiPoWx/gtI3RPuqzNLSla2qC0h6IxBquU=
X-Riseup-User-ID: DEFF9060E8EA107706D83953584E1815F0490610DEB87FA764577ACB26A6E682
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4TMXZF6PvXzJp9g;
	Sat, 27 Jan 2024 11:36:05 +0000 (UTC)
From: Dang Huynh <danct12@riseup.net>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Sandy Huang <hjc@rock-chips.com>, Mark Yao <markyao0591@gmail.com>,
 Diederik de Haas <didi.debian@cknow.org>,
 Segfault <awarnecke002@hotmail.com>, Arnaud Ferraris <aferraris@debian.org>,
 Ondrej Jirman <megi@xff.cz>, Manuel Traut <manut@mecka.net>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, Manuel Traut <manut@mecka.net>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 0/4] arm64: rockchip: Pine64 PineTab2 support
Date: Sat, 27 Jan 2024 18:35:50 +0700
Message-ID: <6035442.lOV4Wx5bFT@melttower>
In-Reply-To: <20240127-pinetab2-v4-0-37aab1c39194@mecka.net>
References: <20240127-pinetab2-v4-0-37aab1c39194@mecka.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Manuel,

Since the BOE patches have been accepted to next, you do not need to include 
it in this patch series.

Best regards,
Dang

On Saturday, January 27, 2024 4:48:41 PM +07 Manuel Traut wrote:
> - BOE TH101MB31IG002 LCD Panel:
>   * Picked patches from https://anongit.freedesktop.org/git/drm/drm-misc.git
> (drm-misc-next)



