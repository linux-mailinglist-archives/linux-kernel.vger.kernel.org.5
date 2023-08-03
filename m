Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2516F76E9AE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236198AbjHCNMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjHCNMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:12:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2507468B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 06:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691068139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=25q2f4QIBXlN+KgpNe5k3Wb9XdvdW+h/LzkEpoNRomc=;
        b=WxpT2WdvJtc3kmDzVha1ttrLgAk2JgeiU+bhQtQmr7e/vad+VNs8bEH95R6GjEDpDy7DUc
        W6s8FfWTdugOEILAbeM7bWrS4n9yHsH917sDnmpfXvyvKblhOL2R+VTGnCNwcSQNN4m/G2
        zSojGwyRatv1R56gM2Z1h4RO/d5/bX8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-7HKX0y1AP2GMIHz0XOtVrw-1; Thu, 03 Aug 2023 09:08:57 -0400
X-MC-Unique: 7HKX0y1AP2GMIHz0XOtVrw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3178532c6c8so509464f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 06:08:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691068135; x=1691672935;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=25q2f4QIBXlN+KgpNe5k3Wb9XdvdW+h/LzkEpoNRomc=;
        b=TioJ0xtf18KOzzRzLxlrjATGx6ASZp+PHplKHY3RadV7U3AGEA1UAsc22owsKc1BV9
         4HyMFxjnX+Gp4gyGtcNTR3wtwQuTaJldgsfI5EpC0Dn+gKnIOzjEvxy8cpQL9+/KHny6
         A/T16DWx/IkxK261UXFN9fqws/JPLWgs1+OZCK7L7U9VWvj50kd8H+VOKNOGw9c0ptNF
         OlcFzBRGtldO6fJPBaxSQvRcuviMfaZpvZ4pFygRJKm/I2J8agim5NNC9AXI6zYokd9t
         dsU40o/Pq56SoRMzHFTfHMDCGgL+LH4SrG+Xq6Z8l48eiXC2lQwJP4RmdTPuwhBPhWGt
         sIfw==
X-Gm-Message-State: ABy/qLaI6L3akEsscbesLYuKs1zWOx0ORC6Mr7Y3EurQyZgRI5hmQdqX
        IlAf+kScOBwVbgF5wRgHuYv1cwS3aETF4EM8TQmnumTARfLNd0waubjdlb29/PIqEg4IW/hIdXg
        /YSZIcOHQxbqICc/xuVQTYKzJU2bJS4bQ
X-Received: by 2002:adf:f6c6:0:b0:317:5cfb:714c with SMTP id y6-20020adff6c6000000b003175cfb714cmr6691079wrp.25.1691068135676;
        Thu, 03 Aug 2023 06:08:55 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGwjr+buTj2yxFI0ur1IJMZMUMb4lAUtmU+Klmbq0qiadSvcx+oDaX7+hTjcsSCWJz0m+tMzw==
X-Received: by 2002:adf:f6c6:0:b0:317:5cfb:714c with SMTP id y6-20020adff6c6000000b003175cfb714cmr6691065wrp.25.1691068135291;
        Thu, 03 Aug 2023 06:08:55 -0700 (PDT)
Received: from ?IPV6:2003:cb:c718:9a00:a5f5:5315:b9fa:64df? (p200300cbc7189a00a5f55315b9fa64df.dip0.t-ipconnect.de. [2003:cb:c718:9a00:a5f5:5315:b9fa:64df])
        by smtp.gmail.com with ESMTPSA id d4-20020adfe884000000b003144b95e1ecsm21876256wrm.93.2023.08.03.06.08.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 06:08:54 -0700 (PDT)
Message-ID: <590d3fd8-54a8-e2c8-33ae-5e2f6d03abe4@redhat.com>
Date:   Thu, 3 Aug 2023 15:08:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] mm/mm_init: use helper macro BITS_PER_LONG
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        rppt@kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230803114051.637709-1-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230803114051.637709-1-linmiaohe@huawei.com>
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

On 03.08.23 13:40, Miaohe Lin wrote:
> It's more readable to use helper macro BITS_PER_LONG. No functional
> change intended.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/mm_init.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 66aca3f6accd..2f37dbb5ff9a 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -79,7 +79,7 @@ void __init mminit_verify_pageflags_layout(void)
>   	int shift, width;
>   	unsigned long or_mask, add_mask;
>   
> -	shift = 8 * sizeof(unsigned long);
> +	shift = BITS_PER_LONG;
>   	width = shift - SECTIONS_WIDTH - NODES_WIDTH - ZONES_WIDTH
>   		- LAST_CPUPID_SHIFT - KASAN_TAG_WIDTH - LRU_GEN_WIDTH - LRU_REFS_WIDTH;
>   	mminit_dprintk(MMINIT_TRACE, "pageflags_layout_widths",
> @@ -1431,7 +1431,7 @@ static unsigned long __init usemap_size(unsigned long zone_start_pfn, unsigned l
>   	usemapsize = roundup(zonesize, pageblock_nr_pages);
>   	usemapsize = usemapsize >> pageblock_order;
>   	usemapsize *= NR_PAGEBLOCK_BITS;
> -	usemapsize = roundup(usemapsize, 8 * sizeof(unsigned long));
> +	usemapsize = roundup(usemapsize, BITS_PER_LONG);
>   
>   	return usemapsize / 8;
>   }

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

