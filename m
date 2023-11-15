Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92BAA7EC0F1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 11:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234906AbjKOKtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 05:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbjKOKtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 05:49:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F40C2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 02:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700045370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=6h5lZpCuSazHgv2YmM0iVJvh4zmhX2/1WMTc2oqtGbs=;
        b=L7WcVCQBE3YuH8wV0tWhag/87xJFB/RAhZnozM9i+O8fvRi5w3Ubxxje2gYYgXtW7sp2SU
        kubj3vXwWgq+fae6nLETNejh9k8hw4ZbsLmuseG6B9FQX+e5BxFiQPOiYuZccWQRx9/KG2
        hyzGLULxIjDY1DKWoP2vBQhnJSrVGUQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-nq6gegInPaKbQq9LhH7Z3Q-1; Wed, 15 Nov 2023 05:49:28 -0500
X-MC-Unique: nq6gegInPaKbQq9LhH7Z3Q-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40a36dd4a58so40584405e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 02:49:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700045366; x=1700650166;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6h5lZpCuSazHgv2YmM0iVJvh4zmhX2/1WMTc2oqtGbs=;
        b=qvQpGpM4e+IHKHe0GH0qNWe2ukvh7R3LP3Os5dk9lzaE8UHBBkbymC6EpLZGT4QN+n
         PUlWNHU6FUy2F+T3aGcgsNJuzL72g7pyM9bIESW1MbVUFQeDP8iCIAyR0hxGyMdK3t2q
         kfnlVa1ZCP83csRYgLdO2PyShVn99nP77OtrlSMXT9XKHhPI5BkqtG6tgVaxVTz4JozH
         ZOl7DvaSGDFk44/XulEwqn2YuqiKgXoyj/CQd8VguG4bDuPXp1F4KHHJagN49xak91Sw
         f2gCrqF/PzwG/hsP3/o2gk+ed1JupaHFeSIoRzJiXY20h+fb2vlttUeoEqTtBLHq/M66
         ehVg==
X-Gm-Message-State: AOJu0YzQyJjmqBNQGOUSfaaLHYmqmZBK3dB33ntzOJ2unw+uklodm24U
        pnCKIn+oESNc31BKmdH0MR9hIiYEDGPZH3bfjxiE7qibiuS/GV2Xq28cTkSu/2rmceV4vu+w3Kg
        xJH94YclCNu3Shpfra6Rrr6/Z
X-Received: by 2002:a05:600c:4690:b0:40a:5129:c284 with SMTP id p16-20020a05600c469000b0040a5129c284mr6999671wmo.35.1700045366638;
        Wed, 15 Nov 2023 02:49:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXuKDiUWKKYy3IGKX+TZHqubb7f4QBQd/nbWMupiFlKtRRUq5e+cB97mwm52mWbcWl1PTQ2Q==
X-Received: by 2002:a05:600c:4690:b0:40a:5129:c284 with SMTP id p16-20020a05600c469000b0040a5129c284mr6999658wmo.35.1700045366260;
        Wed, 15 Nov 2023 02:49:26 -0800 (PST)
Received: from ?IPV6:2003:cb:c706:ed00:59ee:f048:4ed9:62a6? (p200300cbc706ed0059eef0484ed962a6.dip0.t-ipconnect.de. [2003:cb:c706:ed00:59ee:f048:4ed9:62a6])
        by smtp.gmail.com with ESMTPSA id s21-20020a05600c45d500b0040775501256sm14450380wmo.16.2023.11.15.02.49.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 02:49:25 -0800 (PST)
Message-ID: <d87bfcdd-cbaa-4485-a63b-6a524681fa08@redhat.com>
Date:   Wed, 15 Nov 2023 11:49:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ksm: delay the check of splitting compound pages
Content-Language: en-US
To:     xu <xu.xin.sc@gmail.com>
Cc:     akpm@linux-foundation.org, imbrenda@linux.ibm.com,
        jiang.xuexin@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ran.xiaokai@zte.com.cn, wang.yong12@zte.com.cn,
        xu.xin16@zte.com.cn, yang.yang29@zte.com.cn
References: <b4a11840-0118-44af-9397-30b5bcdd6552@redhat.com>
 <20231115031129.1970581-1-xu.xin16@zte.com.cn>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231115031129.1970581-1-xu.xin16@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.11.23 04:11, xu wrote:
>>> diff --git a/mm/ksm.c b/mm/ksm.c
>>> index 7efcc68ccc6e..c952fe5d9e43 100644
>>> --- a/mm/ksm.c
>>> +++ b/mm/ksm.c
>>> @@ -2229,24 +2229,10 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
>>>    	tree_rmap_item =
>>>    		unstable_tree_search_insert(rmap_item, page, &tree_page);
>>>    	if (tree_rmap_item) {
>>> -		bool split;
>>> -
>>>    		kpage = try_to_merge_two_pages(rmap_item, page,
>>>    						tree_rmap_item, tree_page);
>>> -		/*
>>> -		 * If both pages we tried to merge belong to the same compound
>>> -		 * page, then we actually ended up increasing the reference
>>> -		 * count of the same compound page twice, and split_huge_page
>>> -		 * failed.
>>> -		 * Here we set a flag if that happened, and we use it later to
>>> -		 * try split_huge_page again. Since we call put_page right
>>> -		 * afterwards, the reference count will be correct and
>>> -		 * split_huge_page should succeed.
>>> -		 */
>>
>> I'm curious, why can't we detect that ahead of time and keep only a
>> single reference? Why do we need the backup code? Anything I am missing?
> 
> I don't know the original reason, better ask Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>.
> Maybe because doing detection that ahead of time will break several funtions' semantic,
> such as try_to_merge_two_pages(), try_to_merge_with_ksm_page() and try_to_merge_one_page()
> 
> Adding the backup code don't change the old code and fixing the old problem, it's good.

It's absolutely counter-intuitive to check for something that cannot 
possibly work after the effects. This better has a good reason to make 
that code more complicated.
-- 
Cheers,

David / dhildenb

