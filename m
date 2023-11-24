Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB827F84E3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 20:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346065AbjKXTro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 14:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345941AbjKXTrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 14:47:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE5393
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 11:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700855267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=UoSyH7/Xs2EDz5XVIi0UGi5J8M7FGAkh0W4dXp+AavI=;
        b=ZxeSxkt09kk+H8edaGe92TDnfjcI4nO0JuLHCReb02GMhUcj/DeDmeNrjM6Hk2Ow80/DB8
        1rEkx2AwsGdiH0AQLzH55sRKcEbWh9UvJreDaT4eBMKCgPwTl+MKxFIlJm9xRInY+3Q1Gx
        0+q7TLpfL5lvhm1He21WZnBjTN7tXqI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-ZqCrDK7dM2-aXcuJOWQFOQ-1; Fri, 24 Nov 2023 14:47:45 -0500
X-MC-Unique: ZqCrDK7dM2-aXcuJOWQFOQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40b2c0df444so12853235e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 11:47:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700855264; x=1701460064;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UoSyH7/Xs2EDz5XVIi0UGi5J8M7FGAkh0W4dXp+AavI=;
        b=CwKmwwGvK5uxZbxN9e/X8ev0saw1hv8Qz7fy2qiRZHfuYNVbHP8+rsObrwdZ3xGZ+c
         didyyquWQU2JIla309O5wzm7Q88vp2QJxG55B/GItYjEfCZMcrGGV23Ukh+NSxqCqJWS
         KEdi9X1UPDEIaclkpX4g4zSUARW7Y3nKxE4DaH96OIvlf9nvjaSkccMoUk3SqiY5BhyW
         U/kfLJV6WRoKftX/TzApE/ccTwe9QUE5G3+DgpGudXO7EvyI79bZOInYkXrnghh3kab8
         xTERfnIAD9MyFoQiyF0ZKK4Pg8mbTvPEVXYmF+oLhl2eYyhL1NwdsSRDUzEIMC7AUYsG
         wC+w==
X-Gm-Message-State: AOJu0YzY5PIdQqjefnTkR3FJUhFD/OoBEevMowSAoudXxPhd4Qk1/KdC
        kmaKd9QnWel1k3No6V+glJxp0oPZBpBErCanMKwTnQzYl76tajI5zBtPk04hsV8bYkzGFR8e5iN
        cPHrteuPTXsu6vcfisQoBnLg7PJr6fUqs
X-Received: by 2002:a05:600c:1396:b0:405:34e4:14cf with SMTP id u22-20020a05600c139600b0040534e414cfmr3579201wmf.4.1700855264598;
        Fri, 24 Nov 2023 11:47:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmtXKZEo6EOiTl6aWmSx8lpOfZgsY3/2HPDyopQc6oyygaWSlVBHXhfORZ1q3Llscv6Nxoow==
X-Received: by 2002:a05:600c:1396:b0:405:34e4:14cf with SMTP id u22-20020a05600c139600b0040534e414cfmr3579185wmf.4.1700855264192;
        Fri, 24 Nov 2023 11:47:44 -0800 (PST)
Received: from ?IPV6:2003:cb:c721:a000:7426:f6b4:82a3:c6ab? (p200300cbc721a0007426f6b482a3c6ab.dip0.t-ipconnect.de. [2003:cb:c721:a000:7426:f6b4:82a3:c6ab])
        by smtp.gmail.com with ESMTPSA id n17-20020a05600c4f9100b004090798d29csm5896863wmq.15.2023.11.24.11.47.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 11:47:43 -0800 (PST)
Message-ID: <9d5de524-28ee-4d71-9493-f77967ea213c@redhat.com>
Date:   Fri, 24 Nov 2023 20:47:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/4] hugetlb: parallelize hugetlb page allocation
 on boot
Content-Language: en-US
To:     David Rientjes <rientjes@google.com>
Cc:     Gang Li <gang.li@linux.dev>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Gang Li <ligang.bdlg@bytedance.com>
References: <20231123133036.68540-1-gang.li@linux.dev>
 <5c0e27f2-5826-4537-a1ab-1debfab65b9a@redhat.com>
 <28e28c2a-e72d-a181-e87a-39cecc8c3c76@google.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <28e28c2a-e72d-a181-e87a-39cecc8c3c76@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.11.23 20:44, David Rientjes wrote:
> On Thu, 23 Nov 2023, David Hildenbrand wrote:
> 
>> On 23.11.23 14:30, Gang Li wrote:
>>> From: Gang Li <ligang.bdlg@bytedance.com>
>>>
>>> Inspired by these patches [1][2], this series aims to speed up the
>>> initialization of hugetlb during the boot process through
>>> parallelization.
>>>
>>> It is particularly effective in large systems. On a machine equipped
>>> with 1TB of memory and two NUMA nodes, the time for hugetlb
>>> initialization was reduced from 2 seconds to 1 second.
>>
>> Sorry to say, but why is that a scenario worth adding complexity for /
>> optimizing for? You don't cover that, so there is a clear lack in the
>> motivation.
>>
>> 2 vs. 1 second on a 1 TiB system is usually really just noise.
>>
> 
> The cost will continue to grow over time, so I presume that Gang is trying
> to get out in front of the issue even though it may not be a large savings
> today.
> 
> Running single boot tests, with the latest upstream kernel, allocating
> 1,440 1GB hugetlb pages on a 1.5TB AMD host appears to take 1.47s.
> 
> But allocating 11,776 1GB hugetlb pages on a 12TB Intel host takes 65.2s
> today with the current implementation.

And there, the 65.2s won't be noise because that 12TB system is up by a 
snap of a finger? :)

-- 
Cheers,

David / dhildenb

