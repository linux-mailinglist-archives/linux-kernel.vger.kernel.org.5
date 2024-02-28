Return-Path: <linux-kernel+bounces-84407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B45586A665
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCA111C244BD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95AE7470;
	Wed, 28 Feb 2024 02:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0i0OrbSj"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3409442C
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 02:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709086461; cv=none; b=DPBpX82jPrvheEgjv820nCK2iCJIvW+eYWuo+gyLFViHrDBP9QBVmc0ZY4bL5YX9lSA6sNfMxvMQXSveKoyfTnJ9HPgwkR4GyQybeOXzgA/lAnleaKmonyu5XoNCaMLXOWVtY3Hz7lJPhAAOUSfEiKqzqEPHTUyE211ckPFXv9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709086461; c=relaxed/simple;
	bh=4nDFMVvXgmxDw5zoXxRPs5AqF78/zhUArZTZnzRWccg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GufP9lzs50bmwNQ534iMsDu6MmPHlqOxRfVRbWs7QimQP07zcsG2+47TxdD+jFfG6UjpotoX/MMTDVB9lIO0Q/8aVNfy8+8gtyk5hiAC57Z3JHkKeHw29jUTUO+gFzQSJvfLtOsUxLcfAnhbWbskMSVuw+3Hcx58eUBHMYqzMjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0i0OrbSj; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6e09015f862so3729946b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 18:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709086459; x=1709691259; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uBsEB2bWKTc3gmkwF5a0wpcJFcu32yAcOr3T6FBTFEA=;
        b=0i0OrbSjBqJGow1/ZwpoGuASiWbNm3QqNm52ZsY/GtatRqoev6IheAKiHa/tXmxfit
         3feK+jFvfc+rGCUwrL+Y3EJWeyiZA9gKbjxBqalA/i48w/TSaotMVoi7tXL5vwnQfSFr
         aMXgGYmGKe104NFMH441mUGYqy6gnAw96vvXqoe777brPHtV7XDxTjpt8GUs77HrrLmZ
         7y2hBLjcCC5L5z19Y47DM7Txipaw26Xn/mUAzHtsfnf1+BRQCE/yEt75dXAPedBOU+En
         g4LHuMGjbzIyX1vrobVseSp4sF2o4ekurzar2Dk3eYjxWEKtcha4ESaNzHWvQqryBCT/
         HP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709086459; x=1709691259;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uBsEB2bWKTc3gmkwF5a0wpcJFcu32yAcOr3T6FBTFEA=;
        b=fACecMl474uDkC0mBNxZx/TegC74Og/AFUsYLtYztZ9nCKf8Dz7N2fsz265MM3HdQn
         6/bZyr52GkIEP1+cyKM5HyiUJkjpHyRs0TxFHt2YW3qUnbbmzjfojwYkRX51/QosAxkR
         dcfQHYj8xOvoPP46DnPaqOxuqauSU97geqFmPVfNVvr2KVG/9+Sq2tFCAQ1244xwphdW
         gp8g7+tSYaLPkDO3DcTuzkw/MtivUIuhIlB6VOBZSSLXUR7IbRQwkeIVJ9WUcKesMxWP
         xNDSZyKgme1rqItr8eDXgQ6vK9LHu05C/0XPbUIAOBAXCbg7W0b2r/iWTnlm4HxPHPZg
         GXRw==
X-Gm-Message-State: AOJu0Yx/6CODl3nR2TyMmb3S+gqVqsQMgsy+akbg5Fl/IpKqlk1iOrtA
	rNS1T2BbwtqAdWKoOhl3W9u56lTLCjSi1/7Y2rQi3w/1gDMapjEhESyOJ1C0stUgj/udWm3M4Ti
	G1Q==
X-Google-Smtp-Source: AGHT+IFYdHs0nOixyFuzAGGcLeL7Rj9tGJMNICeXoHorG2gmVZn6HhKaMCuru1RrJZw7Y4EZLJOUpsKv49o=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2349:b0:6e5:3554:7fae with SMTP id
 j9-20020a056a00234900b006e535547faemr69771pfj.1.1709086459143; Tue, 27 Feb
 2024 18:14:19 -0800 (PST)
Date: Tue, 27 Feb 2024 18:14:17 -0800
In-Reply-To: <20240227232100.478238-18-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240227232100.478238-1-pbonzini@redhat.com> <20240227232100.478238-18-pbonzini@redhat.com>
Message-ID: <Zd6W-aLnovAI1FL3@google.com>
Subject: Re: [PATCH 17/21] filemap: add FGP_CREAT_ONLY
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, michael.roth@amd.com, 
	isaku.yamahata@intel.com, thomas.lendacky@amd.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Feb 27, 2024, Paolo Bonzini wrote:

This needs a changelog, and also needs to be Cc'd to someone(s) that can give it
a thumbs up.

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/linux/pagemap.h | 2 ++
>  mm/filemap.c            | 4 ++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 2df35e65557d..e8ac0b32f84d 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -586,6 +586,7 @@ pgoff_t page_cache_prev_miss(struct address_space *mapping,
>   * * %FGP_CREAT - If no folio is present then a new folio is allocated,
>   *   added to the page cache and the VM's LRU list.  The folio is
>   *   returned locked.
> + * * %FGP_CREAT_ONLY - Fail if a folio is not present
>   * * %FGP_FOR_MMAP - The caller wants to do its own locking dance if the
>   *   folio is already in cache.  If the folio was allocated, unlock it
>   *   before returning so the caller can do the same dance.
> @@ -606,6 +607,7 @@ typedef unsigned int __bitwise fgf_t;
>  #define FGP_NOWAIT		((__force fgf_t)0x00000020)
>  #define FGP_FOR_MMAP		((__force fgf_t)0x00000040)
>  #define FGP_STABLE		((__force fgf_t)0x00000080)
> +#define FGP_CREAT_ONLY		((__force fgf_t)0x00000100)
>  #define FGF_GET_ORDER(fgf)	(((__force unsigned)fgf) >> 26)	/* top 6 bits */
>  
>  #define FGP_WRITEBEGIN		(FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE)
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 750e779c23db..d5107bd0cd09 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1854,6 +1854,10 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>  		folio = NULL;
>  	if (!folio)
>  		goto no_page;
> +	if (fgp_flags & FGP_CREAT_ONLY) {
> +		folio_put(folio);
> +		return ERR_PTR(-EEXIST);
> +	}
>  
>  	if (fgp_flags & FGP_LOCK) {
>  		if (fgp_flags & FGP_NOWAIT) {
> -- 
> 2.39.0
> 
> 

