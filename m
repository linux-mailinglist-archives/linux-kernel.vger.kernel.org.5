Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A857A9EA7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjIUUH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbjIUUHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:07:46 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0329D1FE8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:02:15 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99c1c66876aso145071666b.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695315662; x=1695920462; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=19SW2gsLL1UdhsDBKiLlNxKkdUUQxSgCx6gW88i2Zes=;
        b=NC9YxZCcV5mWuV4hivgJTEtsoQObB4P+6CvY2dBTY7it/cPw2l1uj4YlsZGjWUdlHW
         CENcSL3V6EPyb5lelGqVJ1Lsb0GIdRG0u14GUJ0b/ICutLNM03RdA/ZSz/f9HYmm3sCt
         fvfVjkuuT576uOfnkyVrIWTzESnr/40Br0NcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695315662; x=1695920462;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=19SW2gsLL1UdhsDBKiLlNxKkdUUQxSgCx6gW88i2Zes=;
        b=Rg2vBxCqPeTwh/wgYkqqFa1Qi/EU5A0rhcGcIZAviFO67DztjPLbLi9S5J0Tu6U6Oo
         IEGu1nDeq8A7/LYhNeFhUez//k7WZKRdSHyxhZ8riAvKlTM4us9Je6QNARMVYKsg4a1C
         7/dGVCbA+eDevHKqmovZZEpK+usQZl3NjDAdKqOG9pAapNCPXp/DldQJqhjs/15m9aIn
         DU6xXIs8IcB1ZKmxv1+EZJR6wAjXaEyVmi4pmyYmLfJ0sy6jw3JbvCvauO4otxR6yWU9
         4FYb4aHUyoxY38Dh0Kxy+tm9xQp+04AAoNDdMPcvOCDAoPZDhI/pF7eZiGh57MyxgB/z
         EDWQ==
X-Gm-Message-State: AOJu0YwKNU2GPsZ2HOeB8oSH4Q2upC5vFba4DnpmZiaI1gnzwsf5i4SH
        zkrUCT1LT54CrSuJRjAHlv/fr77U1vxWF8N8WcNnDZU4
X-Google-Smtp-Source: AGHT+IEOiGq2WUxqncse0GSK9WElwYns1AiX2s54rCR17XJgVp1yBUKXYqSYej4U24C367gKLmlIKQ==
X-Received: by 2002:a17:906:2cc:b0:9a5:b878:7336 with SMTP id 12-20020a17090602cc00b009a5b8787336mr5997744ejk.7.1695312073186;
        Thu, 21 Sep 2023 09:01:13 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id l3-20020a170906230300b009932337747esm1263922eja.86.2023.09.21.09.01.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 09:01:12 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5310a63cf7bso1362565a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 09:01:12 -0700 (PDT)
X-Received: by 2002:aa7:c448:0:b0:52a:6497:d02b with SMTP id
 n8-20020aa7c448000000b0052a6497d02bmr5458698edr.16.1695312071878; Thu, 21 Sep
 2023 09:01:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230830184958.2333078-8-ankur.a.arora@oracle.com>
 <20230908070258.GA19320@noisy.programming.kicks-ass.net> <87zg1v3xxh.fsf@oracle.com>
 <CAHk-=whagwHrDxhjUVrRPhq78YC195KrSGzuC722-4MvAz40pw@mail.gmail.com>
 <87edj64rj1.fsf@oracle.com> <CAHk-=wi0bXpgULVVLc2AdJcta-fvQP7yyFQ_JtaoHUiPrqf--A@mail.gmail.com>
 <87zg1u1h5t.fsf@oracle.com> <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
 <20230911150410.GC9098@noisy.programming.kicks-ass.net> <87h6o01w1a.fsf@oracle.com>
 <20230912082606.GB35261@noisy.programming.kicks-ass.net> <87cyyfxd4k.ffs@tglx>
 <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
 <87led2wdj0.ffs@tglx> <8734z8v1lo.ffs@tglx>
In-Reply-To: <8734z8v1lo.ffs@tglx>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 Sep 2023 09:00:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wix=nrfi2LkSXBvBSrTHgEAMYQebUfWXq8Q-PtH0x_SdQ@mail.gmail.com>
Message-ID: <CAHk-=wix=nrfi2LkSXBvBSrTHgEAMYQebUfWXq8Q-PtH0x_SdQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com,
        Frederic Weisbecker <fweisbec@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I like this.

That said, this part of it:

On Wed, 20 Sept 2023 at 16:58, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> -void resched_curr(struct rq *rq)
> +static void __resched_curr(struct rq *rq, int nr_bit)
>  [...]
> -               set_tsk_need_resched(curr);
> -               set_preempt_need_resched();
> +               set_tsk_thread_flag(curr, nr_bit);
> +               if (nr_bit == TIF_NEED_RESCHED)
> +                       set_preempt_need_resched();

feels really hacky.

I think that instead of passing a random TIF bit around, it should
just pass a "lazy or not" value around.

Then you make the TIF bit be some easily computable thing (eg something like

        #define TIF_RESCHED(lazy) (TIF_NEED_RESCHED + (lazy))

or whatever), and write the above conditional as

        if (!lazy)
                set_preempt_need_resched();

so that it all *does* the same thing, but the code makes it clear
about what the logic is.

Because honestly, without having been part of this thread, I would look at that

        if (nr_bit == TIF_NEED_RESCHED)
                set_preempt_need_resched();

and I'd be completely lost. It doesn't make conceptual sense, I feel.

So I'd really like the source code to be more directly expressing the
*intent* of the code, not be so centered around the implementation
detail.

Put another way: I think we can make the compiler turn the intent into
the implementation, and I'd rather *not* have us humans have to infer
the intent from the implementation.

That said - I think as a proof of concept and "look, with this we get
the expected scheduling event counts", that patch is perfect. I think
you more than proved the concept.

                 Linus
