Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B642A7795DF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236515AbjHKRKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235270AbjHKRKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:10:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34AC26BC;
        Fri, 11 Aug 2023 10:10:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5B49677D5;
        Fri, 11 Aug 2023 17:10:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF09C433C8;
        Fri, 11 Aug 2023 17:10:03 +0000 (UTC)
Date:   Fri, 11 Aug 2023 13:10:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Florent Revest <revest@chromium.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
Subject: Re: [RFC PATCH v2 1/6] fprobe: Use fprobe_regs in fprobe entry
 handler
Message-ID: <20230811131001.7b22a17d@gandalf.local.home>
In-Reply-To: <20230810071330.d41a728f996f76e3243f469e@kernel.org>
References: <169139090386.324433.6412259486776991296.stgit@devnote2>
        <169139091575.324433.13168120610633669432.stgit@devnote2>
        <CABRcYmKRAbOuqNQm5mCwC9NWbtcz1JJDYL_h5x6dK77SJ5FRkA@mail.gmail.com>
        <20230809231011.b125bd68887a5659db59905e@kernel.org>
        <CABRcYmKEd=zmriE8VUnSTvybwA962r60+QaRJZK=KNqYixd_eg@mail.gmail.com>
        <CABRcYmLHfQsjwf7dk+A0Q96iANhj60M0g_xRjVyMUY9LJPybNg@mail.gmail.com>
        <20230810071330.d41a728f996f76e3243f469e@kernel.org>
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

On Thu, 10 Aug 2023 07:13:30 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > 
> > I hope that makes my thoughts clearer? It's a hairy topic ahah  
> 
> Ah, I see your point.
> 
> static void fprobe_init(struct fprobe *fp)
> {
>         fp->nmissed = 0;
>         if (fprobe_shared_with_kprobes(fp))
>                 fp->ops.func = fprobe_kprobe_handler;
>         else
>                 fp->ops.func = fprobe_handler;
>         fp->ops.flags |= FTRACE_OPS_FL_SAVE_REGS; <---- This flag!
> }
> 
> So it should be FTRACE_OPS_FL_ARGS. Let me fix that.

Yes, this was the concern that I was bringing up, where I did not see an
advantage of fprobes over kprobes using ftrace, because they both were
saving all registers.

-- Steve
