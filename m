Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38DA751201
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 22:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbjGLUse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 16:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbjGLUs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 16:48:28 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51ACF1FFD
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 13:48:27 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-403b622101bso20921cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 13:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689194906; x=1691786906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckvfaMUWpPvTo3te2ghCH91a1cTE4BZA7za+DnJRfWc=;
        b=ihCoBZPfH+/EUMXvGA0hQEGZN+NjZH+19kjrsKmTU+8L8MLDyGD+DD1SRcO/+WgtDQ
         S/cuwlX5KK1TUg03WXllxL2RU+lerRIAn+nHyAr4T/O9eyGPMeRs25NqGIsBV8eN2Lem
         tRmebaizSAQb9laYuUYSfmI9wjSYAlpb8CnuWLVyA08PbT+ysnXNHetDnTUnya20Ak+b
         RhWiLGAukCdh+Pce9tauGU+JGgxCBMWbkCino2MwKjkFhuTcBrBQuLOVhOnwSq/VE+8H
         HK+lEwnizMuO+PUVt29ThSy+u9mScgHWUH+fgL4HdkdbK7BXpZnzrjyZHFHM9GL+9SVL
         mEcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689194906; x=1691786906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ckvfaMUWpPvTo3te2ghCH91a1cTE4BZA7za+DnJRfWc=;
        b=hqySr7o4cQ3LN5+ViL+9NK2UptiF0vZ7DtMcfZJHIVg4eyKaYNT++ZIv0mdtZdB/1S
         kizEWOSqwu3WNxuHFpmt96JtHDOEnw8oZr4odo72QiZwwb8GOm23N1no7iDk99Seglzy
         sF0Ro3LeHVxKyOQt+YcC6ozSZokLBng6bjHTtGds4/Mhm82CF5+qbzuCjD6G+h1/9+7U
         RZRShLoAECo+THzFm+wZ8jCJZw26MM+u8JS0gqFNsIsu5TUXPbzWPU+/ivWjjMasqCyW
         mVOLyAsGyNetyJ0i0jh+xVhN5gRzX/PEBSjmNiJZwv2LnKMbJ4Nl3Ji4bS4jzCBybLur
         Ohdg==
X-Gm-Message-State: ABy/qLZB3yEk9q2lQ4b0pHuheBSY7setC3S+G77JTGnaTe+VYEKrTHMR
        hfxLHW535DzJlKA+LtTztM6xdSMgc8AWR9NmRRd29w==
X-Google-Smtp-Source: APBJJlGKu9LJh5fJZUzLj9OH8ENDKvSNndC0BxMA80bWvU95D5HbkN8J1w8FijCQRcgyer/1smSRlempjC8RMfjpxHY=
X-Received: by 2002:ac8:5905:0:b0:3ef:302c:319e with SMTP id
 5-20020ac85905000000b003ef302c319emr357520qty.8.1689194906296; Wed, 12 Jul
 2023 13:48:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230704074217.240939-1-yangjihong1@huawei.com> <20230704074217.240939-5-yangjihong1@huawei.com>
In-Reply-To: <20230704074217.240939-5-yangjihong1@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 12 Jul 2023 13:48:14 -0700
Message-ID: <CAP-5=fVv5C75xy-kMRfssCGd6syx5H1FKe1xs2K_+xQhQVJQPA@mail.gmail.com>
Subject: Re: [PATCH 4/5] perf test: Add test case for record tracking
To:     Yang Jihong <yangjihong1@huawei.com>, adrian.hunter@intel.com
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, kan.liang@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 4, 2023 at 12:44=E2=80=AFAM Yang Jihong <yangjihong1@huawei.com=
> wrote:
>
> Add a new test case to record tracking side-band events for all CPUs when
> tracing selected CPUs

We're using "tracking" and "sideband" as synonyms, I think it would be
clearer to just use "sideband" and not use "tracking". I see both
terms in tools/perf/Documentation/perf-intel-pt.txt

Would it be possible to get some consistency here?

Thanks,
Ian

> Test result:
>
>   # ./perf test list 2>&1 | grep 'perf record tracking tests'
>    95: perf record tracking tests
>   f# ./perf test 95
>    95: perf record tracking tests                                      : =
Ok
>
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
>  tools/perf/tests/shell/record_tracking.sh | 44 +++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100755 tools/perf/tests/shell/record_tracking.sh
>
> diff --git a/tools/perf/tests/shell/record_tracking.sh b/tools/perf/tests=
/shell/record_tracking.sh
> new file mode 100755
> index 000000000000..fe05f4772999
> --- /dev/null
> +++ b/tools/perf/tests/shell/record_tracking.sh
> @@ -0,0 +1,44 @@
> +#!/bin/sh
> +# perf record tracking tests
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -e
> +
> +err=3D0
> +perfdata=3D$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> +
> +can_cpu_wide()
> +{
> +    if ! perf record -o ${perfdata} -BN --no-bpf-event -e dummy:u -C $1 =
true 2>&1 >/dev/null
> +    then
> +       echo "record tracking test [Skipped cannot record cpu$1]"
> +       err=3D2
> +    fi
> +
> +    rm -f ${perfdata}
> +    return $err
> +}
> +
> +test_system_wide_tracking()
> +{
> +    # Need CPU 0 and CPU 1
> +    can_cpu_wide 0 || return 0
> +    can_cpu_wide 1 || return 0
> +
> +    # Record on CPU 0 a task running on CPU 1
> +    perf record -BN --no-bpf-event -o ${perfdata} -e dummy:u -C 0 -- tas=
kset --cpu-list 1 true
> +
> +    # Should get MMAP events from CPU 1
> +    mmap_cnt=3D`perf script -i ${perfdata} --show-mmap-events -C 1 2>/de=
v/null | grep MMAP | wc -l`
> +
> +    rm -f ${perfdata}
> +
> +    if [ ${mmap_cnt} -gt 0 ] ; then
> +       return 0
> +    fi
> +
> +    echo "Failed to record MMAP events on CPU 1 when tracing CPU 0"
> +    return 1
> +}
> +
> +test_system_wide_tracking
> --
> 2.30.GIT
>
