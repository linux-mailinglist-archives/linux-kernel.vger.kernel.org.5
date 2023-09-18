Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756737A481B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 13:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241359AbjIRLMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 07:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241468AbjIRLME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 07:12:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FED185
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 04:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695035440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6/cr+xhXNv4f07NXf+l3nV8fbTg3rSUgiXuUzeU2fnA=;
        b=aXxwivUSI3iVsXM3Bsq5o0ndpnk0mZo7oRt3yULrCDv4CIGKYRlqzdhFDZhf2E9pP6+0J2
        sqvi6MFfMM7iY74i3MPogsDcK6cgB1IKp6KTexxhWOIgwmLGiFzwk8RKJqmPWy+vLiFjxy
        1+gqPtXb4ZRiGlc68oc6xSfmBFpajkA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-nR8oECNEN5K14rXmqw3VlQ-1; Mon, 18 Sep 2023 07:10:38 -0400
X-MC-Unique: nR8oECNEN5K14rXmqw3VlQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-31aef4011cfso2917881f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 04:10:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695035437; x=1695640237;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6/cr+xhXNv4f07NXf+l3nV8fbTg3rSUgiXuUzeU2fnA=;
        b=pMIZ5atdW9v2X9bQ4oSP1HjRIBZaMa2hF8VJ702hhoacbdZn2HzpcQe06rycIQcddM
         4um+CdWvZKOH9mLA82xNbf+y9S+O5k320W+zsh7LQaX1SmjxY/XBR2buBmShzvYTMci0
         qwwpu1mmGdg7hNPsR6wuiW3j/egMt277/WqE0yW7wvz9gp1onraq3wPJXDeO0npfkn64
         V1mvIF6yoNHFrMqKnqJ+z3zJLri2wmxlVZkdd18GdteqKrtzj4gPy0gmN22pIcv0YtnS
         8nwkOhFPbLysqvF0fwVz9e/SI88IGRuqQf7WUEP32oahrrmpancX1AOyRbHB5AHuwGX9
         pCOg==
X-Gm-Message-State: AOJu0YwsM4Uy6rrPj7Rk4oflIpYfKtn+PuacMVWIfinF4QZwENck0Y7i
        MyUph0grneouIomvNTJP68ugGOUDQpZ6kJiOPyvw7k2ve9tx6ajClCtmfUqGI6ASxTkxg/vG2fO
        smMfDmajwnX/VC94XpM51r/aU
X-Received: by 2002:a5d:63d1:0:b0:31f:a9db:b838 with SMTP id c17-20020a5d63d1000000b0031fa9dbb838mr6448466wrw.15.1695035437625;
        Mon, 18 Sep 2023 04:10:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRs2UBwdGuEnqmlGA4zPmaZO5EZBJQ66/3cNBF2T8XpnS4PAlvdIhR+RuXod4GcbCamLR0jw==
X-Received: by 2002:a5d:63d1:0:b0:31f:a9db:b838 with SMTP id c17-20020a5d63d1000000b0031fa9dbb838mr6448451wrw.15.1695035437189;
        Mon, 18 Sep 2023 04:10:37 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:3400:ec51:7a3a:274e:cbee? (p200300cbc74b3400ec517a3a274ecbee.dip0.t-ipconnect.de. [2003:cb:c74b:3400:ec51:7a3a:274e:cbee])
        by smtp.gmail.com with ESMTPSA id g3-20020a5d64e3000000b003215c6e30cbsm1420122wri.104.2023.09.18.04.10.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 04:10:36 -0700 (PDT)
Message-ID: <6447ab02-1a22-efe4-68c9-4f595e2499fc@redhat.com>
Date:   Mon, 18 Sep 2023 13:10:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, riel@surriel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20230912175228.952039-1-shr@devkernel.io>
 <20230912175228.952039-2-shr@devkernel.io>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 1/4] mm/ksm: add "smart" page scanning mode
