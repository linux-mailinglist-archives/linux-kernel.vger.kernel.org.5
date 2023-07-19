Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE37675A1FD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 00:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjGSWeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 18:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjGSWef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 18:34:35 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9CF1FDC
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 15:34:34 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-346099c6f43so52545ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 15:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689806073; x=1692398073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lIbuVyN5d3NyUBHRaekU7xza2xcWELBLsfoZP8e9gNg=;
        b=2hxfLvUnWST1hw5GHv+xREoq79Syz2FB2qGP2KKuqS3JcgJ3VRnxxDA4HtD4TomoRS
         c8VbEXGK/dNFnd0BMqEcDL8zSJ4/ae7LyF3rhus4PkPJMdb+PXpiWcS1UoGu31hfRfHz
         TGQiRlYA2CPIWG1xhGptxv5gQW2pQ7HoTudYJOCjw//U0C9h96eWd1zm7UwTSJyL6kts
         0iZiz/lrqcMVDFAXiC6d3mxWEGV+FtGq3NierD9tZzc9UWyLGEC9aHrZhZdtDfYExC4r
         bUyr7rBPvEzyxg6af8CCWhUSkwoexwomx8FdiF6Q5ScCtJC6M7MOeOc7nUHcR+h+hoML
         L/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689806073; x=1692398073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lIbuVyN5d3NyUBHRaekU7xza2xcWELBLsfoZP8e9gNg=;
        b=ZlzUgT/j3AGDxEMoc3Rtm3nqahwARD1OddHWDXcp8JRSfWD8HVJmIds//VKEb0EfX6
         9L6xptpmvZti/0MWau2geFJEag2DoAvQzPys2zdcsaaf4fpyx9ScHcxwbBMkNqhstF8I
         Pemw7QL15LZWuqCVqVvfe9RUAK/AU2APjq+VcdYy9c6KUDK+Xu3Ir33+fxb/kE4cYe0R
         G04anvyfXxwynsztdbLo6QG9aCIS8RoLoO8GFFB+nucfvRWuZPdKhgMQ4PiQ4ksS7Q5t
         FieduRMe60hS1nq3AnnQXwJdiO0Pr9RHr5Wpa5L68gpP4Fd0riCHVpVhAXXBukmMI398
         ZOAA==
X-Gm-Message-State: ABy/qLYL74eZUnbFwG2InuRklif0OWAGXU7dbiLk/R/I/VJ2cHRxZUmR
        gjRikCneQj5Eo7Z++UmFpT9ueOF7WLrkE+GmjAKwEA==
X-Google-Smtp-Source: APBJJlG9jUMqVyvUlse88weKimxWs0pP1zXlRDmC++8lT6+P6hHKROIp/1otTP4crqWLUHpvTdqFVht2+4BxQnlXnOI=
X-Received: by 2002:a05:6e02:1789:b0:346:48bd:da43 with SMTP id
 y9-20020a056e02178900b0034648bdda43mr99530ilu.4.1689806073680; Wed, 19 Jul
 2023 15:34:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230719202951.534582-1-acme@kernel.org>
In-Reply-To: <20230719202951.534582-1-acme@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 19 Jul 2023 15:34:21 -0700
Message-ID: <CAP-5=fWj8ZgbYd2OX85LjW=Cd6jvF_tfqPdVELsTXHG+GebxRg@mail.gmail.com>
Subject: Re: [PATCHES 0/6] Fix some 'perf trace' leaks found with -fsanitize=address.
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
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

On Wed, Jul 19, 2023 at 1:30=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Hi,
>
>         Please review/ack, I put it as well on the tmp.perf-tools-next
> in the perf-tools-next tree:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/=
commit/?h=3Dtmp.perf-tools-next
>
> Best regards,
>
> - Arnaldo
>
> Arnaldo Carvalho de Melo (6):
>   perf evsel: Free evsel->filter on the destructor
>   perf thread: Allow tools to register a thread->priv destructor
>   perf trace: Register a thread priv destructor
>   perf trace: Really free the evsel->priv area
>   perf trace: Free thread_trace->files table
>   MAINTAINERS: Add git information for perf-tools and perf-tools-next
>     trees/branches

Series:
Acked-by: Ian Rogers <irogers@google.com>

I think patch 2 could use an extra assert to be extra safe.

Thanks,
Ian

>  MAINTAINERS                |  2 ++
>  tools/perf/builtin-trace.c | 38 +++++++++++++++++++++++++++++++-------
>  tools/perf/util/evsel.c    |  1 +
>  tools/perf/util/thread.c   | 11 +++++++++++
>  tools/perf/util/thread.h   |  2 ++
>  5 files changed, 47 insertions(+), 7 deletions(-)
>
> --
> 2.41.0
>
