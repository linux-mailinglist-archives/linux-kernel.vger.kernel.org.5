Return-Path: <linux-kernel+bounces-130954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAAA898112
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F2891F235F2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 05:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814D945942;
	Thu,  4 Apr 2024 05:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="iie1t1+n"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70BC3FC2
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 05:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712209457; cv=none; b=CrbdelFzB9In2c2r52QX80XN/z9YRDrWvLpNhAeK3OXVIUgassHM13q6V3AanzRZz8BfCmYCuSqBD5Qhlshp0L/BGsfFGQ6If0ku7RFalctm1sCn3c7XSnB6e089QQJ4qP50zH+esn9OQ3IbuwZKlnDx/yqYotAN0G31z7v56O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712209457; c=relaxed/simple;
	bh=7sHm5NYQwlFhuVIj8dvs4XxZaD5hjWm1LfC24QUL4eU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Uo+i24HVHLq6qjKEtu3r+GgFlIFhZ88IuYU5Ks6/FO8NESKz5bjnauOFBwfaU2/DVV+bm6ayM3zO4ey/i330WdPrZBlqd4fPzrxf1KBZUI63vmRcEgv/Sdl1lqU1A5TUsX4FSM1H1XB1Ifi4kEBxb3md6D/KveKZghXoQYdDebA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=iie1t1+n; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56d5d4d2e2bso447038a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 22:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1712209453; x=1712814253; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p6A4SiGWNYJMmN29Xh0xcoVvXDLons2as90jPZGp2Y0=;
        b=iie1t1+nL+95R5TC2+ZmU/mpbzBGwrPvfbH4QgDaj09Bnnt2tEiZXVhXpZpNbDD9lU
         b6JAX606gKAJvX5IVcx+os0giMLqC2VsVi0/2heFrf7fBrpsj8AzkgktA1sgfRN5GKP9
         dhOP1XnkQoBusUkXbqp3b+NMFsVBLHmZaMnFKgGIqPFTk22ViOesLXRVNDyONHeIFsc4
         s1SzYSCwOsRwcMuWyJQfHFvoIv44nNoPxa0izlZ/ERmTj7ESchQiCp4P8tec8P+ibrIQ
         XuqbTrzVzJT9eaf0VsJA12Qmdm5aKVdIqCDb4OZS7gf1fhcXGnakOJ0L44OmR5rz3swM
         jmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712209453; x=1712814253;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p6A4SiGWNYJMmN29Xh0xcoVvXDLons2as90jPZGp2Y0=;
        b=mUIQ7RuXdwvkyRAoqMK+MNVDbdlHdFupkmbEN0+IG4Do9H90wP3TqniFL023gjfEp2
         jNLwIGkCUxE+qUcV+F7YJSVSSQPfU29zzU6b8P0JDKVvDYOrcPqzJv1F6fgJhyTlF2fa
         smkQx5UIde+1bzG7iUthsf8UbNcZXx809cx7K4OR4b4Kok7geFuapypBD6DpGC9MZJMv
         sGz3Kde5VRUiEss2mvMVLMqNc7ymWVJZcFDqjRuTbL+fpUBjC2sjNNW6M6MSCN12Y08U
         ueTxXspRih6NlNqyAtDGhdfNhufMF3Y/BGD+v8EhuOzCPRvohCy7ScmvK9ZSgLmh2V2F
         n3Vw==
X-Forwarded-Encrypted: i=1; AJvYcCVP8uHs6KwDomZYmRTlnQeKzZlpWz7qFOUHcyZnc5cvgO1D9XXOcnzRnA6IzAdjSdLnV+50X7IRXNv9QOqeq1BO0Zt/c+IsLI/Xn7dW
X-Gm-Message-State: AOJu0YxTYve34YLhL9QnUAhDBHu8VOjGDfTpFyFQFokBkmg/6XtwKKUK
	Xl4tTiYHYv3NjMPLF8g/CDz0nOB2uzdzXpKfo5WG+DaytY2JJk9XI73jinp/Hw0=
