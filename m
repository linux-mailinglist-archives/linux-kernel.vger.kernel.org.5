Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F21379E934
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240903AbjIMN0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240899AbjIMN0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:26:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE87E1BC9;
        Wed, 13 Sep 2023 06:26:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBFCFC433C7;
        Wed, 13 Sep 2023 13:26:27 +0000 (UTC)
Date:   Wed, 13 Sep 2023 09:26:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-trace-kernel@vger.kernel.org, Ajay Kaher <akaher@vmware.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        xen-devel@lists.xenproject.org
Subject: Re: [PATCH 2/3] x86/xen: move paravirt lazy code
Message-ID: <20230913092646.5b087871@gandalf.local.home>
In-Reply-To: <20230913113828.18421-3-jgross@suse.com>
References: <20230913113828.18421-1-jgross@suse.com>
        <20230913113828.18421-3-jgross@suse.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2023 13:38:27 +0200
Juergen Gross <jgross@suse.com> wrote:

> diff --git a/include/trace/events/xen.h b/include/trace/events/xen.h
> index 44a3f565264d..0577f0cdd231 100644
> --- a/include/trace/events/xen.h
> +++ b/include/trace/events/xen.h
> @@ -6,26 +6,26 @@
>  #define _TRACE_XEN_H
>  
>  #include <linux/tracepoint.h>
> -#include <asm/paravirt_types.h>
> +#include <asm/xen/hypervisor.h>
>  #include <asm/xen/trace_types.h>
>  
>  struct multicall_entry;
>  
>  /* Multicalls */
>  DECLARE_EVENT_CLASS(xen_mc__batch,
> -	    TP_PROTO(enum paravirt_lazy_mode mode),
> +	    TP_PROTO(enum xen_lazy_mode mode),
>  	    TP_ARGS(mode),
>  	    TP_STRUCT__entry(
> -		    __field(enum paravirt_lazy_mode, mode)
> +		    __field(enum xen_lazy_mode, mode)
>  		    ),
>  	    TP_fast_assign(__entry->mode = mode),
>  	    TP_printk("start batch LAZY_%s",
> -		      (__entry->mode == PARAVIRT_LAZY_MMU) ? "MMU" :
> -		      (__entry->mode == PARAVIRT_LAZY_CPU) ? "CPU" : "NONE")
> +		      (__entry->mode == XEN_LAZY_MMU) ? "MMU" :
> +		      (__entry->mode == XEN_LAZY_CPU) ? "CPU" : "NONE")

There's helper functions that make the above easier to implement as well as
exports the symbols so that user space can parse this better:

TRACE_DEFINE_ENUM(XEN_LAZY_NONE);
TRACE_DEFINE_ENUM(XEN_LAZY_MMU);
TRACE_DEFINE_ENUM(XEN_LAZY_CPU);

[..]

  	    TP_printk("start batch LAZY_%s",
		      __print_symbolic(mode,
				       { XEN_LAZY_NONE, "NONE" },
				       { XEN_LAZY_MMU,  "MMU   },
				       { XEN_LAZY_CPU,  "CPU"  }))

Then user space parsers that read the raw data can convert these events
into something humans can read.

-- Steve

>  	);
>  #define DEFINE_XEN_MC_BATCH(name)			\
>  	DEFINE_EVENT(xen_mc__batch, name,		\
> -		TP_PROTO(enum paravirt_lazy_mode mode),	\
> +		TP_PROTO(enum xen_lazy_mode mode),	\
>  		     TP_ARGS(mode))
>  
>  DEFINE_XEN_MC_BATCH(xen_mc_batch);
