Return-Path: <linux-kernel+bounces-131170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 518418983FE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88105B24D7C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C1E74C09;
	Thu,  4 Apr 2024 09:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="P+Ygndtu"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C96745C2
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 09:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712223011; cv=none; b=W54qFE3lLKtPWy+6bp8aagJvqj0koyMoxrmORtjNRlFpLmxV6S8U4dx2l91Y8X6oI1G4GAJKmTSg+evFKUgIPwyaYPHSgeP/vXyz6eBywbRDEUR+fMPdM2ENGf/kRNrvlSITX+G/zmfPXEbMRixsotctUk4MKIIIcNehnydcSu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712223011; c=relaxed/simple;
	bh=keVQ+JSmIRyUsmJ3etfQZLWjCiaykGuXkUV8XCETcG0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C5PZh3mL3m5/cyrlkCXbxrhYOTTXfgYQjvvo8HApURbtvM5Mn0sdLakRvSyUf9po2qVcSZDvSI7an0Pr+1wEcfOo5g21/IRcSjIf079I8NxEC0yj6l2PRJfzEXzes+QYFgblnJ2XdXuqmX2nmg3o3e5KcGgX99RUqqrDHrcQa80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=P+Ygndtu; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a4702457ccbso100769666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 02:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1712223007; x=1712827807; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XeqgpKrVGgo+XJxZmR7xCB2JIcBDNuq70r821JTeGtM=;
        b=P+YgndtuKfQVdBivCzZsVolpK40DBwrU7UBKAwNQH1ZZKxK0jFF+jzbX2NXrlNbxjn
         mnKnzskby1Y0oc/ksvx0sNhJyA/S4+O00OFGS1F19gXVyTTmYIaiPLQMCHgNhhtSIHme
         TjAoDDS4vFCbRNLKZCSbo0vqzCkt+2zzy6B8iEZ00S1uPPBCDjo0sZUi6WS/jlSt2p4r
         EhAps93QZaBAc+U8hjY5RJ9HgLmOpS8u18WwYifwFM/Oa+dManuRSrzM0YwiqHuFiwBp
         tBQqZRN2pUODLfeG/wNzIq9Qz7CEOTXWutDKW7PEFcz+XAEprbPT5hrvj8BROuFQgLjf
         1xhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712223007; x=1712827807;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XeqgpKrVGgo+XJxZmR7xCB2JIcBDNuq70r821JTeGtM=;
        b=DPjWuCPo/PgE7+VGA0gUEZci/vFKT8mpTsPpMscLnaoKMB9qIBQ6jo9CCvdBLS7kVp
         fdUpmX6hKynMulNMXr5Inz7Y24naYFPxF2WFK/zrRg2u1R5sZoaImhGJo06X+mer9Sw8
         sChNJpOKe1ICG++HVfdPuKt1ybUYsepqCFe784dSgRRjeh5BVsKmVRIJTSRmPe2MCF6w
         4J7/D4D5fVwaqtJ+zEbQftoVCqXF/dptjBd1tSmyT0TgubBtPJ9/6iHj6A+eLzhBxmG/
         46PybSQQUFO2cbQPctsJv6Y0E4cCPU5AX22Q2DLW0W2D7a7zgCEW0x2XSpHT4/Ze/TOY
         mwwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVu6MpQlVGTwmUtBAlS2WDHsWF2o+BtWCRYfGwU4n3N7pMqzyxiO+X9AucOQEcaeomvfvQyXxvg/akNRV801C7dUQlJWKxL+S+j60Nt
X-Gm-Message-State: AOJu0YwXTwTZmnPGmFaEzioFGlJsTHGFM+pV4A8N+pXo9jCDuDK+CzSm
	9+aqI+otc3eQVkihk2xl/b5raJ0SHQVmFPx/zPWrN6l9KRs1+CjvnsZ6nAKh1DU=
