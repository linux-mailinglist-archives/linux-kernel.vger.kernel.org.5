Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130507F0E44
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 09:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbjKTI5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 03:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbjKTI5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 03:57:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831CFA4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 00:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700470630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=5Qf+s++PJXkoIaJ5ZWtjbotl2CQD5cU4WwKuFq4lyG8=;
        b=GROTT17vHJ9jqMHomTo8s8QAKdU41Jd+RW54kN6mtVUv/tGFFShhpevRUlDD7DF6YFGSZV
        +uuC2kfbfFVYCs0qqRD7tqbxFC3ygf8YX+WFUtXVor4sqhffGq8ElqtVbLCOjZSZYnoZEs
        U1Pdtq0Xwv3RlmChdM3cl9aXfHJ3hDg=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-EKOoA7LGOPC66nrBWAY_rw-1; Mon, 20 Nov 2023 03:57:09 -0500
X-MC-Unique: EKOoA7LGOPC66nrBWAY_rw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5079a3362afso3793584e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 00:57:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700470628; x=1701075428;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Qf+s++PJXkoIaJ5ZWtjbotl2CQD5cU4WwKuFq4lyG8=;
        b=tSzaQu1TX7dpx2qRESYp3IoBHKEnHuCsVcXAcpo67UFmqeZwX3SAU/sFNqCjSnGmiT
         hxizzPe58mAAHddIXjRo6rsc9LFSn+t67L6RGPCKJKXlrbjm4WAri7VJr5COIEbj3HOa
         V45VkOJ+j2OAYBYYA3tpFHvBXdK8qc9ahglg9f3jKpRTrkhp74L4xVh/yKZr0y27izrS
         e1AI5/80y3Xmcx5GFxOwRaZGg3+rfiohY1IarlVQWtJdojOXLWhE88GHB6YhWQnLubvO
         sfdq42rrUhkzLGVSW5jVEU66z/a5I8jWDyH2vJ8/3xO6SfZ+78omEYfWfI1o/PRLDXeD
         1EPw==
X-Gm-Message-State: AOJu0YxK/iMdMbPbui34l+719sxD0+DTv6QbCwt2Lch29ZfnavlcIksP
        PzAKonzmDDcDOwfJXCU2cwONnBmYpfZCUj2IS4BcZnQJ8wP7rMb2aqAUCgGb/y9HsIr+JJ/V2kn
        6jLiPRF0eJumTqGasD8hnyAw+
X-Received: by 2002:ac2:59c9:0:b0:509:f45c:fae6 with SMTP id x9-20020ac259c9000000b00509f45cfae6mr5988301lfn.10.1700470627730;
        Mon, 20 Nov 2023 00:57:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFh06/r0MKuhiwR+4tIcg/KWZFHDnajsuICyBAflJOTfSWVJxA+J4knkZKoVK/fbctMYH8BoQ==
X-Received: by 2002:ac2:59c9:0:b0:509:f45c:fae6 with SMTP id x9-20020ac259c9000000b00509f45cfae6mr5988284lfn.10.1700470627351;
        Mon, 20 Nov 2023 00:57:07 -0800 (PST)
Received: from ?IPV6:2003:cb:c746:7700:9885:6589:b1e3:f74c? (p200300cbc746770098856589b1e3f74c.dip0.t-ipconnect.de. [2003:cb:c746:7700:9885:6589:b1e3:f74c])
        by smtp.gmail.com with ESMTPSA id b11-20020a05600010cb00b00332c0d256c5sm5558804wrx.80.2023.11.20.00.57.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 00:57:07 -0800 (PST)
Message-ID: <1d8908d6-8084-4539-8ec0-178815e1c9e7@redhat.com>
Date:   Mon, 20 Nov 2023 09:57:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mm/memory_hotplug: fix error handling in
 add_memory_resource()
Content-Language: en-US
To:     Sumanth Korikkar <sumanthk@linux.ibm.com>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20231120072317.3169630-1-sumanthk@linux.ibm.com>
 <20231120072317.3169630-3-sumanthk@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231120072317.3169630-3-sumanthk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.11.23 08:23, Sumanth Korikkar wrote:
> In add_memory_resource(), creation of memory block devices occurs after
> successful call to arch_add_memory(). However, creation of memory block
> devices could fail.  In that case, arch_remove_memory() is called to
> perform necessary cleanup.
> 
> Currently with or without altmap support, arch_remove_memory() is always
> passed with altmap set to NULL during error handling. This leads to
> freeing of struct pages using free_pages(), eventhough the allocation
> might have been performed with altmap support via
> altmap_alloc_block_buf().
> 
> Fix the error handling by passing altmap in arch_remove_memory(). This
> ensures the following:
> * When altmap is disabled, deallocation of the struct pages array occurs
>    via free_pages().
> * When altmap is enabled, deallocation occurs via vmem_altmap_free().
> 
> Fixes: a08a2ae34613 ("mm,memory_hotplug: allocate memmap from the added memory range")
> Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> ---
>   mm/memory_hotplug.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index c8238fc5edcb..4f476a970e84 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1458,7 +1458,7 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
>   	/* create memory block devices after memory was added */
>   	ret = create_memory_block_devices(start, size, params.altmap, group);
>   	if (ret) {
> -		arch_remove_memory(start, size, NULL);
> +		arch_remove_memory(start, size, params.altmap);
>   		goto error_free;
>   	}
>   

We should likely CC stable on this one

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

