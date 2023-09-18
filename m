Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782987A486F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 13:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241568AbjIRLar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 07:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241762AbjIRLak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 07:30:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AF6194
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 04:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695036490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2+1DSm32hMfdhO5ZA8UHhTzFRwLr/647M51OqI3DUYU=;
        b=ZrnGXrkU8uOtMoMfrOOOEIlARo9uY9oXBlc5suRYFAEATwFbYW1ZIf9GAB+xWw1jveu9Fs
        KHTvQZ7y6OIW6yJ9a1QSZL1Wkx885uurX5o+T7eoHFI/LgLjEjPtG1BncJ3+R7ndkE9rjM
        M2V6xji5u0r4YMCq3t1LYME+7DHJ88M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-zSBg0_xpPd2lPv3O4RFr0Q-1; Mon, 18 Sep 2023 07:28:09 -0400
X-MC-Unique: zSBg0_xpPd2lPv3O4RFr0Q-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-401b8089339so33742325e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 04:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695036488; x=1695641288;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2+1DSm32hMfdhO5ZA8UHhTzFRwLr/647M51OqI3DUYU=;
        b=kDCUs6ZghYEPGWrUpG1GuHZyhm12yCdT1PtHjFiV2eANp+ivM/ZzJbXUJ7i1+Zw3rb
         N4Um37Fldz/ZzGLmE4p6foBZ5DqC4JhY6ekuWu14uwAySZsPn8Qr31lbOZFGZnDdg5N7
         8UwxbMLVb0/f7cPNGdP7ZBtf8DnSrurtBTX02zwuCwTN2FJOFNiKMtmTYbYGtDooQXMm
         5Mz1L2LZyzje2odccYuOV9v/X7ujffIc12XkfIPPDRg5LLjmaSGIKduazotQR3pywq8b
         NCSEIYBN/cZ+c5g1We2qI1i+gcDBTUk0CVH5BxtOd13QclFDetyL4DKy45DL3AC1jTSz
         rHVg==
X-Gm-Message-State: AOJu0YyvFzSRBwcXFIb8oKIr5Bj4SnR2dxPsfkMugxmNvRpJI/jidOQ1
        MK+IK0E/q7BVjUbDsrE3F9dJD8wf9JKkqY81tdxfwzIXvidzrPnIaT3vX6wQf9G3ZGFUG7B0gqc
        /jx65OPPoIuDyJ2ap4KHFR5bT
X-Received: by 2002:a05:600c:3781:b0:401:b2c7:349b with SMTP id o1-20020a05600c378100b00401b2c7349bmr6867514wmr.7.1695036488299;
        Mon, 18 Sep 2023 04:28:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGci4qXIDogvyJYt6l9ZtdNOehLAhFlhO9v1v76ai0+FNRoJ7vZlEt4ipeRiOC9RV3VQ3EAA==
X-Received: by 2002:a05:600c:3781:b0:401:b2c7:349b with SMTP id o1-20020a05600c378100b00401b2c7349bmr6867504wmr.7.1695036487866;
        Mon, 18 Sep 2023 04:28:07 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:3400:ec51:7a3a:274e:cbee? (p200300cbc74b3400ec517a3a274ecbee.dip0.t-ipconnect.de. [2003:cb:c74b:3400:ec51:7a3a:274e:cbee])
        by smtp.gmail.com with ESMTPSA id z9-20020adff1c9000000b0031f07d1edbcsm12516298wro.77.2023.09.18.04.28.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 04:28:07 -0700 (PDT)
Message-ID: <67c0bbac-aa4a-28ce-5416-e41af794e899@redhat.com>
Date:   Mon, 18 Sep 2023 13:28:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 2/4] mm/ksm: add pages_skipped metric
Content-Language: en-US
To:     Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, riel@surriel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20230912175228.952039-1-shr@devkernel.io>
 <20230912175228.952039-3-shr@devkernel.io>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230912175228.952039-3-shr@devkernel.io>
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

On 12.09.23 19:52, Stefan Roesch wrote:
> This change adds the "pages skipped" metric. To be able to evaluate how
> successful smart page scanning is, the pages skipped metric can be
> compared to the pages scanned metric.
> 
> The pages skipped metric is a cumulative counter. The counter is stored
> under /sys/kernel/mm/ksm/pages_skipped.
> 
> Signed-off-by: Stefan Roesch <shr@devkernel.io>
> ---
>   mm/ksm.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index bfd5087c7d5a..728574a3033e 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -293,6 +293,9 @@ static bool ksm_smart_scan;
>   /* The number of zero pages which is placed by KSM */
>   unsigned long ksm_zero_pages;
>   
> +/* The number of pages that have been skipped due to "smart scanning" */
> +static unsigned long ksm_pages_skipped;
> +
>   #ifdef CONFIG_NUMA
>   /* Zeroed when merging across nodes is not allowed */
>   static unsigned int ksm_merge_across_nodes = 1;
> @@ -2345,6 +2348,7 @@ static bool skip_rmap_item(struct page *page, struct ksm_rmap_item *rmap_item)
>   		return false;
>   	}
>   
> +	ksm_pages_skipped++;
>   	if (rmap_item->skip_age == 0) {
>   		rmap_item->skip_age = age + inc_skip_age(age);
>   		remove_rmap_item_from_tree(rmap_item);
> @@ -3435,6 +3439,13 @@ static ssize_t pages_volatile_show(struct kobject *kobj,
>   }
>   KSM_ATTR_RO(pages_volatile);
>   
> +static ssize_t pages_skipped_show(struct kobject *kobj,
> +				  struct kobj_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%lu\n", ksm_pages_skipped);
> +}
> +KSM_ATTR_RO(pages_skipped);
> +
>   static ssize_t ksm_zero_pages_show(struct kobject *kobj,
>   				struct kobj_attribute *attr, char *buf)
>   {
> @@ -3532,6 +3543,7 @@ static struct attribute *ksm_attrs[] = {
>   	&pages_sharing_attr.attr,
>   	&pages_unshared_attr.attr,
>   	&pages_volatile_attr.attr,
> +	&pages_skipped_attr.attr,
>   	&ksm_zero_pages_attr.attr,
>   	&full_scans_attr.attr,
>   #ifdef CONFIG_NUMA

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

