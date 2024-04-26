Return-Path: <linux-kernel+bounces-159874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D998B3557
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 459041C20D93
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75E985269;
	Fri, 26 Apr 2024 10:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ig1kQiSL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E114227701
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714127524; cv=none; b=CRzSCKtltTsdBz2pidu+qjhAtoCBNHJ7H9vg9Y6BmN9ihrq7nXGO6iiuexML9wJluXdJOq0qK7IJ+d4ARSdDbKOJPz2NZA+5PXo8cXpHdmvlIKDZsVOLPja/imA3O3zzuiyeKsUqJtycqYmBzcWsgYZ91ir4jTxHnTmcVuq+cRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714127524; c=relaxed/simple;
	bh=BO0PNXa7fijSNEdJ7CeWKE/2x9hJl/pXe+QjjFBkehI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UA7YzhPIIkbb2p8EsIT/lmFpVZ3LAnN+hncVgiwSUzITrHlDe9v9EL4Dxd7+J0iaoKeWGSiPTQB78YfbwKeTkgg+RSh2AymtWW5H1EAY2q4RkN009eMI8s/A+k9184CpsVJbqlLPRggIkl6Q8IQ6KYFcPNjZj+dhDnqz9Hi69oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ig1kQiSL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714127521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XDZastqrmcaaNm5J+vSQjUloL6wtLvJtr9BJ6T8gz7o=;
	b=ig1kQiSLx35K7103Yzj3raFWSA54cePxZmSBU3BcuLXSzcEdsQm7kNhHlk5j5DkR6smD2m
	SeS6z2tTSqKSPQH3rYhDOm3e3bvJKeZHNo2fSejcA0WDv4eWDY7CJ7MEYZoyDYJ0yH6C2J
	QiN8a5RVR3XYOjkC/6LPSYQrjMuJ2YQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-5d4WSwyROZ2FOl27Y_rS0Q-1; Fri, 26 Apr 2024 06:32:00 -0400
X-MC-Unique: 5d4WSwyROZ2FOl27Y_rS0Q-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-418df23b51cso8770595e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 03:31:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714127519; x=1714732319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XDZastqrmcaaNm5J+vSQjUloL6wtLvJtr9BJ6T8gz7o=;
        b=QY8gvkhKmW/XM/PzNS8NZiSg1k9FJqR/Jlixi2IeBHIGA7gC3uqakOOeJIexApcZaF
         TusDYNlPe/8zsOXJJxhViDfjmJEOzNo/aLmmJSSfuMpcjfGn1ht6/ev1cW2lODMHkPf8
         S4m/tBRP+A3pXjDS/6yQFg+uNzIGWdC0PZM4pqEYwBw/kjgri7C/2nV+Cn6LF1EWb/Zx
         aUOFETan1F1RR7wW64VV92M+VYJ1ojHZ9AmX57cc31/HvedLB0tNyczeWHmAHAz+/JC/
         RFngUK28odaku7FvnyvZPiIRw5enZpGUDrDAXgdquoQWr+qzrdozeqU8eq4/2lBjDbBN
         gLHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeBn5fB4C0Yi9vQ9NUqs4otTfHFLVcr2E5qCQlnV3eW5SOtoXDDQGzoOpubq/dwUJUHZK3ZTFhYUv1HCh6WS9FGxw17PWN03nrCngu
X-Gm-Message-State: AOJu0YyxiWmf/gMsOmkPZqizi7Yp9ADtAiQ/av5KVWeA0P1qHj9LJfWh
	OzOUx/JnUC3nASxn7OxbEza9elEyTbzHFf70Du7Kt/i6/ytvjPOFZhCnC2ebe6JqRLalzQOoQsj
	YA5mpvS+/pBxT3bH9FEUyfzHY95lRmZZsZV3HKpwdZO6EnEM7Qhij7SWc/uQrxQ==
X-Received: by 2002:a05:600c:1c21:b0:418:e08c:817 with SMTP id j33-20020a05600c1c2100b00418e08c0817mr1475947wms.32.1714127518666;
        Fri, 26 Apr 2024 03:31:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQJuiqv2cdBGw330Iaeq87CWyr5jKd7Z73I0rdD9dR0xvSHs44iMyRSuFIll0X4BvfDRMc2g==
X-Received: by 2002:a05:600c:1c21:b0:418:e08c:817 with SMTP id j33-20020a05600c1c2100b00418e08c0817mr1475926wms.32.1714127518183;
        Fri, 26 Apr 2024 03:31:58 -0700 (PDT)
