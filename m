Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C0D7F77ED
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 16:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345871AbjKXPjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 10:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345784AbjKXPjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 10:39:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBBA10E7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 07:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700840361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=zbQKAp+Clj5/b7EZL4rrFhSja3A5Bbjru+mhH1vKgdg=;
        b=DdghAXxP15hWQSAWsBhMv7qGoMM2IF2l5VwSuu6YG9qgka7ZbWanvn+ejbFiwKC6nE6BhN
        FMDL7yfFmLwuOwD8X5hrj6Zh906ONhaA6mC3tTGL3B1izIZtlbJ0jOrHQF9tIRPCAZSycq
        Zf3FHFFQBCt0bN1pJyi4UtNPsgFAQV4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-I8EaWrkZPlma9z4HBD2BTw-1; Fri, 24 Nov 2023 10:39:20 -0500
X-MC-Unique: I8EaWrkZPlma9z4HBD2BTw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-332e11a22a0so1033859f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 07:39:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700840359; x=1701445159;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbQKAp+Clj5/b7EZL4rrFhSja3A5Bbjru+mhH1vKgdg=;
        b=fsVWc5+ksLjiBsVmY4BzvGlEfroIaa0+fWMcosDPwVrhYlyNaXFKg6AeWyrkutLoqH
         Kayo7ccULKXVuBzZVfn0HOkXnwlXLeu+UoZZltsrjv9HvkfWQNhfJL3yDUPH1IIIbmGz
         Zw2uudPIATuU1RFVIC7R+I8/0XLtHKmLtz0Ypi1CIMpUZTar6FnpwrUUWMpAG5zxqan0
         uct6351KBHFooRRzTF41ONLtzsWBv20dlA/VPiDaU4feL2FStcncw7LXtrQhv8rFeiL2
         sK/xQiMGmWGglioRiI+fo4BT4YFB+DLn2VugLkEVrhN11LuSE1duiE50xBMKfx/kpTo4
         2wSQ==
X-Gm-Message-State: AOJu0YzYmQdNe9gGI33xdOgheVSfo9mbrLiMkcNCOw2cSMnBG4Hc2KaC
        HLjZ2nvW3Z0byLuoE8DMxKFzSkzOXnGOgjKnTnd/I8xw22/muujDQ7AaqpXfObvyQohG9QyHtI5
        1HwOyTFvg5Y+iqZqBOf8XxFoD9k2lZVEq
X-Received: by 2002:a5d:5267:0:b0:332:d1cc:6374 with SMTP id l7-20020a5d5267000000b00332d1cc6374mr2927706wrc.47.1700840359184;
        Fri, 24 Nov 2023 07:39:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKEBIFzlraaubcICxVaebEeJHY8WOIHdv6sUvrrhq+8edkF2upiKeRj2OsjjADVkt8cS3flw==
X-Received: by 2002:a5d:5267:0:b0:332:d1cc:6374 with SMTP id l7-20020a5d5267000000b00332d1cc6374mr2927679wrc.47.1700840358769;
        Fri, 24 Nov 2023 07:39:18 -0800 (PST)
Received: from ?IPV6:2003:cb:c721:a000:7426:f6b4:82a3:c6ab? (p200300cbc721a0007426f6b482a3c6ab.dip0.t-ipconnect.de. [2003:cb:c721:a000:7426:f6b4:82a3:c6ab])
        by smtp.gmail.com with ESMTPSA id x1-20020adfec01000000b003313e4dddecsm4573111wrn.108.2023.11.24.07.39.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 07:39:18 -0800 (PST)
Message-ID: <d035af42-89a1-469e-87f4-8fbbfefa1332@redhat.com>
Date:   Fri, 24 Nov 2023 16:39:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] mm/ksm: add ksm advisor
Content-Language: en-US
To:     Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, riel@surriel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20231028000945.2428830-1-shr@devkernel.io>
 <20231028000945.2428830-2-shr@devkernel.io>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231028000945.2428830-2-shr@devkernel.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.10.23 02:09, Stefan Roesch wrote:
