Return-Path: <linux-kernel+bounces-120359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1BC88D641
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33A442A26FF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 06:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530491CA9C;
	Wed, 27 Mar 2024 06:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="ei1hUpqf"
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF6314A85
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 06:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711520005; cv=none; b=F6R0YewzDCb02w/m2HS+jhPY5IAH0hi94AJkGVKcJ1OTAc/HUgJLhMBzqol85/HTCHzEiCT2vJYnTsnpzaj6IEVZLSK8OquvSFo7gtCVvHovfHvOZUIdEvfddeAaSC7f3A4Pgl91257pqn5R3rno9HkpymrTs1jHUREnJneDES4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711520005; c=relaxed/simple;
	bh=viX/MdjNuAIobeKr40ksgAHoTSGRAM9jPdIN7zdjn8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYL8pWuFClKRqRq9ZKEgj2lp9weV61+9X8NBOm9L8pLWEefO2qgMQ3SBg+qnUzI9puHJ6mxNeQdbLRGxreAzRedJoKa/ynXicOmhmeihTeSEv9Rg9SIXzS/2EIeOiOcW5kkkUcZIqdwyMVaJ+tYwaw7RKueFOpXTMb+txRhilEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=ei1hUpqf; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=ei1hUpqf;
	dkim-atps=neutral
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id C4304A19
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 15:05:32 +0900 (JST)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-29ddc8a7bb3so5799246a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 23:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1711519532; x=1712124332; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2MRzFYx2tj+PDh8am8YbrNCOlZ4ErSM5bWnU774aBMM=;
        b=ei1hUpqfD/Nde95US1DgpF2kQfxgGvu4kB6lvyxcbbpPaNZdBO7KwUllG5xzQ9WQ1S
         PcaN0mxE0ogPIOl3bnSg7HPnHCzSfBsXGBW/8som3gHdQNSa3sYKkX/wsvOeSti3aRA7
         BniEupuNDB2dM+4FS8FpLcuo19JMCLeEj2s+qI+nA11bb6ch1PkAX5mNvdZ/qzJH6FPq
         nGYCh5oX2vfdPKPW+2V5UhBB+XtE9Ki6tOimOKMZ4VaHl/NMxlwUbvsAURt2NTy5rIVi
         BHyub/yTgOsempXUnc+U5SzOdQ2AWz6lbqieZd2Y25Qc7CUBVP1+hbgn/O5CdjBNiLDg
         GlJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711519532; x=1712124332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2MRzFYx2tj+PDh8am8YbrNCOlZ4ErSM5bWnU774aBMM=;
        b=IXgmyOUVw56Abx1JNqW/vSp8nb40JkkiXTWSFU/ft3qcLN0pCaFdBB/KkDAVerxGm5
         SLjGiw3CBEb0Jfaay7mLLZRFH3m7P205G5piXn8/YzirYLwiJbeMjtnxV5tIUENcUGdU
         95puE05vk7R3sul+NnNZn4vhK0tAAcrJ0vRc4+H+bVe5BKoaQQrix1Filq0rtnPi+pv/
         28Oany8P01g31XoqbMGIXRym2P0VLVN69eFtXxy/5rUXVJbxhB/Us3mDgqzDHEoG7+8J
         9At2FVt5G6cQSoRqk5Y2Tt19fimW7Q3qsUvTvNuSp9ejDo2AhQE8XC0LdBL08JwnHpbD
         Fxww==
X-Forwarded-Encrypted: i=1; AJvYcCXq4u2GzT0C1/4mQxRbOSnNsWPfJnvzjXW0UCRLPa4MDYnNYsWsyJ2+jNgswaKyHO55fbWg3yZMNtCkoBpYujgu2chF2yVmKY0snkyK
X-Gm-Message-State: AOJu0YzxzvuEv3NW3mk69CyRDvD9OBEB/ET0oMOqRJ4Mna/o1iKtDbsD
	D3xk18khaBxtGTd8rWoJsTUFDbmtSdVr+/b9raxiuiuuEYeSFBxsfBRQz6vKGIJUMYM77G7GGzU
	xT2YtPMc3dGi5SgRTaygcPuomqh+e1OoF9OL3g/exCNE/3qE6FgZomRPPm2LdUNk=
