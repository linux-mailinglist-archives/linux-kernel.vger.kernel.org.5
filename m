Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C088769D25
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbjGaQtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbjGaQtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:49:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C641728
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 09:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690822133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6TgwT38r7+YbyfH94qkF+Uv3IgMJq4zc27cr5GOz45w=;
        b=E6j4nNfsg08vDGePcxHD5kIJWszOIIqaxaxpFG6tU3vULEH9YdwRt2g+CQneuhy82qtnfH
        ZGEi2EzR3VouuqUDf54FA1SOn2B9Dmrb1rdRruXOD7Eh4RGZX0s2ENKHmsYrvoXVUQIgYZ
        WTd0wLzmaWvZ7ReQ4KxMfAe+jyJR6nc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-e-XahwSlMIqVz0m_OT-iZQ-1; Mon, 31 Jul 2023 12:48:50 -0400
X-MC-Unique: e-XahwSlMIqVz0m_OT-iZQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-30932d15a30so2597992f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 09:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690822129; x=1691426929;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6TgwT38r7+YbyfH94qkF+Uv3IgMJq4zc27cr5GOz45w=;
        b=dSI227hsKF4nJGy2+xuKnNKPzn+c3dAzZa3eBLuCemqHlF1HTMmMeu3JKdruPeQUnv
         pQcEEXzbbxm7veFvf2VlCtMIG4p+ecpsuVT9rYGRh6jpZ4yK8q5Of8Dihsr36hIcP5la
         P0j0WuGUSUXaWbWWVhuk6b4DoyU1+uc14pjmvOmXhBMiPuind+4urwxHP24Q+3rWQNAb
         A0pNSpgm5O7fZNFZb+0jF0yX/IZwRjdYCRyBq2hVXk5dZ1kXPWfopywRNyBS4/LRisEj
         xIXuuUmOQV4HK9923Y+vCGNpfZa9XPUfMHPkLbqNR4+Q5EWwsFSMoMpef2s0SXGrgt1R
         dv6g==
X-Gm-Message-State: ABy/qLb0Hn/hRPurx8j/mewyOEsXpCfG7j5TM2iwnjkhM9PD/GDs5TIr
        RePEyYWdrOSak6FSuEA64NBebcFkLjUzsNXLV3eOHMXEEehPuRgrjb7n8i54xzt0vU15N91yfbu
        3j7S9GNIvhh20AQfY42WnAhoJ
X-Received: by 2002:adf:f7cc:0:b0:314:10d6:8910 with SMTP id a12-20020adff7cc000000b0031410d68910mr280804wrq.63.1690822128760;
        Mon, 31 Jul 2023 09:48:48 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHsulRPcR/7aCWwzmerrdvtLRirVZ/0lTim8W8Rly8QTe7pj1jyO8KSx+l6F7ppUQQ0Bq+k+A==
X-Received: by 2002:adf:f7cc:0:b0:314:10d6:8910 with SMTP id a12-20020adff7cc000000b0031410d68910mr280792wrq.63.1690822128294;
        Mon, 31 Jul 2023 09:48:48 -0700 (PDT)
Received: from ?IPV6:2003:cb:c723:4c00:5c85:5575:c321:cea3? (p200300cbc7234c005c855575c321cea3.dip0.t-ipconnect.de. [2003:cb:c723:4c00:5c85:5575:c321:cea3])
        by smtp.gmail.com with ESMTPSA id y18-20020a5d6212000000b003143c6e09ccsm13700276wru.16.2023.07.31.09.48.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 09:48:47 -0700 (PDT)
Message-ID: <c1f3c78d-b1eb-5c1c-83aa-35901800498f@redhat.com>
Date:   Mon, 31 Jul 2023 18:48:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RFC v2 0/4] Add support for sharing page tables across
 processes (Previously mshare)
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Rongwei Wang <rongwei.wang@linux.alibaba.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        "xuyu@linux.alibaba.com" <xuyu@linux.alibaba.com>
References: <cover.1682453344.git.khalid.aziz@oracle.com>
 <74fe50d9-9be9-cc97-e550-3ca30aebfd13@linux.alibaba.com>
 <ZMeoHoM8j/ric0Bh@casper.infradead.org>
 <ae3bbfba-4207-ec5b-b4dd-ea63cb52883d@redhat.com>
 <9faea1cf-d3da-47ff-eb41-adc5bd73e5ca@linux.alibaba.com>
 <d3d03475-7977-fc55-188d-7df350ee0f29@redhat.com>
 <ZMfjmhaqVZyZNNMW@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZMfjmhaqVZyZNNMW@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.07.23 18:38, Matthew Wilcox wrote:
> On Mon, Jul 31, 2023 at 06:30:22PM +0200, David Hildenbrand wrote:
>> Assume we do do the page table sharing at mmap time, if the flags are right.
>> Let's focus on the most common:
>>
>> mmap(memfd, PROT_READ | PROT_WRITE, MAP_SHARED)
>>
>> And doing the same in each and every process.
> 
> That may be the most common in your usage, but for a database, you're
> looking at two usage scenarios.  Postgres calls mmap() on the database
> file itself so that all processes share the kernel page cache.
> Some Commercial Databases call mmap() on a hugetlbfs file so that all
> processes share the same userspace buffer cache.  Other Commecial
> Databases call shmget() / shmat() with SHM_HUGETLB for the exact
> same reason.

I remember you said that postgres might be looking into using shmem as 
well, maybe I am wrong.

memfd/hugetlb/shmem could all be handled alike, just "arbitrary 
filesystems" would require more work.

> 
> This is why I proposed mshare().  Anyone can use it for anything.
> We have such a diverse set of users who want to do stuff with shared
> page tables that we should not be tying it to memfd or any other
> filesystem.  Not to mention that it's more flexible; you can map
> individual 4kB files into it and still get page table sharing.

That's not what the current proposal does, or am I wrong?

Also, I'm curious, is that a real requirement in the database world?

-- 
Cheers,

David / dhildenb

