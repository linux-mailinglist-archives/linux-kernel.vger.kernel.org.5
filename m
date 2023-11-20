Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8357F10CE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbjKTKvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbjKTKvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:51:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D78285
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700477496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=/05V0W7XwKXU+dIgJCkkOm1CX3elAsSlSq3vRkgWv64=;
        b=H7Hc2Lx/C7B2sIV6H30T/d9eNCyYRGtRCyBGcGxoA7r+YWxSQ50IoOc1E0Eu3Qy3j578GG
        NAmcmL1PBgo1A+npRrVfEa+VbZQKex93qD4v0SvTuy+GXLawfwY/kh5KH9bmbLIWdcNuMW
        +KeYSYPyev3Io58nhrvmmBgW8vYtMuM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-_8-sfifWM22CJs1oGmDxtA-1; Mon, 20 Nov 2023 05:51:34 -0500
X-MC-Unique: _8-sfifWM22CJs1oGmDxtA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4084d08235fso12506705e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:51:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700477493; x=1701082293;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/05V0W7XwKXU+dIgJCkkOm1CX3elAsSlSq3vRkgWv64=;
        b=tpSlalJWXDQxgV2AQTM3Dsf7LO69qvkRYFVEpd2v/UMGuArid2rvfKJ0IEsLFQTcY8
         nFUZ4hL5KEf6nUt1iw+6H1Zs05vx5RwljaxaHtR3yI69qoSdcebG9V+H0gJgUuQ7xZ35
         +FSeqedtwnwvQv59OWskZHjSII+WtdnsNBGFuEFAk5cCHSGTGiyEj3HqromDV9iYSv69
         AFlrJ5sgIFaJYjZUqbvub6LKGOhQVC5PEo88QH+fZZAJv09g9j+jiNJ0xbhAKtLRcHlC
         AUlOcUjoKCivqH3DD/WGDaaL1nXH8l80UZ4OIUwn40xtDU+PGMiNpo9BdXD/kmkqujNW
         jLYw==
X-Gm-Message-State: AOJu0YxSD0tE48LCdtcorzG42MZwF4XY1hgVAPDn2wYmyAWXWG5/twid
        JtfuF5tDpGEJlk1LFCz2OhF5qkGO2HwX15si3jqhHh12Z1EyZnGpEC9tFEbAdHcNRM4OXtKuShX
        P0aPuy/8XSL6VSyB3cZqFxm7w
X-Received: by 2002:a05:600c:45ca:b0:406:8c7a:9520 with SMTP id s10-20020a05600c45ca00b004068c7a9520mr5303169wmo.36.1700477493498;
        Mon, 20 Nov 2023 02:51:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUKn3vefNiNXogrpuFn4IVdzols7L9zWTQiqsdAXx5b35CTvSnXLfVih1AWhpYEAN4ukxlLA==
X-Received: by 2002:a05:600c:45ca:b0:406:8c7a:9520 with SMTP id s10-20020a05600c45ca00b004068c7a9520mr5303153wmo.36.1700477493058;
        Mon, 20 Nov 2023 02:51:33 -0800 (PST)
Received: from ?IPV6:2003:cb:c746:7700:9885:6589:b1e3:f74c? (p200300cbc746770098856589b1e3f74c.dip0.t-ipconnect.de. [2003:cb:c746:7700:9885:6589:b1e3:f74c])
        by smtp.gmail.com with ESMTPSA id p22-20020a05600c1d9600b0040b1a3c83b6sm8163764wms.40.2023.11.20.02.51.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 02:51:32 -0800 (PST)
Message-ID: <d41ecf6d-d276-406c-a002-f4ffc9d82ef1@redhat.com>
Date:   Mon, 20 Nov 2023 11:51:31 +0100
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
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
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

Do we really need the min cpu load? The target scan time combined with 
the max CPU load should be sufficient, no?

Internally, we might want some sane default/min start value, but 
exposing that to the user is questionable.

For example, if I have exactly two possible KSM pages in the system, why 
should my cpu dedicate 15% to scanning nothing after merging them? :)

[...]

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

