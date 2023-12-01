Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37683800A18
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 12:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378614AbjLALuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 06:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378585AbjLALut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 06:50:49 -0500
Received: from mail-lf1-x14a.google.com (mail-lf1-x14a.google.com [IPv6:2a00:1450:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A781708
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 03:50:55 -0800 (PST)
Received: by mail-lf1-x14a.google.com with SMTP id 2adb3069b0e04-50bcb455a3fso2249034e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 03:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701431453; x=1702036253; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/BVYl63ZIrcNFLUa5Nj/riyis5Au6tDAIb2Q4+PiwNE=;
        b=gaCdCZS8Wo+IpU+LvrghZGHSCTDlu2ovMWwXkkq4WgqAeFm2ZldnNzNzYETqGn4oX9
         eiSezNoCyNNLOq/PGtLrxZMYYkKilymI4NS2vIIYP1I0cTK6dfjIagIRyHDRnFQH6o1Q
         e4is4Ikj/5HnQ9VUMspMc6P17oQQEvHsqfsaAKTWAH351ICZ4HJ8pBAmLKbEaRGfM9HM
         VCtYrQyeNByRu2XlXYmzuE0nKhJCtWuGPwDdeoU1/R8DzSe8nxFg8YiILJ1c5AFBWJx9
         jCxytya20EekFz/xA+eAtupMe9j6Lq3+WMEO9ufiQT8WCY4+U4dNJTd9FdaVCCCua7U6
         FAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701431453; x=1702036253;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/BVYl63ZIrcNFLUa5Nj/riyis5Au6tDAIb2Q4+PiwNE=;
        b=YM4yMPj0vZTOa0h8xZYLqh6jKBCzxw1zvWRneAv5Qmr6lBnNjE8ZjxIbUqhmuKd0yR
         A1LJ6/QD+nGVNB57vH6WEQazekIxnyUe4USwsEzr8T1jsuH8CxNx+hLWVEqSfuVEMTuz
         RzleJxpNni2FYBpP2FUVRPLQPZL6Ef9vdJ/oQPT6qc/Mu6mC9CwzvwHjVtA23J619JHj
         OpCIccp9hY7NwzXHWYRq4/CXHfCpHY2vOyKl6vK6YN434bls7iwoMwoic8iloXsh8L2A
         RNzDL4AkhBImrPth1SdP0vIJsQ7jQfQpnAkZL06TTw9nfMED0qB6vw94vh289+jP29ZY
         LAoA==
X-Gm-Message-State: AOJu0YwSy4kfBbZRvMGad6xjdfQqNPXMRpx48/8CL9z4CepPFsTIeq/2
        XU1kTd1od+M1IOi9TRhiLmTD1RrUyRcszR8=
X-Google-Smtp-Source: AGHT+IHWIVTksmK0edVZGPr78JsVaudS40Jz9JyjF/DFPOEUrS0ZrluBGntBFY5f8ZeB66yp5PYJtPcHyw+v+T8=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:2392:b0:50b:d466:bb with SMTP
 id c18-20020a056512239200b0050bd46600bbmr53383lfv.4.1701431453776; Fri, 01
 Dec 2023 03:50:53 -0800 (PST)
Date:   Fri,  1 Dec 2023 11:50:51 +0000
In-Reply-To: <ZWkPGF5AS6creWTH@boqun-archlinux>
Mime-Version: 1.0
References: <ZWkPGF5AS6creWTH@boqun-archlinux>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231201115051.2209084-1-aliceryhl@google.com>
Subject: Re: [PATCH 7/7] rust: file: add abstraction for `poll_table`
From:   Alice Ryhl <aliceryhl@google.com>
To:     boqun.feng@gmail.com
Cc:     a.hindborg@samsung.com, alex.gaynor@gmail.com,
        aliceryhl@google.com, arve@android.com, benno.lossin@proton.me,
        bjorn3_gh@protonmail.com, brauner@kernel.org, cmllamas@google.com,
        dan.j.williams@intel.com, dxu@dxuuu.xyz, gary@garyguo.net,
        gregkh@linuxfoundation.org, joel@joelfernandes.org,
        keescook@chromium.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, maco@android.com, ojeda@kernel.org,
        peterz@infradead.org, rust-for-linux@vger.kernel.org,
        surenb@google.com, tglx@linutronix.de, tkjos@android.com,
        viro@zeniv.linux.org.uk, wedsonaf@gmail.com, willy@infradead.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boqun Feng <boqun.feng@gmail.com> writes:
>> That said, `synchronize_rcu` is rather expensive and is not needed in
>> all cases: If we have never registered a `poll_table` with the
>> `wait_list`, then we don't need to call `synchronize_rcu`. (And this is
>> a common case in Binder - not all processes use Binder with epoll.) The
>> current implementation does not account for this, but we could change it
>> to store a boolean next to the `wait_list` to keep track of whether a
>> `poll_table` has ever been registered. It is up to discussion whether
>> this is desireable.
>> 
>> It is not clear to me whether we can implement the above without storing
>> an extra boolean. We could check whether the `wait_list` is empty, but
>> it is not clear that this is sufficient. Perhaps someone knows the
>> answer? If a `poll_table` has previously been registered with a
> 
> That won't be sufficient, considering this:
> 
>     CPU 0                           CPU 1
>                                     ep_remove_wait_queue():
>                                       whead = smp_load_acquire(&pwq->whead); // whead is not NULL
>     PollCondVar::drop():
>       self.inner.notify():
>         <for each wait entry in the list>
> 	  ep_poll_callback():
> 	    <remove wait entry>
>             smp_store_release(&ep_pwq_from_wait(wait)->whead, NULL);
>       <lock the waitqueue>
>       waitqueue_active() // return false, since the queue is emtpy
>       <unlock>
>     ...
>     <free the waitqueue>
> 				       if (whead) {
> 				         remove_wait_queue(whead, &pwq->wait); // Use-after-free BOOM!
> 				       }
>       
> 
> Note that moving the `wait_list` empty checking before
> `self.inner.notify()` won't change the result, since there might be a
> `notify` called by users before `PollCondVar::drop()`, hence the same
> result.
> 
> Regards,
> Boqun

Thank you for confirming my suspicion.

Alice
