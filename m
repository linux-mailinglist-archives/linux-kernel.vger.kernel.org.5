Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D5D7E1575
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 18:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjKER0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 12:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjKER0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 12:26:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1615AC5;
        Sun,  5 Nov 2023 09:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VZvehqzmYfdKM74gw2bH42XgavIBzXX1XLduCUr0/Wg=; b=fM/RAP1TLr0PusgCJzr2HIanH3
        +3yAPvHpA6a+RDrBtCIBv1gYHkRYFVPVzS8RE05WCpl/UEnAvoqM3iiFaLRm4jR19YfroPbrnzSA9
        oJ2iLNvwxknV1xzPNiagLOEY98tceQkBZoMydZWolPBWJ5aPM/fc5Y5I55xxWBjYZkeJCZ9/4VoWT
        sybSV8dVHNwdRyt+38tjZK4jBdt4YQMcaqjs4v7qXaBCH/nbC9kbtlbeo2SSGMfExst+9u52mpdTi
        +ihJZJvwDn1LsmgOoEyyFk5G4H63OZwgfCKPiy0VuFFx2ZvAk2f59lwmzkS0N5WWRcrJ1fVZ0TWg2
        JqVFeuqQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qzgsS-0011Dy-DX; Sun, 05 Nov 2023 17:25:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id B2ABA300326; Sun,  5 Nov 2023 18:25:36 +0100 (CET)
Date:   Sun, 5 Nov 2023 18:25:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <20231105172536.GA7124@noisy.programming.kicks-ass.net>
References: <169920038849.482486.15796387219966662967.stgit@devnote2>
 <169920068069.482486.6540417903833579700.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169920068069.482486.6540417903833579700.stgit@devnote2>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 01:11:21AM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Support HAVE_FUNCTION_GRAPH_FREGS on x86-64, which saves ftrace_regs
> on the stack in ftrace_graph return trampoline so that the callbacks
> can access registers via ftrace_regs APIs.

What is ftrace_regs ? If I look at arch/x86/include/asm/ftrace.h it's a
pointless wrapper around pt_regs.

Can we please remove the pointless wrappery and call it what it is?
