Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA354751100
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 21:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbjGLTK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 15:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjGLTK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 15:10:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32ED1BFA
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 12:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689189011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LpyHkpVso0b8a+p6JmqDgDKJ26YHuwzqKI5Da7hz1I8=;
        b=GM5nYP+hR2+/e8j/H63+ZJtci23eA7pD9XBITB8yDFvl9tFfNZInaUAeing8SeU3K+G9dX
        mlGcB5v3kQXCMVw0QFLN0sGX53u1iHKl5ycoL0xMOoHxYCdtTsEEnF3oAoIiKQizSIinxC
        JBGtRJn5V3SclkDJk7GCRI7B7wv32zc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-EfRX5tXqMIer0WnabP1Hug-1; Wed, 12 Jul 2023 15:10:10 -0400
X-MC-Unique: EfRX5tXqMIer0WnabP1Hug-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-30e4943ca7fso3869216f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 12:10:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689189009; x=1691781009;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LpyHkpVso0b8a+p6JmqDgDKJ26YHuwzqKI5Da7hz1I8=;
        b=Rc8ps7rxkRkdmmFpuKvULGys/PPyzYTATqygtO/VP2PEjVZen4xFmJ6E44Tph4C4v6
         VkwSFCL6Njr0jfp7GK71h+ndipzxQ8EhaQqZRa6V47sbHDMa/qGoq+fXiBaMLiBhPmuN
         wlQhTzArmYoUHFO76GYoATOzLJLjU3uB5WI70ACmCxkdxoehf2fgwkWB7MMdJlPrGOg7
         LO9RK4AJ3W391Z08WN61RjpKqKzKdbhdhXMKoPMeG6Wt62s22bQ5Zl/o+T/9cPnGhhl+
         trw3jmtOSzwhqJBqbqTIAwOQ/TReCXIzfRasyMXTKlp5t1ZaKrguxDVY+drfuTB4RJsy
         ycvQ==
X-Gm-Message-State: ABy/qLawhYBCEk6vUOB2ryReK6WG5wdD71sZ/jIhy+QrARl6PitRTi7b
        PH5R4Bxll4JO+UxDv/TCEJp5o3WvfzNUQwBeH1y9/8KC1IzqrWFaeuzetxDfDOFXdlmx+B44+Hv
        atrF8zZE9dZXgOn1HTDV9k3T1
X-Received: by 2002:a5d:664d:0:b0:313:ee2e:dae1 with SMTP id f13-20020a5d664d000000b00313ee2edae1mr16045096wrw.18.1689189009180;
        Wed, 12 Jul 2023 12:10:09 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGMGfFIaXHwBrDx1CqxjskLjhy5sdzusnHEp8jN2HIPDxRD+vAGQJNr4BZ6vOAZC+oUwBNggg==
X-Received: by 2002:a5d:664d:0:b0:313:ee2e:dae1 with SMTP id f13-20020a5d664d000000b00313ee2edae1mr16045086wrw.18.1689189008931;
        Wed, 12 Jul 2023 12:10:08 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:3700:3eea:ace6:5bde:4478? (p200300cbc70737003eeaace65bde4478.dip0.t-ipconnect.de. [2003:cb:c707:3700:3eea:ace6:5bde:4478])
        by smtp.gmail.com with ESMTPSA id k8-20020a5d5188000000b00314172ba213sm5718522wrv.108.2023.07.12.12.10.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 12:10:08 -0700 (PDT)
Message-ID: <6d24ff50-b463-f2cd-09c8-fb6eb73d5c07@redhat.com>
Date:   Wed, 12 Jul 2023 21:10:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1] mm/memory_hotplug: document the signal_pending() check
 in offline_pages()
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230711174050.603820-1-david@redhat.com>
 <6e473d64-fbbc-db12-99ee-d32768d8af85@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <6e473d64-fbbc-db12-99ee-d32768d8af85@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.07.23 08:47, Anshuman Khandual wrote:
> 
> 
> On 7/11/23 23:10, David Hildenbrand wrote:
>> Let's update the documentation that any signal is sufficient, and
>> add a comment that not only checking for fatal signals is historical
>> baggage: changing it now could break existing user space. although
>> unlikely.
>>
>> For example, when an app provides a custom SIGALRM handler and triggers
>> memory offlining, the timeout cmd would no longer stop memory offlining,
>> because SIGALRM would no longer be considered a fatal signal.
>>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   Documentation/admin-guide/mm/memory-hotplug.rst | 2 +-
>>   mm/memory_hotplug.c                             | 5 +++++
>>   2 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
>> index 1b02fe5807cc..bd77841041af 100644
>> --- a/Documentation/admin-guide/mm/memory-hotplug.rst
>> +++ b/Documentation/admin-guide/mm/memory-hotplug.rst
>> @@ -669,7 +669,7 @@ when still encountering permanently unmovable pages within ZONE_MOVABLE
>>   (-> BUG), memory offlining will keep retrying until it eventually succeeds.
>>   
>>   When offlining is triggered from user space, the offlining context can be
>> -terminated by sending a fatal signal. A timeout based offlining can easily be
>> +terminated by sending a signal. A timeout based offlining can easily be
>>   implemented via::
>>   
>>   	% timeout $TIMEOUT offline_block | failure_handling
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index 3f231cf1b410..7cfd13c91568 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -1843,6 +1843,11 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
>>   	do {
>>   		pfn = start_pfn;
>>   		do {
>> +			/*
>> +			 * Historically we always checked for any signal and
>> +			 * can't limit it to fatal signals without eventually
>> +			 * breaking user space.> +			 */
> 
> Just curious, could 'signal type' to stop memory offline process be considered
> an ABI and cannot be changed in kernel ever if required ? Just wondering if an
> additional '!fatal_signal_pending()' check be introduced to warn about support
> being deprecated, before finally replacing it with fatal_signal_pending().

See my reply to Michal, while that would be doable it is probably not 
worth the effort, and we'd still have to stick with the existing 
handling for quite a while.

Thanks!

-- 
Cheers,

David / dhildenb

