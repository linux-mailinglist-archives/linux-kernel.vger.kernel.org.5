Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149BA7B23F1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 19:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjI1Rat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 13:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjI1Rar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 13:30:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761BA1AD
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 10:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695922200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+4sYcMfxqTnzgFrCEZfVXXlsFEBmmiyRD3TMJswsdYg=;
        b=aZWShuB08R8oRg6Gppia2yK7Yn8L4N3gI4d9zBDlvEri4WfrYKBBBmmTUlTNMXmvruc8Bc
        jt91v8AjT8QM7oINyZESHXhav54xWtVq6YBNCPnpdU2nzd9IMurR2DA4AChzVVA9wnX9qa
        r1Jqmupqnac5GvteUcHDUyoojg3ROsI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-voYdG6XGMO6vEaK-u5P6_A-1; Thu, 28 Sep 2023 13:29:56 -0400
X-MC-Unique: voYdG6XGMO6vEaK-u5P6_A-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4053a5c6a59so110910385e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 10:29:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695922195; x=1696526995;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+4sYcMfxqTnzgFrCEZfVXXlsFEBmmiyRD3TMJswsdYg=;
        b=PzL7+bjFcoyQZhNKiolct8dOqDWdlhfwsQIpm0uWLgjZq7OygAafem7QQpsjY9GJlL
         K/rp9JFwmp/0MmnPSKFUmd/Qb65AcLuDP2HJb3ury6VOc0gut4kh7YoJ8kSRLI9J5n99
         V20vMfcgQPJ+RQERiPvx/1l0trLO+fHBwuTXjM7QWAoelnYjbqmsvuKzyuzkRMpDeRct
         CLS9VXXj+TWbLA2Vr+uNku4WG/yo5IwUPXOWE4qbmQh0CHDoK7rRq+0DokqEd2zbkmP8
         NOWD4DSTqGtAbe0BkK1+4QIWxJM3WHRr0N4qZq4nkH2wnC+mgHi4nO8bNo+iERrQ5+pU
         HgUw==
X-Gm-Message-State: AOJu0Yy1zo001fBB6+MaOdjWB2mdmmYIIjepoEN9lHz8v3BrEYzj33+s
        6UySNTOWY/hi1JOeNFBKXsUNhJWLt1J28wLMUmsgyS+zZ80KuQwNMoI29pY2IRe+B9Tf/DdcGj8
        GlQelshuQGHOhlDzy8j5KvMHv
X-Received: by 2002:a5d:58c1:0:b0:31c:3136:60af with SMTP id o1-20020a5d58c1000000b0031c313660afmr1404412wrf.61.1695922195721;
        Thu, 28 Sep 2023 10:29:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAdjAUBqA8qaoWqAi1QmoFnrMG8cfswCS9Yn7LtSlgQgV/g93InbG4ZlwdY0nlh4hq9SurwA==
X-Received: by 2002:a5d:58c1:0:b0:31c:3136:60af with SMTP id o1-20020a5d58c1000000b0031c313660afmr1404390wrf.61.1695922195320;
        Thu, 28 Sep 2023 10:29:55 -0700 (PDT)
Received: from ?IPV6:2003:cb:c718:f00:b37d:4253:cd0d:d213? (p200300cbc7180f00b37d4253cd0dd213.dip0.t-ipconnect.de. [2003:cb:c718:f00:b37d:4253:cd0d:d213])
        by smtp.gmail.com with ESMTPSA id b12-20020a5d634c000000b0031ad2f9269dsm19862621wrw.40.2023.09.28.10.29.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 10:29:54 -0700 (PDT)
Message-ID: <838c24a6-5866-a800-ba50-0311d4a4f1d2@redhat.com>
Date:   Thu, 28 Sep 2023 19:29:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>,
        Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        stanislav.kinsburskii@gmail.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-mm@kvack.org, kys@microsoft.com, jgowans@amazon.com,
        wei.liu@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        graf@amazon.de, pbonzini@redhat.com
References: <01828.123092517290700465@us-mta-156.us.mimecast.lan>
 <ZRPBRkXrYvbw8+Lt@MiWiFi-R3L-srv>
 <58146.123092712145601339@us-mta-73.us.mimecast.lan>
 <ZRVUqLSH7HfVLy+G@MiWiFi-R3L-srv>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH v2 0/7] Introduce persistent memory pool
In-Reply-To: <ZRVUqLSH7HfVLy+G@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.09.23 12:25, Baoquan He wrote:
> On 09/27/23 at 09:13am, Stanislav Kinsburskii wrote:
>> On Wed, Sep 27, 2023 at 01:44:38PM +0800, Baoquan He wrote:
>>> Hi Stanislav,
>>>
>>> On 09/25/23 at 02:27pm, Stanislav Kinsburskii wrote:
>>>> This patch introduces a memory allocator specifically tailored for
>>>> persistent memory within the kernel. The allocator maintains
>>>> kernel-specific states like DMA passthrough device states, IOMMU state, and
>>>> more across kexec.
>>>
>>> Can you give more details about how this persistent memory pool will be
>>> utilized in a actual scenario? I mean, what problem have you met so that
>>> you have to introduce persistent memory pool to solve it?
>>>
>>
>> The major reason we have at the moment, is that Linux root partition
>> running on top of the Microsoft hypervisor needs to deposit pages to
>> hypervisor in runtime, when hypervisor runs out of memory.
>> "Depositing" here means, that Linux passes a set of its PFNs to the
>> hypervisor via hypercall, and hypervisor then uses these pages for its
>> own needs.
>>
>> Once deposited, these pages can't be accessed by Linux anymore and thus
>> must be preserved in "used" state across kexec, as hypervisor state is
>> unware of kexec. In the same time, these pages can we withdrawn when
>> usused. Thus, an allocator persistent across kexec looks reasonable for
>> this particular matter.
> 
> Thanks for these details.
>   
> The deposit and withdraw remind me the Balloon driver, David's virtio-mem,
> DLPAR on ppc which can hot increasing or shrinking phisical memory on guest
> OS. Can't microsoft hypervisor do the similar thing to reclaim or give
> back the memory from or to the 'Linux root partition' running on top of
> the hypervisor?

virtio-mem was designed with kexec support in mind. You only expose the 
initial memory to the second kernel, and that memory can never have such 
holes. That does not apply to memory ballooning implementations, like 
Hyper-V dynamic memory.

In the virtio-mem paper I have the following:

"In our experiments, Hyper-V VMs crashed reliably when
trying to use kexec under Linux for fast OS reboots with
an inflated balloon. Other memory ballooning mechanisms
either have to temporarily deflate the whole balloon or al-
low access to inflated memory, which is undesired in cloud
environments."

I remember XEN does something elaborate, whereby they allow access to 
all inflated memory during reboot, but limit the total number of pages 
they will hand out. IIRC, you then have to work around things like 
"Windows initializes all memory with 0s when booting, and cope with 
that". So there are ways how hypervisors handled that in the past.

-- 
Cheers,

David / dhildenb

