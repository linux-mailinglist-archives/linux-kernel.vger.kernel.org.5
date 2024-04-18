Return-Path: <linux-kernel+bounces-149950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 652F18A983C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 511FDB23F45
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9641615E7EA;
	Thu, 18 Apr 2024 11:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtBUCCud"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23C215E5C6;
	Thu, 18 Apr 2024 11:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713438459; cv=none; b=muRpHdHgn2kwDM6rqMJihiUHwDHvUX3rJsId/y6CAryoacJMcD+b/3lOq9gz0yuxb5qF4Az0URjOfLAQAT21Vmtv48nobWpHADJWDc1kOu2XNlApPPxPFisOJYSOkANq10a9WTGTaQ1l6yjsHWXapvrjT8KR0WMiG/79rUDdmVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713438459; c=relaxed/simple;
	bh=zwXcSp+gS+V/zeI7KiXiX9qGQJloCCeFDJ8XC9FCmp8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FBy7D7P6s7lsXhV5axLLI+EFfY7xYy3CGGIfdwc0nBTQDPKomoxDrwQPzdB65NDQHLwODOqnP2t3+pul/K0y0t2K99rqbjanVnRbMMYVryGjOj7X909KC0j52op3+5ia2f/60TDZvvR7HU/r0XkWiEMyPd6Nk/3LQ87dBfhQDM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtBUCCud; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340B6C4AF08;
	Thu, 18 Apr 2024 11:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713438459;
	bh=zwXcSp+gS+V/zeI7KiXiX9qGQJloCCeFDJ8XC9FCmp8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WtBUCCudLJbry0qzPtwylXf2XGuGsS9YFZZbVBKyb4nwXE9SbJPICMdSz17v5pxpQ
	 zHMRtYfZqNy8jVXfppLtkwfowLAiAnDXlQFRDsgFJThXqFJO5h3zoSsvYjRlEMLzAx
	 9LXQ6/oTWKWqsKJRc3vDNEzH4kYvhm8PMnO/2O86+TtjGbI0mDRKn1qKcM1i53BaD7
	 cxUXY2nD7xItggFx0zxzRcrcPku0l6YxKUng3U7W95PmU5T9CGOmmgyciRByFeKSMS
	 0HWc5L4ytm1JZ0cJPT3mJopkclbM0rRRltrI9Q7mBDJWZkjWVJ7tY+CxB9RRvdEunj
	 PByS17Na8RLYg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1rxPc8-005iIG-CB;
	Thu, 18 Apr 2024 12:07:36 +0100
Date: Thu, 18 Apr 2024 12:07:35 +0100
Message-ID: <86sezjq688.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	stable@vger.kernel.org,
	patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuah@kernel.org,
	patches@kernelci.org,
	lkft-triage@lists.linaro.org,
	pavel@denx.de,
	jonathanh@nvidia.com,
	f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net,
	rwarsow@gmx.de,
	conor@kernel.org,
	allen.lkml@gmail.com,
	Yihuang Yu <yihyu@redhat.com>,
	Gavin Shan <gshan@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Shaoqin Huang <shahuang@redhat.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH 6.6 000/122] 6.6.28-rc1 review
In-Reply-To: <Zh61KobDt_y1O46-@arm.com>
References: <20240415141953.365222063@linuxfoundation.org>
	<Zh5UJh31PlBkpZWd@finisterre.sirena.org.uk>
	<CA+G9fYu-AjRm-BBA=8fWS8oCbBJ5W443JHPh3uddD7ea7MY-YA@mail.gmail.com>
	<86y19dqw74.wl-maz@kernel.org>
	<Zh61KobDt_y1O46-@arm.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.2
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: catalin.marinas@arm.com, naresh.kamboju@linaro.org, gregkh@linuxfoundation.org, broonie@kernel.org, stable@vger.kernel.org, patches@lists.linux.dev, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, yihyu@redhat.com, gshan@redhat.com, ryan.roberts@arm.com, anshuman.khandual@arm.com, shahuang@redhat.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, anders.roxell@linaro.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Tue, 16 Apr 2024 18:28:10 +0100,
Catalin Marinas <catalin.marinas@arm.com> wrote:
> 
> On Tue, Apr 16, 2024 at 02:22:07PM +0100, Marc Zyngier wrote:
> > On Tue, 16 Apr 2024 14:07:30 +0100,
> > Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > > On Tue, 16 Apr 2024 at 16:04, Mark Brown <broonie@kernel.org> wrote:
> > > > On Mon, Apr 15, 2024 at 04:19:25PM +0200, Greg Kroah-Hartman wrote:
> > > > > This is the start of the stable review cycle for the 6.6.28 release.
> > > > > There are 122 patches in this series, all will be posted as a response
> > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > let me know.
> > > >
> > > > The bisect of the boot issue that's affecting the FVP in v6.6 (only)
> > > > landed on c9ad150ed8dd988 (arm64: tlb: Fix TLBI RANGE operand),
> > > > e3ba51ab24fdd in mainline, as being the first bad commit - it's also in
> > > > the -rc for v6.8 but that seems fine.  I've done no investigation beyond
> > > > the bisect and looking at the commit log to pull out people to CC and
> > > > note that the fix was explicitly targeted at v6.6.
> > > 
> > > Anders investigated this reported issues and bisected and also found
> > > the missing commit for stable-rc 6.6 is
> > > e2768b798a19 ("arm64/mm: Modify range-based tlbi to decrement scale")
> > 
> > Which is definitely *not* stable candidate. We need to understand why
> > the invalidation goes south when the scale go up instead of down.
> 
> If you backport e3ba51ab24fd ("arm64: tlb: Fix TLBI RANGE operand")
> which fixes 117940aa6e5f ("KVM: arm64: Define
> kvm_tlb_flush_vmid_range()") but without the newer e2768b798a19
> ("arm64/mm: Modify range-based tlbi to decrement scale"), it looks like
> "scale" in __flush_tlb_range_op() goes out of range to 4. Tested on my
> CBMC model, not on the actual kernel. It may be worth adding some
> WARN_ONs in __flush_tlb_range_op() if scale is outside the 0..3 range or
> num greater than 31.
> 
> I haven't investigated properly (and I'm off tomorrow, back on Thu) but
> it's likely the original code was not very friendly to the maximum
> range, never tested. Anyway, if one figures out why it goes out of
> range, I think the solution is to also backport e2768b798a19 to stable.

I looked into this, and I came to the conclusion that this patch is
pretty much incompatible with the increasing scale (even if you cap
num to 30).

The number of pages to invalidate is a 20 bit quantity, a 5 bit slice
per scale. With the 6.6 approach (limit of num=30 and increasing
scale), we invalidate each 5 bit slice independently. After each
scale round, the corresponding slice is guaranteed to be 0.

With the 6.9 method, we invalidate the maximum possible for a given
scale. With a decreasing scale, we converge towards 0 or 1 on each
round.  With an increasing scale, this breaks spectacularly, because
the strong guarantee that the remaining page count is "aligned" to
2^(5*scale+1) is not valid anymore (the low bits may not be 0).

As a result, we don't converge because we never consider these low
bits anymore, the page count doesn't decrease, scale goes past 3, and
everything catches fire.

So despite my earlier comment, it looks like picking e2768b798a19 is
the right thing to do *if* we're taking e3ba51ab24fd into 6.6-stable.

Otherwise, we need a separate fix, which Ryan initially advocating for
initially.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.

