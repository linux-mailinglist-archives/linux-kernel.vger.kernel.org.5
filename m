Return-Path: <linux-kernel+bounces-137866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 826E489E87F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 05:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34F2E285571
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 03:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C97ABE49;
	Wed, 10 Apr 2024 03:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJcIp/YS"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084398828
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 03:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712720839; cv=none; b=sYO9DoEnHcYLCgceqmRyM3YH1rRl4BsBszBLUK8XVoY/uft1Q9MwRTLWOQSbWKPixxBcC8BAFO396V7uuUowS0bRShMkgSlk7pCZESaG8t8l41aLgYmHnYKjvP1nDTwZCs47EtUoD5HlUJnJ7PD8yW90ctl5Yamg2iJaOxIJnXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712720839; c=relaxed/simple;
	bh=5fGiF7BYzkTZhFaW0xs9ZlAF3EoXM0Yrlw+8r1VOnUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qcmLnh4C6xOn5BE/wxJZkfxUE0bUPRzOx9dNF48kxC0Bj7d6Mm66C1VBwI40/XBvpwecyVYy7ksgsYEsS5X5XLUpHmoTOmAH8YHfDw2NuWayym/BcXrBSbWJc5XUJDMDsLw3XX/yturF/K/Pho0V1VviIoKR9f8l40FbIepDzGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJcIp/YS; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e6b22af648so5129722b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 20:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712720837; x=1713325637; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ScVv2cVL2IqKu4xZ+K+tP2lIBxE9zyAR4grQNU+Bjo=;
        b=mJcIp/YSTuXsFnB1OYwyfm7nRz5W1h3ka7ok8zV+P3EMm1BjkmoSEBmZh+F6CRxVXM
         0H2wowTVtqMv5DzPSa03+I6V5+cnikQwhawxvbpXH95fS8VnPzvuqKPMC/aJx1RWA4gy
         sxltE1+4+eW/BtXtLMovTpwrE4Lcmm9efAYKG4YbPHQaAt7xQcmEk7tjGAbv4i1UgjfI
         GDYzUCmM0hW9Cv2hv0bMswzhgQ5lw+DVc/rZ9w9NXVlKxj0BNk0WY/ZeTOw/o0pn2TSa
         zOjaK3H6zSAow7BgZuiTTg4WnpnmAsg403euW0xnvvsYSQEMtGrtcxs1EnFXG8sCtKfW
         ZeQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712720837; x=1713325637;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ScVv2cVL2IqKu4xZ+K+tP2lIBxE9zyAR4grQNU+Bjo=;
        b=eSneJYlOuJkYmCjma5Bh8gYafdAzUAeMz04DN1ehDo1FV3cUnOlBDcVIJt4xAxYfJk
         n7ncKiBX/+sWwvHPBWv7Qu74h/J0FrVlBwPHU6bNeNUxOcybbKpt6oC+p5YHUXazOjkZ
         y1W1wNt+oGu1LYbduLLT3bvMrCMDJrhvfACdDPxO8KiR4efdEifxQqS79g8Rn4owAJJs
         mvYkrqSlLrMAQqCNrvtI1ZmYcWWvJmFJVRk+5KJDFxPYSCatqKWrDQ5Toaz/AGeke9Xg
         aZZu98htQPEBaFczfbNRhho0hYZOwRA+MxagP6WXjMSKAI9Jw5R0pWkJq2FP/iNZT96I
         F2QA==
X-Forwarded-Encrypted: i=1; AJvYcCVuuTnM32pTcpeea2wuZ3qgjt28qHg6LJ9a/9KJAOaer7tsNBLmXMau2hYoJBwfHVZGuGzAFyIJiRAtN5Z70VvIGX3owrH9plwXl59e
X-Gm-Message-State: AOJu0YwkGQyW8jTJub/yRG9Qb5q4o6PkADkoQblRq2UbV05J2JYth4Wa
	r4st/g0fUuV1w+9+xNFhPx7WONDg56VSkNFcqp1wGYB+FOD7dJrS
X-Google-Smtp-Source: AGHT+IFiB5jsn3AGo/5iAgNUbHEhKu4d5iOYuirmAZu/Ka6Satlkn8EVmM7q7CuefwC6pNruOCFhXw==
X-Received: by 2002:a05:6a20:9185:b0:1a8:6727:1c6 with SMTP id v5-20020a056a20918500b001a8672701c6mr2242227pzd.14.1712720837184;
        Tue, 09 Apr 2024 20:47:17 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id f24-20020a631018000000b005f07f34eb59sm9050174pgl.27.2024.04.09.20.47.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 20:47:16 -0700 (PDT)
