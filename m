Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BA97FA772
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 18:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbjK0RDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 12:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbjK0RDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 12:03:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E7276BA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 08:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701104337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=XMg0UCw7ncShwMtFI9YG6sbkvvyS81hZIPOGyu2PItU=;
        b=X5J31S7iI0GrGVaH311nMz9sUe2R0h0DaT4qzSuBHRljeC8N4iWnwi9oh/4U99T+95PzjQ
        dc/5UsPEdghR0wHO8HKc+rlSPSOX5CQhUcq9AbXP3Kxx2q0dM2PsL4wu0VMAW2PKp9orb0
        yj0qEEp9a7ofnRUltAmuKOcgR1bzoZU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-U4da2kPPMkOnFBDwIsA8PQ-1; Mon, 27 Nov 2023 11:58:55 -0500
X-MC-Unique: U4da2kPPMkOnFBDwIsA8PQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-332e2f70092so3144755f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 08:58:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701104334; x=1701709134;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XMg0UCw7ncShwMtFI9YG6sbkvvyS81hZIPOGyu2PItU=;
        b=wXFZlr0i2jCCd7bmqOtXzWiiwVuye+SYtb3T4CzuzBXqxjVzKVX5DnW8yIeNRoz4AN
         PFUaz4wu1En87oV1tjb2q8xFrTRVirwIPviHLtXyfNpADQMNuy3kY4hbswKYzW/yiVhy
         UCQkyq72bC6hdHeR67q/DrJ6UizZwgA8Er3hdsOSRQLb98SNjJMUTn+Agett3qFmy0Os
         /L160FYvGM7yAZMwVbiQia5kmZl0p3R9VR5DQ2MH1Lg8T1tbLbW7GAcvSMBOPU4L7pae
         gbBKllSOUstdnK6TTA1bNMSNlk3LOof0X7SYAkcACdxiZmxFz2rupci04poO6iwuL5zJ
         RJQw==
X-Gm-Message-State: AOJu0YxiNuS8fPApGL6yYQmF0wfbE2mDlryw5r442SROTMNAdeEkpA7C
        K91BzNS1XBDV9lem9MblJmsrV2O1nrm6Z0IFs316JZ9wz6KlmAJYMPw4Hmpk6qxiFWNWrO6P7fT
        3dpO2btQXsjUJJMgH3gI+bY8N
X-Received: by 2002:a5d:5273:0:b0:331:6ad3:857 with SMTP id l19-20020a5d5273000000b003316ad30857mr8810743wrc.16.1701104334503;
        Mon, 27 Nov 2023 08:58:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkb1qMBwdaK5OKbqHyvO8vII4UsazWfZXMxlnMnXEG1jHUb4fu4JABuF77+v1aRM34CscZJg==
X-Received: by 2002:a5d:5273:0:b0:331:6ad3:857 with SMTP id l19-20020a5d5273000000b003316ad30857mr8810701wrc.16.1701104333179;
        Mon, 27 Nov 2023 08:58:53 -0800 (PST)
Received: from ?IPV6:2003:cb:c745:2a00:d74a:a8c5:20b6:3ec3? (p200300cbc7452a00d74aa8c520b63ec3.dip0.t-ipconnect.de. [2003:cb:c745:2a00:d74a:a8c5:20b6:3ec3])
        by smtp.gmail.com with ESMTPSA id s11-20020adfeccb000000b003316b38c625sm12583163wro.99.2023.11.27.08.58.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 08:58:52 -0800 (PST)
Message-ID: <18d06a3d-b75f-4ac9-8791-8391a3f60575@redhat.com>
Date:   Mon, 27 Nov 2023 17:58:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] s390/mm: implement
 MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE notifiers
Content-Language: en-US
To:     Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20231127082023.2079810-1-sumanthk@linux.ibm.com>
 <20231127082023.2079810-5-sumanthk@linux.ibm.com>
 <abbe4d53-e944-46cc-90fc-a0a65e50b2fe@redhat.com>
 <ZWS/5ZzhGzt6ykfq@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZWS/5ZzhGzt6ykfq@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
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

On 27.11.23 17:12, Sumanth Korikkar wrote:
> On Mon, Nov 27, 2023 at 04:11:05PM +0100, David Hildenbrand wrote:
>>> diff --git a/drivers/s390/char/sclp_cmd.c b/drivers/s390/char/sclp_cmd.c
>>> index 355e63e44e95..30b829e4c052 100644
>>> --- a/drivers/s390/char/sclp_cmd.c
>>> +++ b/drivers/s390/char/sclp_cmd.c
>>> @@ -18,6 +18,7 @@
>>>    #include <linux/mm.h>
>>>    #include <linux/mmzone.h>
>>>    #include <linux/memory.h>
>>> +#include <linux/memory_hotplug.h>
>>>    #include <linux/module.h>
>>>    #include <asm/ctlreg.h>
>>>    #include <asm/chpid.h>
>>> @@ -26,6 +27,7 @@
>>>    #include <asm/sclp.h>
>>>    #include <asm/numa.h>
>>>    #include <asm/facility.h>
>>> +#include <asm/page-states.h>
>>>    #include "sclp.h"
>>> @@ -319,6 +321,7 @@ static bool contains_standby_increment(unsigned long start, unsigned long end)
>>>    static int sclp_mem_notifier(struct notifier_block *nb,
>>>    			     unsigned long action, void *data)
>>>    {
>>> +	struct memory_block *memory_block;
>>>    	unsigned long start, size;
>>>    	struct memory_notify *arg;
>>>    	unsigned char id;
>>> @@ -340,18 +343,29 @@ static int sclp_mem_notifier(struct notifier_block *nb,
>>>    		if (contains_standby_increment(start, start + size))
>>>    			rc = -EPERM;
>>>    		break;
>>> -	case MEM_GOING_ONLINE:
>>> +	case MEM_PREPARE_ONLINE:
>>> +		memory_block = find_memory_block(pfn_to_section_nr(arg->start_pfn));
>>> +		if (!memory_block) {
>>> +			rc = -EINVAL;
>>> +			goto out;
>>> +		}
>>>    		rc = sclp_mem_change_state(start, size, 1);
>>> +		if (rc || !memory_block->altmap)
>>> +			goto out;
>>> +		/*
>>> +		 * Set CMMA state to nodat here, since the struct page memory
>>> +		 * at the beginning of the memory block will not go through the
>>> +		 * buddy allocator later.
>>> +		 */
>>> +		__arch_set_page_nodat((void *)__va(start), memory_block->altmap->free);
>>
>> Looking up the memory block and grabbing the altmap from there is a bit
>> unfortunate.
>>
>> Why can't we do that when adding the altmap? Will the hypervisor scream at
>> us?
>>
> calling __arch_set_page_nodat() before making memory block accessible
> will lead to crash. Hence, we think this is the only safe location to
> place it.
> 
>> ... would we want to communicate any altmap start+size via the memory
>> notifier instead?
> 
> Passing start, size  of memory range via memory notifier looks correct
> approach to me, as we try to make the specified range accessible.
> 
> If we want to pass altmap size (nr_vmemmap_pages), then we might need a
> new field in struct memory_notify, which would prevent access of
> memory_block->altmap->free in the notifier.
> 
> Do you want to take this approach instead?
> 
> If yes, Then I could add a new field nr_vmemmap_pages in struct
> memory_notify and place it in PATCH : introduce
> MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE notifiers.

Yes, see my other mail. That's probably cleanest!

-- 
Cheers,

David / dhildenb