In-Reply-To: <20230912175228.952039-2-shr@devkernel.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.09.23 19:52, Stefan Roesch wrote:
> This change adds a "smart" page scanning mode for KSM. So far all the
> candidate pages are continuously scanned to find candidates for
> de-duplication. There are a considerably number of pages that cannot be
> de-duplicated. This is costly in terms of CPU. By using smart scanning
> considerable CPU savings can be achieved.
> 
> This change takes the history of scanning pages into account and skips
> the page scanning of certain pages for a while if de-deduplication for
> this page has not been successful in the past.
> 
> To do this it introduces two new fields in the ksm_rmap_item structure:
> age and skip_age. age, is the KSM age and skip_page is the age for how
> long page scanning of this page is skipped. The age field is incremented
> each time the page is scanned and the page cannot be de-duplicated.
> 
> How often a page is skipped is dependent how often de-duplication has
> been tried so far and the number of skips is currently limited to 8.
> This value has shown to be effective with different workloads.
> 
> The feature is currently disable by default and can be enabled with the
> new smart_scan knob.
> 
> The feature has shown to be very effective: upt to 25% of the page scans
> can be eliminated; the pages_to_scan rate can be reduced by 40 - 50% and
> a similar de-duplication rate can be maintained.
> 
> Signed-off-by: Stefan Roesch <shr@devkernel.io>
> ---
>   mm/ksm.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 75 insertions(+)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 981af9c72e7a..bfd5087c7d5a 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -56,6 +56,8 @@
>   #define DO_NUMA(x)	do { } while (0)
>   #endif
>   
> +typedef u8 rmap_age_t;
> +
>   /**
>    * DOC: Overview
>    *
> @@ -193,6 +195,8 @@ struct ksm_stable_node {
>    * @node: rb node of this rmap_item in the unstable tree
>    * @head: pointer to stable_node heading this list in the stable tree
>    * @hlist: link into hlist of rmap_items hanging off that stable_node
> + * @age: number of scan iterations since creation
> + * @skip_age: skip rmap item until age reaches skip_age
>    */
>   struct ksm_rmap_item {
>   	struct ksm_rmap_item *rmap_list;
> @@ -212,6 +216,8 @@ struct ksm_rmap_item {
>   			struct hlist_node hlist;
>   		};
>   	};
> +	rmap_age_t age;
> +	rmap_age_t skip_age;
>   };
>   
>   #define SEQNR_MASK	0x0ff	/* low bits of unstable tree seqnr */
> @@ -281,6 +287,9 @@ static unsigned int zero_checksum __read_mostly;
>   /* Whether to merge empty (zeroed) pages with actual zero pages */
>   static bool ksm_use_zero_pages __read_mostly;
>   
> +/* Skip pages that couldn't be de-duplicated previously  */
> +static bool ksm_smart_scan;
> +
>   /* The number of zero pages which is placed by KSM */
>   unsigned long ksm_zero_pages;
>   
> @@ -2305,6 +2314,45 @@ static struct ksm_rmap_item *get_next_rmap_item(struct ksm_mm_slot *mm_slot,
>   	return rmap_item;
>   }
>   
> +static unsigned int inc_skip_age(rmap_age_t age)
> +{
> +	if (age <= 3)
> +		return 1;
> +	if (age <= 5)
> +		return 2;
> +	if (age <= 8)
> +		return 4;
> +
> +	return 8;
> +}
> +
> +static bool skip_rmap_item(struct page *page, struct ksm_rmap_item *rmap_item)
> +{
> +	rmap_age_t age;
> +
> +	if (!ksm_smart_scan)
> +		return false;
> +
> +	if (PageKsm(page))
> +		return false;


I'm a bit confused about this check here. scan_get_next_rmap_item() 
would return a PageKsm() page and call cmp_and_merge_page().

cmp_and_merge_page() says: "first see if page can be merged into the 
stable tree"

... but shouldn't a PageKsm page *already* be in the stable tree?

Maybe that's what cmp_and_merge_page() does via:

	kpage = stable_tree_search(page);
	if (kpage == page && rmap_item->head == stable_node) {
		put_page(kpage);
		return;
	}


Hoping you can enlighten me :)

> +
> +	age = rmap_item->age++;

Can't we overflow here? Is that desired, or would you want to stop at 
the maximum you can store?

> +	if (age < 3)
> +		return false;
> +
> +	if (rmap_item->skip_age == age) {
> +		rmap_item->skip_age = 0;
> +		return false;
> +	}
> +
> +	if (rmap_item->skip_age == 0) {
> +		rmap_item->skip_age = age + inc_skip_age(age);

Can't you overflow here as well?

> +		remove_rmap_item_from_tree(rmap_item);


Can you enlighten me why that is required?

> +	}
> +
> +	return true;
> +}
> +


-- 
Cheers,

David / dhildenb

