Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBDB80A0F6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 11:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573655AbjLHKad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 05:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235876AbjLHKaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 05:30:07 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0102106
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 02:29:31 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1d0c4d84bf6so14260595ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 02:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702031371; x=1702636171; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7qoKQ5iQtJ7ORKAjC/jbRnFF5PVRidwsUSKuUbzTiuc=;
        b=wKNJgN6c/ct0c7iwBrH1iRFQWXotLdF9N88tl0Ec48t0Uf6Sgh/0KRjCgWqvkPSAT3
         edB5nd2MOPRfvsKWdXJN11Ne7Fm/NaTzoFXTbxnCbp8AbnHJLUWPNlxFo+SDSnJJyNaO
         9c/iAskhpJniaSdPUHDe/j5CLZPjZ5DAWK7Y39nu8YwOB9IhInl5+5GwzDOvjMvHCUGj
         m7ISwxZtX3vNBCoVenUkUZTL6v5cuOfbvT5WNJiGgPMv9hyeoF3+L+u7exuURteU2gSt
         IHYqSBHnNMaol2uNU2GnTvO4BQVHYUKU4f01TrUMw5qAlfwaR1xdmVz+Q1NCj6RWwYEl
         iUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702031371; x=1702636171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qoKQ5iQtJ7ORKAjC/jbRnFF5PVRidwsUSKuUbzTiuc=;
        b=C0Z8iOWY1BV+W8PS72CqRmaPA39W53ug23MC8Bj/tgc6Ge1ZTX9wKTxvdMr7+WbCFe
         +8mfZTJDTu/V2Siv7RkxLlHwHsZIVO5cqYsmlUIHQ9rXeH7dh/BCHLY7qpMG7s4tcPyF
         X41UQuru9V+1FuemltdopXFkmD0S1Ejb9eiDWU4y/w3oi0FPwe7JUy5LppiDXnmV48xX
         kKrXh386OTUne4pQojphJC8WLVXA2F93c0yHywN9kYDChIyWlg02iTgKVxkNwq0tpCZg
         b71QMP0gWdN40T8se1zO3bxCpytH49gPipIJe1GHFg/1us/FenXQZneHbjAlvs/MGrHT
         2erQ==
X-Gm-Message-State: AOJu0YyGLQc1BVtoT+Is9QSy7P7NM8/2WKf5Kes8Zf96Mew4meHZF2HZ
        /oWvLGJJ18LlqWHOgg84h2mFtw==
X-Google-Smtp-Source: AGHT+IGp6gJKDTnj0Q50k3Oi+iQgxehq4lMqHqUBpi5q+BCl1I8EsTY+C3JfvDplR8rMKUtD5X/swg==
X-Received: by 2002:a17:903:1209:b0:1d0:cfdc:10cb with SMTP id l9-20020a170903120900b001d0cfdc10cbmr3805283plh.72.1702031370812;
        Fri, 08 Dec 2023 02:29:30 -0800 (PST)
Received: from leoy-huanghe.lan ([94.177.131.71])
        by smtp.gmail.com with ESMTPSA id j15-20020a170902da8f00b001c9db5e2929sm1357806plx.93.2023.12.08.02.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 02:29:30 -0800 (PST)
Date:   Fri, 8 Dec 2023 18:29:22 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, irogers@google.com, peterz@infradead.org,
        mingo@redhat.com, namhyung@kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, john.g.garry@oracle.com, will@kernel.org,
        james.clark@arm.com, mike.leach@linaro.org,
        yuhaixin.yhx@linux.alibaba.com, renyu.zj@linux.alibaba.com,
        tmricht@linux.ibm.com, ravi.bangoria@amd.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2 1/5] perf mem: Add mem_events into the supported
 perf_pmu
Message-ID: <20231208102922.GB769184@leoy-huanghe.lan>
References: <20231207192338.400336-1-kan.liang@linux.intel.com>
 <20231207192338.400336-2-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207192338.400336-2-kan.liang@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 11:23:34AM -0800, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> With the mem_events, perf doesn't need to read sysfs for each PMU to