X-Google-Smtp-Source: AGHT+IEjf5p0vSM1n/RGUVqe4WwmoH/DSpG8tUJ7wWJkOCQSE5JqeKFCqEKO6XKiwsuKwW7FZ+FsDw==
X-Received: by 2002:a17:906:abc5:b0:a51:84bf:8ba6 with SMTP id kq5-20020a170906abc500b00a5184bf8ba6mr1092612ejb.17.1712223007264;
        Thu, 04 Apr 2024 02:30:07 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id p6-20020a170906a00600b00a46d04b6117sm8851210ejy.64.2024.04.04.02.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 02:30:06 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Jens Axboe <axboe@kernel.dk>,  Christoph Hellwig <hch@lst.de>,  Keith
 Busch <kbusch@kernel.org>,  Damien Le Moal <Damien.LeMoal@wdc.com>,  Bart
 Van Assche <bvanassche@acm.org>,  Hannes Reinecke <hare@suse.de>,
  "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,  Andreas
 Hindborg <a.hindborg@samsung.com>,  Wedson Almeida Filho
 <wedsonaf@gmail.com>,  Niklas Cassel <Niklas.Cassel@wdc.com>,  Greg KH
 <gregkh@linuxfoundation.org>,  Matthew Wilcox <willy@infradead.org>,
  Miguel Ojeda <ojeda@kernel.org>,  Alex Gaynor <alex.gaynor@gmail.com>,
  Boqun Feng <boqun.feng@gmail.com>,  Gary Guo <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>,  Alice Ryhl <aliceryhl@google.com>,
  Chaitanya Kulkarni <chaitanyak@nvidia.com>,  Luis Chamberlain
 <mcgrof@kernel.org>,  Yexuan Yang <1182282462@bupt.edu.cn>,  Sergio
 =?utf-8?Q?Gonz=C3=A1lez?= Collado <sergio.collado@gmail.com>,  Joel
 Granados
 <j.granados@samsung.com>,  "Pankaj Raghav (Samsung)"
 <kernel@pankajraghav.com>,  Daniel Gomez <da.gomez@samsung.com>,  open
 list <linux-kernel@vger.kernel.org>,  "rust-for-linux@vger.kernel.org"
 <rust-for-linux@vger.kernel.org>,  "lsf-pc@lists.linux-foundation.org"
 <lsf-pc@lists.linux-foundation.org>,  "gost.dev@samsung.com"
 <gost.dev@samsung.com>,  Ming Lei <ming.lei@redhat.com>
Subject: Re: [RFC PATCH 1/5] rust: block: introduce `kernel::block::mq` module
In-Reply-To: <3478efc2-7e81-4688-a115-5d33c70a24aa@proton.me> (Benno Lossin's
	message of "Thu, 04 Apr 2024 08:46:52 +0000")
References: <86cd5566-5f1b-434a-9163-2b2d60a759d1@proton.me>
	<871q7o54el.fsf@metaspace.dk>
	<7ed2a8df-3088-42a1-b257-dba3c2c9fc92@proton.me>
	<87v84ysujo.fsf@metaspace.dk>
	<f405ff55-fcb0-4592-ae4b-e1188eae9953@proton.me>
	<87zfu9r8be.fsf@metaspace.dk>
	<3478efc2-7e81-4688-a115-5d33c70a24aa@proton.me>
User-Agent: mu4e 1.12.2; emacs 29.3
Date: Thu, 04 Apr 2024 11:30:00 +0200
Message-ID: <87frw1qxuv.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Benno Lossin <benno.lossin@proton.me> writes:

