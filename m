Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5707CC77A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344348AbjJQP3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235059AbjJQP3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:29:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BC19E
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697556520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=qlqZzEBQcDLAx/rtfamhIzSQPRrDgfFEkwqu0MvOCiE=;
        b=W1bbhore4f/IywY770Vh1yw2ZAtzClTAciS5rZrOTCBPIyKL/9aXnT6NydBpPHazmCXtQr
        SAdpTRQqfy96SSdpPnGm7XAwRlOmo1O99Eh9rhiHuqL8oN7In4FQ+QpWGmtk9+8zWMOQmd
        jGYm1kvKVEFyycagbkUQ11CxRj2+Mhw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-qb_skTd5N_qcVWoPYzuDXQ-1; Tue, 17 Oct 2023 11:28:39 -0400
X-MC-Unique: qb_skTd5N_qcVWoPYzuDXQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-408374a3d6bso2127965e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:28:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697556517; x=1698161317;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qlqZzEBQcDLAx/rtfamhIzSQPRrDgfFEkwqu0MvOCiE=;
        b=Xi9wy8UpRnKR/NiMyxJMxXc0yYJgsEDQNL8yla22oiqsKVpia8WtXctinHzbWIclmd
         mwbZN/QGA46YwLvjusS4CLRNUbH1g9Or0f1S2JZFSbd7Crfh73NYzoAhBLTmdu+pLtud
         YYoC8Y14XreSrXayXMLka52xyhTpUg6W0lUhdxsTWMuRsbCGxoeFvbtUUNX2PECGCJvp
         HF+VrmotI1EgNtdfQRYkQJriuCQMphf/kkYVYB6FQxkeuKUiJmDKEH/ZgwgPShDH0363
         YZYQessJ3tdxfJhVXllsToJHTgye7iS46nYmBuIw+dGL8/tIWbpDVfA1IWDtuEChu7t/
         TkTQ==
X-Gm-Message-State: AOJu0YxjzOv2TjAHz5GYbpwsDJMM1wTNnKe6pwTVLxGHVLVaU/S2n+R2
        0EUuougydIeynIosYbmy0qDomICrB0T5YV81w2joi78FJkxF2M4SQcw7su94HOX5yHXOeXMoHTg
        V448BnBG7D4AdLjGJ2je7FovOpoPbEooF
X-Received: by 2002:a5d:4e01:0:b0:32d:9a88:e36 with SMTP id p1-20020a5d4e01000000b0032d9a880e36mr2211327wrt.2.1697556517153;
        Tue, 17 Oct 2023 08:28:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcNlz0Yxv/DaxmarSq6osIBb3CJ6KzZbsTbAg+Cqro781ION6NzFOhs3bNhGXAUlUxANIRvw==
X-Received: by 2002:a5d:4e01:0:b0:32d:9a88:e36 with SMTP id p1-20020a5d4e01000000b0032d9a880e36mr2211306wrt.2.1697556516722;
        Tue, 17 Oct 2023 08:28:36 -0700 (PDT)
Received: from ?IPV6:2003:cb:c743:5100:93b1:f654:ad11:cd81? (p200300cbc743510093b1f654ad11cd81.dip0.t-ipconnect.de. [2003:cb:c743:5100:93b1:f654:ad11:cd81])
        by smtp.gmail.com with ESMTPSA id l11-20020adff48b000000b0032dbf32bd56sm16995wro.37.2023.10.17.08.28.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 08:28:36 -0700 (PDT)
Message-ID: <60eb2c69-8644-45de-9499-a57dc6dbab61@redhat.com>
Date:   Tue, 17 Oct 2023 17:28:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] mm/ksm: Add ksm advisor
Content-Language: en-US
To:     Stefan Roesch <shr@devkernel.io>
Cc:     kernel-team@fb.com, akpm@linux-foundation.org, hannes@cmpxchg.org,
        riel@surriel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20231004190249.829015-1-shr@devkernel.io>
 <4509a3b4-16a6-f63e-1dd5-e20c7eadf87d@redhat.com>
 <87fs2nhg14.fsf@devkernel.io>
 <d9e28b8a-dc03-42cf-a6f8-69b2d993cc8d@redhat.com>
 <87bkd61n12.fsf@devkernel.io>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <87bkd61n12.fsf@devkernel.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.10.23 18:02, Stefan Roesch wrote:
