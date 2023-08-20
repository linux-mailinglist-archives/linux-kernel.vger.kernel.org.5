Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2F9781D30
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 11:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjHTJgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 05:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjHTJgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 05:36:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C1D12A;
        Sun, 20 Aug 2023 02:32:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC5CE60EBF;
        Sun, 20 Aug 2023 09:32:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE5AC433C7;
        Sun, 20 Aug 2023 09:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692523942;
        bh=Mwxqh7D4alt9PiyEKqBot7zzqgVRjTW256SDQGY9m24=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YH/yGIp8OPCeVT9dHAMrD3r3oD6SzcmhDUYd0+b6iM3Eo8EmzOmUNqMzNnB4qqbz5
         1QHukdJCXo9mygdlSLTAgvRobJyWdZJZ/HRjazvu/1GEDJf+/RqRWQK4eQBMwxl/Zh
         tt7FjMdIIuJzCiiEByVs0Hiwml6eSukVltaKjXxsIaXkRKRZhRFv/D74yWZvem5lHd
         pZAkYM3Qq/Frtw5icpuhW2KOZ39mn19O5CaTDiyCi2ZHzQHodq72LGg+m9DNljrhPd
         VB8Kxigq/oLK/19OOoYjg4C86JL/xLVzQxQuYPxRZUT6X/6+SwZYsSG+3/sraTSvvy
         JqjyQf4kSQ09g==
Date:   Sun, 20 Aug 2023 18:32:18 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Francis Laniel <flaniel@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] tracing/kprobe: Add multi-probe support for
 'perf_kprobe' PMU
Message-Id: <20230820183218.bf0b04be3c0ccac5e7b2a587@kernel.org>
In-Reply-To: <CAPhsuW7d4cMi_FAtvyTn4HJWzRdocJaEVq-uYVcW43=JDE_EnA@mail.gmail.com>
References: <20230816163517.112518-1-flaniel@linux.microsoft.com>
        <20230818213705.b4f5e18b392c4837068cba6f@kernel.org>
        <20230818114141.2a3a75ee@gandalf.local.home>
        <4853240.31r3eYUQgx@pwmachine>
        <20230818142033.1d7685e9@gandalf.local.home>
        <20230819101519.568d658fbb6461cc60d348e5@kernel.org>
        <CAPhsuW7d4cMi_FAtvyTn4HJWzRdocJaEVq-uYVcW43=JDE_EnA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Aug 2023 08:22:50 -0700
Song Liu <song@kernel.org> wrote:

> On Fri, Aug 18, 2023 at 6:16 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Fri, 18 Aug 2023 14:20:33 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > > On Fri, 18 Aug 2023 20:13:43 +0200
> > > Francis Laniel <flaniel@linux.microsoft.com> wrote:
> > >
> > > > Hi.
> > > >
> > > > Le vendredi 18 août 2023, 17:41:41 CEST Steven Rostedt a écrit :
> > > > > On Fri, 18 Aug 2023 21:37:05 +0900
> > > > >
> > > > > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > > > > > That's why perf probe uses the offset from '_text'. Normal KASLR will just
> > > > > > moves all symbols. (Finer one will move all symbols randomely)
> > > > > > This should not need to access /proc/kallsyms but vmlinux or SystemMap.
> > > > >
> > > > > We could just pass in: "_text+offset" too.
> > > >
> > > > So, the idea would be to change the existing create_local_trace_kprobe() and
> > > > above functions to indicate the user's offset is to be used against _text and
> > > > not address?
> > >
> > > No, not to modify that function, but if you know the offset from _text (via
> > > the vmlinux), you can easily calculate it for that function.
> >
> > Note that the kprobe-event PMU interface itself allows you to specify
> > FUNC+OFFSET style;
> >
> > https://lore.kernel.org/lkml/20171206224518.3598254-5-songliubraving@fb.com/
> >
> > perf_event_attr::kprobe_func = "_text";
> > perf_event_attr::probe_offset = OFFSET;
> >
> > Then, it should be able to specify the correct one. Of course you can use
> > other unique symbols around the target symbol.
> 
> Trying to catch up with the thread.

Thanks for your reply :)

> 
> Besides the CAP_* issue, we can do this with
> 
> perf_event_attr::kprobe_func = NULL;
> perf_event_attr::kprobe_addr = address;

As I pointed, you don't need actual address, instead, you can specify the
probe point via "unique symbol" + offset. 

> 
> Then for the CAP_*, I think we should give CAP_PERFMON access to
> /proc/kallsyms. Would this work?

For the "unique symbol" + offset, you don't need the kallsyms, but need to
access the System.map or vmlinux image. In this case, we don't need to expand
the CAP_PERFMON capabilities.

Thank you,

> 
> Thanks,
> Song


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
