Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76C17CA181
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbjJPIYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjJPIYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:24:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E89A2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 01:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697444600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6yKDePwtzTa+USWKPH07FF4dsILlQgoX/L1Fc3rLl0E=;
        b=M0+L43JkVcuT/Fy7my+h/hn2WrEn8XvA0QKecJKB5/eZKpLVXx3VbXR+r85GT5ql8uC9ku
        NNoXMiynygSdj5SQxQSP0TQNL4oPdBHYPRfI5Bjc9l0rAjPCoEASz8PhlfjuXo3OBFn/C/
        yX6Ol/P5cYjqoZb5IK2ySGbE859BYQU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-4oI370gcNL29q-HRmn7qcA-1; Mon, 16 Oct 2023 04:23:19 -0400
X-MC-Unique: 4oI370gcNL29q-HRmn7qcA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-31fd48da316so2599179f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 01:23:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697444598; x=1698049398;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6yKDePwtzTa+USWKPH07FF4dsILlQgoX/L1Fc3rLl0E=;
        b=hNNRu4gUsMa+5p513wilQFTOViGYjgiT7H9+NhP/yPhw00Nm3Gcr5SyEaKk8tmS3bd
         rigYxo6l0uQ/K62/SAFha0nMRMa89YXwR9Qe2omSbnW3YhIT4Ce2Kp4zjn87rW2ALO8g
         3mQSLXFCRnh3Won4idjd+xVlRgHqFUwR0KFh2CstRXriex8SfONzPfToTH/MFBdisgIQ
         8S2AToc1X5vwZ2Tczia2eDNhCPXGrCZSjxoAM2qMzPmPQys6ZGFFfgEsGk1WGFqOEYNH
         s3ocFKUSZ/55G3HrjkmqEwSNylZFNRtYJ2aRfKQOCiZTNQSqyZfgVbP3TK/FSjPJSZVw
         vmPA==
X-Gm-Message-State: AOJu0YwVSqLLnQtx6A2G2XwUDIErUC+7xK8jEhOfVjxE7lN9kajaeVbV
        /byefKhtA5R1ueb+CcIbYFqo0sGH31QrRR+NzDGD7BI5gQCdrsVRsGkp7OVrykBs9doqHWvUxmr
        IOSCAOCXNQnpO35ectjmDIM4N
X-Received: by 2002:a5d:594c:0:b0:31f:ef77:67ee with SMTP id e12-20020a5d594c000000b0031fef7767eemr30236406wri.40.1697444598355;
        Mon, 16 Oct 2023 01:23:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IER3lZ78xZW6erjzHE/D/mHu65eaq4cnC5JaODMu+8Ut61774H39DoplStarXPslv8yUZczyg==
X-Received: by 2002:a5d:594c:0:b0:31f:ef77:67ee with SMTP id e12-20020a5d594c000000b0031fef7767eemr30236391wri.40.1697444597881;
        Mon, 16 Oct 2023 01:23:17 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73c:9300:8903:bf2e:db72:6527? (p200300cbc73c93008903bf2edb726527.dip0.t-ipconnect.de. [2003:cb:c73c:9300:8903:bf2e:db72:6527])
        by smtp.gmail.com with ESMTPSA id n6-20020adffe06000000b003140f47224csm26564497wrr.15.2023.10.16.01.23.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 01:23:17 -0700 (PDT)
Message-ID: <a46cf10b-d852-c671-ee20-40f39bdbceac@redhat.com>
Date:   Mon, 16 Oct 2023 10:23:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     osalvador@suse.de, dan.j.williams@intel.com, vbabka@suse.cz,
        mgorman@techsingularity.net, aneesh.kumar@linux.ibm.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1697202267-23600-1-git-send-email-quic_charante@quicinc.com>
 <20231014152532.5f3dca7838c2567a1a9ca9c6@linux-foundation.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm/sparsemem: fix race in accessing memory_section->usage
In-Reply-To: <20231014152532.5f3dca7838c2567a1a9ca9c6@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.10.23 00:25, Andrew Morton wrote:
> On Fri, 13 Oct 2023 18:34:27 +0530 Charan Teja Kalla <quic_charante@quicinc.com> wrote:
> 
>> The below race is observed on a PFN which falls into the device memory
>> region with the system memory configuration where PFN's are such that
>> [ZONE_NORMAL ZONE_DEVICE  ZONE_NORMAL]. Since normal zone start and
>> end pfn contains the device memory PFN's as well, the compaction
>> triggered will try on the device memory PFN's too though they end up in
>> NOP(because pfn_to_online_page() returns NULL for ZONE_DEVICE memory
>> sections). When from other core, the section mappings are being removed
>> for the ZONE_DEVICE region, that the PFN in question belongs to,
>> on which compaction is currently being operated is resulting into the
>> kernel crash with CONFIG_SPASEMEM_VMEMAP enabled.
> 
> Seems this bug is four years old, yes?  It must be quite hard to hit.

 From the description, it's not quite clear to me if this was actually 
hit -- usually people include the dmesg bug/crash info.

> 
> When people review this, please offer opinions on whether a fix should
> be backported into -stable kernels, thanks.
> 
>> compact_zone()			memunmap_page
>> -------------			---------------
>> __pageblock_pfn_to_page
>>     ......
>>   (a)pfn_valid():
>>       valid_section()//return true
>> 			      (b)__remove_pages()->
>> 				  sparse_remove_section()->
>> 				    section_deactivate():
>> 				    [Free the array ms->usage and set
>> 				     ms->usage = NULL]
>>       pfn_section_valid()
>>       [Access ms->usage which
>>       is NULL]
>>
>> NOTE: From the above it can be said that the race is reduced to between
>> the pfn_valid()/pfn_section_valid() and the section deactivate with
>> SPASEMEM_VMEMAP enabled.
>>
>> The commit b943f045a9af("mm/sparse: fix kernel crash with
>> pfn_section_valid check") tried to address the same problem by clearing
>> the SECTION_HAS_MEM_MAP with the expectation of valid_section() returns
>> false thus ms->usage is not accessed.
>>
>> Fix this issue by the below steps:
>> a) Clear SECTION_HAS_MEM_MAP before freeing the ->usage.
>> b) RCU protected read side critical section will either return NULL when
>> SECTION_HAS_MEM_MAP is cleared or can successfully access ->usage.
>> c) Synchronize the rcu on the write side and free the ->usage. No
>> attempt will be made to access ->usage after this as the
>> SECTION_HAS_MEM_MAP is cleared thus valid_section() return false.


This affects any kind of memory hotunplug. When hotunplugging memory we 
will end up calling synchronize_rcu() for each and every memory section, 
which sounds extremely wasteful.

Can't we find a way to kfree_rcu() that thing and read/write the pointer 
using READ?ONCE?WRITE_ONCE instead?

-- 
Cheers,

David / dhildenb

