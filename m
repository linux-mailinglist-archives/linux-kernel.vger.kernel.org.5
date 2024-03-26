Return-Path: <linux-kernel+bounces-119954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EABE88CF62
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFBF21C3E4F3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411867442F;
	Tue, 26 Mar 2024 20:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="1JEN3Z3q"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DB21E884
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 20:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711486125; cv=none; b=U6FLyDPdqKT4ENFdJAW6wtTqRKBAr86WoB4swPk9Qk7YfGD+ASw0tdD16EN7RBnWK496KrZ6bokJM/nU7OftyKb4TVLBB0630SLIsLojTX4Ls677KoHJaQGnp6I3qwWoKXIy1WMCawahopF+Q0KboIDWpHRFpn+yABxkvG4lQeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711486125; c=relaxed/simple;
	bh=fVfFdufsWoF4rohhGO8RKrU2Zxn010PzePDhim2rFZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VChj8wu7BDLMzrYHRanaxCK6lW6k1cTDtRrB4EaDHQaS0fPl2afamcjqU+AE2EEfqapGUqvcg+L8uTRUkXebJFUCfXCGemVMn4jBCsUOtcNkW6dzzzdrvrVWinnhoe5Q57qV9OccS06IkQ7USTl1Dohgeuoo4ozvER4tlF/7FRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=1JEN3Z3q; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c3d67db82aso974914b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 13:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1711486121; x=1712090921; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qadrCkOfGnwpKmFdNNDGiamy9oOJd+0dFbMg7rAWkqE=;
        b=1JEN3Z3qV808vFxPIZZGuqrXNGVNNzJynSxj4uRXgTavYVLlZ/qsfbcyOL/OhpnIvU
         +37zw0mlN8h7YmHmysWyb1YP+T8XojDKbqD4JEcOExvr2HW5Q1h7YorALIYdNKT8h23B
         0OiVDDWNBlCesb/F6F8nKKfwsDCG1WT97Q5xZAEsSUzH/mjpddsGqmzbF/j64WZxQagy
         S1taQRFYoNalGqtAfIv1wZ/L0SjimCdpkgU5TfgMiaREwsoZ9ksTmpJ0CoBCX1jqEYqc
         KmxhTB1nbE673bz9+933/FEvdiN/efH4zi/k4YvcdOzJnj6lGB5NZ3nh1Shzf4r9YzZM
         +rug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711486121; x=1712090921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qadrCkOfGnwpKmFdNNDGiamy9oOJd+0dFbMg7rAWkqE=;
        b=HYac/o5uT02m+ZCGzXlo6AGEvQmnh09btK31iuBbqOYo4nTQhtVUC14qGLp97bI3rY
         JkXlh1361WhciRDEA7zXlrcPnKNoglUJFVOVaH4SCFTeEf/9XdvBzWJ7aGJJAI2KZdvs
         D37nKzDvZDZwnI6OatVAoibQKI5Evs7cCiUPn38GRjt11DKJIOC940WNbIUIn9zDMCdQ
         3jQOnSbAi0oSK/Rh7EZmGu913bS38m7cyI+rg1PRjzhpNnUywsbKxwatxliwWLpv47Hp
         9R2dTN50CWcyLA0fFhlNgBsmil9/ux47o8EZ7l/HJS8DBwDIzA8bJIsz5NpOgF1/1mcD
         FBGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXm6jIdrWu0r5GzX7MtPNEvWA5gjoD5YsoOliPCvaeWXylZsvy7daNZ5Lc3uorlcYqMwAECUsgyYy7ARsCFhEgH4MB+mRNf9zd8hIK
X-Gm-Message-State: AOJu0Yz2rgiQTmAd22v1U42KocT7XiAkzt9yGGF5WJupx9u72O7pZM04
	3pgaPmSQI4CdGn2lBHPMrL3MsEkd5cw3PFOHLJcR0G8HW/MXgkXNW+senPF8S5o=
X-Google-Smtp-Source: AGHT+IF2SL/odI3naJVy4wPv9EHrd3HZU4bf46sQq/F/U6G5bSa+Lq7BxcDFTMMDrataI2Sz075ihw==
X-Received: by 2002:a05:6808:2cc:b0:3c3:d99b:d6e3 with SMTP id a12-20020a05680802cc00b003c3d99bd6e3mr2243446oid.28.1711486121393;
        Tue, 26 Mar 2024 13:48:41 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id hj2-20020a05622a620200b00430d286c58fsm4035593qtb.44.2024.03.26.13.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 13:48:41 -0700 (PDT)
Date: Tue, 26 Mar 2024 16:48:36 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Yosry Ahmed <yosryahmed@google.com>,
	Nhat Pham <nphamcs@gmail.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Barry Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH v9] zswap: replace RB tree with xarray
Message-ID: <20240326204836.GC229434@cmpxchg.org>
References: <20240326-zswap-xarray-v9-1-d2891a65dfc7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326-zswap-xarray-v9-1-d2891a65dfc7@kernel.org>

On Tue, Mar 26, 2024 at 11:35:43AM -0700, Chris Li wrote:
>  	/*
> -	 * When reading into the swapcache, invalidate our entry. The
> +	 * When reading into the swapcache, erase our entry. The
>  	 * swapcache can be the authoritative owner of the page and
>  	 * its mappings, and the pressure that results from having two
>  	 * in-memory copies outweighs any benefits of caching the

Not sure why you editorialized this? Your patch doesn't change those
semantics, for which "invalidation" of the backing copy is a much
better description, given we're also marking the folio dirty again etc.

Can you please send a delta fix to undo that?

> @@ -1649,8 +1581,12 @@ bool zswap_load(struct folio *folio)
>  	 * the fault fails. We remain the primary owner of the entry.)
>  	 */
>  	if (swapcache)
> -		zswap_rb_erase(&tree->rbroot, entry);
> -	spin_unlock(&tree->lock);
> +		entry = xa_erase(tree, offset);
> +	else
> +		entry = xa_load(tree, offset);
> +
> +	if (!entry)
> +		return false;
>  
>  	if (entry->length)
>  		zswap_decompress(entry, page);

Otherwise, looks good to me

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

