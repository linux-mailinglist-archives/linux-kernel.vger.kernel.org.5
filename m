Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A06779AE95
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344860AbjIKVO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236135AbjIKJv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:51:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D66EBE40
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694425836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3hI7Q7HmJLGnvJ6TWSuqo/D2NRHYvfG0p6wZ2y0ko6s=;
        b=YhXu0nK7mwCQWzxiDBSHYtg/wYz8g1lg0Y/2s8KiClw7tmLXhGjjfnqUNK/DX5jAsAVGOW
        awea7Jh4vWhSRqOFbWDSr3esL6mQXwsDbWtZ6vhfn7wjrWdavx/331kRQTk+JW0DgQs1Ut
        Tv0Sl6oXAo1DiMLsuz7ngxuA+yBTjXM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-5eIu5RaaP6Gd0R4hwoRzEA-1; Mon, 11 Sep 2023 05:50:34 -0400
X-MC-Unique: 5eIu5RaaP6Gd0R4hwoRzEA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-401b8089339so30917415e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694425833; x=1695030633;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3hI7Q7HmJLGnvJ6TWSuqo/D2NRHYvfG0p6wZ2y0ko6s=;
        b=TzPIFARJ2RrIynmdM3y4PRKRq/uop3R79Lu+i+GHIUaVa8AsO7qZCEFwpR+kNzzrlY
         SdcFtVm0PE45/NzoqdIaf9MKH7qehI7B7VdyevUfUmvPiFkoRqKCXkFasyW6A+iJPZad
         2YapDeCiqJC2aXRfHcx3tv23SiA7nNOXFz408pQNlUrqXYj3MOvxdl6p80DYpFmaigtJ
         heLeoaXI6BoRVoaU6ELwpMPK8mcVhSIP7SsY7G+Q3AJqs37VVwQHQKZIJcBUkcFldL3E
         zjdXj1hbURkZSwqC9W2gHLxdPruIbRvShSBlOsL00xQ+EJM3gyVVT0z8c6TPuCcgcCeK
         G5XQ==
X-Gm-Message-State: AOJu0YwcSqqPcSicPoNN6au/+8Tzdain1oEECjVx6O+y91zOupVBbm5y
        l5XJZO6d6R3N92miwNbFBZ1tmES4fyuRUSZ1VZZgzivypXzdsdvbTIq5hNqdy1Asq0I5E/AePaM
        B5qecdJ2bsWU5G2C/+xYs8YM1
X-Received: by 2002:a05:600c:ad2:b0:3fe:1871:1826 with SMTP id c18-20020a05600c0ad200b003fe18711826mr8233495wmr.27.1694425833710;
        Mon, 11 Sep 2023 02:50:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEj8YJrIUf0UCqWXG8KH6oM4Y88u3/pmtlr2wHp0tLZ2zrPuhEBzJbkMb9F1qoq/xPMcrqORA==
X-Received: by 2002:a05:600c:ad2:b0:3fe:1871:1826 with SMTP id c18-20020a05600c0ad200b003fe18711826mr8233473wmr.27.1694425833313;
        Mon, 11 Sep 2023 02:50:33 -0700 (PDT)
Received: from ?IPV6:2003:cb:c743:5500:a9bd:94ab:74e9:782f? (p200300cbc7435500a9bd94ab74e9782f.dip0.t-ipconnect.de. [2003:cb:c743:5500:a9bd:94ab:74e9:782f])
        by smtp.gmail.com with ESMTPSA id n8-20020a7bcbc8000000b003fe29f6b61bsm9506299wmi.46.2023.09.11.02.50.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 02:50:32 -0700 (PDT)
Message-ID: <476456e1-ac50-8e48-260d-5cbe5e8b085e@redhat.com>
Date:   Mon, 11 Sep 2023 11:50:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] proc/vmcore: Do not map unaccepted memory
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
        kexec@lists.infradead.org
References: <20230906073902.4229-1-adrian.hunter@intel.com>
 <20230906073902.4229-2-adrian.hunter@intel.com>
 <ef97f466-b27a-a883-7131-c2051480dd87@redhat.com>
 <20230911084148.l6han7jxob42rdvm@box.shutemov.name>
 <49ab74c8-553b-b3d0-6a72-2d259a2b5bdf@redhat.com>
 <20230911092712.2ps55mylf7elfqp6@box.shutemov.name>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230911092712.2ps55mylf7elfqp6@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.09.23 11:27, Kirill A. Shutemov wrote:
> On Mon, Sep 11, 2023 at 10:42:51AM +0200, David Hildenbrand wrote:
>> On 11.09.23 10:41, Kirill A. Shutemov wrote:
>>> On Mon, Sep 11, 2023 at 10:03:36AM +0200, David Hildenbrand wrote:
>>>> On 06.09.23 09:39, Adrian Hunter wrote:
>>>>> Support for unaccepted memory was added recently, refer commit
>>>>> dcdfdd40fa82 ("mm: Add support for unaccepted memory"), whereby
>>>>> a virtual machine may need to accept memory before it can be used.
>>>>>
>>>>> Do not map unaccepted memory because it can cause the guest to fail.
>>>>>
>>>>> For /proc/vmcore, which is read-only, this means a read or mmap of
>>>>> unaccepted memory will return zeros.
>>>>
>>>> Does a second (kdump) kernel that exposes /proc/vmcore reliably get access
>>>> to the information whether memory of the first kernel is unaccepted (IOW,
>>>> not its memory, but the memory of the first kernel it is supposed to expose
>>>> via /proc/vmcore)?
>>>
>>> There are few patches in my queue to few related issue, but generally,
>>> yes, the information is available to the target kernel via EFI
>>> configuration table.
>>
>> I assume that table provided by the first kernel, and not read directly from
>> HW, correct?
> 
> The table is constructed by the EFI stub in the first kernel based on EFI
> memory map.
> 

Okay, should work then once that's done by the first kernel.

Maybe include this patch in your series?

-- 
Cheers,

David / dhildenb