X-Google-Smtp-Source: AGHT+IG8Q2Hn5mRYO5tL7zfow15NKsys0JcI5LAjTqTjlU0wZarWU62w2QGZcCj00l5DA8sG/3twTw==
X-Received: by 2002:a50:9f67:0:b0:568:b48e:bb2 with SMTP id b94-20020a509f67000000b00568b48e0bb2mr780512edf.25.1712209452758;
        Wed, 03 Apr 2024 22:44:12 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id ec47-20020a0564020d6f00b0056e0badec02sm1277154edb.38.2024.04.03.22.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 22:44:12 -0700 (PDT)
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
In-Reply-To: <f405ff55-fcb0-4592-ae4b-e1188eae9953@proton.me> (Benno Lossin's
	message of "Wed, 03 Apr 2024 19:37:44 +0000")
References: <86cd5566-5f1b-434a-9163-2b2d60a759d1@proton.me>
	<871q7o54el.fsf@metaspace.dk>
	<7ed2a8df-3088-42a1-b257-dba3c2c9fc92@proton.me>
	<87v84ysujo.fsf@metaspace.dk>
	<f405ff55-fcb0-4592-ae4b-e1188eae9953@proton.me>
User-Agent: mu4e 1.12.2; emacs 29.3
Date: Thu, 04 Apr 2024 07:44:05 +0200
Message-ID: <87zfu9r8be.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Benno Lossin <benno.lossin@proton.me> writes:

