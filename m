Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5069F79C110
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjILARa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 20:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjILARX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 20:17:23 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2CF14AE30
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 17:09:24 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-52713d2c606so6545935a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 17:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694477260; x=1695082060; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pIPOzP6LAN+yL7kKEyuXNnJg8Y+1WcCPbZvSjEDcprA=;
        b=Ab6HfbdX/AnsW2bVDCwJZ3DMiTudk+4oLnxqNGB6sCDawVY+lXWx83F4G4V+r0akDT
         ok/FOpyFOUVL0mH9c2kQPA4Fr3KePEzEHqQBqg2KFMjw6StXjDKIIlois5Iahd0xvEMT
         7k/7qvziE2KNWMXoaXC/+BrNyFSzQuspBPWp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694477260; x=1695082060;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pIPOzP6LAN+yL7kKEyuXNnJg8Y+1WcCPbZvSjEDcprA=;
        b=s06F2+UPHzcRhGMZB7pfDU63216rKwwRWEn4P5R7nVQ9p6p2DWbyp3bFKMImdMITfX
         ZwbCWt+HzE/tGqLjJZPK8q846pee4vtcvabU5wYR1Y5oV/wXc4vUPoasVeQUyid47JS7
         xLLrUIfRlDOWWhRLL9FvoxLFAPUCr7wCCPMy7+Xxidbux6VBYdErUJ4aZphrNd+wSXUo
         om1dsXYkMdnUBeV2r1/Afvfeb4Detw/JupCK7B/emuiDfm6UrZhpS3KivFmiT5w4fePW
         V/NGJRKJDwf6e3xVrvHFGKg3etIC2yePlagNgESYq4fgWqpKtpPSthq4yqcwfTGWsbia
         q0kw==
X-Gm-Message-State: AOJu0Ywo3gVIJRr3j4kKQRMN5Bu4+OuKRWO6AqMrYqLCZJzsekRqoW5n
        HWa20FTuHqutxsGOfn/lgKeTc2GBq1G6ND/PG+7d6aFm
X-Google-Smtp-Source: AGHT+IFzuVvhlN3MsL7AzkJ0YMPpsLmQc5mtScgpLnQWhvXdtSx2JvctpS/bj9PwhPVHdaIjSB3BHQ==
X-Received: by 2002:a2e:9254:0:b0:2b6:c886:681 with SMTP id v20-20020a2e9254000000b002b6c8860681mr8720608ljg.6.1694465918381;
        Mon, 11 Sep 2023 13:58:38 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id o15-20020a2e90cf000000b002bce0e9385asm1670078ljg.9.2023.09.11.13.58.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 13:58:38 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5008d16cc36so8318662e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 13:58:38 -0700 (PDT)
X-Received: by 2002:a2e:b2d4:0:b0:2b6:fa3f:9230 with SMTP id
 20-20020a2eb2d4000000b002b6fa3f9230mr8463202ljz.46.1694465470349; Mon, 11 Sep
 2023 13:51:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
 <20230830184958.2333078-8-ankur.a.arora@oracle.com> <20230908070258.GA19320@noisy.programming.kicks-ass.net>
 <87zg1v3xxh.fsf@oracle.com> <CAHk-=whagwHrDxhjUVrRPhq78YC195KrSGzuC722-4MvAz40pw@mail.gmail.com>
 <87edj64rj1.fsf@oracle.com> <CAHk-=wi0bXpgULVVLc2AdJcta-fvQP7yyFQ_JtaoHUiPrqf--A@mail.gmail.com>
 <20230911124856.453fba22@gandalf.local.home>
In-Reply-To: <20230911124856.453fba22@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Sep 2023 13:50:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=whpYjm_AizQij6XEfTd7xvGjrVCx5gzHcHm=2Xijt+Kyg@mail.gmail.com>
Message-ID: <CAHk-=whpYjm_AizQij6XEfTd7xvGjrVCx5gzHcHm=2Xijt+Kyg@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Sept 2023 at 09:48, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I wonder if we should make it a rule to not allow page faults when
> RESCHED_ALLOW is set?

I really think that user copies might actually be one of the prime targets.

Right now we special-case big user copes - see for example
copy_chunked_from_user().

But that's an example of exactly the problem this code has - we
literally make more complex - and objectively *WORSE* code just to
deal with "I want this to be interruptible".

So yes, we could limit RESCHED_ALLOW to not allow page faults, but big
user copies literally are one of the worst problems.

Another example of this this is just plain read/write. It's not a
problem in practice right now, because large pages are effectively
never used.

But just imagine what happens once filemap_read() actually does big folios?

Do you really want this code:

        copied = copy_folio_to_iter(folio, offset, bytes, iter);

to forever use the artificial chunking it does now?

And yes, right now it will still do things in one-page chunks in
copy_page_to_iter(). It doesn't even have cond_resched() - it's
currently in the caller, in filemap_read().

But just think about possible futures.

Now, one option really is to do what I think PeterZ kind of alluded to
- start deprecating PREEMPT_VOLUNTARY and PREEMPT_NONE entirely.

Except we've actually been *adding* to this whole mess, rather than
removing it. So we have actively *expanded* on that preemption choice
with PREEMPT_DYNAMIC.

That's actually reasonably recent, implying that distros really want
to still have the option.

And it seems like it's actually server people who want the "no
preemption" (and presumably avoid all the preempt count stuff entirely
- it's not necessarily the *preemption* that is the cost, it's the
incessant preempt count updates)

                            Linus
