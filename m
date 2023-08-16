Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5970B77E4D3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344047AbjHPPNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344098AbjHPPMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:12:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3271D10EC
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 08:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692198721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kjSGmNTgIVSKKOhkrl2rww2pco147cpSwYmgtMlFC8o=;
        b=Q5G/FPCaY1pk/tR9b1qMlv43256Nq/tOyAfp74GnYv+JzyNSDSaBKTz2fRXks0QBaN6/33
        0+qguiUbUT9+GkIwGtlXcp5jkCQ9QYgydPRmb7NCRV93EBk/mAc0iPzCAfq9OjqZ1qgHP/
        gK2K1pXvYT1nZzzVSAj2p3KTnN/22XM=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-USNzRtfHPgCDbZ6WUGTdTA-1; Wed, 16 Aug 2023 11:11:58 -0400
X-MC-Unique: USNzRtfHPgCDbZ6WUGTdTA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ba0f144938so70809471fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 08:11:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692198716; x=1692803516;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kjSGmNTgIVSKKOhkrl2rww2pco147cpSwYmgtMlFC8o=;
        b=e1qzaj12VKSS4WFcYmNVkMyz/eQ10HNP8y77E2dOoL22+JrbOe+Trv+poiUH6Py0rJ
         zM2hfMwthlISy1UUQZYwkQL6R3aehrp6Ts+aKowj1Kl+jFGTnfB+MFo5ixDk0GqhckXa
         s233NPkAD+++mjOQF7FdXqf85d70Lo1Z0H950zXKy09CwVheRkCEGECnZ8btGHkGFLlN
         pSsA5/uN8j9n0BM0/ZKjrGBAsGeiJLewSfxAkqnZWlhK0liJcdmsCq7VSJrLqOF+/SN4
         kU5niQIurNK9CQ6t+DO7OwJ4GV0ETdNJvjt1lL6tCDWMs//usWG9vxgCcoW0Z9vh4iWB
         /akQ==
X-Gm-Message-State: AOJu0YxqkpUeyAwExJi/KocgVj37q5ciCCsGvGiCAzBQZD+ojN2U1PpF
        mNeOYYaLPQniSfII3Qqy2iWnC0vnzAjR3Qh9c0xhlXa58HA1k187E936LHcUHk8sxCuQ+T5EH3V
        WoiJcHJS1Ta0qC+ZfhUfy1nQ3
X-Received: by 2002:a2e:b794:0:b0:2b5:8f85:bf67 with SMTP id n20-20020a2eb794000000b002b58f85bf67mr1768803ljo.53.1692198716505;
        Wed, 16 Aug 2023 08:11:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEL0iYP3uJPBFpw0ae+mHd2Z9tZ9QoWKJlJMfAfuPNxWG0IemainGBUP8OFRMMjPcFCPTmMmg==
X-Received: by 2002:a2e:b794:0:b0:2b5:8f85:bf67 with SMTP id n20-20020a2eb794000000b002b58f85bf67mr1768790ljo.53.1692198716117;
        Wed, 16 Aug 2023 08:11:56 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:8b00:5520:fa3c:c527:592f? (p200300cbc74b8b005520fa3cc527592f.dip0.t-ipconnect.de. [2003:cb:c74b:8b00:5520:fa3c:c527:592f])
        by smtp.gmail.com with ESMTPSA id l24-20020a7bc458000000b003fbb25da65bsm21522971wmi.30.2023.08.16.08.11.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 08:11:55 -0700 (PDT)
Message-ID: <2b6cc6b6-8fcb-35ff-3d5b-e4a6068847d9@redhat.com>
Date:   Wed, 16 Aug 2023 17:11:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 3/3] madvise:madvise_free_pte_range(): don't use
 mapcount() against large folio for sharing check
Content-Language: en-US
To:     Daniel Gomez <da.gomez@samsung.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "vishal.moola@gmail.com" <vishal.moola@gmail.com>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "yuzhao@google.com" <yuzhao@google.com>,
        "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
        "shy828301@gmail.com" <shy828301@gmail.com>
References: <20230808020917.2230692-1-fengwei.yin@intel.com>
 <20230808020917.2230692-4-fengwei.yin@intel.com>
 <CGME20230815132509eucas1p1b34b2852a9c4efe743c8da82867c4cc3@eucas1p1.samsung.com>
 <4jvrmdpyteny5vaqmcrctzrovap2oy2zuukybbhfqyqbbb5xmy@ufgxufss2ngw>
 <2bfa1931-1fc6-5d6f-cba1-c7a9eb8a279a@intel.com>
 <svdxtqiihsjwcbxjp67s6cteprhoxgypf7rjrk2v73ppyn2ogp@ee4ru6vgspl4>
 <4412ad3c-ebed-40a4-8f4e-83bb1b53b686@intel.com>
 <a4k27pleianmjbt2d5lqlmwqv7k2pujzfv75y2q564vrcdye3w@xf3wcifffxkx>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <a4k27pleianmjbt2d5lqlmwqv7k2pujzfv75y2q564vrcdye3w@xf3wcifffxkx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.08.23 16:13, Daniel Gomez wrote:
