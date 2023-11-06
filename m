Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15347E182D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 01:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjKFAjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 19:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKFAjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 19:39:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC3DCC
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 16:38:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31413C433C7;
        Mon,  6 Nov 2023 00:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699231137;
        bh=sBDk+076fVKXychqjFadk7YAA7DfxlUCMnw+EafM8Xc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ouh1MQfQTyssXSpmolQ9RLlVODSh05RIUQCcwxNhAwep/MAvyIsmg9rXKWDVIXf9Y
         NpMnXU18AQrFZIizlEWBlcLVVYj8AzYoXPr5zQcFK63w7MhBfztM+JOml/Litu7Q/u
         ykF6NMSoLkLhHHNbWOThcnzvuphl/LO51J2PqT8OFbRYZ7kJYuQwu1+yUnGMNDl0jp
         Ge2pfOAnWojNLmUskxnFNc9+Y0sp8XJacjLM0vzn89DWubbOV4gaM+BvZQTsruSHin
         54ipzRNGlP6KcaBFKvtlnfTMdywcnUwDdkrDnmpt9SZDgRt3z1UMbUALzcTUNiGTwR
         o0sVd6VoyBm2A==
Date:   Mon, 6 Nov 2023 09:38:50 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Florent Revest <revest@chromium.org>,
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
        Thomas Gleixner <tglx@linutronix.de>,
        Guo Ren <guoren@kernel.org>
Subject: Re: [RFC PATCH 24/32] x86/ftrace: Enable HAVE_FUNCTION_GRAPH_FREGS
Message-Id: <20231106093850.62702d5bf1779e30cdecf1eb@kernel.org>
In-Reply-To: <20231105183409.424bc368@rorschach.local.home>
References: <169920038849.482486.15796387219966662967.stgit@devnote2>
        <169920068069.482486.6540417903833579700.stgit@devnote2>
        <20231105172536.GA7124@noisy.programming.kicks-ass.net>
        <20231105141130.6ef7d8bd@rorschach.local.home>
        <20231105231734.GE3818@noisy.programming.kicks-ass.net>
        <20231105183301.38be5598@rorschach.local.home>
        <20231105183409.424bc368@rorschach.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Nov 2023 18:34:09 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sun, 5 Nov 2023 18:33:01 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > For x86_64, that would be:
> > 
> >   rdi, rsi, rdx, r8, r9, rsp
> 
> I missed rcx.

I would like to add rax to the list so that it can handle the return value too. :)

Thanks,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
