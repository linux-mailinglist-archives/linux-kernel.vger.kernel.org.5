Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985777AB4E9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 17:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbjIVPjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 11:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbjIVPjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 11:39:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0D5100
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 08:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695397134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=28YK1yWDhsvGzgSgmFKM5KSBJsEoW2Mh43BzpB68BbM=;
        b=KYlKnHglb4K49rpZHY/hXP4ngs88wR/YfxawCWzb4zSFdMXYRyJIMYgQI5i7ZPYcEjR2d/
        2Wbk7AUaACoE73IqmMLDHErXL2PFSY2BrwR7fLSjbPTwhi2OCYKTJ3C91KGjH81MdAcQbl
        c/b34vpyK10vi2vMi1QsQsabFkm+i94=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-7qVewsToOeW98xJLNR2Gfg-1; Fri, 22 Sep 2023 11:38:52 -0400
X-MC-Unique: 7qVewsToOeW98xJLNR2Gfg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-320004980a2so1456980f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 08:38:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695397131; x=1696001931;
        h=content-transfer-encoding:subject:organization:in-reply-to
         :content-language:references:cc:to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=28YK1yWDhsvGzgSgmFKM5KSBJsEoW2Mh43BzpB68BbM=;
        b=U848k+2XcR7dr8G56vsQrDl2AOMNi0XEbSj1cWf5KQEbCuSYLv2m+WMvqKa3PtmD2l
         8KC/+66kwXYJYxChmPrqTJU1Vb8Em5qWNY4pO7D+dWnCn/oVOQmrA1IlmHdAy73ldi0b
         AbT6afylevKefcAV/83NWBSxQVRPeKfTPuojJ4yOSBs0JAguKnq2Sa85JP2iiEBjfCAy
         Jz3xQZS01oLEEcPNdAgTututjShkrL+2hYaSE6cqnbM9a4zxmyH36qahyDoGlnGDzRgx
         RyYJPm2h5KdHcPcbwDxyR//H0bZT/nsT9JZnmx7bO4errrXFwBAqrGRtaDSTIpnCTDxu
         qOVQ==
X-Gm-Message-State: AOJu0YwR/JBXyd0Svi/jPUP33J77RAIxaTnntzIi07ve0Uw0ugEmV6wu
        pUYj72AFsQIOktCmxHZfiyxsd9ShgbyX5P5TZH+1xdol+DG/PBuSUFP+9xuHMPkGx4jrrEvlcpv
        6s3repjzXc39wO3FAeDVW/JBsYFjAIALc
X-Received: by 2002:a05:6000:1cc4:b0:321:68fa:70aa with SMTP id bf4-20020a0560001cc400b0032168fa70aamr50815wrb.9.1695397131635;
        Fri, 22 Sep 2023 08:38:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtnIOkmAt3qyian4WMHlSMv2Pq0c2znHPkEQSbVqQXXatSTUNIsXYfYNHYUP5Ouq7MoKz3dA==
X-Received: by 2002:a05:6000:1cc4:b0:321:68fa:70aa with SMTP id bf4-20020a0560001cc400b0032168fa70aamr50781wrb.9.1695397131168;
        Fri, 22 Sep 2023 08:38:51 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71a:7100:dfaf:df8b:54b9:7303? (p200300cbc71a7100dfafdf8b54b97303.dip0.t-ipconnect.de. [2003:cb:c71a:7100:dfaf:df8b:54b9:7303])
        by smtp.gmail.com with ESMTPSA id j3-20020a5d5643000000b0032167e49619sm4733853wrw.5.2023.09.22.08.38.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 08:38:50 -0700 (PDT)
Message-ID: <b8d98257-ae01-4163-a4a7-ecd3dbee7325@redhat.com>
Date:   Fri, 22 Sep 2023 17:38:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   David Hildenbrand <david@redhat.com>
To:     Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, riel@surriel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20230918185816.1518366-1-shr@devkernel.io>
 <20230918185816.1518366-2-shr@devkernel.io>
Content-Language: en-US
In-Reply-To: <20230918185816.1518366-2-shr@devkernel.io>
Organization: Red Hat
Subject: Re: [PATCH v2 1/4] mm/ksm: add "smart" page scanning mode
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


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

I *think* of you move that after "oldchecksum", the size of the struct 
might not necessarily increase.

[...]

>   
> +/*
> + * Calculate skip age for the ksm page age. The age determines how often
> + * de-duplicating has already been tried unsuccessfully. If the age is
> + * smaller, the scanning of this page is skipped for less scans.
> + *
> + * @age: rmap_item age of page
> + */
> +static unsigned int skip_age(rmap_age_t age)
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
> +/*
> + * Determines if a page should be skipped for the current scan.
> + *
> + * @page: page to check
> + * @rmap_item: associated rmap_item of page
> + */
> +static bool should_skip_rmap_item(struct page *page,
> +				  struct ksm_rmap_item *rmap_item)
> +{
> +	rmap_age_t age;
> +
> +	if (!ksm_smart_scan)
> +		return false;
> +
> +	/*
> +	 * Never skip pages that are already KSM; pages cmp_and_merge_page()
> +	 * will essentially ignore them, but we still have to process them
> +	 * properly.
> +	 */
> +	if (PageKsm(page))
> +		return false;
> +
> +	/*
> +	 * Smaller ages are not skipped, they need to get a chance to go
> +	 * through the different phases of the KSM merging.
> +	 */

Sorry, had to set some time aside to think this through. Wouldn't it be 
cleaner to just not rely on this overflow?

Instead, we could track the page age (which we would freeze at U8_MAX) 
and simply track how much more often we are allowed to skip.

Something like the following (which, I am sure, is completely broken, 
but should express what I have in mind)



age = rmap_item->age;
if (age != U8_MAX)
	rmap_item->age++;

/*
  * Smaller ages are not skipped, they need to get a chance to go
  * through the different phases of the KSM merging.
  */
if (age < 3)
	return false;

/*
  * Are we still allowed to skip? If not, then don't skip it
  * and determine how much more often we are allowed to skip next.
  */
if (!rmap_item->remaining_skips) {
	rmap_item->remaining_skips = skip_age(age);
	return false;
}

/* Skip this page. */
rmap_item->remaining_skips--;
remove_rmap_item_from_tree(rmap_item);
return true;



Would that miss anything important? Was the overflow handling (and 
scanning more often one we overflow again IIUC) important?

-- 
Cheers,

David / dhildenb


