Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57CA76C0B7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 01:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjHAXRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 19:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjHAXRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 19:17:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C88B2103;
        Tue,  1 Aug 2023 16:17:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 297736176A;
        Tue,  1 Aug 2023 23:17:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B6D6C433C8;
        Tue,  1 Aug 2023 23:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690931836;
        bh=88zkvAVDUFWqbW4oJyMLFNy3ju90g2621RUrlMf/Du0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YZTL4fESnAxnkfayIkA5m25sZobaFGsMuDbvhwbG5rk32Vrh/STz+FnVSkmRMuneR
         sNDPe0AfCByyN7A7sI+zabf/sz1wHHpJp719Xh9zJaO8YwHmxP6MMEEgRMx6BqLg9Y
         x0LnEGIn+udJHza1m+Ox1PEJI/FGssHLoQ6sNzPnvFb1fwoWU1W/bn4bofvQipirdz
         7yD8wix5G3U6I9Ki/FRdqSdy+SCW4O1txJ+KJiBwDrX6F3gy1lxajt8wej6Q44FohZ
         XWS6J6x0izVWJs3g5B4UgglwJ7BJyZy8teHdN+sEbDv/KNA2TJ2lgq5vIZjMx+cOZp
         6vPF/jmjp2Y0w==
Date:   Wed, 2 Aug 2023 08:17:11 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4 3/9] bpf/btf: Add a function to search a member of a
 struct/union
Message-Id: <20230802081711.7711f8775ffc730b2c32df5e@kernel.org>
In-Reply-To: <CAADnVQJ2ixjZUY7hJJMM1iUBAYY2VxdL6v--Rg8wvKypfxBsGw@mail.gmail.com>
References: <169078860386.173706.3091034523220945605.stgit@devnote2>
        <169078863449.173706.2322042687021909241.stgit@devnote2>
        <CAADnVQ+C64_C1w1kqScZ6C5tr6_juaWFaQdAp9Mt3uzaQp2KOw@mail.gmail.com>
        <20230731211527.3bde484d@gandalf.local.home>
        <CAADnVQJz41QgpFHr3k0pndjHZ8ragH--=C_bYxrzitj7bN3bbg@mail.gmail.com>
        <20230802001824.90819c7355283843178d9163@kernel.org>
        <CAADnVQJ2ixjZUY7hJJMM1iUBAYY2VxdL6v--Rg8wvKypfxBsGw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Aug 2023 15:21:59 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Tue, Aug 1, 2023 at 8:18 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Mon, 31 Jul 2023 19:24:25 -0700
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> >
> > > On Mon, Jul 31, 2023 at 6:15 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> > > >
> > > > On Mon, 31 Jul 2023 14:59:47 -0700
> > > > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > > Assuming that is addressed. How do we merge the series?
> > > > > The first 3 patches have serious conflicts with bpf trees.
> > > > >
> > > > > Maybe send the first 3 with extra selftest for above recursion
> > > > > targeting bpf-next then we can have a merge commit that Steven can pull
> > > > > into tracing?
> > > >
> > > > Would it be possible to do this by basing it off of one of Linus's tags,
> > > > and doing the merge and conflict resolution in your tree before it gets to
> > > > Linus?
> > > >
> > > > That way we can pull in that clean branch without having to pull in
> > > > anything else from BPF. I believe Linus prefers this over having tracing
> > > > having extra changes from BPF that are not yet in his tree. We only need
> > > > these particular changes, we shouldn't be pulling in anything specific for
> > > > BPF, as I believe that will cause issues on Linus's side.
> > >
> > > We can try, but I suspect git tricks won't do it.
> > > Masami's changes depend on patches for kernel/bpf/btf.c that
> > > are already in bpf-next, so git would have to follow all commits
> > > that touch this file.
> >
> > This point is strange. I'm working on probe/fixes which is based on
> > v6.5-rc3, so any bpf-next change should not be involved. Can you recheck
> > this point?
> >
> > > I don't think git is smart enough to
> > > thread the needle and split the commit into files. If one commit touches
> > > btf.c and something else that whole commit becomes a dependency
> > > that pulls another commit with all files touched by
> > > the previous commit and so on.
> >
> > As far as I understand Steve's method, we will have an intermediate branch
> > on bpf or probe tree, like
> >
> > linus(some common commit) ---- probes/btf-find-api
> >
> > and merge it to both bpf-next and probes/for-next branch
> >
> >           +----------------------bpf-next --- (merge bpf patches)
> >          /                       / merge
> > common -/\ probes/btf-find-api -/-\
> >           \                        \ merge
> >            +----------------------probes/for-next --- (merge probe patches)
> >
> > Thus, we can merge both for-next branches at next merge window without
> > any issue. (But, yes, this is not simple, and needs maxium care)
> 
> Sounds like the path of least resistance is to keep the changes
> in kernel/trace and consolidate with kernel/bpf/btf.c after the next
> merge window.

OK, sounds good to me. I will only expose the bpf_find_btf_id() then.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
