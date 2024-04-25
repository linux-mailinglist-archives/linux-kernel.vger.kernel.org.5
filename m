Return-Path: <linux-kernel+bounces-159342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 758328B2D4F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A28E81C210FC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25E315624D;
	Thu, 25 Apr 2024 22:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h6R1E8+N"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F2912BF28
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 22:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714085842; cv=none; b=Z70GOn0tGHn+OVNCU3ZoHQDU6QGVrbx58KY39ikC4z40msIzUtbh0Wg89Q2yQeUT3Wgd1lSno7d+hLklMbs5qTRyUAmTXBqSbTeTV5LmSjZWhft21h6bg4pG+osvy4zqdj0mjSgCF6C2J7Z6C1KSOElzLkurK3BC3SXhPYL/tZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714085842; c=relaxed/simple;
	bh=v+pIQkCp/d0XMM62nKcndPkFSsemwxbmh9VmlslHl6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfY5nV9oUKX/onnOtKZQzBOQXuddKLSyRqEGuo7yG0J8qtlWQl3amF4UfTruwP3g/gXQQ5D4Y2TgTEEhZd09s2uMljj5YKvtsrGcor57Fljfv27TrwpB+xCz0qJu/u/hNZxs7fWGTbzotPK2dGrvLyiiIMMVspoSuPxF0eR/rVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h6R1E8+N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714085840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y1zc8KxI490UVDtoXR0x+4igsV+4WxEoDguutCn+fls=;
	b=h6R1E8+NTezDD03GD0yFFypysl+a/0M/+yg+RgcuOm2kejTQbjtn9NKXDbIL9AYPJ7IcGo
	930idDKuYogrW2FyA5EDgqtaZKEVcXqWOQrMiV1CS4mQKzcbu0CuFw9getRx8LX5cqlp6m
	32/zc07kQbErh6Cdc3qHNTscRdXXszs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-TeMIkrVANF-Wp4dhh-fjOg-1; Thu, 25 Apr 2024 18:57:18 -0400
X-MC-Unique: TeMIkrVANF-Wp4dhh-fjOg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-416ac21981dso7824665e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 15:57:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714085837; x=1714690637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y1zc8KxI490UVDtoXR0x+4igsV+4WxEoDguutCn+fls=;
        b=cjzR3qVAO7xFRn355hXmOlubOHFgvttfE6mFZdRBPC5g5PJOnz0RHWC/zv90IrGHK4
         0t5JvwtSdZzvUSrd8e67W4IYOtaGh0eaohxgxgDaKxJpWmTwc8NpZaWaMA/1SeKJDKDD
         8jiVrflvvmQPUqz0G7CbZWtQNDL0mtBOnfDF6Gc5ClDH2yK2T6KwQgJ5B4QQwhhTAvaV
         5WIsaBUz2uAzHcRZlZQLcng/vxvDoLgwJ6vAScIPMEDeBanb+JrXJsiaDf7voQRYUURM
         EF6F7yzl/SKlCLrrVx1/TD8OpZhg8pIOcnGUQHJr9Y5JLVCagCEeLaHbUernlzMlQDDG
         W3fg==
X-Forwarded-Encrypted: i=1; AJvYcCW9CaIkoGOSj8zODgMNz51/X0G7RaKu8wzPyx27Q1BXDv+RTdMaUqlGw9c9EEn6BFYVbqdd9IVHlPKwgo8s8yKxxNHlmes60FGmp7xF
X-Gm-Message-State: AOJu0YwrLUN932Unsno2eMozgOAoebVfjlZklg6/vkSwLOMScymBTE8B
	zDADtUnWGA2c9C2LOHXwmkoCbCHCS+8DWA9rAf4HsBH+GtNgoa4yy30AEkS6lpfm1ZL5VWH+ywg
	Hf2Ikcj6WGMS1dAh4W/R2CSe0HwRogDCiLZkXuUUatQsoh5QBoDpIVic/apDVlg==
X-Received: by 2002:a05:600c:1c20:b0:418:91ae:befc with SMTP id j32-20020a05600c1c2000b0041891aebefcmr3409384wms.0.1714085837401;
        Thu, 25 Apr 2024 15:57:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElHmk9dKRrTbmlPorTMkzfsWk0eCWrVogI2z7mJOFY62iXxZOgQ/VEGrXfIfl/QLQyodQ1bA==
X-Received: by 2002:a05:600c:1c20:b0:418:91ae:befc with SMTP id j32-20020a05600c1c2000b0041891aebefcmr3409364wms.0.1714085837005;
        Thu, 25 Apr 2024 15:57:17 -0700 (PDT)
