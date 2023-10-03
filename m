Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8267B696C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 14:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjJCMus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 08:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjJCMur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 08:50:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0172BB8;
        Tue,  3 Oct 2023 05:50:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C5CC433C8;
        Tue,  3 Oct 2023 12:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696337442;
        bh=j+yGGSzRCSvGI/VJZ5tDD+R9hNuauFXWos6gg7ksK9g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MJ/oN8aJ2bpGvvD6dW8Tl/VepfemAorPEeTPmXgk+EErVwRslYPEqRtn2CFCG+9bC
         Kdham49WtkR5Afs9wCaVRtcEPN52xWOxV74AR2FqZFbtQV1GB1QabIZuJF076ivub1
         KcGbEYaDsOVuqk9rEUlR8EwP7tSHh4zrGN0UySKk=
Date:   Tue, 3 Oct 2023 14:50:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dan Raymond <raymod2@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-serial <linux-serial@vger.kernel.org>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, peterz@infradead.org,
        andriy.shevchenko@linux.intel.com
Subject: Re: [PATCH v3] arch/x86: port I/O tracing on x86
Message-ID: <2023100344-dart-jailbreak-c371@gregkh>
References: <b8eae358-a3b3-fd68-82f1-b2c53534b922@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8eae358-a3b3-fd68-82f1-b2c53534b922@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 01:15:41PM -0600, Dan Raymond wrote:
> Add support for port I/O tracing on x86.  Memory mapped I/O tracing is
> available on x86 via CONFIG_MMIOTRACE but that relies on page faults
> so it doesn't work with port I/O.  This feature uses tracepoints in a
> similar manner as CONFIG_TRACE_MMIO_ACCESS.
> 
> Signed-off-by: Dan Raymond <raymod2@gmail.com>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> V1 -> V2:
>   - create header file for prototypes to silence new compiler warning
>   - reduce CPU overhead to 2 instructions (no branching) when tracing disabled
>   - fix imprecise IP logging by retrieving the IP off the stack instead of using
>     compile time labels
> 
> V2 -> V3:
>   - restore missing semicolon
> 
>  arch/x86/include/asm/shared/io.h | 25 ++++++++++++++++
>  arch/x86/lib/Makefile            |  1 +
>  arch/x86/lib/trace_portio.c      | 21 ++++++++++++++
>  include/linux/trace_portio.h     |  6 ++++
>  include/trace/events/portio.h    | 49 ++++++++++++++++++++++++++++++++
>  5 files changed, 102 insertions(+)
>  create mode 100644 arch/x86/lib/trace_portio.c
>  create mode 100644 include/linux/trace_portio.h
>  create mode 100644 include/trace/events/portio.h
> 
> diff --git a/arch/x86/include/asm/shared/io.h b/arch/x86/include/asm/shared/io.h
> index c0ef921c0586..9e5dce1cb62d 100644
> --- a/arch/x86/include/asm/shared/io.h
> +++ b/arch/x86/include/asm/shared/io.h
> @@ -2,13 +2,36 @@
>  #ifndef _ASM_X86_SHARED_IO_H
>  #define _ASM_X86_SHARED_IO_H
>  
> +#include <linux/trace_portio.h>
>  #include <linux/types.h>
>  
> +/*
> + * We don't want the tracing logic included in the early boot modules (under
> + * arch/x86/boot) so we check for their include guards here.  If we don't do
> + * this we will get compiler errors.  These checks are not present in
> + * arch/x86/include/asm/msr.h which contains similar tracing logic.  That is
> + * possible only because none of the msr inline functions are instantiated in
> + * the early boot modules.  If that changes this issue will need to be addressed
> + * there as well.  Therefore it might be better to handle this centrally in
> + * tracepoint-defs.h.
> + */
> +
> +#if defined(CONFIG_TRACEPOINTS) && !defined(BOOT_COMPRESSED_MISC_H) && !defined(BOOT_BOOT_H)

I see what you are doing here in trying to see if a .h file has been
included already, but now you are making an assumption on both the .h
file ordering, and the #ifdef guard for those .h files, which are
something that we almost never remember or even consider when dealing
with .h files files.


