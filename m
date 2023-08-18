Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBFB780CAB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 15:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377211AbjHRNkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 09:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377212AbjHRNkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 09:40:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2A230F5;
        Fri, 18 Aug 2023 06:40:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24EED6607D;
        Fri, 18 Aug 2023 13:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB60AC433C7;
        Fri, 18 Aug 2023 13:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692366012;
        bh=Jknt7yoyXj/GKmML3txJuQ91AeMyNNJJSxj3O7zVlfo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uoCK37CZGANYJvk89oM0I6FX/XHktq9nBLsAXihU3DzSpQmVVCM8KfVjuVLsLpgug
         E8uZIvIFpFcYvdNLTv2rJCsDtraGvBNN9bAyXm9+Pc6yIi4KfOjCmSZ3qVRpF8YBD5
         Zg8Q/xam3sZugPtID75cbWQ5Om0unl5RKzI5eIy98HICIq90LcLVDaWuL7rHuDOsMI
         Uvxzoa8KcmGA+9+ZhcBd2wEm5lVYAR1Ju39jHdHuBAHDYJjGOEbzAjdVMTnVD4jVxo
         4uY5mhD9kWObBeEUW8ZzyiGHFNzK/wOCYBw6RfRNitzpJsUO+3bsDPc9Ym4Ud2C8cW
         tka2j3+ZmH5HQ==
Date:   Fri, 18 Aug 2023 22:40:06 +0900
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
Subject: Re: [PATCH v3 0/8] bpf: fprobe: rethook: Use ftrace_regs instead of
 pt_regs
Message-Id: <20230818224006.a611cd1a73e00ca1a48478bc@kernel.org>
In-Reply-To: <CABRcYmJLbb0_fs2beiNA2QE468JkxB9nHnmQcQW4dt63pPBoFA@mail.gmail.com>
References: <169181859570.505132.10136520092011157898.stgit@devnote2>
        <CABRcYmJLbb0_fs2beiNA2QE468JkxB9nHnmQcQW4dt63pPBoFA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2023 10:57:13 +0200
Florent Revest <revest@chromium.org> wrote:

> On Sat, Aug 12, 2023 at 7:36 AM Masami Hiramatsu (Google)
> <mhiramat@kernel.org> wrote:
> >
> > Hi,
> >
> > Here is the 3rd version of RFC series to use ftrace_regs instead of pt_regs.
> > The previous version is here;
> >
> > https://lore.kernel.org/all/169139090386.324433.6412259486776991296.stgit@devnote2/
> >
> > This also includes the generic part and minimum modifications of arch
> > dependent code. (e.g. not including rethook for arm64.)
> 
> I think that one aspect that's missing from the discussion (and maybe
> the series) so far is plans to actually save partial registers in the
> existing rethook trampolines.

Yes, it is arch-dependent part. We have to recheck what registers are
required for the rethook, and that is saved correctly on partial pt_regs
on each architecture.

> For now the series makes everything called by the rethook trampolines
> handle the possibility of having a sparse ftrace_regs but the rethook
> trampolines still save full ftrace_regs. I think that to rip the full
> benefits of this series, we should have the rethook trampolines save
> the equivalent ftrace_regs as the light "args" version of the ftrace
> trampoline.

I think this part depends on the architecture implementation, but yes.
Arm64 can *add* the rethook implementation but not enable KRETPROBE_ON_RETHOOK.
(do not remove kretprobe trampoline)
For this perpose, we need HAVE_RETHOOK_WITH_REGS;

 config KRETPROBE_ON_RETHOOK
         def_bool y
-        depends on HAVE_RETHOOK
+        depends on HAVE_RETHOOK_WITH_REGS
         depends on KRETPROBES
         select RETHOOK

So there will be pt_regs rethook and ftrace_regs (partial regs) rethook.

I would like to replace rethook's pt_regs with ftrace_regs too. However the
most problematic part is kretprobe. If CONFIG_KRETPROBE_ON_RETHOOK=y, the 
rethook must use pt_regs instead of ftrace_regs for API compatibility.
But it makes hard to integrate the rethook and function-graph trace return
hook. (I will discuss this in LPC)

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
