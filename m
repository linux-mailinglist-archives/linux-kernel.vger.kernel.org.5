Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5937A565C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 01:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjIRXz1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 18 Sep 2023 19:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjIRXz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 19:55:26 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAD190;
        Mon, 18 Sep 2023 16:55:20 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-76c64da0e46so197314939f.0;
        Mon, 18 Sep 2023 16:55:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695081319; x=1695686119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=32Geyxo6Wez9nlnCFYhmzhhOce0/GBBaedRUh12+AWQ=;
        b=eNrCgjAUmeEIj7twHIZGxY4JubrMUMdsrLWjMhqfmhrFAc938GuTVS22J2O6Rf33mD
         IywOJnYjDvpKJOnMQCIh3QSTcBMg6EMJk2YPtzptniL9bgz5ctrhBJOBJYrQuQhMLrT2
         tlKsyJugKwruv+WhPK7575yK/DIsWWDI3uK5IOW3e+bLX+tyz2QL9ITnkE4McQ5FjVZ9
         cZmE2RBXLoPIPjslazcWaQgsCOORKFp0xKm1FNfc54Bcfrs6JkZlck90UNX3dmUu6QoW
         5YSqd5BAF6rtJyN/5Cq8YCxAy3h7y6tiyrQayh/jYxJKmGPr8wF6PoW6AZ8L294H5VbF
         4aYQ==
X-Gm-Message-State: AOJu0Yy45BwIFf9rU30/zD7yUPUvMGrHqvJuLjHeh7EMZnGZ6nTqgih2
        +bYjOcXrV7Mpf2a11liX5D5uZbrAXPCGHOIxEIk=
X-Google-Smtp-Source: AGHT+IFbLxCYIvaKuYR8u8i+mk+abA5iRP66MeIEw6GnRFCMCPYf2ifQo1vICVxyq4Xg8rLkI6MyoX1ur+v01l8s0gI=
X-Received: by 2002:a5d:84c5:0:b0:790:f866:d71b with SMTP id
 z5-20020a5d84c5000000b00790f866d71bmr10706784ior.13.1695081319684; Mon, 18
 Sep 2023 16:55:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230918030304.24832-1-yangjihong1@huawei.com>
In-Reply-To: <20230918030304.24832-1-yangjihong1@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 18 Sep 2023 16:55:08 -0700
Message-ID: <CAM9d7cjCwykJ+9oB_u1cP+qgLNbwUCFhR31iK9rfjfSFxs13fg@mail.gmail.com>
Subject: Re: [PATCH] perf jevents: Fix segfault in perf_pmu__find_events_table
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, Sep 17, 2023 at 8:05 PM Yang Jihong <yangjihong1@huawei.com> wrote:
>
> Before caching the JSON events table, perf_pmu__find_events_table() need
> to check whether table is empty.
>
> For example, AuthenticAMD-15-6B-1 is used. The matching events table cannot
> be found. As a result, a null pointer is accessed when caching JSON events
> table, causing segfault.
>
> Before:
>   # perf record -vv true
>   DEBUGINFOD_URLS=
>   Using CPUID AuthenticAMD-15-6B-1
>   Segmentation fault (core dumped)
>
> After:
>   # perf record -vv true
>   DEBUGINFOD_URLS=
>   Using CPUID AuthenticAMD-15-6B-1
>   <SNIP>
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.005 MB perf.data ]
>
> Fixes: 7c52f10c0d4d ("perf pmu: Cache JSON events table")
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>

Thanks for the fix but please see

https://lore.kernel.org/all/20230913125157.2790375-1-tmricht@linux.ibm.com/

Thanks,
Namhyung


> ---
>  tools/perf/pmu-events/jevents.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> index a7e88332276d..72ba4a9239c6 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -991,7 +991,7 @@ const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu)
>                  }
>          }
>          free(cpuid);
> -        if (!pmu)
> +        if (!pmu || !table)
>                  return table;
>
>          for (i = 0; i < table->num_pmus; i++) {
> --
> 2.34.1
>
