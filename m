Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F3D788165
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 10:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243249AbjHYIAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 04:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241338AbjHYIAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 04:00:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3A61FF0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 00:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692950368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jch5meqCve0IYszOaHOpzDCFTLibD/LfhsjzqZiTXSs=;
        b=UikjQSqIpfkw/mnUxSBDYJGl6yC37vjeVC+ob3XOzvzf5kNHFlVkZ6stGrBumuVR9X4clE
        /6+gaY4Uos4sAV9FXFGaasFQREb1/wbFAR4apafpLItJQGFQWG2EZBLowFxbo4U2IqupPs
        pHmZNJ3WCMyMK1WCbRIdfNCNQrcwTms=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-NUtVMtuJPQmXWUtwMimqEA-1; Fri, 25 Aug 2023 03:59:26 -0400
X-MC-Unique: NUtVMtuJPQmXWUtwMimqEA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fee53cd697so5764855e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 00:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692950365; x=1693555165;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jch5meqCve0IYszOaHOpzDCFTLibD/LfhsjzqZiTXSs=;
        b=cmFz0tVkWh37PZLKUvJB9PrJ8YPAcHpjbhTvClTeM/zxJow1+nL1n27mHbGdnUB7mK
         /rmB3dHNoRB/ogHGBViumNKR3Wnqy5usAZkt7Vr6mutaGUwon+uuI8QxgJc84qwxzITY
         V1aaqrefZxWFy7Dr9VawhsbkLDf0JpxxxKL+3WhiEbW0J3+SNTY8sj4pgu/dBPM0gf8O
         A4moCudtNn5zw4xFLC9yodmkK1It5yBy9UxeGfpWQC+bg+mn8tn9KKfiGarrg2zepYZP
         uxIf5Fih1wxaLXXn4vq93nPAxPYzOmEN7KUheMx/Uk7PDdrMj2WpAHPbbhKQDixqONNB
         438Q==
X-Gm-Message-State: AOJu0YxbunqRxmXrr/lXUfs11cbMkP3eEvOlRqc3EmqidOU4jnSZwUdo
        YSkJeDA8NRAgIPjtzeI+qYT5TwMfqsYUHyvmexi/Tx7wpATbtrXOPTb3U9jQ/ndzlQA8tbDEHEw
        oKEK3LivC6FpMXNNQGeVaVHrH
X-Received: by 2002:a05:600c:3b05:b0:3fd:2d35:b96a with SMTP id m5-20020a05600c3b0500b003fd2d35b96amr12623028wms.39.1692950365746;
        Fri, 25 Aug 2023 00:59:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdQwDqnosVW1DDak/N5nvionAIaQ4MZxk2UELAYY9GD/+opncTu71Ze9B8Wh064B3e3tF+WA==
X-Received: by 2002:a05:600c:3b05:b0:3fd:2d35:b96a with SMTP id m5-20020a05600c3b0500b003fd2d35b96amr12623016wms.39.1692950365310;
        Fri, 25 Aug 2023 00:59:25 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70e:9200:ce93:b5e6:8aa9:65d4? (p200300cbc70e9200ce93b5e68aa965d4.dip0.t-ipconnect.de. [2003:cb:c70e:9200:ce93:b5e6:8aa9:65d4])
        by smtp.gmail.com with ESMTPSA id y24-20020a1c4b18000000b003feae747ff2sm4647776wma.35.2023.08.25.00.59.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 00:59:24 -0700 (PDT)
Message-ID: <3408ff54-f353-0334-0d66-c808389d2f01@redhat.com>
Date:   Fri, 25 Aug 2023 09:59:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Zach O'Keefe <zokeefe@google.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Yang Shi <shy828301@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Saurabh Sengar <ssengar@linux.microsoft.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20230821234844.699818-1-zokeefe@google.com>
 <37c2b525-5c2c-d400-552c-9ccb91f4d7bf@redhat.com>
 <CAAa6QmSHF6-9aFa68WDcb+WATh2Yz=wXyp8VBLDNv6yPp2SS5Q@mail.gmail.com>
 <3e08d48b-7b70-cc7f-0ec1-12ad9b1a33db@redhat.com>
 <CAAa6QmSNvx7wbZzfhFOyhODTMoBbf6PimnOf2xeAw5NkD1eXVg@mail.gmail.com>
 <PUZP153MB06350A5DC9CCB8448C98E4EEBE1DA@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [EXTERNAL] Re: [PATCH v3] mm/thp: fix "mm: thp: kill
 __transhuge_page_enabled()"
