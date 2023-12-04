Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D678803E1C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbjLDTLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234965AbjLDTLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:11:01 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326BCAB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 11:11:08 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50beed2a46eso445e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 11:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701717066; x=1702321866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVSNr1Qot00fXFMvviV2konhIWgpkJd6arMvwOKUXZQ=;
        b=LcC4xhGrxScAfPw759dioNUG3N8Py6uN5JUzcJS7LHSxtKuEDd66x+MKFLdmw1qOL7
         PiellQUqT/Ty1qcIvth/a3kS50L73LJYAuyOmAfiv9uIpmYN8VvLioQJkXT/RpSKK5mU
         kQ6EczhzP6DPAf6ffJqHDntAvcA/eYiTvGZQ+XdrzNI74fS/7SrlXpokxAUxjQ88wkIx
         g4peC04WLqqbxcYy6GlVoxoLbw3imUExgxvw/sYGqZk1hfpTEEGzxKcOdXNRplqoZSse
         h7ENQNG1q+ZuJZv2f4lhK8d/RaA9lvfHhPg38xdiL3lCUB9VyOCkxdpVQv6QtTnnRFmq
         uKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701717066; x=1702321866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NVSNr1Qot00fXFMvviV2konhIWgpkJd6arMvwOKUXZQ=;
        b=dhJORkcpREsKfdxQeigXsy3cJdAW5W0lx9NxjKlfHYtJfwn+fgYrpKGnWM5iM0KTkN
         eg1PzvNm+cPpqGQlboMyzwahyWqCHEFwh26BMuVB9S31czFYK38JScrr0RR0/lPp7YWA
         mEOAP5kohnmSYWIAcMzdStaKhg4ui8d3npdficLZFfdm+EZvUEu7SfGBXuElmQsFERRH
         7dByP8rgoVP6RH3lZkB8iaD2Er+XeR57fshL/3BUSpfHf7nBaVQuMbm6A61Com30TmDp
         IDJgwTlgeSmpGunOoU4ZpZseV6/GrpSMlCEYGFR0CLO1ezfwkYoLTwn6HcsiCvOz2rrV
         rKew==
X-Gm-Message-State: AOJu0Yyio+XV4JN+XiKKdyO5HNu+ANjPOT18tTmRdJ679QEEA0s5Z7Hz
        Urs9bQq3Qm1hDd+ulaRsXYS40fmEi6G15O66F4H5uA==
X-Google-Smtp-Source: AGHT+IFbZXqoGl/WdTMR7T1nW5A9qFR+v28+geM54U7dMEdA4nWpaQuSsrDolKMUo4O6BUGaMsu/bSyVe8dHQBeIMJE=
X-Received: by 2002:a05:6512:12c4:b0:50b:fc76:42c with SMTP id
 p4-20020a05651212c400b0050bfc76042cmr75442lfg.2.1701717066213; Mon, 04 Dec
 2023 11:11:06 -0800 (PST)
MIME-Version: 1.0
References: <20231201203046.486596-1-acme@kernel.org>
In-Reply-To: <20231201203046.486596-1-acme@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 4 Dec 2023 11:10:54 -0800
Message-ID: <CAP-5=fWJMcJb0+Nmkd1=HoOc5j7LEzGkJmqyAgdpfekOJtjybg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Cache the arch specific stderrno routine
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 1, 2023 at 12:30=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> Hi,
>
>         Please take a look,
>
> - Arnaldo
>
> Arnaldo Carvalho de Melo (2):
>   perf env: Introduce perf_env__arch_strerrno()
>   perf env: Cache the arch specific strerrno function in perf_env__arch_s=
trerrno()

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>  tools/perf/builtin-trace.c                  | 6 ++----
>  tools/perf/trace/beauty/arch_errno_names.sh | 6 +++---
>  tools/perf/trace/beauty/beauty.h            | 2 --
>  tools/perf/util/env.c                       | 9 +++++++++
>  tools/perf/util/env.h                       | 6 ++++++
>  5 files changed, 20 insertions(+), 9 deletions(-)
>
> --
> 2.41.0
>