Message-ID: <c35fcdca-bec9-4a68-99dd-dbc9b3ad97a5@gmail.com>
Date: Wed, 10 Apr 2024 11:47:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/9] mm/ksm: Convert chain series funcs and replace
 get_ksm_page
To: David Hildenbrand <david@redhat.com>, alexs@kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: Izik Eidus <izik.eidus@ravellosystems.com>,
 Matthew Wilcox <willy@infradead.org>, Andrea Arcangeli
 <aarcange@redhat.com>, Hugh Dickins <hughd@google.com>,
 Chris Wright <chrisw@sous-sol.org>
References: <20240409092826.1733637-1-alexs@kernel.org>
 <20240409092826.1733637-9-alexs@kernel.org>
 <7a8d8005-3cec-4647-82b0-2d55d0ef34fc@redhat.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <7a8d8005-3cec-4647-82b0-2d55d0ef34fc@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/9/24 7:02 PM, David Hildenbrand wrote:
> On 09.04.24 11:28, alexs@kernel.org wrote:
>> From: "Alex Shi (tencent)" <alexs@kernel.org>
>>
>> In ksm stable tree all page are single, let's convert them to use and
>> folios as well as stable_tree_insert/stable_tree_search funcs.
>> And replace get_ksm_page() by ksm_get_folio() since there is no more
>> needs.
>>
>> It could save a few compound_head calls.
>>
>> Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
>> Cc: Izik Eidus <izik.eidus@ravellosystems.com>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>> Cc: Hugh Dickins <hughd@google.com>
>> Cc: Chris Wright <chrisw@sous-sol.org>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
> 
> I don't recall giving that yet :)

Ops... 
Sorry for misunderstand!

> 
> You could have kept some get_ksm_page()->ksm_get_folio() into a separate patch.
> 
> i.e., "[PATCH v3 11/14] mm/ksm: remove get_ksm_page and related info" from your old series could have mostly stayed separately.
> 

Yes, but the 12th and 11th patches are kind of depends each other, like after merge 8,9,10,12th with get_ksm_page replaced,

./mm/ksm.c:993:21: error: ‘get_ksm_page’ defined but not used [-Werror=unused-function]
  993 | static struct page *get_ksm_page(struct ksm_stable_node *stable_node,
      |                     ^~~~~~~~~~~~

so we have to squash the 11th and 12th if we want to merge 12th with 8,9,10...
or we can do just merge the 8,9,10 and keep 11th, 12th as your first suggestion?

> [...]
> 
>>   /*
>> @@ -1829,7 +1821,7 @@ static __always_inline struct page *chain(struct ksm_stable_node **s_n_d,
>>    * This function returns the stable tree node of identical content if found,
>>    * NULL otherwise.
>>    */
>> -static struct page *stable_tree_search(struct page *page)
>> +static void *stable_tree_search(struct page *page)
> 
> There is one caller of stable_tree_search() in cmp_and_merge_page().
> 
> Why the change from page* to void* ?

Uh, a bit more changes needs if we want to remove void*. 

diff --git a/mm/ksm.c b/mm/ksm.c
index 0d703c3da9d8..cd414a9c33ad 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1815,7 +1815,7 @@ static __always_inline struct folio *chain(struct ksm_stable_node **s_n_d,
  * This function returns the stable tree node of identical content if found,
  * NULL otherwise.
  */
-static void *stable_tree_search(struct page *page)
+static struct folio *stable_tree_search(struct page *page)
 {
        int nid;
        struct rb_root *root;
@@ -2308,6 +2308,7 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
        struct page *tree_page = NULL;
        struct ksm_stable_node *stable_node;
        struct page *kpage;
+       struct folio *folio;
        unsigned int checksum;
        int err;
        bool max_page_sharing_bypass = false;
@@ -2333,7 +2334,8 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
        }
 
        /* We first start with searching the page inside the stable tree */
-       kpage = stable_tree_search(page);
+       folio = stable_tree_search(page);
+       kpage = &folio->page;
        if (kpage == page && rmap_item->head == stable_node) {
                put_page(kpage);
                return;

> I suspect cmp_and_merge_page() could similarly be converted to some degree to let kpage be a folio (separate patch).
>

Yes, there are couple of changes needed for cmp_and_merge_page() and series try_to_merge_xx_pages(), I am going to change them on the next series patches. Guess 2 phases patches are better for a big/huge one, is this right?

Thanks
Alex 

