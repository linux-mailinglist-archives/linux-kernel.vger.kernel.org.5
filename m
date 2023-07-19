Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A49B75A1F2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 00:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjGSWb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 18:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjGSWb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 18:31:57 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFF92103
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 15:31:53 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-345bc4a438fso28275ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 15:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689805913; x=1692397913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hiNsp140u/z6iaEw6m3evD3OsE+pjKNY88u57By7+DM=;
        b=MWnmjKVm7AYL27gaU9Vyk22i9b/I03CZ2m3162rteHKQ0h6PQ+eQJFrnU0gdW5S/sA
         5AYA+Ot2dAes2ZoyaFtHJAF4VQEcJi/hoVusA+yjI0PkWr1tHKUKOFjV4UEWtz1A3A6W
         CrpAB9k8A9M1BD7vJc4NnwGswA1YlfSR43p2qYT7m9VUunZ9wMZ1TmpnRI3KJoSd038Z
         iSYhj4Dw6FFxF+vlId7PlFyh/0kSZisDo0les+2TgUsfW8XuluThywlb8lMddoFHASY8
         IJvJtWZ5guTPqByisvww8eb9QnENwIe2I2lJaf578Sul9C79FIXW7Qzqkf98klTH6NyN
         5eeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689805913; x=1692397913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hiNsp140u/z6iaEw6m3evD3OsE+pjKNY88u57By7+DM=;
        b=XafwUSCVjubIMo13N6KK1bppd0caR7dI8rOMt82Y4oLHFe0j8rPjFgulf8nWQfpd1n
         41bi/T8NhxFNQJDEmA2XhQKCcljhi1k53dJGT6ETkZOCN59EmdOwtVbqO1QVLThVh9i2
         aQsBkb5rw1th0Kw4UTVY+8e6Xt8VNN0Xer6GsrnNOgnoJRI5y1+7zRNaj2e7sWT2fnmR
         9999Ei9MXtIL01sBwoQCw0mXY5BMklIvGZGW2m8UYRPI3F+xLR37kLzbA8bxQv/BKEPA
         LYMW8znwuKdXitM4VUFMbHZgn8rFhkfGHnFHocYHq9189GrDWWAuvQKAnGwXofjpaMXz
         CR2g==
X-Gm-Message-State: ABy/qLbhpMlbKv0o8wijEA7bgL9NiII50bpok4N9KjIsdLZKa+kCiGsb
        PmYjKYPA69I2IloVYmn8O3zdh3RDvTyR0XHH7Okflg==
X-Google-Smtp-Source: APBJJlH9BzVTG/2sfDIAuUfdaGvxpNlVQtgmXmW6P6EhWaGK5HeN313qhFDPSDiTYWH9S+nNpyiNfOADKTIwVEXEmgw=
X-Received: by 2002:a05:6e02:1ba3:b0:346:9c8:b011 with SMTP id
 n3-20020a056e021ba300b0034609c8b011mr37657ili.19.1689805912815; Wed, 19 Jul
 2023 15:31:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230719202951.534582-1-acme@kernel.org> <20230719202951.534582-3-acme@kernel.org>
In-Reply-To: <20230719202951.534582-3-acme@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 19 Jul 2023 15:31:41 -0700
Message-ID: <CAP-5=fV3Er=Ek8=iE=bSGbEBmM56_PJffMWot1g_5Bh8B5hO7A@mail.gmail.com>
Subject: Re: [PATCH 2/6] perf thread: Allow tools to register a thread->priv destructor
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 1:30=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> So that when thread__delete() runs it can be called and free stuff tools
> stashed into thread->priv, like 'perf trace' does and will use this
> new facility to plug some leaks.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/thread.c | 11 +++++++++++
>  tools/perf/util/thread.h |  2 ++
>  2 files changed, 13 insertions(+)
>
> diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
> index 0b166404c5c365cf..35dd4e716e411da9 100644
> --- a/tools/perf/util/thread.c
> +++ b/tools/perf/util/thread.c
> @@ -80,6 +80,13 @@ struct thread *thread__new(pid_t pid, pid_t tid)
>         return NULL;
>  }
>
> +static void (*thread__priv_destructor)(void *priv);
> +
> +void thread__set_priv_destructor(void (*destructor)(void *priv))
> +{

Perhaps:
assert(thread__priv_destructor =3D=3D NULL);

To make it clear that there should never be >1 currently.

> +       thread__priv_destructor =3D destructor;
> +}
> +
>  void thread__delete(struct thread *thread)
>  {
>         struct namespaces *namespaces, *tmp_namespaces;
> @@ -112,6 +119,10 @@ void thread__delete(struct thread *thread)
>         exit_rwsem(thread__namespaces_lock(thread));
>         exit_rwsem(thread__comm_lock(thread));
>         thread__free_stitch_list(thread);
> +
> +       if (thread__priv_destructor)
> +               thread__priv_destructor(thread__priv(thread));
> +
>         RC_CHK_FREE(thread);
>  }
>
> diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
> index 9068a21ce0fa1b0f..e79225a0ea46b789 100644
> --- a/tools/perf/util/thread.h
> +++ b/tools/perf/util/thread.h
> @@ -71,6 +71,8 @@ struct thread *thread__new(pid_t pid, pid_t tid);
>  int thread__init_maps(struct thread *thread, struct machine *machine);
>  void thread__delete(struct thread *thread);
>
> +void thread__set_priv_destructor(void (*destructor)(void *priv));
> +
>  struct thread *thread__get(struct thread *thread);
>  void thread__put(struct thread *thread);
>
> --
> 2.41.0
>