> +#include <linux/tracepoint-defs.h>
> +DECLARE_TRACEPOINT(portio_write);
> +DECLARE_TRACEPOINT(portio_read);
> +#define _tracepoint_enabled(tracepoint) tracepoint_enabled(tracepoint)
> +#else
> +#define _tracepoint_enabled(tracepoint) false
> +#endif
> +
>  #define BUILDIO(bwl, bw, type)						\
>  static inline void __out##bwl(type value, u16 port)			\
>  {									\
>  	asm volatile("out" #bwl " %" #bw "0, %w1"			\
>  		     : : "a"(value), "Nd"(port));			\
> +	if (_tracepoint_enabled(portio_write))				\
> +		do_trace_portio_write(value, port, #bwl[0]);		\
>  }									\

Who wants/needs port tracing these days?  What types of systems still
rely on that for their primary form of I/O other than some old-school
serial ports?

The MMIO tracing was added because there are crazy out-of-tree SoC
devices out there that "insisted" that they need to hook into the mmio
access path, so they added traceing there under the auspicious of trying
to log all mmio accesses so that they could then override the access
path in the tracehook to do who-knows-what other things.  Hopefully you
are not wanting to do the same thing here as well?

And have you addressed all of Peter's previous review comments?



>  									\
>  static inline type __in##bwl(u16 port)					\
> @@ -16,6 +39,8 @@ static inline type __in##bwl(u16 port)					\
>  	type value;							\
>  	asm volatile("in" #bwl " %w1, %" #bw "0"			\
>  		     : "=a"(value) : "Nd"(port));			\
> +	if (_tracepoint_enabled(portio_read))				\
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

So this is always enabled?  No separate config option?  Why not?

>  lib-y := delay.o misc.o cmdline.o cpu.o
>  lib-y += usercopy_$(BITS).o usercopy.o getuser.o putuser.o
> diff --git a/arch/x86/lib/trace_portio.c b/arch/x86/lib/trace_portio.c
> new file mode 100644
> index 000000000000..c048dffcfe05
> --- /dev/null
> +++ b/arch/x86/lib/trace_portio.c
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include <linux/instruction_pointer.h>
> +#include <linux/trace_portio.h>
> +
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/portio.h>
> +
> +void do_trace_portio_read(u32 value, u16 port, char width)
> +{
> +	trace_portio_read(value, port, width, _RET_IP_);
> +}
> +EXPORT_SYMBOL_GPL(do_trace_portio_read);
> +EXPORT_TRACEPOINT_SYMBOL_GPL(portio_read);
> +
> +void do_trace_portio_write(u32 value, u16 port, char width)
> +{
> +	trace_portio_write(value, port, width, _RET_IP_);
> +}
> +EXPORT_SYMBOL_GPL(do_trace_portio_write);
> +EXPORT_TRACEPOINT_SYMBOL_GPL(portio_write);
> diff --git a/include/linux/trace_portio.h b/include/linux/trace_portio.h
> new file mode 100644
> index 000000000000..013418d3d2ae
> --- /dev/null
> +++ b/include/linux/trace_portio.h
> @@ -0,0 +1,6 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */

Why "+"?  (I have to ask).

> +
> +#include <linux/types.h>
> +
> +extern void do_trace_portio_read(u32 value, u16 port, char width);
> +extern void do_trace_portio_write(u32 value, u16 port, char width);
> diff --git a/include/trace/events/portio.h b/include/trace/events/portio.h
> new file mode 100644
> index 000000000000..3591a75a475e
> --- /dev/null
> +++ b/include/trace/events/portio.h
> @@ -0,0 +1,49 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */

This is -only, which is fine, but your patch doesn't seem to be uniform
here for new files being added in the same patch, right?  So documenting
this somewhere (i.e. in the changelog), is essential.

> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM portio
> +
> +#if !defined(_TRACE_PORTIO_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_PORTIO_H
> +
> +#include <linux/tracepoint.h>
> +
> +DECLARE_EVENT_CLASS(portio_class,
> +	TP_PROTO(u32 value, u16 port, char width, long ip_addr),

Memory locations are stored in "unsigned long" not "long", right?

> +
> +	TP_ARGS(value, port, width, ip_addr),
> +
> +	TP_STRUCT__entry(
> +		__field(u32, value)
> +		__field(u16, port)
> +		__field(char, width)
> +		__field(long, ip_addr)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->value = value;
> +		__entry->port = port;
> +		__entry->width = width;
> +		__entry->ip_addr = ip_addr;
> +	),
> +
> +	TP_printk("port=0x%04x value=0x%0*x %pS",
> +		__entry->port,
> +		__entry->width == 'b' ? 2 :
> +		__entry->width == 'w' ? 4 : 8,
> +		__entry->value, (void *)__entry->ip_addr)

Logging kernel memory locations, why?  Where is this format documented?

thanks,

greg k-h