X-Received: by 2002:a17:902:edd4:b0:1e0:c3b5:1c5 with SMTP id q20-20020a170902edd400b001e0c3b501c5mr2755801plk.24.1711519531711;
        Tue, 26 Mar 2024 23:05:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBepDadg6wJlMmAAZVKUr7t2mbf/lczJuSS/IQmYJkRlC5WexwBeyWY1KBENny0IZu29L2Ow==
X-Received: by 2002:a17:902:edd4:b0:1e0:c3b5:1c5 with SMTP id q20-20020a170902edd400b001e0c3b501c5mr2755789plk.24.1711519531254;
        Tue, 26 Mar 2024 23:05:31 -0700 (PDT)
Received: from pc-0182.atmarktech (162.198.187.35.bc.googleusercontent.com. [35.187.198.162])
        by smtp.gmail.com with ESMTPSA id m11-20020a170902c44b00b001d92a58330csm8066858plm.145.2024.03.26.23.05.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2024 23:05:30 -0700 (PDT)
Received: from martinet by pc-0182.atmarktech with local (Exim 4.96)
	(envelope-from <martinet@pc-zest>)
	id 1rpMPg-002B1b-2y;
	Wed, 27 Mar 2024 15:05:28 +0900
Date: Wed, 27 Mar 2024 15:05:18 +0900
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: mhklinux@outlook.com
Cc: hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
	petrtesarik@huaweicloud.com, konrad.wilk@oracle.com,
	chanho61.park@samsung.com, bumyong.lee@samsung.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	will@kernel.org, petr@tesarici.cz, roberto.sassu@huaweicloud.com,
	lukas@mntmn.com
Subject: Re: [PATCH 1/1] swiotlb: Fix swiotlb_bounce() to do partial sync's
 correctly
Message-ID: <ZgO3HlYWo6qXaGs8@atmark-techno.com>
References: <20240327034548.1959-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240327034548.1959-1-mhklinux@outlook.com>

H Michael,

