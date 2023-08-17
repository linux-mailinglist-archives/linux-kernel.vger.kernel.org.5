Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC42E77F290
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349175AbjHQI57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349174AbjHQI5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:57:33 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B6B2D56
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:57:30 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-563f8e8a53dso4434765a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692262649; x=1692867449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzJTGyBFfNHD26CtlWDf2OW3qCUaOPcLUEmxDdyzh1Y=;
        b=AX4W4grsrDeNO020vqALXp3Khnl8rxn12/hWnVkm67FyUZYNK6smWA2tVd8XAqEEo5
         FbFzjnUdn5GyY/imwd42Tip4Ey4NFPGonCAfEMdB44xSE9S0uD+/jMevNWO9J6uHj04P
         xtYQpsw8LEaz2Y0c/YJMNJg1TpbPHVQ9Qo0Co=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692262649; x=1692867449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zzJTGyBFfNHD26CtlWDf2OW3qCUaOPcLUEmxDdyzh1Y=;
        b=RBOxtUX4gu9blDlwF9KObKDcd0pXaEFtCIyxpjnRoQoISqBcuN57yGJsuGhnUqGSWy
         LsrpWXVBA4nLnkQl8NKxAdXPKFBVHHqWeOMdrGIe0Jbmi7qA2NvhqhI8Sr0YmbK8baLj
         E36B1rAZAqvnAwyuor9a9FDhCCldZF9VMkiEVW0xN3fIeCAIdn4nJ3eiR9jDVS2NGYeW
         rSNIorapL+ew9l4dF2eqeytSudK+d1p7lQoMCE300nS84jr3HhxCPGfsF8nof0hBhpUd
         23j1fsYyOUZMxp05/skOapKeQa5PoNbnukwUru96+zKR23MSzZjc2GtEO9Aq2S+cvN5i
         IiSA==
X-Gm-Message-State: AOJu0YxDhUluQSZ6ikhq+TQ9C3VvVBdFOFwqPGO7m0W9kaOrxbkGYf0L
        V7eTi806/e9fepLeLv/TLsNJN6H81fU2RavdrfHgwA==
X-Google-Smtp-Source: AGHT+IGoPbYFBVceIn1MirlXDItYRs71DR8HUnsO7PhevciD8S5nbWq09PLmtEx8gUECyHYDIG141YPHSni37ZMfp2E=
X-Received: by 2002:a17:90b:3b49:b0:268:1be1:745a with SMTP id
 ot9-20020a17090b3b4900b002681be1745amr3422216pjb.29.1692262649679; Thu, 17
 Aug 2023 01:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <169181859570.505132.10136520092011157898.stgit@devnote2> <169181860742.505132.14215380532909911090.stgit@devnote2>
In-Reply-To: <169181860742.505132.14215380532909911090.stgit@devnote2>
From:   Florent Revest <revest@chromium.org>
Date:   Thu, 17 Aug 2023 10:57:18 +0200
Message-ID: <CABRcYm+ZuuJJGGk1cQso=4ZN+jBp2g5NODFJYq-TDqzu8KL85A@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] Documentation: probes: Add a new ret_ip callback parameter
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

On Sat, Aug 12, 2023 at 7:36=E2=80=AFAM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> Add a new ret_ip callback parameter description.
>
> Fixes: cb16330d1274 ("fprobe: Pass return address to the handlers")
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Documentation/trace/fprobe.rst |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/trace/fprobe.rst b/Documentation/trace/fprobe.=
rst
> index 40dd2fbce861..a6d682478147 100644
> --- a/Documentation/trace/fprobe.rst
> +++ b/Documentation/trace/fprobe.rst
> @@ -91,9 +91,9 @@ The prototype of the entry/exit callback function are a=
s follows:
>
>  .. code-block:: c
>
> - int entry_callback(struct fprobe *fp, unsigned long entry_ip, struct pt=
_regs *regs, void *entry_data);
> + int entry_callback(struct fprobe *fp, unsigned long entry_ip, unsigned =
long ret_ip, struct pt_regs *regs, void *entry_data);
>
> - void exit_callback(struct fprobe *fp, unsigned long entry_ip, struct pt=
_regs *regs, void *entry_data);
> + void exit_callback(struct fprobe *fp, unsigned long entry_ip, unsigned =
long ret_ip, struct pt_regs *regs, void *entry_data);
>
>  Note that the @entry_ip is saved at function entry and passed to exit ha=
ndler.
>  If the entry callback function returns !0, the corresponding exit callba=
ck will be cancelled.
> @@ -108,6 +108,10 @@ If the entry callback function returns !0, the corre=
sponding exit callback will
>          Note that this may not be the actual entry address of the functi=
on but
>          the address where the ftrace is instrumented.
>
> +@ret_ip
> +        This is the return address of the traced function. This can be u=
sed
> +        at both entry and exit.

Maybe that's just the lack of coffee but I had to think twice to
understand what this paragraph meant :) On my first pass I thought
this meant "the address of the return instruction", which made little
sense since there can of course be multiple "ret"s in a function. I
like the name in the fprobe code "parent_ip" because I find it conveys
better that this is an address in the caller of the traced function.
I'm also fine with this "ret_ip" but I propose we modify the paragraph
a little bit to something like:

This is the address that the traced function will return to, somewhere
in its caller. This can be used at both entry and exit.
