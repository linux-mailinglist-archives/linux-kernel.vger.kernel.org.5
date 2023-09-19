Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB6B7A6BB4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 21:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbjISToA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 15:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbjISTn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 15:43:59 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4EEEC
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 12:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GUGhcqBPQQtT/m+P4vnc8VtVAbKOjKnB5nSOxes9dp8=; b=OSpQdRvJyfmaggQxQMKEusxaxh
        PN0aAsmoIHmc+FaFOcBpRu3dJMjLYsrb9NIyr256qw+UVuSO4UmvpyK2c5Hc/Ug0BgCg7hOI2V/vf
        FA8qlQvb6xcOKkZfGnl0ineHrFTexea6ydTRbtG4LlO3JMGwhzTHu1K/tKEAzogP3dPsPyJGVvuzS
        lpHAhkrFfHcEgSQHWGDf8x0jtiEakTtM+vFf45jP6TKmF9QWPN4BaSWGZL+snLtIWqe3blmPLFCgO
        a54SXPYDzET/GDonBHwqyY9xLfXekt0tlY5q+nVZxRBqt07yaNssfJ7GIddfpZMUFS5re554As3Z6
        u5JpjUtw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qigdE-00DqxM-0Z;
        Tue, 19 Sep 2023 19:43:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4793C300585; Tue, 19 Sep 2023 21:43:37 +0200 (CEST)
Date:   Tue, 19 Sep 2023 21:43:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dan Raymond <draymond@foxvalley.net>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com
Subject: Re: [PATCH v1] arch/x86: port I/O tracing on x86
Message-ID: <20230919194337.GC424@noisy.programming.kicks-ass.net>
References: <14c27df7-12a3-e432-a741-17672185c092@foxvalley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14c27df7-12a3-e432-a741-17672185c092@foxvalley.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 11:55:10AM -0600, Dan Raymond wrote:
> Add support for port I/O tracing on x86.  Memory mapped I/O tracing is
> available on x86 via CONFIG_MMIOTRACE but that relies on page faults
> so it doesn't work with port I/O.  This feature uses tracepoints in a
> similar manner as CONFIG_TRACE_MMIO_ACCESS.
> 
> Signed-off-by: Dan Raymond <draymond@foxvalley.net>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/x86/include/asm/shared/io.h | 11 +++++++
>  arch/x86/lib/Makefile            |  1 +
>  arch/x86/lib/trace_portio.c      | 18 ++++++++++++
>  include/trace/events/portio.h    | 49 ++++++++++++++++++++++++++++++++
>  4 files changed, 79 insertions(+)
>  create mode 100644 arch/x86/lib/trace_portio.c
>  create mode 100644 include/trace/events/portio.h
> 
> diff --git a/arch/x86/include/asm/shared/io.h b/arch/x86/include/asm/shared/io.h
> index c0ef921c0586..e7ef4212e00b 100644
> --- a/arch/x86/include/asm/shared/io.h
> +++ b/arch/x86/include/asm/shared/io.h
> @@ -2,13 +2,23 @@
>  #ifndef _ASM_X86_SHARED_IO_H
>  #define _ASM_X86_SHARED_IO_H
>  
> +#include <linux/instruction_pointer.h>
>  #include <linux/types.h>
>  
> +#if defined(CONFIG_TRACEPOINTS) && !defined(BOOT_COMPRESSED_MISC_H) && !defined(BOOT_BOOT_H)
> +extern void do_trace_portio_read(u32 value, u16 port, char width, long ip_addr);
> +extern void do_trace_portio_write(u32 value, u16 port, char width, long ip_addr);
> +#else
> +static inline void do_trace_portio_read(u32 value, u16 port, char width, long ip_addr) {}
> +static inline void do_trace_portio_write(u32 value, u16 port, char width, long ip_addr) {}
> +#endif
> +
>  #define BUILDIO(bwl, bw, type)						\
>  static inline void __out##bwl(type value, u16 port)			\
>  {									\
>  	asm volatile("out" #bwl " %" #bw "0, %w1"			\
>  		     : : "a"(value), "Nd"(port));			\
> +	do_trace_portio_write(value, port, #bwl[0], _THIS_IP_);		\
>  }									\
>  									\
>  static inline type __in##bwl(u16 port)					\
> @@ -16,6 +26,7 @@ static inline type __in##bwl(u16 port)					\
>  	type value;							\
>  	asm volatile("in" #bwl " %w1, %" #bw "0"			\
>  		     : "=a"(value) : "Nd"(port));			\
> +	do_trace_portio_read(value, port, #bwl[0], _THIS_IP_);		\
>  	return value;							\
>  }

No, very much no.

This sticks tracing in the very rawest of raw output paths. This means I
can no longer use early_console->write() to print to my
early_serial_console.

That is the one and only fully reliably output path we have. You're not
sticking tracing in it.
