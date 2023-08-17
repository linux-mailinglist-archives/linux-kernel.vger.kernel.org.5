Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D8477F29D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349225AbjHQI6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349200AbjHQI6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:58:06 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047C92684
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:58:05 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-564b326185bso4476815a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692262684; x=1692867484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XfLp1c4CQASb52Y25xFQC1k0yj/rlFjQOJxQJThqQmU=;
        b=ho9t7K5YnNQvxLDVMQoh5xm1KUvC6FOjB+27q2YIWPGBsEK1xTmHG1t4a7Ee3T31Ex
         SKeSoS63VoXvRtkhpGG+BaN/dwKaZY0js6KsiZBcoiXMgPY0a8N/kAAIeNSsjokm9WlT
         yZI1f9uvxWx6FbPMxJ3Gl8EMiGLXjB2yWFuDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692262684; x=1692867484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XfLp1c4CQASb52Y25xFQC1k0yj/rlFjQOJxQJThqQmU=;
        b=h4AyG/FaeOF/mvzbNsWHS68kA5ZeG0ILd4rbNxuQmlvQLypGz8KLuu4n1IE3v7kLLb
         7omQZE+8NAVqpcUz/ypbyNEwpetDiMCLYoA1kHji1/DJP+Ns/XLfY1iXbyo3pxBZQ7ui
         6kjTXBk3Z8fDKPfIPuYACed97Vs8FRNWFrDIRtB4GhruUP0rzR1KcznwrRPTdEASxMnu
         mN64VuP0Js5nnbh6D4KVcerGcxc1ryRqYJgcWlIRUE7EqMvwAmFlQs5+y4g5aplx/7rk
         JJleWu7Vn3nHbq/iQ+LIj6PG4onRDIWvKEij6rl5HO2hKrg8PbIyh+E+FDYilESNBhyQ
         ULbA==
X-Gm-Message-State: AOJu0Yz2BMOvNkpygwGbT8N8FXu38G/MgdD6897WNIMa+pa3Mqux/jLS
        BU4hPYYw8/76zFX4S3HGGFc1kqYhY/r6Uybm8t3Uuw==
X-Google-Smtp-Source: AGHT+IEuEh+F6ilNeOovqEBoQx7IdH5Xb8wY6puO8xnT2cSmh5oD8u4Z75bhE+9E37pBH0xI4F70q7QRYHtpLN1LfH8=
X-Received: by 2002:a17:90b:a12:b0:268:daa4:3a70 with SMTP id
 gg18-20020a17090b0a1200b00268daa43a70mr3495997pjb.32.1692262684544; Thu, 17
 Aug 2023 01:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <169181859570.505132.10136520092011157898.stgit@devnote2> <169181866661.505132.3229847361646568033.stgit@devnote2>
In-Reply-To: <169181866661.505132.3229847361646568033.stgit@devnote2>
From:   Florent Revest <revest@chromium.org>
Date:   Thu, 17 Aug 2023 10:57:53 +0200
Message-ID: <CABRcYm+8uASJA+=AmAFVQMO+ZEOKRBca0bYpxTKb1hGV7P0iUg@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] ftrace: Add ftrace_partial_regs() for converting
 ftrace_regs to pt_regs
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 7:37=E2=80=AFAM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> Add ftrace_partial_regs() which converts the ftrace_regs to pt_regs.
> If the architecture defines its own ftrace_regs, this copies partial
> registers to pt_regs and returns it. If not, ftrace_regs is the same as
> pt_regs and ftrace_partial_regs() will return ftrace_regs::regs.
>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Acked-by: Florent Revest <revest@chromium.org>
