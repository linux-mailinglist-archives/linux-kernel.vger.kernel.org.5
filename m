Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C6076B5FB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 15:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbjHANfm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 1 Aug 2023 09:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbjHANfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:35:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9642106;
        Tue,  1 Aug 2023 06:35:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31E0F61592;
        Tue,  1 Aug 2023 13:35:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36E6C433C8;
        Tue,  1 Aug 2023 13:35:29 +0000 (UTC)
Date:   Tue, 1 Aug 2023 09:35:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4 3/9] bpf/btf: Add a function to search a member of a
 struct/union
Message-ID: <20230801093527.369e046e@gandalf.local.home>
In-Reply-To: <CAADnVQJz41QgpFHr3k0pndjHZ8ragH--=C_bYxrzitj7bN3bbg@mail.gmail.com>
References: <169078860386.173706.3091034523220945605.stgit@devnote2>
        <169078863449.173706.2322042687021909241.stgit@devnote2>
        <CAADnVQ+C64_C1w1kqScZ6C5tr6_juaWFaQdAp9Mt3uzaQp2KOw@mail.gmail.com>
        <20230731211527.3bde484d@gandalf.local.home>
        <CAADnVQJz41QgpFHr3k0pndjHZ8ragH--=C_bYxrzitj7bN3bbg@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2023 19:24:25 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Mon, Jul 31, 2023 at 6:15 PM Steven Rostedt <rostedt@goodmis.org>
> wrote:
> >
> > On Mon, 31 Jul 2023 14:59:47 -0700
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> >  
> > > Assuming that is addressed. How do we merge the series?
> > > The first 3 patches have serious conflicts with bpf trees.
> > >
> > > Maybe send the first 3 with extra selftest for above recursion
> > > targeting bpf-next then we can have a merge commit that Steven can
> > > pull into tracing?  
> >
> > Would it be possible to do this by basing it off of one of Linus's tags,
> > and doing the merge and conflict resolution in your tree before it gets
> > to Linus?
> >
> > That way we can pull in that clean branch without having to pull in
> > anything else from BPF. I believe Linus prefers this over having tracing
> > having extra changes from BPF that are not yet in his tree. We only need
> > these particular changes, we shouldn't be pulling in anything specific
> > for BPF, as I believe that will cause issues on Linus's side.  
> 
> We can try, but I suspect git tricks won't do it.
> Masami's changes depend on patches for kernel/bpf/btf.c that
> are already in bpf-next, so git would have to follow all commits

You mean other patches that Masami has sent are in the bpf tree already and
these are on top of them?

-- Steve

> that touch this file. I don't think git is smart enough to
> thread the needle and split the commit into files. If one commit touches
> btf.c and something else that whole commit becomes a dependency
> that pulls another commit with all files touched by
> the previous commit and so on.
> tbh for this set, the easiest for everyone, is to land the whole thing
> through bpf-next, since there are no conflicts on fprobe side.

