Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41267773D7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbjHJJL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbjHJJLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:11:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD7B26B8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691658638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ok20ImRbwV+ahFsSJEGEi8FG+c4kJzXHikrFiTYwZr4=;
        b=OVkfNDiIc1ljBrC8QAx8EaVn19X2GMy+3pksmb2u2xo1szol5A0ak2cSEqTeBKBJ1TY9QC
        /P7aGI4QBaqH3WzrEzDslBDi/PF7FPKKpY6V517XGurW7/iNq/6hvzbG2/rCHI4SWl/9ov
        VXL1bEFghrlzgMQNfYuSu7t3DVI2uBQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-PnNSEb5HO4-g-Hf87YBFzg-1; Thu, 10 Aug 2023 05:10:36 -0400
X-MC-Unique: PnNSEb5HO4-g-Hf87YBFzg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-317dff409dfso254362f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:10:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691658635; x=1692263435;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ok20ImRbwV+ahFsSJEGEi8FG+c4kJzXHikrFiTYwZr4=;
        b=kcs+zMIKh1G9BgUxwQ74MpnCy1h0ML3DVWbZP98XnyH9JGFRRzx2QKVAT92PYmQ2dl
         YM1jpqDgrtoWsElzJCo8Ss6l3JJdLg5iMoPffI4B0PUFLAsVV/u8QZME2USiWMvdNq80
         lrjYt2W+HM1Vk+J819izX4pWxbZwDKeDbGa50i9HorM69D4nSGangWIOJfSmAidvbaJt
         HAXAc38BHNEPOgqmeFcLi+pUUkDEPXKcfnjtjiorRxltqGoD9ILLr93YVlzkoPBCkQJe
         XcUIjFFCnFzZGrgjlJIptbMdfo2r/XOPQ7E2DfwknJPjqyx8FrQJ7vM3q8kgGrMppexo
         pKKA==
X-Gm-Message-State: AOJu0YzkKBN1Bg+nVV1afK7O1seXLCS7uVNv5DKV5SrR0a5YVrNsfFTI
        +PZgvb04FVSFijKeOq+ytdMl78WR8DgGtznp/13SDEX/Kc65hdLbqCy+/r9qauPPfNr1SYPAsLa
        kO+gHB3BJd0eIvPuePce5ZJLo
X-Received: by 2002:adf:cf0e:0:b0:317:60fc:c8d0 with SMTP id o14-20020adfcf0e000000b0031760fcc8d0mr1360640wrj.0.1691658635562;
        Thu, 10 Aug 2023 02:10:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHy5laYqgU/tH+lg/RQ1L1OS7NeE5KDy5YnWrbrSTsyABQl13F+8PsrK2qFdNRGiqFbrbAZng==
X-Received: by 2002:adf:cf0e:0:b0:317:60fc:c8d0 with SMTP id o14-20020adfcf0e000000b0031760fcc8d0mr1360622wrj.0.1691658635203;
        Thu, 10 Aug 2023 02:10:35 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id j4-20020adfff84000000b003142ea7a661sm1511133wrr.21.2023.08.10.02.10.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 02:10:34 -0700 (PDT)
Message-ID: <6c766c69-21c5-9f52-a172-18083edcb2c5@redhat.com>
Date:   Thu, 10 Aug 2023 11:10:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] mm/page_alloc: correct start page when guard page
 debug is enabled
Content-Language: en-US
To:     Kemeng Shi <shikemeng@huaweicloud.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        baolin.wang@linux.alibaba.com, mgorman@techsingularity.net,
        willy@infradead.org
References: <20230810095309.3109107-1-shikemeng@huaweicloud.com>
 <20230810095309.3109107-2-shikemeng@huaweicloud.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230810095309.3109107-2-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.08.23 11:53, Kemeng Shi wrote:
> When guard page debug is enabled and set_page_guard returns success, we miss
> to forward page to point to start of next split range and we will do split
> unexpectedly in page range without target page. Move start page update
> before set_page_guard to fix this.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>   mm/page_alloc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 96b7c1a7d1f2..fd93d1396ccd 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6557,6 +6557,7 @@ static void break_down_buddy_pages(struct zone *zone, struct page *page,
>   			next_page = page;
>   			current_buddy = page + size;
>   		}
> +		page = next_page;
>   
>   		if (set_page_guard(zone, current_buddy, high, migratetype))
>   			continue;
> @@ -6564,7 +6565,6 @@ static void break_down_buddy_pages(struct zone *zone, struct page *page,
>   		if (current_buddy != target) {
>   			add_to_free_list(current_buddy, zone, high, migratetype);
>   			set_buddy_order(current_buddy, high);
> -			page = next_page;
>   		}
>   	}
>   }

Is this worth a Fixes: tag?

What is the user-visible result?

-- 
Cheers,

David / dhildenb

