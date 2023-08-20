Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6018F781DF1
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 15:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjHTNTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 09:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjHTNTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 09:19:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588C744BD;
        Sun, 20 Aug 2023 06:16:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA0EC60EF4;
        Sun, 20 Aug 2023 13:16:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA68EC433C7;
        Sun, 20 Aug 2023 13:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692537376;
        bh=jpP12Tt84GSWZqhl9X1pqcl1iK7aUfgfa3ZFx9tEono=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dR0Eh0zx9/B4CmgyzrI6FscpKnZqEZKbdw8bngNBRztXzCwekeqBXqdb5C3QJXZ0I
         F5LU1tmnki+48YGkT2jEcTKa1DSEmvfNqB1eywh5laDGZfoTwWiUS4UkawUxupMivz
         7zGRFI70ncpsh6uHw7RYoOmFe9OBC8H4GfImCjbf2AMVzl2TXLMAlEv4NnamXrDxWf
         m1NWDP8ImY4U5I52hAR4SU6h1nLNNHo2vklU8lNlTgBlmZSc+K9NgWyAsjDdrtSKfQ
         3M1KrXJSJzCBVpPrD3AR2q06mpZ7Wv5jVkpmfL0O7vUwXU/dd4vAIGnYsqCAoHBWOo
         cbedtT7E5kMWg==
Date:   Sun, 20 Aug 2023 22:16:12 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Francis Laniel <flaniel@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] tracing/kprobe: Add multi-probe support for
 'perf_kprobe' PMU
Message-Id: <20230820221612.33dfc3b3072f8bd8517f95b5@kernel.org>
In-Reply-To: <CAPhsuW73yT+D9HhLhi8pafYZsgT=qsqk5foAwGRTvStnWCZwNA@mail.gmail.com>
References: <20230816163517.112518-1-flaniel@linux.microsoft.com>
        <20230818213705.b4f5e18b392c4837068cba6f@kernel.org>
        <20230818114141.2a3a75ee@gandalf.local.home>
        <4853240.31r3eYUQgx@pwmachine>
        <20230818142033.1d7685e9@gandalf.local.home>
        <20230819101519.568d658fbb6461cc60d348e5@kernel.org>
        <CAPhsuW7d4cMi_FAtvyTn4HJWzRdocJaEVq-uYVcW43=JDE_EnA@mail.gmail.com>
        <20230820183218.bf0b04be3c0ccac5e7b2a587@kernel.org>
        <CAPhsuW73yT+D9HhLhi8pafYZsgT=qsqk5foAwGRTvStnWCZwNA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Aug 2023 03:02:18 -0700
Song Liu <song@kernel.org> wrote:

> On Sun, Aug 20, 2023 at 2:32 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> [...]
> > > >
> > > > perf_event_attr::kprobe_func = "_text";
> > > > perf_event_attr::probe_offset = OFFSET;
> > > >
> > > > Then, it should be able to specify the correct one. Of course you can use
> > > > other unique symbols around the target symbol.
> > >
> > > Trying to catch up with the thread.
> >
> > Thanks for your reply :)
> >
> > >
> > > Besides the CAP_* issue, we can do this with
> > >
> > > perf_event_attr::kprobe_func = NULL;
> > > perf_event_attr::kprobe_addr = address;
> >
> > As I pointed, you don't need actual address, instead, you can specify the
> > probe point via "unique symbol" + offset.
> 
> Technically, this works. But it is weird to me.

It's not so weired because it is a relative address, e.g. from _text,
this means "the address in the text section". And perf probe already
uses it a while.

> > >
> > > Then for the CAP_*, I think we should give CAP_PERFMON access to
> > > /proc/kallsyms. Would this work?
> >
> > For the "unique symbol" + offset, you don't need the kallsyms, but need to
> > access the System.map or vmlinux image. In this case, we don't need to expand
> > the CAP_PERFMON capabilities.
> 
> I agree this is not needed in this case. But I wonder whether it makes sense
> to give CAP_PERFMON access to /proc/kallsyms. Will this change make
> CAP_PERFMON less secure?

Yes, because /proc/kallsyms will expose the real address of the all
symbols, which makes KASLR useless. But on the other hand, it maybe
already useless because BPF program can read any real address, right?
Hmm, from this point of view, is the CAP_PERFMON meaningful?
(maybe it can avoid loading modules etc.)

Thank you,

> 
> Thanks,
> Song


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
