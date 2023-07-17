Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FDC7563D2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjGQNHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbjGQNHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:07:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635CD94
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 06:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689599211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ziRtRwIpR/kgGXhVSaugdNu+dtD9CR9I38gJo6RH+lc=;
        b=COebgLmRM4FAV2K2MIEGUk+r6xMXQghP0LXOcsGJ6exptrr3ePqMlsy8/UCI/3WhBrk1XN
        6fyMTKeKfkshvskbGwjLrRpE9QCukR1zoYD2eDjvZeg6seBY/rBVbTEqUHois2JjfeOqz+
        /VuWumu8KjqfTVH/DJ6uvVy8tWKicDY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-ueaV0NrnMVe0g9fzTxChnw-1; Mon, 17 Jul 2023 09:06:50 -0400
X-MC-Unique: ueaV0NrnMVe0g9fzTxChnw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-31432b25c2fso2836276f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 06:06:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689599209; x=1692191209;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ziRtRwIpR/kgGXhVSaugdNu+dtD9CR9I38gJo6RH+lc=;
        b=ISpez7RcCfUfFmTekMbLII4TNWbAEDau5B3S9D/OW4WwSFY4hyN176QG6qNmyI+AXd
         EQ1b1d8JIyRXbaXo9QDnl9uVPsUEQrilqhzW+6JqdzASKo5cKMqVh/3dPRhIwnRvIGOh
         qZY1y2aDrrxjW1ZhYTCO5plahOL3fDrskC4XoJNhKQsyueEsHZSlVmN0qEJnMmWTnRbx
         mb3N5l9P+GHQAnjegi+h8nQkoQs/pmL63QkEwKrmwXH+pOakVh1H50dPuihHGZrMZzIR
         WHpwTm5hwHRRNmZTdkaME5CpvtzuRPpNlnAszjvtvjMqEPwVyOKRAMI7vkiME7a/ko7b
         2LrA==
X-Gm-Message-State: ABy/qLbHfUKTGv0HeA6kyx3Le62alwnOG9kOFbMhGMCvttLiwRyvv/Od
        YkcSFpmcY49iwAut01pJJH3elKR8Nhud9UhTTLMdrLHCLZKMjabWi2A7lcehIgxjSbXOc/H3q3G
        LLQzjeuhG2kqkWVB+fbkE7l/d
X-Received: by 2002:a5d:6d4b:0:b0:313:f676:8327 with SMTP id k11-20020a5d6d4b000000b00313f6768327mr11902556wri.60.1689599209042;
        Mon, 17 Jul 2023 06:06:49 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH6WKGZ1IRdUgtbX72lH7blBAvdBEUvJYedP5p1VfC4zsPt4YsX8ncjpvhhjKXjiBpbszZZKg==
X-Received: by 2002:a5d:6d4b:0:b0:313:f676:8327 with SMTP id k11-20020a5d6d4b000000b00313f6768327mr11902535wri.60.1689599208645;
        Mon, 17 Jul 2023 06:06:48 -0700 (PDT)
Received: from ?IPV6:2003:cb:c735:400:2501:5a2e:13c6:88da? (p200300cbc735040025015a2e13c688da.dip0.t-ipconnect.de. [2003:cb:c735:400:2501:5a2e:13c6:88da])
        by smtp.gmail.com with ESMTPSA id f14-20020a5d58ee000000b003143c532431sm19155090wrd.27.2023.07.17.06.06.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 06:06:48 -0700 (PDT)
Message-ID: <82c934af-a777-3437-8d87-ff453ad94bfd@redhat.com>
Date:   Mon, 17 Jul 2023 15:06:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 3/4] mm: FLEXIBLE_THP for improved performance
Content-Language: en-US
To:     Yu Zhao <yuzhao@google.com>, Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230714160407.4142030-1-ryan.roberts@arm.com>
 <20230714161733.4144503-3-ryan.roberts@arm.com>
 <CAOUHufacQ8Vx9WQ3BVjGGWKGhcRkL7u79UMX=O7oePDwZ0iNxw@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAOUHufacQ8Vx9WQ3BVjGGWKGhcRkL7u79UMX=O7oePDwZ0iNxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 14.07.23 19:17, Yu Zhao wrote:
> On Fri, Jul 14, 2023 at 10:17 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> Introduce FLEXIBLE_THP feature, which allows anonymous memory to be
>> allocated in large folios of a determined order. All pages of the large
>> folio are pte-mapped during the same page fault, significantly reducing
>> the number of page faults. The number of per-page operations (e.g. ref
>> counting, rmap management lru list management) are also significantly
>> reduced since those ops now become per-folio.
>>
>> The new behaviour is hidden behind the new FLEXIBLE_THP Kconfig, which
>> defaults to disabled for now; The long term aim is for this to defaut to
>> enabled, but there are some risks around internal fragmentation that
>> need to be better understood first.
>>
>> When enabled, the folio order is determined as such: For a vma, process
>> or system that has explicitly disabled THP, we continue to allocate
>> order-0. THP is most likely disabled to avoid any possible internal
>> fragmentation so we honour that request.
>>
>> Otherwise, the return value of arch_wants_pte_order() is used. For vmas
>> that have not explicitly opted-in to use transparent hugepages (e.g.
>> where thp=madvise and the vma does not have MADV_HUGEPAGE), then
>> arch_wants_pte_order() is limited by the new cmdline parameter,
>> `flexthp_unhinted_max`. This allows for a performance boost without
>> requiring any explicit opt-in from the workload while allowing the
>> sysadmin to tune between performance and internal fragmentation.
>>
>> arch_wants_pte_order() can be overridden by the architecture if desired.
>> Some architectures (e.g. arm64) can coalsece TLB entries if a contiguous
>> set of ptes map physically contigious, naturally aligned memory, so this
>> mechanism allows the architecture to optimize as required.
>>
>> If the preferred order can't be used (e.g. because the folio would
>> breach the bounds of the vma, or because ptes in the region are already
>> mapped) then we fall back to a suitable lower order; first
>> PAGE_ALLOC_COSTLY_ORDER, then order-0.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>   .../admin-guide/kernel-parameters.txt         |  10 +
>>   mm/Kconfig                                    |  10 +
>>   mm/memory.c                                   | 187 ++++++++++++++++--
>>   3 files changed, 190 insertions(+), 17 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index a1457995fd41..405d624e2191 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -1497,6 +1497,16 @@
>>                          See Documentation/admin-guide/sysctl/net.rst for
>>                          fb_tunnels_only_for_init_ns
>>
>> +       flexthp_unhinted_max=
>> +                       [KNL] Requires CONFIG_FLEXIBLE_THP enabled. The maximum
>> +                       folio size that will be allocated for an anonymous vma
>> +                       that has neither explicitly opted in nor out of using
>> +                       transparent hugepages. The size must be a power-of-2 in
>> +                       the range [PAGE_SIZE, PMD_SIZE). A larger size improves
>> +                       performance by reducing page faults, while a smaller
>> +                       size reduces internal fragmentation. Default: max(64K,
>> +                       PAGE_SIZE). Format: size[KMG].
>> +
> 
> Let's split this parameter into a separate patch.
> 

Just a general comment after stumbling over patch #2, let's not start 
splitting patches into things that don't make any sense on their own; 
that just makes review a lot harder.

For this case here, I'd suggest first adding the general infrastructure 
and then adding tunables we want to have on top.

I agree that toggling that at runtime (for example via sysfs as raised 
by me previously) would be nicer.

-- 
Cheers,

David / dhildenb

