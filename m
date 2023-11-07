Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065377E47CA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 19:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234703AbjKGSFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 13:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbjKGSFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 13:05:21 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3EAC0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 10:05:18 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so840a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 10:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699380317; x=1699985117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yuk46w2V/Xl/i9xklMeeYDERqTn6153Zwns9yWDprP8=;
        b=bEEeVTjqlhxkn1JQMvnhYvEdu5+RKmfK4yf+0GimP3t4STamJcbHnJoNep4OshucUt
         XUxzitUP7LFiOfH0FA1xjKcT9+61/zyJi3Oi4wJ4mPqG5VaFzT263bPODUFYt1H+lPjM
         G0mgpNfL71FPND6WRXHjLlKgg9bIM1vmezjFmOWZwVBmKpbgRKhj68YLjLblDGF1fuJz
         PAERiBNcNc7E72kSZJ7Phjlrvk4hRyDogm55wJvzt/aagecxxeODVLm6o2l3AfYx4rBq
         OKcb4ZZ77+UDmod9+kg2Dw1Jarsl0tPM3REKmj+ilNoLoYFrS7ndWMOhysVsNz/JSni+
         AYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699380317; x=1699985117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yuk46w2V/Xl/i9xklMeeYDERqTn6153Zwns9yWDprP8=;
        b=HlPZzho5AyjLRHeP4uQq/WZpgl9hcyGyzHJMpOrnWwXfWCsAUFOKQGYMtYqRshH3n+
         uA4D/8VhouLf68N1IZa+Y/TeOsY9whn4Kk0DfcXlTryDZWJtNZhQELbNBvvvuyt+wSp1
         IJjIQnLxdP3NkgzlJTO/W20ZXfj+qsaALz6X//ICl88X2ngsY8oPxZfkagczAmP4prqW
         XVe09DzARsbFKSSUmzwYNXCJ657/4tZFx1g36mcrNxuknsBCLh15JQ02fx9xnzP0UrbX
         zP8w6bAHkiDxcuJnegee5qVscsKUmozg+ymqtbn11lgPFtr0wo8GNdgoJAD/S+z94Zdh
         wZzQ==
X-Gm-Message-State: AOJu0Yw4JGexnqW0EPCnx7mLgBY0Y3RZeDEJnCk9800hUSmfJw8Pyg8Y
        p/A17EwA2Jb4fmUgxhWzZoVF6RI5BaQYtKU49vcfhQ==
X-Google-Smtp-Source: AGHT+IHcYS7GtPvNX7hZLxP4K2LXkgZbrrueOqy8lDarHjDOCNPLsT0Ib8Uu+aG+K/9kOk6TRzX6tpzQWLtVy+oGK7M=
X-Received: by 2002:a50:d081:0:b0:544:46e4:ef94 with SMTP id
 v1-20020a50d081000000b0054446e4ef94mr118936edd.5.1699380316801; Tue, 07 Nov
 2023 10:05:16 -0800 (PST)
MIME-Version: 1.0
References: <20231107174411.1496958-1-kan.liang@linux.intel.com>
In-Reply-To: <20231107174411.1496958-1-kan.liang@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 7 Nov 2023 10:05:05 -0800
Message-ID: <CAP-5=fWjXS43xBujQ2DOAeo41WX5L4hfTfJVEV8h6i1Uu2HBEA@mail.gmail.com>
Subject: Re: [PATCH] perf test: Basic branch counter support
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, jolsa@kernel.org, namhyung@kernel.org,
        adrian.hunter@intel.com, tinghao.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 7, 2023 at 9:44=E2=80=AFAM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> Add a basic test for the branch counter feature.
>
> The test verifies that
> - The new filter can be successfully applied on the supported platforms.
> - The counter value can be outputted via the perf report -D
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Thanks Kan!

> ---
>  tools/perf/tests/shell/record.sh | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/re=
cord.sh
> index 4fbc74805d52..2783e867c07c 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -11,6 +11,9 @@ err=3D0
>  perfdata=3D$(mktemp /tmp/__perf_test.perf.data.XXXXX)
>  testprog=3D"perf test -w thloop"
>  testsym=3D"test_loop"
> +cpu_pmu_dir=3D"/sys/bus/event_source/devices/cpu*"
> +br_cntr_file=3D"/caps/branch_counter_nr"
> +br_cntr_output=3D"branch stack counters"
>
>  cleanup() {
>    rm -rf "${perfdata}"
> @@ -154,10 +157,37 @@ test_workload() {
>    echo "Basic target workload test [Success]"
>  }
>
> +test_branch_counter() {
> +  echo "Basic branch counter test"
> +  # Check if the branch counter feature is supported

If $cpu_pmu_dir is empty, e.g. ARM and S390, this should also skip.

> +  for dir in $cpu_pmu_dir
> +  do
> +    if [ ! -e "$dir$br_cntr_file" ]
> +    then
> +      echo "Not support branch counter feature [Skipped]"

Perhaps here it'd be clearer to output:
echo "branch counter feature not supported on all core PMUs ($dir) [Skipped=
]"

Thanks,
Ian

> +      return
> +    fi
> +  done
> +  if ! perf record -o "${perfdata}" -j any,counter ${testprog} 2> /dev/n=
ull
> +  then
> +    echo "Basic branch counter test [Failed record]"
> +    err=3D1
> +    return
> +  fi
> +  if ! perf report -i "${perfdata}" -D -q | grep -q "$br_cntr_output"
> +  then
> +    echo "Basic branch record test [Failed missing output]"
> +    err=3D1
> +    return
> +  fi
> +  echo "Basic branch counter test [Success]"
> +}
> +
>  test_per_thread
>  test_register_capture
>  test_system_wide
>  test_workload
> +test_branch_counter
>
>  cleanup
>  exit $err
> --
> 2.35.1
>
