Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674FF77F295
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349192AbjHQI6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349198AbjHQI5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:57:48 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3541C2684
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:57:47 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3a7f4f7a8easo2271990b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692262665; x=1692867465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZ7NMqvFIR2et+D8JZPMfPw5WnBck106F6tUJxbT9Gg=;
        b=b0GhhDLSM9faSxoD0WP+TXbItwqeY4LweTgfy9B593XszXNEq91tklMLWcxdjEXQrJ
         6VMQUM+rWR/ODEx3HE1E3XuNdEIONzAUxF7ibYt1tsebrIKpHhaXHhpXBg67/rQjFrv2
         xLI4IRptekVy+SWo0CuEz3yJxIsjTjMsIgqK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692262665; x=1692867465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gZ7NMqvFIR2et+D8JZPMfPw5WnBck106F6tUJxbT9Gg=;
        b=IcGEnh7lN5El0NLAhgfc8/4/88HmLSDtNnJf5VJLrIIoFE/+b2TwBmBjyDQrPQkxrA
         nht3SAfqprk/Von32KlkOPqKtbhxcXPy5t3hlzVu827Drr4OOXdQh/mxaULLIK0MhYPJ
         PJiKUjzHxKxo7a94xsgTZEVjFhJVd2skZxYCLq4IPc2AwQw6b3p3chZZ3uL2ZZmXr7sN
         YNxaMMdp4vr4WB8KpKbT2OnlvSEL7ZhlAodKz7/DTMY7OFNcoITneehHcX4+r6TH3XaD
         5lKktKNDcSpPF1yz/t2Sf3izJqKran6njff3Af0MPmf3BQozjC/oO6fD27UwvFyeKhd8
         x35Q==
X-Gm-Message-State: AOJu0Yw7yI2J2fTDrGYMLYE5C9oK03DbPpDjMD5Gncqo/vxZlAJYrg4f
        LXilxrk9nX/U1Qf6BhcT4uEWa4IKdW+xO7+vvYmiIQ==
X-Google-Smtp-Source: AGHT+IF/lZED8EmuEUmIk6G5RS65+A7NYREGfAS6ecOd1YzcZ0v6Mx9lu+wCelzhQCnQ1D518ZnjHFgRY/sYb2/L/FQ=
X-Received: by 2002:a05:6808:14ca:b0:3a8:3155:bc2e with SMTP id
 f10-20020a05680814ca00b003a83155bc2emr355357oiw.0.1692262665550; Thu, 17 Aug
 2023 01:57:45 -0700 (PDT)
MIME-Version: 1.0
References: <169181859570.505132.10136520092011157898.stgit@devnote2> <169181863118.505132.13233554057378608176.stgit@devnote2>
In-Reply-To: <169181863118.505132.13233554057378608176.stgit@devnote2>
From:   Florent Revest <revest@chromium.org>
Date:   Thu, 17 Aug 2023 10:57:34 +0200
Message-ID: <CABRcYm+i1PqVNUC_Hf2wsUdw8Gz-kap9YQ1zFwKKXjb7hp11bg@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] tracing: Expose ftrace_regs regardless of CONFIG_FUNCTION_TRACER
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
> In order to be able to use ftrace_regs even from features unrelated to
> function tracer (e.g. kretprobe), expose ftrace_regs structures and
> APIs even if the CONFIG_FUNCTION_TRACER=3Dn.
>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Acked-by: Florent Revest <revest@chromium.org>
