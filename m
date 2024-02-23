Return-Path: <linux-kernel+bounces-77569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E8A8607A0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24478286639
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41ACD1C13;
	Fri, 23 Feb 2024 00:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzHm2f57"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F49219B;
	Fri, 23 Feb 2024 00:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708647887; cv=none; b=rQNpi1d2WAg2ro3a0QGCZzh2uuCiwB9IgvYAFqfiyfoswwXmxM7XYAttcW3QiRN94IIZhdijAhEb0k3kdIhfMXJ/Qa9+qFZE1gdkj6Ce005V3lCGOlQklBFMic1qCUGE1puog4YQedgAJSEYU8gqgULjI4V1SvhFj3MUGZlmWDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708647887; c=relaxed/simple;
	bh=6RQYh1c+2WGB747k5Q8GGgtAQbYiwufgRsISUMvWeQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXXaIGC0g8TKPpM89ut1vs3rEwOz0Bw5M32mtAqAS+6oFq1q0DaRw3j5dv8KPvBTUihMRvTnaAQvj4AkZE2K1Y70iXZuM37B9OOIbnfSLltDdk7eSrUYt5gVkB6k7HaXxxYJhTTF26wlRgZ094//X6nrwMiuF1R1sSB85LaFEJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzHm2f57; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F619C433C7;
	Fri, 23 Feb 2024 00:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708647887;
	bh=6RQYh1c+2WGB747k5Q8GGgtAQbYiwufgRsISUMvWeQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gzHm2f57w8oQ2CKM9OBagrwZLTrD/zFgJ4JyVHlKPWO7vG6JD5bPJ+V4ArEaOdbyg
	 g55eElDLh8+jCDJIrQdkzYfyeU15LGZk+un8e1MufskvuEmF0zGYZOoIVxbvdnIHL3
	 hNFph744wKpQzIEszSlMJALrD6ZIrDHo06Sx+VkWneFq8paQjxGNBXBAtyIpdecsmf
	 6VrQFclphPwRR4h9C3JsqeeltI5YpWw+bsib9axBuWFi/TDBsET+mmFsGMZEeqbb6I
	 TFASGZSvtjh1zJflNpr2PSHrDqYNiDrqrF4HYvi38csYMuRaq+pltiBTZBzl2R+mkk
	 XMmyR2Zll5IZA==
Date: Thu, 22 Feb 2024 17:24:43 -0700
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Conor Dooley <conor@kernel.org>, Alex Soo <yuklin.soo@starfivetech.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Hal Feng <hal.feng@starfivetech.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	Jianlong Huang <jianlong.huang@starfivetech.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Drew Fustini <drew@beagleboard.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [RFC PATCH v2 1/6] dt-bindings: pinctrl: starfive: Add JH8100
 pinctrl
Message-ID: <20240223002443.GA3877354-robh@kernel.org>
References: <20240220064246.467216-1-yuklin.soo@starfivetech.com>
 <20240220064246.467216-2-yuklin.soo@starfivetech.com>
 <1a11cee2-2ef1-4ce0-8cc1-63c6cc97863f@linaro.org>
 <20240220-bottling-reverence-e0ee08f48ccc@spud>
 <cafccf8d-b8f7-44cb-bc41-3c7a908fd1e4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cafccf8d-b8f7-44cb-bc41-3c7a908fd1e4@linaro.org>

On Wed, Feb 21, 2024 at 08:24:26AM +0100, Krzysztof Kozlowski wrote:
> On 20/02/2024 20:10, Conor Dooley wrote:
> > On Tue, Feb 20, 2024 at 09:11:43AM +0100, Krzysztof Kozlowski wrote:
> >> On 20/02/2024 07:42, Alex Soo wrote:
> >>> Add documentation and header file for JH8100 pinctrl driver.
> >>>
> >>> Signed-off-by: Alex Soo <yuklin.soo@starfivetech.com>
> >>> ---
> >>
> >>
> >> RFC? Why isn't this patch ready for review?
> > 
> > The TL;DR is that Emil and I didn't want to apply the dts patches to
> > support a platform that hadn't actually been taped out yet. 
> > For an SoC in that state, at least the bindings for, clock and pinctrl
> > could be subject to changes before tapeou. I think putting RFC on those
> > patches is a good idea, but of course the rationale should be mentioned.
> 
> That would be useful information. We also could mark some bindings
> unstable and accept breaking ABI under certain conditions, like that it
> is early work without users for long time.

The challenge with that is when do things get marked stable? No one has 
any motivation to do that (unless users complain). For example, We have 
a couple of platforms that have an unstable bindings statement that has 
been there "forever".

I would like a solution though. The only idea I have is passing 
SystemReady cert, but that's an Arm thing.

Rob

