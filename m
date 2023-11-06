Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5C87E288B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 16:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjKFPVw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 6 Nov 2023 10:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjKFPVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 10:21:50 -0500
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD3BF3;
        Mon,  6 Nov 2023 07:21:47 -0800 (PST)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2802d218242so4382412a91.1;
        Mon, 06 Nov 2023 07:21:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699284107; x=1699888907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hC01eFTX9uGCPuSCN6Hq+UaUvIpEOT+vxrlNTGWSxeY=;
        b=IzS9WM0WuIUHQlOCi80WLMoWL7Qcx37UhW1/Wd2DBoa9R51FKm6igbL6FQZ9ulNyo+
         3EbfXdjbcBa7bFz67fNODsjkfdZzNojKvGEnJ6koehIUJY00Y+fSnlHyYYJkd9g11DJV
         pRl2e3muutRUTMwMVE4vMTOeKJ4tb/Ww2JjBxX5el+g5LfpxxblOtEs7VC1fi3kMf50f
         0b9BOFWz9AzJZ75HNmjPQYrIysfC9XwWcuTenfquYkpFRubYheoIShJtv2+TRPO2/HB7
         WwiIpk8ilXEwRTUUb78xYOpDOziSnleHkA2vRubwE4JJxOfjKqD2DZ/N5UT8mtN9iMYI
         gW+A==
X-Gm-Message-State: AOJu0YwqjK5wqm6Cdq5/cXEGH82pfncrk3rnr6LJmth6pfONtGLY60mP
        lPjgJ4ochfyPPZgIH+WzYCGCJKFh2fDUNq0PKymp34xm
X-Google-Smtp-Source: AGHT+IG0Bbsp92U3fyOlWVfA51oBKtjvUge6KMPebYcucyR40fN4XG4A6xs3v4GbFLgiESKSIIqEC4UcMLKsC8MVpXg=
X-Received: by 2002:a17:90b:4004:b0:280:94e8:99f4 with SMTP id
 ie4-20020a17090b400400b0028094e899f4mr18257643pjb.46.1699284106836; Mon, 06
 Nov 2023 07:21:46 -0800 (PST)
MIME-Version: 1.0
References: <20231106091627.2022530-1-tmricht@linux.ibm.com>
In-Reply-To: <20231106091627.2022530-1-tmricht@linux.ibm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 6 Nov 2023 07:21:35 -0800
Message-ID: <CAM9d7chpvhDCkTLiuPVqSKxoZdNYgJ0A2HvVdXbEgMvPZrv1Eg@mail.gmail.com>
Subject: Re: [PATCH v2 PING] perf test: Adjust test case perf record offcpu
 profiling tests for s390
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, svens@linux.ibm.com, gor@linux.ibm.com,
        sumanthk@linux.ibm.com, hca@linux.ibm.com,
        Ilya Leoshkevich <iii@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Nov 6, 2023 at 1:16 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
>
> On s390 using linux-next the test case
>     87: perf record offcpu profiling tests
> fails. The root cause is this command
>
>  # ./perf  record --off-cpu -e dummy -- ./perf bench sched messaging -l 10
>  # Running 'sched/messaging' benchmark:
>  # 20 sender and receiver processes per group
>  # 10 groups == 400 processes run
>
>      Total time: 0.231 [sec]
>  [ perf record: Woken up 1 times to write data ]
>  [ perf record: Captured and wrote 0.077 MB perf.data (401 samples) ]
>  #
>
> It does not generate 800+ sample entries, on s390 usually around 40[1-9],
> sometimes a few more, but never more than 450. The higher the number
> of CPUs the lower the number of samples.
>
> Looking at function chain
>   bench_sched_messaging()
>   +--> group()
> the senders and receiver threads are created. The senders and receivers
> call function ready() which writes one bytes and wait for a reply using
> poll system() call.
>
> As context switches are counted, the function ready() will trigger
> a context switch when no input data is available after the write
> system call. The write system call does not trigger context switches
> when the data size is small. And writing 1000 bytes (10 iterations with
> 100 bytes) is not much and certainly won't block.
>
> The 400+ context switch on s390 occur when the some receiver/sender
> threads call ready() and wait for the response from function
> bench_sched_messaging() being kicked off.
>
> Lower the number of expected context switches to 400 to succeed on
> s390.
>
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Co-developed-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/tests/shell/record_offcpu.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/shell/record_offcpu.sh b/tools/perf/tests/shell/record_offcpu.sh
> index a1ef8f0d2b5c..67c925f3a15a 100755
> --- a/tools/perf/tests/shell/record_offcpu.sh
> +++ b/tools/perf/tests/shell/record_offcpu.sh
> @@ -77,9 +77,9 @@ test_offcpu_child() {
>      err=1
>      return
>    fi
> -  # each process waits for read and write, so it should be more than 800 events
> +  # each process waits at least for poll, so it should be more than 400 events
>    if ! perf report -i ${perfdata} -s comm -q -n -t ';' --percent-limit=90 | \
> -    awk -F ";" '{ if (NF > 3 && int($3) < 800) exit 1; }'
> +    awk -F ";" '{ if (NF > 3 && int($3) < 400) exit 1; }'
>    then
>      echo "Child task off-cpu test [Failed invalid output]"
>      err=1
> --
> 2.41.0
>