> On Wed, Aug 16, 2023 at 08:04:11PM +0800, Yin, Fengwei wrote:
>>
>>
>> On 8/16/2023 7:44 PM, Daniel Gomez wrote:
>>> On Wed, Aug 16, 2023 at 07:30:35AM +0800, Yin Fengwei wrote:
>>>>
>>>>
>>>> On 8/15/23 21:25, Daniel Gomez wrote:
>>>>> Hi Yin,
>>>>> On Tue, Aug 08, 2023 at 10:09:17AM +0800, Yin Fengwei wrote:
>>>>>> Commit 98b211d6415f ("madvise: convert madvise_free_pte_range() to use a
>>>>>> folio") replaced the page_mapcount() with folio_mapcount() to check
>>>>>> whether the folio is shared by other mapping.
>>>>>>
>>>>>> It's not correct for large folios. folio_mapcount() returns the total
>>>>>> mapcount of large folio which is not suitable to detect whether the folio
>>>>>> is shared.
>>>>>>
>>>>>> Use folio_estimated_sharers() which returns a estimated number of shares.
>>>>>> That means it's not 100% correct. It should be OK for madvise case here.
>>>>>
>>>>> I'm trying to understand why it should be ok for madvise this change, so
>>>>> I hope it's okay to ask you few questions.
>>>>>
>>>>> folio_mapcount() calculates the total maps for all the subpages of a
>>>>> folio. However, the folio_estimated_sharers does it only for the first
>>>>> subpage making it not true for large folios. Then, wouldn't this change
>>>>> drop support for large folios?
>>>> I saw David explained this very well in another mail.
>>>>
>>>>>
>>>>> Seems like folio_entire_mapcount() is not accurate either because of it
>>>>> does not inclue PTE-mapped sub-pages which I think we need here. Hence,
>>>>> the folio_mapcount(). Could this be something missing in the test side?
>>>>>
>>>>> I tried to replicate the setup with CONFIG_TRANSPARENT_HUGEPAGE but
>>>>> seems like I'm not able to do it:
>>>>>
>>>>> ./cow
>>>>> # [INFO] detected THP size: 2048 KiB
>>>>> # [INFO] detected hugetlb size: 2048 KiB
>>>>> # [INFO] detected hugetlb size: 1048576 KiB
>>>>> # [INFO] huge zeropage is enabled
>>>>> TAP version 13
>>>>> 1..166
>>>>> # [INFO] Anonymous memory tests in private mappings
>>>>> # [RUN] Basic COW after fork() ... with base page
>>>>> not ok 1 MADV_NOHUGEPAGE failed
>>>>> # [RUN] Basic COW after fork() ... with swapped out base page
>>>>> not ok 2 MADV_NOHUGEPAGE failed
>>>>> # [RUN] Basic COW after fork() ... with THP
>>>>> not ok 3 MADV_HUGEPAGE failed
>>>>> # [RUN] Basic COW after fork() ... with swapped-out THP
>>>>> not ok 4 MADV_HUGEPAGE failed
>>>>> # [RUN] Basic COW after fork() ... with PTE-mapped THP
>>>>> not ok 5 MADV_HUGEPAGE failed
>>>>> # [RUN] Basic COW after fork() ... with swapped-out, PTE-mapped THP
>>>>> not ok 6 MADV_HUGEPAGE failed
>>>>> ...
>>>> Can you post the MADV_PAGEOUT and PTE-mapped THP related testing result?
>>>> And I suppose swap need be enabled also for the testing.
>>>
>>> You may find a dump of the logs in the link below with system information. Let me
>>> know if you find something wrong in my setup or if you need something else.
>>> Besides CONFIG_TRANSPARENT_HUGEPAGE, CONFIG_SWAP is also enabled in the kernel.
>>>
>>> https://gitlab.com/-/snippets/2584135
>>>
>>> Also, strace reports ENOSYS for MADV_*:
>>> madvise(0x7f2912465000, 4096, MADV_NOHUGEPAGE) = -1 ENOSYS (Function not implemented)
>>> madvise(0x7f2912000000, 2097152, MADV_HUGEPAGE) = -1 ENOSYS (Function not implemented)
>> O. The problem here is MADV_HUGEPAGE/MADV_NOHUGEPAGE doesn't work.
>> Do you have CONFIG_ADVISE_SYSCALLS enabled?
> It worked after I enabled the conf. Some tests failed and some were
> skipped. But I managed to reproduce the issue now, thanks Yin!
> 
> Bail out! 4 out of 166 tests failed
> # Totals: pass:146 fail:4 xfail:0 xpass:0 skip:16 error:0
> 

These hugetlb that are failing are known failures.

-- 
Cheers,

David / dhildenb