> On 03.04.24 10:46, Andreas Hindborg wrote:
>> Benno Lossin <benno.lossin@proton.me> writes:
>> 
>>> On 23.03.24 07:32, Andreas Hindborg wrote:
>>>> Benno Lossin <benno.lossin@proton.me> writes:
>>>>> On 3/13/24 12:05, Andreas Hindborg wrote:
>>>>>> +//! implementations of the `Operations` trait.
>>>>>> +//!
>>>>>> +//! IO requests are passed to the driver as [`Request`] references. The
>>>>>> +//! `Request` type is a wrapper around the C `struct request`. The driver must
>>>>>> +//! mark start of request processing by calling [`Request::start`] and end of
>>>>>> +//! processing by calling one of the [`Request::end`], methods. Failure to do so
>>>>>> +//! can lead to IO failures.
>>>>>
>>>>> I am unfamiliar with this, what are "IO failures"?
>>>>> Do you think that it might be better to change the API to use a
>>>>> callback? So instead of calling start and end, you would do
>>>>>
>>>>>        request.handle(|req| {
>>>>>            // do the stuff that would be done between start and end
>>>>>        });
>>>>>
>>>>> I took a quick look at the rnull driver and there you are calling
>>>>> `Request::end_ok` from a different function. So my suggestion might not
>>>>> be possible, since you really need the freedom.
>>>>>
>>>>> Do you think that a guard approach might work better? ie `start` returns
>>>>> a guard that when dropped will call `end` and you need the guard to
>>>>> operate on the request.
>>>>
>>>> I don't think that would fit, since the driver might not complete the
>>>> request immediately. We might be able to call `start` on behalf of the
>>>> driver.
>>>>
>>>> At any rate, since the request is reference counted now, we can
>>>> automatically fail a request when the last reference is dropped and it
>>>> was not marked successfully completed. I would need to measure the
>>>> performance implications of such a feature.
>>>
>>> Are there cases where you still need access to the request after you
>>> have called `end`?
>> 
>> In general no, there is no need to handle the request after calling end.
>> C drivers are not allowed to, because this transfers ownership of the
>> request back to the block layer. This patch series defer the transfer of
>> ownership to the point when the ARef<Request> refcount goes to zero, so
>> there should be no danger associated with touching the `Request` after
>> end.
>> 
>>> If no, I think it would be better for the request to
>>> be consumed by the `end` function.
>>> This is a bit difficult with `ARef`, since the user can just clone it
>>> though... Do you think that it might be necessary to clone requests?
>> 
>> Looking into the details now I see that calling `Request::end` more than
>> once will trigger UAF, because C code decrements the refcount on the
>> request. When we have `ARef<Request>` around, that is a problem. It
>> probably also messes with other things in C land. Good catch.
>> 
>> I did implement `Request::end` to consume the request at one point
>> before I fell back on reference counting. It works fine for simple
>> drivers. However, most drivers will need to use the block layer tag set
>> service, that allows conversion of an integer id to a request pointer.
>> The abstraction for this feature is not part of this patch set. But the
>> block layer manages a mapping of integer to request mapping, and drivers
>> typically use this to identify the request that corresponds to
>> completion messages that arrive from hardware. When drivers are able to
>> turn integers into requests like this, consuming the request in the call
>> to `end` makes little sense (because we can just construct more).
>
> How do you ensure that this is fine?:
>
>      let r1 = tagset.get(0);
>      let r2 = tagset.get(0);
>      r1.end_ok();
>      r2.do_something_that_would_only_be_done_while_active();
>
> One thing that comes to my mind would be to only give out `&Request`
> from the tag set. And to destroy, you could have a separate operation
> that also removes the request from the tag set. (I am thinking of a tag
> set as a `HashMap<u64, Request>`.

This would be similar to

  let r1 = tagset.get(0)?;
  ler r2 = r1.clone();
  r1.end_ok();
  r2.do_something_requires_active();

but it is not a problem because we do not implement any actions that are
illegal in that position (outside of `end` - that _is_ a problem).


>> 
>> What I do now is issue the an `Option<ARef<Request>>` with
>> `bindings::req_ref_inc_not_zero(rq_ptr)`, to make sure that the request
>> is currently owned by the driver.
>> 
>> I guess we can check the absolute value of the refcount, and only issue
>> a request handle if the count matches what we expect. Then we can be certain
>> that the handle is unique, and we can require transfer of ownership of
>> the handle to `Request::end` to make sure it can never be called more
>> than once.
>> 
>> Another option is to error out in `Request::end` if the
>> refcount is not what we expect.
>
> I am a bit confused, why does the refcount matter in this case? Can't
> the user just have multiple `ARef`s?

Because we want to assert that we are consuming the last handle to the
request. After we do that, the user cannot call `Request::end` again.
`TagSet::get` will not issue a request reference if the request is not
in flight. Although there might be a race condition to watch out for.

When the block layer hands over ownership to Rust, the reference count
is 1. The first `ARef<Request>` we create increments the count to 2. To
complete the request, we must have ownership of all reference counts
above 1. The block layer takes the last reference count when it takes
back ownership of the request.

> I think it would be weird to use `ARef<Request>` if you expect the
> refcount to be 1.

Yes, that would require a custom smart pointer with a `try_into_unique`
method that succeeds when the refcount is exactly 2. It would consume
the instance and decrement the refcount to 1. But as I said, there is a
potential race with `TagSet::get` when the refcount is 1 that needs to
be handled.

> Maybe the API should be different?

I needs to change a little, yes.

> As I understand it, a request has the following life cycle (please
> correct me if I am wrong):
> 1. A new request is created, it is given to the driver via `queue_rq`.
> 2. The driver can now decide what to do with it (theoretically it can
>     store it somewhere and later do something with it), but it should at
>     some point call `Request::start`.
> 3. Work happens and eventually the driver calls `Request::end`.
>
> To me this does not seem like something where we need a refcount (we
> still might need one for safety, but it does not need to be exposed to
> the user).

It would not need to be exposed to the user, other than a) ending a request
can fail OR b) `TagSet::get` can fail.

a) would require that ending a request must be done with a unique
reference. This could be done by the user by the user calling
`try_into_unique` or by making the `end` method fallible.

b) would make the reference handle `!Clone` and add a failure mode to
`TagSet::get`, so it fails to construct a `Request` handle if there are
already one in existence.

I gravitate towards a) because it allows the user to clone the Request
reference without adding an additional `Arc`.


BR Andreas

