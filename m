Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F707EC0F5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 11:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbjKOKw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 05:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbjKOKw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 05:52:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3026B9F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 02:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700045544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=RKt+LeBx9naR2yTYIAYPQKp23URXk7seSnYTkBXdtao=;
        b=FNkUJhk3e/hBsSkMzUuUr9Aewn3UmaQWsWZiTdegDlhbpODXIuuSCNF6agPF5VA4wVHvAg
        /BJ7TbFQlO6fJxODQOeHfT9xj93PXwvIqAcpnXdgHTAFlsG4P6jQaUfutwiXc3XyL+B88/
        7rqN+qbEEHKXNKSM6x7gpT0+P/T9Beg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-9ikLp7SfOrW5EBEf7PdNbw-1; Wed, 15 Nov 2023 05:52:23 -0500
X-MC-Unique: 9ikLp7SfOrW5EBEf7PdNbw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40845fe2d1cso44751835e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 02:52:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700045542; x=1700650342;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKt+LeBx9naR2yTYIAYPQKp23URXk7seSnYTkBXdtao=;
        b=O57nJdPv2mR783BGnl5b1zN3IrCL5jqYePhg3b6RLaR5mPNeqkUGt328m9eq5mrjcn
         CocJAjCzwKw6IYZfxsoHST3VYmPjb3+n/ERFxQEZsWGCKpOD+JPLrPORhxNHJ6rIQk7X
         obCKXYgZJJRSjyMxpr1HXzLnKXyRtVB/29Gl0/6o+DvKcRwOISPgjBrjk974F1NOTmCQ
         ZBl6C8htFS0NanuZtUfvM6/JPll67o6Z0itJVoKa/hWa5sJ9JBoK3xEBZNLAh/a9qtkl
         xTe+XRsU8VUYuyY2KxIvWKLg3GySuZUOtt+ZVpPjOthVFvv3Jq6gZJtGLidtOnCuud+1
         7Y+w==
X-Gm-Message-State: AOJu0Yy2mPtyBQq7rnzedOkVFBkY/kG8BkDDLxRpasryS59e5yZhsvz/
        77pMEOPpGdKaSpbEdzjP85JQdCpKXuLX36cNK3IWGqhlD5S6XMwOd7rFRt4vcyEV8ISbHXLbUZ/
        7xsZmdWwRPAxJ4WgCboLexcgB
X-Received: by 2002:a05:600c:3591:b0:408:3b8d:f7e8 with SMTP id p17-20020a05600c359100b004083b8df7e8mr10073418wmq.33.1700045541856;
        Wed, 15 Nov 2023 02:52:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3sAk81MObGu9461A4CobH3TGebHEzOOMi5ARspE5tR78OTB4bTYJO4czINTaUGvebwJ3IYQ==
X-Received: by 2002:a05:600c:3591:b0:408:3b8d:f7e8 with SMTP id p17-20020a05600c359100b004083b8df7e8mr10073401wmq.33.1700045541438;
        Wed, 15 Nov 2023 02:52:21 -0800 (PST)
Received: from ?IPV6:2003:cb:c706:ed00:59ee:f048:4ed9:62a6? (p200300cbc706ed0059eef0484ed962a6.dip0.t-ipconnect.de. [2003:cb:c706:ed00:59ee:f048:4ed9:62a6])
        by smtp.gmail.com with ESMTPSA id r21-20020a05600c35d500b00407efbc4361sm20471399wmq.9.2023.11.15.02.52.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 02:52:21 -0800 (PST)
Message-ID: <6bca32fa-6f9b-45ba-9bb2-59726f99a536@redhat.com>
Date:   Wed, 15 Nov 2023 11:52:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ksm: delay the check of splitting compound pages
Content-Language: en-US
To:     xu <xu.xin.sc@gmail.com>
Cc:     akpm@linux-foundation.org, imbrenda@linux.ibm.com,
        jiang.xuexin@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ran.xiaokai@zte.com.cn, wang.yong12@zte.com.cn,
        xu.xin16@zte.com.cn, yang.yang29@zte.com.cn
References: <938be193-8a73-432e-b424-53afa9f8c38e@redhat.com>
 <20231115031553.1970634-1-xu.xin16@zte.com.cn>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231115031553.1970634-1-xu.xin16@zte.com.cn>
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

On 15.11.23 04:15, xu wrote:
>>> From: xu xin <xu.xin16@zte.com.cn>
>>>
>>> Background
>>> ==========
>>> When trying to merge two pages, it may fail because the two pages
>>> belongs to the same compound page and split_huge_page fails due to
>>> the incorrect reference to the page. To solve the problem, the commit
>>> 77da2ba0648a4 ("mm/ksm: fix interaction with THP") tries to split the
>>> compound page after try_to_merge_two_pages() fails and put_page in
>>> that case. However it is too early to calculate of the variable 'split' which
>>> indicates whether the two pages belongs to the same compound page.
>>>
>>> What to do
>>> ==========
>>> If try_to_merge_two_pages() succeeds, there is no need to check whether
>>> to splitting compound pages. So we delay the check of splitting compound
>>> pages until try_to_merge_two_pages() fails, which can improve the
>>> processing efficiency of cmp_and_merge_page() a little.
>>>
>>> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
>>> Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
>>
>> Can we please add a unit test to ksm_functional_tests.c so we actually
>> get it right this time?
> 
> Sure. Maybe we can simply refer to the reproducing way Claudio proposes in
> 77da2ba0648a4 ("mm/ksm: fix interaction with THP").

So, was Claudio able to verify that his fix was correct, and how come we 
figure out 5 years later that that fix is insufficient?

Could it not have possibly worked, has something else changed in the 
meantime, or what's the deal here? Further elaborating on that in the 
patch description and adding a proper Fixes: tag will be appreciated ;)

-- 
Cheers,

David / dhildenb

