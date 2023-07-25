Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C967B76277E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 01:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbjGYXpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 19:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjGYXpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 19:45:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEDB212D;
        Tue, 25 Jul 2023 16:45:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B69276192A;
        Tue, 25 Jul 2023 23:45:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE682C433C7;
        Tue, 25 Jul 2023 23:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690328749;
        bh=zcTWdwnMVLYnBape8/coAf02HP0DFcemq9xCnn63sKA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XXjgLjnRKfEjc18RIYBSVFtKNV+I/IpnCQAMVxH++VqrM71b2G3izXMMLDAi/uXoS
         ijMKvIFC58uf7/qQZ2DWoQtVgjIQUOVAX5aDtA019/tERLn+KmAhp6AQ1wpq38e1o7
         0AXwZ5TEEUWIugL9AewtGpjxZhEPa0e4uNDdcj64G7XbzJQTJXqeBbpmUxXZey4una
         ji1kw5XbiHl0uEiQmqdJeTH/rhb+POvWsyEMaR2k3zbZBdjmQrZ4GABwG5DvsTvhC7
         u2s4VQV8b41nDPdOmdpL5gPlYmxD/xLLpmBTYQDxlCfZde65Dm3e2tjhPPlFaZLAWg
         C8Zn46DnR7/+Q==
Date:   Wed, 26 Jul 2023 08:45:44 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2 0/9] tracing: Improbe BTF support on probe events
Message-Id: <20230726084544.6f5ef0bb6ff63173c1a97367@kernel.org>
In-Reply-To: <1f26e0a2-413c-f176-3cac-2947b20eb6a4@oracle.com>
References: <168960739768.34107.15145201749042174448.stgit@devnote2>
        <e002b414-0e12-0ee8-08a9-2a2b2f21c7bc@oracle.com>
        <20230720010144.a2a70b1db0f636401e96909a@kernel.org>
        <1f26e0a2-413c-f176-3cac-2947b20eb6a4@oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jul 2023 22:50:18 +0100
Alan Maguire <alan.maguire@oracle.com> wrote:


> >> One thing we should probably figure out is a common approach to handling
> >> ambiguous static functions that will work across ftrace and BPF.  A few
> >> edge cases that are worth figuring out:
> >>
> >> 1. a static function with the same name exists in multiple modules,
> >> either with different or identical function signatures
> >> 2. a static function has .isra.0 and other gcc suffixes applied to
> >> static functions during optimization
> >>
> >> As Alexei mentioned, we're still working on 1, so it would be good
> >> to figure out a naming scheme that works well in both ftrace and BPF
> >> contexts. There are a few hundred of these ambiguous functions. My
> >> reading of the fprobe docs seems to suggest that there is no mechanism
> >> to specify a specific module for a given symbol (as in ftrace filters),
> >> is that right?
> > 
> > Yes, it doesn't have module specificaiton at this moment. I'll considering
> > to fix this. BTW, for the same-name functions, we are discussing another
> > approach. We also need to sync this with BTF. 
> > 
> > https://lore.kernel.org/all/20230714150326.1152359-1-alessandro.carminati@gmail.com/
> > 
> >>
> >> Jiri led a session on this topic at LSF/MM/BPF ; perhaps we should
> >> carve out some time at Plumbers to discuss this?
> > 
> > Yeah, good idea.
> > 
> >>
> >> With respect to 2, pahole v1.25 will generate representations for these
> >> "."-suffixed functions in BTF via --btf_gen_optimized [1]. (BTF
> >> representation is skipped if the optimizations impact on the registers
> >> used for function arguments; if these don't match calling conventions
> >> due to optimized-out params, we don't represent the function in BTF,
> >> as the tracing expectations are violated).
> > 
> > Correct. But can't we know which argument is skipped by the optimization
> > from the DWARF? At least the function parameters will be changed.
> >
> 
> Yep; we use the expected registers to spot cases where something
> has been optimized out.

I guess DWARF knows which register is optimized out and then BTF also
knows that?
Let me update my pahole too.

> >> However the BTF function name - in line with DWARF representation -
> >> will not have the .isra suffix. So the thing to bear in mind is if
> >> you use the function name with suffix as the fprobe function name,
> >> a BTF lookup of that exact ("foo.isra.0") name will not find anything,
> >> while a lookup of "foo" will succeed. I'll add some specifics in your
> >> patch doing the lookups, but just wanted to highlight the issue at
> >> the top-level.
> > 
> > So, what about adding an index sorted list of the address and BTF entry
> > index as an expansion of the BTF? It allowed us to easily map the suffixed
> > symbol address (we can get it from kallsyms) to BTF quickly.
> > So the module will have
> > 
> > [BTF data][array length][BTF index array]
> > 
> > Index array member will be like this.
> > 
> > struct btf_index {
> > 	u32	offset;	// offset from the start text
> > 	u32	id:		// BTF type id
> > };
> > 
> > We can do binary search the function type id from the symbol address.
> > 
> 
> Yeah, I wonder if a representation that bridged between kallsyms and BTF
> might be valuable? I don't _think_ it's as much of an issue for your
> case though since you only need to do the BTF lookup once on fprobe
> setup, right? Thanks!

Yes, but I'm thinking fprobe to support some sort of 'symbol+offset' format
to specify one of the "same-name" symbols. In that case, it is important to
identify which address the BTF type is pointed.

Thank you!

> 
> Alan
> 
> 
> 
> > Thank you,
> > 
> >>
> >> Thanks!
> >>
> >> Alan
> >>
> >> [1]
> >> https://lore.kernel.org/bpf/1675790102-23037-1-git-send-email-alan.maguire@oracle.com/
> >>
> >>> Selftest test case [8/9] and document [9/9] are also updated according to
> >>> those changes.
> >>>
> >>> This series can be applied on top of "v6.5-rc2" kernel.
> >>>
> >>> You can also get this series from:
> >>>
> >>> git://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git topic/fprobe-event-ext
> >>>
> >>>
> >>> Thank you,
> >>>
> >>> ---
> >>>
> >>> Masami Hiramatsu (Google) (9):
> >>>       tracing/probes: Fix to add NULL check for BTF APIs
> >>>       bpf/btf: tracing: Move finding func-proto API and getting func-param API to BTF
> >>>       bpf/btf: Add a function to search a member of a struct/union
> >>>       tracing/probes: Support BTF based data structure field access
> >>>       tracing/probes: Support BTF field access from $retval
> >>>       tracing/probes: Add string type check with BTF
> >>>       tracing/fprobe-event: Assume fprobe is a return event by $retval
> >>>       selftests/ftrace: Add BTF fields access testcases
> >>>       Documentation: tracing: Update fprobe event example with BTF field
> >>>
> >>>
> >>>  Documentation/trace/fprobetrace.rst                |   50 ++
> >>>  include/linux/btf.h                                |    7 
> >>>  kernel/bpf/btf.c                                   |   83 ++++
> >>>  kernel/trace/trace_fprobe.c                        |   58 ++-
> >>>  kernel/trace/trace_probe.c                         |  402 +++++++++++++++-----
> >>>  kernel/trace/trace_probe.h                         |   12 +
> >>>  .../ftrace/test.d/dynevent/add_remove_btfarg.tc    |   11 +
> >>>  .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |    6 
> >>>  8 files changed, 503 insertions(+), 126 deletions(-)
> >>>
> >>> --
> >>> Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >>>
> > 
> > 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
