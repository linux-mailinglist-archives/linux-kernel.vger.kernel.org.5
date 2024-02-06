Return-Path: <linux-kernel+bounces-55501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3180B84BD73
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD11C290021
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FB017984;
	Tue,  6 Feb 2024 18:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="k30q1wW2"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137F114273
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 18:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707245512; cv=none; b=WdV6m21bHKxJSbn7Jg3BaVr+nKonJSp0UmWi6GcfTfp87+zmJa8c/SHXIfPNLLjidnPd1b+UiUfcftKuhbLuvkD+hSJxkkF/8kJBLWEp99CuUqALLJMM8TElmnGtNUpu0+EPzJdseNk/BLP+fn7NqcaoY/fWUKPzMgmPP2Y/2lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707245512; c=relaxed/simple;
	bh=LslDXJksTahobFcvGlV1BM41nSqQMb1KO9O/kxAu3CQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXVfky4EE08vGTML88XvV6++ohrge8UgeoM+/MN591eqZmvmYMRIjw/LLtWnynIlih0dtAgSTyMy18Whx0591BUIKTpn6xnp0HXkd8piqbbYLvyeEHyFD5txSXup0b2Rtsu+g0r3XDyvRgz71j1i27FhjScW+pyzF6AZW8ftQYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=k30q1wW2; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a26f73732c5so846177466b.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 10:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1707245507; x=1707850307; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=621piEzSXJxB1zy3OuwwYQSE5VTqKJoLX8Sk8RtyImg=;
        b=k30q1wW2Zq2slwupivqW1cG41cbWZUiwmszkBDq47HboB/I2jHdaCIi5RhFLSHL8/0
         SajlBpdhR+Uw0tT2m43X2228VzfS6yVJIfYYG+ZsnlTSJFD0yG5xHU9jzkUaQQ2S/I/Y
         eqHAY/E4MTpF7CPW+8d0MbIT1lvwD8P+eNI0PJw1KO5Ht2+PrwTWThhax5oUN5xl75ue
         5EHN3jked36w4nRFUKqGGAr6FwxYTf5ggx53d3NVX9IZyc104tyfXT+E5C2Hpho2lpT7
         uC3eUn5MVUm50pC8u8uJ3rylW6CB5vOadpjpdxJAhcxaYCg37j/iJdz1X2qo0x2UlIgA
         yJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707245507; x=1707850307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=621piEzSXJxB1zy3OuwwYQSE5VTqKJoLX8Sk8RtyImg=;
        b=I/XyQNUiuVWZflC7hoareAf1/Zp6OAzXSVgAVtXJ+6kEznB34Vy/XAWRXIjkg8TcRM
         SfMd1AVHH6lT6CqyuYd+UNyaG0jbCBfPsD6PalkmE9pUxr52F5DMMqT4veuuj3G1Zejd
         xzxTW8Tq7OlNQcwcgllM7aYOqT/qYBR44n9IdtdOhFevu27INToN+37KaaD0ILDrRgzZ
         pGvcFmVjTf35ZKEA2Px2ch7dB6vsgsI5+MEq6qtllkXHQt4RIGxD91UW+YUugawliMRy
         TMb4MrwsY0nD+Fk6KJWuODoszMd2A3BQqpIzPzy511ux6uWTI8MJmmmhnE/xGdv56BTx
         s/oQ==
X-Gm-Message-State: AOJu0Yyta+wkFqoVrim58A6thnzhI79BSpkufcDizLSI1OWRFTrRewwP
	hMs7Mc++xefYYtzgjic9zFHi0ovY0Nc11hppeDIpMg6v33Pfvt0dKyBBlMb5etw=
X-Google-Smtp-Source: AGHT+IFxYTbMcukoiLJjcgtMqQP0qNMxgZcZgHZ9EB6ONAVjWA5ZIv/bY2lcMFyv4EZnoA07trkBcQ==
X-Received: by 2002:a17:906:f203:b0:a38:4f52:cd01 with SMTP id gt3-20020a170906f20300b00a384f52cd01mr796877ejb.53.1707245507031;
        Tue, 06 Feb 2024 10:51:47 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXonRSCCIY5Y4O6Xfex2VBrnEbn2ZuvPgDRBBu5e4QaWvVzzQ8xMfROH4BNF5caLsLivrybO1kKOvzFl3rzflZrIs+Vh1AeHerZzHq5UMt/VT+XVkXSqYLpnjJSQ0mLpj6eZbOFG0U3Vh6kpQiPn5hKmPgDX032o1+Y4g2vNIZetwUFDpPkZwmgn0+KATokEp5b/ZFQf1yx02qWOCNmMSPOJdtySva6qg==
