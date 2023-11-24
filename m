Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6607F77EC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 16:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345854AbjKXPhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 10:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345784AbjKXPhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 10:37:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0125719D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 07:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700840226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=Qnms+DPVu8N4Y1chnKBFHigepbquSQ211tXQc+b4C5s=;
        b=X4tOtZgTbMaJy+kWIdMPHPf76MnEnyAifIy+Duyj58yjO98xLevU375VENVdY+jOfd181j
        mZlmTyUr80dSH/KMLyjC4eMa76ORWcjsi5+gR7oFaCIgP/tyuqvWQF8Y1RUuWIEBHEmGiO
        ixXMg5trsR+de8WS2t4VwDNGPYT3Lyk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-4RTzFtKcNXWhUH0LKjsfmg-1; Fri, 24 Nov 2023 10:37:05 -0500
X-MC-Unique: 4RTzFtKcNXWhUH0LKjsfmg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-407da05ee50so10923635e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 07:37:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700840223; x=1701445023;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qnms+DPVu8N4Y1chnKBFHigepbquSQ211tXQc+b4C5s=;
        b=S03QeW4Zi8/09iVH1a+awPmv1tZtgPsCMZJyc9jxsnviGp6MF0t7JW8OZZuTi6LvmS
         GooS0vCb0O2kxlSyV8ZSXy8WK/RGX9gLuVhvOKCrku+keXZQZCQo1VC7mNKsqQdN7g/a
         82hVe35cUPrN6s8G7XTlrcffbt3FOsZGxZiBlXKsGfid7XglQ9+tfpWZ/mkowwstvgRA
         FVha0aH0ZCkzYKGkj10uzed93Q88kzUJfdgfk+iUSiOWLIfVlXd/D3DbN2YT1PsrS/cI
         Wwx73hU4onLe58XtlW641/2Dj3p7PnzLKVvKg/j6ejmpq+QMa1qCC18mdUK4tkgA1U8/
         /49g==
X-Gm-Message-State: AOJu0YwKZO0lIyv89BbegIOzYmzUZtjIgYyHhTPskSAnCsSepfF5Gcc2
        FLLuLNh40v6LH3x7HK+9lTmNJXGZ7EgdcAz66AmwwxN1xmDE1cMs7sP22MuwM0i/OffgNlYS/Wg
        FHIxOxMycM6C8/F5w26XEU4x7
X-Received: by 2002:a05:600c:3c9d:b0:40b:3645:4678 with SMTP id bg29-20020a05600c3c9d00b0040b36454678mr2645121wmb.19.1700840223665;
        Fri, 24 Nov 2023 07:37:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYQuq/hD+iCLBMQH1TfNiQDkYm9QAKMDlKlPX2GvJEXkFR9fgULERONF6qNvYgYuDsgts27w==
X-Received: by 2002:a05:600c:3c9d:b0:40b:3645:4678 with SMTP id bg29-20020a05600c3c9d00b0040b36454678mr2645100wmb.19.1700840223194;
        Fri, 24 Nov 2023 07:37:03 -0800 (PST)
Received: from ?IPV6:2003:cb:c721:a000:7426:f6b4:82a3:c6ab? (p200300cbc721a0007426f6b482a3c6ab.dip0.t-ipconnect.de. [2003:cb:c721:a000:7426:f6b4:82a3:c6ab])
        by smtp.gmail.com with ESMTPSA id jg28-20020a05600ca01c00b004063cd8105csm6128004wmb.22.2023.11.24.07.37.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 07:37:02 -0800 (PST)
Message-ID: <c1c266cd-a943-461e-b8ff-5f2eaba96a35@redhat.com>
Date:   Fri, 24 Nov 2023 16:37:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] mm/ksm: add ksm advisor
To:     Stefan Roesch <shr@devkernel.io>
Cc:     kernel-team@fb.com, akpm@linux-foundation.org, hannes@cmpxchg.org,
        riel@surriel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20231028000945.2428830-1-shr@devkernel.io>
 <20231028000945.2428830-2-shr@devkernel.io>
 <d41ecf6d-d276-406c-a002-f4ffc9d82ef1@redhat.com>
 <8734wxsn4u.fsf@devkernel.io>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <8734wxsn4u.fsf@devkernel.io>
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

>>
> 
> The min cpu case is to make sure that we scan fast enough to be able to
> react fast enough to the changes in the number of pages. This helps in
> determining in how quick we want to react to changes. This helps
> especially with the startup phase of applications.
> 
> We can certainly only set a default value, that is not exposed in sysfs.

Less toggles is better. So if we can just use some sane starting 
default, that would be great.

> 
>>> +/**
>>> + * struct advisor_ctx - metadata for KSM advisor
>>> + * @start_scan: start time of the current scan
>>> + * @scan_time: scan time of previous scan
>>> + * @change: change in percent to pages_to_scan parameter
>>> + * @cpu_percent: average cpu percent usage of the ksmd thread for the last scan
>>> + */
>>> +struct advisor_ctx {
>>> +	ktime_t start_scan;
>>> +	unsigned long scan_time;
>>> +	unsigned long change;
>>> +	unsigned long long cpu_time;
>>> +};
>>> +static struct advisor_ctx advisor_ctx;
>>> +
>>> +/* Define different advisor's */
>>> +enum ksm_advisor_type {
>>> +	KSM_ADVISOR_NONE,
>>> +	KSM_ADVISOR_FIRST = KSM_ADVISOR_NONE,
>>
>> Unused, better drop it. 0 is the implicit first one.
>>
> Will change it accordingly.
> 
>>> +	KSM_ADVISOR_SCAN_TIME,
>>> +	KSM_ADVISOR_LAST = KSM_ADVISOR_SCAN_TIME
>>
>> Instead of "_LAST", maybe use "_COUNT" and use that when checking for valid
>> values.
>>
>> But: we likely want to store "strings" instead of magic numbers from user space
>> instead.
>>
> 
> Any recommendation for the naming of the parameters when I switch to
> strings?

Probably just "none" and "scan-time" ?

>>> +}
>>> +
>>> +static void run_advisor(void)
>>> +{
>>> +	if (ksm_advisor == KSM_ADVISOR_SCAN_TIME) {
>>> +		s64 scan_time;
>>> +
>>> +		/* Convert scan time to seconds */
>>> +		scan_time = ktime_ms_delta(ktime_get(), advisor_ctx.start_scan);
>>> +		scan_time = div_s64(scan_time, MSEC_PER_SEC);
>>> +		scan_time = scan_time ? scan_time : 1;
>>> +
>>> +		scan_time_advisor((unsigned long)scan_time);
>>> +	}
>>
>> We could have rescheduled in the meantime, right? Doesn't that mean that our CPU
>> load consumption might be wrong in some cases?
>>
> Does it matter? I'm interested how long it takes to complete the scan,
> including any scheduling.

But isn't this also required to compute CPU load, so you can stay 
between min-load and max-load?

- ksm_advisor_min_cpu (minimum value for cpu percent usage)
- ksm_advisor_max_cpu (maximum value for cpu percent usage)

Likely, you want to exclude any rescheduling from there?

I'll have to recheck the logic.

-- 
Cheers,

David / dhildenb

