Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237897D7DCF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 09:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344393AbjJZHu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 03:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjJZHu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 03:50:27 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19156CE
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 00:50:25 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5b5354da665so456602a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 00:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698306624; x=1698911424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4oF7/sp9r8tFN/7q4wIyKyAjM4HjrtS/MA/+IaxCrIo=;
        b=l/XxJ5kRaKh86hRhSYl0tQCyoCxgvrm4u3Wv734g9LGKxfrsJQNhJ2PpN5Udt69vXP
         fMDGE2RAGouOyWIyh2D3pa2DDiqkXeyiehDVY1dGhSAR/+HTn1Iu7cNXTVvdZqAgvGid
         RRb3po81EiquX0NgQonlc1d5Dcz+ll5RtJWRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698306624; x=1698911424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4oF7/sp9r8tFN/7q4wIyKyAjM4HjrtS/MA/+IaxCrIo=;
        b=GAixJMy900e6IfumY4hxVL5VCTOW6ULJH9Sd7eGsuLPuuvnsb/KzMU4Dc1gFGitNM7
         Er4nygDMcrCWXnX/4UkRHlxybb++bsobmktC15L6enYFF4cOggBQwkliZNbVwfO+myt3
         PQnNFoJudCtvekBgHCNA1HB3hE3fO7HMkNdoN5AnY0osi2nf885TzSMyg34lcGuqH1Hd
         r5+jZj/l5rlh1P3xJXh+e2FcfnQJjRAyfOxnzcwTjoobnpUv2tsrLiuU4ruwuyfzuSlG
         5gUNuYpUzygiVwkrzGNTwmhrfM/Q1LkrqhgoIolf56O9l0lD4Iq6BJWZ5RMBq563V9kN
         YTdQ==
X-Gm-Message-State: AOJu0YwlX92jbbeIPxSr5xVkDXorgzHDe2uBsVDTnAUcQzlixmRweZ5v
        nHn1ak9ZAJHgr/kzz+3wxrDn9w==
X-Google-Smtp-Source: AGHT+IEjhrgzbd6xxkUfyhfvIL+VYNKXZWIwdhaq2GkkASkOOL6jU4CP1v1Uh6uOkz0lGvT4bbSvtw==
X-Received: by 2002:a17:90a:df8f:b0:27d:237b:558b with SMTP id p15-20020a17090adf8f00b0027d237b558bmr15773440pjv.5.1698306624531;
        Thu, 26 Oct 2023 00:50:24 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:f228:3a07:1e7f:b38f])
        by smtp.gmail.com with ESMTPSA id n20-20020a17090ade9400b0027d1366d113sm1028327pjv.43.2023.10.26.00.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 00:50:24 -0700 (PDT)
Date:   Thu, 26 Oct 2023 16:50:16 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com,
        Joel Fernandes <joel@joelfernandes.org>,
        Youssef Esmat <youssefesmat@chromium.org>,
        Vineeth Pillai <vineethrp@google.com>,
        Suleiman Souhlal <suleiman@google.com>
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
Message-ID: <20231026075016.GC15694@google.com>
References: <CAHk-=whagwHrDxhjUVrRPhq78YC195KrSGzuC722-4MvAz40pw@mail.gmail.com>
 <87edj64rj1.fsf@oracle.com>
 <CAHk-=wi0bXpgULVVLc2AdJcta-fvQP7yyFQ_JtaoHUiPrqf--A@mail.gmail.com>
 <87zg1u1h5t.fsf@oracle.com>
 <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
 <20230911150410.GC9098@noisy.programming.kicks-ass.net>
 <87h6o01w1a.fsf@oracle.com>
 <20230912082606.GB35261@noisy.programming.kicks-ass.net>
 <87cyyfxd4k.ffs@tglx>
 <20231024103426.4074d319@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024103426.4074d319@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/10/24 10:34), Steven Rostedt wrote:
> On Tue, 19 Sep 2023 01:42:03 +0200
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> >    2) When the scheduler wants to set NEED_RESCHED due it sets
> >       NEED_RESCHED_LAZY instead which is only evaluated in the return to
> >       user space preemption points.
> > 
> >       As NEED_RESCHED_LAZY is not folded into the preemption count the
> >       preemption count won't become zero, so the task can continue until
> >       it hits return to user space.
> > 
> >       That preserves the existing behaviour.
> 
> I'm looking into extending this concept to user space and to VMs.
> 
> I'm calling this the "extended scheduler time slice" (ESTS pronounced "estis")
> 
> The ideas is this. Have VMs/user space share a memory region with the
> kernel that is per thread/vCPU. This would be registered via a syscall or
> ioctl on some defined file or whatever. Then, when entering user space /
> VM, if NEED_RESCHED_LAZY (or whatever it's eventually called) is set, it
> checks if the thread has this memory region and a special bit in it is
> set, and if it does, it does not schedule. It will treat it like a long
> kernel system call.
> 
> The kernel will then set another bit in the shared memory region that will
> tell user space / VM that the kernel wanted to schedule, but is allowing it
> to finish its critical section. When user space / VM is done with the
> critical section, it will check the bit that may be set by the kernel and
> if it is set, it should do a sched_yield() or VMEXIT so that the kernel can
> now schedule it.
> 
> What about DOS you say? It's no different than running a long system call.
> No task can run forever. It's not a "preempt disable", it's just "give me
> some more time". A "NEED_RESCHED" will always schedule, just like a kernel
> system call that takes a long time. The goal is to allow user space to get
> out of critical sections that we know can cause problems if they get
> preempted. Usually it's a user space / VM lock is held or maybe a VM
> interrupt handler that needs to wake up a task on another vCPU.
> 
> If we are worried about abuse, we could even punish tasks that don't call
> sched_yield() by the time its extended time slice is taken. Even without
> that punishment, if we have EEVDF, this extension will make it less
> eligible the next time around.
> 
> The goal is to prevent a thread / vCPU being preempted while holding a lock
> or resource that other threads / vCPUs will want. That is, prevent
> contention, as that's usually the biggest issue with performance in user
> space and VMs.

I think some time ago we tried to check guest's preempt count on each vm-exit
and we'd vm-enter if guest exited from a critical section (those that bump
preempt count) so that it can hopefully finish whatever is was going to
do and vmexit again. We didn't look into covering guest's RCU read-side
critical sections.

Can you educate me, is your PoC significantly different from guest preempt
count check?
