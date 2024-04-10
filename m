Return-Path: <linux-kernel+bounces-138199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E035189EDFC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94E452847B8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37011154BF4;
	Wed, 10 Apr 2024 08:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="THG/itM/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9BE13D8A4
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 08:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712738846; cv=none; b=WcW6IdqbiHabzE7NGN7B7uQF7SQvGhwlxkWXwcU7JqXrsNjEiST24PSUn2vT/EoXvWBLGQqZhDZI1PoQcycamMjuX08iTyc8vepe9+ZT9Ii3ts/XUnsOJFVmuWfbmu2tn47H79GHf8YYoG6RdPZeCb6mODjAd92EjYWsy60KR4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712738846; c=relaxed/simple;
	bh=L5Gvkvz1uCCHlgBr7EqrwmsfQmknQvGzrROK0cbFcE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MLQ2B2D51+NByHsM3RgPRPLIT5Rofa02iPbB73fcPVgdXM3/Bb9ViXi2LLDR5DoMoF0Pyt70LQdiIsWflBG/W6xyPsIWm19iM2BBTfqgCaec+AmiVJNgkO1OI4Dw7Q6rFLttoeYdsg1Mp90ZkxciJ9Vv4zb3qtTE9AEkgEkdef8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=THG/itM/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712738843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lbqDQYV2qID0jQ2LK0Y56JhIFmw2n47G66tG276yRU4=;
	b=THG/itM/Dg5AXY44hlsODePR06DbB1KVN2uYb4UMZmt6n1QQEeKvIZfUlLyE8lGBzmvl1i
	XqYQt86iM5EKdqtcEsYQh5sjBNux2oyzllf8XH1sfmFNu6Z7EzQu+EIBt4SQB6yux8Kvy6
	2NJ3wQq89VcanLvE/+4JGz43tBqlWRM=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-XQIXg59UOsiuwpM1GUlgNg-1; Wed, 10 Apr 2024 04:47:21 -0400
X-MC-Unique: XQIXg59UOsiuwpM1GUlgNg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2d88bc8e8a4so27336011fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 01:47:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712738840; x=1713343640;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbqDQYV2qID0jQ2LK0Y56JhIFmw2n47G66tG276yRU4=;
        b=UpL9As93J75nbMQWvtrLmqAD+i/PSuQEd9UVrcvmQyp8lP/jYKHtapIw9Vf4unFYc7
         sATWEcjwVfvNrpkR52ld6xDlwtKFsS8ouSTDX3x8KPe5lHtg/I1Lf9U+nZW5y599/bej
         peGiDMtSc6Vm05R6pFrWdXq/Fi8n5fNfOr0pnYfT3gWS3UgpnhVQ8WDr2clRZjr8l3G9
         2oLM83dlX+Km7QfUBtQNgBDL1p6pxcfeeLeMGnWSk2ol5amrxJj/4yNonI+Y2Y68+7T8
         MQAMEBCTUTNhgQs2JIUG0C2LyUS76xleTu3tp+QuiqN6owjLLRi3c8tyh7smblNq9puC
         08KQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuL7D3bX6NyK4Wg4TtOQVn8F7F3WraeruMxP7Sn0WBsVXhqjC584pT0uatAJQLe0gO+eqr+RZ2kJ10qP7tg9KvZnyZ/WGDGDlsaaxY
X-Gm-Message-State: AOJu0YxGv590eCo9t7sAFoQPuXEGVMNpagY5epC17KtBwaKnGX467Wt9
	UhZoIR7MiR97C0GPuCEoXv/H3hkjEx/jRnBon6SCCsZoeVMHWpokop5SoD4PdJjaaubhxjKASP7
	rdvnBAP/CBCCddgEyKWr7/0qcuyphCQWE80B1/ML0w4LCiBxtitTjQ+Ylkf/QSQ==
X-Received: by 2002:a2e:87cf:0:b0:2d6:8e54:80a1 with SMTP id v15-20020a2e87cf000000b002d68e5480a1mr1395699ljj.19.1712738840245;
        Wed, 10 Apr 2024 01:47:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXOrI1Vw5ijUSqOw5wdQ/75FC9jFr47PYRU8rWYcYFkwV66RL+idajNOtQ4hnogkDZA8307w==
X-Received: by 2002:a2e:87cf:0:b0:2d6:8e54:80a1 with SMTP id v15-20020a2e87cf000000b002d68e5480a1mr1395686ljj.19.1712738839799;
        Wed, 10 Apr 2024 01:47:19 -0700 (PDT)
