Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9976A79BA3D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236191AbjIKWmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357677AbjIKWFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 18:05:53 -0400
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780B022308
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 14:35:09 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-501bef6e0d3so8158565e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 14:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694467745; x=1695072545; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aEQHy8E6gWOE1flUwFUnaS7D8iHYGNq6LI3SdRK8uDk=;
        b=ZBrPhiK4Y0dWc2PAYlIAmWa7TCnWtHEprmaFEMd6chcmN+OYiHhQv60xnSnIGJtCaw
         rQJilhDtfaPfLsMhcN0L2figGgrKTveO8/HRKCnmEgSPL/igNip9FDkprfiEYkeQRa7n
         iydApAjPbT/hiwUTFrO31u0FyI3yZpQ93xsiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694467745; x=1695072545;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aEQHy8E6gWOE1flUwFUnaS7D8iHYGNq6LI3SdRK8uDk=;
        b=YNad8Xy0h7iW47gXpk4/mNbt++AwSkxa4fpswbmrDeBzvZ/oYRmB5KHKedxgrpHWCQ
         YW6WZviVxuPMNGO9EC/WcR4Usu1IL7hhSPArEeU92SkONezNrAjJ5g2i8bHCNIemBH+i
         DF95SeqTX7rwYPttH59YkbLVnpHTIWzOEXm7nfSLaZS16ePHO4DUA9CY6j35/D1VafQF
         80f/+e66JxpRRDRN4TzwKSIk8IB+bvX4CAbdHf0jB3rpH9F8xp5tRM3EKnOoffY47r2c
         L/CCKc+X2SxUlv3qJheYHeEMSw/6C/JqNl5zf2gIDIkvluIMIAZWir/g7Ch3ArXDHpli
         VNjw==
X-Gm-Message-State: AOJu0Yz+eukfc13KohiF0U+XlOB9rmQD+r0nCb2Y//pOlI03l0gSRsm0
        /2a+mq+0e51JrI5zsMG4rNpNfqsdyBlDdO4gwVOrIg1L
X-Google-Smtp-Source: AGHT+IEhZezHlpvmd2XaqIu4HTut5QFwUdypsBBDFoXzLrX75fk2inlBbR2EzNzIA6VDgN6SmtCY7A==
X-Received: by 2002:a05:6512:3ba9:b0:502:c950:592e with SMTP id g41-20020a0565123ba900b00502c950592emr778129lfv.25.1694466998000;
        Mon, 11 Sep 2023 14:16:38 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id i10-20020a056512006a00b004ffa0350851sm1480454lfo.78.2023.09.11.14.16.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 14:16:36 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so83577221fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 14:16:36 -0700 (PDT)
X-Received: by 2002:a05:651c:203:b0:2bc:f439:b5a5 with SMTP id
 y3-20020a05651c020300b002bcf439b5a5mr9138299ljn.14.1694466995798; Mon, 11 Sep
 2023 14:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
 <20230830184958.2333078-8-ankur.a.arora@oracle.com> <20230908070258.GA19320@noisy.programming.kicks-ass.net>
 <87zg1v3xxh.fsf@oracle.com> <CAHk-=whagwHrDxhjUVrRPhq78YC195KrSGzuC722-4MvAz40pw@mail.gmail.com>
 <87edj64rj1.fsf@oracle.com> <CAHk-=wi0bXpgULVVLc2AdJcta-fvQP7yyFQ_JtaoHUiPrqf--A@mail.gmail.com>
 <20230911124856.453fba22@gandalf.local.home> <CAHk-=whpYjm_AizQij6XEfTd7xvGjrVCx5gzHcHm=2Xijt+Kyg@mail.gmail.com>
In-Reply-To: <CAHk-=whpYjm_AizQij6XEfTd7xvGjrVCx5gzHcHm=2Xijt+Kyg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Sep 2023 14:16:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=whc0Jsji_h-vLyDLT6Q-NCjSTMOg9qXACmoPZOdWqMovg@mail.gmail.com>
Message-ID: <CAHk-=whc0Jsji_h-vLyDLT6Q-NCjSTMOg9qXACmoPZOdWqMovg@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, tglx@linutronix.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Sept 2023 at 13:50, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Except we've actually been *adding* to this whole mess, rather than
> removing it. So we have actively *expanded* on that preemption choice
> with PREEMPT_DYNAMIC.

Actually, that config option makes no sense.

It makes the sched_cond() behavior conditional with a static call.

But all the *real* overhead is still there and unconditional (ie all
the preempt count updates and the "did it go down to zero and we need
to check" code).

That just seems stupid. It seems to have all the overhead of a
preemptible kernel, just not doing the preemption.

So I must be mis-reading this, or just missing something important.

The real cost seems to be

   PREEMPT_BUILD -> PREEMPTION -> PREEMPT_COUNT

and PREEMPT vs PREEMPT_DYNAMIC makes no difference to that, since both
will end up with that, and thus both cases will have all the spinlock
preempt count stuff.

There must be some non-preempt_count cost that people worry about.

Or maybe I'm just mis-reading the Kconfig stuff entirely. That's
possible, because this seems *so* pointless to me.

Somebody please hit me with a clue-bat to the noggin.

                Linus
