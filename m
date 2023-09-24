Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF987ACB36
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 20:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjIXSDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 14:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXSDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 14:03:41 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E760FC
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 11:03:34 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-41513d2cca7so316651cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 11:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695578613; x=1696183413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFnymHRtoiSLSE6xlXlPfUo1MSdkdwnizEDkqFjEp5M=;
        b=0N12PufIVMADzpR5JvZrVR1zBlw3XeOS0LiFKjxachJfNLZIhXtRQzCDpapBxqeN/N
         KOc1wyj3fz/Ng9libyDmqF6fKVTpgF0ldnPHb18GIKQM16jZZNFrlfv3OeSGIOETR1z9
         z92OZJSBn9IweU/o5n5BizcPtqgTRoFKwvVaRp7S1Bt2dDx4rjb9wijBUs8QF0E6IILx
         F138fTwNd1RBoe8crEm1bo7VibmUQmvqR4u+WTZwDdCNgQ6UW2KOVJqpR0Z8CvqBbWWw
         gFyjKrPTbPDIdHj9cBQ7wvqW3ADh+w10ULYMN3MDx3EAo0ciOjqkkUQtHO62iCSSSgOn
         Vaqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695578613; x=1696183413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFnymHRtoiSLSE6xlXlPfUo1MSdkdwnizEDkqFjEp5M=;
        b=CsL8bLggbOo84IyjnSejR+eAeehviTPdK8mHjn3qRREMn4PiacMPlkLFtTkuqASq81
         HY3wf8LqAJu5WtYPW+mSCuybLNqyX1zvF6WrqwHndq+OroD+gPW6sq974eH7FIqiK+Dy
         D7I4lpmsy5qPbqY3N1d3d0+9ktJa7vJCuK/s+pQMEhLcxQnWFLEN53z85QMsCcVown/P
         NbgflyMXM7QWhkxtOdPUiPfx3RkQclPjhVx6uC+di8Uq+NYFxl5iuDTib9XUmT3jvDLn
         8rZK+IWTHakXCo56iTFnPTHQWSmkIJH9gJW6FQbWwCak2kBuTpvqNZJethuWzv+lpeXm
         5QqQ==
X-Gm-Message-State: AOJu0YzuorKKM+WEMogCxA4HVqDYnRliwiG+TKgoBN+A5NaYD1jWKlmx
        YjtSsiiUXNVuaT/V3eMeuhIibNKnPRXlgOnPPsuimg==
X-Google-Smtp-Source: AGHT+IF1Z2oLq9smh2qhEPC193F5fqkRC6B/tsHivKcbUv1O+Mhj/WxhnsnegPuh58Fu+zugRoFHFRSC8frjQTSIMog=
X-Received: by 2002:a05:622a:111:b0:3f0:af20:1a37 with SMTP id
 u17-20020a05622a011100b003f0af201a37mr308189qtw.15.1695578613246; Sun, 24 Sep
 2023 11:03:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230922234444.3115821-1-namhyung@kernel.org>
In-Reply-To: <20230922234444.3115821-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 24 Sep 2023 11:03:20 -0700
Message-ID: <CAP-5=fVMdX+vLPNBSe-8arKGvAGcdgHGt7ypEX-J-SZpUi2PGg@mail.gmail.com>
Subject: Re: [PATCH] perf record: Fix BTF type checks in the off-cpu profiling
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 4:44=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> The BTF func proto for a tracepoint has one more argument than the
> actual tracepoint function since it has a context argument at the
> begining.  So it should compare to 5 when the tracepoint has 4
> arguments.
>
>   typedef void (*btf_trace_sched_switch)(void *, bool, struct task_struct=
 *, struct task_struct *, unsigned int);
>
> Also, recent change in the perf tool would use a hand-written minimal
> vmlinux.h to generate BTF in the skeleton.  So it won't have the info
> of the tracepoint.  Anyway it should use the kernel's vmlinux BTF to
> check the type in the kernel.
>
> Fixes: b36888f71c85 ("perf record: Handle argument change in sched_switch=
")
> Cc: Song Liu <song@kernel.org>
> Cc: Hao Luo <haoluo@google.com>
> CC: bpf@vger.kernel.org
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

> ---
>  tools/perf/util/bpf_off_cpu.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.=
c
> index 01f70b8e705a..21f4d9ba023d 100644
> --- a/tools/perf/util/bpf_off_cpu.c
> +++ b/tools/perf/util/bpf_off_cpu.c
> @@ -98,7 +98,7 @@ static void off_cpu_finish(void *arg __maybe_unused)
>  /* v5.18 kernel added prev_state arg, so it needs to check the signature=
 */
>  static void check_sched_switch_args(void)
>  {
> -       const struct btf *btf =3D bpf_object__btf(skel->obj);
> +       const struct btf *btf =3D btf__load_vmlinux_btf();
>         const struct btf_type *t1, *t2, *t3;
>         u32 type_id;
>
> @@ -116,7 +116,8 @@ static void check_sched_switch_args(void)
>                 return;
>
>         t3 =3D btf__type_by_id(btf, t2->type);
> -       if (t3 && btf_is_func_proto(t3) && btf_vlen(t3) =3D=3D 4) {
> +       /* btf_trace func proto has one more argument for the context */
> +       if (t3 && btf_is_func_proto(t3) && btf_vlen(t3) =3D=3D 5) {
>                 /* new format: pass prev_state as 4th arg */

nit: does this comment need updating?

>                 skel->rodata->has_prev_state =3D true;
>         }
> --
> 2.42.0.515.g380fc7ccd1-goog
>
