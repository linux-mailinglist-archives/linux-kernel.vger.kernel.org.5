Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E5477C942
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 10:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbjHOIS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 04:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235645AbjHOISK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 04:18:10 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3EA1703
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 01:18:08 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-40c72caec5cso159401cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 01:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692087488; x=1692692288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfx88hBPKZgPUMvxISVxhC4/bacIhL+OUFTRzij75sk=;
        b=uz5vKcLfOJjqDmAyfm2IEdzijabG0Xp1WNQCuij9+PfWa0FJl1E2VDEks2CAQqmAS+
         xzisEwZKh0McrILZOeFsfjAUSmOrimNc7uRbu3VUsJMB3HinZHtiEd+b5G1Y3pwg7T+t
         SmpH7lYYuOUMjmTbTK5bTsGILm2AUZf2w6aa1pvz88cdgycLS1e5TENiOmbu0YNZ0jpR
         Bit03HWL0x2GYaBFMAswrGAETv1jH7n70KiwN10hwDlQGPC5QSUFF2s2e4Falb7uJN5p
         2oyyJSsU5BI+DlZ4yVPiitSUKe2xiVCEKJFPWR4v70YrF2gEZtwxVqwbWuVFdta2mI8Q
         3cqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692087488; x=1692692288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xfx88hBPKZgPUMvxISVxhC4/bacIhL+OUFTRzij75sk=;
        b=CHllFOBlYWAyujP7hIuC2AtOdWf3mc5Sa1cmd/QejceQkbAtSNUyiR9DbLauEaKox4
         4b86f7eJoaX4EaVeGdzbWJIUXMUJW+xye2K4q8ZnnajjytZnBv6ihZbgdoPtE4i0O1Ep
         0JxnkaTc7qRxd1ty2VaDvHgg9PfdqGuhsvSlhZaWAqFwWLz9tLi/20p2ouTDB5EWBpa9
         4J6qJ3T2qDNS1zgPHzzSeEGm+AAqnM1RbkvpidoP3fqXRq7d8/dKJ23DznmiInEeHCva
         sM5JcukmtjwiFidfw/1QPG+ZshxgoGf3kIcjzsnd+K1Ko938LnAY9iE+hNfhHiAv3kcN
         UXIw==
X-Gm-Message-State: AOJu0Yx4eLRmoBgYixTusvn2RVgCL5m1yAKssA7PQOlXFRKfLFfin1j6
        SP2zoCCXqzbRfTM6o6Tv5qXov9uiKxsqRYljwMgdCQ==
X-Google-Smtp-Source: AGHT+IHfpEwzrg+6FEwcZbZfspvqiNJDjiRo2MM7TkJ8cDjquKsEV3WAqpz9fyz08FnAbuI/ezAv8YDZp/mbcA0Y9wo=
X-Received: by 2002:a05:622a:10d:b0:3f4:f0fd:fe7e with SMTP id
 u13-20020a05622a010d00b003f4f0fdfe7emr774886qtw.3.1692087487706; Tue, 15 Aug
 2023 01:18:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230811025822.3859771-1-namhyung@kernel.org> <20230811025822.3859771-2-namhyung@kernel.org>
In-Reply-To: <20230811025822.3859771-2-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 15 Aug 2023 01:17:55 -0700
Message-ID: <CAP-5=fWJuw0GKFqWcX8TA2hW8WbgXORzyJoYJex=AFNYZpKxOg@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf test: Add perf record sample filtering test
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>
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

