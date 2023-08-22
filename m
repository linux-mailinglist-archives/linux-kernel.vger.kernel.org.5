Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2447F783CF4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 11:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbjHVJcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 05:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234365AbjHVJcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 05:32:00 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA1CCCB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 02:31:58 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-52576448c91so2781457a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 02:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692696716; x=1693301516;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u/W6jtJXaUE/gh/n+1FodWgnqTe/idj5hBc66GJX2bo=;
        b=Fd/2xyqlDK8ctp+IphjXZfkwLM3vpM3cfpY5hhlTJ6PcnNjQz2e0EFZLcmmWlL0155
         g7HjV35Qm7PeAa//XiJE6Mgd4FHd4HSSDmNgNIjtqJerMRqcjtYEYP3y67QaZfMAv0dl
         GdU0Vm7U7ahsDeeayRohyZE8DyzXdcHnfe1VTTgkbSeCzEsMlnQ/3BQSNuELCVdmyXOr
         vBhOCuLCAH8yQR+ucvwyHyTR/Mx4fH0k+S6bx3V6KRMODn1984frfmoj0y9FpTwzl7dA
         H8offrTWZ4xwq1KDOYCV9Yu4ulRUy+BbeaRsZdQtvvYpCllK92eB/IPtopx37Uq5FGD+
         nydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692696716; x=1693301516;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u/W6jtJXaUE/gh/n+1FodWgnqTe/idj5hBc66GJX2bo=;
        b=lna5zh+T99s+vVBCLQhqSfrbIhraIzgfVrRNKgVxKWzRe9p7yjgzWqR2fMuF6rnjcV
         BVTuoOCCC2rtzoMWWismn3q4oz1yqOM795s6gmpZg89A1ZZrXqsp548fo+9uE98nPO+Z
         wORV+4SrXfoEvkZ1/2zGW+DYakKVEV0LJ+ktt+mrRTVojortUS1pz4LkUMG0Maw1fNl8
         6CuqKuSHuUjmxz0fuRgEzwl0JnLZHd9eSnWuQoJA4iSHITgVgXXTtW9pBixI9V0vrsJm
         22GunNDIqzY1xv5SkBwC6wtzqDskwGbmy1Eygeuci+caIj910vUwe3KFbnCaYoQW7QwZ
         00dw==
X-Gm-Message-State: AOJu0YzYoI0dzN6XYEv/b94T/bxE08mJyARFg1rhvhEEZp/0BWcRWJ5A
        ec+2ojcaigF+7OJ1LvQs6QC2+a1EasFP+d8=
X-Google-Smtp-Source: AGHT+IHU5+U+7RFLKURa2jqbhBEn2o6/mkJMJNhOerO0L9z5FZBO9RapI/AMbpvltVZlSY10g5zOZyZifzbKvKU=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a50:ab4f:0:b0:527:251d:f2ea with SMTP id
 t15-20020a50ab4f000000b00527251df2eamr54769edc.5.1692696716598; Tue, 22 Aug
 2023 02:31:56 -0700 (PDT)
Date:   Tue, 22 Aug 2023 09:31:54 +0000
In-Reply-To: <87r0octho8.fsf@metaspace.dk>
Mime-Version: 1.0
References: <87r0octho8.fsf@metaspace.dk>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230822093154.3478754-1-aliceryhl@google.com>
Subject: Re: [PATCH v1] rust: add improved version of `ForeignOwnable::borrow_mut`
From:   Alice Ryhl <aliceryhl@google.com>
To:     nmi@metaspace.dk
Cc:     alex.gaynor@gmail.com, aliceryhl@google.com,
        benno.lossin@proton.me, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, gary@garyguo.net,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        patches@lists.linux.dev, rust-for-linux@vger.kernel.org,
        wedsonaf@gmail.com
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Hindborg <nmi@metaspace.dk> writes:
>> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
>> index 172f563976a9..f152a562c9c3 100644
>> --- a/rust/kernel/sync/arc.rs
>> +++ b/rust/kernel/sync/arc.rs
>> @@ -232,26 +232,35 @@ pub fn ptr_eq(this: &Self, other: &Self) -> bool {
>>  
>>  impl<T: 'static> ForeignOwnable for Arc<T> {
>>      type Borrowed<'a> = ArcBorrow<'a, T>;
>> +    // Mutable access to the `Arc` does not give any extra abilities over
>> +    // immutable access.
>> +    type BorrowedMut<'a> = ArcBorrow<'a, T>;
>>  
>>      fn into_foreign(self) -> *const core::ffi::c_void {
>>          ManuallyDrop::new(self).ptr.as_ptr() as _
>>      }
>>  
>> -    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> ArcBorrow<'a, T> {
>> -        // SAFETY: By the safety requirement of this function, we know that `ptr` came from
>> -        // a previous call to `Arc::into_foreign`.
>> -        let inner = NonNull::new(ptr as *mut ArcInner<T>).unwrap();
>> -
>> -        // SAFETY: The safety requirements of `from_foreign` ensure that the object remains alive
>> -        // for the lifetime of the returned value.
>> -        unsafe { ArcBorrow::new(inner) }
>> -    }
>> -
>>      unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
>>          // SAFETY: By the safety requirement of this function, we know that `ptr` came from
>>          // a previous call to `Arc::into_foreign`, which guarantees that `ptr` is valid and
>>          // holds a reference count increment that is transferrable to us.
>> -        unsafe { Self::from_inner(NonNull::new(ptr as _).unwrap()) }
>> +        unsafe { Self::from_inner(NonNull::new_unchecked(ptr as _)) }
>>      }
>> +
>> +    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> ArcBorrow<'a, T> {
>> +        // SAFETY: By the safety requirement of this function, we know that `ptr` came from
>> +        // a previous call to `Arc::into_foreign`.
>> +        let inner = unsafe { NonNull::new_unchecked(ptr as *mut ArcInner<T>) };
>> +
>> +        // SAFETY: The safety requirements ensure that we will not give up our
>> +        // foreign-owned refcount while the `ArcBorrow` is still live.
>> +        unsafe { ArcBorrow::new(inner) }
>> +    }
>> +
>> +    unsafe fn borrow_mut<'a>(ptr: *const core::ffi::c_void) -> ArcBorrow<'a, T> {
>> +        // SAFETY: The safety requirements for `borrow_mut` are a superset of the safety
>> +        // requirements for `borrow`.
>> +        unsafe { Self::borrow(ptr) }
>> +    }
>
> I am not sure this makes sense. How about splitting the trait in two,
> immutable and mutable and only implementing the immutable one or Arc?

I used this design based on what would make sense for a linked list. The
idea is that we can have two different types of cursors for a linked
list: immutable and mutable. The immutable cursor lets you:

 * move around the linked list
 * access the values using `borrow`

The mutable cursor lets you:

 * move around the linked list
 * delete or add items to the list
 * access the values using `borrow_mut`

The mutable cursor gives you extra abilities beyond the `borrow` vs
`borrow_mut` distinction, so we want to provide both types of cursors
even if the pointer type is Arc. To do that, we need a trait that
defines what it means to have mutable access to an Arc.

Alice

