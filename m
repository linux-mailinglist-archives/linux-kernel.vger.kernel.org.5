Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F49D7BB830
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 14:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbjJFMy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 08:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjJFMy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 08:54:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDC3CA
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 05:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696596854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g6htZfDbswFCPywJQRCZEocbznYQRU2LfNQkxAULUvc=;
        b=Fx2L0LB7jYeEwLQohJdyEzAOFE3zR841il4OmQmF7tLKYT/v/AP8PpzeG1PxzcZKmSLGIC
        sG9Opd6J5f9eCaPfTpZu08/kvtu8PYgODmg0RkJqgOZQO3mswDbUYwd+44BVzqW039hqtw
        OIgoubLSnZoXXWDU/jeKKxBd/+dUd1g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-84U66ZB8PLSguOSvSq3RwA-1; Fri, 06 Oct 2023 08:54:12 -0400
X-MC-Unique: 84U66ZB8PLSguOSvSq3RwA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-327b5f2235aso1516261f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 05:54:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696596851; x=1697201651;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g6htZfDbswFCPywJQRCZEocbznYQRU2LfNQkxAULUvc=;
        b=sW+yEJDJ5EALqoLzb7q/3ZfqVlOv/NHJjUr2NBYmT6CvARCPnXvITwLcI9b0zONNe7
         zenrGA3jwJZVcMGDVpc878pkN0hqSOFJLKtOy5M5DHThQrz5VPHIzHMQI+vtAAXe488L
         EhSjNsi/x//8/j1p4Mx44o1dRAEKg3eesAfx674YCl6zniNy+v4tKptDukMHexYBuwXJ
         q0Er9Jz5oSRB9AodA7H7HxkgWg3cI5fr402FiLWiNYTvh3GHEtfJAFiic8MBUgcIokAu
         tvt+2wexV6UxBGjcbEOJe1ZO3sBo3LVxEQ+5PiHSGgO846R7MocEfE40KUKxte/09cyS
         CwXg==
X-Gm-Message-State: AOJu0Yy5w4SpNeg5bu/GCUtFzhNWB+ZD/OkdUqi3eTVmToWje33MdF6w
        0lerUjqbsjTxN5/D7O+TOx4yGr/sLLtQwKx7kvGpBVXkM9VBsExwH7Gm/KKfLBrodi7Fm3sQp3c
        /0q29ZJ02UN7VtSn+r8YS/41P8MRrdpy5
X-Received: by 2002:a5d:6a07:0:b0:321:7844:de44 with SMTP id m7-20020a5d6a07000000b003217844de44mr7428904wru.45.1696596851419;
        Fri, 06 Oct 2023 05:54:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHv/gkP7aT8VVN2umYs2E0/Kde3dTjiaHaJJCy5yGltZralKb5wcUVCXDjPHRwN/I9vOKxQQ==
X-Received: by 2002:a5d:6a07:0:b0:321:7844:de44 with SMTP id m7-20020a5d6a07000000b003217844de44mr7428883wru.45.1696596850933;
        Fri, 06 Oct 2023 05:54:10 -0700 (PDT)
Received: from ?IPV6:2003:cb:c715:ee00:4e24:cf8e:3de0:8819? (p200300cbc715ee004e24cf8e3de08819.dip0.t-ipconnect.de. [2003:cb:c715:ee00:4e24:cf8e:3de0:8819])
        by smtp.gmail.com with ESMTPSA id n9-20020adff089000000b0031ad2f9269dsm1607947wro.40.2023.10.06.05.54.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 05:54:10 -0700 (PDT)
Message-ID: <97577076-8083-df9e-15fd-fc1a5fdaf748@redhat.com>
Date:   Fri, 6 Oct 2023 14:54:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] mm: rmap.c: fix kenrel-doc warning
Content-Language: en-US
To:     Muhammad Muzammil <m.muzzammilashraf@gmail.com>,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20231006122825.54840-1-m.muzzammilashraf@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20231006122825.54840-1-m.muzzammilashraf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.10.23 14:28, Muhammad Muzammil wrote:
> after running make htmldocs, getting this warning
> warning: Function parameter or member 'folio' not described in
> 'folio_move_anon_rmap'
> and this patch resolves this warning
> 
> changes since v1:
> 	- changed page to folio and reverted other changes
> 
> Signed-off-by: Muhammad Muzammil <m.muzzammilashraf@gmail.com>
> ---
>   mm/rmap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index c1f11c9dbe61..6976fb6feeed 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1129,7 +1129,7 @@ int folio_total_mapcount(struct folio *folio)
>   
>   /**
>    * folio_move_anon_rmap - move a folio to our anon_vma
> - * @page:	The folio to move to our anon_vma
> + * @folio:  The folio to move to our anon_vma
>    * @vma:	The vma the folio belongs to
>    *
>    * When a folio belongs exclusively to one process after a COW event,

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