> This adds the ksm advisor. The ksm advisor automatically manages the
> pages_to_scan setting to achieve a target scan time. The target scan
> time defines how many seconds it should take to scan all the candidate
> KSM pages. In other words the pages_to_scan rate is changed by the
> advisor to achieve the target scan time. The algorithm has a max and min
> value to:
> - guarantee responsiveness to changes
> - to avoid to spend too much CPU
> 
> The respective parameters are:
> - ksm_advisor_target_scan_time (how many seconds a scan should take)
> - ksm_advisor_min_cpu (minimum value for cpu percent usage)
> - ksm_advisor_max_cpu (maximum value for cpu percent usage)
> 
> - ksm_advisor_min_pages (minimum value for pages_to_scan per batch)
> - ksm_advisor_max_pages (maximum value for pages_to_scan per batch)
> 
> The algorithm calculates the change value based on the target scan time
> and the previous scan time. To avoid pertubations an exponentially
> weighted moving average is applied.
> 
> The advisor is managed by three main parameters: target scan time,
> cpu min time and cpu max time for the ksmd background thread. These
> parameters determine how aggresive ksmd scans.
> 
> In addition there are min and max values for the pages_to_scan parameter
> to make sure that its initial and max values are not set too low or too
> high. This ensures that it is able to react to changes quickly enough.
> 
> The default values are:
> - target scan time: 200 secs
> - min cpu: 15%
> - max cpu: 70%
> - min pages: 500
> - max pages: 30000
> 
> By default the advisor is disabled. Currently there are two advisors:
> none and scan_time.
> 
> Tests with various workloads have shown considerable CPU savings. Most
> of the workloads I have investigated have more candidate pages during
> startup, once the workload is stable in terms of memory, the number of
> candidate pages is reduced. Without the advisor, the pages_to_scan needs
> to be sized for the maximum number of candidate pages. So having this
> advisor definitely helps in reducing CPU consumption.
> 
> For the instagram workload, the advisor achieves a 25% CPU reduction.
> Once the memory is stable, the pages_to_scan parameter gets reduced to
> about 40% of its max value.
> 
> Signed-off-by: Stefan Roesch <shr@devkernel.io>
> ---
>   mm/ksm.c | 159 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 158 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 7efcc68ccc6e..e18fecfb359d 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -21,6 +21,7 @@
>   #include <linux/sched.h>
>   #include <linux/sched/mm.h>
>   #include <linux/sched/coredump.h>
> +#include <linux/sched/cputime.h>
>   #include <linux/rwsem.h>
>   #include <linux/pagemap.h>
>   #include <linux/rmap.h>
> @@ -248,6 +249,9 @@ static struct kmem_cache *rmap_item_cache;
>   static struct kmem_cache *stable_node_cache;
>   static struct kmem_cache *mm_slot_cache;
>   
> +/* Default number of pages to scan per batch */
> +#define DEFAULT_PAGES_TO_SCAN 100
> +
>   /* The number of pages scanned */
>   static unsigned long ksm_pages_scanned;
>   
> @@ -276,7 +280,7 @@ static unsigned int ksm_stable_node_chains_prune_millisecs = 2000;
>   static int ksm_max_page_sharing = 256;
>   
>   /* Number of pages ksmd should scan in one batch */
> -static unsigned int ksm_thread_pages_to_scan = 100;
> +static unsigned int ksm_thread_pages_to_scan = DEFAULT_PAGES_TO_SCAN;
>   
>   /* Milliseconds ksmd should sleep between batches */
>   static unsigned int ksm_thread_sleep_millisecs = 20;
> @@ -297,6 +301,155 @@ unsigned long ksm_zero_pages;
>   /* The number of pages that have been skipped due to "smart scanning" */
>   static unsigned long ksm_pages_skipped;
>   
> +/* Don't scan more than max pages per batch. */
> +static unsigned long ksm_advisor_max_pages = 30000;
> +
> +/* At least scan this many pages per batch. */
> +static unsigned long ksm_advisor_min_pages = 500;
> +
> +/* Min CPU for scanning pages per scan */
> +static unsigned int ksm_advisor_min_cpu =  15;
> +
> +/* Max CPU for scanning pages per scan */
> +static unsigned int ksm_advisor_max_cpu =  70;
> +
> +/* Target scan time in seconds to analyze all KSM candidate pages. */
> +static unsigned long ksm_advisor_target_scan_time = 200;
> +
> +/* Exponentially weighted moving average. */
> +#define EWMA_WEIGHT 30
> +
> +/**
> + * struct advisor_ctx - metadata for KSM advisor
> + * @start_scan: start time of the current scan
> + * @scan_time: scan time of previous scan
> + * @change: change in percent to pages_to_scan parameter
> + * @cpu_percent: average cpu percent usage of the ksmd thread for the last scan
> + */
> +struct advisor_ctx {
> +	ktime_t start_scan;
> +	unsigned long scan_time;
> +	unsigned long change;
> +	unsigned long long cpu_time;
> +};
> +static struct advisor_ctx advisor_ctx;
> +
> +/* Define different advisor's */
> +enum ksm_advisor_type {
> +	KSM_ADVISOR_NONE,
> +	KSM_ADVISOR_FIRST = KSM_ADVISOR_NONE,
> +	KSM_ADVISOR_SCAN_TIME,
> +	KSM_ADVISOR_LAST = KSM_ADVISOR_SCAN_TIME
> +};
> +static enum ksm_advisor_type ksm_advisor;
> +
> +static void init_advisor(void)
> +{
> +	advisor_ctx.start_scan = 0;
> +	advisor_ctx.scan_time = 0;
> +	advisor_ctx.change = 0;
> +	advisor_ctx.cpu_time = 0;
> +}
> +
> +/*
> + * Use previous scan time if available, otherwise use current scan time as an
> + * approximation for the previous scan time.
> + */
> +static inline unsigned long prev_scan_time(struct advisor_ctx *ctx,
> +					   unsigned long scan_time)
> +{
> +	return ctx->scan_time ? ctx->scan_time : scan_time;
> +}
> +
> +/* Calculate exponential weighted moving average */
> +static unsigned long ewma(unsigned long prev, unsigned long curr)
> +{
> +	return ((100 - EWMA_WEIGHT) * prev + EWMA_WEIGHT * curr) / 100;
> +}
> +
> +/*
> + * The scan time advisor is based on the current scan rate and the target
> + * scan rate.
> + *
> + *      new_pages_to_scan = pages_to_scan * (scan_time / target_scan_time)
> + *
> + * To avoid pertubations it calculates a change factor of previous changes.
> + * A new change factor is calculated for each iteration and it uses an
> + * exponentially weighted moving average. The new pages_to_scan value is
> + * multiplied with that change factor:
> + *
> + *      new_pages_to_scan *= change facor
> + *
> + * In addition the new pages_to_scan value is capped by the max and min
> + * limits.
> + */
> +static void scan_time_advisor(unsigned long scan_time)
> +{
> +	unsigned int cpu_percent;
> +	unsigned long cpu_time;
> +	unsigned long cpu_time_diff;
> +	unsigned long cpu_time_diff_ms;
> +	unsigned long pages;
> +	unsigned long per_page_cost;
> +	unsigned long factor;
> +	unsigned long change;
> +	unsigned long last_scan_time;
> +
> +	cpu_time = task_sched_runtime(current);
> +	cpu_time_diff = cpu_time - advisor_ctx.cpu_time;
> +	cpu_time_diff_ms = cpu_time_diff / 1000 / 1000;
> +
> +	cpu_percent = (cpu_time_diff_ms * 100) / (scan_time * 1000);
> +	cpu_percent = cpu_percent ? cpu_percent : 1;
> +	last_scan_time = prev_scan_time(&advisor_ctx, scan_time);
> +
> +	/* Calculate scan time as percentage of target scan time */
> +	factor = ksm_advisor_target_scan_time * 100 / scan_time;
> +	factor = factor ? factor : 1;
> +

^ ah, that's what I missed.

BTW, why do we pass in "scan_time" and not simply obtain it here, just 
like we do with task_sched_runtime() ?


-- 
Cheers,

David / dhildenb