> On 04.04.24 07:44, Andreas Hindborg wrote:
>> Benno Lossin <benno.lossin@proton.me> writes:
>> 
>>> On 03.04.24 10:46, Andreas Hindborg wrote:
>>>> Benno Lossin <benno.lossin@proton.me> writes:
>>>>
>>>>> On 23.03.24 07:32, Andreas Hindborg wrote:
>>>>>> Benno Lossin <benno.lossin@proton.me> writes:
>>>>>>> On 3/13/24 12:05, Andreas Hindborg wrote:
>>>>>>>> +//! implementations of the `Operations` trait.
>>>>>>>> +//!
>>>>>>>> +//! IO requests are passed to the driver as [`Request`] references. The
>>>>>>>> +//! `Request` type is a wrapper around the C `struct request`. The driver must
>>>>>>>> +//! mark start of request processing by calling [`Request::start`] and end of
>>>>>>>> +//! processing by calling one of the [`Request::end`], methods. Failure to do so
>>>>>>>> +//! can lead to IO failures.
>>>>>>>
>>>>>>> I am unfamiliar with this, what are "IO failures"?
>>>>>>> Do you think that it might be better to change the API to use a
>>>>>>> callback? So instead of calling start and end, you would do
>>>>>>>
>>>>>>>         request.handle(|req| {
>>>>>>>             // do the stuff that would be done between start and end
>>>>>>>         });
>>>>>>>
>>>>>>> I took a quick look at the rnull driver and there you are calling
>>>>>>> `Request::end_ok` from a different function. So my suggestion might not
>>>>>>> be possible, since you really need the freedom.
>>>>>>>
>>>>>>> Do you think that a guard approach might work better? ie `start` returns
>>>>>>> a guard that when dropped will call `end` and you need the guard to
>>>>>>> operate on the request.
>>>>>>
>>>>>> I don't think that would fit, since the driver might not complete the
>>>>>> request immediately. We might be able to call `start` on behalf of the
>>>>>> driver.
>>>>>>
>>>>>> At any rate, since the request is reference counted now, we can
>>>>>> automatically fail a request when the last reference is dropped and it
>>>>>> was not marked successfully completed. I would need to measure the
>>>>>> performance implications of such a feature.
>>>>>
>>>>> Are there cases where you still need access to the request after you
>>>>> have called `end`?
>>>>
>>>> In general no, there is no need to handle the request after calling end.
>>>> C drivers are not allowed to, because this transfers ownership of the
>>>> request back to the block layer. This patch series defer the transfer of
>>>> ownership to the point when the ARef<Request> refcount goes to zero, so
>>>> there should be no danger associated with touching the `Request` after
>>>> end.
>>>>
>>>>> If no, I think it would be better for the request to
>>>>> be consumed by the `end` function.
>>>>> This is a bit difficult with `ARef`, since the user can just clone it
>>>>> though... Do you think that it might be necessary to clone requests?
>>>>
>>>> Looking into the details now I see that calling `Request::end` more than
>>>> once will trigger UAF, because C code decrements the refcount on the
>>>> request. When we have `ARef<Request>` around, that is a problem. It
>>>> probably also messes with other things in C land. Good catch.
>>>>
>>>> I did implement `Request::end` to consume the request at one point
>>>> before I fell back on reference counting. It works fine for simple
>>>> drivers. However, most drivers will need to use the block layer tag set
>>>> service, that allows conversion of an integer id to a request pointer.
>>>> The abstraction for this feature is not part of this patch set. But the
>>>> block layer manages a mapping of integer to request mapping, and drivers
>>>> typically use this to identify the request that corresponds to
>>>> completion messages that arrive from hardware. When drivers are able to
>>>> turn integers into requests like this, consuming the request in the call
>>>> to `end` makes little sense (because we can just construct more).
>>>
>>> How do you ensure that this is fine?:
>>>
>>>       let r1 = tagset.get(0);
>>>       let r2 = tagset.get(0);
>>>       r1.end_ok();
>>>       r2.do_something_that_would_only_be_done_while_active();
>>>
>>> One thing that comes to my mind would be to only give out `&Request`
>>> from the tag set. And to destroy, you could have a separate operation
>>> that also removes the request from the tag set. (I am thinking of a tag
>>> set as a `HashMap<u64, Request>`.
>> 
>> This would be similar to
>> 
>>    let r1 = tagset.get(0)?;
>>    ler r2 = r1.clone();
>>    r1.end_ok();
>>    r2.do_something_requires_active();
>> 
>> but it is not a problem because we do not implement any actions that are
>> illegal in that position (outside of `end` - that _is_ a problem).
>
> Makes sense, but I think it's a bit weird to still be able to access it
> after `end`ing.

Yes, that is true.

>
>> 
>> 
>>>>
>>>> What I do now is issue the an `Option<ARef<Request>>` with
>>>> `bindings::req_ref_inc_not_zero(rq_ptr)`, to make sure that the request
>>>> is currently owned by the driver.
>>>>
>>>> I guess we can check the absolute value of the refcount, and only issue
>>>> a request handle if the count matches what we expect. Then we can be certain
>>>> that the handle is unique, and we can require transfer of ownership of
>>>> the handle to `Request::end` to make sure it can never be called more
>>>> than once.
>>>>
>>>> Another option is to error out in `Request::end` if the
>>>> refcount is not what we expect.
>>>
>>> I am a bit confused, why does the refcount matter in this case? Can't
>>> the user just have multiple `ARef`s?
>> 
>> Because we want to assert that we are consuming the last handle to the
>> request. After we do that, the user cannot call `Request::end` again.
>> `TagSet::get` will not issue a request reference if the request is not
>> in flight. Although there might be a race condition to watch out for.
>> 
>> When the block layer hands over ownership to Rust, the reference count
>> is 1. The first `ARef<Request>` we create increments the count to 2. To
>> complete the request, we must have ownership of all reference counts
>> above 1. The block layer takes the last reference count when it takes
>> back ownership of the request.
>> 
>>> I think it would be weird to use `ARef<Request>` if you expect the
>>> refcount to be 1.
>> 
>> Yes, that would require a custom smart pointer with a `try_into_unique`
>> method that succeeds when the refcount is exactly 2. It would consume
>> the instance and decrement the refcount to 1. But as I said, there is a
>> potential race with `TagSet::get` when the refcount is 1 that needs to
>> be handled.
>> 
>>> Maybe the API should be different?
>> 
>> I needs to change a little, yes.
>> 
>>> As I understand it, a request has the following life cycle (please
>>> correct me if I am wrong):
>>> 1. A new request is created, it is given to the driver via `queue_rq`.
>>> 2. The driver can now decide what to do with it (theoretically it can
>>>      store it somewhere and later do something with it), but it should at
>>>      some point call `Request::start`.
>>> 3. Work happens and eventually the driver calls `Request::end`.
>>>
>>> To me this does not seem like something where we need a refcount (we
>>> still might need one for safety, but it does not need to be exposed to
>>> the user).
>> 
>> It would not need to be exposed to the user, other than a) ending a request
>> can fail OR b) `TagSet::get` can fail.
>> 
>> a) would require that ending a request must be done with a unique
>> reference. This could be done by the user by the user calling
>> `try_into_unique` or by making the `end` method fallible.
>> 
>> b) would make the reference handle `!Clone` and add a failure mode to
>> `TagSet::get`, so it fails to construct a `Request` handle if there are
>> already one in existence.
>> 
>> I gravitate towards a) because it allows the user to clone the Request
>> reference without adding an additional `Arc`.
>
> This confuses me a little, since I thought that `TagSet::get` returns
> `Option<ARef<Request>>`.

It does, but in the current implementation the failure mode returning
`None` is triggered when the refcount is zero, meaning that the request
corresponding to that tag is not currently owned by the driver. For
solution b) we would change the type to be
`Option<CustomSmartPointerHandleThing<Request>>`.

> (I tried to find the abstractions in your
> github, but I did not find them)

It's here [1]. It was introduced in the `rnvme-v6.8` branch.

> I think that this could work: `queue_rq` takes a `OwnedRequest`, which
> the user can store in a `TagSet`, transferring ownership. `TagSet::get`
> returns `Option<&Request>` and you can call `TagSet::remove` to get
> `Option<OwnedRequest>`. `OwnedRequest::end` consumes `self`.
> With this pattern we also do not need to take an additional refcount.

It would, but the `TagSet` is just a wrapper for the C block layer
`strugt blk_mq_tag_set`. This is a highly optimized data structure and
tag mapping is done before the driver sees the request. I would like to
reuse that logic.

We could implement what you suggest anyhow, but I would not want to that
additional logic to the hot path.


BR Andreas


[1] https://github.com/metaspace/linux/blob/0976c869fbfae13f6d475a287ade776c730cc029/rust/kernel/block/mq/tag_set.rs#L102

