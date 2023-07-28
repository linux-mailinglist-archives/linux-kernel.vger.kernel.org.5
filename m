Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0E0766AEB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234645AbjG1Km1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjG1KmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:42:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091DD3A81
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 03:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690540868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s4AYZ2Z4BzAcpH/nTmeh8PGBERH7SBsG0XRZTiA9nSk=;
        b=ITg7mNPftB102j49Z9BZZmh11iPZcXDTmGOKp1ZlSYMav6RQGT3ymUu9WEIRU4wZ0CTrXg
        mZKWBnqk1dPs0k61KmCL5DAfhLeHV9lJMGQ10ZpFDzgG5z10xwG4is3czTFDbL7xaFbtnG
        BhmBj64HMiuPceffROFg/W2ElmKfX1E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-SGQRiFsKNXWq__kbmfP_Sg-1; Fri, 28 Jul 2023 06:41:07 -0400
X-MC-Unique: SGQRiFsKNXWq__kbmfP_Sg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-317421b94a4so985495f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 03:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690540866; x=1691145666;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s4AYZ2Z4BzAcpH/nTmeh8PGBERH7SBsG0XRZTiA9nSk=;
        b=YyT9ilyQZ5muM9XXkPDkIaxUSYPv8OGvy7uDkKofJKRJ8knXTqgL/4mcShV84wcync
         fEmS4NTCkUEmkhuX6WW3kuNBrZ+anSZOiB1NJaAhTtTHn/LumsH4hYWtAaz/JIiX9YEj
         cwb8gNReBWSAqshfZ9X774boVadii4QNB26nNJ8S90PBUhRGukSeJMPHXUFMju2Wc2da
         oepuE6ux+/upLfPLmT7UZrYW+xfd04e2nnlBt0uXyZNItxvP4uCYeFw9YWdNpcrdzh12
         dzxCAsOZAw0f4AQZuhpdVAKpNJ0c6ZA2oBOIJWuO2yMDM6MpKjPAzLCVWfib8QWVR+Y7
         KTqg==
X-Gm-Message-State: ABy/qLYvGd+6Tt+raYIiAmgEMIRuRMFrjl/JzGHZEhezPB6RwUknB117
        7Jpr9/3wY/h0p6ur5V+27t0vsVQNXpV9TSf04u2qSbmHCiisib2MgQC4Zw9Vk0mpVdgY2fi0feO
        +9pCgIEwewFf7WhC8HpSg5OON
X-Received: by 2002:adf:f70c:0:b0:313:f61c:42b2 with SMTP id r12-20020adff70c000000b00313f61c42b2mr1567505wrp.69.1690540865872;
        Fri, 28 Jul 2023 03:41:05 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHQWvM3h+hJVZLsDx7/1wU8fv6JvGPKDkGJVGBaVORUobH6t8FOhhOZGqV81t+c1UaqmJeN2Q==
X-Received: by 2002:adf:f70c:0:b0:313:f61c:42b2 with SMTP id r12-20020adff70c000000b00313f61c42b2mr1567489wrp.69.1690540865461;
        Fri, 28 Jul 2023 03:41:05 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:6b00:bf49:f14b:380d:f871? (p200300cbc7066b00bf49f14b380df871.dip0.t-ipconnect.de. [2003:cb:c706:6b00:bf49:f14b:380d:f871])
        by smtp.gmail.com with ESMTPSA id i8-20020adfefc8000000b0030ada01ca78sm4495010wrp.10.2023.07.28.03.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 03:41:05 -0700 (PDT)
Message-ID: <8d3f4a1d-b624-3e2f-653c-032833646dea@redhat.com>
Date:   Fri, 28 Jul 2023 12:41:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/8] mm/compaction: avoid missing last page block in
 section after skip offline sections
Content-Language: en-US
To:     Kemeng Shi <shikemeng@huaweicloud.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        baolin.wang@linux.alibaba.com, mgorman@techsingularity.net,
        willy@infradead.org
References: <20230728171037.2219226-1-shikemeng@huaweicloud.com>
 <20230728171037.2219226-2-shikemeng@huaweicloud.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230728171037.2219226-2-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.07.23 19:10, Kemeng Shi wrote:
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
>   mm/compaction.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 9b7a0a69e19f..ce7841363b12 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c

Can we add a short comment which kind of PFN we return (first pfn of 
first offline section after an online section)?

> @@ -259,7 +259,7 @@ static unsigned long skip_offline_sections_reverse(unsigned long start_pfn)
>   
>   	while (start_nr-- > 0) {
>   		if (online_section_nr(start_nr))
> -			return section_nr_to_pfn(start_nr) + PAGES_PER_SECTION - 1;
> +			return section_nr_to_pfn(start_nr + 1);
>   	}
>   
>   	return 0;
> @@ -1670,8 +1670,7 @@ static void isolate_freepages(struct compact_control *cc)
>   
>   			next_pfn = skip_offline_sections_reverse(block_start_pfn);
>   			if (next_pfn)
> -				block_start_pfn = max(pageblock_start_pfn(next_pfn),
> -						      low_pfn);
> +				block_start_pfn = max(next_pfn, low_pfn);


So block_start_pfn() will now point at the first PFN of the offline section.

Confusing stuff, but I get the idea and I think it makes sense to me :)

-- 
Cheers,

David / dhildenb

