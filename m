Return-Path: <linux-kernel+bounces-59708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D23484FABF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F34E1C21A3A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D76180C07;
	Fri,  9 Feb 2024 17:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9WFIsh9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A8D7BB08
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 17:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707498721; cv=none; b=Uklr1QH/V17mtWahjiUWi7CT0mK8leF7NcUPp9cslKp9bkZZwiR9oF2wiQcRMlkyrDyToF77deQjRTen6Grf/4YrKLhpKoQ4S0f2UyPDebaoncw0yhEupn0eBPufP+3+M8+lPbtCgTYdDzsLkXaUC9804NTE3ZEE4ul2bbq+y4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707498721; c=relaxed/simple;
	bh=QKvQt9YWW6uZWhy9ZXSZmB6o80HZsnRJY2SXeTLZtCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fp18Ij8Rk0z7/RdcDOTZms65h4VeMA9Ei1TgalRt2L0TH1opbsLTDWBpw9MMgQXc+9JSyb+EsYxLJOaexjGY+uDFRcZJ7pMC0sYa3c/jyWWbBRY8+9Xa+L8jRdHwhKdi0hzCZnLWCIqFu9WpduY27SO/anwsDPCZO803X+v+iQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9WFIsh9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CADEDC43390;
	Fri,  9 Feb 2024 17:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707498720;
	bh=QKvQt9YWW6uZWhy9ZXSZmB6o80HZsnRJY2SXeTLZtCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z9WFIsh9rUY2t9gwyaB2PnmT4eEZUbPWSWlqv+m0mpoX5qQbhPziVmunrZhBrmYWV
	 3p/VTpPxPNb7TwVtB2zxxYzqwaAqKvyQXktd69erDVMFx3ibrFECD6SF8MoC50g1rW
	 8KwTmhKq2pGPXLB2GPxYO5Lv+PNHAoasMlcC9ZmwS+ybAyqrbLXSbpuPqmTuSptK8C
	 g8M+xp6n766X2gi9bH2jjP0EQk5rl+3lB+RUgq4vld1BtOqlASXeY72UCT1Vu46yAX
	 n+6plub8uQQrTlO9V0CAwr2Q9n2kaYh1YACbICmVxg8d3wrXgIw3cgqnreeftH8z4z
	 2NnS6km13lPOQ==
Date: Fri, 9 Feb 2024 17:11:55 +0000
From: Will Deacon <will@kernel.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Martin <Dave.Martin@arm.com>, Oleg Nesterov <oleg@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/sve: Lower the maximum allocation for the SVE
 ptrace regset
Message-ID: <20240209171155.GB25069@willie-the-truck>
References: <20240203-arm64-sve-ptrace-regset-size-v1-1-2c3ba1386b9e@kernel.org>
 <CAD=FV=XupbtO3_+P9=XO26vH_5nALSSLZZHZywPSR_hQsWxM0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=XupbtO3_+P9=XO26vH_5nALSSLZZHZywPSR_hQsWxM0Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Doug,

On Mon, Feb 05, 2024 at 09:02:08AM -0800, Doug Anderson wrote:
> Hi,
> 
> On Sat, Feb 3, 2024 at 4:18 AM Mark Brown <broonie@kernel.org> wrote:
> >
> > Doug Anderson observed that ChromeOS crashes are being reported which
> > include failing allocations of order 7 during core dumps due to ptrace
> > allocating storage for regsets:
> >
> >   chrome: page allocation failure: order:7,
> >           mode:0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO),
> >           nodemask=(null),cpuset=urgent,mems_allowed=0
> >    ...
> >   regset_get_alloc+0x1c/0x28
> >   elf_core_dump+0x3d8/0xd8c
> >   do_coredump+0xeb8/0x1378
> >
> > with further investigation showing that this is:
> >
> >    [   66.957385] DOUG: Allocating 279584 bytes
> >
> > which is the maximum size of the SVE regset. As Doug observes it is not
> > entirely surprising that such a large allocation of contiguous memory might
> > fail on a long running system.
> >
> > The SVE regset is currently sized to hold SVE registers with a VQ of
> > SVE_VQ_MAX which is 512, substantially more than the architectural maximum
> > of 16 which we might see even in a system emulating the limits of the
> > architecture. Since we don't expose the size we tell the regset core
> > externally let's define ARCH_SVE_VQ_MAX with the actual architectural
> > maximum and use that for the regset, we'll still overallocate most of the
> > time but much less so which will be helpful even if the core is fixed to
> > not require contiguous allocations.
> >
> > We could also teach the ptrace core about runtime discoverable regset sizes
> > but that would be a more invasive change and this is being observed in
> > practical systems.
> >
> > Reported-by: Doug Anderson <dianders@chromium.org>
> > Signed-off-by: Mark Brown <broonie@kernel.org>
> 
> Confirmed that when I send a "quit" signal to Chrome now that the
> allocation I see for "core_note_type" NT_ARM_SVE goes down from
> 279,584 bytes (n=17474) to just 8,768 bytes (n=548). I'm not
> intimately familiar with this code so I'll skip the Reviewed-by unless
> someone thinks it would be valuable for me to analyze more. I think
> there are already plenty of people who know this well, so for now,
> just:
> 
> Tested-by: Douglas Anderson <dianders@chromium.org>

I can pick this up as a short-term hack if it solves the problem for you,
but I also saw that you posted:

https://lore.kernel.org/r/20240205092626.v2.1.Id9ad163b60d21c9e56c2d686b0cc9083a8ba7924@changeid

to fallback onto vmalloc() for large allocations.

What's your preference for a fix?

Cheers,

Will

