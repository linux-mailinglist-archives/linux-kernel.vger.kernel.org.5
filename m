Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFDD757131
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 03:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjGRBEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 21:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjGRBDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 21:03:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E477810F0;
        Mon, 17 Jul 2023 18:03:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B00B61343;
        Tue, 18 Jul 2023 01:03:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ACACC433C7;
        Tue, 18 Jul 2023 01:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689642229;
        bh=5k/u+A5DX4GHss2OEjzlFsWIQoVIRmvHHG7d/qfjoYE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Tq3zbcMlte9vBm6Qt/pdcZjvS/qKfvD/EqAQhRWt24pLiMmQ8nsx5hmUCyYpzMnkP
         p3rS5xu7Or7QTSHKU1SHT776uRC4KE93j6Mf8aXGdVHd+LBYVdfjbtZIOfxx/Millz
         TmULkOlG/sIjNfWWfK1K6KT9VSxf6ZcPk1Wj+XxgxCDR57h96P7GyMZjm0BOPQlb7y
         G8yzf/oypKldVEr21OyRlpOOZyL4Vp1Wrgy+xZw10nYHmxZKAqEPtVw+urMBnXOWa1
         dkaTfuzTsqwiyFTSsyK/UJTl7deaatLgcRLR81nHyW2Q+mF60i1nnkU0NkmPABQQMX
         CSeufJmFvIgJQ==
Date:   Tue, 18 Jul 2023 10:03:45 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v2 2/9] bpf/btf: tracing: Move finding func-proto API
 and getting func-param API to BTF
Message-Id: <20230718100345.c4ba0e4c1e52e9b028697f98@kernel.org>
In-Reply-To: <CAADnVQK6J2TNNRMaZDkC7NNHO6uGs4MrUvocWW-TXsSNg_7s5g@mail.gmail.com>
References: <168960739768.34107.15145201749042174448.stgit@devnote2>
        <168960741686.34107.6330273416064011062.stgit@devnote2>
        <20230717143914.5399a8e4@gandalf.local.home>
        <20230718084634.7746b16b470f5fa1b0d99521@kernel.org>
        <CAADnVQK6J2TNNRMaZDkC7NNHO6uGs4MrUvocWW-TXsSNg_7s5g@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jul 2023 16:51:29 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Mon, Jul 17, 2023 at 4:46 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > >
> > > > + * Return NULL if not found, or return -EINVAL if parameter is invalid.
> > > > + */
> > > > +const struct btf_type *btf_find_func_proto(struct btf *btf, const char *func_name)
> > > > +{
> > > > +   const struct btf_type *t;
> > > > +   s32 id;
> > > > +
> > > > +   if (!btf || !func_name)
> > > > +           return ERR_PTR(-EINVAL);
> 
> Please remove these checks.
> We don't do defensive programming in the BPF subsystem.
> Don't pass NULL pointers to such functions.

OK, we will trust API user to pass a non-NULL parameters.

Thank you!

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