Received: from pollux ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id fc9-20020a05600c524900b0041ac5f19213sm12024149wmb.8.2024.04.26.03.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 03:31:57 -0700 (PDT)
Date: Fri, 26 Apr 2024 12:31:55 +0200
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
Message-ID: <ZiuCm4VtFiCfzTPI@pollux>
References: <Zip4dFpt8xhk7UBL@cassiopeiae>
 <74cbdaf7-360e-47e3-bda4-4661422a11ae@proton.me>
 <ZiqkIQTHe9apd-LW@pollux>
 <f71c4e07-9f6f-4709-a3bb-012e644c4845@proton.me>
 <Zirfyp_NiYCRQYvk@cassiopeiae>
 <71dd99fe-0d64-47cc-b367-8fdd4fcdbdca@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71dd99fe-0d64-47cc-b367-8fdd4fcdbdca@proton.me>

On Fri, Apr 26, 2024 at 06:32:26AM +0000, Benno Lossin wrote:
> On 26.04.24 00:57, Danilo Krummrich wrote:
> > On Thu, Apr 25, 2024 at 08:52:16PM +0000, Benno Lossin wrote:
> >> On 25.04.24 20:42, Danilo Krummrich wrote:
> >>> On Thu, Apr 25, 2024 at 04:09:46PM +0000, Benno Lossin wrote:
> >>>> On 25.04.24 17:36, Danilo Krummrich wrote:
> >>>>> (adding folks from [1])
> >>>>>
> >>>>> On Tue, Apr 23, 2024 at 05:43:08PM +0200, Danilo Krummrich wrote:
> >>>>>> Hi all,
> >>>>>>
> >>>>>> On 3/28/24 02:35, Wedson Almeida Filho wrote:
> >>>>>>> From: Wedson Almeida Filho <walmeida@microsoft.com>
> >>>>>>>
> >>>>>>> Revamp how we use the `alloc` crate.
> >>>>>>>
> >>>>>>> We currently have a fork of the crate with changes to `Vec`; other
> >>>>>>> changes have been upstreamed (to the Rust project). This series removes
> >>>>>>> the fork and exposes all the functionality as extension traits.
> >>>>>>>
> >>>>>>> Additionally, it also introduces allocation flag parameters to all
> >>>>>>> functions that may result in allocations (e.g., `Box::new`, `Arc::new`,
> >>>>>>> `Vec::push`, etc.) without the `try_` prefix -- the names are available
> >>>>>>> because we build `alloc` with `no_global_oom_handling`.
> >>>>>>>
> >>>>>>> Lastly, the series also removes our reliance on the `allocator_api`
> >>>>>>> unstable feature.
> >>>>>>>
> >>>>>>> Long term, we still want to make such functionality available in
> >>>>>>> upstream Rust, but this allows us to make progress now and reduces our
> >>>>>>> maintainance burden.
> >>>>>>>
> >>>>>>> In summary:
> >>>>>>> 1. Removes `alloc` fork
> >>>>>>> 2. Removes use of `allocator_api` unstable feature
> >>>>>>> 3. Introduces flags (e.g., GFP_KERNEL, GFP_ATOMIC) when allocating
> >>>>>>
> >>>>>> With that series, how do we implement alternative allocators, such as
> >>>>>> (k)vmalloc or DMA coherent?
> >>>>>>
> >>>>>> For instance, I recently sketched up some firmware bindings we want to
> >>>>>> use in Nova providing
> >>>>>>
> >>>>>> fn copy<A: core::alloc::Allocator>(&self, alloc: A) -> Result<Vec<u8, A>>
> >>>>>> [1]
> >>>>>>
> >>>>>> making use of Vec::try_with_capacity_in(). How would I implement
> >>>>>> something similar now?
> >>>>>
> >>>>> I want to follow up on this topic after also bringing it up in yesterday's
> >>>>> weekly Rust call.
> >>>>>
> >>>>> In the call a few ideas were discussed, e.g. whether we could just re-enable the
> >>>>> allocator_api feature and try getting it stabilized.
> >>>>>
> >>>>> With the introduction of alloc::Flags (gfp_t abstraction) allocator_api might
> >>>>> not be a viable choice anymore.
> >>>>
> >>>> Bringing in some more context from the meeting: Gary suggested we create
> >>>> a custom trait for allocators that can also handle allocation flags:
> >>>>
> >>>>        pub trait AllocatorWithFlags: Allocator {
> >>>>            type Flags;
> >>>>
> >>>>            fn allocate_with_flags(&self, layout: Layout, flags: Self::Flags) -> Result<NonNull<[u8]>, AllocError>;
> >>>>
> >>>>            /* ... */
> >>>>        }
> >>>>
> >>>>        impl AllocatorWithFlags for Global { /* ... */ }
> >>>>
> >>>>        impl<T, A> VecExt<T> for Vec<T, A> where A: AllocatorWithFlags {
> >>>>            /* ... */
> >>>>        }
> >>>>
> >>>> I think that this would work, but we would have to ensure that users are
> >>>> only allowed to call allocating functions if they are functions that we
> >>>> control. For example `Vec::try_reserve` [1] would still use the normal
> >>>> `Allocator` trait that doesn't support our flags.
> >>>> Gary noted that this could be solved by `klint` [2].
> >>>
> >>> I agree, extending the Allocator trait should work.
> >>>
> >>> Regarding allocating functions we don't control, isn't that the case already?
> >>> AFAICS, we're currently always falling back to GFP_KERNEL when calling
> >>> Vec::try_reserve().
> >>
> >> Yes we're falling back to that, but
> >> 1. there are currently no calls to `try_reserve` in tree,
> >> 2. if you use eg a `vmalloc` allocator, then I don't know if it would be
> >>      fine to reallocate that pointer using `krealloc`. I assumed that that
> >>      would not be OK (hence my extra care with functions outside of our
> >>      control).
> > 
> > Well, this would indeed not be valid. However, a vmalloc allocater wouldn't
> > implement realloc() this way.
> 
> Oh yeah that is correct.
> 
> > Or are you saying that Vec always uses the global allocator in that case? Why
> > would it do that?
> 
> No, it would use the vmalloc allocator.
> 
> So I guess the issue isn't as bad as I at first thought. I still think
> we should lint for this though (but maybe a warning instead of an error).
> 
> >>> But yes, I also think it would be better to enforce being explicit.
> >>>
> >>> Given that, is there any value extending the existing Allocator trait at all?
> >>
> >> This is what I meant in the meeting by "do you really need the allocator
> >> trait?". What you lose is the ability to use `Vec` and `Box`, instead
> > 
> > Oh, indeed. I forgot about that when I wrote that. In that case I feel like it's
> > worth extending the existing allocator_api.
> > 
> >> you have to use your own wrapper types (see below). But what you gain is
> >> freedom to experiment. In the end we should still try to upstream our
> >> findings to Rust or at least share our knowledge, but doing that from
> >> the get-go is not ideal for productivity.
> >>
> >>>> But we only need to extend the allocator API, if you want to use the std
> >>>> library types that allocate. If you would also be happy with a custom
> >>>> newtype wrapper, then we could also do that.
> >>>
> >>> What do you mean with "custom newtype wrapper"?
> >>
> >> You create a newtype struct ("newtype" means that it wraps an inner type
> >> and adds/removes/changes features from the inner type):
> >>
> >>       pub struct BigVec<T>(Vec<T>);
> >>
> >> And then you implement the common operations on it:
> >>
> >>       impl<T> BigVec<T> {
> >>           pub fn push(&mut self, item: T) -> Result {
> >>               self.reserve(1)?;
> >>
> >>               self.0.spare_capacity_mut()[0].write(item);
> >>
> >>               // SAFETY: <omitted for brevity>
> >>               unsafe { self.0.set_len(self.0.len() + 1) };
> >>               Ok(())
> >>           }
> >>
> >>           pub fn reserve(&mut self, additional: usize) -> Result {
> >>               /*
> >>                * implemented like `VecExt::reserve` from this patchset,
> >>                * except that it uses `vmalloc` instead of `krealloc`.
> >>                */
> >>           }
> >>       }
> >>
> >> If we need several of these, we can also create a general API that
> >> makes it easier to create them and avoids the duplication.
> > 
> > Thanks for for explaining.
> > 
> > I'd probably tend to extending allocator_api then. Do you see any major
> > advantages / disadvantages doing one or the other?
> 
> So aside from being able to use `Vec` and `Box` etc, I don't think there
> are any advantages to using `allocator_api`. The disadvantages are that
> it's another unstable feature that we need to get stabilized in some
> form. So it increases the amount of time it takes for us to be able to
> support multiple versions of Rust.
> 
> I think it's fine for you to experiment with the `allocator_api` and see
> where that leads you. But when we discuss merging patches that enable
> unstable features, we should be sure that the feature is truly needed.
> And that it cannot be replaced by custom code (it also depends on how
> complicated it is, but I think `allocator_api` would be simple enough).

I agree, though I'm not asking to re-enable allocator_api necessarily.

My original question regarding this series was what's the plan on how to
implement alternative allocators given the changes of this series.

This series clearly is a huge improvement, however, before it was quite clear
how to implement alternative allocators. Now it's rather unclear.

It's good that we discuss the options now and I'm also happy to contribute to
the implementation, but I also think that within the context of this series we
should give an answer to this question.

- Danilo

> 
> -- 
> Cheers,
> Benno
> 


