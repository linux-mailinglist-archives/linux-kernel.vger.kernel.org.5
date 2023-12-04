Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C0680390D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 16:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbjLDPm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 10:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjLDPm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 10:42:56 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDE7B0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 07:43:02 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db402e6f61dso3432756276.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 07:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701704581; x=1702309381; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xfK9TlefHc7mRtPrpHFFYKDLxrgLCZkCjPMobBdjijM=;
        b=3WicJ16pvToD3e9Z1135Br25xC7rAGtpGGS5Jgeriupv1FJXy+fN3Y7fuzQ7YIHK+S
         oPV+mCFgwINgsuJ89E4MxHLyKmDiSyG9Y5dw1dnm+p5C8ZhVJyxo7OpKg9S8VzHje5MN
         ugLZaW1tfkDm3Tjy0AnAASakxGSNAWUUyIAoGtG//cNQ8fVF95aRnPyAKvA814FzEowY
         mSkXqpCx+UIlaM5u44DnRhuygQzncjyETnWbJs3LZccoitmoSalg3SkPHhRxPjsaQpA5
         0LhpWgo3gAVRmP0auiHi3m63V1H4Hxgnk4p8wEay+yuOtIt3uuRCU7q1rviM9x2CydmQ
         o3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701704581; x=1702309381;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xfK9TlefHc7mRtPrpHFFYKDLxrgLCZkCjPMobBdjijM=;
        b=ijF4qSmR4UxgrEIP48j5NSAeUB3wn0Mkh42bJtlmgMslmBu3246bx+s9B4zgBnvtc4
         ATfpVlI3WfIKs91YY3kkHqPDUB8jDzNOST/pQzQwbnArL904fUSus+Gpa43aoqWoTB2p
         AbACKHqJqPawu8e7HrzpqToESMRQZIQggnESXuzPRnAXzfKZj/GrqzoyzLrYoY4Thvr5
         GZ5P3XeYFDmX2wmCkD/OVyTxSq1rkkDCAsuMR6pMRqcFV4N09iGAjN5gvL8dstXXJtsO
         U6djipVJGPRpG+rJttQm9//OBAZkZR11RPZ9oForbuJHD1R/2+q9DXO/IGFWYaM4otJU
         nHgg==
X-Gm-Message-State: AOJu0Yx4aFRpYkmovSSzbG8kkcy1CaMYIsh3J0fYg6reNJIAnNNy24Hb
        mAWdQR6ERix+VQVy5e6jYbghQZU1ufnaMjQ=
X-Google-Smtp-Source: AGHT+IF5vXT7L2NfCCScVUhEdNBMLFarwJWD1avitjpZToP9B/GeVxDMVqxOYsLK8Qpl8id4UHBwIV1CHtz3+60=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a25:3006:0:b0:daf:6333:17c3 with SMTP id
 w6-20020a253006000000b00daf633317c3mr965267ybw.1.1701704581579; Mon, 04 Dec
 2023 07:43:01 -0800 (PST)
Date:   Mon,  4 Dec 2023 15:42:59 +0000
In-Reply-To: <20231201-zacken-gewachsen-73fe323b067b@brauner>
Mime-Version: 1.0
References: <20231201-zacken-gewachsen-73fe323b067b@brauner>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231204154259.79529-1-aliceryhl@google.com>
Subject: Re: [PATCH 2/7] rust: cred: add Rust abstraction for `struct cred`
From:   Alice Ryhl <aliceryhl@google.com>
To:     brauner@kernel.org
Cc:     a.hindborg@samsung.com, alex.gaynor@gmail.com,
        aliceryhl@google.com, arve@android.com, benno.lossin@proton.me,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com,
        cmllamas@google.com, dan.j.williams@intel.com, dxu@dxuuu.xyz,
        gary@garyguo.net, gregkh@linuxfoundation.org,
        joel@joelfernandes.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@android.com, ojeda@kernel.org, peterz@infradead.org,
        rust-for-linux@vger.kernel.org, surenb@google.com,
        tglx@linutronix.de, tkjos@android.com, viro@zeniv.linux.org.uk,
        wedsonaf@gmail.com, willy@infradead.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <brauner@kernel.org> writes:
> On Fri, Dec 01, 2023 at 09:06:35AM +0000, Alice Ryhl wrote:
> > Benno Lossin <benno.lossin@proton.me> writes:
> > > On 11/29/23 13:51, Alice Ryhl wrote:
> > >> +    /// Returns the credentials of the task that originally opened the file.
> > >> +    pub fn cred(&self) -> &Credential {
> > >> +        // This `read_volatile` is intended to correspond to a READ_ONCE call.
> > >> +        //
> > >> +        // SAFETY: The file is valid because the shared reference guarantees a nonzero refcount.
> > >> +        //
> > >> +        // TODO: Replace with `read_once` when available on the Rust side.
> > >> +        let ptr = unsafe { core::ptr::addr_of!((*self.0.get()).f_cred).read_volatile() };
> > >> +
> > >> +        // SAFETY: The signature of this function ensures that the caller will only access the
> > >> +        // returned credential while the file is still valid, and the credential must stay valid
> > >> +        // while the file is valid.
> > > 
> > > About the last part of this safety comment, is this a guarantee from the
> > > C side? If yes, then I would phrase it that way:
> > > 
> > >     ... while the file is still valid, and the C side ensures that the
> > >     credentials stay valid while the file is valid.
> > 
> > Yes, that's my intention with this code.
> > 
> > But I guess this is a good question for Christian Brauner to confirm:
> > 
> > If I read the credential from the `f_cred` field, is it guaranteed that
> > the pointer remains valid for at least as long as the file?
> > 
> > Or should I do some dance along the lines of "lock file, increment
> > refcount on credential, unlock file"?
> 
> The lifetime of the f_cred reference is at least as long as the lifetime
> of the file:
> 
> // file not yet visible anywhere
> some_file = alloc_file*()
> -> init_file()
>    {
>            file->f_cred = get_cred(cred /* usually current_cred() */)
>    }
> 
> 
> // install into fd_table -> irreversible, thing visible, possibly shared
> fd_install(1234, some_file)
> 
> // last fput
> fput()
> // atomic_dec_and_test() dance:
> -> file_free() // either "delayed" through task work, workqueue, or
> 	       // sometimes freed right away if file hasn't been opened,
> 	       // i.e., if fd_install() wasn't called
>    -> put_cred(file->f_cred)
> 
> In order to access anything you must hold a reference to the file or
> files->file_lock. IOW, no poking around in f->f_cred or any field for
> that matter just under rcu_read_lock() for example. Because files are
> SLAB_TYPESAFE_BY_RCU. You might be poking in someone else's creds then.

Okay, we aren't dealing with the rcu case in this patchset, so we know
that it wont be freed while we're accessing it.

I guess this means that the `f_cred` field is immutable, which means
that I don't need READ_ONCE to read it? I'll use an ordinary load in the
next version.

Alice
