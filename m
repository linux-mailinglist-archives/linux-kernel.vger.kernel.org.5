Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC173799B53
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 23:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241571AbjIIVRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 17:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbjIIVRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 17:17:24 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F11131
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 14:17:16 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-5009d4a4897so5391726e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 14:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694294234; x=1694899034; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FUTX2wZtyaGuqkUm3+lfhlNbLIAZVk0Z/0uyTAczRl0=;
        b=f8hDBLdyJraoy40fvC3U8LtSSwt0CBXTH+nV3mWGfMMOeb1r1UoAjycircBv7yrz2z
         xAXWDGzoXWq1EOjo3q+VhG+SZA4aQT+A2aDqctIEBSrt85lYMBUXb5FKjGzYWy+y3vW2
         G2Q4u7y096tN9a0zBXpOXNkp5b2cNrbEqUX+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694294234; x=1694899034;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FUTX2wZtyaGuqkUm3+lfhlNbLIAZVk0Z/0uyTAczRl0=;
        b=gD+lbvo6fKKwEfPvENZkOudp9bBhRhjMraHO41iBUrIHvZVTOKO6M/vHoPk33bThLg
         TxkHVhPpT/RAhyy5v3UggYMt4kSUz89uBmgf+9ixFiun7LyaUPd05UOHAZpXQ6ROWBvO
         58yCQNxx8KWamWiweNUP6HvsTYhKhbWlGyEjiipdYj/oYg9GnSXDV8GNkwUlNVX9Es/M
         jrrnvH7/E1hfmeNa2RXaeV/ulYQsafhEs+7ZrBrAVBjTSf7LWll3fvR0kTNRQIKlfYLb
         0WHdEiKKhHp7no0N63Ri1WkYv2iUDSu/Ue9Wf8j4c0iYzDA5qCKhRwRvANevFrrDBnO+
         oRPw==
X-Gm-Message-State: AOJu0YyMy4KOh5gk1uVubjdBiyfzYTQZk/BkLVbiTqVkuNWhi+4NXm9z
        EQdHAwwcfqp09MzPbdTm17AQO+K1MQVlBBKCUnN/BZd6
X-Google-Smtp-Source: AGHT+IGfOtckppz2NzZdJFb7Y3s9+wEHVPvawfdAmeILC/9b3t1m8S5NLfJsemMZXnw+63XesCLy8Q==
X-Received: by 2002:ac2:58e7:0:b0:4fb:90c6:c31a with SMTP id v7-20020ac258e7000000b004fb90c6c31amr4214159lfo.14.1694294233996;
        Sat, 09 Sep 2023 14:17:13 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id w6-20020ac254a6000000b004fb64600e5dsm731024lfk.219.2023.09.09.14.17.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Sep 2023 14:17:12 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-502934c88b7so4894729e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 14:17:11 -0700 (PDT)
X-Received: by 2002:ac2:597b:0:b0:500:a092:d085 with SMTP id
 h27-20020ac2597b000000b00500a092d085mr4467355lfp.68.1694294231470; Sat, 09
 Sep 2023 14:17:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
 <20230830184958.2333078-8-ankur.a.arora@oracle.com> <20230908070258.GA19320@noisy.programming.kicks-ass.net>
 <87zg1v3xxh.fsf@oracle.com>
In-Reply-To: <87zg1v3xxh.fsf@oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 9 Sep 2023 14:16:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=whagwHrDxhjUVrRPhq78YC195KrSGzuC722-4MvAz40pw@mail.gmail.com>
Message-ID: <CAHk-=whagwHrDxhjUVrRPhq78YC195KrSGzuC722-4MvAz40pw@mail.gmail.com>
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

On Sat, 9 Sept 2023 at 13:16, Ankur Arora <ankur.a.arora@oracle.com> wrote:
>
> > +     if (WARN_ON(resched_allowed()))
> > +             return;
>
> And, maybe something like this to guard against __this_cpu_read()
> etc:
>
> +++ b/lib/smp_processor_id.c
> @@ -13,6 +13,9 @@ unsigned int check_preemption_disabled(const char *what1, const char *what2)
>  {
>         int this_cpu = raw_smp_processor_id();
>
> +       if (unlikely(resched_allowed()))
> +               goto out_error;

Again, both of those checks are WRONG.

They'll error out even in exceptions / interrupts, when we have a
preempt count already from the exception itself.

So testing "resched_allowed()" that only tests the TIF_RESCHED_ALLOW
bit is wrong, wrong, wrong.

These situations aren't errors if we already had a preemption count
for other reasons. Only trying to disable preemption when in process
context (while TIF_RESCHED_ALLOW) is a problem. Your patch is missing
the check for "are we in a process context" part.

                Linus
