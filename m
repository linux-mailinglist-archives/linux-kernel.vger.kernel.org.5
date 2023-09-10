Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832D1799CA7
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 06:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346052AbjIJEgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 00:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238403AbjIJEgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 00:36:19 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C747195
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 21:36:14 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99c93638322so709490066b.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 21:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694320572; x=1694925372; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L8HEy6S0LdmzzzNFz4rEsIqVyXRa/Zk4t2KCxzu/Vho=;
        b=G5Msj5VS7aeKvqeDymn+sMEDhxQ/NDbYkfEgHsxqvim9khyHgehkxhkTDcMD/FzVaN
         IaEYHE6iXlsbiIybfD+/TvjDu2CDrNpX6tQrVXScYg8bmiDX/TRq7TIoffGE2PPEsTzp
         wfnr84+QCpfhP4NqH2uXU+tS0HaBJZ4sgWscw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694320572; x=1694925372;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L8HEy6S0LdmzzzNFz4rEsIqVyXRa/Zk4t2KCxzu/Vho=;
        b=DJ7J/KYYs/N+xBSyodiNhgS0bzc9EcuMjORrS6WytdeJe4FT6ZjFxujuxDv9OUiFAt
         2l+Ce1jE+mRvNaYcQaiiVQlSMysK68p7bOu3m2qcFKr7u9c6VZ4l2zVnIrRQZ7uW2Vx1
         ud5YvknNMXkk9phk6JzA7QUzIz02oODyJqaeW4mPzmkGFYpT8KceJPo2o5YSo/VP3fno
         07y5/85Bqq8JzYnnsqju+qsQfmayf1PDRy6IyW158Lil72Hc8KHoZBMnkIx1y7t9XPNM
         McKpO0EUuuDPeh9YxAf+2323UIzqDVJC8hdyWy+MDtxz978DMc/QRfN8MvJYS6RbK9hL
         DYNQ==
X-Gm-Message-State: AOJu0YwIIV4R3vYiHbVz0Aq6uuEEztkNi3I1lIiK8MkBYleCF2kiFvvu
        2/d472BMhosR5egxhezjMPR3zwf8B8UlGRusH0Qmac6X
X-Google-Smtp-Source: AGHT+IHQA5fdce8LMLNh5BafBbAlnDVW8aDFUGuU2cuxrrcqBEoNwXFJsRBn+dba6kWhV7wjFg9pZw==
X-Received: by 2002:a17:906:c113:b0:9a9:9d19:b250 with SMTP id do19-20020a170906c11300b009a99d19b250mr13085752ejc.17.1694320572646;
        Sat, 09 Sep 2023 21:36:12 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id g18-20020a170906595200b009931a3adf64sm3293126ejr.17.2023.09.09.21.36.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Sep 2023 21:36:12 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-9aa0495f9cfso326827066b.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 21:36:12 -0700 (PDT)
X-Received: by 2002:a17:907:2713:b0:9a5:cc2b:50e5 with SMTP id
 w19-20020a170907271300b009a5cc2b50e5mr8297488ejk.32.1694320572001; Sat, 09
 Sep 2023 21:36:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
 <20230830184958.2333078-8-ankur.a.arora@oracle.com> <20230908070258.GA19320@noisy.programming.kicks-ass.net>
 <87zg1v3xxh.fsf@oracle.com> <CAHk-=whagwHrDxhjUVrRPhq78YC195KrSGzuC722-4MvAz40pw@mail.gmail.com>
 <87edj64rj1.fsf@oracle.com>
In-Reply-To: <87edj64rj1.fsf@oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 9 Sep 2023 21:35:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi0bXpgULVVLc2AdJcta-fvQP7yyFQ_JtaoHUiPrqf--A@mail.gmail.com>
Message-ID: <CAHk-=wi0bXpgULVVLc2AdJcta-fvQP7yyFQ_JtaoHUiPrqf--A@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        tglx@linutronix.de, jon.grimm@amd.com, bharata@amd.com,
        raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Sept 2023 at 20:49, Ankur Arora <ankur.a.arora@oracle.com> wrote:
>
> I think we can keep these checks, but with this fixed definition of
> resched_allowed(). This might be better:
>
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2260,7 +2260,8 @@ static inline void disallow_resched(void)
>
>  static __always_inline bool resched_allowed(void)
>  {
> -       return unlikely(test_tsk_thread_flag(current, TIF_RESCHED_ALLOW));
> +       return unlikely(!preempt_count() &&
> +                        test_tsk_thread_flag(current, TIF_RESCHED_ALLOW));
>  }

I'm not convinced (at all) that the preempt count is the right thing.

It works for interrupts, yes, because interrupts will increment the
preempt count even on non-preempt kernels (since the preempt count is
also the interrupt context level).

But what about any synchronous trap handling?

In other words, just something like a page fault? A page fault doesn't
increment the preemption count (and in fact many page faults _will_
obviously re-schedule as part of waiting for IO).

A page fault can *itself* say "feel free to preempt me", and that's one thing.

But a page fault can also *interupt* something that said "feel free to
preempt me", and that's a completely *different* thing.

So I feel like the "tsk_thread_flag" was sadly completely the wrong
place to add this bit to, and the wrong place to test it in. What we
really want is "current kernel entry context".

So the right thing to do would basically be to put it in the stack
frame at kernel entry - whether that kernel entry was a system call
(which is doing some big copy that should be preemptible without us
having to add "cond_resched()" in places), or is a page fault (which
will also do things like big page clearings for hugepages)

And we don't have that, do we?

We have "on_thread_stack()", which checks for "are we on the system
call stack". But that doesn't work for page faults.

PeterZ - I feel like I might be either very confused, or missing
something You probably go "Duh, Linus, you're off on one of your crazy
tangents, and none of this is relevant because..."

                 Linus
