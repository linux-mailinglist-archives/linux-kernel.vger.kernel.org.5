Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D48E776312
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbjHIOwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjHIOwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:52:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE371FF5;
        Wed,  9 Aug 2023 07:52:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C85FB63CA6;
        Wed,  9 Aug 2023 14:52:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA84C433C8;
        Wed,  9 Aug 2023 14:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691592752;
        bh=di6NBnwSgy7sy24SlTR04GfQ8U9w41UQmbmsgl8CO9w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BLSLUpc6Gst0cnZcdo/R85Y77iobKXbzNgjcvhNyo5OwbewuMqQNlCrR3HuuNf5N8
         xFZNTpUlqfLpVYRJPoenB9Mx12RSMfJ8XEXCbRmkA7AbTDAtdGBJgvKCRoV0TQcvJN
         PpUxwl7w7E5qzbpmSybglU9uEBGWH90tBT9PB/CyHfn1764Go43D7uIWjACtquukUQ
         VzZNfKWZQouQZxejpPC4qBzJltQx0qfKQuPuHTQebR/Nxz7yr3C1lsy5XYTqdla0fG
         RKUcXxnZA6MMSaKV35vMocgrHv4Li3ew7lf/frR7Lajf60nUA2sSA3Euh+t/EYG6Xw
         Ig+CNghJtGYuA==
Date:   Wed, 9 Aug 2023 23:52:26 +0900
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
Subject: Re: [RFC PATCH v2 5/6] ftrace: Add ftrace_partial_regs() for
 converting ftrace_regs to pt_regs
Message-Id: <20230809235226.92ca501403a1e7ad533b869d@kernel.org>
In-Reply-To: <CABRcYmLFwSrfsod6y8-K1memLUZiJeb2so6pD4XaFUpwbLD9AQ@mail.gmail.com>
References: <169139090386.324433.6412259486776991296.stgit@devnote2>
        <169139096244.324433.7237290521765120297.stgit@devnote2>
        <CABRcYmLFwSrfsod6y8-K1memLUZiJeb2so6pD4XaFUpwbLD9AQ@mail.gmail.com>
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

On Wed, 9 Aug 2023 12:31:27 +0200
Florent Revest <revest@chromium.org> wrote:

> On Mon, Aug 7, 2023 at 8:49 AM Masami Hiramatsu (Google)
> <mhiramat@kernel.org> wrote:
> >
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >
> > Add ftrace_partial_regs() which converts the ftrace_regas to pt_regs.
> 
> ftrace_regs*

Oops, thanks.

> 
> > If the architecture defines its own ftrace_regs, this copies partial
> > registers to pt_regs and returns it. If not, ftrace_regs is the same as
> > pt_regs and ftrace_partial_regs() will return ftrace_regs::regs.
> >
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  arch/arm64/include/asm/ftrace.h |   11 +++++++++++
> >  include/linux/ftrace.h          |   11 +++++++++++
> >  2 files changed, 22 insertions(+)
> >
> > diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> > index ab158196480c..b108cd6718cf 100644
> > --- a/arch/arm64/include/asm/ftrace.h
> > +++ b/arch/arm64/include/asm/ftrace.h
> > @@ -137,6 +137,17 @@ ftrace_override_function_with_return(struct ftrace_regs *fregs)
> >         fregs->pc = fregs->lr;
> >  }
> >
> > +static __always_inline struct pt_regs *
> > +ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
> > +{
> > +       memcpy(regs->regs, fregs->regs, sizeof(u64) * 10);
> 
> Are you intentionally copying that tenth value (fregs.direct_tramp)
> into pt_regs.regs[9] ? This seems wrong and it looks like it will bite
> us back one day. Isn't it one of these cases where we can simply use
> sizeof(fregs->regs) ?

Ah, sorry, it was my mistake. It should be "sizeof(u64) * 9".
I would like to know how can I handle the 'direct_tramp' thing?
Can I just ignore it?

> 
> > +       regs->sp = fregs->sp;
> > +       regs->pc = fregs->pc;
> > +       regs->x[29] = fregs->fp;
> > +       regs->x[30] = fregs->lr;
> > +       return regs;
> > +}
> > +
> >  int ftrace_regs_query_register_offset(const char *name);
> >
> >  int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
> > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > index 3fb94a1a2461..7f45654441b7 100644
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> > @@ -155,6 +155,17 @@ static __always_inline struct pt_regs *ftrace_get_regs(struct ftrace_regs *fregs
> >         return arch_ftrace_get_regs(fregs);
> >  }
> >
> > +#if !defined(CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS) || \
> > +       defined(CONFIG_HAVE_PT_REGS_COMPAT_FTRACE_REGS)
> > +
> > +static __always_inline struct pt_regs *
> > +ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
> > +{
> > +       return arch_ftrace_get_regs((struct ftrace_regs *)fregs);
> > +}
> 
> I don't think this works. Suppose you are on x86, WITH_ARGS, and with
> HAVE_PT_REGS_COMPAT_FTRACE_REGS. If you register to ftrace without
> FTRACE_OPS_FL_SAVE_REGS you will receive a ftrace_regs from the light
> ftrace pre-trampoline that has a CS register equal to 0 and
> arch_ftrace_get_regs will return NULL here, which should never happen.

Yes, Jiri also pointed it. So I simply made it (also remove 'const' from fregs)

return &fregs->regs;

Thank you,

> 
> Have you tested your series without registering as FTRACE_OPS_FL_SAVE_REGS ?

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
