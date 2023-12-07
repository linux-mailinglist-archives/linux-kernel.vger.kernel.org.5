Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A4E809691
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 00:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444129AbjLGX0w convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 7 Dec 2023 18:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235331AbjLGX0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 18:26:50 -0500
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1542C1717;
        Thu,  7 Dec 2023 15:26:56 -0800 (PST)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ce72faf1e8so1077981b3a.0;
        Thu, 07 Dec 2023 15:26:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701991615; x=1702596415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L4J2E2tG2dP97E7tt5Zs/xut2bSJe2Lv30FSjIan7Ew=;
        b=tAcd5VZP5c9PcRamRHTcNCtrOOpKLUGgt6dAs9ZMFVWrrgNmV+CReqeXB7T+2EPqTu
         ijZUQP5jaPRXimIX8J/pZWN7qGTaWLqnuphScRnrgdh2AHzBb3CBd/AAGlYLdTSim8IP
         RRxujbwwPSep0zc+xWjN6Kgdgc6xE2ZsbQB8+/1/e5C8Z1u8RIsxmsNdV1x6jB587i9t
         0UZPckivi7B8fUP5KB+mnrfpw8Fwctm+B8kGCAYsLXaVleXdMkHyRymg2RsCj9q3SEqa
         tme7UXfPglfQ+wh0o5WGMuW94Y/Wgu4Crcz6f0XpzujMxJwFaiMu1m6GH0ntMrqM9JNm
         niLg==
X-Gm-Message-State: AOJu0YwrpYBNsxAlKyVmaUdwIPa+69qRfH/B3NqmyPMeGDEov9mRk0ug
        7dJ7yR69CrB/WFWwRYJVjtI9S9qU+/a7uKVnxNSOgPQ2BYk=
X-Google-Smtp-Source: AGHT+IEuuqBsJIJyxMPILRxJ8yuzzSZroPT9okr9/mpKlIjY2VyBtU2GI9b7309naza3f77qfi6ET2yEcRqhpJ166P0=
X-Received: by 2002:aa7:9e0b:0:b0:6ce:3260:c469 with SMTP id
 y11-20020aa79e0b000000b006ce3260c469mr2692375pfq.35.1701991615418; Thu, 07
 Dec 2023 15:26:55 -0800 (PST)
MIME-Version: 1.0
References: <20231207125716.1947860-1-tmricht@linux.ibm.com>
In-Reply-To: <20231207125716.1947860-1-tmricht@linux.ibm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 7 Dec 2023 15:26:43 -0800
Message-ID: <CAM9d7cgJUgVGpQJ=KgH+3RzAJ8Ce50Acr=gSZh_ZLuiTa3-sEg@mail.gmail.com>
Subject: Re: [PATCH] perf test: Fix fails of perf stat --bpf-counters
 --for-each-cgroup on s390
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, svens@linux.ibm.com, gor@linux.ibm.com,
        sumanthk@linux.ibm.com, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Dec 7, 2023 at 4:57 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
>
> On s390 this test fails very often, as can be observed in the output
> below. This is caused by the second test function
> check_cpu_list_counted(). The perf stat is triggered for 2 CPUs
> 0 and 1.  On s390, which usually has a lot more CPUs, most often
> this ends up in no counter increments on these 2 CPUs 0 and 1.
>
> Fix this and trigger explicit workload on CPU 0 and 1 for
> systemd. This is a better approach than calculating a long
> list of CPUs (which is basicly the same as option -a), or
> wait a longer period of time.
>
> Output before:
>  # for i in $(seq 10)
>  > do ./perf test 100
>  > done
>  100: perf stat --bpf-counters --for-each-cgroup test : FAILED!
>  100: perf stat --bpf-counters --for-each-cgroup test : Ok
>  100: perf stat --bpf-counters --for-each-cgroup test : FAILED!
>  100: perf stat --bpf-counters --for-each-cgroup test : Ok
>  100: perf stat --bpf-counters --for-each-cgroup test : Ok
>  100: perf stat --bpf-counters --for-each-cgroup test : Ok
>  100: perf stat --bpf-counters --for-each-cgroup test : FAILED!
>  100: perf stat --bpf-counters --for-each-cgroup test : Ok
>  100: perf stat --bpf-counters --for-each-cgroup test : FAILED!
>  100: perf stat --bpf-counters --for-each-cgroup test : Ok
>  #
>
> Output after:
>  # for i in $(seq 10);
>  do ./perf test 100;
>  done
>  100: perf stat --bpf-counters --for-each-cgroup test  : Ok
>  100: perf stat --bpf-counters --for-each-cgroup test  : Ok
>  100: perf stat --bpf-counters --for-each-cgroup test  : Ok
>  100: perf stat --bpf-counters --for-each-cgroup test  : Ok
>  100: perf stat --bpf-counters --for-each-cgroup test  : Ok
>  100: perf stat --bpf-counters --for-each-cgroup test  : Ok
>  100: perf stat --bpf-counters --for-each-cgroup test  : Ok
>  100: perf stat --bpf-counters --for-each-cgroup test  : Ok
>  100: perf stat --bpf-counters --for-each-cgroup test  : Ok
>  100: perf stat --bpf-counters --for-each-cgroup test  : Ok
>  #
>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  tools/perf/tests/shell/stat_bpf_counters_cgrp.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh b/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh
> index e75d0780dc78..f67602321403 100755
> --- a/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh
> +++ b/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh
> @@ -60,6 +60,7 @@ check_system_wide_counted()
>
>  check_cpu_list_counted()
>  {
> +       taskset -c 0,1 systemctl daemon-reexec &

Thanks for the patch.  But I think it should support
machines without systemd (or maybe with old versions).

Also probably you want to reset the behavior after
the test.  I think we can just run some built-in test
workload like `perf test -w thloop`.

Thanks,
Namhyung


>         check_cpu_list_counted_output=$(perf stat -C 0,1 --bpf-counters --for-each-cgroup ${test_cgroups} -e cpu-clock -x, taskset -c 1 sleep 1  2>&1)
>         if echo ${check_cpu_list_counted_output} | grep -q -F "<not "; then
>                 echo "Some CPU events are not counted"
> --
> 2.43.0
>
