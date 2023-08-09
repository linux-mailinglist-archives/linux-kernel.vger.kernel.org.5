Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3705776C09
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 00:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjHIWOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 18:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjHIWOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:14:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA9F2699;
        Wed,  9 Aug 2023 15:13:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E13C64B46;
        Wed,  9 Aug 2023 22:13:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E473C433C7;
        Wed,  9 Aug 2023 22:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691619216;
        bh=0SR9DPqseRHiCXQ+j6+0+QSN4Sn6OOxeM42Im3uazes=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aEUC8hu248uC08A4L5iDh0a+W+mlid8cOQvoZghQ0ePtWWP3/01VWwKlMokaVoStR
         +yoxh3hV/rweR2hv0YPrigzI8RzRzYptpjK3gStXmzsm7ruL2sM0U5XfHLKjGZwE/p
         pPnKJU08RLf12NVdtwlhoJtHISSFK48EM8lzMEeky31FVgscBf/BbjBOyTX3DDJa/1
         9yluawRZ/bHdkUJj6boWBctDa3g1Vsy5Gsc4oWziBVg1b2Sl73ejFosS3ymDeil0+B
         zNBNk3AE/+0fKDSQpKeEy3+xPOyc5EoeY5lkfeuOrf0gbEEiNgUrfkC99fJV+kpsxX
         jY6X4ZUgLojRA==
Date:   Thu, 10 Aug 2023 07:13:30 +0900
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
Subject: Re: [RFC PATCH v2 1/6] fprobe: Use fprobe_regs in fprobe entry
 handler
Message-Id: <20230810071330.d41a728f996f76e3243f469e@kernel.org>
In-Reply-To: <CABRcYmLHfQsjwf7dk+A0Q96iANhj60M0g_xRjVyMUY9LJPybNg@mail.gmail.com>
References: <169139090386.324433.6412259486776991296.stgit@devnote2>
        <169139091575.324433.13168120610633669432.stgit@devnote2>
        <CABRcYmKRAbOuqNQm5mCwC9NWbtcz1JJDYL_h5x6dK77SJ5FRkA@mail.gmail.com>
        <20230809231011.b125bd68887a5659db59905e@kernel.org>
        <CABRcYmKEd=zmriE8VUnSTvybwA962r60+QaRJZK=KNqYixd_eg@mail.gmail.com>
        <CABRcYmLHfQsjwf7dk+A0Q96iANhj60M0g_xRjVyMUY9LJPybNg@mail.gmail.com>
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

On Wed, 9 Aug 2023 18:17:47 +0200
Florent Revest <revest@chromium.org> wrote:

> On Wed, Aug 9, 2023 at 6:09 PM Florent Revest <revest@chromium.org> wrote:
> >
> > On Wed, Aug 9, 2023 at 4:10 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > >
> > > Hi Florent,
> > >
> > > On Wed, 9 Aug 2023 12:28:38 +0200
> > > Florent Revest <revest@chromium.org> wrote:
> > >
> > > > On Mon, Aug 7, 2023 at 8:48 AM Masami Hiramatsu (Google)
> > > > <mhiramat@kernel.org> wrote:
> > > > >
> > > > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > > >
> > > > > This allows fprobes to be available with CONFIG_DYNAMIC_FTRACE_WITH_ARGS
> > > > > instead of CONFIG_DYNAMIC_FTRACE_WITH_REGS, then we can enable fprobe
> > > > > on arm64.
> > > >
> > > > This patch lets fprobe code build on configs WITH_ARGS and !WITH_REGS
> > > > but fprobe wouldn't run on these builds because fprobe still registers
> > > > to ftrace with FTRACE_OPS_FL_SAVE_REGS, which would fail on
> > > > !WITH_REGS. Shouldn't we also let the fprobe_init callers decide
> > > > whether they want REGS or not ?
> > >
> > > Ah, I think you meant FPROBE_EVENTS? Yes I forgot to add the dependency
> > > on it. But fprobe itself can work because fprobe just pass the ftrace_regs
> > > to the handlers. (Note that exit callback may not work until next patch)
> >
> > No, I mean that fprobe still registers its ftrace ops with the
> > FTRACE_OPS_FL_SAVE_REGS flag:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/tree/kernel/trace/fprobe.c?h=topic/fprobe-ftrace-regs&id=2ca022b2753ae0d2a2513c95f7ed5b5b727fb2c4#n185
> >
> > Which means that __register_ftrace_function will return -EINVAL on
> > builds !WITH_REGS:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/tree/kernel/trace/ftrace.c?h=topic/fprobe-ftrace-regs&id=2ca022b2753ae0d2a2513c95f7ed5b5b727fb2c4#n338
> >
> > As documented here:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/tree/include/linux/ftrace.h?h=topic/fprobe-ftrace-regs&id=2ca022b2753ae0d2a2513c95f7ed5b5b727fb2c4#n188
> >
> > There are two parts to using sparse pt_regs. One is "static": having
> > WITH_ARGS in the config, the second one is "dynamic": a ftrace ops
> > needs to specify that it doesn't want to go through the ftrace
> > trampoline that saves a full pt_regs, by not giving
> > FTRACE_OPS_FL_SAVE_REGS. If we want fprobe to work on builds
> > !WITH_REGS then we should both remove Kconfig dependencies to
> > WITH_REGS (like you've done) but also stop passing this ftrace ops
> > flag.
> 
> Said in a different way: there are arches that support both WITH_ARGS
> and WITH_REGS (like x86 actually). They have two ftrace trampolines
> compiled in: ftrace_caller and ftrace_regs_caller, one for each
> usecase. If you register to ftrace with the FTRACE_OPS_FL_SAVE_REGS
> flag you are telling it that what you want is a pt_regs. If you are
> trying to move away from pt_regs and support ftrace_regs in the more
> general case (meaning, in the case where it can contain a sparse
> pt_regs) then you should stop passing that flag so you go through the
> lighter, faster trampoline and test your code in the circumstances
> where ftrace_regs isn't just a regular pt_regs but an actually sparse
> or light data structure.
> 
> I hope that makes my thoughts clearer? It's a hairy topic ahah

Ah, I see your point.

static void fprobe_init(struct fprobe *fp)
{
        fp->nmissed = 0;
        if (fprobe_shared_with_kprobes(fp))
                fp->ops.func = fprobe_kprobe_handler;
        else
                fp->ops.func = fprobe_handler;
        fp->ops.flags |= FTRACE_OPS_FL_SAVE_REGS; <---- This flag!
}

So it should be FTRACE_OPS_FL_ARGS. Let me fix that.

Thank you!
-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