In-Reply-To: <PUZP153MB06350A5DC9CCB8448C98E4EEBE1DA@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.08.23 17:39, Saurabh Singh Sengar wrote:
>> On Thu, Aug 24, 2023 at 7:05 AM David Hildenbrand <david@redhat.com>
>> wrote:
>>>
>>> On 24.08.23 15:59, Zach O'Keefe wrote:
>>>> On Thu, Aug 24, 2023 at 12:39 AM David Hildenbrand
>> <david@redhat.com> wrote:
>>>>>
>>>>> On 22.08.23 01:48, Zach O'Keefe wrote:
>>>>>> The 6.0 commits:
>>>>>>
>>>>>> commit 9fec51689ff6 ("mm: thp: kill
>>>>>> transparent_hugepage_active()") commit 7da4e2cb8b1f ("mm: thp:
>>>>>> kill __transhuge_page_enabled()")
>>>>>>
>>>>>> merged "can we have THPs in this VMA?" logic that was previously
>>>>>> done separately by fault-path, khugepaged, and smaps "THPeligible"
>> checks.
>>>>>>
>>>>>> During the process, the semantics of the fault path check changed
>>>>>> in two
>>>>>> ways:
>>>>>>
>>>>>> 1) A VM_NO_KHUGEPAGED check was introduced (also added to smaps
>> path).
>>>>>> 2) We no longer checked if non-anonymous memory had a vm_ops-
>>> huge_fault
>>>>>>       handler that could satisfy the fault.  Previously, this check had been
>>>>>>       done in create_huge_pud() and create_huge_pmd() routines, but
>> after
>>>>>>       the changes, we never reach those routines.
>>>>>>
>>>>>> During the review of the above commits, it was determined that
>>>>>> in-tree users weren't affected by the change; most notably, since
>>>>>> the only relevant user (in terms of THP) of VM_MIXEDMAP or
>>>>>> ->huge_fault is DAX, which is explicitly approved early in
>>>>>> approval logic.  However, there is at least one occurrence where
>>>>>> an out-of-tree driver that used VM_HUGEPAGE|VM_MIXEDMAP with a
>> vm_ops->huge_fault handler, was broken.
>>>>>
>>>>> ... so all we did is break an arbitrary out-of-tree driver? Sorry
>>>>> to say, but why should we care?
>>>>>
>>>>> Is there any in-tree code affected and needs a "Fixes:" ?
>>>>
>>>> The in-tree code was taken care of during the rework .. but I didn't
>>>> know about the possibility of a driver hooking in here.
>>>
>>> And that's the problem of the driver, no? It's not the job of the
>>> kernel developers to be aware of each out-of-tree driver to not
>>> accidentally break something in there.
>>>
>>>>
>>>> I don't know what the normal policy / stance here is, but I figured
>>>> the change was simple enough that it was worth helping out.
>>>
>>> If you decide to be out-of-tree, then you have be prepared to only
>>> support tested kernels and fix your driver when something changes
>>> upstream -- like upstream developers would do for you when it would be
>>> in-tree.
>>>
>>> So why can't the out-of-tree driver be fixed, similarly to how we
>>> would have fixed it if it would be in-tree?
>>
>> I don't know much about driver development, but perhaps they are / need to
>> use a pristine upstream kernel, with their driver as a loadable kernel module.
>> Saurabh can comment on this, I don't know.
> 

Hi!

> You are correct Zach. The "out-of-tree" driver had been seamlessly operational
> on version 5.19, leveraging the kernel's capability to handle huge faults for
> non-anonymous vma. However, the transition to kernel version 6.1 inadvertently
> led to the removal of this feature. It's important to note that this removal wasn't
> intentional, and I am optimistic about the potential restoration of this feature.

We are currently creating 6.5, and are being told that a patch in 6.0 
(released almost one year ago!) broke an out-of-tree driver.

Being that back-level, you cannot possibly expect that the upstream 
community can seriously care about not breaking your OOT driver in each 
release.

Especially, we do have bigger ->huge_fault changes coming up:

https://lkml.kernel.org/r/20230818202335.2739663-1-willy@infradead.org

If the driver is not in the tree, people don't care.

You really should try upstreaming that driver.


So this patch here adds complexity (which I don't like) in order to keep 
an OOT driver working -- possibly for a short time. I'm tempted to say 
"please fix your driver to not use huge faults in that scenario, it is 
no longer supported".

But I'm just about to vanish for 1.5 week into vacation :)

@Willy, what are your thoughts?

In any case, I think we should drop the "Fixes" tag. This does not fix 
any kernel BUG -- it restores compatibility with an OOT driver -- and 
already confused people building distributions and asking about this fix ;)


> 
> Hello David,
> 
> Given the context, I am currently exploring potential ways to address the issue
> with the "out-of-tree" driver. I have recognized a challenge posed by the kernel's
> memory management framework, which now imposes restrictions on huge faults
> for non-anonymous vma.

You should try upstreaming your driver possibly without huge fault 
support, and then separately try re-adding huge fault support and see if 
kernel people want to support that or not.

And if your driver *really* requires huge faults, then supporting that 
would be part of your series when upstreaming that driver.

-- 
Cheers,

David / dhildenb

