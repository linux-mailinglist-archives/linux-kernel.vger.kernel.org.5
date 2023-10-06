Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DEC7BBF2A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 20:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbjJFSyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 14:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbjJFSyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 14:54:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3963FE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 11:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696618355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JOeQFdxxoelQGpngpLs9e1LT5gw6XGDAEUlktj2VpH4=;
        b=IdLX3bRKL05Wwz/lExH9iX0mjTqCW90wywGYBpJ0+kaXlUaP8QtQmexNMCjZxER3kIncM2
        sfkSHo+X5CAvQPDLJu5qiYPBuYomQSL5hxnBU0lEzEY0IUy/DoGTxBXfY8PoLZ4+3WgL1q
        YG/BjPly3YlsLBrV0shwnKOkJBPy+uQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-7Km3meM2MPmOP6k-cR_sRA-1; Fri, 06 Oct 2023 14:52:33 -0400
X-MC-Unique: 7Km3meM2MPmOP6k-cR_sRA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3251bc06680so1798578f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 11:52:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696618352; x=1697223152;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JOeQFdxxoelQGpngpLs9e1LT5gw6XGDAEUlktj2VpH4=;
        b=vFLXcV+Ot6Uhu0cviePtiwz6zDWuwMi0h5/468hg2DDg5gceQzLzn2rsESOytMeWMy
         WVFkVwSEo2p5lT9X3UInnEGGS9snRrDvzdtOZgyEKR+7BORAYbn0+gSxcyQ5LoE+Bt0M
         sutl69rr+S7Vm0ezZlGAn4yPjQnl7TLLIF8/TSFbDr0YQE2iLUK/5DXAEcW+a0Uvhzj+
         Yco/kqxy4mpImqdNDwJgNa1Wn6om+6dgMDUchtGBoHYE6n6g3C/PefATyq4q5QSnyPo1
         w63lDA38/U/UNXjQCzhKzzajYFti4pxwZbcWowHo5Q+J9gfDjwL01K9zpFyr0nzVarZS
         YCxg==
X-Gm-Message-State: AOJu0YzKfIXsGc6bERMGUZhbCGhM8eKOVrifEVJx5IeuorWvJb2yvLOP
        Bos0qoeRBC2Vc4P5La6zJCRWUbZ7OLSPkv0z8ZY4CNZRrb+BdIcoFV2K6Ly2YvQXyU1WNvG/dhz
        7LF1n7Ml6ENOQzZVgxCd0lDi7heKe7+7L
X-Received: by 2002:a5d:4286:0:b0:321:651b:4651 with SMTP id k6-20020a5d4286000000b00321651b4651mr8540564wrq.29.1696618352496;
        Fri, 06 Oct 2023 11:52:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcCPOFXmr+bA/jHzGh7Itci+F3ST/K5NJOrqs3d3a4HSFV8LqOi+029gM3IVISV4ItpA6YkA==
X-Received: by 2002:a5d:4286:0:b0:321:651b:4651 with SMTP id k6-20020a5d4286000000b00321651b4651mr8540544wrq.29.1696618351955;
        Fri, 06 Oct 2023 11:52:31 -0700 (PDT)
Received: from [192.168.3.108] (p4ff23b7e.dip0.t-ipconnect.de. [79.242.59.126])
        by smtp.gmail.com with ESMTPSA id p13-20020a5d68cd000000b0031ae8d86af4sm2213046wrw.103.2023.10.06.11.52.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 11:52:31 -0700 (PDT)
Message-ID: <0ed83331-9037-421a-d450-363e07e87f6a@redhat.com>
Date:   Fri, 6 Oct 2023 20:52:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4] mm/thp: fix "mm: thp: kill __transhuge_page_enabled()"
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Zach O'Keefe <zokeefe@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Yang Shi <shy828301@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Ryan Roberts <ryan.roberts@arm.com>
References: <20230925200110.1979606-1-zokeefe@google.com>
 <20231006105810.17fcb352e33cbcab1645099b@linux-foundation.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20231006105810.17fcb352e33cbcab1645099b@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.10.23 19:58, Andrew Morton wrote:
> On Mon, 25 Sep 2023 13:01:10 -0700 "Zach O'Keefe" <zokeefe@google.com> wrote:
> 
>> The 6.0 commits:
>>
>> commit 9fec51689ff6 ("mm: thp: kill transparent_hugepage_active()")
>> commit 7da4e2cb8b1f ("mm: thp: kill __transhuge_page_enabled()")
>>
>> merged "can we have THPs in this VMA?" logic that was previously done
>> separately by fault-path, khugepaged, and smaps "THPeligible" checks.
>>
>> During the process, the semantics of the fault path check changed in two
>> ways:
>>
>> 1) A VM_NO_KHUGEPAGED check was introduced (also added to smaps path).
>> 2) We no longer checked if non-anonymous memory had a vm_ops->huge_fault
>>     handler that could satisfy the fault.  Previously, this check had been
>>     done in create_huge_pud() and create_huge_pmd() routines, but after
>>     the changes, we never reach those routines.
>>
>> During the review of the above commits, it was determined that in-tree
>> users weren't affected by the change; most notably, since the only relevant
>> user (in terms of THP) of VM_MIXEDMAP or ->huge_fault is DAX, which is
>> explicitly approved early in approval logic. However, this was a bad
>> assumption to make as it assumes the only reason to support ->huge_fault
>> was for DAX (which is not true in general).
>>
>> Remove the VM_NO_KHUGEPAGED check when not in collapse path and give
>> any ->huge_fault handler a chance to handle the fault.  Note that we
>> don't validate the file mode or mapping alignment, which is consistent
>> with the behavior before the aforementioned commits.
>>
>> ...
>>
>> @@ -100,11 +100,11 @@ bool hugepage_vma_check(struct vm_area_struct *vma, unsigned long vm_flags,
>>   		return in_pf;
>>   
> 
> Ryan's "mm: thp: introduce anon_orders and anon_always_mask sysfs
> files" changes hugepage_vma_check() to return an unsigned int, so this
> patch will need some rework to fit in after that.
> 
> However Ryan's overall series "variable-order, large folios for
> anonymous memory" is in early days and might not make it.
> 
> And as I don't know what is the urgency of this patch ("mm/thp: fix
> "mm: thp: kill __transhuge_page_enabled()"), I'm unable to decide which
> patch needs to come first (thus requiring rework of the other patch).
> 
> Please discuss!

IMHO clearly this one.

-- 
Cheers,

David / dhildenb

