Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60D1803005
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 11:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343769AbjLDKVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 05:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343788AbjLDKVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 05:21:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF293D2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 02:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701685268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=VTEnGAuuATss7gyR221tz2RkYCsGvxGKol2rgrgK2qg=;
        b=EYlfZXWUFK1APVf1Y1owY8PINBjE4bW871GhJS3b5ZwhJv9z7cYSvJiEn0vuP19Rj6BN5/
        BgXKd1NksCHlvG1YNW5RQuzQqx+AyYDW15jFxxnKJB5cVagK3CaFO0PupJR7WWny97S8vw
        5cnFJO21Ai6BSP/IWUJOZmIWBhAFYEA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-ACwDPzY_Mbee5uA2_zdwFw-1; Mon, 04 Dec 2023 05:21:06 -0500
X-MC-Unique: ACwDPzY_Mbee5uA2_zdwFw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40b3d4d6417so29294075e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 02:21:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701685265; x=1702290065;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTEnGAuuATss7gyR221tz2RkYCsGvxGKol2rgrgK2qg=;
        b=CvjV1SJCpZbyxn/xxhxesJgG1ioS/4vnlq8pj1ulo4W/FRYd+OA/qzda/CiioNdKul
         iHqRDhMN23tO9D5UcXKwu2cvQxQfDR4xiHMoJseLwDZSjnGEI9xmS7SsnOI2ZdtVqsaw
         Vd7DpsrwRp2bFRzRdu/1Oa4uG8vZbxIfARdW1KojWNnlT1L4YCi/i6nL6vctvc2fVR6E
         bUqoR3AmkB+wXZ78iHbPAP4WfHDhrYgxWBSr+LdjtAbmrZCQ78oiVt08vaWa6T1/ZNx+
         RqTItvo6eDAvOXxpK3bU9u238w3wS20qVKtgK5cCUJpdYGWi0uEkMQJ0BzGZKyDJdHcR
         Shbw==
X-Gm-Message-State: AOJu0Yzdfuo0BHJpvbJT+wc65YyIa0QtLgrLm9DUE/Chic2SrXOaNu43
        0hlub0jWqORg4q9Qke93ab2ntTDlS9k0NfRHfo0bcrcfOFViY/cQ8YJbyFmE4vP45zOu+DVlVH5
        aPVtCaOEEqFbRYxorcUkPNDhm
X-Received: by 2002:a05:600c:310c:b0:40b:5f03:b3df with SMTP id g12-20020a05600c310c00b0040b5f03b3dfmr1338515wmo.257.1701685265580;
        Mon, 04 Dec 2023 02:21:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFqbUQL384Zpt7twdFO2KJgNDZk0K0oiu/bJBZUXdOBu3Jm0w2bsEUrKNwq1dflJ6Fs9+6Qcg==
X-Received: by 2002:a05:600c:310c:b0:40b:5f03:b3df with SMTP id g12-20020a05600c310c00b0040b5f03b3dfmr1338491wmo.257.1701685265077;
        Mon, 04 Dec 2023 02:21:05 -0800 (PST)
Received: from ?IPV6:2003:cb:c722:3700:6501:8925:6f9:fcdc? (p200300cbc72237006501892506f9fcdc.dip0.t-ipconnect.de. [2003:cb:c722:3700:6501:8925:6f9:fcdc])
        by smtp.gmail.com with ESMTPSA id iv11-20020a05600c548b00b0040b4cb14d40sm18172398wmb.19.2023.12.04.02.21.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 02:21:04 -0800 (PST)
Message-ID: <1c68ee91-1b6a-41e8-b96f-bcaf9faffa08@redhat.com>
Date:   Mon, 4 Dec 2023 11:21:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/6] mm/gmem: add arch-independent abstraction to
 track address mapping status
Content-Language: en-US
To:     Pedro Falcato <pedro.falcato@gmail.com>
Cc:     Weixi Zhu <weixi.zhu@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        weixi.zhu@openeuler.sh, mgorman@suse.de, jglisse@redhat.com,
        rcampbell@nvidia.com, jhubbard@nvidia.com, apopple@nvidia.com,
        mhairgrove@nvidia.com, ziy@nvidia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com,
        amd-gfx@lists.freedesktop.org, Felix.Kuehling@amd.com,
        ogabbay@kernel.org, dri-devel@lists.freedesktop.org,
        jgg@nvidia.com, leonro@nvidia.com, zhenyuw@linux.intel.com,
        zhi.a.wang@intel.com, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        tvrtko.ursulin@linux.intel.com
References: <20231128125025.4449-1-weixi.zhu@huawei.com>
 <20231128125025.4449-3-weixi.zhu@huawei.com>
 <e4eb5a24-e9cf-4944-9614-df5f5f3a7163@redhat.com>
 <CAKbZUD25mwVXowDcN1Cj5Op9wRAopYhYZcesR0tk2r_Wn-d95g@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAKbZUD25mwVXowDcN1Cj5Op9wRAopYhYZcesR0tk2r_Wn-d95g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.12.23 15:50, Pedro Falcato wrote:
