Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C07F7588D7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 01:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjGRXD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 19:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjGRXD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 19:03:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC1EED;
        Tue, 18 Jul 2023 16:03:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29A7E6130C;
        Tue, 18 Jul 2023 23:03:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27746C433C7;
        Tue, 18 Jul 2023 23:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689721422;
        bh=KLWairXWjM3wHL7cN2BqH6MgbWz4n9bm+Sod/qxn6hE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GgemyIa0/KWxtZey2iWTFwkaoLD00Lvvy0CR1AjwmRSuHgnEzAZDkT9UymjBk57mB
         msJIyUULvpB+VIDOynw92BBgGJFCyEwMZIeHXaJy37ZRfwxH9hKw6DNdzjQhx0/gtd
         WNNr4s5RTMGVYXRCAMSWh4nj/kGuMxlN58iULiG7TbrY15XbkGdQeKa+JeA8+pksil
         E3zQGiZZYymzO4oUuXt6C4+kAMp07mp/HgiaWlGGrF2mHBDYqG/ksBH/TBOWX/GOw3
         +yr4DmeAYk8CGNxQaD3LkBmEnXSPVlImV6Gqa6SPv9NrPeX2CrHQw35oe5A+Skjfmm
         y+JgSBNeVqrRA==
Date:   Wed, 19 Jul 2023 08:03:37 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Donglin Peng <dolinux.peng@gmail.com>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v2 2/9] bpf/btf: tracing: Move finding func-proto API
 and getting func-param API to BTF
Message-Id: <20230719080337.0955a6e77d799daad4c44350@kernel.org>
In-Reply-To: <CAADnVQ+8PuT5tC4q1spefzzCZG9r1UszFv0jenK5+Ed+QNqtsw@mail.gmail.com>
References: <168960739768.34107.15145201749042174448.stgit@devnote2>
        <168960741686.34107.6330273416064011062.stgit@devnote2>
        <CAErzpmuvhrj0HhTpH2m-C-=pFV=Q_mxYC59Hw=dm0pqUvtPm0g@mail.gmail.com>
        <20230718194431.5653b1e89841e6abd9742ede@kernel.org>
        <20230718225606.926222723cdd8c2c37294e41@kernel.org>
        <CAADnVQ+8PuT5tC4q1spefzzCZG9r1UszFv0jenK5+Ed+QNqtsw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
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

On Tue, 18 Jul 2023 10:11:01 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Tue, Jul 18, 2023 at 6:56 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Tue, 18 Jul 2023 19:44:31 +0900
> > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> >
> > > > >  static const struct btf_param *find_btf_func_param(const char *funcname, s32 *nr,
> > > > >                                                    bool tracepoint)
> > > > >  {
> > > > > +       struct btf *btf = traceprobe_get_btf();
> > > >
> > > > I found that traceprobe_get_btf() only returns the vmlinux's btf. But
> > > > if the function is
> > > > defined in a kernel module, we should get the module's btf.
> > > >
> > >
> > > Good catch! That should be a separated fix (or improvement?)
> > > I think it's better to use btf_get() and btf_put(), and pass btf via
> > > traceprobe_parse_context.
> >
> > Hmm, it seems that there is no exposed API to get the module's btf.
> > Should I use btf_idr and btf_idr_lock directly to find the corresponding
> > btf? If there isn't yet, I will add it too.
> 
> There is bpf_find_btf_id.
> Probably drop 'static' from it and use it.

Thanks! BTW, that API seems to search BTF type info by name. If user want to
specify a module name, do we need a new API? (Or expand the function to parse
a module name in given name?)

Thank you,
-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