Received: from ?IPV6:2003:cb:c712:fa00:38eb:93ad:be38:d469? (p200300cbc712fa0038eb93adbe38d469.dip0.t-ipconnect.de. [2003:cb:c712:fa00:38eb:93ad:be38:d469])
        by smtp.gmail.com with ESMTPSA id je7-20020a05600c1f8700b00416a43d60e6sm1576752wmb.39.2024.04.10.01.47.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 01:47:19 -0700 (PDT)
Message-ID: <3f5f5447-8b9f-4ec3-807f-5768daddd3b4@redhat.com>
Date: Wed, 10 Apr 2024 10:47:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/9] mm/ksm: Convert chain series funcs and replace
 get_ksm_page
To: Alex Shi <seakeel@gmail.com>, alexs@kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: Izik Eidus <izik.eidus@ravellosystems.com>,
 Matthew Wilcox <willy@infradead.org>, Andrea Arcangeli
 <aarcange@redhat.com>, Hugh Dickins <hughd@google.com>,
 Chris Wright <chrisw@sous-sol.org>
References: <20240409092826.1733637-1-alexs@kernel.org>
 <20240409092826.1733637-9-alexs@kernel.org>
 <7a8d8005-3cec-4647-82b0-2d55d0ef34fc@redhat.com>
 <c35fcdca-bec9-4a68-99dd-dbc9b3ad97a5@gmail.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <c35fcdca-bec9-4a68-99dd-dbc9b3ad97a5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10.04.24 05:47, Alex Shi wrote:
> 
> 
> On 4/9/24 7:02 PM, David Hildenbrand wrote:
>> On 09.04.24 11:28, alexs@kernel.org wrote:
>>> From: "Alex Shi (tencent)" <alexs@kernel.org>
>>>
>>> In ksm stable tree all page are single, let's convert them to use and
>>> folios as well as stable_tree_insert/stable_tree_search funcs.
>>> And replace get_ksm_page() by ksm_get_folio() since there is no more
>>> needs.
>>>
>>> It could save a few compound_head calls.
>>>
>>> Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
>>> Cc: Izik Eidus <izik.eidus@ravellosystems.com>
>>> Cc: Matthew Wilcox <willy@infradead.org>
>>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>>> Cc: Hugh Dickins <hughd@google.com>
>>> Cc: Chris Wright <chrisw@sous-sol.org>
>>> Reviewed-by: David Hildenbrand <david@redhat.com>
>>
>> I don't recall giving that yet :)
> 
> Ops...
> Sorry for misunderstand!

No worries :)

>>
>> You could have kept some get_ksm_page()->ksm_get_folio() into a separate patch.
>>
>> i.e., "[PATCH v3 11/14] mm/ksm: remove get_ksm_page and related info" from your old series could have mostly stayed separately.
>>
> 
> Yes, but the 12th and 11th patches are kind of depends each other, like after merge 8,9,10,12th with get_ksm_page replaced,
> 
> ../mm/ksm.c:993:21: error: ‘get_ksm_page’ defined but not used [-Werror=unused-function]
>    993 | static struct page *get_ksm_page(struct ksm_stable_node *stable_node,
>        |                     ^~~~~~~~~~~~
> 
> so we have to squash the 11th and 12th if we want to merge 12th with 8,9,10...
> or we can do just merge the 8,9,10 and keep 11th, 12th as your first suggestion?
> 

I see what you mean. Including removal is certainly required there, as you remove
the last user.

It might make sense to move some cleanups+comment adjustments from
"[PATCH v3 11/14] mm/ksm: remove get_ksm_page and related info" into relevant patches.

After Patch #1 in this series, I would do

 From 38a6f6017bf91d9a8869316b711b594909caa5ed Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Wed, 10 Apr 2024 10:32:24 +0200
Subject: [PATCH] mm/ksm: rename get_ksm_page_flags() to ksm_get_folio_flags

As we are removing get_ksm_page_flags(), make the flags match the new
function name.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
  mm/ksm.c | 34 +++++++++++++++++-----------------
  1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index ac080235b002..fd2666e6bda1 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -890,10 +890,10 @@ static void remove_node_from_stable_tree(struct ksm_stable_node *stable_node)
  	free_stable_node(stable_node);
  }
  
