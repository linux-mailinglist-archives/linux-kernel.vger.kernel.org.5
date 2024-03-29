Return-Path: <linux-kernel+bounces-124150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D46189130E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 06:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DF462883C6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 05:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F573B290;
	Fri, 29 Mar 2024 05:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="fYCQx0m7"
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929EE28EF
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 05:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711688982; cv=none; b=jlt6co9LCUNW3M+CPNPZo4gi/fMzQJAUFc+R8PJ5cofiPni3fpol4mEckY2r66EFNz6rQWErUmuAQoB3h9UYZze7MpJBTimUqvktYXXa2miIXbJ/cwDYhSstP8KVbhKgU/XWtPeLLC4Cnna1pcUm5SVzLsr5i5t8JQf3DY7DAx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711688982; c=relaxed/simple;
	bh=DppCwssZ4xsiZHArTL5mMdedI3W5aqxLYayWzYibPmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rv/7bhXs+1Sjk+VvgzXQpkkBCfCJJ0mmMJ+af8VkqoS9s8eMAKXBWjfISAQrOPI+rPIO6/qbvbVc/QNczXruuOe0GpVNZ+Z1f0WlJAUZ0KzZ0Lhwo7BnREA4PIFGAI4JWtSclydnsLDtk0TXXyr+BflAgK7ujo/LogpaPTVfOws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=fYCQx0m7; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=fYCQx0m7;
	dkim-atps=neutral
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id 5BA7F99F
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 14:09:33 +0900 (JST)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5d8bdadc79cso1352867a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 22:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1711688972; x=1712293772; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9U5x4MU5MsogFGv+KFAc9+mPRl8v6vrTZs+bcwccjek=;
        b=fYCQx0m7GzvmdnxUQsv0bjfcoR98NamQAHdRWCmfWSN4IjkAqXSUqfywsgwJh/uhgk
         FCeMVKdppy0+L1jRqtKfcICEdANEIzkDEaeaCsgZJ13NDLUP8fOou+ZieLFt0ixk+EV/
         vZ1DD2UDSQ89qBwBU7caMjLlTlaV+y/eQ5+kLye2y50LsrGn6dT1iIUUyK84DJOAbq2U
         v3bV2rzsSwuA8vtj9kFA5sFx+ezmQUUt7M0zJVGUE9AVEihS5voSWaBpgZ+cG7R+Nonl
         nm2Cnev0alYouTPGxSbARP2THFXxpoDdV5jq2pPoSoAsGJOXWo1+eK1lkYAAOeyHa/ii
         LaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711688972; x=1712293772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9U5x4MU5MsogFGv+KFAc9+mPRl8v6vrTZs+bcwccjek=;
        b=Scoq5vFKMp3hCrFDVljA0BnxZ4noGA+Z0a+BOFFlCbP0yLo7oj2hkkW1q3ME8nH8fV
         WVUWuNfmoH5pI09uZO5ueMf3NyHLSGHAY64emxcU7tq8Dx3DebGBY7VvzwDiKDDm6BaR
         elt8+cWlgBrPUUCJgbbOPCNoPm5Td7i4XeGxMhFIYjaH0LkyXrhRNy+wtVRQZ6gH7PLL
         pyBhV45MSoZNrmFvuAk/V/9sq3iCt4pPR4MhFXT+gx/+WVQzleEx9s5x5uMYVJa3iwa0
         zQ8U06NP/VrGJ37d6Xog4PLghRlcgVkIEHpTUJuxMrUYY8hR2WNn++nwcP4grOlh/84j
         0Low==
X-Forwarded-Encrypted: i=1; AJvYcCVffBsOjrfkkJf1B3KAeoxB2DQD3+KqfCfmaw/fiWT+Nl1v3lD9UtajmBaMrjUEasXsMiOpas1AnImCNaBvWbW/slGAuBHe/kjgsehs
X-Gm-Message-State: AOJu0Yxh3b2iH+y3R6g/Sb4xCSzhLGVn8aZRNwb7W4f/KgThnGuUyzGA
	+fTs1ikn4hzO076QV+hhnhg4RSBxH2swwp/ehVQONlAuVpIGijAZhSpoVsQyBy/6vRBpM3+UwvS
	DpHiyWUxAf75QzNuYvpSALZlBoipXYHy69W0Dh60bwWoTKUYq+o89VXBLnQnYbLs=
X-Received: by 2002:a17:90a:b791:b0:29d:e004:f8ce with SMTP id m17-20020a17090ab79100b0029de004f8cemr1518759pjr.6.1711688972268;
        Thu, 28 Mar 2024 22:09:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExYO+5uHJg+n48X3gcmpJ1EncBTwV76hj18e0OyLzjNe4emEQ/I+2H3cr8B2bBt0bB2pVpiA==
X-Received: by 2002:a17:90a:b791:b0:29d:e004:f8ce with SMTP id m17-20020a17090ab79100b0029de004f8cemr1518742pjr.6.1711688971844;
        Thu, 28 Mar 2024 22:09:31 -0700 (PDT)
Received: from pc-0182.atmarktech (35.112.198.104.bc.googleusercontent.com. [104.198.112.35])
        by smtp.gmail.com with ESMTPSA id v11-20020a17090a0c8b00b002a203bd94bfsm2354390pja.51.2024.03.28.22.09.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2024 22:09:31 -0700 (PDT)