On Thu, Aug 10, 2023 at 7:58=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
>   $ sudo ./perf test 'sample filter' -v
>    94: perf record sample filtering (by BPF) tests                     :
>   --- start ---
>   test child forked, pid 3817527
>   Checking BPF-filter privilege
>   Basic bpf-filter test
>   Basic bpf-filter test [Success]
>   Failing bpf-filter test
>   Error: task-clock event does not have PERF_SAMPLE_CPU
>   Failing bpf-filter test [Success]
>   Group bpf-filter test
>   Error: task-clock event does not have PERF_SAMPLE_CPU
>   Error: task-clock event does not have PERF_SAMPLE_CODE_PAGE_SIZE
>   Group bpf-filter test [Success]
>   test child finished with 0
>   ---- end ----
>   perf record sample filtering (by BPF) tests: Ok
>
> Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/record_bpf_filter.sh | 128 ++++++++++++++++++++
>  1 file changed, 128 insertions(+)
>  create mode 100755 tools/perf/tests/shell/record_bpf_filter.sh
>
> diff --git a/tools/perf/tests/shell/record_bpf_filter.sh b/tools/perf/tes=
ts/shell/record_bpf_filter.sh
> new file mode 100755
> index 000000000000..e76ea861b92c
> --- /dev/null
> +++ b/tools/perf/tests/shell/record_bpf_filter.sh
> @@ -0,0 +1,128 @@
> +#!/bin/sh
> +# perf record sample filtering (by BPF) tests
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -e
> +
> +err=3D0
> +perfdata=3D$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> +
> +cleanup() {
> +  rm -f "${perfdata}"
> +  rm -f "${perfdata}".old
> +  trap - EXIT TERM INT
> +}
> +
> +trap_cleanup() {
> +  cleanup
> +  exit 1
> +}
> +trap trap_cleanup EXIT TERM INT
> +
> +test_bpf_filter_priv() {
> +  echo "Checking BPF-filter privilege"
> +
> +  if [ "$(id -u)" !=3D 0 ]
> +  then
> +    echo "bpf-filter test [Skipped permission]"
> +    err=3D2
> +    return
> +  fi
> +  if ! perf record -e task-clock --filter 'period > 1' \
> +         -o /dev/null --quiet true 2>&1
> +  then
> +    echo "bpf-filter test [Skipped missing BPF support]"
> +    err=3D2
> +    return
> +  fi
> +}
> +
> +test_bpf_filter_basic() {
> +  echo "Basic bpf-filter test"
> +
> +  if ! perf record -e task-clock -c 10000 --filter 'ip < 0xffffffff00000=
000' \
> +         -o "${perfdata}" true 2> /dev/null
> +  then
> +    echo "Basic bpf-filter test [Failed record]"
> +    err=3D1
> +    return
> +  fi
> +  if perf script -i "${perfdata}" -F ip | grep 'ffffffff[0-9a-f]*'
> +  then
> +    echo "Basic bpf-filter test [Failed invalid output]"
> +    err=3D1
> +    return
> +  fi
> +  echo "Basic bpf-filter test [Success]"
> +}
> +
> +test_bpf_filter_fail() {
> +  echo "Failing bpf-filter test"
> +
> +  # 'cpu' requires PERF_SAMPLE_CPU flag
> +  if ! perf record -e task-clock --filter 'cpu > 0' \
> +         -o /dev/null true 2>&1 | grep PERF_SAMPLE_CPU
> +  then
> +    echo "Failing bpf-filter test [Failed forbidden CPU]"
> +    err=3D1
> +    return
> +  fi
> +
> +  if ! perf record --sample-cpu -e task-clock --filter 'cpu > 0' \
> +         -o /dev/null true 2>/dev/null
> +  then
> +    echo "Failing bpf-filter test [Failed should succeed]"
> +    err=3D1
> +    return
> +  fi
> +
> +  echo "Failing bpf-filter test [Success]"
> +}
> +
> +test_bpf_filter_group() {
> +  echo "Group bpf-filter test"
> +
> +  if ! perf record -e task-clock --filter 'period > 1000 || ip > 0' \
> +         -o /dev/null true 2>/dev/null
> +  then
> +    echo "Group bpf-filter test [Failed should succeed]"
> +    err=3D1
> +    return
> +  fi
> +
> +  if ! perf record -e task-clock --filter 'cpu > 0 || ip > 0' \
> +         -o /dev/null true 2>&1 | grep PERF_SAMPLE_CPU
> +  then
> +    echo "Group bpf-filter test [Failed forbidden CPU]"
> +    err=3D1
> +    return
> +  fi
> +
> +  if ! perf record -e task-clock --filter 'period > 0 || code_pgsz > 409=
6' \
> +         -o /dev/null true 2>&1 | grep PERF_SAMPLE_CODE_PAGE_SIZE
> +  then
> +    echo "Group bpf-filter test [Failed forbidden CODE_PAGE_SIZE]"
> +    err=3D1
> +    return
> +  fi
> +
> +  echo "Group bpf-filter test [Success]"
> +}
> +
> +
> +test_bpf_filter_priv
> +
> +if [ $err =3D 0 ]; then
> +  test_bpf_filter_basic
> +fi
> +
> +if [ $err =3D 0 ]; then
> +  test_bpf_filter_fail
> +fi
> +
> +if [ $err =3D 0 ]; then
> +  test_bpf_filter_group
> +fi
> +
> +cleanup
> +exit $err
> --
> 2.41.0.640.ga95def55d0-goog
>
