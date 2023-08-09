Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B5D7761EC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbjHIOBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbjHIOBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:01:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932C019A1
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 07:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691589633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aluolLqCzcz4OLmT1ULBFqNwssRR0Xduy3gDjygn/A8=;
        b=H+xSgxVtwy1KjHY0xT8jKRr7Xjtqk+6QZ/yfqTTTPAh1+qbcUDjlkQIBqAgQZc/jXXExOu
        I46Y15rb1XNj11u0R7VMoAO7PsgYbLfM3qrqZ1/2ZTve1svXSqqn1kdMeRhTvIxJIhzlls
        Utik3NKHCzIeKRpNPyeQJl66SlkBd/M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-O4eX0h9vNO6t_7lnH7ILcA-1; Wed, 09 Aug 2023 10:00:32 -0400
X-MC-Unique: O4eX0h9vNO6t_7lnH7ILcA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-317a84a3ebeso505496f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 07:00:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691589631; x=1692194431;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aluolLqCzcz4OLmT1ULBFqNwssRR0Xduy3gDjygn/A8=;
        b=YMKFMwRTXh2cwlTl/v5+h7i0Nl/6i+yf/TMpJGVmr/lNWe25hdA0I0PSUGosKGwXYQ
         PIIyjmjC9e3hTfh3L9VMN7t2Q1KwlJiUKHltzP6iypb+4h6Lu26qYp1RrPkFKAhJZae5
         esZCRwgkusgtv659JurDpABk7p3qKIymyHXA3lUnP/I8/CXHMa9hXyRXyQ3obkQ7zuaq
         T+QcQHaq0/H0V+ut3RBJZWjJZtI3Yr2VicoNeLlIy+fdzE6f6St8BmcsZlsyYFFYSZn5
         mSThnCs8Eh4jyRuiE39HLAjhTFI+zzK4uJPUepfuMuqnBxIgtKZRdFrnvzJ5iskgOHB9
         WrLQ==
X-Gm-Message-State: AOJu0Yxjx5Si61704QUn5bA813419gAb2L8Rj0W5GtgBXSro4z6BxW0T
        szeIubke/wA5G2sF0LIHfoBSXB9Z4x4s2uDspp9Xa91wcuGpr/Of0ruGuImBPzbrGlS9DHG7uu7
        jzhaCyZ6EJeTRSAxI/VmoJH7U
X-Received: by 2002:adf:fcc4:0:b0:314:3369:df57 with SMTP id f4-20020adffcc4000000b003143369df57mr10478160wrs.5.1691589630824;
        Wed, 09 Aug 2023 07:00:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHq8eyODQkiCXu0pqsZC3bKXH5wWt/tpXu5a4c1dvrP2vcV295Iz5h7sZWgfaI/eIBurDamdQ==
X-Received: by 2002:adf:fcc4:0:b0:314:3369:df57 with SMTP id f4-20020adffcc4000000b003143369df57mr10478140wrs.5.1691589630391;
        Wed, 09 Aug 2023 07:00:30 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70e:6800:9933:28db:f83a:ef5? (p200300cbc70e6800993328dbf83a0ef5.dip0.t-ipconnect.de. [2003:cb:c70e:6800:9933:28db:f83a:ef5])
        by smtp.gmail.com with ESMTPSA id c17-20020adffb11000000b00317efb41e44sm8029944wrr.18.2023.08.09.07.00.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 07:00:29 -0700 (PDT)
Message-ID: <9d109a43-78a3-dee4-5aaa-385bdfe4bcb3@redhat.com>
Date:   Wed, 9 Aug 2023 16:00:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] Multi-gen LRU: skip CMA pages when they are not eligible
Content-Language: en-US
To:     Charan Teja Kalla <quic_charante@quicinc.com>,
        akpm@linux-foundation.org, zhaoyang.huang@unisoc.com,
        yuzhao@google.com, surenb@google.com, kaleshsingh@google.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1691568344-13475-1-git-send-email-quic_charante@quicinc.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <1691568344-13475-1-git-send-email-quic_charante@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.08.23 10:05, Charan Teja Kalla wrote:
> This patch is based on the commit 5da226dbfce3("mm: skip CMA pages when
> they are not available") which skips cma pages reclaim when they are not
> eligible for the current allocation context. In mglru, such pages are
> added to the tail of the immediate generation to maintain better LRU
> order, which is unlike the case of conventional LRU where such pages are
> directly added to the head of the LRU list(akin to adding to head of the
> youngest generation in mglru).
> 
> No observable issue without this patch on MGLRU, but logically it make
> sense to skip the CMA page reclaim when those pages can't be satisfied
> for the current allocation context.
> 
> Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
> ---
>   mm/vmscan.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index b4329f9..6cbe921 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4943,7 +4943,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
>   	}
>   
>   	/* ineligible */
> -	if (zone > sc->reclaim_idx) {
> +	if (zone > sc->reclaim_idx || skip_cma(folio, sc)) {
>   		gen = folio_inc_gen(lruvec, folio, false);
>   		list_move_tail(&folio->lru, &lrugen->folios[gen][type][zone]);
>   		return true;

Makes sense to me.

-- 
Cheers,

David / dhildenb

