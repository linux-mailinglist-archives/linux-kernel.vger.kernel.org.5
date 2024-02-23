Return-Path: <linux-kernel+bounces-78126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 278D5860F38
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDCCA284D7F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756555D467;
	Fri, 23 Feb 2024 10:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXVBU0MY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37E6D533;
	Fri, 23 Feb 2024 10:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708684100; cv=none; b=uTQ68hciDnCDHCc7NGaiOdcUX1xsX0Zr7hWj8JsKIhDJibq0xZPYMc3dzUUXo2637RtLC9oHdYot9ssq8hYLKwc0PNhFnRIgLQ409HN5XHb0SqXDfsEMRSgTZ7ZrqVHKeLlGLcTYzK6Jafh8G1FmWoUf6NTdqs7ZyBSI0W3fSoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708684100; c=relaxed/simple;
	bh=fc/IO+eE7eVNyzFhiC5OvGH6nnC+0hs/rN3nzL1D/Ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nyeNnTa7rDfhBhFHcClINR5SiaRvxXgg0h1rcOrZjh0hs/jk5XlBvPkQ17KrH/nKVo9NxS+rFHxjDyng2ztiKOFozZ7rQ8N/w7nBUwkHJ/0Y8Xg/6U8akUgYEnhsdHmwLON6K4bnhvrVf5MXZcYvUo6XEitBZZS5lhW6XTjq+Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXVBU0MY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E265C433F1;
	Fri, 23 Feb 2024 10:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708684100;
	bh=fc/IO+eE7eVNyzFhiC5OvGH6nnC+0hs/rN3nzL1D/Ms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lXVBU0MYQdiFDIm1L15t41/Ej875c0PC0VylFPNtRbU0aHL4PBdLyZHBBVszWnlfO
	 ud4t1kY2PDj8nW/XHuc4XPvtL83NEC6bhUpWwoItHP1Ki6ky492oC5/WG4xGein30W
	 9la4+fpneXjH8/ON2HHQEO/+XZCZ6/qi/YFAMUj/7n4L2a8l+mg1mDGyLhva6h8zMm
	 QvzaDDcwHID1gPUv8Haodjtre9ngzHUQcrAcoTf40Qoc6nkF6a40pAg0mwpiffVVFJ
	 4/bZmy68KI+7QAsoiClhS5t62kQFRDa780HzR4keBq8eGx1UD8vipZq/ppUgRF7aTr
	 v1KzXoYlNbNng==
Date: Fri, 23 Feb 2024 10:28:14 +0000
From: Lee Jones <lee@kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Aren Moynihan <aren@peacevolution.org>, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
	Chen-Yu Tsai <wens@csie.org>, Ondrej Jirman <megi@xff.cz>,
	linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	linux-leds@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Miles Alan <m@milesalan.com>, Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v2 1/4] leds: rgb: leds-group-multicolor: allow leds to
 stay on in suspend
Message-ID: <20240223102814.GN10170@google.com>
References: <20240206185400.596979-1-aren@peacevolution.org>
 <Zde+Sce+PAuC1U6g@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zde+Sce+PAuC1U6g@duo.ucw.cz>

On Thu, 22 Feb 2024, Pavel Machek wrote:

> Hi!
> 
> > If none of the managed leds enable LED_CORE_SUSPENDRESUME, then we
> > shouldn't need to set it here. This makes it possible to use multicolor
> > groups with gpio leds that enable retain-state-suspended in the device
> > tree.
> > 
> > Signed-off-by: Aren Moynihan <aren@peacevolution.org>
> 
> Thanks for the series.
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>
> 
> Note this will change userland API and maybe break the LED for code
> expecting old setup and hardcoding paths. I guess we should not
> backport this to stable. But we should do this, because it is really
> one LED and not three.

Thanks Pavel.

Is this tied to the other patches in the set?

Will thing break if this is applied on its own?

-- 
Lee Jones [李琼斯]

