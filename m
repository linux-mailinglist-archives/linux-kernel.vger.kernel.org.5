Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4287FDDAE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbjK2Qz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbjK2Qzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:55:49 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BB6D1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:55:54 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5cddc35545dso79930287b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701276953; x=1701881753; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=unbZFkiD0dHweTLgp1OYP68ojVuVgwsL9BVcNl+eCj0=;
        b=ZHu6IwecdEJq762miAS3Om9MTNmVo8wTHYwvvBUO9TFlduLm2RhZPyjKON/lhUc40n
         Y7z6t4Ws5yrtGwOpdxFnTtz+DCoNhslTrjCwyUtKvZ1nUyfpM/7aAM8OFr96JWKKpg0w
         u/sj0wG66pfilbDxeIFiNg0E22XHst6ybyCS8ucnMtUCkhl31D6dB9U13Tm/zlXXUsGR
         mMpI57qoQriXTWaYZJPRW50t4AKy3xAgZHQAyr7MMLJtLbwaprUihbGY2ZE2sCI0wMvD
         uSHZpsbwfao/FQUH2IjMBeXye3i3DsZgEFSU/Sr4SQ/V/ZQxbel9Kx36WhQxkfHWgbuG
         0jGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701276953; x=1701881753;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=unbZFkiD0dHweTLgp1OYP68ojVuVgwsL9BVcNl+eCj0=;
        b=TlZOFcTJUaY6EJUG2VQmZ86aLVRtS9+483MWIfabE6hFHTFrgTfLLSoShykXrmthUz
         NH9CVLRyfff91+GqYTzYAu+z0KWw8JEyBu/HI/hgsVv3saktB3oZQxnrWBFvho9L7wOJ
         NHhod9odXokrhpcg+XsMQ9jUIjV6npz7o3Yqg/Ajn9nMPoSmg/xwqm6Gjnywl6eLBAhR
         m6yTUEmgAMgkynDfNPaor1qqKTKXUBXz1fXI1yRh+tldoIWVVcqpi/0IKwzonaKsMlir
         tZ597gYtQtVszRdQ1GJUWamuJxXzCK1hVdvk27Qrxv9pItwt1T7frf3964DIQ9Bmq3eG
         S9zQ==
X-Gm-Message-State: AOJu0YyEZ3eYHV7tbIdaOFiJRbeTAkFF1aPznQLhrJ1uLmxInXkNwjx/
        u126YWg4D9WOQ2OJ5O+rteiKr2wGVM9rqzQ=
X-Google-Smtp-Source: AGHT+IEpWMlZIbVFMqFnLabAnmVr/lPqw+N8K9vWZ1Skq6PXRN+J94RDlgF3JQbaZlH+xbk7iE6skGya8a4JWqA=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:690c:3183:b0:5ca:4a99:7008 with SMTP
 id fd3-20020a05690c318300b005ca4a997008mr630558ywb.10.1701276953779; Wed, 29
 Nov 2023 08:55:53 -0800 (PST)
Date:   Wed, 29 Nov 2023 16:55:51 +0000
In-Reply-To: <20231129-zwiespalt-exakt-f1446d88a62a@brauner>
Mime-Version: 1.0
References: <20231129-zwiespalt-exakt-f1446d88a62a@brauner>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231129165551.3476910-1-aliceryhl@google.com>
Subject: Re: [PATCH 4/7] rust: file: add `FileDescriptorReservation`
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
> Can we follow the traditional file terminology, i.e.,
> get_unused_fd_flags() and fd_install()? At least at the beginning this
> might be quite helpful instead of having to mentally map new() and
> commit() onto the C functions.

Sure, I'll do that in the next version.

>> +    /// Prevent values of this type from being moved to a different task.
>> +    ///
>> +    /// This is necessary because the C FFI calls assume that `current` is set to the task that
>> +    /// owns the fd in question.
>> +    _not_send_sync: PhantomData<*mut ()>,
> 
> I don't fully understand this. Can you explain in a little more detail
> what you mean by this and how this works?

Yeah, so, this has to do with the Rust trait `Send` that controls
whether it's okay for a value to get moved from one thread to another.
In this case, we don't want it to be `Send` so that it can't be moved to
another thread, since current might be different there.

The `Send` trait is automatically applied to structs whenever *all*
fields of the struct are `Send`. So to ensure that a struct is not
`Send`, you add a field that is not `Send`.

The `PhantomData` type used here is a special zero-sized type.
Basically, it says "pretend this struct has a field of type `*mut ()`,
but don't actually add the field". So for the purposes of `Send`, it has
a non-Send field, but since its wrapped in `PhantomData`, the field is
not there at runtime.

>> +        Ok(Self {
>> +            fd: fd as _,
> 
> This is a cast to a u32?

Yes.

> Can you please draft a quick example how that return value would be
> expected to be used by a caller? It's really not clear

The most basic usage would look like this:

	// First, reserve the fd.
	let reservation = FileDescriptorReservation::new(O_CLOEXEC)?;

	// Then, somehow get a file to put in it.
	let file = get_file_using_fallible_operation()?;

	// Finally, commit it to the fd.
	reservation.commit(file);

In Rust Binder, reservations are used here:
https://github.com/Darksonn/linux/blob/dca45e6c7848e024709b165a306cdbe88e5b086a/drivers/android/allocation.rs#L199-L210
https://github.com/Darksonn/linux/blob/dca45e6c7848e024709b165a306cdbe88e5b086a/drivers/android/allocation.rs#L512-L541

>> +    pub fn commit(self, file: ARef<File>) {
>> +        // SAFETY: `self.fd` was previously returned by `get_unused_fd_flags`, and `file.ptr` is
>> +        // guaranteed to have an owned ref count by its type invariants.
>> +        unsafe { bindings::fd_install(self.fd, file.0.get()) };
> 
> Why file.0.get()? Where did that come from?

This gets a raw pointer to the C type.

The `.0` part is a field access. `ARef` struct is a tuple struct, so its
fields are unnamed. However, the fields can still be accessed by index.

Alice
