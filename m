Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082BD759944
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbjGSPPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjGSPP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:15:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BC1B7;
        Wed, 19 Jul 2023 08:15:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17C1E6172E;
        Wed, 19 Jul 2023 15:15:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 447B0C433C8;
        Wed, 19 Jul 2023 15:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689779727;
        bh=qJ+ZrPEpdBA96XSDs0SJx0ONexgC885l+neDnc4f3ko=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=teN+eU0GR7xtJcebaFAAObKkHW/bzF2oP1wRwhkmMyvJOw/EbyXfyEHwiZ1LzoEIt
         otVk7eUqCEe0GvVKaW4viGxLbuInZDyqrDf2ZoZyDuACl0k6Tau2CRxgY6coYdxPXk
         D+wJikzZWxxnPgZdYD+5gmS2V8J4lFn6G5pCZc0r5RLCLBf2pPPkiv5+30C1bnLLug
         fSI+lbtHqRRcNva+uIj/kJeyQB7jQVP3S4cG6qgMJR7YahKLEJjeKy8SBlR8BcmX2U
         R1a2egRnqybWxCZ2C1OLXIYf9IdeTkymGGdIaLGoAZuMZ/OjoMa/KgVEOlJG61mqIl
         r3Ldi2AyBNOJg==
Date:   Thu, 20 Jul 2023 00:15:22 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Donglin Peng <dolinux.peng@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v2 2/9] bpf/btf: tracing: Move finding func-proto API
 and getting func-param API to BTF
Message-Id: <20230720001522.4aaadaf77d037ccdc7e4b83e@kernel.org>
In-Reply-To: <CAErzpmtJF4tjHCyYdHgiX_-vp39tdc=3iNmMhQ6SnFVicqZWrg@mail.gmail.com>
References: <168960739768.34107.15145201749042174448.stgit@devnote2>
        <168960741686.34107.6330273416064011062.stgit@devnote2>
        <CAErzpmuvhrj0HhTpH2m-C-=pFV=Q_mxYC59Hw=dm0pqUvtPm0g@mail.gmail.com>
        <20230718194431.5653b1e89841e6abd9742ede@kernel.org>
        <20230718225606.926222723cdd8c2c37294e41@kernel.org>
        <CAADnVQ+8PuT5tC4q1spefzzCZG9r1UszFv0jenK5+Ed+QNqtsw@mail.gmail.com>
        <20230719080337.0955a6e77d799daad4c44350@kernel.org>
        <CAErzpmtJF4tjHCyYdHgiX_-vp39tdc=3iNmMhQ6SnFVicqZWrg@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jul 2023 10:09:48 +0800
Donglin Peng <dolinux.peng@gmail.com> wrote:

> On Wed, Jul 19, 2023 at 7:03 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Tue, 18 Jul 2023 10:11:01 -0700
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> >
> > > On Tue, Jul 18, 2023 at 6:56 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > >
> > > > On Tue, 18 Jul 2023 19:44:31 +0900
> > > > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > > >
> > > > > > >  static const struct btf_param *find_btf_func_param(const char *funcname, s32 *nr,
> > > > > > >                                                    bool tracepoint)
> > > > > > >  {
> > > > > > > +       struct btf *btf = traceprobe_get_btf();
> > > > > >
> > > > > > I found that traceprobe_get_btf() only returns the vmlinux's btf. But
> > > > > > if the function is
> > > > > > defined in a kernel module, we should get the module's btf.
> > > > > >
> > > > >
> > > > > Good catch! That should be a separated fix (or improvement?)
> > > > > I think it's better to use btf_get() and btf_put(), and pass btf via
> > > > > traceprobe_parse_context.
> > > >
> > > > Hmm, it seems that there is no exposed API to get the module's btf.
> > > > Should I use btf_idr and btf_idr_lock directly to find the corresponding
> > > > btf? If there isn't yet, I will add it too.
> > >
> > > There is bpf_find_btf_id.
> > > Probably drop 'static' from it and use it.
> >
> > Thanks! BTW, that API seems to search BTF type info by name. If user want to
> > specify a module name, do we need a new API? (Or expand the function to parse
> > a module name in given name?)
> 
> btf_get_module_btf can be used to get a module's btf, but we have to use
> find_module to get the module by its name firstly.

Thanks for the info! OK, this will be useful.

> 
> >
> > Thank you,
> > --
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
