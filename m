Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815F3776231
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbjHIOQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbjHIOQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:16:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC19E2110;
        Wed,  9 Aug 2023 07:16:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82BBF63476;
        Wed,  9 Aug 2023 14:16:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982C1C433C9;
        Wed,  9 Aug 2023 14:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691590572;
        bh=1SsVUXtWZgOegRFQu/GbBOH3DZTNW23JsvaY2VEYgBY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U1CjP3mWibzJWHlC+0WnkiYzptEzDbUEGoUKGfIq13sTvP5wK9jycbLETah8A4uHz
         iTlb/R0Qtz6uGeKJE3Au1LooZ601DpkjB+604scSfx55ovfJRN5gd43KUzLXG/WnLk
         ABdowwihO3Dh788RrYv5zy7hEb0U8ET8wH64r8ZYq0RleqaQEopIAxOn+F+swadv4S
         8BbhiYTOTnHQGDY18ffsYNZaIWrBXUlpNkzXbVYsa1ngNVVwY6fq5JgkQWK0Ex8iHZ
         UVQyWpG55QO1akmjijvJDSzzRZ8bzMzlNK0Ntp6hZNmi90F74cChRsgswa2CANnr42
         hWYULQmdXtlFQ==
Date:   Wed, 9 Aug 2023 23:16:07 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Florent Revest <revest@chromium.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alan Maguire <alan.maguire@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH v2 2/6] tracing: Expose ftrace_regs regardless of
 CONFIG_FUNCTION_TRACER
Message-Id: <20230809231607.0c5c75e7c3b69fcc96d82cb4@kernel.org>
In-Reply-To: <CABRcYmJpA7tWk7pNxMy-44aoT9fFByQY3kGiEfKDbOe9WPkmNg@mail.gmail.com>
References: <169139090386.324433.6412259486776991296.stgit@devnote2>
        <169139092722.324433.16681957760325391475.stgit@devnote2>
        <CABRcYmJpA7tWk7pNxMy-44aoT9fFByQY3kGiEfKDbOe9WPkmNg@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Aug 2023 12:29:13 +0200
Florent Revest <revest@chromium.org> wrote:

> On Mon, Aug 7, 2023 at 8:48 AM Masami Hiramatsu (Google)
> <mhiramat@kernel.org> wrote:
> > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > index ce156c7704ee..3fb94a1a2461 100644
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> > @@ -112,11 +112,11 @@ static inline int ftrace_mod_get_kallsym(unsigned int symnum, unsigned long *val
> >  }
> >  #endif
> >
> > -#ifdef CONFIG_FUNCTION_TRACER
> > -
> > -extern int ftrace_enabled;
> > -
> > -#ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
> > +/*
> > + * If the architecture doesn't support FTRACE_WITH_ARGS or disable function
> 
> nit: disables*

Thanks!

> 
> > + * tracer, define the default(pt_regs compatible) ftrace_regs.
> > + */
> > +#if !defined(CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS) || !defined(CONFIG_FUNCTION_TRACER)
> 
> I wonder if we should make things simpler with:
> 
> #if defined(HAVE_PT_REGS_COMPAT_FTRACE_REGS) || !defined(CONFIG_FUNCTION_TRACER)
> 
> And remove the ftrace_regs definitions that are copy-pastes of this
> block in arch specific headers. Then we can enforce in a single point
> that HAVE_PT_REGS_COMPAT_FTRACE_REGS holds.

Here, the "HAVE_PT_REGS_COMPAT_FTRACE_REGS" does not mean that the
ftrace_regs is completely compatible with pt_regs, but on the memory
it wraps struct pt_regs (thus we can just cast the type).

- CONFIG_DYNAMIC_FTRACE_WITH_REGS
  ftrace_regs is completely compatible with pt_regs

- CONFIG_DYNAMIC_FTRACE_WITH_ARGS
  |   ftrace_regs may not compatible with pt_regs
  |
  +- CONFIG_HAVE_PT_REGS_COMPAT_FTRACE_REGS
     but on memory image, ftrace_regs includes pt_regs.

Thank you,

> 
> Maybe that's a question for Steven ?


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
