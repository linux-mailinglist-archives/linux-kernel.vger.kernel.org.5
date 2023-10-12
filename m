Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA727C69B1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 11:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235530AbjJLJcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 05:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjJLJcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 05:32:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FE7C6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 02:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697103084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xSLDOzif9pe7NWfs6FAqs0gKz2RiKRhAj6wFDsEM4p4=;
        b=MhvzeC/ZmzKJFO+gS5sFUeVZAyR1e3Pfb2icIvSjl7L2TXik9PqvpARqWesF0Z0y5urLHw
        hR4WYvu7xzwDWOJsUrJ0xKYEKB9KxxXspXvs7LYTAncy4O72AYypTUgse4gdef/v/0YK+u
        uVCVspSUrWzqHQ2/zdIEV9IB5GraKhA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-icfiZj3pOieiM6utf_xZcA-1; Thu, 12 Oct 2023 05:31:22 -0400
X-MC-Unique: icfiZj3pOieiM6utf_xZcA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-32d931872cbso186801f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 02:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697103081; x=1697707881;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xSLDOzif9pe7NWfs6FAqs0gKz2RiKRhAj6wFDsEM4p4=;
        b=S10qYKYa2ctAmb8llpfccgkC5AxbZQJHhENYGohD8kNuUaMHyahAKS24aOmN7UBW2u
         SnqHx+gxDRqBQOQXml7SBvD1OuOevhNaXMaa5Eu3Zk1NpxirjH8GW1R2xS/LFXRSZ3JU
         Yp084AcbtQ1bgc0cR7CzN+e7rPoMIJA4qLsiv4+4RCawIHNQq0+eGFm6qFFVgjQWji8V
         wiPwCIULlrxqU09ftETbIhlayWFFq3pMBj1x6z03IH+BaEluJapXN8/90YVFLAG9FM76
         Uk31UMLlBzZmBwKAy91pic5Uh5/w6E7HqGEDOLwhn5EHtZomHxSkgTARcua9IOTvVW9M
         1vQQ==
X-Gm-Message-State: AOJu0YyBCJYQwoUpE8PCwvR1Q23kJucFMOrtYxEFlSJmAVsk6WwkVbNP
        JkrylxKkK93QMvZZB9Md8ML5fC80sbclr/0M+CFqzkpLI1FOkwyLJvfbHUIFwNq5tDBuKLmozyQ
        l0NMJYTnsgpnEplCwGKRajGvx
X-Received: by 2002:a5d:5487:0:b0:319:6997:942e with SMTP id h7-20020a5d5487000000b003196997942emr21160874wrv.8.1697103081679;
        Thu, 12 Oct 2023 02:31:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPzeS7uCwL+pDb1dGgHVTR29EBJnszm/PSyz58/uQ1Bkw1Kxbz5kvLADKGVnfjZ5RZryevww==
X-Received: by 2002:a5d:5487:0:b0:319:6997:942e with SMTP id h7-20020a5d5487000000b003196997942emr21160852wrv.8.1697103081266;
        Thu, 12 Oct 2023 02:31:21 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70d:ee00:b271:fb6c:a931:4769? (p200300cbc70dee00b271fb6ca9314769.dip0.t-ipconnect.de. [2003:cb:c70d:ee00:b271:fb6c:a931:4769])
        by smtp.gmail.com with ESMTPSA id 20-20020a05600c22d400b004054dcbf92asm981775wmg.20.2023.10.12.02.31.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 02:31:20 -0700 (PDT)
Message-ID: <0feef130-59dd-0a31-ed06-e3849a52c75e@redhat.com>
Date:   Thu, 12 Oct 2023 11:31:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 4/9] mm: thp: Introduce anon_orders and
 anon_always_mask sysfs files
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
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
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org
References: <20230929114421.3761121-1-ryan.roberts@arm.com>
 <20230929114421.3761121-5-ryan.roberts@arm.com>
 <20230929155530.a51e68e03e47a06b6b84c689@linux-foundation.org>
 <87fs2mrqld.fsf@mail.lhotse>
 <20231009172029.e558c08dd90d9b94fec3a036@linux-foundation.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20231009172029.e558c08dd90d9b94fec3a036@linux-foundation.org>
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

On 10.10.23 02:20, Andrew Morton wrote:
> On Sun, 08 Oct 2023 09:54:22 +1100 Michael Ellerman <mpe@ellerman.id.au> wrote:
> 
>>> I don't know why powerpc's PTE_INDEX_SIZE is variable.
>>
>> To allow a single vmlinux to boot using either the Hashed Page Table
>> MMU, or Radix Tree MMU, which have different page table geometry.
>>
>> That's a pretty crucial feature for distros, so that they can build a
>> single kernel to boot on Power8/9/10.
> 
> Dumb question: why can't distros ship two kernels and have the boot
> loader (or something else) pick the appropriate one?

One answer I keep hearing over and over again is "test matrix 
explosion". So distros only do it when unavoidable: for example, when 
differing PAGE_SIZE is required (e.g., 4k vs 64k) or we're dealing with 
RT support (RT vs !RT).

-- 
Cheers,

David / dhildenb

