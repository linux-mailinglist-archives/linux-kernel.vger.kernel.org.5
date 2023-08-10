Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844067782F8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 23:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjHJV5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 17:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjHJV5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 17:57:43 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374E9ED
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 14:57:43 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-40a47e8e38dso38961cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 14:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691704662; x=1692309462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7oVBO46MdvBouc4bVPGr2lcvlmkwA8Kbpr6KZMzD/Q=;
        b=EX1b72NLdvMfLeeNVzu6CWeu/jBvz/LB/WWNSPy5gcJ6sGd1YwBbQQ2FqY/Bqk1eTR
         rJCjxkswJ/rHp2bolxYQc1Z1bHfXOdIeZKFYB+QmJ/bqXNAoYcH4BzgMz9HDjaSO3ALj
         Uxs0uYcxOsEn2PvN2WT0y4Pi7kFuN/HqUp7WrBUSzCHUn2rCHUG1jK5f0uJ2k1a0zOJ8
         rl3mdFgH4MdvZh5WdToBm0Pjx+ykyQzrXGjx8K3cZnCQRPyZxujb/P+OC9+5jndmE4F9
         zSU3JfY1j5LE3oYVmie8XTKKg/fUtWtodKzFkY+fWA/LBMKlQEhImZaN9yense6Izzjz
         eM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691704662; x=1692309462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7oVBO46MdvBouc4bVPGr2lcvlmkwA8Kbpr6KZMzD/Q=;
        b=WbmyeWH5hdQIrbblpKOtd0DF5tJPuHJXhutNVNQBioI63lQdYqPewBfszrarWgtL+4
         4Ye8/t/LqW2Qgmbehku7VxEXdwiEy9yGWAI2aYUraPK9o7/J1kNR9JGAqF44KP6z8OLZ
         m/IDNrckG5bIv0iA0TcCd+ld8ua5i9F+0ukWfYs5r9mb4ZmDL071WA4mmJjtMajfNOFY
         bfnoVUEmy79pDvp04Pg6TEB9KFtHmr2wnxwcyeTcuxKOSkcN6aX4XPdW5CPbXqn/cIFg
         WDnnpPIkK76z7ViaeMjzqSvaT9Uos7xoohY+bpWFDxtOWtCIajLzyAGWpQEitwQ10hdL
         L9Ew==
X-Gm-Message-State: AOJu0YyZl+jx5VkkUPkZt30Rl1teJxdZuCP5pj1yionp6o2amTf4zS3J
        +Y0L0u5iRXBRIqR+rJgfu+LXLY43JOt2tYVeQPBe4g==
X-Google-Smtp-Source: AGHT+IGAiOgGrzCgz/wcjCbXBfQrmbwf3xAVg409lsFFw29pn8BCBKKekly/gBmDNRR6B5JYxXsbjnup+xkiDPBwJJU=
X-Received: by 2002:ac8:7f86:0:b0:403:96e3:4745 with SMTP id
 z6-20020ac87f86000000b0040396e34745mr83317qtj.20.1691704662282; Thu, 10 Aug
 2023 14:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <ZM0mzpQktHnhXJXr@kernel.org>
In-Reply-To: <ZM0mzpQktHnhXJXr@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 10 Aug 2023 14:57:30 -0700
Message-ID: <CAP-5=fXciFqoqwF7Om_y+RZK19GKsfQhQJLsH9WXhaKbuvLEOQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf probe: Free string returned by
 synthesize_perf_probe_point() on failure in synthesize_perf_probe_command()
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 4, 2023 at 9:27=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> Building perf with EXTRA_CFLAGS=3D"-fsanitize=3Daddress" a leak was detec=
ted
> elsewhere and lead to an audit, where we found that
> synthesize_perf_probe_command() may leak synthesize_perf_probe_point()
> return on failure, fix it.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: https://lore.kernel.org/lkml/
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/probe-event.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.=
c
> index c7bfeab610a3679a..2835d87cb97771f9 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -2063,14 +2063,18 @@ char *synthesize_perf_probe_command(struct perf_p=
robe_event *pev)
>                         goto out;
>
>         tmp =3D synthesize_perf_probe_point(&pev->point);
> -       if (!tmp || strbuf_addstr(&buf, tmp) < 0)
> +       if (!tmp || strbuf_addstr(&buf, tmp) < 0) {
> +               free(tmp);
>                 goto out;
> +       }
>         free(tmp);
>
>         for (i =3D 0; i < pev->nargs; i++) {
>                 tmp =3D synthesize_perf_probe_arg(pev->args + i);
> -               if (!tmp || strbuf_addf(&buf, " %s", tmp) < 0)
> +               if (!tmp || strbuf_addf(&buf, " %s", tmp) < 0) {
> +                       free(tmp);
>                         goto out;
> +               }
>                 free(tmp);
>         }
>
> --
> 2.37.1
>
