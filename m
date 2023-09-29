Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A173B7B3B0B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 22:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbjI2UO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 16:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbjI2UOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 16:14:23 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A70A1AB
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 13:14:15 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2bfea381255so236496841fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 13:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696018453; x=1696623253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPAXVGa1vaZNDKI9GqcxOhnuNCrtvlqJP4AnZpE32Zw=;
        b=pouZxb7W6gqWlNn9qZf4kA4FURTPm0gEavOitK5PvNTxVQycRF4PPfVHPS1g/1LFSj
         BWwETay+0bFf5PNZo+CdO1ami1j7EbYDBmD29l7ysUrCmkTCk6TVIEM2nM8H+PbSmFBN
         AXk7myI4ZEmDJGbL3wfuu3vfbD11h3Ejm5HZpI+PLw15/lXW00exSyjN5OFRii0g29Ei
         lwVqEBqMHK703n3vtNkHG9z703rFRCT1UdBnUZCSBrjLZ/33X3mB6LsvpeZuqidjs3kF
         eWTzbvCZoFgJV7X7jxIl5JNUnpRzXVyEK5E3D2icNqiqzvlcUsyt4Ebnc7PJCQtV5QkG
         qAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696018453; x=1696623253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jPAXVGa1vaZNDKI9GqcxOhnuNCrtvlqJP4AnZpE32Zw=;
        b=eDmYN0GGlWm/bKkgak6vViBWcjhNR+fD9jrO9j+MxUbGKUmw+8CPpWg2dQv13ndPlN
         bxGBJdogXsg0vB3RrOCosnOyk6v4me2/Qmte/xkj+qHjyQPsWBSU4HydjMWK6zKl6tNQ
         rFnZMK2EVMqvPgOAZFg7ZGECdP7NW7L4N6eX0GL8zmkYCjvU3CV4KzRPu/0evq8RjAg5
         qYru0PUOexrJm2ExtDc9vHcLUhWlTI009Rnx6ijFquBpAwY2Rfrogp3fQrf8vOHM0AO7
         ppabtBvmwxGJQWLt/jk0obTe/wQ3Gr2dOQW0X8OMPTnigl61JGH9gBTcHg16/dso8ya/
         5CZg==
X-Gm-Message-State: AOJu0YwpMHNDbpuv5/gOLaeX3OaIOMurTXe9n/PO4jvji8BQ3tqMawWT
        tUlNm1JudT3cm8KRvniIZXxtRuXXKcKN3HiiqnhC2g==
X-Google-Smtp-Source: AGHT+IFhN+RYXyZcjDZDTL4hr6PdazeWUaka8kIh6PpI3FymUyuiPqpmqLdznpukrXNVYeEHPC6w4G0weB1Yrnda2Gc=
X-Received: by 2002:a05:6512:401a:b0:503:19bc:efb with SMTP id
 br26-20020a056512401a00b0050319bc0efbmr5920186lfb.29.1696018453380; Fri, 29
 Sep 2023 13:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230929191637.416931-1-cleger@rivosinc.com>
In-Reply-To: <20230929191637.416931-1-cleger@rivosinc.com>
From:   Atish Kumar Patra <atishp@rivosinc.com>
Date:   Fri, 29 Sep 2023 13:14:02 -0700
Message-ID: <CAHBxVyGvKLqo7vhD_jtHCH=QrMhTfmjcUW6GBvLogOrAvvm=YA@mail.gmail.com>
Subject: Re: [PATCH v2] tracing: relax trace_event_eval_update() execution
 with cond_resched()
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 12:17=E2=80=AFPM Cl=C3=A9ment L=C3=A9ger <cleger@ri=
vosinc.com> wrote:
>
> When kernel is compiled without preemption, the eval_map_work_func()
> (which calls trace_event_eval_update()) will not be preempted up to its
> complete execution. This can actually cause a problem since if another
> CPU call stop_machine(), the call will have to wait for the
> eval_map_work_func() function to finish executing in the workqueue
> before being able to be scheduled. This problem was observe on a SMP
> system at boot time, when the CPU calling the initcalls executed
> clocksource_done_booting() which in the end calls stop_machine(). We
> observed a 1 second delay because one CPU was executing
> eval_map_work_func() and was not preempted by the stop_machine() task.
>
> Adding a call to cond_resched() in trace_event_eval_update() allows
> other tasks to be executed and thus continue working asynchronously
> like before without blocking any pending task at boot time.
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> ---
>
> Changes in v2:
>  - Use cond_resched() instead of schedule()
>
>  kernel/trace/trace_events.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 91951d038ba4..f49d6ddb6342 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -2770,6 +2770,7 @@ void trace_event_eval_update(struct trace_eval_map =
**map, int len)
>                                 update_event_fields(call, map[i]);
>                         }
>                 }
> +               cond_resched();
>         }
>         up_write(&trace_event_sem);
>  }

(First email got rejected as gmail decided to switch back the format
to html :(). Sorry for the noise.
Thanks for the fix. The boot time improvement is evident in both
spike/Qemu. FWIW
Tested-by: Atish Patra <atishp@rivosinc.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>

> --
> 2.40.1
>
