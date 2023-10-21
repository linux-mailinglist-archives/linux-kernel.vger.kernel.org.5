Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE987D1E18
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 18:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjJUQAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 12:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjJUQAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 12:00:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75094188;
        Sat, 21 Oct 2023 09:00:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E2C2C433C7;
        Sat, 21 Oct 2023 16:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697904041;
        bh=u7QWjefvvhtj9JYfMJo3vYUfs5HQpQfQAshJw2ij5Vw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wdVEBmLa1kPbIQ5smiCijdD7+3yZv3hEd/PfixRKYQudqL3ib6A8Z0s3tUi9oQ1Dt
         MhNqrs7XN1SUhrVKleq49C3OTp/LTLC+6b5cdi/QBYPZ+l0w/qXMrKAGmfwlP9qcU+
         S0ZXkdW88DF/GxeV+h3/8qAY3ZiuuyBgDAux095c=
Date:   Sat, 21 Oct 2023 18:00:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dan Raymond <raymod2@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-serial <linux-serial@vger.kernel.org>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, peterz@infradead.org,
        andriy.shevchenko@linux.intel.com, quic_saipraka@quicinc.com,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v5] arch/x86: port I/O tracing on x86
Message-ID: <2023102122-diabetes-trend-57d0@gregkh>
References: <b8eae358-a3b3-fd68-82f1-b2c53534b922@gmail.com>
 <2023100344-dart-jailbreak-c371@gregkh>
 <94e2b77c-9cc4-534f-e650-06d7e0697f9f@gmail.com>
 <20231004195001.76a57417@gandalf.local.home>
 <80b84be0-a0ad-d1a9-607a-a87c6cf509e0@gmail.com>
 <cc7fba3b-9da2-b9eb-95c8-7336e1cd4449@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc7fba3b-9da2-b9eb-95c8-7336e1cd4449@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2023 at 11:56:53AM -0600, Dan Raymond wrote:
> Add support for port I/O tracing on x86.  Memory mapped I/O tracing is
> available on x86 via CONFIG_MMIOTRACE but that relies on page faults
> so it doesn't work with port I/O.  This feature uses tracepoints in a
> similar manner as CONFIG_TRACE_MMIO_ACCESS.
> 
> Signed-off-by: Dan Raymond <raymod2@gmail.com>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This is now outside of my subsystems to review, sorry.  It's going to
have to go through the x86 tree, so you are going to have to convince
them that this is something that actually matters and is needed by
people, as maintaining it over time is going to add to their workload.

Note, you are keeping tracing from working in a few areas that might not
be good:

> --- a/arch/x86/boot/Makefile
> +++ b/arch/x86/boot/Makefile
> @@ -70,6 +70,7 @@ KBUILD_CFLAGS	:= $(REALMODE_CFLAGS) -D_SETUP
>  KBUILD_AFLAGS	:= $(KBUILD_CFLAGS) -D__ASSEMBLY__
>  KBUILD_CFLAGS	+= $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
>  KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
> +KBUILD_CFLAGS	+= -DDISABLE_TRACEPOINTS
>  GCOV_PROFILE := n
>  UBSAN_SANITIZE := n
>  
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 35ce1a64068b..c368bcc008eb 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -51,6 +51,7 @@ KBUILD_CFLAGS += -D__DISABLE_EXPORTS
>  # Disable relocation relaxation in case the link is not PIE.
>  KBUILD_CFLAGS += $(call as-option,-Wa$(comma)-mrelax-relocations=no)
>  KBUILD_CFLAGS += -include $(srctree)/include/linux/hidden.h
> +KBUILD_CFLAGS += -DDISABLE_TRACEPOINTS
>  
>  # sev.c indirectly inludes inat-table.h which is generated during
>  # compilation and stored in $(objtree). Add the directory to the includes so

Now I know why you did that for this patch (i.e. so early boot doesn't
get the printk mess), but that kind of defeats the use of tracepoints at
all for this part of the kernel, is that ok?  Are any existing
tracepoints now removed?

Some other random comments:

