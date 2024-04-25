Return-Path: <linux-kernel+bounces-159026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C2E8B2846
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00954B2331A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B08214A0BE;
	Thu, 25 Apr 2024 18:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CxpKp59c"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1163BBE9
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 18:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714070571; cv=none; b=IfI7E9t/HQNQ9yYznpRne7MazYeryfKaMptffnGAvSV0uaC8X5S2dgCUXDHEibtOVNx2jtv97rVCHN6zFBEECmlBS/yMTHEnrBe2fHUy33MbxMz27+waO4m6DwijZabFwhlD0yzXJ0MQ7iFwPUCMWm3ODQ74dnmh3Iqx9EQfyXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714070571; c=relaxed/simple;
	bh=gJIR3iQXeNyt3QL8tRErTvOnwB9IOYdL9wPL1VqurBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ceXZ8fZP3ftJ9wJ7dB4Th+Evoq9AOU/d1xulxjeU+Ew0+RAYI2CK7vWinrb/ppE1lkY43ku3YOfVbK/oc7ZjUtrCH1xabNNLGa+G/6tWSugejjeS4WTN7YlnbPlee7maXulPP3mVrOEtE99Ci3LRJl3foc3TmrMz33L4JkvT2Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CxpKp59c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714070568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fTnn2fCHl/Xo2klhmJAZoUT1j+Wuzqk+PuRx8GalUwM=;
	b=CxpKp59cV4Tn4472mO1DTtoWVlCnLX98BfA0VSinYV50ekPWu01oqGy4NJo73HV8E9PMva
	h3fRQ9czNdP1kVf6pKTBrIJRA4E8cbil6yKwzvGtE7ZcKEWtvigV3+MCV0YLCaAiW2mPU0
	GEBQWdTwcz6vuJYkji0LIY6gJ9Noz4o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-4Si9H211Oi6RO5xB4ed4_w-1; Thu, 25 Apr 2024 14:42:46 -0400
X-MC-Unique: 4Si9H211Oi6RO5xB4ed4_w-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3479b511725so872171f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 11:42:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714070564; x=1714675364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fTnn2fCHl/Xo2klhmJAZoUT1j+Wuzqk+PuRx8GalUwM=;
        b=oBIVVoBLrBTqwEKtxOTVSBzcKN+ns/BSRF9ujguj/o/wzlrh6y6xVFTYC5Myf3DtlA
         QZ4IJVF8bEf/2ed5QQzN/2TevWqQvHfMqk1/5JPKCydYrE8vumQezDrN50ereHyf7apU
         tft6CZzJUSa3/eoiRgGXStyAzPZy2qI5FFtscpCTcmuWbCks8cVd8Rvwmyf6Tsu1wWQH
         ZtWS48aeQNGKFu9ebh5MyWKMBUeZ8Dfyb7Ez+znTmgsLC0vEc7yhqNpuSSpwX83cuGO6
         /Ktiu2Rwbp5VWKE57K+P+SafFXCEmLNQtGTdicifKO3ak+oVL+14ajqBW/HDOSTyk0Bs
         k/dA==
X-Forwarded-Encrypted: i=1; AJvYcCVwYJjQvd949oUXjtGI1agDdjnBXre/Hum3r/AqTrnz+MpGq9W3xSnWMBnf4JdtTonuVhruU+qV5erHXq8u6dJvmB8wS76AWLLsp5SF
X-Gm-Message-State: AOJu0YxppEyHho9VXduc/92k/IVOYSzwZ2HdmCvXmTATUgtZaeb6clVY
	pL8vWa8ZRO9D2mNvOL2qWvCh7gSkOo9Sfnf71BMHGurvjv90ZfytuOFhw8+xHg4zvvQkyhpwwDt
	Tti5QgDInajOH93ucgYNROCu00hL04mlFGS3V20CzvNCyx1BJbbw+xTLD4/iSpQ==
X-Received: by 2002:a5d:40cb:0:b0:349:9b7f:8df3 with SMTP id b11-20020a5d40cb000000b003499b7f8df3mr200428wrq.40.1714070564676;
        Thu, 25 Apr 2024 11:42:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECIJT6QQZO+I1RyLvnoHmdjp3YxnPPZaibk78pSJxr8rAJ1Cffp1mzJ0P7xEljkmgv7+gfzQ==
X-Received: by 2002:a5d:40cb:0:b0:349:9b7f:8df3 with SMTP id b11-20020a5d40cb000000b003499b7f8df3mr200407wrq.40.1714070564298;
        Thu, 25 Apr 2024 11:42:44 -0700 (PDT)
Received: from pollux ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id f8-20020adff8c8000000b0033e7b05edf3sm20432907wrq.44.2024.04.25.11.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 11:42:43 -0700 (PDT)
Date: Thu, 25 Apr 2024 20:42:41 +0200
From: Danilo Krummrich <dakr@redhat.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>, Zhi Wang <zhiw@nvidia.com>,
	rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>, ajanulgu@redhat.com,
	Andy Currid <acurrid@nvidia.com>, Neo Jia <cjia@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v3 00/10] Allocation APIs
Message-ID: <ZiqkIQTHe9apd-LW@pollux>
References: <Zip4dFpt8xhk7UBL@cassiopeiae>
 <74cbdaf7-360e-47e3-bda4-4661422a11ae@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74cbdaf7-360e-47e3-bda4-4661422a11ae@proton.me>