> find the mem-events-supported PMU. The patch also makes it possible to
> clean up the related __weak functions later.
> 
> The patch is only to add the mem_events into the perf_pmu for all ARCHs.
> It will be used in the later cleanup patches.
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> Tested-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/arch/arm64/util/mem-events.c | 4 ++--
>  tools/perf/arch/arm64/util/mem-events.h | 7 +++++++
>  tools/perf/arch/arm64/util/pmu.c        | 6 ++++++
>  tools/perf/arch/s390/util/pmu.c         | 3 +++
>  tools/perf/arch/x86/util/mem-events.c   | 4 ++--
>  tools/perf/arch/x86/util/mem-events.h   | 9 +++++++++
>  tools/perf/arch/x86/util/pmu.c          | 7 +++++++
>  tools/perf/util/mem-events.c            | 2 +-
>  tools/perf/util/mem-events.h            | 1 +
>  tools/perf/util/pmu.c                   | 4 +++-
>  tools/perf/util/pmu.h                   | 7 +++++++
>  11 files changed, 48 insertions(+), 6 deletions(-)
>  create mode 100644 tools/perf/arch/arm64/util/mem-events.h
>  create mode 100644 tools/perf/arch/x86/util/mem-events.h
> 
> diff --git a/tools/perf/arch/arm64/util/mem-events.c b/tools/perf/arch/arm64/util/mem-events.c
> index 3bcc5c7035c2..aaa4804922b4 100644
> --- a/tools/perf/arch/arm64/util/mem-events.c
> +++ b/tools/perf/arch/arm64/util/mem-events.c
> @@ -4,7 +4,7 @@
>  
>  #define E(t, n, s) { .tag = t, .name = n, .sysfs_name = s }
>  
> -static struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
> +struct perf_mem_event perf_mem_events_arm[PERF_MEM_EVENTS__MAX] = {
>  	E("spe-load",	"arm_spe_0/ts_enable=1,pa_enable=1,load_filter=1,store_filter=0,min_latency=%u/",	"arm_spe_0"),
>  	E("spe-store",	"arm_spe_0/ts_enable=1,pa_enable=1,load_filter=0,store_filter=1/",			"arm_spe_0"),
>  	E("spe-ldst",	"arm_spe_0/ts_enable=1,pa_enable=1,load_filter=1,store_filter=1,min_latency=%u/",	"arm_spe_0"),
> @@ -17,7 +17,7 @@ struct perf_mem_event *perf_mem_events__ptr(int i)
>  	if (i >= PERF_MEM_EVENTS__MAX)
>  		return NULL;
>  
> -	return &perf_mem_events[i];
> +	return &perf_mem_events_arm[i];

I recognized that it's hard code to "arm_spe_0", which might break if
system registers different Arm SPE groups.  But this is not the issue
introduced by this patch, we might need to consider to fix it later.

>  }
>  
>  const char *perf_mem_events__name(int i, const char *pmu_name __maybe_unused)
> diff --git a/tools/perf/arch/arm64/util/mem-events.h b/tools/perf/arch/arm64/util/mem-events.h
> new file mode 100644
> index 000000000000..5fc50be4be38
> --- /dev/null
> +++ b/tools/perf/arch/arm64/util/mem-events.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ARM64_MEM_EVENTS_H
> +#define _ARM64_MEM_EVENTS_H
> +
> +extern struct perf_mem_event perf_mem_events_arm[PERF_MEM_EVENTS__MAX];
> +
> +#endif /* _ARM64_MEM_EVENTS_H */
> diff --git a/tools/perf/arch/arm64/util/pmu.c b/tools/perf/arch/arm64/util/pmu.c
> index 2a4eab2d160e..06ec9b838807 100644
> --- a/tools/perf/arch/arm64/util/pmu.c
> +++ b/tools/perf/arch/arm64/util/pmu.c
> @@ -8,6 +8,12 @@
>  #include <api/fs/fs.h>
>  #include <math.h>
>  
> +void perf_pmu__arch_init(struct perf_pmu *pmu)
> +{
> +	if (!strcmp(pmu->name, "arm_spe_0"))
> +		pmu->mem_events = perf_mem_events_arm;

This is not right and it should cause building failure on aarch64.

aarch64 reuses aarch32's file arch/arm/util/pmu.c, and this file has
already defined perf_pmu__arch_init(), you should add above change in
the file arch/arm/util/pmu.c.

Now I cannot access a machine for testing Arm SPE, but I will play
a bit for this patch set to ensure it can pass compilation.  After
that, I will seek Arm maintainers/reviewers help for the test.

Thanks,
Leo
