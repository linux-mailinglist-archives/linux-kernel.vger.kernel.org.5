Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A567A33DB
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 07:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbjIQFhH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 17 Sep 2023 01:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbjIQFgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 01:36:37 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A73122;
        Sat, 16 Sep 2023 22:36:32 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-795547f055fso122314539f.0;
        Sat, 16 Sep 2023 22:36:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694928991; x=1695533791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ob5I9kRynnPkG9uzPUBKYceGRS1WlW3gs9wY88hmXBo=;
        b=SMnkOhlj95Qn9QgkSf9UTABynzLDMxasbNRKO/iyHEjqOQAlcXf3xUxM4ciIEEAtwq
         TYRd+/ykbRii/YzmAQmxPeT5ZLmFKSAQK6mLok+2A/KP29tvTreOzQoqi1EKa+ty9eLa
         xizQBybmpAlPoyJKjlbU/jzru6oTMuj4dfRHzHZYwfSLIpw9wsBi2cvQjmScMb3BTvC9
         Sr+9hf7u/Yr9J6gKufkMoOVZjHQrZJ6uBgS0NdqUiphKcsnUs+8YyjTz4LrgXDsr/Pbu
         PQBv84xHoTy0ZaJS6r83WmSBFKrT7nVECawCsYB/qpeHpdvjzyR+AyMGzpYYCfOOGYJe
         2hZQ==
X-Gm-Message-State: AOJu0YyFplv4T2d6a2Wv0NwQV3a0BzhOuzrS0iP+HK/CZ96/Kxk4JqPc
        qwR9yoz7+efQkEUnLCOsJxUNifWSXxYosy+X59A=
X-Google-Smtp-Source: AGHT+IGevGllGlavsi60Gh+mtGRF4n7+sIpm+WMuCJtFjE5jgsWo5g686gDcN6aMmbiBcOMUCozzumKKBN+5x/JH/8Y=
X-Received: by 2002:a5e:8e08:0:b0:785:ff35:f340 with SMTP id
 a8-20020a5e8e08000000b00785ff35f340mr7170401ion.14.1694928991623; Sat, 16 Sep
 2023 22:36:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230916091641.776031-1-yangjihong1@huawei.com>
In-Reply-To: <20230916091641.776031-1-yangjihong1@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 16 Sep 2023 22:36:19 -0700
Message-ID: <CAM9d7ciuLiYRT0tyhXSrZLqe9uhLNw=zGK4Tj6-GG5WQALP3-Q@mail.gmail.com>
Subject: Re: [PATCH] perf test: Fix test-record-dummy-C0 failure for supported
 PERF_FORMAT_LOST feature kernel
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 16, 2023 at 2:18 AM Yang Jihong <yangjihong1@huawei.com> wrote:
>
> For kernel that supports PERF_FORMAT_LOST, attr->read_format has
> PERF_FORMAT_LOST bit. Update expected value of
> attr->read_format of test-record-dummy-C0 for this scenario.
>
> Before:
>
>   # ./perf test 17 -vv
>    17: Setup struct perf_event_attr                                    :
>   --- start ---
>   test child forked, pid 1609441
>   <SNIP>
>   running './tests/attr/test-record-dummy-C0'
>     'PERF_TEST_ATTR=/tmp/tmpm3s60aji ./perf record -o /tmp/tmpm3s60aji/perf.data --no-bpf-event -e dummy -C 0 kill >/dev/null 2>&1' ret '1', expected '1'
>   expected read_format=4, got 20
>   FAILED './tests/attr/test-record-dummy-C0' - match failure
>   test child finished with -1
>   ---- end ----
>   Setup struct perf_event_attr: FAILED!
>
> After:
>
>   # ./perf test 17 -vv
>    17: Setup struct perf_event_attr                                    :
>   --- start ---
>   test child forked, pid 1609441
>   <SNIP>
>   running './tests/attr/test-record-dummy-C0'
>     'PERF_TEST_ATTR=/tmp/tmppa9vxcb7 ./perf record -o /tmp/tmppa9vxcb7/perf.data --no-bpf-event -e dummy -C 0 kill >/dev/null 2>&1' ret '1', expected '1'
>   <SNIP>
>   test child finished with 0
>   ---- end ----
>   Setup struct perf_event_attr: Ok
>
> Reported-by: Namhyung Kim <namhyung@kernel.org>
> Closes: https://lore.kernel.org/all/CAM9d7cgNH2+zhSAmA3en_6as915UsF25MoLbfjE350tAP43Bog@mail.gmail.com/

I'll change it to follow the existing style like

Fixes: d50ad02cb39a ("perf test: Add perf_event_attr test for record
dummy event")

> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>

Tested-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/tests/attr/test-record-dummy-C0 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/attr/test-record-dummy-C0 b/tools/perf/tests/attr/test-record-dummy-C0
> index 83ca4e373acd..576ec48b3aaf 100644
> --- a/tools/perf/tests/attr/test-record-dummy-C0
> +++ b/tools/perf/tests/attr/test-record-dummy-C0
> @@ -17,7 +17,7 @@ sample_period=4000
>  # PERF_SAMPLE_PERIOD
>  # + PERF_SAMPLE_CPU added by -C 0
>  sample_type=391
> -read_format=4
> +read_format=4|20
>  disabled=0
>  inherit=1
>  pinned=0
> --
> 2.34.1
>