> --- a/arch/x86/include/asm/cmpxchg_32.h
> +++ b/arch/x86/include/asm/cmpxchg_32.h
> @@ -37,13 +37,16 @@ static inline void set_64bit(volatile u64 *ptr, u64 value)
>  
>  #ifdef CONFIG_X86_CMPXCHG64
>  #define arch_cmpxchg64(ptr, o, n)					\
> -	((__typeof__(*(ptr)))__cmpxchg64((ptr), (unsigned long long)(o), \
> +	((__typeof__(*(ptr)))__cmpxchg64((unsigned long long *)(ptr),	\
> +					 (unsigned long long)(o),	\
>  					 (unsigned long long)(n)))
> -#define arch_cmpxchg64_local(ptr, o, n)					\
> -	((__typeof__(*(ptr)))__cmpxchg64_local((ptr), (unsigned long long)(o), \
> +#define arch_cmpxchg64_local(ptr, o, n)						\
> +	((__typeof__(*(ptr)))__cmpxchg64_local((unsigned long long *)(ptr),	\
> +					       (unsigned long long)(o),		\
>  					       (unsigned long long)(n)))
> -#define arch_try_cmpxchg64(ptr, po, n)					\
> -	__try_cmpxchg64((ptr), (unsigned long long *)(po), \
> +#define arch_try_cmpxchg64(ptr, po, n)			\
> +	__try_cmpxchg64((unsigned long long *)(ptr),	\
> +			(unsigned long long *)(po),	\
>  			(unsigned long long)(n))
>  #endif
>  

Why are these needed to be changed at all?  What code changes with it,
and it's not mentioned in the changelog, so why is it required?

> diff --git a/arch/x86/include/asm/shared/io.h b/arch/x86/include/asm/shared/io.h
> index c0ef921c0586..82664956ce41 100644
> --- a/arch/x86/include/asm/shared/io.h
> +++ b/arch/x86/include/asm/shared/io.h
> @@ -2,13 +2,20 @@
>  #ifndef _ASM_X86_SHARED_IO_H
>  #define _ASM_X86_SHARED_IO_H
>  
> +#include <linux/tracepoint-defs.h>
> +#include <linux/trace_portio.h>
>  #include <linux/types.h>
>  
> +DECLARE_TRACEPOINT(portio_write);
> +DECLARE_TRACEPOINT(portio_read);
> +
>  #define BUILDIO(bwl, bw, type)						\
>  static inline void __out##bwl(type value, u16 port)			\
>  {									\
>  	asm volatile("out" #bwl " %" #bw "0, %w1"			\
>  		     : : "a"(value), "Nd"(port));			\
> +	if (tracepoint_enabled(portio_write))				\
> +		do_trace_portio_write(value, port, #bwl[0]);		\

Your level of indirection here seems deep, why doesn't
do_trace_portio_write() belong in a .h file here and do the
tracepoint_enabled() check?

Is this a by-product of the tracing macros that require this deeper
callchain to happen?

>  }									\
>  									\
>  static inline type __in##bwl(u16 port)					\
> @@ -16,6 +23,8 @@ static inline type __in##bwl(u16 port)					\
>  	type value;							\
>  	asm volatile("in" #bwl " %w1, %" #bw "0"			\
>  		     : "=a"(value) : "Nd"(port));			\
> +	if (tracepoint_enabled(portio_read))				\
> +		do_trace_portio_read(value, port, #bwl[0]);		\
>  	return value;							\
>  }
>  
> diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
> index f76747862bd2..254f223c025d 100644
> --- a/arch/x86/lib/Makefile
> +++ b/arch/x86/lib/Makefile
> @@ -40,6 +40,7 @@ $(obj)/inat.o: $(obj)/inat-tables.c
>  clean-files := inat-tables.c
>  
>  obj-$(CONFIG_SMP) += msr-smp.o cache-smp.o
> +obj-$(CONFIG_TRACEPOINTS) += trace_portio.o

So you are always enabling these if any CONFIG_TRACEPOINTS is enabled?
That seems brave.

> --- a/arch/x86/realmode/rm/Makefile
> +++ b/arch/x86/realmode/rm/Makefile
> @@ -75,5 +75,6 @@ KBUILD_CFLAGS	:= $(REALMODE_CFLAGS) -D_SETUP -D_WAKEUP \
>  		   -I$(srctree)/arch/x86/boot
>  KBUILD_AFLAGS	:= $(KBUILD_CFLAGS) -D__ASSEMBLY__
>  KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
> +KBUILD_CFLAGS	+= -DDISABLE_TRACEPOINTS

Again, you prevent any tracepoints from this code chunk, is that going
to be ok going forward?

>  GCOV_PROFILE := n
>  UBSAN_SANITIZE := n
> diff --git a/include/linux/trace_portio.h b/include/linux/trace_portio.h
> new file mode 100644
> index 000000000000..2324d62e6c9e
> --- /dev/null
> +++ b/include/linux/trace_portio.h
> @@ -0,0 +1,6 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#include <linux/types.h>
> +
> +extern void do_trace_portio_read(u32 value, u16 port, char width);
> +extern void do_trace_portio_write(u32 value, u16 port, char width);

Nit, "extern" isn't needed in .h files anymore.  Not a big deal, just
for other work you do going forward.

> diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoint-defs.h
> index e7c2276be33e..bfe70e17b2aa 100644
> --- a/include/linux/tracepoint-defs.h
> +++ b/include/linux/tracepoint-defs.h
> @@ -80,7 +80,7 @@ struct bpf_raw_event_map {
>  #define DECLARE_TRACEPOINT(tp) \
>  	extern struct tracepoint __tracepoint_##tp
>  
> -#ifdef CONFIG_TRACEPOINTS
> +#if defined(CONFIG_TRACEPOINTS) && !defined(DISABLE_TRACEPOINTS)

Why this global change?

Anyway, it's up to the x86 maintainers now, good luck!

But personally, I don't see the real need for this at all.  It's a
debugging thing for what exactly?  Who needs this?  Who will use it?
When will they use it?  And why?

thanks,

greg k-h
