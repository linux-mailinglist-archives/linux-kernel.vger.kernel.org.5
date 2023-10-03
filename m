Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CF67B73FA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 00:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241282AbjJCWLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 18:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241205AbjJCWLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 18:11:32 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CD4A1;
        Tue,  3 Oct 2023 15:11:28 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9b1ebc80d0aso260685766b.0;
        Tue, 03 Oct 2023 15:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696371087; x=1696975887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwfmzZmTkmxxJS6uLVFK/hJDI9dOhPuDmbdy9/UEN4k=;
        b=k2wpdmPnpWjF7oJdlPirN0/moX0NFL65kU2u7eAzgk5H6XQuP8nplulbr3clsf9SXj
         AucssOx/IXLsai3ITk9fYXvttJM9+tRvqbWoZmxIyK1GZ12iredZeBowrUC+8SV8i9Jx
         BcszPU5X/CZz0E+yPkGbI66q2rDs9yaY2wb0W71RJor+WY10OE/MWUl4VEzf+pGTgYhd
         Wg6o4L1DZkoPHYtxVC4nDZW23h91Lf3ocLDEx1KM6L4gwMUc0uTl/d0sUoRnpEgeb05v
         th0n0EiJGxqpdkLK5xLy63Q5gD445NXdiyLTtoXq4FnHAQbjvYd4EiqjY8/oMsWSH4+X
         d6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696371087; x=1696975887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NwfmzZmTkmxxJS6uLVFK/hJDI9dOhPuDmbdy9/UEN4k=;
        b=itqIDPp8n6IS0LluUcH1lPT3B6u14UjN2e+XLcQ4uYRroGMqpVnEVt/bykJivcdipn
         1y6Bi24fcRwQmacKcATqmTJBrWCLVUBQgJgaV+6fXAiPUEaPZnEr73grvm7x5ueTsGjr
         QgUeH7uWOhFOwS1jtqB7yRPXKacxJIIwkaMJcMfZw7pHYh/o+7Di+BQGaCGY5alJZQWA
         QXtKYQqzXbo0tPw506VWNJWbiVrdfRRRGThx8CWG6/krkvXo9BdpmJ8IDI8RXolj6MWU
         55YBR204CK6BaLmje26WHuWq8IOF+OeShktkx2B9Ri6OIxnE0lspuSiLGWwpd1zZDy6f
         B8bg==
X-Gm-Message-State: AOJu0Yz/rKixA64A3qQKcfvWIkgGIMq//HkE0282JEoS28D51jKGHqgl
        Grdqe1mjESfCFFiy9Vwqrn0rS997DEG3p9kmQTo=
X-Google-Smtp-Source: AGHT+IGjAcqAulJJqUO3QyO9rB/A5TFQSmSYm5cJLN5VuTFzhp6QqiOiE03L/C40OvkYVZfeGNFi0hS0Hfb6Rs4S8L4=
X-Received: by 2002:a17:907:2cef:b0:9ae:6355:5ef4 with SMTP id
 hz15-20020a1709072cef00b009ae63555ef4mr395664ejc.3.1696371087041; Tue, 03 Oct
 2023 15:11:27 -0700 (PDT)
MIME-Version: 1.0
References: <20231002135242.247536-1-asavkov@redhat.com>
In-Reply-To: <20231002135242.247536-1-asavkov@redhat.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 3 Oct 2023 15:11:15 -0700
Message-ID: <CAEf4BzbM1z-ccRq-gH7UkVrSa6Vhewu3R7wV3sHW6BKxhm9k2Q@mail.gmail.com>
Subject: Re: [RFC PATCH] tracing: change syscall number type in struct syscall_trace_*
To:     Artem Savkov <asavkov@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 2, 2023 at 6:53=E2=80=AFAM Artem Savkov <asavkov@redhat.com> wr=
ote:
>
> linux-rt-devel tree contains a patch that adds an extra member to struct

can you please point to the patch itself that makes that change?

