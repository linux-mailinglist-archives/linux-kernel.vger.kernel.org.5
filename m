Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941F0756834
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjGQPmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjGQPmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:42:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63758A1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689608525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3g9pjADKRhJ57FMX5gXYkm+ipevq0sMugfTwhHl2pPc=;
        b=g8ZkUHcELTMiV78+qK8BIe2BC4DXhqORpPmDNXzgpJrNslGPozUWHHoMbiCPRbrnknUDaQ
        7xLudT1uS7H22DfvmjubZVoqpKK7ShbUmfrd2dNNcxC4tPFMSY9LRhVDfyqrjq7Q7SBQEY
        wvLI2gY04fmJ+v19FjNyj2ZTpT07bzA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-GKjdDxCaO_ytc4A1sBb9uw-1; Mon, 17 Jul 2023 11:42:04 -0400
X-MC-Unique: GKjdDxCaO_ytc4A1sBb9uw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fc07d4c63eso23634785e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689608523; x=1692200523;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3g9pjADKRhJ57FMX5gXYkm+ipevq0sMugfTwhHl2pPc=;
        b=dz1W3tlVjMAfnyQYzVZNyBrCmEdG8FCgnCi9FVT71A/9r4L37igfzWI7wAEJoCg5b8
         b0W2yYCsML9x3J9qkPi/sPMxjR6KKd+ij3D5PFnmE/iGBnSyDleTIBNaxL+TeAQHD1HF
         xCEvl4WUCujNd2WAL389F5YWNn2ZyODQZ1/XQWl7sNjJsmQFjPLXJbfM91midiJwG0W5
         t+yp6tu9H/jbDsoGgYjy8QI7oKb06cAwL12qyh93EMDVHal+FwjaicWEILO2irl2xSWs
         NS8z7aq4VaHyXJB9JoLFWY/OXGDe3/DPhdfi70eGPUDro34FnEa58nMeTFst14QWfFEW
         9dww==
X-Gm-Message-State: ABy/qLYdVVTMde0rhzJX99TrKHnoIs4NXt/xifVEO9RfotPWBMvv7fpt
        2I/+c3yCW0JEkH0FBQfH62dBpsv5JXZQhjRlCiwoZlEz6t9R3OFZTv63jyNQMPTk/cEdoJPVtKf
        EfliDNnQTOdbw7ycx/T3JsKlt
X-Received: by 2002:a05:600c:4509:b0:3fa:8c8b:716 with SMTP id t9-20020a05600c450900b003fa8c8b0716mr8463998wmo.1.1689608523138;
        Mon, 17 Jul 2023 08:42:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGgHpT8XonCi8k2gklP0NjV6dnu3l1DHiQ30N08iWXx3N+/R/nb3+dH8ujqqzommwbME591Jg==
X-Received: by 2002:a05:600c:4509:b0:3fa:8c8b:716 with SMTP id t9-20020a05600c450900b003fa8c8b0716mr8463989wmo.1.1689608522771;
        Mon, 17 Jul 2023 08:42:02 -0700 (PDT)
Received: from ?IPV6:2003:cb:c735:400:2501:5a2e:13c6:88da? (p200300cbc735040025015a2e13c688da.dip0.t-ipconnect.de. [2003:cb:c735:400:2501:5a2e:13c6:88da])
        by smtp.gmail.com with ESMTPSA id m13-20020a7bce0d000000b003fbaa2903f4sm79979wmc.19.2023.07.17.08.42.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 08:42:02 -0700 (PDT)
Message-ID: <90b406af-9db4-b668-a7a0-e574e104c84c@redhat.com>
Date:   Mon, 17 Jul 2023 17:42:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 1/3] mm: Allow deferred splitting of arbitrary large
 anon folios
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20230717143110.260162-1-ryan.roberts@arm.com>
 <20230717143110.260162-2-ryan.roberts@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230717143110.260162-2-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.07.23 16:31, Ryan Roberts wrote:
> In preparation for the introduction of large folios for anonymous
> memory, we would like to be able to split them when they have unmapped
> subpages, in order to free those unused pages under memory pressure. So
> remove the artificial requirement that the large folio needed to be at
> least PMD-sized.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> Reviewed-by: Yu Zhao <yuzhao@google.com>
> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
> ---
>   mm/rmap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 0c0d8857dfce..2baf57d65c23 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1430,7 +1430,7 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
>   		 * page of the folio is unmapped and at least one page
>   		 * is still mapped.
>   		 */
> -		if (folio_test_pmd_mappable(folio) && folio_test_anon(folio))
> +		if (folio_test_large(folio) && folio_test_anon(folio))
>   			if (!compound || nr < nr_pmdmapped)
>   				deferred_split_folio(folio);

!compound will always be true I guess, so nr_pmdmapped == 0 (which will 
always be the case) will be ignored.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

