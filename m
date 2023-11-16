Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BE17EE65D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 19:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345400AbjKPSGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 13:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjKPSGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 13:06:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A4AD52
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 10:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700157990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=Fc3j3jASPknCBdxsGHNqQKjfRx07DWXQMKJXeyhrSXg=;
        b=jIkik8rEQW4lssWmSV7oxQCVkztpQNoItzEusXX5I3QlPHKQGSgWvbAAfzVw6jvEIrSMRn
        h0KySKjKV/eqQOxv1NbBpHWfvwfhZkZ3q09nClTiVd8yUS5PaNobo8O9S57gZH/z3HU1rh
        BLVmOXU/eZ5TvME7L2Qh99kQqN2rp1Q=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-ALMgS6R8OuqN4qu2QKQNbQ-1; Thu, 16 Nov 2023 13:06:27 -0500
X-MC-Unique: ALMgS6R8OuqN4qu2QKQNbQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2c50d73e212so9662581fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 10:06:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700157986; x=1700762786;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:from:content-language:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Fc3j3jASPknCBdxsGHNqQKjfRx07DWXQMKJXeyhrSXg=;
        b=UxGgLlohD2TW7NuFvqvSQAx1F87kJ0tW0L0OwanJMi9rsLjM/9hu2uJuCsiqjf7LKd
         PTVJXSdUlYWz6tldk+WjU/3vOzif79U9UcAHM5HGEepg+u4FjD7xjANArTfFd5ptLw2k
         qJh4TeN/HxrRlJ40kBzYnZm+Dsm7gvSjFEsdSPPigx/5lpE9KbwOhiiinQr7tCvW2pbE
         swaWlg7TNbnlNe6ym1IY4uFYg+KHVjd7Kg1IyiIS2u/li0LW0UpMkwD1yudqcZRxKYVd
         vBQmT3sI+kztuP6PlNOHi+suscTn/0NYRJPcU/jEQ30YVSEeyhFt6PaXd1EywbRSf1BZ
         WHLA==
X-Gm-Message-State: AOJu0Yzo75I+qbt1za8F8nRsoo7Oc4Ic1z755xdqhXsH9g56x54VyP2m
        qONgFtcKidnyRrNOiyOqS5GNoKQTmRrY2MxTVXietkQelYFAs/tLLRTR9VJ3Jp6UYmuNp5WoeNq
        DyeGP7UX/w1SQ2K14MsYtbZWq
X-Received: by 2002:a2e:2e19:0:b0:2c5:1ad0:e2ff with SMTP id u25-20020a2e2e19000000b002c51ad0e2ffmr7633498lju.39.1700157985662;
        Thu, 16 Nov 2023 10:06:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlOHiZyjac8DaftCg3hpgN3SyiXFJog+qJLzRn7rNqIOayncCCl1zruKdKZbdUmxYDPIk2xA==
X-Received: by 2002:a2e:2e19:0:b0:2c5:1ad0:e2ff with SMTP id u25-20020a2e2e19000000b002c51ad0e2ffmr7633461lju.39.1700157985161;
        Thu, 16 Nov 2023 10:06:25 -0800 (PST)
Received: from ?IPV6:2003:cb:c714:e000:d929:2324:97c7:112c? (p200300cbc714e000d929232497c7112c.dip0.t-ipconnect.de. [2003:cb:c714:e000:d929:2324:97c7:112c])
        by smtp.gmail.com with ESMTPSA id g18-20020a05600c4ed200b004068e09a70bsm39584wmq.31.2023.11.16.10.06.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 10:06:24 -0800 (PST)
Message-ID: <664505c5-0782-43b8-aad1-b843616fe893@redhat.com>
Date:   Thu, 16 Nov 2023 19:06:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ksm: delay the check of splitting compound pages
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     xu <xu.xin.sc@gmail.com>
Cc:     akpm@linux-foundation.org, imbrenda@linux.ibm.com,
        jiang.xuexin@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ran.xiaokai@zte.com.cn, wang.yong12@zte.com.cn,
        xu.xin16@zte.com.cn, yang.yang29@zte.com.cn
References: <d87bfcdd-cbaa-4485-a63b-6a524681fa08@redhat.com>
 <20231116121715.1974713-1-xu.xin16@zte.com.cn>
 <2d9745ce-e46b-4275-8512-11699f25d921@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <2d9745ce-e46b-4275-8512-11699f25d921@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.11.23 18:39, David Hildenbrand wrote:
