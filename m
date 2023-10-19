Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4316D7CFA54
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbjJSNFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345722AbjJSNFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:05:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A88F10C2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 06:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697720627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=cOdqO2XoxuRzuqyPGyewOktUv4c1wTFsSVsSHrfwggg=;
        b=HoXIf01FXCt/6ubLCKFujG6/BNfGMjAzS65Y1tETxgCFIFEEYTH0PI01oTioJWuq4sry9E
        5I+V3Y9mMVhwwLqLLMRBFqSIYQ8j2b4Kj8eOP4t9RLXSw9+rZGY/ufk1/zW44SYpmfnyam
        UIXaQsqt9agp08bYTukkENQ0XK2QJm0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-RWomHni9MGWZokuOKUeAxg-1; Thu, 19 Oct 2023 09:03:36 -0400
X-MC-Unique: RWomHni9MGWZokuOKUeAxg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4084001846eso10079685e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 06:03:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697720614; x=1698325414;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cOdqO2XoxuRzuqyPGyewOktUv4c1wTFsSVsSHrfwggg=;
        b=VLiyXRyDIhLu5BFzrMFGT4EdOTI6TaKVRXaS/8U2Nm4vBBQJCkPKLOUE63TZn195xH
         A1gXLke7Lt95t0o3KMBtwvH1hm3DgVOc2/Je2pArIYpJz8lGRigULR7EPw0nTqpi/lHx
         1DAQJYzwxn/gOnOT1lLSCo+vvK76cfd8mwWABfrytWrqpMzE4u8brtvRAi8QbusAsly2
         ASKBaVQjZW9v2lz7SW8tLi2pbAPAR2uITkqVgWbPOO8hGNi/6kGa1KPrCI9JpABJeIZq
         C+X6UP5GKdD2Qgwe0PTysfvgq6oOV0sDzQz/ZUf5xPOjPUxAhnYuvuXpDXs8/JG2edT/
         LpVw==
X-Gm-Message-State: AOJu0YwAU2Zgilvg8bYrSf7HmG8+9r2ZSV3Kt8+dVoSA/CBsSy/AfO6m
        IbFkDJqi+KMoVGuxgx7nfGTvU9X5E9bgvB7BUF7DOTe6+14Xc2gA7Rp5pF/l62zaTDe732MGISq
        RfrNmJdragNAKFRJYP6lS0BZO
X-Received: by 2002:a05:600c:1c93:b0:405:458d:d54 with SMTP id k19-20020a05600c1c9300b00405458d0d54mr1783649wms.33.1697720614476;
        Thu, 19 Oct 2023 06:03:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEniR6jtcNlcaZfheicelDCXWNJbEihe050M5J3eISf3Ms5mN5cNL5iDKMtru5WeI22XJDipg==
X-Received: by 2002:a05:600c:1c93:b0:405:458d:d54 with SMTP id k19-20020a05600c1c9300b00405458d0d54mr1783626wms.33.1697720613985;
        Thu, 19 Oct 2023 06:03:33 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:500:6a06:17fc:810b:b054? (p200300cbc70b05006a0617fc810bb054.dip0.t-ipconnect.de. [2003:cb:c70b:500:6a06:17fc:810b:b054])
        by smtp.gmail.com with ESMTPSA id j20-20020a05600c1c1400b004065daba6casm4464578wms.46.2023.10.19.06.03.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 06:03:33 -0700 (PDT)
Message-ID: <904094ce-e340-4bb7-b50d-6aedd816e569@redhat.com>
Date:   Thu, 19 Oct 2023 15:03:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: vmscan: the dirty folio unmap redundantly
Content-Language: en-US
To:     Zhiguo Jiang <justinjiang@vivo.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
References: <20231018013004.1569-1-justinjiang@vivo.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231018013004.1569-1-justinjiang@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.10.23 03:30, Zhiguo Jiang wrote:
> If the dirty folio is not reclaimed in the shrink process, it do
> not need to unmap, which can save shrinking time during traversaling
> the dirty folio.

Hi,

I really cannot understand what you mean with "the dirty folio unmap 
redundantly". No clue what this patch is supposed to tackle by staring 
at the patch subject.


This patch is supposed to improve performance. Can you provide some 
proof that it does and that we should even care about this change?

> 
> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
> ---
>   mm/vmscan.c | 72 +++++++++++++++++++++++++++--------------------------
>   1 file changed, 37 insertions(+), 35 deletions(-)
>   mode change 100644 => 100755 mm/vmscan.c
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 2cc0cb41fb32..cf555cdfcefc
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1261,6 +1261,43 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>   			enum ttu_flags flags = TTU_BATCH_FLUSH;
>   			bool was_swapbacked = folio_test_swapbacked(folio);
>   
> +			if (folio_test_dirty(folio)) {
> +				/*
> +				 * Only kswapd can writeback filesystem folios
> +				 * to avoid risk of stack overflow. But avoid
> +				 * injecting inefficient single-folio I/O into
> +				 * flusher writeback as much as possible: only
> +				 * write folios when we've encountered many
> +				 * dirty folios, and when we've already scanned
> +				 * the rest of the LRU for clean folios and see
> +				 * the same dirty folios again (with the reclaim
> +				 * flag set).
> +				 */
> +				if (folio_is_file_lru(folio) &&
> +					(!current_is_kswapd() ||
> +					 !folio_test_reclaim(folio) ||
> +					 !test_bit(PGDAT_DIRTY, &pgdat->flags))) {
> +					/*
> +					 * Immediately reclaim when written back.
> +					 * Similar in principle to folio_deactivate()
> +					 * except we already have the folio isolated
> +					 * and know it's dirty
> +					 */
> +					node_stat_mod_folio(folio, NR_VMSCAN_IMMEDIATE,
> +							nr_pages);
> +					folio_set_reclaim(folio);
> +
> +					goto activate_locked;
> +				}
> +
> +				if (references == FOLIOREF_RECLAIM_CLEAN)
> +					goto keep_locked;
> +				if (!may_enter_fs(folio, sc->gfp_mask))
> +					goto keep_locked;
> +				if (!sc->may_writepage)
> +					goto keep_locked;
> +			}
> +
>   			if (folio_test_pmd_mappable(folio))
>   				flags |= TTU_SPLIT_HUGE_PMD;
>   
> @@ -1286,41 +1323,6 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>   
>   		mapping = folio_mapping(folio);
>   		if (folio_test_dirty(folio)) {

Can you elaborate why we want to remove below code? It would have made 
sense to me to duplicate the code in an early check before unmap, if the 
folio is already dirty before checking all PTEs. But why can we remove 
that post-unmap code?

-- 
Cheers,

David / dhildenb

