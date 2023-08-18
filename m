Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E99780A9E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 13:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376506AbjHRK7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 06:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376504AbjHRK7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 06:59:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81CA2D73;
        Fri, 18 Aug 2023 03:59:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46AEB60B3B;
        Fri, 18 Aug 2023 10:59:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C15C433C8;
        Fri, 18 Aug 2023 10:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692356381;
        bh=SE01vkZvNrOCsRm/er4z+F222drSCyqwBYJhfrWSbPs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mWE8gEwT+A3q3KwmI1jlPKqm/1u4mg+AE4cnwOdbL41KQYAFd4eo3oxfb3ntyLNhq
         6TwThv3Vs4evhwQl5naZnp1KIbx+bwl+bdQ/OMuiF4z9Vgdw8kwjtgcvRSUktdLUCc
         N+AdpuWaIuO9kTG9dWt+QYlRCEK3zLTWCho1MimVcCg7XE688k307n53F7NH+SwXg/
         C46Hz5hj3wtNNi1rxEZYk2w7X4FjTUZ3COJk8VYso+8MOpDz0N5bUw/KVoycRl9qAz
         hwQ5LqDBWctw4NyCpx7IHyJrV+gji0/41fP1S4gJT2aDX2qtjVbZKPZbLLLO1a1SKG
         UjQ+KBvAqoPsw==
Date:   Fri, 18 Aug 2023 19:59:35 +0900
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
Subject: Re: [PATCH v3 3/8] tracing: Expose ftrace_regs regardless of
 CONFIG_FUNCTION_TRACER
Message-Id: <20230818195935.b03b191c9d453e483eb72269@kernel.org>
In-Reply-To: <CABRcYm+i1PqVNUC_Hf2wsUdw8Gz-kap9YQ1zFwKKXjb7hp11bg@mail.gmail.com>
References: <169181859570.505132.10136520092011157898.stgit@devnote2>
        <169181863118.505132.13233554057378608176.stgit@devnote2>
        <CABRcYm+i1PqVNUC_Hf2wsUdw8Gz-kap9YQ1zFwKKXjb7hp11bg@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2023 10:57:34 +0200
Florent Revest <revest@chromium.org> wrote:

> On Sat, Aug 12, 2023 at 7:37 AM Masami Hiramatsu (Google)
> <mhiramat@kernel.org> wrote:
> >
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >
> > In order to be able to use ftrace_regs even from features unrelated to
> > function tracer (e.g. kretprobe), expose ftrace_regs structures and
> > APIs even if the CONFIG_FUNCTION_TRACER=n.
> >
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Acked-by: Florent Revest <revest@chromium.org>

Thanks!

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
