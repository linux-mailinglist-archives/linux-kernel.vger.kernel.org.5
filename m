Return-Path: <linux-kernel+bounces-129361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A69E896973
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA0D61C2573B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CCD7FBBD;
	Wed,  3 Apr 2024 08:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="vHlPntHc"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00AF71B32
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 08:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712133990; cv=none; b=A4s9KXb/Sc3wYHxKyMxSTiMQo8UUPXZto0eFN+qIJpTPZw2a7Po7Hdm1i4CvSLHTQeLeMVCfwPEJywSy/exkCkyRqTAHpbOge4UpsL3imYBfnYtZYQ97fl4LqbKAAlwa3Z8wq1VefE0bEvQZKVR1epvcH5M5O4gC9k14+WN64W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712133990; c=relaxed/simple;
	bh=CnCNaZzl5rEH+QwH0mfl8Hi6Yca+JPC01k5/o/eFevs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oP2W1hm7jDM1IxDFVBwwwSTJgWoWo3llriOE6jswzbJeHAEl//QVO/R0WC+A0XGGzRv6XUMT6TJrIVP8h2J8DBX0GxmM5MrxHTtSRk/9DxDnrSNlBRjRMq3oln/3ociIJBGPSq3RH77FjDf8R5ATqWD+02N9JwuwfrwRxinsue4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=vHlPntHc; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56c404da0ebso8853773a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 01:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1712133986; x=1712738786; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H/ZMejo28/LllyfJA5g9nwz3RGVzU+8WXzt/3Z5s4wA=;
        b=vHlPntHcV3neZhL+d8OrTCOLohiXlSLDh6Ra9sMTNc/vREXX/2C8ev4B4JSlnbhxjw
         7q99LKyw+CQwZgwgfxvpYj/Z2jC8AWtDwit42nVn30QyrGlALTCn/uU6SXAAXTSpO7wu
         AzRjlzfPHsNuhEf/fvPQNw3wGEI9gpY1jzl1/3wM5Woba0opiuM9QPP29BVSICxe/+HW
         NKusdeTNiQzpDBrxf6EgL3XRrdWH/Z7mGEpqJ0NECyJxhoid0vf5rAjQB6ZcPo+fpFb3
         rEIAg5TTKGf03lbbWbumZl1KRp369qZm7IbtweUgAWuN0owAwYpoaFc9W0Q9d9M3kf2k
         WK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712133986; x=1712738786;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/ZMejo28/LllyfJA5g9nwz3RGVzU+8WXzt/3Z5s4wA=;
        b=rxjwPDDXB223SgV2Vy/Z6tzvoylK8XDDIym2IFqx1kinEezgueSZrXgsfUXbgkCOrz
         H/PGKtLiYLUBGdqcn2cN3OGKmCDV4vEynBTNufY+e9j3rsXH1spP0zZ6wSp0apdtirAs
         GkFIiPxTx4qCQh7Vlv1wRXHi1DwfnTu/7A/TTmtyG+8QXtMS2O9BTujwlP2xUVvktD9l
         En2zSRYgf70LkNT6nreW6rPg7TUhcO/bVhkjG33cIf6XpFL0MJOuSolppCic8sUt3eBG
         7gRrnwL1wFi0S25j4OcA2EPHAhWUCQWLMdHncwfHlwrkT5Frfn34fmjQqog8Hpkijo24
         rTKw==
X-Forwarded-Encrypted: i=1; AJvYcCXUv5JR6ctmPHMu35BqAtTzCl+wpuyfpBcrNRrrAJxgYeOkYzmSOe3HMzNWoaCS3xkiCW19/0TX2iSEGi5vXKRZMJ/dNKWGnQWmFy+G
X-Gm-Message-State: AOJu0Yxog1fiiG2Uzz0z/mlzxLXl+X8ssfXmcEvtt/uO+rtqbmqf/wY1
	nPOSVETZlkeOrdcqIJjLmZo+77Tks5p+usBG3W1I/Ql7liBi6JDKxTkjOlb1ydY=
X-Google-Smtp-Source: AGHT+IGo0b98RS6TrT3TIulpj9uf0OgGe9HgqnWXsEMXgCAc3KB/kjdbiHGYBrypbUj2L0uEeH3M1A==
X-Received: by 2002:a05:6402:5111:b0:56e:447:1e44 with SMTP id m17-20020a056402511100b0056e04471e44mr1297850edd.8.1712133985643;
        Wed, 03 Apr 2024 01:46:25 -0700 (PDT)
Received: from localhost ([194.62.217.1])
        by smtp.gmail.com with ESMTPSA id l24-20020aa7cad8000000b00562d908daf4sm7753421edt.84.2024.04.03.01.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 01:46:25 -0700 (PDT)
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
 <gost.dev@samsung.com>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [RFC PATCH 1/5] rust: block: introduce `kernel::block::mq` module
In-Reply-To: <7ed2a8df-3088-42a1-b257-dba3c2c9fc92@proton.me> (Benno Lossin's
	message of "Tue, 02 Apr 2024 23:09:49 +0000")
References: <86cd5566-5f1b-434a-9163-2b2d60a759d1@proton.me>
	<871q7o54el.fsf@metaspace.dk>
	<7ed2a8df-3088-42a1-b257-dba3c2c9fc92@proton.me>