Received: from cassiopeiae ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id p3-20020a5d6383000000b00341b451a31asm20782804wru.36.2024.04.25.15.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 15:57:16 -0700 (PDT)
Date: Fri, 26 Apr 2024 00:57:14 +0200
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
Message-ID: <Zirfyp_NiYCRQYvk@cassiopeiae>
References: <Zip4dFpt8xhk7UBL@cassiopeiae>
 <74cbdaf7-360e-47e3-bda4-4661422a11ae@proton.me>
 <ZiqkIQTHe9apd-LW@pollux>
 <f71c4e07-9f6f-4709-a3bb-012e644c4845@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f71c4e07-9f6f-4709-a3bb-012e644c4845@proton.me>

On Thu, Apr 25, 2024 at 08:52:16PM +0000, Benno Lossin wrote:
> On 25.04.24 20:42, Danilo Krummrich wrote:
> > On Thu, Apr 25, 2024 at 04:09:46PM +0000, Benno Lossin wrote:
> >> On 25.04.24 17:36, Danilo Krummrich wrote:
> >>> (adding folks from [1])
> >>>
> >>> On Tue, Apr 23, 2024 at 05:43:08PM +0200, Danilo Krummrich wrote:
> >>>> Hi all,
> >>>>
> >>>> On 3/28/24 02:35, Wedson Almeida Filho wrote:
> >>>>> From: Wedson Almeida Filho <walmeida@microsoft.com>
> >>>>>
> >>>>> Revamp how we use the `alloc` crate.
> >>>>>
> >>>>> We currently have a fork of the crate with changes to `Vec`; other
> >>>>> changes have been upstreamed (to the Rust project). This series removes
> >>>>> the fork and exposes all the functionality as extension traits.
> >>>>>
> >>>>> Additionally, it also introduces allocation flag parameters to all
> >>>>> functions that may result in allocations (e.g., `Box::new`, `Arc::new`,
> >>>>> `Vec::push`, etc.) without the `try_` prefix -- the names are available
> >>>>> because we build `alloc` with `no_global_oom_handling`.
> >>>>>
> >>>>> Lastly, the series also removes our reliance on the `allocator_api`
> >>>>> unstable feature.
> >>>>>
> >>>>> Long term, we still want to make such functionality available in
> >>>>> upstream Rust, but this allows us to make progress now and reduces our
> >>>>> maintainance burden.
> >>>>>
> >>>>> In summary:
> >>>>> 1. Removes `alloc` fork
> >>>>> 2. Removes use of `allocator_api` unstable feature
> >>>>> 3. Introduces flags (e.g., GFP_KERNEL, GFP_ATOMIC) when allocating
> >>>>
> >>>> With that series, how do we implement alternative allocators, such as
> >>>> (k)vmalloc or DMA coherent?
> >>>>
> >>>> For instance, I recently sketched up some firmware bindings we want to
> >>>> use in Nova providing
> >>>>
> >>>> fn copy<A: core::alloc::Allocator>(&self, alloc: A) -> Result<Vec<u8, A>>
> >>>> [1]
> >>>>
> >>>> making use of Vec::try_with_capacity_in(). How would I implement
> >>>> something similar now?
> >>>
> >>> I want to follow up on this topic after also bringing it up in yesterday's
> >>> weekly Rust call.
> >>>
> >>> In the call a few ideas were discussed, e.g. whether we could just re-enable the
> >>> allocator_api feature and try getting it stabilized.
> >>>
> >>> With the introduction of alloc::Flags (gfp_t abstraction) allocator_api might
> >>> not be a viable choice anymore.
> >>
> >> Bringing in some more context from the meeting: Gary suggested we create
> >> a custom trait for allocators that can also handle allocation flags:
> >>
> >>       pub trait AllocatorWithFlags: Allocator {
> >>           type Flags;
> >>
> >>           fn allocate_with_flags(&self, layout: Layout, flags: Self::Flags) -> Result<NonNull<[u8]>, AllocError>;
> >>
> >>           /* ... */
> >>       }
> >>
> >>       impl AllocatorWithFlags for Global { /* ... */ }
> >>
> >>       impl<T, A> VecExt<T> for Vec<T, A> where A: AllocatorWithFlags {
> >>           /* ... */
> >>       }
> >>
> >> I think that this would work, but we would have to ensure that users are
> >> only allowed to call allocating functions if they are functions that we
> >> control. For example `Vec::try_reserve` [1] would still use the normal
> >> `Allocator` trait that doesn't support our flags.
> >> Gary noted that this could be solved by `klint` [2].
> > 
> > I agree, extending the Allocator trait should work.
> > 
> > Regarding allocating functions we don't control, isn't that the case already?
> > AFAICS, we're currently always falling back to GFP_KERNEL when calling
> > Vec::try_reserve().
> 
> Yes we're falling back to that, but
> 1. there are currently no calls to `try_reserve` in tree,
> 2. if you use eg a `vmalloc` allocator, then I don't know if it would be
>     fine to reallocate that pointer using `krealloc`. I assumed that that
>     would not be OK (hence my extra care with functions outside of our
>     control).

