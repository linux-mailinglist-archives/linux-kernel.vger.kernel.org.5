Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC02A788CFF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 18:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244006AbjHYQMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 12:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243932AbjHYQME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 12:12:04 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D3B1A6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 09:12:01 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-56f84de64b9so797948a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 09:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692979921; x=1693584721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+swS0Fs+/Jidlh626yVLRTU30HTjKLYV7Eqz4GXMuk4=;
        b=SJEctspEFKgbaE90bSPOQjkbytLN6x83WwR3Ye+Do16tmYcwlEkuikSUgw/rVAOFMw
         ivYKoHGCtgYWydal+37rgYsnAU61pDDfJjmvgEzoSr6zh3acSOAZWRagfz6fZHa98e8R
         yxZ2Kk1GE4LWqMUa/rm3Edmoojly0uNCid+js=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692979921; x=1693584721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+swS0Fs+/Jidlh626yVLRTU30HTjKLYV7Eqz4GXMuk4=;
        b=Cr1HYP4riK61qyFd5zwFcloa8AYb7LBg1tll24NO28URBEC3kUUGiFcYxK92wZPg7A
         SNaEKYeBDvQwKSJWAY6uwq/4ah8AvfOQAc+EUXcQTgNw8jjmKVQpXS2LK5GnYgyuraLe
         F2zw7zjZ7NkE5JdUOXCwPW99i/dSNdl3bB1kCHSY+t2DoYCUa/fGpVD8XWyZ+645LDrI
         sNtxNgE5pdcI1UdEe6pzaFEWoK5MNOkK899fJfudwBFaAGPO0bpStMFnXPH1EVORUAVS
         xoNs8UlH17LXYlUDAHf3oib66XsRXEWnW7JWfHLf23OWLkKuhvzT+ZO/x/j2Sx85RgyF
         SB8Q==
X-Gm-Message-State: AOJu0YzP/x9unGQMAjDRXtZpSy6DbwWWe7oq/fNVXqo8DwMoDmT5PKqv
        kWZSBFLqM/m8pcYX2JS1XsGxcQXZQW3JsMM/fRoBcQ==
X-Google-Smtp-Source: AGHT+IHKREHs/rd7bH+N9Ahx9JgFVYEltPJDfwl75y4CnynKUKCSELopuAPThIGR8lqkCZ3hAcygI84sWqmQKen2udg=
X-Received: by 2002:a17:90b:2551:b0:268:808:8e82 with SMTP id
 nw17-20020a17090b255100b0026808088e82mr28189702pjb.1.1692979921252; Fri, 25
 Aug 2023 09:12:01 -0700 (PDT)
MIME-Version: 1.0
References: <169280372795.282662.9784422934484459769.stgit@devnote2>
In-Reply-To: <169280372795.282662.9784422934484459769.stgit@devnote2>
From:   Florent Revest <revest@chromium.org>
Date:   Fri, 25 Aug 2023 18:11:49 +0200
Message-ID: <CABRcYmJoPiSEu_=fq5y=oLg8+VG=p5myp=aCYam_TvRmkWs4Eg@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] bpf: fprobe: rethook: Use ftrace_regs instead of pt_regs
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 5:15=E2=80=AFPM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> Hi,
>
> Here is the 4th version of the series to use ftrace_regs instead of pt_re=
gs
> in fprobe.
> The previous version is here;
>
> https://lore.kernel.org/all/169181859570.505132.10136520092011157898.stgi=
t@devnote2/
>
> This version fixes the issues pointed in the previous series; fix documen=
t
> description, keep CONFIG_FPROBE dependency for multi-kprobe, add
> static_assert check for ftrace_regs size, reorder the ftrace_partial_regs=
()
> patch for perf fprobe event support, introduce per-cpu pt_regs stack for
> perf fprobe event and add Florent's Ack (Thanks!). Also this adds a new
> documentation patch to clarify that the $argN and $retval is best effort.
>
>  - Document fix for the current fprobe callback prototype
>  - Simply replace pt_regs in fprobe_entry_handler with ftrace_regs.
>  - Expose ftrace_regs even if CONFIG_FUNCTION_TRACER=3Dn.
>  - Introduce ftrace_partial_regs(). (This changes ARM64 which needs a cus=
tom
>    implementation)
>  - Replace pt_regs in rethook and fprobe_exit_handler with ftrace_regs. T=
his
>    introduce a new HAVE_PT_REGS_TO_FTRACE_REGS_CAST which means ftrace_re=
gs is
>    just a wrapper of pt_regs (except for arm64, other architectures do th=
is)
>  - Update fprobe-events to use ftrace_regs natively.
>  - Update bpf multi-kprobe handler use ftrace_partial_regs().
>  - Update document for new fprobe callbacks.
>  - Add notes for the $argN and $retval.
>
> This series can be applied against the probes/core branch on linux-trace =
tree.
>
> This series can also be found below branch.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/log/?h=
=3Dtopic/fprobe-ftrace-regs
>
> Thank you,

FWIW, I verified that I could implement BPF multi_kprobe on arm64 on
top of this series so the BPF multi_kprobe usecase is tested but I
haven't tested the "trace_fprobe" or perf use cases.