User-Agent: mu4e 1.12.2; emacs 29.3
Date: Wed, 03 Apr 2024 10:46:19 +0200
Message-ID: <87v84ysujo.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Benno Lossin <benno.lossin@proton.me> writes:

> On 23.03.24 07:32, Andreas Hindborg wrote:
>> Benno Lossin <benno.lossin@proton.me> writes:
>>> On 3/13/24 12:05, Andreas Hindborg wrote:
>>>> +//! implementations of the `Operations` trait.
>>>> +//!
>>>> +//! IO requests are passed to the driver as [`Request`] references. The
>>>> +//! `Request` type is a wrapper around the C `struct request`. The driver must
>>>> +//! mark start of request processing by calling [`Request::start`] and end of
>>>> +//! processing by calling one of the [`Request::end`], methods. Failure to do so
>>>> +//! can lead to IO failures.
>>>
>>> I am unfamiliar with this, what are "IO failures"?
>>> Do you think that it might be better to change the API to use a
>>> callback? So instead of calling start and end, you would do
>>>
>>>       request.handle(|req| {
>>>           // do the stuff that would be done between start and end
>>>       });
>>>
>>> I took a quick look at the rnull driver and there you are calling
>>> `Request::end_ok` from a different function. So my suggestion might not
>>> be possible, since you really need the freedom.
>>>
>>> Do you think that a guard approach might work better? ie `start` returns
>>> a guard that when dropped will call `end` and you need the guard to
>>> operate on the request.
>> 
>> I don't think that would fit, since the driver might not complete the
>> request immediately. We might be able to call `start` on behalf of the
>> driver.
>> 
>> At any rate, since the request is reference counted now, we can
>> automatically fail a request when the last reference is dropped and it
>> was not marked successfully completed. I would need to measure the
>> performance implications of such a feature.
>
> Are there cases where you still need access to the request after you
> have called `end`?

In general no, there is no need to handle the request after calling end.
C drivers are not allowed to, because this transfers ownership of the
request back to the block layer. This patch series defer the transfer of
ownership to the point when the ARef<Request> refcount goes to zero, so
there should be no danger associated with touching the `Request` after
end.

> If no, I think it would be better for the request to
> be consumed by the `end` function.
> This is a bit difficult with `ARef`, since the user can just clone it
> though... Do you think that it might be necessary to clone requests?

Looking into the details now I see that calling `Request::end` more than
once will trigger UAF, because C code decrements the refcount on the
request. When we have `ARef<Request>` around, that is a problem. It
probably also messes with other things in C land. Good catch.

I did implement `Request::end` to consume the request at one point
before I fell back on reference counting. It works fine for simple
drivers. However, most drivers will need to use the block layer tag set
service, that allows conversion of an integer id to a request pointer.
The abstraction for this feature is not part of this patch set. But the
block layer manages a mapping of integer to request mapping, and drivers
typically use this to identify the request that corresponds to
completion messages that arrive from hardware. When drivers are able to
turn integers into requests like this, consuming the request in the call
to `end` makes little sense (because we can just construct more).

What I do now is issue the an `Option<ARef<Request>>` with
`bindings::req_ref_inc_not_zero(rq_ptr)`, to make sure that the request
is currently owned by the driver.

I guess we can check the absolute value of the refcount, and only issue
a request handle if the count matches what we expect. Then we can be certain
that the handle is unique, and we can require transfer of ownership of
the handle to `Request::end` to make sure it can never be called more
than once.

Another option is to error out in `Request::end` if the
refcount is not what we expect.

>
> Also what happens if I call `end_ok` and then `end_err` or vice versa?

That would be similar to calling end twice.

>
>>>> +    pub fn data_ref(&self) -> &T::RequestData {
>>>> +        let request_ptr = self.0.get().cast::<bindings::request>();
>>>> +
>>>> +        // SAFETY: `request_ptr` is a valid `struct request` because `ARef` is
>>>> +        // `repr(transparent)`
>>>> +        let p: *mut c_void = unsafe { bindings::blk_mq_rq_to_pdu(request_ptr) };
>>>> +
>>>> +        let p = p.cast::<T::RequestData>();
>>>> +
>>>> +        // SAFETY: By C API contract, `p` is initialized by a call to
>>>> +        // `OperationsVTable::init_request_callback()`. By existence of `&self`
>>>> +        // it must be valid for use as a shared reference.
>>>> +        unsafe { &*p }
>>>> +    }
>>>> +}
>>>> +
>>>> +// SAFETY: It is impossible to obtain an owned or mutable `Request`, so we can
>>>
>>> What do you mean by "mutable `Request`"? There is the function to obtain
>>> a `&mut Request`.
>> 
>> The idea behind this comment is that it is not possible to have an owned
>> `Request` instance. You can only ever have something that will deref
>> (shared) to `Request`. Construction of the `Request` type is not
>> possible in safe driver code. At least that is the intention.
>> 
>> The `from_ptr_mut` is unsafe, and could be downgraded to
>> `from_ptr`, since `Operations::complete` takes a shared reference
>> anyway. Bottom line is that user code does not handle `&mut Request`.
>
> Ah I see what you mean. But the user is able to have an `ARef<Request>`.
> Which you own, if it is the only refcount currently held on that
> request. When you drop it, you will run the destructor of the request.
>
> A more suitable safety comment would be "SAFETY: A `struct request` may
> be destroyed from any thread.".

I see, I will update the comment.


BR Andreas