> On Fri, Dec 1, 2023 at 9:23 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 28.11.23 13:50, Weixi Zhu wrote:
>>> This patch adds an abstraction layer, struct vm_object, that maintains
>>> per-process virtual-to-physical mapping status stored in struct gm_mapping.
>>> For example, a virtual page may be mapped to a CPU physical page or to a
>>> device physical page. Struct vm_object effectively maintains an
>>> arch-independent page table, which is defined as a "logical page table".
>>> While arch-dependent page table used by a real MMU is named a "physical
>>> page table". The logical page table is useful if Linux core MM is extended
>>> to handle a unified virtual address space with external accelerators using
>>> customized MMUs.
>>
>> Which raises the question why we are dealing with anonymous memory at
>> all? Why not go for shmem if you are already only special-casing VMAs
>> with a MMAP flag right now?
>>
>> That would maybe avoid having to introduce controversial BSD design
>> concepts into Linux, that feel like going a step backwards in time to me
>> and adding *more* MM complexity.
>>
>>>
>>> In this patch, struct vm_object utilizes a radix
>>> tree (xarray) to track where a virtual page is mapped to. This adds extra
>>> memory consumption from xarray, but provides a nice abstraction to isolate
>>> mapping status from the machine-dependent layer (PTEs). Besides supporting
>>> accelerators with external MMUs, struct vm_object is planned to further
>>> union with i_pages in struct address_mapping for file-backed memory.
>>
>> A file already has a tree structure (pagecache) to manage the pages that
>> are theoretically mapped. It's easy to translate from a VMA to a page
>> inside that tree structure that is currently not present in page tables.
>>
>> Why the need for that tree structure if you can just remove anon memory
>> from the picture?
>>
>>>
>>> The idea of struct vm_object is originated from FreeBSD VM design, which
>>> provides a unified abstraction for anonymous memory, file-backed memory,
>>> page cache and etc[1].
>>
>> :/
>>
>>> Currently, Linux utilizes a set of hierarchical page walk functions to
>>> abstract page table manipulations of different CPU architecture. The
>>> problem happens when a device wants to reuse Linux MM code to manage its
>>> page table -- the device page table may not be accessible to the CPU.
>>> Existing solution like Linux HMM utilizes the MMU notifier mechanisms to
>>> invoke device-specific MMU functions, but relies on encoding the mapping
>>> status on the CPU page table entries. This entangles machine-independent
>>> code with machine-dependent code, and also brings unnecessary restrictions.
>>
>> Why? we have primitives to walk arch page tables in a non-arch specific
>> fashion and are using them all over the place.
>>
>> We even have various mechanisms to map something into the page tables
>> and get the CPU to fault on it, as if it is inaccessible (PROT_NONE as
>> used for NUMA balancing, fake swap entries).
>>
>>> The PTE size and format vary arch by arch, which harms the extensibility.
>>
>> Not really.
>>
>> We might have some features limited to some architectures because of the
>> lack of PTE bits. And usually the problem is that people don't care
>> enough about enabling these features on older architectures.
>>
>> If we ever *really* need more space for sw-defined data, it would be
>> possible to allocate auxiliary data for page tables only where required
>> (where the features apply), instead of crafting a completely new,
>> auxiliary datastructure with it's own locking.
>>
>> So far it was not required to enable the feature we need on the
>> architectures we care about.
>>
>>>
>>> [1] https://docs.freebsd.org/en/articles/vm-design/
>>
>> In the cover letter you have:
>>
>> "The future plan of logical page table is to provide a generic
>> abstraction layer that support common anonymous memory (I am looking at
>> you, transparent huge pages) and file-backed memory."
>>
>> Which I doubt will happen; there is little interest in making anonymous
>> memory management slower, more serialized, and wasting more memory on
>> metadata.
> 
> Also worth noting that:
> 
> 1) Mach VM (which FreeBSD inherited, from the old BSD) vm_objects
> aren't quite what's being stated here, rather they are somewhat
> replacements for both anon_vma and address_space[1]. Very similarly to
> Linux, they take pages from vm_objects and map them in page tables
> using pmap (the big difference is anon memory, which has its
> bookkeeping in page tables, on Linux)
> 
> 2) These vm_objects were a horrendous mistake (see CoW chaining) and
> FreeBSD has to go to horrendous lengths to make them tolerable. The
> UVM paper/dissertation (by Charles Cranor) talks about these issues at
> length, and 20 years later it's still true.
> 
> 3) Despite Linux MM having its warts, it's probably correct to
> consider it a solid improvement over FreeBSD MM or NetBSD UVM
> 
> And, finally, randomly tacking on core MM concepts from other systems
> is at best a *really weird* idea. Particularly when they aren't even
> what was stated!

Can you read my mind? :) thanks for noting all that, with which I 100% 
agree.

-- 
Cheers,

David / dhildenb

