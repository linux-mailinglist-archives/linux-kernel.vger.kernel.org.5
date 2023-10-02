Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065157B50FE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 13:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236655AbjJBLQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 07:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236610AbjJBLQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:16:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABF0AC
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 04:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696245339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vloWIm8roEEtkpE7kohbeVMYbuY6qmZVGsigEMAa8jk=;
        b=H0d9i7FjxgFDw53qerelKijbHvbe6c7mkmnLtTc/p/zB28Rebb+bMl/uNX0bc7EbgGwfjf
        r2gZW5AOz6vXxcQApNzG5zsfJsongi0lycB6/3ZGJfP7EXXfGnAyKxs0HGLYbzCCFNJDUA
        k8UiXNWiYgW8nfKrsGHdPbyhRisG1BU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-P88n6qZqMuSAgahAc7Bchw-1; Mon, 02 Oct 2023 07:15:37 -0400
X-MC-Unique: P88n6qZqMuSAgahAc7Bchw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-321f75cf2bdso12011692f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 04:15:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696245336; x=1696850136;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vloWIm8roEEtkpE7kohbeVMYbuY6qmZVGsigEMAa8jk=;
        b=cl9i2omc7IJU8gEYlGNz+GIEVscfOggVSrwX2SgV8CgxEXghBmaZSxsw5GGg/PNR3C
         CaTgbKL1VYaRqtDOIQ2HsIc7P1R9WXoWesbyifMlH0AfVQt1v6fzQ3BAyJeBh+ubmYps
         BMeTOyYbPnKVcKgByjU71RaqdyXWy14DasE0rmmNZ58VZY3MDrUdpMjsVTRbL/unD9aG
         N2dJCZ51QGOIJElQZnJ575rNlFTkYUQO/BbwUQ4oY/zu73xtR+NbAnw0ml/t7tLSOIDY
         MX1xQK4kyBUc7LGoLibsTdc5Zx7oiwSapNaO8YJepuh5Mwv8VKzusAqF3vYl+dRWClnV
         MS0A==
X-Gm-Message-State: AOJu0Yz1cPzYI9Fs06sAW5kfdOr3HZU3KF32l7FdKXFXbG5Fn9INSpT+
        yZ/fx40SBredUzbEChaZzgeLVtHZSzXy9MI6S6nu1YXFP3yK7PYQfC9BY8MfYHaGFEMbTMq2A6B
        IpIvqfYfEN0DNO4GW72FR8Cbf
X-Received: by 2002:a5d:4c84:0:b0:317:5182:7b55 with SMTP id z4-20020a5d4c84000000b0031751827b55mr9436584wrs.42.1696245336557;
        Mon, 02 Oct 2023 04:15:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGW9393cqtNAAuZ44EYJhv8HMERFb7Fxyq1hsOhUqUd37RVvM2CvD/2j4qcON/3kGZkcdStFw==
X-Received: by 2002:a5d:4c84:0:b0:317:5182:7b55 with SMTP id z4-20020a5d4c84000000b0031751827b55mr9436571wrs.42.1696245336137;
        Mon, 02 Oct 2023 04:15:36 -0700 (PDT)
Received: from ?IPV6:2003:cb:c735:f200:cb49:cb8f:88fc:9446? (p200300cbc735f200cb49cb8f88fc9446.dip0.t-ipconnect.de. [2003:cb:c735:f200:cb49:cb8f:88fc:9446])
        by smtp.gmail.com with ESMTPSA id 6-20020a05600c22c600b00406447b798bsm6999866wmg.37.2023.10.02.04.15.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 04:15:35 -0700 (PDT)
Message-ID: <a65a8eb8-8889-051b-f46b-b797ed91e0b0@redhat.com>
Date:   Mon, 2 Oct 2023 13:15:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] mm/gup: Clean up errors in gup.c
Content-Language: en-US
To:     KaiLong Wang <wangkailong@jari.cn>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1748b504.8b0.18ad9d487ae.Coremail.wangkailong@jari.cn>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <1748b504.8b0.18ad9d487ae.Coremail.wangkailong@jari.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.09.23 05:28, KaiLong Wang wrote:
> Fix the following errors reported by checkpatch:
> 
> ERROR: else should follow close brace '}'
> 
> Signed-off-by: KaiLong Wang <wangkailong@jari.cn>
> ---
>   mm/gup.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 2f8a2d89fde1..aed327450250 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1480,8 +1480,7 @@ static __always_inline long __get_user_pages_locked(struct mm_struct *mm,
>   			return -EAGAIN;
>   		must_unlock = true;
>   		*locked = 1;
> -	}
> -	else
> +	} else
>   		mmap_assert_locked(mm);
>   
>   	if (flags & FOLL_PIN)

Please see Documentation/process/coding-style.rst "3) Placing Braces and 
Spaces"

-- 
Cheers,

David / dhildenb

