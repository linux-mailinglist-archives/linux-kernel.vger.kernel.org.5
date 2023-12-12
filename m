Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7EC80EDEF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376328AbjLLNpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346660AbjLLNpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:45:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFDAF7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 05:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702388744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=UepGytcdOyzcSccbTHC7MPkRQKFLI21tGVw9d/A2bBo=;
        b=H9WSDW6f7nEFnnujUP/s7jTeJH6DMVPwY/VVzf8DQbAogqy7qTDldIHMf4KczjFG7yrgD+
        8NSOH6tf/SBVx+RkjMUnfLhH2eaqjZG6jpLC5OfX4QYBfaTwavYOjCdqERuqpCp1stqFT8
        rUK2QMwa+hi6ToIqb0sp8kPrasJHrz0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-0i2oeVTmPDCo7RSyHLIDGQ-1; Tue, 12 Dec 2023 08:45:42 -0500
X-MC-Unique: 0i2oeVTmPDCo7RSyHLIDGQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40c2dd83bc4so33864055e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 05:45:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702388741; x=1702993541;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UepGytcdOyzcSccbTHC7MPkRQKFLI21tGVw9d/A2bBo=;
        b=OoIk4VYelvT3HEelZe8j/iNDpsQFnqZy7F9/gNTvweEfpmDxGogyio+S8UK31KJ9Y/
         TpiHH4aPk7MfJi7uvrbUyO9eCoJlz0K7InpuqFfGh7FaLkJ85HYoSyU+BhaiC1WaAGwj
         u9ek9u6sL/32l+QxmuJReD+5SlUi+GAONflQcHQwf2rgf+K5JbYYwev4h4YNJEiBDkWc
         2rN28fEGPF1LNOzPyXy6JjEz2uoAp7a6pFChPOmxzDIwNIvzNRlPZUoEz36Tovsk34Y7
         9+4Jkl1BMdbcr0KJNoP5VVBA6alWF0JhxDINOV1OHkw2UTMozDZLZPscpWjcUjhumWke
         lq9w==
X-Gm-Message-State: AOJu0Yzchz3RkhB0DXDPrLAUViOKKYJkfAKzu4PnjxGbbVXAQ6U3RzOA
        RYK3PcvCChXivnVablbNB+eHaTb03Y/IMgLSy8EBrVDz+TllmHmCS16O19q/F/ZhUx5dvMBklF6
        4mPMngH2UjgUkixeP2YA1SZMt
X-Received: by 2002:a05:600c:1715:b0:40c:2bfa:fb03 with SMTP id c21-20020a05600c171500b0040c2bfafb03mr2859316wmn.72.1702388741417;
        Tue, 12 Dec 2023 05:45:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHd+An8QCmlQVZ+U53kq7SOOHyVxwOHR9N+B8aAHfIrTr1fwzM854k8Zm4pYiMs2orOax1hhw==
X-Received: by 2002:a05:600c:1715:b0:40c:2bfa:fb03 with SMTP id c21-20020a05600c171500b0040c2bfafb03mr2859311wmn.72.1702388741042;
        Tue, 12 Dec 2023 05:45:41 -0800 (PST)
Received: from ?IPV6:2003:cb:c74b:ca00:4ca2:ff2c:9092:f070? (p200300cbc74bca004ca2ff2c9092f070.dip0.t-ipconnect.de. [2003:cb:c74b:ca00:4ca2:ff2c:9092:f070])
        by smtp.gmail.com with ESMTPSA id e10-20020adffd0a000000b003334675634bsm10885476wrr.29.2023.12.12.05.45.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 05:45:40 -0800 (PST)
Message-ID: <2bbbd69e-0804-4f9c-8aca-572032eeedf8@redhat.com>
Date:   Tue, 12 Dec 2023 14:45:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] mm/ksm: add tracepoint for ksm advisor
Content-Language: en-US
To:     Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, riel@surriel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20231204234906.1237478-1-shr@devkernel.io>
 <20231204234906.1237478-4-shr@devkernel.io>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231204234906.1237478-4-shr@devkernel.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.12.23 00:49, Stefan Roesch wrote:
> This adds a new tracepoint for the ksm advisor. It reports the last scan
> time, the new setting of the pages_to_scan parameter and the average cpu
> percent usage of the ksmd background thread for the last scan.
> 
> Signed-off-by: Stefan Roesch <shr@devkernel.io>
> ---
>   include/trace/events/ksm.h | 33 +++++++++++++++++++++++++++++++++
>   mm/ksm.c                   |  1 +
>   2 files changed, 34 insertions(+)
> 
> diff --git a/include/trace/events/ksm.h b/include/trace/events/ksm.h
> index b5ac35c1d0e88..e728647b5d268 100644
> --- a/include/trace/events/ksm.h
> +++ b/include/trace/events/ksm.h
> @@ -245,6 +245,39 @@ TRACE_EVENT(ksm_remove_rmap_item,
>   			__entry->pfn, __entry->rmap_item, __entry->mm)
>   );
>   
> +/**
> + * ksm_advisor - called after the advisor has run
> + *
> + * @scan_time:		scan time in seconds
> + * @pages_to_scan:	new pages_to_scan value
> + * @cpu_percent:	cpu usage in percent
> + *
> + * Allows to trace the ksm advisor.
> + */
> +TRACE_EVENT(ksm_advisor,
> +
> +	TP_PROTO(s64 scan_time, unsigned long pages_to_scan,
> +		 unsigned int cpu_percent),
> +
> +	TP_ARGS(scan_time, pages_to_scan, cpu_percent),
> +
> +	TP_STRUCT__entry(
> +		__field(s64,		scan_time)
> +		__field(unsigned long,	pages_to_scan)
> +		__field(unsigned int,	cpu_percent)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->scan_time	= scan_time;
> +		__entry->pages_to_scan	= pages_to_scan;
> +		__entry->cpu_percent	= cpu_percent;
> +	),
> +
> +	TP_printk("ksm scan time %lld pages_to_scan %lu cpu percent %u",
> +			__entry->scan_time, __entry->pages_to_scan,
> +			__entry->cpu_percent)
> +);
> +
>   #endif /* _TRACE_KSM_H */
>   
>   /* This part must be outside protection */
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 18b7185bbc65b..b8065c5d5f833 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -455,6 +455,7 @@ static void scan_time_advisor(void)
>   	advisor_ctx.cpu_time = cpu_time;
>   
>   	ksm_thread_pages_to_scan = pages;
> +	trace_ksm_advisor(scan_time, pages, cpu_percent);
>   }
>   
>   static void run_advisor(void)

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

