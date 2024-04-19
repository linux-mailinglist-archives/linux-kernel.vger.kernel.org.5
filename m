Return-Path: <linux-kernel+bounces-151038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5278AA839
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C66F41C2102A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 06:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659D110A31;
	Fri, 19 Apr 2024 06:07:11 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCCAC127
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 06:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713506831; cv=none; b=lKNiT1nJ+pcCq+OrG/+TlK128rIr+S4paUVVA38VPcSLayeB3+mZkydhKEfW9fuvAUMYBhAspGS8MM+vZzbmGQH7uDR0N4MwZR8gr0pfTWlySnwtII8/mNGxxwwV9DqnYDNccwGwC89lVJy+CtrYzv/Hv1gkiY96VXEwy+hxIrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713506831; c=relaxed/simple;
	bh=Biconojbwy/N+q5BlbJ1LpXkZO01KfzB4PWP+KgVeWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btaLLUIlT3xkF5XEaIu9eB9mMxAg8GgQCAdQBBXEoWnW8eCJYbHZxfXtHOuzcGWRbQPqjCwO2BE9z7913yiLKU+TBNTW8AJi+wZ61qgt6XspV/Zcs3hzJL5ZMnHEOpTHAAJeNcaYQw9zUndxyvkqBLgLBBNGxAgz/wJ1SDMWgxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-b8-66220a0971e6
Date: Fri, 19 Apr 2024 15:06:59 +0900
From: Byungchul Park <byungchul@sk.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, akpm@linux-foundation.org,
	ying.huang@intel.com, vernhao@tencent.com,
	mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
	david@redhat.com, peterz@infradead.org, luto@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	rjgolo@gmail.com
Subject: Re: [PATCH v9 1/8] x86/tlb: add APIs manipulating tlb batch's arch
 data
Message-ID: <20240419060659.GB48027@system.software.com>
References: <20240417071847.29584-2-byungchul@sk.com>
 <871q71ykvl.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871q71ykvl.ffs@tglx>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsXC9ZZnoS4nl1KaQdd0Dos569ewWXze8I/N
	4sWGdkaLr+t/MVs8/dTHYnF51xw2i3tr/rNanN+1ltVix9J9TBaXDixgsjjee4DJYv69z2wW
	mzdNZbY4PmUqo8XvH0DFJ2dNZnEQ8Pje2sfisXPWXXaPBZtKPTav0PJYvOclk8emVZ1sHps+
	TWL3eHfuHLvHiRm/WTzmnQz0eL/vKpvH1l92Ho1Tr7F5fN4kF8AXxWWTkpqTWZZapG+XwJVx
	e09tQR97xYx3a9gaGE+xdjFyckgImEj8WtbNBGOf+XGLDcRmEVCVON84jRHEZhNQl7hx4ycz
	iC0ioCGx8dItIJuLg1ngNZPE28tzwZqFBYIknv5tByviFbCQ+P3nMVizkICvxIVvf9kg4oIS
	J2c+YQGxmQW0JG78ewnUywFkS0ss/8cBEuYUUJJYuOoS2BhRAWWJA9uOM4HskhBYxS5xa91Z
	FohDJSUOrrjBMoFRYBaSsbOQjJ2FMHYBI/MqRqHMvLLcxMwcE72MyrzMCr3k/NxNjMA4XFb7
	J3oH46cLwYcYBTgYlXh4F8QrpgmxJpYVV+YeYpTgYFYS4TXjAArxpiRWVqUW5ccXleakFh9i
	lOZgURLnNfpWniIkkJ5YkpqdmlqQWgSTZeLglGpgXHegKJq9xGRR0UelH8tTFyUedGHIcdi0
	56/ADbYVG69/3Ns3TS/lZbFYsZiJL0c1x/dMKf09d4T2pIQ8NVyjsdzRx6I4fuLcXfO42tXO
	tGsdWbXwvVyXRl5U3UmmyVlVK48uvvHtZJB8xoLeD1PNpuuv31/G3KP8d8XGxqTVG9hjm34r
	q+sfU2Ipzkg01GIuKk4EAOfuHau/AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsXC5WfdrMvBpZRm0LXVymLO+jVsFp83/GOz
	eLGhndHi6/pfzBZPP/WxWByee5LV4vKuOWwW99b8Z7U4v2stq8WOpfuYLC4dWMBkcbz3AJPF
	/Huf2Sw2b5rKbHF8ylRGi98/gIpPzprM4iDo8b21j8Vj56y77B4LNpV6bF6h5bF4z0smj02r
	Otk8Nn2axO7x7tw5do8TM36zeMw7Gejxft9VNo/FLz4weWz9ZefROPUam8fnTXIB/FFcNimp
	OZllqUX6dglcGbf31Bb0sVfMeLeGrYHxFGsXIyeHhICJxJkft9hAbBYBVYnzjdMYQWw2AXWJ
	Gzd+MoPYIgIaEhsv3QKyuTiYBV4zSby9PJcJJCEsECTx9G87WBGvgIXE7z+PwZqFBHwlLnz7
	ywYRF5Q4OfMJC4jNLKAlcePfS6BeDiBbWmL5Pw6QMKeAksTCVZfAxogKKEsc2HacaQIj7ywk
	3bOQdM9C6F7AyLyKUSQzryw3MTPHVK84O6MyL7NCLzk/dxMjMKqW1f6ZuIPxy2X3Q4wCHIxK
	PLwL4hXThFgTy4orcw8xSnAwK4nwmnEAhXhTEiurUovy44tKc1KLDzFKc7AoifN6hacmCAmk
	J5akZqemFqQWwWSZODilGhjvfE+tafxaa3/zbFbsF32RP5KtHyrzXQ7vfyRu8V1tZdQe/XWa
	NvedzLN7Qmr9i07sEJcPm+91xC/w4kwFWcPNQZcYa35/M3y1Z4Hq3Aehd7JK1U/NE3e4baz5
	tWzj+eLrqbxGi/PUlir3XxLZt0Nltd3ve6ZGbGfOrj/gIT6ncco9/aQEeXYlluKMREMt5qLi
	RAAHI/AEpgIAAA==
X-CFilter-Loop: Reflected

On Fri, Apr 19, 2024 at 07:36:14AM +0200, Thomas Gleixner wrote:
> On Wed, Apr 17 2024 at 16:18, Byungchul Park wrote:
> > This is a preparation for migrc mechanism that needs to recognize
> > read-only tlb entries during migration by separating tlb batch arch data
> > into two, one is for read-only entries and the other is for writable
> > ones, and merging those two when needed.
> 
> I have no idea what migrc mechanism means. Please add enough context
> into the change log so the reviewer does not have to go through loops
> and hoops to figure out what this is about.

I will add a simple description explaining 'what migrc is' at every
patch mentioning migrc, from the next spin.  Thank you for the advice.

JFYI, you can see what migrc is in the following link:

   https://lore.kernel.org/lkml/20240418061536.11645-1-byungchul@sk.com/

	Byungchul

> Thanks,
> 
>         tglx

