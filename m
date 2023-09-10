Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0640799F58
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 20:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjIJSdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 14:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjIJSc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 14:32:59 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097E1131
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 11:32:52 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99bcc0adab4so463705066b.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 11:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694370770; x=1694975570; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FMlIV4MTu5DEIKaM74ShUQPpObFts+yGqhlBt2NCN8M=;
        b=SLIafdB8Pa4sNSNe2RNQk499KViWTHm294Fj5jUJG6se4VifH8OCDR1sKFERuvMK5y
         N+MhT2Vakw+ranVKEBUoGkBuShRZjjeb0nxY1zpdFvhcZxmzNhBokl8q+KYKptoDHXAF
         +o3Fanp9JC+nFQS48R5Gq7+fb01C7S2oGQf1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694370770; x=1694975570;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FMlIV4MTu5DEIKaM74ShUQPpObFts+yGqhlBt2NCN8M=;
        b=HN7WweYneD2A6YlQXSSQu5OrDO75551tcqGERzoSgFy5q0jLiqI5oOP4MOXlD06IvE
         PzCNrbttY8Fg1snPjoH7fVvTwjv6Z+VzCsTpp3VXknmKtLiO2hHzxtWKZQrH6QSu8EEr
         nY1XeJMIVOfi6M0X/do2dwSChLl2i0AbFtlSzaaW3/fYTdGJin0uuqYS1urUPFhhRdsB
         Ydpj/Y5DLoylLFfuZmQVPu9dntiQVaFiogwXSiVnsYBy/gEV6Bfby4K0gyA0Q8NxqeS/
         erOd5jXZZha64wuBCSJhpX6mURAsVx/Vznw5mdOmcLmz8KZHMxQRZiB/BNbr1akIWzA7
         IfEg==
X-Gm-Message-State: AOJu0YwIV6zUfK4IXyi2pjITj+u098pODdwbKwKQhnZorHvkW1z+/8fV
        wuLOkKNlp8ilw6PhtVJ9BaoPPDq6JTTLT8+gei2XunsW
X-Google-Smtp-Source: AGHT+IHPAOEs9cr39BMKuu6Q8/mQ6Jqpm1uz6A7G5BrvzmOZAqZc6qVVVbPw+6O9GQwY2EM3cYTH1A==
X-Received: by 2002:a17:906:21b:b0:994:522f:3f4a with SMTP id 27-20020a170906021b00b00994522f3f4amr6963297ejd.29.1694370770424;
        Sun, 10 Sep 2023 11:32:50 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id ox3-20020a170907100300b0098dfec235ccsm4116842ejb.47.2023.09.10.11.32.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Sep 2023 11:32:50 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-9aa2c6f0806so20737266b.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 11:32:50 -0700 (PDT)
X-Received: by 2002:a17:907:7791:b0:9a9:e41c:bcb6 with SMTP id
 ky17-20020a170907779100b009a9e41cbcb6mr6664791ejc.28.1694370769787; Sun, 10
 Sep 2023 11:32:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
 <20230830184958.2333078-8-ankur.a.arora@oracle.com> <20230908070258.GA19320@noisy.programming.kicks-ass.net>
 <87zg1v3xxh.fsf@oracle.com> <CAHk-=whagwHrDxhjUVrRPhq78YC195KrSGzuC722-4MvAz40pw@mail.gmail.com>
 <87edj64rj1.fsf@oracle.com> <CAHk-=wi0bXpgULVVLc2AdJcta-fvQP7yyFQ_JtaoHUiPrqf--A@mail.gmail.com>
 <87zg1u1h5t.fsf@oracle.com>
In-Reply-To: <87zg1u1h5t.fsf@oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 10 Sep 2023 11:32:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
Message-ID: <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
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

On Sun, 10 Sept 2023 at 03:01, Ankur Arora <ankur.a.arora@oracle.com> wrote:
>
> Seems to me that associating an allow_resched flag with the stack also
> has similar issue. Couldn't the context level change while we are on the
> same stack?

On x86-64 no, but in other situations yes.

> I guess the problem is that allow_resched()/disallow_resched() really
> need to demarcate a section of code having some property, but instead
> set up state that has much wider scope.
>
> Maybe code that allows resched can be in a new .section ".text.resched"
> or whatever, and we could use something like this as a check:

Yes. I'm starting to think that that the only sane solution is to
limit cases that can do this a lot, and the "instruciton pointer
region" approach would certainly work.

At the same time I really hate that, because I was hoping we'd be able
to use this to not have so many of those annoying and random
"cond_resched()" calls.

I literally merged another batch of "random stupid crap" an hour ago:
commit 3d7d72a34e05 ("x86/sgx: Break up long non-preemptible delays in
sgx_vepc_release()") literally just adds manual 'cond_resched()' calls
in random places.

I was hoping that we'd have some generic way to deal with this where
we could just say "this thing is reschedulable", and get rid of - or
at least not increasingly add to - the cond_resched() mess.

Of course, that was probably always unrealistic, and those random
cond_resched() calls we just added probably couldn't just be replaced
by "you can reschedule me" simply because the functions quite possibly
end up taking some lock hidden in one of the xa_xyz() functions.

For the _particular_ case of "give me a preemptible big memory copy /
clear", the section model seems fine. It's just that we do have quite
a bit of code where we can end up with long loops that want that
cond_resched() too that I was hoping we'd _also_ be able to solve.

                   Linus
