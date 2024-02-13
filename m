Return-Path: <linux-kernel+bounces-64333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D59853D2E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A085A1F216D5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1517061673;
	Tue, 13 Feb 2024 21:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="AdSqnfaq"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE556166B
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707859875; cv=none; b=qxivPZnkr6pG1XNittHsAoEo4bvHDXaLe8ne3Cx4QX86KQ9EBLSSkMIceGSuXXYKCvvfA84Vd/91iFYLcrYRtix7dEQL+nAEbRbUyuT1cKTpc3rMghELXYEbmny3gTeGs6lBySOsqG2hnr3YLWDH1zE+SBw/9DcqVlo503I4UeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707859875; c=relaxed/simple;
	bh=vofXMPJrQC+q6/Lnct60uFCq3gSpscykTf56gJnkQAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bIef4Y9NGB6pTTCrsKtHZWZ/9I8kPB2PH4q3aI9061RTLPcNFu5TCEWbwldQJy3znN9jsYj7slDxzBVQsB69L1ruYqI9z6kIQne+HVx+MNBRMJDsk3VWf/A4JgGKJptrjkJ/+tlUMn8VwikYYnv26VIzAFU+kzt5BCSRxB+1dJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=AdSqnfaq; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-785d453c8e9so160627585a.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 13:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1707859872; x=1708464672; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PYDJgiAqQGDP9GzbDPgSy0bCIuBLtER9XQ6AW4LDXW4=;
        b=AdSqnfaqpfOI//YAy9DBjF52QL1Ex6l9hEMA7C00UOKWPwg4mQ2A0pEijdIJsT6oyO
         1tcv6h1hndZGBe1MTflKpWVNl/Kw9PfoM4m/+UiQ1CdLHIQVetVajDhBLiRJGcdGlW7l
         Kboksf1IWu8rFuw0tr5zb7djmEfmztko+jn3HTIquBgFIKVVn0M0kY7cmsFbif9jo+oy
         BnUZaYIXb/q0L+2rpaLNSEldetPhD3TV/1unzVdpES7EJrpkVbVg/3Ke7Htf6Ka77EX/
         2ItH0jFqEpZvyRFfLNR2k7tTvKodINoZezEC2cHfD2CkXxp/iqQq8/rQ1vxZkw6WazM0
         vQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707859872; x=1708464672;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PYDJgiAqQGDP9GzbDPgSy0bCIuBLtER9XQ6AW4LDXW4=;
        b=bhxSUdpxzMoKyhxttG7kNfbwgJ6ZNRL3ZpoPp1ZQLWrOnB3tdmBwA+AxKNWtvvfQT8
         pXmQm2uBQ1mbV7ItyD3yLnIc5MGjF7DjuZsAgBKzSyfzxJtuXNu/NQzmO7xiUjUeyd59
         msWW9+k0ZesAmd+R56IzEhZmG4LP8+5pxmw5KurJ6FHBEGq5IDcLFufNNcF0N+G+oNfD
         uN0xGbwkBG71TqaUZtDW4yxqjNcwCXw0mnWtCHCnR3FTws4C3A6blFg4G2isXyNhN//s
         REoXTREkL663icb1k6o3xKQfK9t1nLuT9OyhUBfdPTp+wWSNrzpagSpAMGH0wlwPxsqq
         FKyA==
X-Forwarded-Encrypted: i=1; AJvYcCXCjiPc7uNcQvipspKANowWXZ7Th0wQ6d3+2HIZXwJQxRx3h4KxtHJgrgD1BOxZ3Z5WgHM9txtie+bzohl6oNvIoU3IOyxywSYcDKE8
X-Gm-Message-State: AOJu0YxapXVTFPI9aIIhW6Ry9U3dkTOMKXADuwlE7LY7F+cmxymalNbM
	tfOyoTWjq1oYp/W6EOaoEZk4epy62ORLOTv6cyBusHJ7UShWl3XZNg/WlMBQV0Y=
X-Google-Smtp-Source: AGHT+IHX5ZndTgR3eB3QRccjYFz6p/B01Rxl6VSza90Zs12k6nHa+nYxGtGAK3tnBpKEI6San/qQng==
X-Received: by 2002:a05:620a:4590:b0:787:1631:6920 with SMTP id bp16-20020a05620a459000b0078716316920mr1029472qkb.34.1707859872527;
        Tue, 13 Feb 2024 13:31:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU+BDpt4pBjCo/TnTlQWv/RqyO2ITx8HDD405KDduEgmwpfU99upKZQBNXadPD86wkWEO518ONVRpCM19z3Mggm5L4+2fTCH2q2L7NeRVMflHX4HjAkuguQvFriU5HKvtXBpcYrICdOOVZV6DMMiBp+p8trk4/JBFLJOcLEk/vI0Yd7Awn8tB0tXj/C7hECIhcF
Received: from [100.64.0.1] ([170.85.8.192])
        by smtp.gmail.com with ESMTPSA id v15-20020a05620a122f00b00785d3729eb0sm2265833qkj.41.2024.02.13.13.31.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 13:31:12 -0800 (PST)
Message-ID: <2d4d939d-4b49-44d7-8405-e075de844884@sifive.com>
Date: Tue, 13 Feb 2024 15:31:10 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] riscv/barrier: Consolidate fence definitions
Content-Language: en-US
To: Eric Chan <ericchancf@google.com>, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240213200923.2547570-1-ericchancf@google.com>
 <20240213201210.2549488-1-ericchancf@google.com>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20240213201210.2549488-1-ericchancf@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Eric,

On 2024-02-13 2:12 PM, Eric Chan wrote:
> Disparate fence implementations are consolidated into fence.h.
> Also introduce RISCV_FENCE_ASM to make fence macro more reusable.
> 
> Signed-off-by: Eric Chan <ericchancf@google.com>
> ---
> v3 -> v4: fix the form that can pass the checking of checkpatch.pl.
>  arch/riscv/include/asm/atomic.h  |  8 ++------
>  arch/riscv/include/asm/barrier.h |  3 +--
>  arch/riscv/include/asm/cmpxchg.h |  1 -
>  arch/riscv/include/asm/fence.h   | 10 +++++++---
>  arch/riscv/include/asm/io.h      |  8 ++++----
>  arch/riscv/include/asm/mmio.h    |  5 +++--
>  arch/riscv/include/asm/mmiowb.h  |  2 +-
>  7 files changed, 18 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
> index 31e6e2e7cc18..19050d13b6c1 100644
> --- a/arch/riscv/include/asm/atomic.h
> +++ b/arch/riscv/include/asm/atomic.h
> @@ -17,13 +17,9 @@
>  #endif
> 
>  #include <asm/cmpxchg.h>
> -#include <asm/barrier.h>
> 
> -#define __atomic_acquire_fence()					\
> -	__asm__ __volatile__(RISCV_ACQUIRE_BARRIER "" ::: "memory")
> -
> -#define __atomic_release_fence()					\
> -	__asm__ __volatile__(RISCV_RELEASE_BARRIER "" ::: "memory");
> +#define __atomic_acquire_fence()	RISCV_FENCE(r, rw)
> +#define __atomic_release_fence()	RISCV_FENCE(rw, r)

This change removes the omit-the-fence-on-uniprocessor optimization, like you
added some instances of in your previous patch. Should we keep this optimization?

Regards,
Samuel


