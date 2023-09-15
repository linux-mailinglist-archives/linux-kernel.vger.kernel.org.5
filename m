Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521157A2943
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 23:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237574AbjIOVWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 17:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237390AbjIOVW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 17:22:29 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460E4101
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 14:22:23 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2bcde83ce9fso41641731fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 14:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694812941; x=1695417741; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5/BraNFl/71q7+qGtNJcgBsbKAvg8Dj64vUtil4VRKI=;
        b=KzkyV/e+RXyR16FMk2RXU8Wcnx0mQ+XM82yOWmK3yVZXcSmzCwav+yajkdm2R3sPUC
         Qm9r5rCqZ4+at4vi+bJjT2sDRygJ0Ej68XPBiSFFSb0gjmc/x946WTeRTvh4vnK6X3wL
         +dxd8iNZ5tM1Gh92yHSC+5hdygGJrirY3C18I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694812941; x=1695417741;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5/BraNFl/71q7+qGtNJcgBsbKAvg8Dj64vUtil4VRKI=;
        b=PUNOoEyd0lvyEhKhSqmEwxeS3g7TzM3rKuLIcGVOWDSIFQhPv3BdDom6MvC+YAZ/JL
         b+/HbW41049FK9k4BRjiv5VjsgnmApKNprSJccoVMndk/SQjzxianwE5YhShUOYEW8KW
         Mh7fKQapQKyxYIGwcH5kLFtKCefyH8L6FUvYr0Qv3YCXd5HtbUDMADgUcBpBG7fAGzbH
         VnWyd92obt6gu2Oph7MUkGSrRufMSD9rg6YQnE/GqEBSnBZ2zKY3b62s9+8ehUF9Kvzd
         7l9VtFr8GYTDyWXuwBOkL0R4B9d5DHdDrax4HzbXGsysdPePfPM0U37hJlCOnrTjckZf
         1lag==
X-Gm-Message-State: AOJu0Yx2AftDrFYs7Dubhqx7bCZLB+ytwQGlVxbAzz0OL+hnjPMlHD/4
        bZaL0ola1sfDNA6AJOdZ4v+UIU3Gj+C2uRlXccHW8d/c
X-Google-Smtp-Source: AGHT+IFkvZJreH1mhhDobB5cvNkVzB2+/+P9lCBOqRHzuduPB42bLfPCuraISuQSsUant3MWrey7mQ==
X-Received: by 2002:a2e:b60c:0:b0:2be:58f3:ccee with SMTP id r12-20020a2eb60c000000b002be58f3cceemr2498025ljn.41.1694812941359;
        Fri, 15 Sep 2023 14:22:21 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id fi8-20020a170906da0800b00997e00e78e6sm2888114ejb.112.2023.09.15.14.22.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 14:22:20 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-530a6cbbb47so785501a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 14:22:20 -0700 (PDT)
X-Received: by 2002:a05:6402:150f:b0:523:a45f:419a with SMTP id
 f15-20020a056402150f00b00523a45f419amr2327902edw.41.1694812939897; Fri, 15
 Sep 2023 14:22:19 -0700 (PDT)
MIME-Version: 1.0
References: <07c32bf1-6c1a-49d9-b97d-f0ae4a2b42ab@p183> <CAHk-=whO1+-4ALjFWSE0kzytz1kEbWPvy3xWvcUP1dJ4t-QqkA@mail.gmail.com>
 <CACMJSetxQi+t3SBXu6OvBbmxV8AbX2CfdSA9JvF1chLJSU9Ppw@mail.gmail.com>
 <CAHk-=wgRHiV5VSxtfXA4S6aLUmcQYEuB67u3BJPJPtuESs1JyA@mail.gmail.com>
 <CACMJSevZQgik7S-62fz9H7+Mib+W0CgYMV4GyWjYV7N_E6iHVQ@mail.gmail.com>
 <CACMJSevrJ5KSPAZVheXkNaYj8KQFD8ck55kU_E4vEj4vzR8wnQ@mail.gmail.com>
 <CAHk-=wicfvWPuRVDG5R1mZSxD8Xg=-0nLOiHay2T_UJ0yDX42g@mail.gmail.com> <20230915210851.GA23174@noisy.programming.kicks-ass.net>
In-Reply-To: <20230915210851.GA23174@noisy.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Sep 2023 14:22:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=whvOGL3aNhtps0YksGtzvaob_bvZpbaTcVEqGwNMxB6xg@mail.gmail.com>
Message-ID: <CAHk-=whvOGL3aNhtps0YksGtzvaob_bvZpbaTcVEqGwNMxB6xg@mail.gmail.com>
Subject: Re: Buggy __free(kfree) usage pattern already in tree
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sept 2023 at 14:08, Peter Zijlstra <peterz@infradead.org> wrote:
>
> So in the perf-event conversion patches I do have this:
>
>         struct task_struct *task __free(put_task) = NULL;
>
>         ...
>
>         if (pid != -1) {
>                 task = find_lively_task_by_vpid(pid);
>                 if (!task)
>                         return -ESRCH;
>         }
>
>         ...
>
> pattern. The having of task is fully optional in the code-flow.

Yeah, if you end up having conditional initialization, you can't have
the cleanup declaration in the same place, since it would be in an
inner scope and get free'd immediately.

Still, I think that's likely the exception rather than the rule.

Side note: I hope your code snippets are "something like this" rather
than the real deal.

Because code like this:

> But a little later in that same function I then have:
>
>      do {
>              struct rw_semaphore *exec_update_lock __free(up_read) = NULL;
>              if (task) {
>                      err = down_read_interruptible(&task->signal->exec_update_lock);
>
>              struct rw_semaphore *exec_update_lock __free(up_read) = NULL;

is just garbage. That's not a "freeing" function. That should be "__cleanup()".

The last thing we want is misleading naming, making people think that
you are "freeing" a lock.

Naming is hard, let's not make it worse by making it actively misleading.

And honestly, I think the above is actually a *HORIBLE* argument for
doing that "initialize to NULL, change later". I think the above is
exactly the kind of code that we ABSOLUTELY DO NOT WANT.

You should aim for a nice

        struct rw_semaphore *struct rw_semaphore *exec_update_lock
            __cleanup(release_exec_update_lock) = get_exec_update_lock(task);

and simply have proper constructors and destructors. It's going to be
much cleaner.

You can literally do something like

    static inline void release_exec_update_lock(struct rw_semaphore *sem)
    { if (!IS_ERR_OR_NULL(sem)) up_read(sem); }

    static inline void get_exec_update_lock(struct task_struct *tsk)
    {
        if (!task)
                return NULL;
        if (down_read_interruptible(&task->signal->exec_update_lock))
                return ERR_PTR(-EINTR);
        retuin &task->signal->exec_update_lock;
    }

and the code will be *much* cleaner, wouldn't you say?

Please use proper constructors and destructors when you do these kinds
of automatic cleanup things. Don't write ad-hoc garbage.

You'll thank me a year from now when the code is actually legible.

                 Linus
