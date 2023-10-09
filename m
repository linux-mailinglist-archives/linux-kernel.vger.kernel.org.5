Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1224A7BD795
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 11:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345952AbjJIJtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 05:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345863AbjJIJtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:49:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0CBCA
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 02:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696844912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jf3TvYWdWhL977BhygUU/Yo5mqDW4sxxg/0A8rYNaRM=;
        b=aO3rGsouGluts/z4O5AiZQ0Ky2SsXTuwYwPXJztV4aJMpb6emTCADcNHwZw51oKRWFMqEC
        ro4gOs8XOODx3g5yttoKwFBVfinX5FX8qDHDY5XSk/cAq0ayTSI5WeDZDUIr0efv/+Faeb
        hisM/IDbiZ5dJVzeTUItM4HRhRqBay4=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-3pIm2PFSPQeAprIhmqS-Gg-1; Mon, 09 Oct 2023 05:48:30 -0400
X-MC-Unique: 3pIm2PFSPQeAprIhmqS-Gg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5041a779c75so3674949e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 02:48:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696844908; x=1697449708;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jf3TvYWdWhL977BhygUU/Yo5mqDW4sxxg/0A8rYNaRM=;
        b=Pd3iEguL0CfDbWp0CChTrAnKzrlyt14WcwOgRpZKuP8XL7qxl2dyTkPSdGsYdA220I
         /yxeGPKYrOR5rfwGav+HxMYmVyrTcxdSC3DdB51IEuTdMe/wJ5e3R87YAS2osL3DBjI9
         2QjEaYgc+1SWU9mWpKhWSAtV+FZMG9z1xqajQScLJAY9jFpAUwmylI64/ri+i94NKEXg
         YO14MHeG75RQZjCbBNsjU9mhRy3LEJvCSB0HXQJZhkG4bLssUYhLBCDWzj/LOWay7jbC
         fCLzIAUHZFPrAPmXvbxr4OQdGVhE7QZJV+VBseJPeo5CfaZTojG1HIUvpF18zAuKAR7k
         vZcQ==
X-Gm-Message-State: AOJu0YyWh/A5IKakveWBa/DqkYkA1NQ43qrdYys6cg1Vok/i/Hz+Hq3N
        ZagZOYFbDTFc7cWZWJvBAFSfL1kKBwSYV59nMpupE25NteJQc9gluaIUkdv6mhbDMfeN18u9ukm
        GPFdJW/nF7eX3ghzS0XCB1c//83SqKC3C
X-Received: by 2002:a05:6512:ea5:b0:4f8:77db:1d9e with SMTP id bi37-20020a0565120ea500b004f877db1d9emr18579051lfb.12.1696844908484;
        Mon, 09 Oct 2023 02:48:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfSbe4VgAbM9GSYCr0y7y4QoQnRmdJHr78+uQDitdeZXQT9PczzBKrIbievTmuvvOGZ3G03Q==
X-Received: by 2002:a05:6512:ea5:b0:4f8:77db:1d9e with SMTP id bi37-20020a0565120ea500b004f877db1d9emr18579003lfb.12.1696844907431;
        Mon, 09 Oct 2023 02:48:27 -0700 (PDT)
Received: from ?IPV6:2003:cb:c733:6400:ae10:4bb7:9712:8548? (p200300cbc7336400ae104bb797128548.dip0.t-ipconnect.de. [2003:cb:c733:6400:ae10:4bb7:9712:8548])
        by smtp.gmail.com with ESMTPSA id 6-20020a05600c22c600b0040303a9965asm13011530wmg.40.2023.10.09.02.48.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 02:48:27 -0700 (PDT)
Message-ID: <d9e28b8a-dc03-42cf-a6f8-69b2d993cc8d@redhat.com>
Date:   Mon, 9 Oct 2023 11:48:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     Stefan Roesch <shr@devkernel.io>
Cc:     kernel-team@fb.com, akpm@linux-foundation.org, hannes@cmpxchg.org,
        riel@surriel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20231004190249.829015-1-shr@devkernel.io>
 <4509a3b4-16a6-f63e-1dd5-e20c7eadf87d@redhat.com>
 <87fs2nhg14.fsf@devkernel.io>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 0/4] mm/ksm: Add ksm advisor
