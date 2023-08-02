Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FEB76C850
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 10:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbjHBIZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 04:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbjHBIZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 04:25:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0E31BF0
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 01:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690964670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DtQormFq6iIvoR/QhqHDlvFGsNl3UyYF/d+disvIy1k=;
        b=TTAHeXKruCTewgJbPI4W9XQGSlLqkxkFCURXB5zUP4ZtCVqvOLP1h3JRh6um+L3GgwCHcK
        votK2wcOapJxH7IBjl6F3vWKe/j6yfKXAff9S3qs3ZaqiKRwFJPbWlu/8DJpM17XKKYimP
        +16BAqkmBgDgYb9yo9giM+352/7fKDU=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-05rhWOviO_yEiQovb11B-Q-1; Wed, 02 Aug 2023 04:24:29 -0400
X-MC-Unique: 05rhWOviO_yEiQovb11B-Q-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b9bcf13746so57373551fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 01:24:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690964668; x=1691569468;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DtQormFq6iIvoR/QhqHDlvFGsNl3UyYF/d+disvIy1k=;
        b=TjDPohI6cDX2ZlHDBjjeG9leLm1Q89B1XKxD5Rp3t2jyfNSwclMTkjIsyNQPBEBvJy
         kCn6R/VRtCu61VNbL6SE/ygzP1mGkw3lTgR/tAHqndotX+mCWfWDRi6S3RFEqtz5ekCP
         zKI1DYidO/ZXa9jO6pZkZvfZHjP+Gu4++/MMdWbRZZY2W/cJGVqsutTd5YLTb/WuNFWl
         EiVp9sCMfxo2EiCOwxJYzKkGnoJRwScND8kHjAbi4Afc6IzMX5Y/PqjZI+qIwetkc8r3
         DZ709JboA83qJPv6QgxmY7qMmRYMIwSRoRBoKNaU5isPB7X3XL8tHPJr8ir36vddN2J0
         BVSw==
X-Gm-Message-State: ABy/qLb2ohLkXGFbiTtiHaZWw5ktqTrqv0GQO9Zg81GSHnejdVfIdY8p
        +5aMnuxGuqpg6MPdwrbIqtImqt4ObA4Sva6jX62BqtviqWVVs83PhHNLb/9iMJdhOVYs3HtyaX4
        gIKung/rw4q2+uwkHqUeuYvSLOT3Neapk
X-Received: by 2002:a2e:3606:0:b0:2b4:6eb0:2a27 with SMTP id d6-20020a2e3606000000b002b46eb02a27mr4403597lja.17.1690964667878;
        Wed, 02 Aug 2023 01:24:27 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFNA6gz1FZ8UuYKGErq/QQiavCiN+bzB6Z9bnEb46HGJkYdZuEyaP0A0byE8+ZAaUHNQ1TEHA==
X-Received: by 2002:a2e:3606:0:b0:2b4:6eb0:2a27 with SMTP id d6-20020a2e3606000000b002b46eb02a27mr4403582lja.17.1690964667450;
        Wed, 02 Aug 2023 01:24:27 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:e00:b8a4:8613:1529:1caf? (p200300cbc70b0e00b8a4861315291caf.dip0.t-ipconnect.de. [2003:cb:c70b:e00:b8a4:8613:1529:1caf])
        by smtp.gmail.com with ESMTPSA id l22-20020a7bc456000000b003fc06169ab3sm1043916wmi.20.2023.08.02.01.24.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 01:24:26 -0700 (PDT)
Message-ID: <9b6ffb16-19e0-da2c-c4bc-d95416fdc787@redhat.com>
Date:   Wed, 2 Aug 2023 10:24:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/8] mm/compaction: avoid missing last page block in
 section after skip offline sections
Content-Language: en-US
To:     Kemeng Shi <shikemeng@huaweicloud.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        baolin.wang@linux.alibaba.com, mgorman@techsingularity.net
References: <20230802093741.2333325-1-shikemeng@huaweicloud.com>
 <20230802093741.2333325-2-shikemeng@huaweicloud.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230802093741.2333325-2-shikemeng@huaweicloud.com>
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

On 02.08.23 11:37, Kemeng Shi wrote:
> skip_offline_sections_reverse will return the last pfn in found online
> section. Then we set block_start_pfn to start of page block which
> contains the last pfn in section. Then we continue, move one page
> block forward and ignore the last page block in the online section.
> Make block_start_pfn point to first page block after online section to fix
> this:
> 1. make skip_offline_sections_reverse return end pfn of online section,
> i.e. pfn of page block after online section.
> 2. assign block_start_pfn with next_pfn.
> 
> Fixes: f63224525309 ("mm: compaction: skip the memory hole rapidly when isolating free pages")
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>   mm/compaction.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index cd23da4d2a5b..a8cea916df9d 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -250,6 +250,11 @@ static unsigned long skip_offline_sections(unsigned long start_pfn)
>   	return 0;
>   }
>   
> +/*
> + * If the PFN falls into an offline section, return the end PFN of the
> + * next online section in reverse. If the PFN falls into an online section
> + * or if there is no next online section in reverse, return 0.
> + */
>   static unsigned long skip_offline_sections_reverse(unsigned long start_pfn)
>   {
>   	unsigned long start_nr = pfn_to_section_nr(start_pfn);
> @@ -259,7 +264,7 @@ static unsigned long skip_offline_sections_reverse(unsigned long start_pfn)
>   
>   	while (start_nr-- > 0) {
>   		if (online_section_nr(start_nr))
> -			return section_nr_to_pfn(start_nr) + PAGES_PER_SECTION - 1;
> +			return section_nr_to_pfn(start_nr) + PAGES_PER_SECTION;
>   	}
>   
>   	return 0;
> @@ -1668,8 +1673,7 @@ static void isolate_freepages(struct compact_control *cc)
>   
>   			next_pfn = skip_offline_sections_reverse(block_start_pfn);
>   			if (next_pfn)
> -				block_start_pfn = max(pageblock_start_pfn(next_pfn),
> -						      low_pfn);
> +				block_start_pfn = max(next_pfn, low_pfn);
>   
>   			continue;
>   		}

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

