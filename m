Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E0680002B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 01:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377412AbjLAAZd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Nov 2023 19:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377389AbjLAAZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 19:25:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E62197
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 16:25:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3096DC433C8;
        Fri,  1 Dec 2023 00:25:33 +0000 (UTC)
Date:   Thu, 30 Nov 2023 19:25:54 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     =?UTF-8?B?xYF1a2Fzeg==?= Bartosik <lb@semihalf.com>
Cc:     Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@google.com>,
        Yaniv Tzoreff <yanivt@google.com>,
        Benson Leung <bleung@google.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        upstream@semihalf.com, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, john.ogness@linutronix.de,
        Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH v2 05/15] tracefs: add __get_str_strip_nl - RFC
Message-ID: <20231130192554.10da680c@gandalf.local.home>
In-Reply-To: <20231130234048.157509-6-lb@semihalf.com>
References: <20231130234048.157509-1-lb@semihalf.com>
        <20231130234048.157509-6-lb@semihalf.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  1 Dec 2023 00:40:38 +0100
Łukasz Bartosik <lb@semihalf.com> wrote:

> From: Jim Cromie <jim.cromie@gmail.com>
> 
> This variant of __get_str() removes the trailing newline. It is for
> use by printk/debug-ish events which already have a trailing newline.
> It is here to support:
> 
> https://lore.kernel.org/lkml/
> 20200825153338.17061-1-vincent.whitchurch@axis.com/

Line wrap breakage.

> which taught dyndbg to send pr_debug() msgs to tracefs, via -x/T flag.
> 
> It "reused" the include/trace/events/printk.h console event,
> which does the following:
> 
>        TP_fast_assign(
>                /*
>                 * Each trace entry is printed in a new line.
>                 * If the msg finishes with '\n', cut it off
>                 * to avoid blank lines in the trace.
>                 */
>                if (len > 0 && (msg[len-1] == '\n'))
>                        len -= 1;
> 
>                memcpy(__get_str(s), msg, len);
>                __get_str(s)[len] = 0;
> 	),
> 
> That trim work could be avoided, *if* all pr_debug() callers are
> known to have no '\n' to strip.  While that's not true for *all*
> callsites, it is 99+% true for DRM.debug callsites, and can be made
> true for some subsets of prdbg/dyndbg callsites.
> 
> WANTED: macros to validate that a literal format-str has or doesn't
> have a trailing newline, or to provide or trim trailing newline(s?).
> Should be usable in TP_printk* defns, for use in new event defns.
> 
> Cc: <rostedt@goodmis.org>
> Cc: Vincent Whitchurch <vincent.whitchurch@axis.com>
> Cc: <daniel@ffwll.ch>
> Cc: <pmladek@suse.com>
> Cc: <sergey.senozhatsky@gmail.com>
> Cc: <john.ogness@linutronix.de>
> Cc: Simon Ser <contact@emersion.fr>
> Cc: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> Signed-off-by: Łukasz Bartosik <lb@semihalf.com>
> ---
>  include/trace/stages/stage3_trace_output.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/trace/stages/stage3_trace_output.h b/include/trace/stages/stage3_trace_output.h
> index c1fb1355d309..92a79bd5c0cd 100644
> --- a/include/trace/stages/stage3_trace_output.h
> +++ b/include/trace/stages/stage3_trace_output.h
> @@ -19,6 +19,15 @@
>  #undef __get_str
>  #define __get_str(field) ((char *)__get_dynamic_array(field))
>  
> +#undef __get_str_strip_nl
> +#define __get_str_strip_nl(field)					\
> +	({								\
> +		char *s = __get_str(field);				\
> +		size_t len = strlen(s);					\
> +		if (len && s[len-1] == '\n')				\
> +			s[len-1] = '\0'; s;				\
> +	})

I'd be worried about modifying the string itself as you are doing above.
That's modifying the source which may have unintended consequences.

That said, there's a trace_seq that is available for stage 3 called "p".
You can use that:

#define __get_str_strip_nl(field)					\
	({								\
		char *s = trace_seq_buffer_ptr(p);			\
		size_t len;						\
		trace_seq_printf(p, "%s", __get_str(field));		\
		trace_seq_putc(p, '\0');				\
		len = strlen(s);					\
		if (len && s[len-1] == '\n')				\
			s[len-1] = '\0';				\
		s;							\
	})

-- Steve

> +
>  #undef __get_rel_dynamic_array
>  #define __get_rel_dynamic_array(field)					\
>  		((void *)__entry + 					\

