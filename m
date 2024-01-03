Return-Path: <linux-kernel+bounces-15802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B0B82333B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A92D31C23B3D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DD51C28A;
	Wed,  3 Jan 2024 17:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUPap1lO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9911C283;
	Wed,  3 Jan 2024 17:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72774C433C7;
	Wed,  3 Jan 2024 17:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704303024;
	bh=Ju7Vq8CwuQ7jiiyXLGXUEI+QEL8KuKs42zh0z+rASmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uUPap1lOmnZZcoDn17aA8Nd55HVoqi1isFli+gdAOiYCvRBKZm3kV6DODXZqV3dQN
	 /nDvDhmFjdjQA/MmahaHI21zT33AjRILypCNBJG4A1uriIOq8ZAINhWLrW9YJXn+Kz
	 eO+wKSkeRD6KYVw8sAxMUMcAOc8gwL5oqZSe5zD9PR1tGE+yO7nY7MKdJWeueZAUs3
	 Pd4Bk8blzw16+B7IoBhzdeDHSYtx7JQvdKY5WL6sOtSHNBf7OuUmRddln8AdADXFtF
	 At8jiyYJw+898xhPXiBkt486fIHDmNiLKnQw46JUnD6uVU1Wjib88XKgtGuwetLQWC
	 7bP87sEkD5xHw==
Date: Wed, 3 Jan 2024 17:30:18 +0000
From: Will Deacon <will@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
	ARM <linux-arm-kernel@lists.infradead.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the arm-soc tree with the arm-perf
 tree
Message-ID: <20240103173018.GD5954@willie-the-truck>
References: <20240103100324.05f47bb8@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103100324.05f47bb8@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Jan 03, 2024 at 10:03:24AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the arm-soc tree got a conflict in:
> 
>   arch/arm/kernel/perf_event_v6.c
> 
> between commit:
> 
>   5cd7da19cb97 ("arm: perf: Remove PMU locking")
> 
> from the arm-perf tree and commit:
> 
>   ced296f63635 ("ARM: Delete ARM11MPCore perf leftovers")
> 
> from the arm-soc tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc arch/arm/kernel/perf_event_v6.c
> index 8fc080c9e4fb,0cbf46233d6b..000000000000
> --- a/arch/arm/kernel/perf_event_v6.c
> +++ b/arch/arm/kernel/perf_event_v6.c
> @@@ -436,35 -386,9 +373,8 @@@ static void armv6pmu_disable_event(stru
>   	val &= ~mask;
>   	val |= evt;
>   	armv6_pmcr_write(val);
>  -	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
>   }
>   
> - static void armv6mpcore_pmu_disable_event(struct perf_event *event)
> - {
> - 	unsigned long val, mask, evt = 0;
> - 	struct hw_perf_event *hwc = &event->hw;
> - 	int idx = hwc->idx;
> - 
> - 	if (ARMV6_CYCLE_COUNTER == idx) {
> - 		mask	= ARMV6_PMCR_CCOUNT_IEN;
> - 	} else if (ARMV6_COUNTER0 == idx) {
> - 		mask	= ARMV6_PMCR_COUNT0_IEN;
> - 	} else if (ARMV6_COUNTER1 == idx) {
> - 		mask	= ARMV6_PMCR_COUNT1_IEN;
> - 	} else {
> - 		WARN_ONCE(1, "invalid counter number (%d)\n", idx);
> - 		return;
> - 	}
> - 
> - 	/*
> - 	 * Unlike UP ARMv6, we don't have a way of stopping the counters. We
> - 	 * simply disable the interrupt reporting.
> - 	 */
> - 	val = armv6_pmcr_read();
> - 	val &= ~mask;
> - 	val |= evt;
> - 	armv6_pmcr_write(val);
> - }
> - 
>   static int armv6_map_event(struct perf_event *event)
>   {
>   	return armpmu_map_event(event, &armv6_perf_map,

Thanks, this looks fine to me (just remove all the 11MPCore code).

Arnd -- anything you need me to do in the perf tree here other than mention
this in my pull request?

Will