Received: from localhost ([2620:10d:c092:400::5:310])
        by smtp.gmail.com with ESMTPSA id tj10-20020a170907c24a00b00a354a5d2c39sm1448273ejc.31.2024.02.06.10.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 10:51:46 -0800 (PST)
Date: Tue, 6 Feb 2024 19:51:45 +0100
From: Johannes Weiner <hannes@cmpxchg.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, chengming.zhou@linux.dev,
	yosryahmed@google.com, linux-mm@kvack.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/swap_state: update zswap LRU's protection range
 with the folio locked
Message-ID: <20240206185145.GA97483@cmpxchg.org>
References: <20240206180855.3987204-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206180855.3987204-1-nphamcs@gmail.com>

On Tue, Feb 06, 2024 at 10:08:55AM -0800, Nhat Pham wrote:
> When a folio is swapped in, the protection size of the corresponding
> zswap LRU is incremented, so that the zswap shrinker is more
> conservative with its reclaiming action. This field is embedded within
> the struct lruvec, so updating it requires looking up the folio's memcg
> and lruvec. However, currently this lookup can happen after the folio is
> unlocked, for instance if a new folio is allocated, and
> swap_read_folio() unlocks the folio before returning. In this scenario,
> there is no stability guarantee for the binding between a folio and its
> memcg and lruvec:
> 
> * A folio's memcg and lruvec can be freed between the lookup and the
>   update, leading to a UAF.
> * Folio migration can clear the now-unlocked folio's memcg_data, which
>   directs the zswap LRU protection size update towards the root memcg
>   instead of the original memcg. This was recently picked up by the
>   syzbot thanks to a warning in the inlined folio_lruvec() call.
> 
> Move the zswap LRU protection range update above the swap_read_folio()
> call, and only when a new page is allocated, to prevent this.
> 
> Reported-by: syzbot+17a611d10af7d18a7092@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/000000000000ae47f90610803260@google.com/
> Fixes: b5ba474f3f51 ("zswap: shrink zswap pool based on memory pressure")
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

Looks great, thanks for updating it!

One more thing I just realized:

> ---
>  mm/swap_state.c | 10 ++++++----
>  mm/zswap.c      |  1 +
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index e671266ad772..7255c01a1e4e 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -680,9 +680,10 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
>  	/* The page was likely read above, so no need for plugging here */
>  	folio = __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
>  					&page_allocated, false);
> -	if (unlikely(page_allocated))
> +	if (unlikely(page_allocated)) {
> +		zswap_folio_swapin(folio);
>  		swap_read_folio(folio, false, NULL);
> -	zswap_folio_swapin(folio);
> +	}
>  	return folio;
>  }
>  
> @@ -855,9 +856,10 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
>  	/* The folio was likely read above, so no need for plugging here */
>  	folio = __read_swap_cache_async(targ_entry, gfp_mask, mpol, targ_ilx,
>  					&page_allocated, false);
> -	if (unlikely(page_allocated))
> +	if (unlikely(page_allocated)) {
> +		zswap_folio_swapin(folio);
>  		swap_read_folio(folio, false, NULL);
> -	zswap_folio_swapin(folio);
> +	}
>  	return folio;
>  }
>  
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 4aea03285532..8c548f73d52e 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -827,6 +827,7 @@ void zswap_folio_swapin(struct folio *folio)
>  	struct lruvec *lruvec;
>  
>  	if (folio) {
> +		VM_WARN_ON_ONCE(!folio_test_locked(folio));
>  		lruvec = folio_lruvec(folio);
>  		atomic_long_inc(&lruvec->zswap_lruvec_state.nr_zswap_protected);
>  	}

The NULL check is now also no longer necessary.

It used to be called unconditionally, even if
__read_swap_cache_async() failed and returned NULL.

However, page_allocated == true implies success. That newly allocated
and locked folio is always returned.