mhkelley58@gmail.com wrote on Tue, Mar 26, 2024 at 08:45:48PM -0700:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> In current code, swiotlb_bounce() may do partial sync's correctly in
> some circumstances, but may incorrectly fail in other circumstances.
> The failure cases require both of these to be true:
> 
> 1) swiotlb_align_offset() returns a non-zero "offset" value
> 2) the tlb_addr of the partial sync area points into the first
> "offset" bytes of the _second_ or subsequent swiotlb slot allocated
> for the mapping
> 
> Code added in commit 868c9ddc182b ("swiotlb: add overflow checks
> to swiotlb_bounce") attempts to WARN on the invalid case where
> tlb_addr points into the first "offset" bytes of the _first_
> allocated slot. But there's no way for swiotlb_bounce() to distinguish
> the first slot from the second and subsequent slots, so the WARN
> can be triggered incorrectly when #2 above is true.
> 
> Related, current code calculates an adjustment to the orig_addr stored
> in the swiotlb slot. The adjustment compensates for the difference
> in the tlb_addr used for the partial sync vs. the tlb_addr for the full
> mapping. The adjustment is stored in the local variable tlb_offset.
> But when #1 and #2 above are true, it's valid for this adjustment to
> be negative. In such case the arithmetic to adjust orig_addr produces
> the wrong result due to tlb_offset being declared as unsigned.
> 
> Fix these problems by removing the over-constraining validations added
> in 868c9ddc182b. Change the declaration of tlb_offset to be signed
> instead of unsigned so the adjustment arithmetic works correctly.
> 
> Tested with a test-only hack to how swiotlb_tbl_map_single() calls
> swiotlb_bounce(). Instead of calling swiotlb_bounce() just once
> for the entire mapped area, do a loop with each iteration doing
> only a 128 byte partial sync until the entire mapped area is
> sync'ed. Then with swiotlb=force on the kernel boot line, run a
> variety of raw disk writes followed by read and verification of
> all bytes of the written data. The storage device has DMA
> min_align_mask set, and the writes are done with a variety of
> original buffer memory address alignments and overall buffer
> sizes. For many of the combinations, current code triggers the
> WARN statements, or the data verification fails. With the fixes,
> no WARNs occur and all verifications pass.

Thanks for the detailed analysis & test, and sorry I didn't reply to
your mail last week.
For everyone's benefit I'll reply here (question was "what were the two
bad commits for"), it's that the previous rework introduced a regression
with caamjr on unaligned mappings that I had reported here:
https://lore.kernel.org/lkml/YL7XXNOnbaDgmTB9@atmark-techno.com/#t

(took me a while to find the threads, Link: tags have been sparse...)

Unfortunately that was ages ago so I don't really remember exactly on
which device that was reproduced.. Given the Cc I'm sure Lukas had hit
it on the MNT reform (i.MX8MQ), but I did say I tested it so I probably
could reproduce on my i.MX8MP?
I'll try to give a try at reproducing the old bug, and if I do test your
fix over next week.


> 
> Fixes: 5f89468e2f06 ("swiotlb: manipulate orig_addr when tlb_addr has offset")
> Fixes: 868c9ddc182b ("swiotlb: add overflow checks to swiotlb_bounce")
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
> This patch is built against the 6.9-rc1 tree plus Petr Tesarik's
> "swiotlb: extend buffer pre-padding to alloc_align_mask" patch
> that's in-flight.
> 
>  kernel/dma/swiotlb.c | 30 +++++++++++++-----------------
>  1 file changed, 13 insertions(+), 17 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index d7a8cb93ef2d..d57c8837c813 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -863,27 +863,23 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
>  	size_t alloc_size = mem->slots[index].alloc_size;
>  	unsigned long pfn = PFN_DOWN(orig_addr);
>  	unsigned char *vaddr = mem->vaddr + tlb_addr - mem->start;
> -	unsigned int tlb_offset, orig_addr_offset;
> +	int tlb_offset;
>  
>  	if (orig_addr == INVALID_PHYS_ADDR)
>  		return;
>  
> -	tlb_offset = tlb_addr & (IO_TLB_SIZE - 1);
> -	orig_addr_offset = swiotlb_align_offset(dev, 0, orig_addr);
> -	if (tlb_offset < orig_addr_offset) {
> -		dev_WARN_ONCE(dev, 1,
> -			"Access before mapping start detected. orig offset %u, requested offset %u.\n",
> -			orig_addr_offset, tlb_offset);
> -		return;
> -	}
> -
> -	tlb_offset -= orig_addr_offset;
> -	if (tlb_offset > alloc_size) {
> -		dev_WARN_ONCE(dev, 1,
> -			"Buffer overflow detected. Allocation size: %zu. Mapping size: %zu+%u.\n",
> -			alloc_size, size, tlb_offset);
> -		return;
> -	}
> +	/*
> +	 * It's valid for tlb_offset to be negative. This can happen when the
> +	 * "offset" returned by swiotlb_align_offset() is non-zero, and the
> +	 * tlb_addr is pointing within the first "offset" bytes of the second
> +	 * or subsequent slots of the allocated swiotlb area. While it's not
> +	 * valid for tlb_addr to be pointing within the first "offset" bytes
> +	 * of the first slot, there's no way to check for such an error since
> +	 * this function can't distinguish the first slot from the second and
> +	 * subsequent slots.
> +	 */
> +	tlb_offset = (tlb_addr & (IO_TLB_SIZE - 1)) -
> +		     swiotlb_align_offset(dev, 0, orig_addr);
>  
>  	orig_addr += tlb_offset;
>  	alloc_size -= tlb_offset;

-- 
Dominique Martinet | Asmadeus

