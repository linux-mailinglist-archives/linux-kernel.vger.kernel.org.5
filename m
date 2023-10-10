Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809D47BF73C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjJJJYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjJJJXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:23:51 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5FAB0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 02:23:05 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-32d569e73acso165338f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 02:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696929784; x=1697534584; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xe8JpwsINq8culWJn2R97JOgXDbD5qqq96xuZqiOo+Y=;
        b=OJj0elYmRjTJjQVKWsVJEzubr/lFuzOTu0VoqmAHISXubqDhYLCnY7ensctM2cxQmr
         L0UWeD9zQHOg+VKvIP41LTOMAwHzvP9Wyp7z4VREf0vL1hzwCU9wfXLNhw9Yik9G7Kua
         vhoR8W6ihcKAb0RHcYUQ7MkoJ5xPWK5//eAYShMcflkDuPF3oNromU10qdxupoJSDiao
         huUHbSUNEvTBZyFZAoUkHqt0ijqAH31T6VpEmocMqPrdDdphV1IMw3rO+1l5/STeQVuL
         9AIqoXZU7vf9eoRs2Vk2Ck5zXhDHgrrCO0e3m3CtED6a6O2Bmocf2aWzPb1AcS3yjQnz
         mEVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696929784; x=1697534584;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xe8JpwsINq8culWJn2R97JOgXDbD5qqq96xuZqiOo+Y=;
        b=W+Hf1w3F9YKzLihwPPvGNZlLlIc3209ykqstqiC7bAJuCMl0mkARY8j+QnLqwf/nxb
         2jHOoRB6WuFMLmAZu2yyeMkfchjtOvLXHPZhasAB7z070hf4pr0+flU9abinYl+r3NEq
         J96L6ugd2JaW7pg5rSHKw6AHOJxWSEmJM4WgNvO43dF/us6LVD/tbTwp0HhhvEfLO98l
         uLzM2GTlXcrGbAm+jiyciOSh27DDE8j0+chooY5184zlSQQKXB/dtvRNG0vBBU2LAA5m
         qMqmrPedFue661hempgkZLfqzpRd7wVhPuZy7RxtFaaXIupVcf9jQbsztHLULRHl9J5P
         qazA==
X-Gm-Message-State: AOJu0Yzavw9X8EVQ46unh6PlVSzyK5zZIKPmkKKYzU98rxJOxcBL5BW9
        zXAW3KjyY/JDRRgAx5JGnUc=
X-Google-Smtp-Source: AGHT+IGmTwB0cowYILSDxlmRY0/l5H88NPoPezYQBWK50ok4Q7Yh1g+d/KAlnBukst9DbONlji+TMA==
X-Received: by 2002:adf:cf0a:0:b0:317:3f70:9dc4 with SMTP id o10-20020adfcf0a000000b003173f709dc4mr15681071wrj.31.1696929783994;
        Tue, 10 Oct 2023 02:23:03 -0700 (PDT)
Received: from gmail.com (1F2EF237.nat.pool.telekom.hu. [31.46.242.55])
        by smtp.gmail.com with ESMTPSA id n9-20020adff089000000b0031ad2f9269dsm12069341wro.40.2023.10.10.02.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 02:23:02 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 10 Oct 2023 11:23:00 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Raghavendra K T <raghavendra.kt@amd.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Bharata B Rao <bharata@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 6/6] sched/numa: Complete scanning of inactive VMAs when
 there is no alternative
Message-ID: <ZSUX9NLa+DDjFLnZ@gmail.com>
References: <20231010083143.19593-1-mgorman@techsingularity.net>
 <20231010083143.19593-7-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010083143.19593-7-mgorman@techsingularity.net>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mel Gorman <mgorman@techsingularity.net> wrote:

> On a 2-socket Cascade Lake test machine, the time to complete the
> workload is as follows;
> 
>                                                6.6.0-rc2              6.6.0-rc2
>                                      sched-numabtrace-v1 sched-numabselective-v1
> Min       elsp-NUMA01_THREADLOCAL      174.22 (   0.00%)      117.64 (  32.48%)
> Amean     elsp-NUMA01_THREADLOCAL      175.68 (   0.00%)      123.34 *  29.79%*
> Stddev    elsp-NUMA01_THREADLOCAL        1.20 (   0.00%)        4.06 (-238.20%)
> CoeffVar  elsp-NUMA01_THREADLOCAL        0.68 (   0.00%)        3.29 (-381.70%)
> Max       elsp-NUMA01_THREADLOCAL      177.18 (   0.00%)      128.03 (  27.74%)
> 
> The time to complete the workload is reduced by almost 30%
> 
>                    6.6.0-rc2   6.6.0-rc2
>                 sched-numabtrace-v1 sched-numabselective-v1 /
> Duration User       91201.80    63506.64
> Duration System      2015.53     1819.78
> Duration Elapsed     1234.77      868.37
> 
> In this specific case, system CPU time was not increased but it's not
> universally true.
> 
> From vmstat, the NUMA scanning and fault activity is as follows;
> 
>                                       6.6.0-rc2      6.6.0-rc2
>                             sched-numabtrace-v1 sched-numabselective-v1
> Ops NUMA base-page range updates       64272.00    26374386.00
> Ops NUMA PTE updates                   36624.00       55538.00
> Ops NUMA PMD updates                      54.00       51404.00
> Ops NUMA hint faults                   15504.00       75786.00
> Ops NUMA hint local faults %           14860.00       56763.00
> Ops NUMA hint local percent               95.85          74.90
> Ops NUMA pages migrated                 1629.00     6469222.00
> 
> Both the number of PTE updates and hint faults is dramatically
> increased. While this is superficially unfortunate, it represents
> ranges that were simply skipped without the patch. As a result
> of the scanning and hinting faults, many more pages were also
> migrated but as the time to completion is reduced, the overhead
> is offset by the gain.

Nice! I've applied your series to tip:sched/core with a few non-functional 
edits to comment/changelog formatting/clarity.

Btw., was any previous analysis done on the size of the pids_active[] hash
and the hash collision rate?

64 (BITS_PER_LONG) feels a bit small, especially on larger machines running 
threaded workloads, and the kmalloc of numab_state likely allocates a full 
cacheline anyway, so we could double the hash size from 8 bytes (2x1 longs) 
to 32 bytes (2x2 longs) with very little real cost, and still have a long 
field left to spare?

Thanks,

	Ingo