-enum get_ksm_page_flags {
-	GET_KSM_PAGE_NOLOCK,
-	GET_KSM_PAGE_LOCK,
-	GET_KSM_PAGE_TRYLOCK
+enum ksm_get_folio_flags {
+	KSM_GET_FOLIO_NOLOCK,
+	KSM_GET_FOLIO_LOCK,
+	KSM_GET_FOLIO_TRYLOCK
  };
  
  /*
@@ -916,7 +916,7 @@ enum get_ksm_page_flags {
   * is on its way to being freed; but it is an anomaly to bear in mind.
   */
  static struct folio *ksm_get_folio(struct ksm_stable_node *stable_node,
-				 enum get_ksm_page_flags flags)
+				 enum ksm_get_folio_flags flags)
  {
  	struct folio *folio;
  	void *expected_mapping;
@@ -959,15 +959,15 @@ static struct folio *ksm_get_folio(struct ksm_stable_node *stable_node,
  		goto stale;
  	}
  
-	if (flags == GET_KSM_PAGE_TRYLOCK) {
+	if (flags == KSM_GET_FOLIO_TRYLOCK) {
  		if (!folio_trylock(folio)) {
  			folio_put(folio);
  			return ERR_PTR(-EBUSY);
  		}
-	} else if (flags == GET_KSM_PAGE_LOCK)
+	} else if (flags == KSM_GET_FOLIO_LOCK)
  		folio_lock(folio);
  
-	if (flags != GET_KSM_PAGE_NOLOCK) {
+	if (flags != KSM_GET_FOLIO_NOLOCK) {
  		if (READ_ONCE(folio->mapping) != expected_mapping) {
  			folio_unlock(folio);
  			folio_put(folio);
@@ -991,7 +991,7 @@ static struct folio *ksm_get_folio(struct ksm_stable_node *stable_node,
  }
  
  static struct page *get_ksm_page(struct ksm_stable_node *stable_node,
-				 enum get_ksm_page_flags flags)
+				 enum ksm_get_folio_flags flags)
  {
  	struct folio *folio = ksm_get_folio(stable_node, flags);
  
@@ -1009,7 +1009,7 @@ static void remove_rmap_item_from_tree(struct ksm_rmap_item *rmap_item)
  		struct page *page;
  
  		stable_node = rmap_item->head;
-		page = get_ksm_page(stable_node, GET_KSM_PAGE_LOCK);
+		page = get_ksm_page(stable_node, KSM_GET_FOLIO_LOCK);
  		if (!page)
  			goto out;
  
@@ -1118,7 +1118,7 @@ static int remove_stable_node(struct ksm_stable_node *stable_node)
  	struct page *page;
  	int err;
  
-	page = get_ksm_page(stable_node, GET_KSM_PAGE_LOCK);
+	page = get_ksm_page(stable_node, KSM_GET_FOLIO_LOCK);
  	if (!page) {
  		/*
  		 * get_ksm_page did remove_node_from_stable_tree itself.
@@ -1657,7 +1657,7 @@ static struct page *stable_node_dup(struct ksm_stable_node **_stable_node_dup,
  		 * stable_node parameter itself will be freed from
  		 * under us if it returns NULL.
  		 */
-		_tree_page = get_ksm_page(dup, GET_KSM_PAGE_NOLOCK);
+		_tree_page = get_ksm_page(dup, KSM_GET_FOLIO_NOLOCK);
  		if (!_tree_page)
  			continue;
  		nr += 1;
@@ -1780,7 +1780,7 @@ static struct page *__stable_node_chain(struct ksm_stable_node **_stable_node_du
  	if (!is_stable_node_chain(stable_node)) {
  		if (is_page_sharing_candidate(stable_node)) {
  			*_stable_node_dup = stable_node;
-			return get_ksm_page(stable_node, GET_KSM_PAGE_NOLOCK);
+			return get_ksm_page(stable_node, KSM_GET_FOLIO_NOLOCK);
  		}
  		/*
  		 * _stable_node_dup set to NULL means the stable_node
@@ -1886,7 +1886,7 @@ static struct page *stable_tree_search(struct page *page)
  			 * fine to continue the walk.
  			 */
  			tree_page = get_ksm_page(stable_node_any,
-						 GET_KSM_PAGE_NOLOCK);
+						 KSM_GET_FOLIO_NOLOCK);
  		}
  		VM_BUG_ON(!stable_node_dup ^ !!stable_node_any);
  		if (!tree_page) {
@@ -1947,7 +1947,7 @@ static struct page *stable_tree_search(struct page *page)
  			 * than kpage, but that involves more changes.
  			 */
  			tree_page = get_ksm_page(stable_node_dup,
-						 GET_KSM_PAGE_TRYLOCK);
+						 KSM_GET_FOLIO_TRYLOCK);
  
  			if (PTR_ERR(tree_page) == -EBUSY)
  				return ERR_PTR(-EBUSY);
@@ -2119,7 +2119,7 @@ static struct ksm_stable_node *stable_tree_insert(struct page *kpage)
  			 * fine to continue the walk.
  			 */
  			tree_page = get_ksm_page(stable_node_any,
-						 GET_KSM_PAGE_NOLOCK);
+						 KSM_GET_FOLIO_NOLOCK);
  		}
  		VM_BUG_ON(!stable_node_dup ^ !!stable_node_any);
  		if (!tree_page) {
@@ -2610,7 +2610,7 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
  			list_for_each_entry_safe(stable_node, next,
  						 &migrate_nodes, list) {
  				page = get_ksm_page(stable_node,
-						    GET_KSM_PAGE_NOLOCK);
+						    KSM_GET_FOLIO_NOLOCK);
  				if (page)
  					put_page(page);
  				cond_resched();
-- 
2.44.0


Then, adjust the get_ksm_page() comments as you change the code:

In "[PATCH v4 4/9] mm/ksm: use folio in remove_stable_node", adjust the two comments
in remove_stable_node() to state "ksm_get_folio".

In "[PATCH v4 5/9] mm/ksm: use folio in stable_node_dup", adjust the comment in
stable_node_dup().

In "[PATCH v4 8/9] mm/ksm: Convert chain series funcs and replace get_ksm_page",
adjust the comments for __stable_node_chain(), stable_tree_insert() and stable_tree_search().


Then, the remaining comments are in folio_migrate_ksm(), stable_node_dup_remove_range(),
ksm_memory_callback() and folio_migrate_flags(), and I'd just fix them up in a separate
patch after this patch here called something like "mm/ksm: update remaining comments now
that get_ksm_page() is gone".


But that's just one way of removing some "noise" from this squashed patch :)

>> [...]
>>
>>>    /*
>>> @@ -1829,7 +1821,7 @@ static __always_inline struct page *chain(struct ksm_stable_node **s_n_d,
>>>     * This function returns the stable tree node of identical content if found,
>>>     * NULL otherwise.
>>>     */
>>> -static struct page *stable_tree_search(struct page *page)
>>> +static void *stable_tree_search(struct page *page)
>>
>> There is one caller of stable_tree_search() in cmp_and_merge_page().
>>
>> Why the change from page* to void* ?
> 
> Uh, a bit more changes needs if we want to remove void*.

You could keep it page* and return &folio->page, right? Then you could convert stable_tree_search() in a separate patch to return a folio* instead.

Sorry if I am missing something.

> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 0d703c3da9d8..cd414a9c33ad 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -1815,7 +1815,7 @@ static __always_inline struct folio *chain(struct ksm_stable_node **s_n_d,
>    * This function returns the stable tree node of identical content if found,
>    * NULL otherwise.
>    */
> -static void *stable_tree_search(struct page *page)
> +static struct folio *stable_tree_search(struct page *page)
>   {
>          int nid;
>          struct rb_root *root;
> @@ -2308,6 +2308,7 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
>          struct page *tree_page = NULL;
>          struct ksm_stable_node *stable_node;
>          struct page *kpage;
> +       struct folio *folio;
>          unsigned int checksum;
>          int err;
>          bool max_page_sharing_bypass = false;
> @@ -2333,7 +2334,8 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
>          }
>   
>          /* We first start with searching the page inside the stable tree */
> -       kpage = stable_tree_search(page);
> +       folio = stable_tree_search(page);
> +       kpage = &folio->page;
>          if (kpage == page && rmap_item->head == stable_node) {
>                  put_page(kpage);
>                  return;
> 
>> I suspect cmp_and_merge_page() could similarly be converted to some degree to let kpage be a folio (separate patch).
>>
> 
> Yes, there are couple of changes needed for cmp_and_merge_page() and series try_to_merge_xx_pages(), I am going to change them on the next series patches. Guess 2 phases patches are better for a big/huge one, is this right?

Smaller patches are preferable. But if we have to add temporary workarounds (like using void*), it might be better to have the relevant
cleanups part of a single patch.

-- 
Cheers,

David / dhildenb