Unused, better drop it. 0 is the implicit first one.

> +	KSM_ADVISOR_SCAN_TIME,
> +	KSM_ADVISOR_LAST = KSM_ADVISOR_SCAN_TIME

Instead of "_LAST", maybe use "_COUNT" and use that when checking for 
valid values.

But: we likely want to store "strings" instead of magic numbers from 
user space instead.

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

That should likely not be required. The values are all 0.

If other values are ever required, they could be initialized right with 
the variable:

static struct advisor_ctx advisor_ctx = {
	.start_scan = 0,
	...
};

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
> +	/*
> +	 * Calculate scan time as percentage of last scan time and use
> +	 * exponentially weighted average to smooth it
> +	 */
> +	change = scan_time * 100 / last_scan_time;
> +	change = change ? change : 1;
> +	change = ewma(advisor_ctx.change, change);
> +
> +	/* Calculate new scan rate based on target scan rate. */
> +	pages = ksm_thread_pages_to_scan * 100 / factor;
> +	/* Update pages_to_scan by weighted change percentage. */
> +	pages = pages * change / 100;
> +
> +	/* Cap new pages_to_scan value */
> +	per_page_cost = ksm_thread_pages_to_scan / cpu_percent;
> +	per_page_cost = per_page_cost ? per_page_cost : 1;
> +
> +	pages = min(pages, per_page_cost * ksm_advisor_max_cpu);
> +	pages = max(pages, per_page_cost * ksm_advisor_min_cpu);
> +	pages = min(pages, ksm_advisor_max_pages);
> +
> +	/* Update advisor context */
> +	advisor_ctx.change = change;
> +	advisor_ctx.scan_time = scan_time;
> +	advisor_ctx.cpu_time = cpu_time;
> +
> +	ksm_thread_pages_to_scan = pages;

While that advisor is active, we should likely disallow changing 
ksm_thread_pages_to_scan using other means.

> +}
> +
> +static void run_advisor(void)
> +{
> +	if (ksm_advisor == KSM_ADVISOR_SCAN_TIME) {
> +		s64 scan_time;
> +
> +		/* Convert scan time to seconds */
> +		scan_time = ktime_ms_delta(ktime_get(), advisor_ctx.start_scan);
> +		scan_time = div_s64(scan_time, MSEC_PER_SEC);
> +		scan_time = scan_time ? scan_time : 1;
> +
> +		scan_time_advisor((unsigned long)scan_time);
> +	}

We could have rescheduled in the meantime, right? Doesn't that mean that 
our CPU load consumption might be wrong in some cases?

> +}
> +
>   #ifdef CONFIG_NUMA
>   /* Zeroed when merging across nodes is not allowed */
>   static unsigned int ksm_merge_across_nodes = 1;
> @@ -2401,6 +2554,7 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
>   
>   	mm_slot = ksm_scan.mm_slot;
>   	if (mm_slot == &ksm_mm_head) {
> +		advisor_ctx.start_scan = ktime_get();

Why do that even without KSM_ADVISOR_SCAN_TIME?

You should probably have two functions:

ksm_advisor_start_scan() [this code, fenced by KSM_ADVISOR_SCAN_TIME]
ksm_advisor_stop_scan() [previous run_advisor]

>   		trace_ksm_start_scan(ksm_scan.seqnr, ksm_rmap_items);
>   
>   		/*
> @@ -2558,6 +2712,8 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
>   	if (mm_slot != &ksm_mm_head)
>   		goto next_mm;
>   
> +	run_advisor();
> +
>   	trace_ksm_stop_scan(ksm_scan.seqnr, ksm_rmap_items);
>   	ksm_scan.seqnr++;
>   	return NULL;
> @@ -3603,6 +3759,7 @@ static int __init ksm_init(void)
>   	zero_checksum = calc_checksum(ZERO_PAGE(0));
>   	/* Default to false for backwards compatibility */
>   	ksm_use_zero_pages = false;
> +	init_advisor();
>   
>   	err = ksm_slab_init();
>   	if (err)

-- 
Cheers,

David / dhildenb

