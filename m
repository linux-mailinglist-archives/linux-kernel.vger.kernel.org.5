Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E754C7EDE39
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 11:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344987AbjKPKMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 05:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjKPKMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 05:12:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0845319F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 02:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700129548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=5ZBbfhLMJV0XF/JRhcYrRxUZLfjN1NPiJz+tDpv7jDU=;
        b=aoCcYi6dFKwqKrSC7cYWxkKdqp85R+NxlJa7gsIYPOXa+sVF3xhVRCWLJTIZpeXm4beA7W
        bK0OhS+gR3qdMiOi0UZWx6t7gyIyHNEl6rNj77WWxSV8/w6iO0h9zO+S3UJxHpFvOb0HB7
        yT+NizVxaD7hDT2OI4Q/d6kNLkHcW2M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-M78Q_vDvN8Sl9VM3fK_NzA-1; Thu, 16 Nov 2023 05:12:25 -0500
X-MC-Unique: M78Q_vDvN8Sl9VM3fK_NzA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-32f8c4b74f7so325349f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 02:12:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700129544; x=1700734344;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZBbfhLMJV0XF/JRhcYrRxUZLfjN1NPiJz+tDpv7jDU=;
        b=Nq0UxO5FbQUEcJna+Cc0+F+rhVVGQp0z+5CtX22rHJBVmJti7ZWSG5DTz4mDt1myy1
         txMTr8nr6So5oQUT6dfRsJxO0B5RNbuXulzHBI2gfpSt+WnD/+5nkZUghpiZtVLOzG/E
         bFsaH1gNO8iiJ1PNdJ6RSY+wPYNqltsCm67s9DS179tiz+pIPkpaRONvk6F7Ig80NYHp
         kdcU4v1PQvJub6BnlKJTAdHdx36sid4/fyQoXtIsbiH6bcCKiQ5aDRDNVZMoiD0szZYS
         8g1oRsitNoP+GLuOORJyLUN2Nrp044ysUwGouTb0DdA1Qbzhtrvcv/RZpcLQ/d8tP3LB
         YgxA==
X-Gm-Message-State: AOJu0Yyjpl9r8KCjkAzJSGQWYM1QodcQD7E74vFn039h+4v8rs8IggEg
        qU7bQ8L/JxHpCNwvd80z2/wWKOINH4OiW3F+Ix/fn/JHrbsBTrnRZ+Ab7qpBvLRAnFNyICIkbcu
        Bh2h0Lun48qntlbmmBZajd6Av
X-Received: by 2002:adf:b34e:0:b0:32d:ccdf:69f2 with SMTP id k14-20020adfb34e000000b0032dccdf69f2mr1167278wrd.26.1700129544295;
        Thu, 16 Nov 2023 02:12:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMGUOW+sXP1OJtcDLRzdaY0Vfsn1RDtCT0aAHbY1L00AmpHwtD70nhXZkB4j4B2LaNebEChw==
X-Received: by 2002:adf:b34e:0:b0:32d:ccdf:69f2 with SMTP id k14-20020adfb34e000000b0032dccdf69f2mr1167254wrd.26.1700129543860;
        Thu, 16 Nov 2023 02:12:23 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id e14-20020adfe7ce000000b0032d2489a399sm13087757wrn.49.2023.11.16.02.12.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 02:12:23 -0800 (PST)
Message-ID: <4e8d329c-eda6-4ff8-bb56-8924bb4583b2@redhat.com>
Date:   Thu, 16 Nov 2023 11:12:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] mm: Batch-copy PTE ranges during fork()
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        kernel test robot <lkp@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231115163018.1303287-2-ryan.roberts@arm.com>
 <202311160516.kHhfmjvl-lkp@intel.com>
 <e6060ff2-ced0-42fd-b92a-c2e710c4e15a@arm.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <e6060ff2-ced0-42fd-b92a-c2e710c4e15a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.11.23 11:07, Ryan Roberts wrote:
> Hi All,
> 
> Hoping for some guidance below!
> 
> 
> On 15/11/2023 21:26, kernel test robot wrote:
>> Hi Ryan,
>>
>> kernel test robot noticed the following build errors:
>>
>> [auto build test ERROR on akpm-mm/mm-everything]
>> [also build test ERROR on linus/master v6.7-rc1 next-20231115]
>> [cannot apply to arm64/for-next/core efi/next]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Roberts/mm-Batch-copy-PTE-ranges-during-fork/20231116-010123
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
>> patch link:    https://lore.kernel.org/r/20231115163018.1303287-2-ryan.roberts%40arm.com
>> patch subject: [PATCH v2 01/14] mm: Batch-copy PTE ranges during fork()
>> config: arm-randconfig-002-20231116 (https://download.01.org/0day-ci/archive/20231116/202311160516.kHhfmjvl-lkp@intel.com/config)
>> compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231116/202311160516.kHhfmjvl-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202311160516.kHhfmjvl-lkp@intel.com/
>>
>> All errors (new ones prefixed by >>):
>>
>>     mm/memory.c: In function 'folio_nr_pages_cont_mapped':
>>>> mm/memory.c:969:16: error: implicit declaration of function 'pte_pgprot'; did you mean 'ptep_get'? [-Werror=implicit-function-declaration]
>>       969 |         prot = pte_pgprot(pte_mkold(pte_mkclean(ptent)));
>>           |                ^~~~~~~~~~
>>           |                ptep_get
>>     cc1: some warnings being treated as errors
> 
> It turns out that pte_pgprot() is not universal; its only implemented by
> architectures that select CONFIG_HAVE_IOREMAP_PROT (currently arc, arm64,
> loongarch, mips, powerpc, s390, sh, x86).
> 
> I'm using it in core-mm to help calculate the number of "contiguously mapped"
> pages within a folio (note that's not the same as arm64's notion of
> contpte-mapped. I just want to know that there are N physically contiguous pages
> mapped virtually contiguously with the same permissions). And I'm using
> pte_pgprot() to extract the permissions for each pte to compare. It's important
> that we compare the permissions because just because the pages belongs to the
> same folio doesn't imply they are mapped with the same permissions; think
> mprotect()ing a sub-range.
> 
> I don't have a great idea for how to fix this - does anyone have any thoughts?

KIS :) fork() operates on individual VMAs if I am not daydreaming.

Just check for the obvious pte_write()/dirty/ and you'll be fine.

If your code tries to optimize "between VMAs", you really shouldn't be 
doing that at this point.

If someone did an mprotect(), there are separate VMAs, and you shouldn't 
be looking at the PTEs belonging to a different VMA.

-- 
Cheers,

David / dhildenb

