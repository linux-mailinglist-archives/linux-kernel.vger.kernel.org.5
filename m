Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031917CBC3A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 09:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbjJQH3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 03:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234593AbjJQH3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 03:29:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE4A83
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 00:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697527706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=wzLeR7ZBF9Y61eeRS3ZpiWYq5P1c5jlr8VXMTwuG4X8=;
        b=hMGo+RJJ+jFILO2TUGyN5zyHh1B+b+xvnfS+Nv2JJ6zw0V7N8KBY6Jdv9Acjx6RuBoMwvO
        fAMyLwg7aAY0lvdjeiln14sQ9+1GuAy0XjowL99ewWZIULqgH5Yim5hotX/Uqj7Esg/xMT
        btDlX8iwh+6ucsYINgWS5YnzM2r8tH4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-1Z7hmffpPq2iwbWsmFiBmw-1; Tue, 17 Oct 2023 03:28:18 -0400
X-MC-Unique: 1Z7hmffpPq2iwbWsmFiBmw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40554735995so41475305e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 00:28:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697527697; x=1698132497;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzLeR7ZBF9Y61eeRS3ZpiWYq5P1c5jlr8VXMTwuG4X8=;
        b=o+T2IpF9qn4DIqMpRNZ4ADHVgrbjgXHwjidjfCioPPmRETq8pxzpIa7mjblSHKdhT9
         jpyheCY2wjWlcUnlAJBWLC+eCg8hCB6qMmUv1btkMLqBSlyIyx2UIDA8WbkQPJFiNKvd
         1s7nkrZ0r9vU9s3P5tO0d+V4ah4HOG9s2GfCFVg3F4w5jMEwR54KAeGzGpVsEXa/eWcu
         WrPX34ixR9SjBLKPsK0ICAei2ExmMH3wvev81q+DB0bsAonP86JsgY/yAr0l1+HhCuXF
         skEDLrMs7WrmmJ/9H0fA5sAPBO5Rg5IGjPqpqr2kSnc7xRHEPBw7OCryklpuDIb1hLdH
         xx5A==
X-Gm-Message-State: AOJu0YyQh4UbKVKa9fJugwFTmYdwp/Zbu137YJhOA1J9eWJM8EpD20YE
        WDltdIBjJnkA+U6zMbahJcb1rtkKrj8FZvRvLC43p0yuDtldBjLdSXyKincR5/Hn/5pATgPRUnJ
        LNoRRWiebuPQV8Vod6O/P4S2S
X-Received: by 2002:a05:600c:1990:b0:406:177e:5df7 with SMTP id t16-20020a05600c199000b00406177e5df7mr1148366wmq.29.1697527696957;
        Tue, 17 Oct 2023 00:28:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKyQxEer2e7zGbN816MK+GY0NOiHLN2t5Xe4INWor4w5R+VF1VIkEGDXCcweItZkGYg814RA==
X-Received: by 2002:a05:600c:1990:b0:406:177e:5df7 with SMTP id t16-20020a05600c199000b00406177e5df7mr1148345wmq.29.1697527696513;
        Tue, 17 Oct 2023 00:28:16 -0700 (PDT)
Received: from ?IPV6:2003:cb:c743:5100:93b1:f654:ad11:cd81? (p200300cbc743510093b1f654ad11cd81.dip0.t-ipconnect.de. [2003:cb:c743:5100:93b1:f654:ad11:cd81])
        by smtp.gmail.com with ESMTPSA id r17-20020a05600c35d100b00407752bd834sm1114861wmq.1.2023.10.17.00.28.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 00:28:15 -0700 (PDT)
Message-ID: <4207feb8-be8c-4d49-b880-31366c0414cb@redhat.com>
Date:   Tue, 17 Oct 2023 09:28:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/mm: drop 4MB restriction on minimal NUMA node size
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>, x86@kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20231017062215.171670-1-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231017062215.171670-1-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.10.23 08:22, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> Qi Zheng reports crashes in a production environment and provides a
> simplified example as a reproducer:
> 
>    For example, if we use qemu to start a two NUMA node kernel,
>    one of the nodes has 2M memory (less than NODE_MIN_SIZE),
>    and the other node has 2G, then we will encounter the
>    following panic:
> 
>    [    0.149844] BUG: kernel NULL pointer dereference, address: 0000000000000000
>    [    0.150783] #PF: supervisor write access in kernel mode
>    [    0.151488] #PF: error_code(0x0002) - not-present page
>    <...>
>    [    0.156056] RIP: 0010:_raw_spin_lock_irqsave+0x22/0x40
>    <...>
>    [    0.169781] Call Trace:
>    [    0.170159]  <TASK>
>    [    0.170448]  deactivate_slab+0x187/0x3c0
>    [    0.171031]  ? bootstrap+0x1b/0x10e
>    [    0.171559]  ? preempt_count_sub+0x9/0xa0
>    [    0.172145]  ? kmem_cache_alloc+0x12c/0x440
>    [    0.172735]  ? bootstrap+0x1b/0x10e
>    [    0.173236]  bootstrap+0x6b/0x10e
>    [    0.173720]  kmem_cache_init+0x10a/0x188
>    [    0.174240]  start_kernel+0x415/0x6ac
>    [    0.174738]  secondary_startup_64_no_verify+0xe0/0xeb
>    [    0.175417]  </TASK>
>    [    0.175713] Modules linked in:
>    [    0.176117] CR2: 0000000000000000
> 
> The crashes happen because of inconsistency between nodemask that has
> nodes with less than 4MB as memoryless and the actual memory fed into
> core mm.
> 
> The commit 9391a3f9c7f1 ("[PATCH] x86_64: Clear more state when ignoring
> empty node in SRAT parsing") that introduced minimal size of a NUMA node
> does not explain why a node size cannot be less than 4MB and what boot
> failures this restriction might fix.
> 
> Since then a lot has changed and core mm won't confuse badly about small
> node sizes.
> 
> Drop the limitation for the minimal node size.
> 
> Reported-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Link: https://lore.kernel.org/all/20230212110305.93670-1-zhengqi.arch@bytedance.com/

That's just a resend I assume? Or has anything changed?

-- 
Cheers,

David / dhildenb