> On 16.11.23 13:17, xu wrote:
>>>>>> @@ -2229,24 +2229,10 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
>>>>>>      	tree_rmap_item =
>>>>>>      		unstable_tree_search_insert(rmap_item, page, &tree_page);
>>>>>>      	if (tree_rmap_item) {
>>>>>> -		bool split;
>>>>>> -
>>>>>>      		kpage = try_to_merge_two_pages(rmap_item, page,
>>>>>>      						tree_rmap_item, tree_page);
>>>>>> -		/*
>>>>>> -		 * If both pages we tried to merge belong to the same compound
>>>>>> -		 * page, then we actually ended up increasing the reference
>>>>>> -		 * count of the same compound page twice, and split_huge_page
>>>>>> -		 * failed.
>>>>>> -		 * Here we set a flag if that happened, and we use it later to
>>>>>> -		 * try split_huge_page again. Since we call put_page right
>>>>>> -		 * afterwards, the reference count will be correct and
>>>>>> -		 * split_huge_page should succeed.
>>>>>> -		 */
>>>>>
>>>>> I'm curious, why can't we detect that ahead of time and keep only a
>>>>> single reference? Why do we need the backup code? Anything I am missing?
>>
>> Do you mean like this?
> 
> Let me see if the refcounting here is sane:
> 
> (a) The caller has a reference on "page" that it will put just after the
>       cmp_and_merge_page() call.
> (b) unstable_tree_search_insert() obtained a reference to the
>       "tree_page" using get_mergeable_page()->follow_page(). We will put
>       that reference.
> 
> So indeed, if both references are to the same folio, *we* have two
> references to the folio and can safely drop one of both.
> 
>>
>> --- a/mm/ksm.c
>> +++ b/mm/ksm.c
>> @@ -2229,23 +2229,21 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
>>           tree_rmap_item =
>>                   unstable_tree_search_insert(rmap_item, page, &tree_page);
>>           if (tree_rmap_item) {
>> -               bool split;
>> +               bool SameCompound;
>> +               /*
>> +                * If they belongs to the same compound page, its' reference
>> +                * get twice, so need to put_page once to avoid that
>> +                * split_huge_page fails in try_to_merge_two_pages().
>> +                */
>> +               if (SameCompound = Is_SameCompound(page, tree_page))
>> +                       put_page(tree_page);
>>    
> 
> bool same_folio = page_folio(page) == page_folio(tree_page);
> 
> /*
>    * If both pages belong to the same folio, we are holding two references
>    * to the same large folio: splitting the folio in
>    * try_to_merge_one_page() will fail for that reason. So let's just drop
>    * one reference early.  Note that this is only possible if tree_page is
>    * not a KSM page yet.
>    */
> if (same_folio)
> 	put_page(tree_page);
> 
> [we could use more folio operations here, but lets KIS]
> 

Looking into the details, that doesn't work unfortunately.

try_to_merge_one_page() will call split_huge_page(), but that
will only hold a reference to "page", not to "tree page" after the
split.

Long story short, after split_huge_page() tree_page could get freed
because we don't hold a reference to that one anymore.

So we most probably cannot do better than the following (untested):

diff --git a/mm/ksm.c b/mm/ksm.c
index 7efcc68ccc6e..afb079524585 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2226,25 +2226,30 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
  		if (!err)
  			return;
  	}
+retry:
  	tree_rmap_item =
  		unstable_tree_search_insert(rmap_item, page, &tree_page);
  	if (tree_rmap_item) {
-		bool split;
+		/*
+		 * If both pages belong to the same folio, we are holding two
+		 * references to the same large folio: splitting the folio in
+		 * try_to_merge_one_page() will fail for that reason.
+		 *
+		 * We have to split manually, and lookup the tree_page
+		 * again. Note that we'll only hold a reference to "page" after
+		 * the split.
+		 */
+		if (page_folio(page) == page_folio(tree_page)) {
+			put_page(tree_page);
+
+			if (!trylock_page(page))
+				return;
+			split_huge_page(page);
+			unlock_page(page);
+			goto retry;
+		}
  
  		kpage = try_to_merge_two_pages(rmap_item, page,
  						tree_rmap_item, tree_page);
-		/*
-		 * If both pages we tried to merge belong to the same compound
-		 * page, then we actually ended up increasing the reference
-		 * count of the same compound page twice, and split_huge_page
-		 * failed.
-		 * Here we set a flag if that happened, and we use it later to
-		 * try split_huge_page again. Since we call put_page right
-		 * afterwards, the reference count will be correct and
-		 * split_huge_page should succeed.
-		 */
-		split = PageTransCompound(page)
-			&& compound_head(page) == compound_head(tree_page);
  		put_page(tree_page);
  		if (kpage) {
  			/*
@@ -2271,20 +2276,6 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
  				break_cow(tree_rmap_item);
  				break_cow(rmap_item);
  			}
-		} else if (split) {
-			/*
-			 * We are here if we tried to merge two pages and
-			 * failed because they both belonged to the same
-			 * compound page. We will split the page now, but no
-			 * merging will take place.
-			 * We do not want to add the cost of a full lock; if
-			 * the page is locked, it is better to skip it and
-			 * perhaps try again later.
-			 */
-			if (!trylock_page(page))
-				return;
-			split_huge_page(page);
-			unlock_page(page);
  		}
  	}
  }

-- 
Cheers,

David / dhildenb

