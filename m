Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CF37D41F1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 23:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbjJWVvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 17:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjJWVvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 17:51:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6683BD;
        Mon, 23 Oct 2023 14:51:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83A0C433C8;
        Mon, 23 Oct 2023 21:51:16 +0000 (UTC)
Date:   Mon, 23 Oct 2023 17:51:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Dan Raymond <raymod2@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-serial <linux-serial@vger.kernel.org>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        andriy.shevchenko@linux.intel.com, quic_saipraka@quicinc.com
Subject: Re: [PATCH v5] arch/x86: port I/O tracing on x86
Message-ID: <20231023175112.251f7072@gandalf.local.home>
In-Reply-To: <78787d18-0f30-4be0-9e7c-1b6dbf142fec@gmail.com>
References: <b8eae358-a3b3-fd68-82f1-b2c53534b922@gmail.com>
        <2023100344-dart-jailbreak-c371@gregkh>
        <94e2b77c-9cc4-534f-e650-06d7e0697f9f@gmail.com>
        <20231004195001.76a57417@gandalf.local.home>
        <80b84be0-a0ad-d1a9-607a-a87c6cf509e0@gmail.com>
        <cc7fba3b-9da2-b9eb-95c8-7336e1cd4449@gmail.com>
        <2023102122-diabetes-trend-57d0@gregkh>
        <20231021161503.382e3d2e@rorschach.local.home>
        <78787d18-0f30-4be0-9e7c-1b6dbf142fec@gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2023 15:29:53 -0600
Dan Raymond <raymod2@gmail.com> wrote:

> On 10/21/2023 2:15 PM, Steven Rostedt wrote:
> 
> >> Why are these needed to be changed at all?  What code changes with it,
> >> and it's not mentioned in the changelog, so why is it required?  

BTW, trimming is good, but it's still better to leave the code that the
comment was talking about. I had to go back to my sent folder to figure it
out.

Adding back here for reference:


> > --- a/arch/x86/include/asm/cmpxchg_32.h
> > +++ b/arch/x86/include/asm/cmpxchg_32.h
> > @@ -37,13 +37,16 @@ static inline void set_64bit(volatile u64 *ptr, u64 value)
> >  
> >  #ifdef CONFIG_X86_CMPXCHG64
> >  #define arch_cmpxchg64(ptr, o, n)					\
> > -	((__typeof__(*(ptr)))__cmpxchg64((ptr), (unsigned long long)(o), \
> > +	((__typeof__(*(ptr)))__cmpxchg64((unsigned long long *)(ptr),	\
> > +					 (unsigned long long)(o),	\
> >  					 (unsigned long long)(n)))
> > -#define arch_cmpxchg64_local(ptr, o, n)					\
> > -	((__typeof__(*(ptr)))__cmpxchg64_local((ptr), (unsigned long long)(o), \
> > +#define arch_cmpxchg64_local(ptr, o, n)						\
> > +	((__typeof__(*(ptr)))__cmpxchg64_local((unsigned long long *)(ptr),	\
> > +					       (unsigned long long)(o),		\
> >  					       (unsigned long long)(n)))
> > -#define arch_try_cmpxchg64(ptr, po, n)					\
> > -	__try_cmpxchg64((ptr), (unsigned long long *)(po), \
> > +#define arch_try_cmpxchg64(ptr, po, n)			\
> > +	__try_cmpxchg64((unsigned long long *)(ptr),	\
> > +			(unsigned long long *)(po),	\
> >  			(unsigned long long)(n))
> >  #endif

> > 
> > Agreed, if this has issues, it probably should be a separate patch.  
> 
> As I mentioned to Greg, this fix is needed to avoid compiler warnings
> triggered by this patch.  If I submitted this separately it would have
> to be merged first.  Isn't it easier to combine them since this is
> not a functional change (it just makes a cast explicit)?

That's what patch series are for. You make a series of changes where one is
dependent on the other. But each commit should only do one thing. If you
need to fix something to do your one thing, that fix should be a separate
patch, but make it part of a series.

Just a "cast explicit" that's in generic code should be a separate change
with a change log explaining why it is needed, and why it didn't work
without it. Single commits can be just "no functional change".

> 
> >>> -#ifdef CONFIG_TRACEPOINTS
> >>> +#if defined(CONFIG_TRACEPOINTS) && !defined(DISABLE_TRACEPOINTS)    
> >>
> >> Why this global change?  
> > 
> > Yeah, DISABLE_TRACEPOINTS does not currently exist. If this is to be a
> > new way to disable TRACEPOINTS it needs a separate patch and be able to
> > disable tracepoints everywhere (maybe include/trace/*.h files also need
> > to be modified?), and also be documented somewhere in Documentation/trace.  
> 
> It's only needed to suppress compiler errors when building arch/x86/boot/*
> and arch/x86/realmode/*.  Those source files include various x86 headers
> such as <asm/msr.h> and <asm/shared/io.h>.  Those x86 headers include
> <linux/tracepoint-defs.h> which references static_key_false() in
> <linux/jump_label.h>.  DISABLE_TRACEPOINTS eliminates that reference and
> hence suppresses the compiler error.
> 
> I didn't intend for this macro to be used by developers adding new
> tracepoints so I didn't document it as such.  As far as creating a
> separate patch: again this is a requirement for this patch and it doesn't
> cause any functional changes so can't we combine them?

This is touching generic code, and as such, it *will* be used by others. If
generic code needs something like "DISABLE_TRACEPOINTS" for your use case,
it may be needed for someone else's.

For the same reason above, it really needs to be a separate patch with a
change log explaining why it is needed.

If this should only be used by code that is not part of the kernel proper,
then we should probably call it something else.

#ifdef PRE_LINUX_CODE  ?

Or something that more explicitly states that this is included in code
that's not part of the Linux proper. By saying "DISABLE_TRACEPOINTS" it
will look like this is the way to disable it for other use cases. Maybe we
want that, or perhaps we don't.

Either case, it should still be separate with a detailed explanation, for
when another developer sees this code, a git blame will give all the
explanation necessary for why it exists.

-- Steve