Well, this would indeed not be valid. However, a vmalloc allocater wouldn't
implement realloc() this way.

Or are you saying that Vec always uses the global allocator in that case? Why
would it do that?

> 
> > But yes, I also think it would be better to enforce being explicit.
> > 
> > Given that, is there any value extending the existing Allocator trait at all?
> 
> This is what I meant in the meeting by "do you really need the allocator
> trait?". What you lose is the ability to use `Vec` and `Box`, instead

Oh, indeed. I forgot about that when I wrote that. In that case I feel like it's
worth extending the existing allocator_api.

> you have to use your own wrapper types (see below). But what you gain is
> freedom to experiment. In the end we should still try to upstream our
> findings to Rust or at least share our knowledge, but doing that from
> the get-go is not ideal for productivity.
> 
> >> But we only need to extend the allocator API, if you want to use the std
> >> library types that allocate. If you would also be happy with a custom
> >> newtype wrapper, then we could also do that.
> > 
> > What do you mean with "custom newtype wrapper"?
> 
> You create a newtype struct ("newtype" means that it wraps an inner type
> and adds/removes/changes features from the inner type):
> 
>      pub struct BigVec<T>(Vec<T>);
> 
> And then you implement the common operations on it:
> 
>      impl<T> BigVec<T> {
>          pub fn push(&mut self, item: T) -> Result {
>              self.reserve(1)?;
> 
>              self.0.spare_capacity_mut()[0].write(item);
> 
>              // SAFETY: <omitted for brevity>
>              unsafe { self.0.set_len(self.0.len() + 1) };
>              Ok(())
>          }
> 
>          pub fn reserve(&mut self, additional: usize) -> Result {
>              /*
>               * implemented like `VecExt::reserve` from this patchset,
>               * except that it uses `vmalloc` instead of `krealloc`.
>               */
>          }
>      }
> 
> If we need several of these, we can also create a general API that
> makes it easier to create them and avoids the duplication.

Thanks for for explaining.

I'd probably tend to extending allocator_api then. Do you see any major
advantages / disadvantages doing one or the other?

> 
> >> I think that we probably want a more general solution (ie `Allocator`
> >> enriched with flags), but we would have to design that before you can
> >> use it.
> >>
> >>
> >> [1]: https://doc.rust-lang.org/alloc/vec/struct.Vec.html#method.try_reserve
> >> [2]: https://github.com/Rust-for-Linux/klint
> >>
> >>>
> >>> I think it would work for (k)vmalloc, where we could pass the page flags through
> >>> const generics for instance.
> >>>
> >>> But I don't see how it could work with kmem_cache, where we can't just create a
> >>> new allocator instance when we want to change the page flags, but need to
> >>> support allocations with different page flags on the same allocator (same
> >>> kmem_cache) instance.
> >>
> >> I think that you can write the `kmem_cache` abstraction without using
> >> the allocator api. You just give the function that allocates a `flags`
> >> argument like in C.
> > 
> > Guess you mean letting the kmem_cache implementation construct the corresponding
> > container? Something like:
> > 
> > KmemCache<T>::alloc_box(flags: alloc::Flags) -> Box<T>
> > 
> > I think that'd make a lot of sense, since the size of an allocation is fixed
> > anyways.
> 
> Yes, but you would probably need a newtype return type, since you need
> to control how it is being freed. Also in the example above there is no
> `kmem_cache` object that stores the state.

Sure, the above was just meant to see whether I understood you correctly.

> 
> I think that the API would look more like this:
> 
>      impl<T> KMemCache<T> {
>          pub fn alloc(&self, value: T, flags: Flags) -> Result<KMemObj<'_, T>>;
>      }
> 
> Here are a couple of interesting elements of this API:
> - I don't know if `kmem_cache` uses the same flags as the alloc module,
>    if not you will need a custom `Flags` type.
> - I assume that an object allocated by a `kmem_cache` is only valid
>    while the cache still exists (ie if you drop the cache, all allocated
>    objects are also invalidated). That is why the return type contains a
>    lifetime (`'_` refers to the elided lifetime on the `&self` parameter.
>    It means that the `KMemObj` is only valid while the `KMemCache` is
>    also valid).
> - The return type is its own kind of smart pointer that allows you to
>    modify the inner value like `Box`, but it takes care of all the
>    `kmem_cache` specifics (eg ensuring that the associated cache is still
>    valid, freeing the object etc).r
> 
> Since I assumed several things, in the end the API might look different,
> but I think that this could be a more fruitful starting point.

Thanks for the hints - your assumptions are correct. The page flags are the same.

> 
> -- 
> Cheers,
> Benno
> 