> 
> David Hildenbrand <david@redhat.com> writes:
> 
>> On 06.10.23 18:17, Stefan Roesch wrote:
>>> David Hildenbrand <david@redhat.com> writes:
>>>
>>>> On 04.10.23 21:02, Stefan Roesch wrote:
>>>>> What is the KSM advisor?
>>>>> =========================
>>>>> The ksm advisor automatically manages the pages_to_scan setting to
>>>>> achieve a target scan time. The target scan time defines how many seconds
>>>>> it should take to scan all the candidate KSM pages. In other words the
>>>>> pages_to_scan rate is changed by the advisor to achieve the target scan
>>>>> time.
>>>>> Why do we need a KSM advisor?
>>>>> ==============================
>>>>> The number of candidate pages for KSM is dynamic. It can often be observed
>>>>> that during the startup of an application more candidate pages need to be
>>>>> processed. Without an advisor the pages_to_scan parameter needs to be
>>>>> sized for the maximum number of candidate pages. With the scan time
>>>>> advisor the pages_to_scan parameter based can be changed based on demand.
>>>>> Algorithm
>>>>> ==========
>>>>> The algorithm calculates the change value based on the target scan time
>>>>> and the previous scan time. To avoid pertubations an exponentially
>>>>> weighted moving average is applied.
>>>>> The algorithm has a max and min
>>>>> value to:
>>>>> - guarantee responsiveness to changes
>>>>> - to avoid to spend too much CPU
>>>>> Parameters to influence the KSM scan advisor
>>>>> =============================================
>>>>> The respective parameters are:
>>>>> - ksm_advisor_mode
>>>>>      0: None (default), 1: scan time advisor
>>>>> - ksm_advisor_target_scan_time
>>>>>      how many seconds a scan should of all candidate pages take
>>>>> - ksm_advisor_min_pages
>>>>>      minimum value for pages_to_scan per batch
>>>>> - ksm_advisor_max_pages
>>>>>      maximum value for pages_to_scan per batch
>>>>> The parameters are exposed as knobs in /sys/kernel/mm/ksm.
>>>>> By default the scan time advisor is disabled.
>>>>
>>>> What would be the main reason to not have this enabled as default?
>>>>
>>> There might be already exisiting users which directly set pages_to_scan
>>> and tuned the KSM settings accordingly, as the default setting of 100 for
>>> pages_to_scan is too low for typical workloads.
>>
>> Good point.
>>
>>>
>>>> IIUC, it is kind-of an auto-tuning of pages_to_scan. Would "auto-tuning"
>>>> describe it better than "advisor" ?
>>>>
>>>> [...]
>>>>
>>> I'm fine with auto-tune. I was also thinking about that name, but I
>>> chose advisor, its a bit less strong and it needs input from the user.
>>>
>>
>> I'm not a native speaker, but "adviser" to me implies that no action is taken,
>> only advises are given :) But again, no native speaker.
>>
>>>>> How is defining a target scan time better?
>>>>> ===========================================
>>>>> For an administrator it is more logical to set a target scan time.. The
>>>>> administrator can determine how many pages are scanned on each scan.
>>>>> Therefore setting a target scan time makes more sense.
>>>>> In addition the administrator might have a good idea about the
>>>>> memory sizing of its respective workloads.
>>>>
>>>> Is there any way you could imagine where we could have this just do something
>>>> reasonable without any user input? IOW, true auto-tuning?
>>>>
>>> True auto-tuning might be difficult as users might want to be able to
>>> choose how aggressive KSM is. Some might want it to be as aggressive as
>>> possible to get the maximum de-duplication rate. Others might want a
>>> more balanced approach that takes CPU-consumption into consideration.
>>> I guess it depends if you are memory-bound, cpu-bound or both.
>>
>> Agreed, more below.
>>
>>>
>>>> I read above:
>>>>> - guarantee responsiveness to changes
>>>>> - to avoid to spend too much CPU
>>>>
>>>> whereby both things are accountable/measurable to use that as the input for
>>>> auto-tuning?
>>>>
>>> I'm not sure a true auto-tuning can be achieved. I think we need
>>> some input from the user
>>> - How much resources to consume
>>> - How fast memory changes or how stable memory is
>>>     (this we might be able to detect)
>>
>> Setting the pages_to_scan is a bit mystical. Setting upper/lower pages_to_scan
>> bounds is similarly mystical, and highly workload dependent.
>>
>> So I agree that a better abstraction to automatically tune the scanning is
>> reasonable. I wonder if we can let the user give better inputs that are less
>> workload dependent.
>>
>> For example, do we need min/max values for pages_to_scan, or can we replace it
>> by something better to the auto-tuning algorithm?
>>
>> IMHO "target scan time" goes into the right direction, but it can still be
>> fairly workload dependent. Maybe a "max CPU consumption" or sth. like that would
>> similarly help to limit CPU waste, and it could be fairly workload dependent.
> 
> I can look into replacing min/max values for pages_to_scan with min/max
> cpu utilization. This might be easier for users to decide on. However I
> still think that we need a target value like scan time to optimize for.

Agreed, it can't be completely automatic.

-- 
Cheers,

David / dhildenb

