Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D48C79C852
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjILHi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjILHi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:38:56 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA3EB9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:38:52 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31c3df710bdso4804819f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694504330; x=1695109130; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+iqrvcXY/4bAbdcHH6fGo/1fRQ+e4TYFsEq51IoZPeM=;
        b=WpzbhA0NxXchp+3UB7pZ8jfNpNrTwRPMIt0wJFNqxXt2mmF2vq7PJfMjgy2CNYFZP0
         4ZKIWn2wJBpXIJFSWKP68CHyg3K6Hfcx1Z/Df5hdXjYoQ0cbAUavoSW83h3AQRrh2Q/V
         VLQEzXIqinKG+39vehe3BQ3TAnxTyAE32BChxutLa+Tbt3Ao/ckiaArTJqaJDbeJjLwY
         g7v0E0uVXqnJzA2r1AIxcpOcYe6DJ/tOxePP831WpLavPs1foA/eiqLpQJjYneUWcFh2
         bSaUTxwNKWAUWuR2XNnBybn+q7MFQ5GZP0im774Nqj2yUXHg30Z37yiY6GFzrCwfGSX+
         1XhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694504330; x=1695109130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+iqrvcXY/4bAbdcHH6fGo/1fRQ+e4TYFsEq51IoZPeM=;
        b=Pqbu1nX6/9QwcItmYRVM7asyvM3uKwYQEBmE5m9smz46/zbkpcZ1wz2WQO2Xxk6oyt
         AGojw/IQ4/X3gV8DLTNumdFw6+QDereyS/Lnl3f8xRMZcq4TSo9uIVyWy3/Rmn315WZn
         6gZsNtENqXaw3OZm6vDUEOG4It2xdSISMVaCo24uN69Anv9hSx0gLvd4teVYsZQbsn8B
         seBmZwwpRAznZgiWlrvBTk2vtH+5TQlIRx3XK6nuzT+8jYvExfJgbFBI9c8bT0nMuMrt
         XYHkiqe/O8WVDSWXExoZtrDs2oGOXVndoJLcxQEkXm1vyeGMNpan01IeOV1I/aMOTC5Y
         fgJw==
X-Gm-Message-State: AOJu0YxuD8dXLUookTLsZ8xdHvx9KL0jBw4R5HZgQzmRNhanjlSjL51w
        v0a7fsbGAPv2ZbPxwzuIw3Y=
X-Google-Smtp-Source: AGHT+IHt+8osXiQG7XmgmjaxhjKlPhc7MjegoQlIytXX/ed0M1Al0SFk5YGedvsmE/r/IJWs5M2LSw==
X-Received: by 2002:a5d:4b4c:0:b0:317:3deb:a899 with SMTP id w12-20020a5d4b4c000000b003173deba899mr9235784wrs.1.1694504329990;
        Tue, 12 Sep 2023 00:38:49 -0700 (PDT)
Received: from gmail.com (1F2EF048.nat.pool.telekom.hu. [31.46.240.72])
        by smtp.gmail.com with ESMTPSA id j12-20020adfe50c000000b003176aa612b1sm12058797wrm.38.2023.09.12.00.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 00:38:49 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 12 Sep 2023 09:38:46 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, tglx@linutronix.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
Message-ID: <ZQAVho72j1zG/HhK@gmail.com>
References: <20230830184958.2333078-8-ankur.a.arora@oracle.com>
 <20230908070258.GA19320@noisy.programming.kicks-ass.net>
 <87zg1v3xxh.fsf@oracle.com>
 <CAHk-=whagwHrDxhjUVrRPhq78YC195KrSGzuC722-4MvAz40pw@mail.gmail.com>
 <87edj64rj1.fsf@oracle.com>
 <CAHk-=wi0bXpgULVVLc2AdJcta-fvQP7yyFQ_JtaoHUiPrqf--A@mail.gmail.com>
 <20230911124856.453fba22@gandalf.local.home>
 <CAHk-=whpYjm_AizQij6XEfTd7xvGjrVCx5gzHcHm=2Xijt+Kyg@mail.gmail.com>
 <CAHk-=whc0Jsji_h-vLyDLT6Q-NCjSTMOg9qXACmoPZOdWqMovg@mail.gmail.com>
 <20230912072022.GA35261@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912072022.GA35261@noisy.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Sep 11, 2023 at 02:16:18PM -0700, Linus Torvalds wrote:
> > On Mon, 11 Sept 2023 at 13:50, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > Except we've actually been *adding* to this whole mess, rather than
> > > removing it. So we have actively *expanded* on that preemption choice
> > > with PREEMPT_DYNAMIC.
> > 
> > Actually, that config option makes no sense.
> > 
> > It makes the sched_cond() behavior conditional with a static call.
> > 
> > But all the *real* overhead is still there and unconditional (ie all
> > the preempt count updates and the "did it go down to zero and we need
> > to check" code).
> > 
> > That just seems stupid. It seems to have all the overhead of a
> > preemptible kernel, just not doing the preemption.
> > 
> > So I must be mis-reading this, or just missing something important.
> > 
> > The real cost seems to be
> > 
> >    PREEMPT_BUILD -> PREEMPTION -> PREEMPT_COUNT
> > 
> > and PREEMPT vs PREEMPT_DYNAMIC makes no difference to that, since both
> > will end up with that, and thus both cases will have all the spinlock
> > preempt count stuff.
> > 
> > There must be some non-preempt_count cost that people worry about.
> > 
> > Or maybe I'm just mis-reading the Kconfig stuff entirely. That's
> > possible, because this seems *so* pointless to me.
> > 
> > Somebody please hit me with a clue-bat to the noggin.
> 
> Well, I was about to reply to your previous email explaining this, but 
> this one time I did read more email..
> 
> Yes, PREEMPT_DYNAMIC has all the preempt count twiddling and only nops 
> out the schedule()/cond_resched() calls where appropriate.
> 
> This work was done by a distro (SuSE) and if they're willing to ship this 
> I'm thinking the overheads are acceptable to them.
> 
> For a significant number of workloads the real overhead is the extra 
> preepmtions themselves more than the counting -- but yes, the counting is 
> measurable, but probably in the noise compared to other some of the other 
> horrible things we have done the past years.
> 
> Anyway, if distros are fine shipping with PREEMPT_DYNAMIC, then yes, 
> deleting the other options are definitely an option.

Yes, so my understanding is that distros generally worry more about 
macro-overhead, for example material changes to a random subset of key 
benchmarks that specific enterprise customers care about, and distros are 
not nearly as sensitive about micro-overhead that preempt_count() 
maintenance causes.

PREEMPT_DYNAMIC is basically a reflection of that: the desire to have only 
a single kernel image, but a boot-time toggle to differentiate between 
desktop and server loads and have CONFIG_PREEMPT (desktop) but also 
PREEMPT_VOLUNTARY behavior (server).

There's also the view that PREEMPT kernels are a bit more QA-friendly, 
because atomic code sequences are much better defined & enforced via kernel 
warnings. Without preempt_count we only have irqs-off warnings, that are 
only a small fraction of all critical sections in the kernel.

Ideally we'd be able to patch out most of the preempt_count maintenance 
overhead too - OTOH these days it's little more than noise on most CPUs, 
considering the kind of horrible security-workaround overhead we have on 
almost all x86 CPU types ... :-/

Thanks,

	Ingo
