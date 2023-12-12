Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C8380EDE5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346661AbjLLNoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346664AbjLLNoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:44:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4073610A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 05:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702388648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=hA6MgSb2PJwlC5hE4aqc0PoWaCVTFbqewmTVV0LvrI8=;
        b=ApgPE3OuUPE95CReVb1WaXYhQ8DGQYt3OSad5fX8D1aku2XPvpmM/ddpgmFozOTOs00TkH
        a9kri+80XHxKyxumwov/UsqvrH+kj/i9oQnsDrzGkc9CWmOBytspCOf7iBADBA0Fi9n2h7
        yu9f6d2Uo+0pBM1BoUKJhbEsmhLKFPo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-XcLNrklAPGmomkfaSQp0mQ-1; Tue, 12 Dec 2023 08:44:07 -0500
X-MC-Unique: XcLNrklAPGmomkfaSQp0mQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3334e7d1951so4961794f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 05:44:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702388646; x=1702993446;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hA6MgSb2PJwlC5hE4aqc0PoWaCVTFbqewmTVV0LvrI8=;
        b=HZ88AglB4apykQNeXoe5LPcSxJK/ddo89yqTsr0FS8w+6nQg3wY/GHOZdSINtzNRhj
         8GQJd26vCTAMwZ6/iCTYetTuHc+UdAlPSaXDMduFYZJtpS2gLEKBpyAHKlLCWdA4KsTH
         onPs9Wx3xbx715i+q8sV1ajcqcmeykzlfaPDpHBdQpCODuYQwm1FOXTGu4mnHP4OrD0P
         iZmBcSGCDkIhrzypfJeUm6dVU9T6g1iSGQeXOPU6QXNoePpGnWALVjG5Giang/oQCOA6
         QoVwo3Q1uToLexwFvHDmdyy9YvP1cnHa00OIR8maoCiQ4cnVlII70GZnYZQGvxU3Ok92
         SVqg==
X-Gm-Message-State: AOJu0YxhsHkuw3lNHH3KImqk0KAtY/6Tzh7jxW/TTVkH5VvGzdV+FIor
        bc9hZaMn/oCopp6pXvNrPROB7iDKMrQu0jNdR3Ya1ZpUUr6kSBdhhOjrw5qsH8ILVx+/LWGMaZN
        Q1VaZjgiUhT/y4uaAl5UriURO
X-Received: by 2002:a05:6000:108a:b0:333:4635:c914 with SMTP id y10-20020a056000108a00b003334635c914mr1549986wrw.82.1702388645882;
        Tue, 12 Dec 2023 05:44:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEyE4F/4GR4EDpwrcUQaaTWk3vuNTFc3KPZN+65zyiQXDh0tlDd/vsem7LfIDq8E7uICaIbrQ==
X-Received: by 2002:a05:6000:108a:b0:333:4635:c914 with SMTP id y10-20020a056000108a00b003334635c914mr1549980wrw.82.1702388645478;
        Tue, 12 Dec 2023 05:44:05 -0800 (PST)
Received: from ?IPV6:2003:cb:c74b:ca00:4ca2:ff2c:9092:f070? (p200300cbc74bca004ca2ff2c9092f070.dip0.t-ipconnect.de. [2003:cb:c74b:ca00:4ca2:ff2c:9092:f070])
        by smtp.gmail.com with ESMTPSA id e10-20020adffd0a000000b003334675634bsm10885476wrr.29.2023.12.12.05.44.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 05:44:05 -0800 (PST)
Message-ID: <9f81f89f-c3ad-4cef-a619-ad36348c8ef5@redhat.com>
Date:   Tue, 12 Dec 2023 14:44:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] mm/ksm: add ksm advisor
Content-Language: en-US
To:     Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, riel@surriel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20231204234906.1237478-1-shr@devkernel.io>
 <20231204234906.1237478-2-shr@devkernel.io>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231204234906.1237478-2-shr@devkernel.io>
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

[...]

> +
> +/**
> + * struct advisor_ctx - metadata for KSM advisor
> + * @start_scan: start time of the current scan
> + * @scan_time: scan time of previous scan
> + * @change: change in percent to pages_to_scan parameter
> + * @cpu_time: cpu time consumed by the ksmd thread in the previous scan
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
> +	KSM_ADVISOR_SCAN_TIME,
> +};
> +static enum ksm_advisor_type ksm_advisor;
> +
> +static void init_advisor(void)
> +{
> +	advisor_ctx = (const struct advisor_ctx){ 0 };
> +}

Again, you can drop this completely. The static values are already 
initialized to 0.

Or is there any reason to initialize to 0 explicitly?

> +
> +static void set_advisor_defaults(void)
> +{
> +	if (ksm_advisor == KSM_ADVISOR_NONE)
> +		ksm_thread_pages_to_scan = DEFAULT_PAGES_TO_SCAN;
> +	else if (ksm_advisor == KSM_ADVISOR_SCAN_TIME)
> +		ksm_thread_pages_to_scan = ksm_advisor_min_pages;
> +}

That function is unused?

> +
> +static inline void advisor_start_scan(void)
> +{
> +	if (ksm_advisor == KSM_ADVISOR_SCAN_TIME)
> +		advisor_ctx.start_scan = ktime_get();
> +}
> +
> +static inline s64 advisor_stop_scan(void)
> +{
> +	return ktime_ms_delta(ktime_get(), advisor_ctx.start_scan);
> +}

Just inline that into the caller. Then rename run_advisor() into 
advisor_stop_scan(). So in scan_get_next_rmap_item)( you have paired 
start+stop hooks.

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

s/pertubations/perturbations/

Do you also want to describe how min/max CPU comes into play?

> + * A new change factor is calculated for each iteration and it uses an
> + * exponentially weighted moving average. The new pages_to_scan value is
> + * multiplied with that change factor:
> + *
> + *      new_pages_to_scan *= change facor
> + *
> + * In addition the new pages_to_scan value is capped by the max and min
> + * limits.
> + */



With that, LGTM

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

