Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07EF27D93C6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 11:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345595AbjJ0Jds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 05:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjJ0Jdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 05:33:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0CDD57
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 02:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698399171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=kErByrtybkXy+qsIgVSS1Zc/twwVH7oA03pKyu56CcU=;
        b=CLBSR+mjCgPSfrk0RPyEgzMFRxuui0iYiHvIIxuCrecLHUHeYOeB035raz+g95bmLbtfH5
        f/puYuxvPM1GhuKUb4qGITDIwzof/2zlWIdizupLb7dP6613myexq+yrV5Xh7U4c5zR4DI
        r7CyDtRGRzPTkJoj4to4wDL5AyIoZ5g=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-ih90cJOpPImvo8_zhBf1TA-1; Fri, 27 Oct 2023 05:32:49 -0400
X-MC-Unique: ih90cJOpPImvo8_zhBf1TA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-507a0904cdbso2328214e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 02:32:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698399167; x=1699003967;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kErByrtybkXy+qsIgVSS1Zc/twwVH7oA03pKyu56CcU=;
        b=dOVQPFnjQlThn1A0Hbhe/ldXdou918gnge5P1f8ofea9fB4jmhFClMHTPRA3dOBrAP
         xClN7Psc8XIsu8qwd1fFpXKAMTSBBL3dGeLG+5XKCFx0g1I1cWvVPwlFA+xEzoUtEW3j
         l5B0FlS3RjVBKK/Ki6AdfcSK1FXcGVtzq23xYB8B1/EOk15D0v/emZMWtbEvsHLLtJhq
         OHUXrRsvGPzDnP10PmzngyMgepTCfMZXIITNxjhTKv48ZR7XvJuMkhJCfXDIBremWz7g
         JtU9LVGQIOYITjJksvc1rmbu1DTZX6+P+jH0KtYDMmrJMpCfzfy9qiCTiQUHa25Y8wYi
         8psw==
X-Gm-Message-State: AOJu0YwipwFyYy2VS5Ku2mS4tKNjTlptYQvdV+UuY862kqOcyd7Ce9F+
        xO/rHRCx0+YGhL5FHUtHpQEI8fbp+Dwde5AxyocZjHp1sTNhwXs9lPAIk/ZcgQ28Jqdf+CFV/G7
        5Y7+srl+ulK/uCm+l+9L6CSWV
X-Received: by 2002:a05:6512:48d0:b0:503:15a5:b368 with SMTP id er16-20020a05651248d000b0050315a5b368mr1542633lfb.16.1698399167357;
        Fri, 27 Oct 2023 02:32:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPdNMQiqanQK3mwDCQINDl0E95dF5V67xitFEVSVMFm+K6ZCKgFMTSaUGJdYAFuIYvc9QNXA==
X-Received: by 2002:a05:6512:48d0:b0:503:15a5:b368 with SMTP id er16-20020a05651248d000b0050315a5b368mr1542613lfb.16.1698399166912;
        Fri, 27 Oct 2023 02:32:46 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71a:c000:811f:68f2:1ecb:4e2d? (p200300cbc71ac000811f68f21ecb4e2d.dip0.t-ipconnect.de. [2003:cb:c71a:c000:811f:68f2:1ecb:4e2d])
        by smtp.gmail.com with ESMTPSA id x3-20020a5d54c3000000b0031f3ad17b2csm1350835wrv.52.2023.10.27.02.32.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 02:32:46 -0700 (PDT)
Message-ID: <78a98a32-6238-4881-bfbc-0e7888aea7b1@redhat.com>
Date:   Fri, 27 Oct 2023 11:32:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] maple_tree: Remove unused function
Content-Language: en-US
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Liam.Howlett@oracle.com
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20231027084944.24888-1-jiapeng.chong@linux.alibaba.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231027084944.24888-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.10.23 10:49, Jiapeng Chong wrote:
> The function are defined in the maple_tree.c file, but not called
> elsewhere, so delete the unused function.
> 
> lib/maple_tree.c:689:29: warning: unused function 'mas_pivot'.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7064
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>   lib/maple_tree.c | 29 -----------------------------
>   1 file changed, 29 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index bb24d84a4922..cf889aaa0011 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -679,35 +679,6 @@ static inline unsigned long *ma_gaps(struct maple_node *node,
>   	return NULL;
>   }
>   
> -/*
> - * mas_pivot() - Get the pivot at @piv of the maple encoded node.
> - * @mas: The maple state.
> - * @piv: The pivot.
> - *
> - * Return: the pivot at @piv of @mn.
> - */
> -static inline unsigned long mas_pivot(struct ma_state *mas, unsigned char piv)
> -{
> -	struct maple_node *node = mas_mn(mas);
> -	enum maple_type type = mte_node_type(mas->node);
> -
> -	if (MAS_WARN_ON(mas, piv >= mt_pivots[type])) {
> -		mas_set_err(mas, -EIO);
> -		return 0;
> -	}
> -
> -	switch (type) {
> -	case maple_arange_64:
> -		return node->ma64.pivot[piv];
> -	case maple_range_64:
> -	case maple_leaf_64:
> -		return node->mr64.pivot[piv];
> -	case maple_dense:
> -		return 0;
> -	}
> -	return 0;
> -}
> -
>   /*
>    * mas_safe_pivot() - get the pivot at @piv or mas->max.
>    * @mas: The maple state

Think the last user was removed with c2aa6f5328b9 ("maple_tree: drop 
mas_{rev_}alloc() and mas_fill_gap()").

Acked-by: David Hildenbrand <david@redhat.com>


-- 
Cheers,

David / dhildenb

