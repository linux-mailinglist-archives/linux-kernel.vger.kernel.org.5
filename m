Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF4D7FA2A0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbjK0O2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbjK0O2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:28:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D03C3251
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701094635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=WhdYJVzXXt1pFzcMraV+31z1/4TvHuz4d3g3ZmURbQM=;
        b=USJ6KXZJ7P5KC1PaoOv5k78Vi+gztWnW/8HPI2DfTTOGmCPMUoC29VZTI8AcnFqKhRLcAF
        XafW5LWeMnZ3Wh/L5KVeIjG4Cq9PTyc7vw2aN7ieve2LsrtChTiRq7csv+hsE1foKVDO5u
        XE4HAAoz0m3xu5v5ImqbIoUoo9VTKic=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-95DKnPkSOeaMZ4bJckznzQ-1; Mon, 27 Nov 2023 09:17:14 -0500
X-MC-Unique: 95DKnPkSOeaMZ4bJckznzQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2c6ec02785eso38741061fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:17:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701094632; x=1701699432;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WhdYJVzXXt1pFzcMraV+31z1/4TvHuz4d3g3ZmURbQM=;
        b=Fol9X4yTYKC21UxQpfLk0h8Kdya/WVnqs35XpY8Oa/7dngXOg4IX4sDFKAVQHAGZKp
         jjSfXEkdqwcOhABL5l5boCPEWCFZh6AyaqaNHNdWfFiZP3WFntwQlH3Om1FxOVnm74Ww
         U83Pk7fdfP/a/5MLha6goapv5PH4ZVtentjfDRxXmGq7KSSCRSYnYClBEzSDPhPs2MU/
         5s5GneDTukjvA5jOdSmSrXGm7NJYB4s7/xhiq0hH/m3iZDhHalg9A5XjYYHmwAyVl/0h
         El1A3zzMLViOyrojNiwCf+K/F9XPyvkNpQZGTZLwuXfDBD7SGtz3CIJFHfdTs/kQXwSd
         k/2w==
X-Gm-Message-State: AOJu0YwTs8zMvd7ZSn0Fuy1uaWXq7lpElP6R4jE1nsh3RJ/U+5seN9kI
        dk3PLvINDvSg5AojZpWHsxDNNz9WIT0Qv6nP3GqXshWmx4wE9hyANWvG/+NKWVDRkhrJn2XjYK1
        ISwSqvnomXc3zhAzOHsEIyhjp
X-Received: by 2002:a2e:8e74:0:b0:2c9:a1d1:813a with SMTP id t20-20020a2e8e74000000b002c9a1d1813amr2072722ljk.34.1701094632451;
        Mon, 27 Nov 2023 06:17:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1PrTvT0NMBqX8K/GrsQzYFyAxRUQe585T2EOMwi7DPCweyKFbMAI/onPivKWNoOcn9rBpSA==
X-Received: by 2002:a2e:8e74:0:b0:2c9:a1d1:813a with SMTP id t20-20020a2e8e74000000b002c9a1d1813amr2072651ljk.34.1701094631233;
        Mon, 27 Nov 2023 06:17:11 -0800 (PST)
Received: from ?IPV6:2003:cb:c745:2a00:d74a:a8c5:20b6:3ec3? (p200300cbc7452a00d74aa8c520b63ec3.dip0.t-ipconnect.de. [2003:cb:c745:2a00:d74a:a8c5:20b6:3ec3])
        by smtp.gmail.com with ESMTPSA id j12-20020a05600c190c00b0040b3b6a0e1fsm10504290wmq.13.2023.11.27.06.17.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 06:17:10 -0800 (PST)
Message-ID: <974467f0-de25-40d4-8a8b-1c7e0b91e719@redhat.com>
Date:   Mon, 27 Nov 2023 15:17:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v7 09/10] selftests/mm/cow: Generalize
 do_run_with_thp() helper
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20231122162950.3854897-1-ryan.roberts@arm.com>
 <20231122162950.3854897-10-ryan.roberts@arm.com>
 <ead82cbe-19c9-43ce-9f28-7ced118b130a@redhat.com>
 <15c288aa-feab-4d3a-af33-b87481eaffe3@arm.com>
 <1ebb9a53-63ee-430c-ba65-8e48eff6d25c@redhat.com>
 <f3008ba2-82c2-47e3-9153-139a9442123b@arm.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <f3008ba2-82c2-47e3-9153-139a9442123b@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 27.11.23 15:11, Ryan Roberts wrote:
> On 27/11/2023 13:59, David Hildenbrand wrote:
>>>>
>>>>> +    pmdsize = read_pmd_pagesize();
>>>>> +    if (pmdsize)
>>>>> +        ksft_print_msg("[INFO] detected PMD-mapped THP size: %zu KiB\n",
>>>>
>>>> Maybe simply: "detected PMD size". Zes, we read it via the THP interface, but
>>>> that shouldn't matter much.
>>>
>>> Err, just want to clarify what you are suggesting. With the current patch you
>>> will see something like:
>>
>> Not with this patch, but with the other ones, yes :)
> 
> Yep, we are on the same page (folio)...
> 
>>
>>>
>>> [INFO] detected PMD-mapped THP size: 2048 KiB
>>> [INFO] detected small-sized THP size: 64 KiB
>>> [INFO] detected small-sized THP size: 128 KiB
>>> ...
>>> [INFO] detected small-sized THP size: 1024 KiB
>>>
>>>
>>> Are you suggesting something like this:
>>>
>>> [INFO] detected PMD size: 2048 KiB
>>> [INFO] detected THP size: 64 KiB
>>> [INFO] detected THP size: 128 KiB
>>> ...
>>> [INFO] detected THP size: 2048 KiB
>>>
>>
>> Yes. If you'd detect that 2M is actually disabled, you could still log the PMD
>> size only.
> 
> Note that in the final patch, where I test the other THP sizes, I'm not
> detecting which sizes the sysadmin has enabled, I'm detecting the set of sizes
> that can be enabled, then explicitly enabling the size (exclusively) when I test
> it. So there is no chance of reading PMD size but not having 2M THP. Minor point
> though.

Ah, makes sense, I missed that and thought we'd check if that size is 
actually possible.

-- 
Cheers,

David / dhildenb