In-Reply-To: <87fs2nhg14.fsf@devkernel.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.10.23 18:17, Stefan Roesch wrote:
> 
> David Hildenbrand <david@redhat.com> writes:
> 
>> On 04.10.23 21:02, Stefan Roesch wrote:
>>> What is the KSM advisor?
>>> =========================
>>> The ksm advisor automatically manages the pages_to_scan setting to
>>> achieve a target scan time. The target scan time defines how many seconds
>>> it should take to scan all the candidate KSM pages. In other words the
>>> pages_to_scan rate is changed by the advisor to achieve the target scan
>>> time.
>>> Why do we need a KSM advisor?
>>> ==============================
>>> The number of candidate pages for KSM is dynamic. It can often be observed
>>> that during the startup of an application more candidate pages need to be
>>> processed. Without an advisor the pages_to_scan parameter needs to be
>>> sized for the maximum number of candidate pages. With the scan time
>>> advisor the pages_to_scan parameter based can be changed based on demand.
>>> Algorithm
>>> ==========
>>> The algorithm calculates the change value based on the target scan time
>>> and the previous scan time. To avoid pertubations an exponentially
>>> weighted moving average is applied.
>>> The algorithm has a max and min
>>> value to:
>>> - guarantee responsiveness to changes
>>> - to avoid to spend too much CPU
>>> Parameters to influence the KSM scan advisor
>>> =============================================
>>> The respective parameters are:
>>> - ksm_advisor_mode
>>>     0: None (default), 1: scan time advisor
>>> - ksm_advisor_target_scan_time
>>>     how many seconds a scan should of all candidate pages take
>>> - ksm_advisor_min_pages
>>>     minimum value for pages_to_scan per batch
>>> - ksm_advisor_max_pages
>>>     maximum value for pages_to_scan per batch
>>> The parameters are exposed as knobs in /sys/kernel/mm/ksm.
>>> By default the scan time advisor is disabled.
>>
>> What would be the main reason to not have this enabled as default?
>>
> There might be already exisiting users which directly set pages_to_scan
> and tuned the KSM settings accordingly, as the default setting of 100 for
> pages_to_scan is too low for typical workloads.

Good point.

> 
>> IIUC, it is kind-of an auto-tuning of pages_to_scan. Would "auto-tuning"
>> describe it better than "advisor" ?
>>
>> [...]
>>
> 
> I'm fine with auto-tune. I was also thinking about that name, but I
> chose advisor, its a bit less strong and it needs input from the user.
> 

I'm not a native speaker, but "adviser" to me implies that no action is 
taken, only advises are given :) But again, no native speaker.

>>> How is defining a target scan time better?
>>> ===========================================
>>> For an administrator it is more logical to set a target scan time.. The
>>> administrator can determine how many pages are scanned on each scan.
>>> Therefore setting a target scan time makes more sense.
>>> In addition the administrator might have a good idea about the
>>> memory sizing of its respective workloads.
>>
>> Is there any way you could imagine where we could have this just do something
>> reasonable without any user input? IOW, true auto-tuning?
>>
> 
> True auto-tuning might be difficult as users might want to be able to
> choose how aggressive KSM is. Some might want it to be as aggressive as
> possible to get the maximum de-duplication rate. Others might want a
> more balanced approach that takes CPU-consumption into consideration.
> 
> I guess it depends if you are memory-bound, cpu-bound or both.

Agreed, more below.

> 
>> I read above:
>>> - guarantee responsiveness to changes
>>> - to avoid to spend too much CPU
>>
>> whereby both things are accountable/measurable to use that as the input for
>> auto-tuning?
>>
> I'm not sure a true auto-tuning can be achieved. I think we need
> some input from the user
> - How much resources to consume
> - How fast memory changes or how stable memory is
>    (this we might be able to detect)

Setting the pages_to_scan is a bit mystical. Setting upper/lower 
pages_to_scan bounds is similarly mystical, and highly workload dependent.

So I agree that a better abstraction to automatically tune the scanning 
is reasonable. I wonder if we can let the user give better inputs that 
are less workload dependent.

For example, do we need min/max values for pages_to_scan, or can we 
replace it by something better to the auto-tuning algorithm?

IMHO "target scan time" goes into the right direction, but it can still 
be fairly workload dependent. Maybe a "max CPU consumption" or sth. like 
that would similarly help to limit CPU waste, and it could be fairly 
workload dependent.


-- 
Cheers,

David / dhildenb