> trace_entry. This causes the offset of args field in struct
> trace_event_raw_sys_enter be different from the one in struct
> syscall_trace_enter:
>
> struct trace_event_raw_sys_enter {
>         struct trace_entry         ent;                  /*     0    12 *=
/
>
>         /* XXX last struct has 3 bytes of padding */
>         /* XXX 4 bytes hole, try to pack */
>
>         long int                   id;                   /*    16     8 *=
/
>         long unsigned int          args[6];              /*    24    48 *=
/
>         /* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */
>         char                       __data[];             /*    72     0 *=
/
>
>         /* size: 72, cachelines: 2, members: 4 */
>         /* sum members: 68, holes: 1, sum holes: 4 */
>         /* paddings: 1, sum paddings: 3 */
>         /* last cacheline: 8 bytes */
> };
>
> struct syscall_trace_enter {
>         struct trace_entry         ent;                  /*     0    12 *=
/
>
>         /* XXX last struct has 3 bytes of padding */
>
>         int                        nr;                   /*    12     4 *=
/
>         long unsigned int          args[];               /*    16     0 *=
/
>
>         /* size: 16, cachelines: 1, members: 3 */
>         /* paddings: 1, sum paddings: 3 */
>         /* last cacheline: 16 bytes */
> };
>
> This, in turn, causes perf_event_set_bpf_prog() fail while running bpf
> test_profiler testcase because max_ctx_offset is calculated based on the
> former struct, while off on the latter:
>
>   10488         if (is_tracepoint || is_syscall_tp) {
>   10489                 int off =3D trace_event_get_offsets(event->tp_eve=
nt);
>   10490
>   10491                 if (prog->aux->max_ctx_offset > off)
>   10492                         return -EACCES;
>   10493         }
>
> This patch changes the type of nr member in syscall_trace_* structs to
> be long so that "args" offset is equal to that in struct
> trace_event_raw_sys_enter.
>
> Signed-off-by: Artem Savkov <asavkov@redhat.com>
> ---
>  kernel/trace/trace.h          | 4 ++--
>  kernel/trace/trace_syscalls.c | 7 ++++---
>  2 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 77debe53f07cf..cd1d24df85364 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -135,13 +135,13 @@ enum trace_type {
>   */
>  struct syscall_trace_enter {
>         struct trace_entry      ent;
> -       int                     nr;
> +       long                    nr;
>         unsigned long           args[];
>  };
>
>  struct syscall_trace_exit {
>         struct trace_entry      ent;
> -       int                     nr;
> +       long                    nr;
>         long                    ret;
>  };
>
> diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.=
c
> index de753403cdafb..c26939119f2e4 100644
> --- a/kernel/trace/trace_syscalls.c
> +++ b/kernel/trace/trace_syscalls.c
> @@ -101,7 +101,7 @@ find_syscall_meta(unsigned long syscall)
>         return NULL;
>  }
>
> -static struct syscall_metadata *syscall_nr_to_meta(int nr)
> +static struct syscall_metadata *syscall_nr_to_meta(long nr)
>  {
>         if (IS_ENABLED(CONFIG_HAVE_SPARSE_SYSCALL_NR))
>                 return xa_load(&syscalls_metadata_sparse, (unsigned long)=
nr);
> @@ -132,7 +132,8 @@ print_syscall_enter(struct trace_iterator *iter, int =
flags,
>         struct trace_entry *ent =3D iter->ent;
>         struct syscall_trace_enter *trace;
>         struct syscall_metadata *entry;
> -       int i, syscall;
> +       int i;
> +       long syscall;
>
>         trace =3D (typeof(trace))ent;
>         syscall =3D trace->nr;
> @@ -177,7 +178,7 @@ print_syscall_exit(struct trace_iterator *iter, int f=
lags,
>         struct trace_seq *s =3D &iter->seq;
>         struct trace_entry *ent =3D iter->ent;
>         struct syscall_trace_exit *trace;
> -       int syscall;
> +       long syscall;
>         struct syscall_metadata *entry;
>
>         trace =3D (typeof(trace))ent;
> --
> 2.41.0
>
>
