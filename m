Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B234C758E22
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 08:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjGSGwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 02:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjGSGwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 02:52:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6DA1BFC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 23:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689749514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RmgXaAba/oCYxBLIcW2af9UbEUzL3nU3I4mLOpLAlGU=;
        b=itukjsw2sa5ZS8Zvbd/FYchDvEeN6NxQ/DyYvALboS49Sco4zkRGoHUWvvKB/YwEy9OWBm
        z2oOViQ4VSbNIhrsp/3RR+0zDVyx2fwjCHYtkCdzC1ygvGY/X+ERB/mcfSTxPBQ/xJ/N4S
        tm0OgTnf3d1g3AVsXErI8trG6BDNpf4=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-8Vs1XdscMVCgwj-zKUJ2Hg-1; Wed, 19 Jul 2023 02:51:53 -0400
X-MC-Unique: 8Vs1XdscMVCgwj-zKUJ2Hg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4fccf211494so5238540e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 23:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689749510; x=1692341510;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RmgXaAba/oCYxBLIcW2af9UbEUzL3nU3I4mLOpLAlGU=;
        b=JCJoGi1leeUHwT8wcvXjOzkVkTf9hmrZtBSgm5IvqLgGSXZld3rCxFlRQesK0QJ4J+
         Wo/eun1TtuK+kCk+NVy7NASz8905JnzotOcp/QKtuhr1uSNQhBo240GiFyPgr+IUvZco
         1sAWgkhfIHuNYu+tw7anrsszJoD4Td8ck7JlrrbgsxUv741yi3rEokEyrcZ9v7/nrIKb
         6DP1HibEZh/pqIjreh/dmc3P4gNWIlFb07Ul2wsYslexn7/eENVqhdqAF3sFQSaXjV/P
         3zg0NVjKFvadVsuboOLvOrXTqD4FoaIjxtO47ZVL9wNBhVCw1j+2E7LVQqEIh1WuDZOb
         oi+w==
X-Gm-Message-State: ABy/qLZVBKotxnb309TO8lxOnQSeC1wPCoJCCA8lj8eRey/spG7LUerl
        CJgJ/EkjZk5dfKTs3uDDCwbxFkItIvnsMaMlKBdXgCfSd0EWuwVvt1eyW+Aj4ZG13Uj+G1Ri/BP
        nPsY88gIOS4w623HIP9ccKVf1Vn3itOQ=
X-Received: by 2002:a05:6512:4002:b0:4fb:7c40:9f97 with SMTP id br2-20020a056512400200b004fb7c409f97mr13453076lfb.27.1689749510631;
        Tue, 18 Jul 2023 23:51:50 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHiblX6I1VK85JRK6ZfiR6zQ/918ty6VbbTzNPHQVPdj/huza5v97okOnE6LLJAIPpT3GEn4A==
X-Received: by 2002:a05:6512:4002:b0:4fb:7c40:9f97 with SMTP id br2-20020a056512400200b004fb7c409f97mr13453059lfb.27.1689749510204;
        Tue, 18 Jul 2023 23:51:50 -0700 (PDT)
Received: from [192.168.1.121] (85-23-20-79.bb.dnainternet.fi. [85.23.20.79])
        by smtp.gmail.com with ESMTPSA id a12-20020a19f80c000000b004fa5f4fd094sm801329lff.266.2023.07.18.23.51.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 23:51:49 -0700 (PDT)
Message-ID: <2b66797b-3ee9-a70f-25d0-dcab830859d2@redhat.com>
Date:   Wed, 19 Jul 2023 09:51:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] mm: hugetlb_vmemmap: use PageCompound() instead of
 PageReserved()
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>, mike.kravetz@oracle.com,
        muchun.song@linux.dev, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230719063132.37676-1-songmuchun@bytedance.com>
From:   =?UTF-8?Q?Mika_Penttil=c3=a4?= <mpenttil@redhat.com>
In-Reply-To: <20230719063132.37676-1-songmuchun@bytedance.com>
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

Hi,


On 19.7.2023 9.31, Muchun Song wrote:
> The ckeck of PageReserved() is easy to be broken in the future, PageCompound()
> is more stable to check if the page should be split.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>   mm/hugetlb_vmemmap.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index 4b9734777f69..8068fe890f52 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -73,8 +73,10 @@ static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start)
>   		 * be treated as indepdenent small pages (as they can be freed
>   		 * individually).
>   		 */
> -		if (!PageReserved(head))
> +		if (PageCompound(head)) {
> +			VM_BUG_ON(compound_order(head) != get_order(PMD_SIZE));
>   			split_page(head, get_order(PMD_SIZE));

I think vmemmap pages are not compound pages (even order > 0).
They would bug on here trying to split_page() :


void split_page(struct page *page, unsigned int order)
{
         int i;

         VM_BUG_ON_PAGE(PageCompound(page), page);


> +		}
>   
>   		/* Make pte visible before pmd. See comment in pmd_install(). */
>   		smp_wmb();

--Mika