On Thu, Apr 25, 2024 at 04:09:46PM +0000, Benno Lossin wrote:
> On 25.04.24 17:36, Danilo Krummrich wrote:
> > (adding folks from [1])
> > 
> > On Tue, Apr 23, 2024 at 05:43:08PM +0200, Danilo Krummrich wrote:
> >> Hi all,
> >>
> >> On 3/28/24 02:35, Wedson Almeida Filho wrote:
> >>> From: Wedson Almeida Filho <walmeida@microsoft.com>
> >>>
> >>> Revamp how we use the `alloc` crate.
> >>>
> >>> We currently have a fork of the crate with changes to `Vec`; other
> >>> changes have been upstreamed (to the Rust project). This series removes
> >>> the fork and exposes all the functionality as extension traits.
> >>>
> >>> Additionally, it also introduces allocation flag parameters to all
> >>> functions that may result in allocations (e.g., `Box::new`, `Arc::new`,
> >>> `Vec::push`, etc.) without the `try_` prefix -- the names are available
> >>> because we build `alloc` with `no_global_oom_handling`.
> >>>
> >>> Lastly, the series also removes our reliance on the `allocator_api`
> >>> unstable feature.
> >>>
> >>> Long term, we still want to make such functionality available in
> >>> upstream Rust, but this allows us to make progress now and reduces our
> >>> maintainance burden.
> >>>
> >>> In summary:
> >>> 1. Removes `alloc` fork
> >>> 2. Removes use of `allocator_api` unstable feature
> >>> 3. Introduces flags (e.g., GFP_KERNEL, GFP_ATOMIC) when allocating
> >>
> >> With that series, how do we implement alternative allocators, such as
> >> (k)vmalloc or DMA coherent?
> >>
> >> For instance, I recently sketched up some firmware bindings we want to
> >> use in Nova providing
> >>
> >> fn copy<A: core::alloc::Allocator>(&self, alloc: A) -> Result<Vec<u8, A>>
> >> [1]
> >>
> >> making use of Vec::try_with_capacity_in(). How would I implement
> >> something similar now?
> > 
> > I want to follow up on this topic after also bringing it up in yesterday's
> > weekly Rust call.
> > 
> > In the call a few ideas were discussed, e.g. whether we could just re-enable the
> > allocator_api feature and try getting it stabilized.
> > 
> > With the introduction of alloc::Flags (gfp_t abstraction) allocator_api might
> > not be a viable choice anymore.
> 
> Bringing in some more context from the meeting: Gary suggested we create
> a custom trait for allocators that can also handle allocation flags:
> 
>      pub trait AllocatorWithFlags: Allocator {
>          type Flags;
>          
>          fn allocate_with_flags(&self, layout: Layout, flags: Self::Flags) -> Result<NonNull<[u8]>, AllocError>;
> 
>          /* ... */
>      }
>      
>      impl AllocatorWithFlags for Global { /* ... */ }
>      
>      impl<T, A> VecExt<T> for Vec<T, A> where A: AllocatorWithFlags {
>          /* ... */
>      }
> 
> I think that this would work, but we would have to ensure that users are
> only allowed to call allocating functions if they are functions that we
> control. For example `Vec::try_reserve` [1] would still use the normal
> `Allocator` trait that doesn't support our flags.
> Gary noted that this could be solved by `klint` [2].

I agree, extending the Allocator trait should work.

Regarding allocating functions we don't control, isn't that the case already?
AFAICS, we're currently always falling back to GFP_KERNEL when calling
Vec::try_reserve().

But yes, I also think it would be better to enforce being explicit.

Given that, is there any value extending the existing Allocator trait at all?

> 
> 
> But we only need to extend the allocator API, if you want to use the std
> library types that allocate. If you would also be happy with a custom
> newtype wrapper, then we could also do that.

What do you mean with "custom newtype wrapper"?

> I think that we probably want a more general solution (ie `Allocator`
> enriched with flags), but we would have to design that before you can
> use it.
> 
> 
> [1]: https://doc.rust-lang.org/alloc/vec/struct.Vec.html#method.try_reserve
> [2]: https://github.com/Rust-for-Linux/klint
> 
> > 
> > I think it would work for (k)vmalloc, where we could pass the page flags through
> > const generics for instance.
> > 
> > But I don't see how it could work with kmem_cache, where we can't just create a
> > new allocator instance when we want to change the page flags, but need to
> > support allocations with different page flags on the same allocator (same
> > kmem_cache) instance.
> 
> I think that you can write the `kmem_cache` abstraction without using
> the allocator api. You just give the function that allocates a `flags`
> argument like in C.

Guess you mean letting the kmem_cache implementation construct the corresponding
container? Something like:

KmemCache<T>::alloc_box(flags: alloc::Flags) -> Box<T>

I think that'd make a lot of sense, since the size of an allocation is fixed
anyways.

> 
> The `Allocator` API might make it more *convenient* to use it, because
> you don't have to explicitly pass the flags every time (since the flags
> are determined by the allocator). But I have also heard that it might be
> desirable to always be explicit.
> 
> -- 
> Cheers,
> Benno
> 
> > 
> > So, I think we have to create our own allocator trait / API.
> > 
> > Any other thoughts on that?
> > 
> > - Danilo
> > 
> > [1] https://lore.kernel.org/rust-for-linux/20240408094738.00005e59.zhiw@nvidia.com/
> > 
> 


