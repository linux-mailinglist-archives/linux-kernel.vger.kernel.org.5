Return-Path: <linux-kernel+bounces-120342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8C588D60A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 06:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A7892A53BB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DD517551;
	Wed, 27 Mar 2024 05:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z5dIOZMv"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A44D4A35
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 05:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711518564; cv=none; b=Zl/xQCXrQkgq16tIh993TxvpKQTm7QyaQ8mhlQP/3EoV48b5yovt2GY/getv0ZNWscSlbcaFcoMbNzwW+BPdGWSTTONEdOiOuTrFkktFRnqThzlcDDc5pk1maxPEQDINpO/70YtjGFQVUgYUKv9j2oTWl/F0G0iM8kLOGLlXxGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711518564; c=relaxed/simple;
	bh=2fPFnfjONXKoBbPAhO0icG61wtmCphmeF2hFymiZsII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pzn3OCt46xD9e3x8ko8Ux2Z6Sa0F9pJWUwkSpWoKWvVFxVbGxi1xo9cC6SuLKQo4u4a1Rc7KXByd9O4XeAKDK+akzFNGcNu2aUpBwcbKM5EpVaVokGaAgKlojx+d17/8ozgNnkc4JAQl5bLjff0gRmCf6V4EPCfPXk+GGIMa838=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z5dIOZMv; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dcc73148611so7049749276.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 22:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711518562; x=1712123362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8J0ZnV1oTFcgfb1JjEJGSxAfSvbJA4SNmT1mCPOXDA=;
        b=Z5dIOZMvzPsNHrLpkfp51MasSlimWX/jgAA0clwETngx65R9tl5vY1zATYV4lltGUr
         berptByuT2hpIlMH3izE8hWBFOyrxyLZ1/NLZd7OLtEucqVTsaWf5OfN6qIlpeV/CHAX
         kv8nWOf6oU85z21VxtQCU3ODZs1yMpwScTO9t0EWYLrqY9EhRreS5YrlAQiFleu+baEF
         30IwTW3Mx5rJLlFjHDAu1mlZi+JLCUfNaLoRk74rQUxT0VJ/hCmUDzB9p7wDpQiDNjaJ
         /KXGXJvzLwBQ+k41X/5b0tDw4OIBo6/CJNdP9g4g4Hnbq+7eno4V+q5hUk3cqQHf2e5r
         EUuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711518562; x=1712123362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a8J0ZnV1oTFcgfb1JjEJGSxAfSvbJA4SNmT1mCPOXDA=;
        b=BBB1dH1jVnC0iqtugud0MdwY5O0ZgJMSDx4tDSz8Z99Z9CZRQKbLUsGJvqG2YxfEvq
         fH1TuK4yW4tTl5qi14aKEd2xHYKzEqCOIixXMZMeodE8i6Q2ShRIvUAoeDg5mR8BboLj
         e0Rw3pzbcYjVa8j8wPttEIxBpsxgHUqLMYyhZP2a9FdTi170uzP8i7smOLP3RlEr4PJ1
         5RP264SHoKi5QrhiAaJpUtcqRH8EAIA2IDLEwndsrm8cKe/44u3+Cxu9GbizKTNcNjRh
         rnM3urnoGKGDU2zyW574lyfh02YomugnRVjEPoxafWxv8xTpf6YCEOIThf1HVNHXe7qr
         P6gQ==
X-Gm-Message-State: AOJu0YyK+dd9ApLJ/x08Ff35utJXJty3s/Ga6UiKiKEBg+vF1ak6ikTU
	8xvw9KH+x057LR88tKFYVi7x+TWiexAFnSgbswI9YBz2TorXD+beV23CqT6zlMS4dglTZRneEJl
	RR56fUkKObN/U31yDX7lTJ5XXr90ry1LaQo1V
X-Google-Smtp-Source: AGHT+IHBhcynCtTcObE/TVj3lUWoUi2qzRWC8rT1WtVFzE4nYTXms+I4mGspk1m0zT4DQKpuscVRZupkC5QaFwvHxVs=
X-Received: by 2002:a25:9388:0:b0:dc6:238e:d766 with SMTP id
 a8-20020a259388000000b00dc6238ed766mr2797003ybm.2.1711518562148; Tue, 26 Mar
 2024 22:49:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327044649.9199-1-rdunlap@infradead.org>
In-Reply-To: <20240327044649.9199-1-rdunlap@infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 26 Mar 2024 22:49:11 -0700
Message-ID: <CAJuCfpG-ocGBZs96WbhEgj=AsVysswMV4M0HtQAK35ZBc6-rAQ@mail.gmail.com>
Subject: Re: [PATCH] mm/slab: fix kcalloc() kernel-doc warnings
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Vlastimil Babka <vbabka@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 9:46=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Fix the parameter names for kcalloc() in slab.h to prevent kernel-doc
> warnings:
>
> include/linux/slab.h:730: warning: Function parameter or struct member '_=
n' not described in 'kcalloc'
> include/linux/slab.h:730: warning: Function parameter or struct member '_=
size' not described in 'kcalloc'
> include/linux/slab.h:730: warning: Function parameter or struct member '_=
flags' not described in 'kcalloc'
> include/linux/slab.h:730: warning: Excess function parameter 'n' descript=
ion in 'kcalloc'
> include/linux/slab.h:730: warning: Excess function parameter 'size' descr=
iption in 'kcalloc'
> include/linux/slab.h:730: warning: Excess function parameter 'flags' desc=
ription in 'kcalloc'
>
> Fixes: bc7b83f5e4bf ("mm/slab: enable slab allocation tagging for kmalloc=
 and friends")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Link: https://lore.kernel.org/linux-next/20240325123603.1bdd6588@canb.auu=
g.org.au/
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org

Doh! I noticed these warnings but completely forgot to fix them in my
fixup patchset :(
Thanks for the fix!

Tested-by: Suren Baghdasaryan <surenb@google.com>


> ---
>  include/linux/slab.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff -- a/include/linux/slab.h b/include/linux/slab.h
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -727,7 +727,7 @@ static inline __realloc_size(2, 3) void
>   * @size: element size.
>   * @flags: the type of memory to allocate (see kmalloc).
>   */
> -#define kcalloc(_n, _size, _flags)             kmalloc_array(_n, _size, =
(_flags) | __GFP_ZERO)
> +#define kcalloc(n, size, flags)                kmalloc_array(n, size, (f=
lags) | __GFP_ZERO)
>
>  void *kmalloc_node_track_caller_noprof(size_t size, gfp_t flags, int nod=
e,
>                                   unsigned long caller) __alloc_size(1);