Received: from martinet by pc-0182.atmarktech with local (Exim 4.96)
	(envelope-from <martinet@pc-zest>)
	id 1rq4Uc-009wii-0U;
	Fri, 29 Mar 2024 14:09:30 +0900
Date: Fri, 29 Mar 2024 14:09:20 +0900
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: mhklinux@outlook.com
Cc: hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
	konrad.wilk@oracle.com, bumyong.lee@samsung.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	will@kernel.org, petr@tesarici.cz, roberto.sassu@huaweicloud.com,
	lukas@mntmn.com
Subject: Re: [PATCH 1/1] swiotlb: Fix swiotlb_bounce() to do partial sync's
 correctly
Message-ID: <ZgZNAM337-UEY1DH@atmark-techno.com>
References: <20240327034548.1959-1-mhklinux@outlook.com>
 <ZgO3HlYWo6qXaGs8@atmark-techno.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZgO3HlYWo6qXaGs8@atmark-techno.com>

Dominique Martinet wrote on Wed, Mar 27, 2024 at 03:05:18PM +0900:
> Unfortunately that was ages ago so I don't really remember exactly on
> which device that was reproduced.. Given the Cc I'm sure Lukas had hit
> it on the MNT reform (i.MX8MQ), but I did say I tested it so I probably
> could reproduce on my i.MX8MP?
> I'll try to give a try at reproducing the old bug, and if I do test your
> fix over next week.

grmbl, sorry I cannot reproduce the problem on devices I have readily
accessible, and don't have time to dig out my reform to test there in
the forseeable future, so cannot confirm if that also fixes the problem
we reported two years ago.
However I had misunderstood your patch, I thought you were also
reverting commit 5f89468e2f06 ("swiotlb: manipulate orig_addr when
tlb_addr has offset") but you're keeping it and just making it signed --
this should cause no problem for the use case I was concerned about as
it fell within the bounds I had defined, so this is basically a no-op
patch for my usecase and I don't expect this particular failure to pop
back up here.


Code-wise, I agree the checks I added in commit 868c9ddc182b ("swiotlb:
add overflow checks to swiotlb_bounce") are too strict - I failed to
consider the device minimum alignment part of swiotlb_align_offset, and
thinking this through this can get weird.
.. And now I'm looking again even with a big minimum alignment it's
also too strict, so, right, let's work through an example.


From my understanding of how orig_addr is computed, in the multi-block
case we have something like this:

(+ represent device's minimum alignment, bigger blocks with | are
IO_TLB_SIZE blocks)

         10        20        30        40        50        60
01234567890123456789012345678901234567890123456789012345678901234...
|---+---+---+-block1+---+---+---|---+---+---+-block2+---+---+---|...
       ^                               ^                          
       mem->slots[n].orig_addr         mem->slots[n+1].orig_addr
       (=7)                            (=32+7=39)

(memo of the code with your patch:
  index = (tlb_addr - mem->start) >> IO_TLB_SHIFT;
  orig_addr = mem->slots[index].orig_addr;
  swiotlb_align_offset(dev, orig_addr) = orig_addr & dev min align mask & (IO_TLB_SIZE-1)
  tlb_offset = (tlb_addr & (IO_TLB_SIZE - 1)) - swiotlb_align_offset(dev, orig_addr);
  orig_addr += tlb_offset;
  alloc_size -= tlb_offset;
  vaddr = mem->vaddr + tlb_addr - mem->start
)

So for this example we have IO_TLB_SIZE=32, dev min alignment=4,
orig_addr's align value would be 7%4=3.
Given say tlb_addr at 33, we'd find slot n, and compute
tlb_offset = 1 - 3 = -2

.. And then I just don't follow anymore?

Computing the rest mechanically, for the example's sake let's say n=0
so mem->start=7, index=0, and also set size to 4 bytes, vaddr to 0x1000.

vaddr = 0x1000 + 33 - 7 = 0x1000 + 26
orig_addr = 7 + -2 = 5
size = 4 - -2 = 6

then we'd proceed to memcpy either (vaddr, p2v(orig_addr), size) or the
other way around, but this cannot be right:
 - size is bigger than what was requested, I fail to see how that can be
allowed. I'd understand a smaller size assuming swiotlb_bounce gets
called for each interval, but not a bigger size.
 - orig_addr is nowhere near 33.


I thought this didn't make sense because of the minimum device
alignment, but even with device alignment >= io tlb's with the very same
example we would get 
tld_offset = 1 - 7 = -6
now that one could make sense if we had used the following slot e.g.
orig_addr being slot[1].orig_addr and we'd get back to 31, but that's
not the case, and the size calculation is still off.


So, long story short it took me half a day to get back into this code
and the only thing I understand about it is that I don't understand it.

I'm sure it works most of the case because everything is nicely aligned
(since nobody complained about my checks before, and if there's no
warning with these the code works), but I'd require some convincing to
give a reviewed-by tag to this patch.

Thanks for working on this though, I'll be happy to be pointed out at
flaws in my logic or to look at another attempt...!!
-- 
Dominique

