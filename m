Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FAA7A82FC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbjITNMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234481AbjITNMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:12:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2489E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 06:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695215487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oYm/Hehcaf9clr/3Nqxb6FNHPYKywPyNIBP16nLDItw=;
        b=UbhpxBHTw2QV7fCR3Vwb1giUU8b4nszGZrQ6P44iCqxoVvy/cb8xFDQWxqWf96KVHkDT3K
        vODDdBTq8Incp/HqXDF9XLKV7I2SRGp2hESREIyzTwhCr5JzD+fuDU2gEOF/HJXyScixSM
        jdMXRD+PE6/IDMEjuLzIK0+qNWreapE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-meUFxnCRMNWmFP1jaQCjbA-1; Wed, 20 Sep 2023 09:11:25 -0400
X-MC-Unique: meUFxnCRMNWmFP1jaQCjbA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f41a04a297so52818225e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 06:11:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695215485; x=1695820285;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYm/Hehcaf9clr/3Nqxb6FNHPYKywPyNIBP16nLDItw=;
        b=wtRng2CquuZWYcqGcHLKv01UPsXnuAEAY7I4aFh4855JMRpOfMJ6s19qVeLLjrIoFq
         FAI0ZSjmeST7XhdXzVe+v0xc3GXUCktm4nGktOWl8WkvLdhLFepAI9KfRtqOMeIfPza4
         AD6VrcBaXsUG1VIicRWvwsLccW3ea2hUdzuOejS3wZUCdLgO16ATCqZCVjvFTkRFM5Sz
         WjXp0yJhH7Uhmh9tK4SlkvqUjrJGWLilzNDtQAF2DjlluXLyn0C5ZnVtNfhlWNLF5HD5
         77tadu3i2J66NBmzRM0Zo524MhJHhDg9DmldGoJlhKy/92VN0ewAoaKr4CIqti2kdnOw
         fJeQ==
X-Gm-Message-State: AOJu0YxCR76Zu/NbHErXMJXY15ILXkBwHec/o/M4yARN3eamnI8x/b4g
        nJAjXlpd8pxQ0eJGK1jjQENHc6QenZYZQMEJugn0Pzomosn24LPOiUNXI5XCWetQCcPLMlLWeNp
        wN3qbSZMt4LjC0vH8SsRnId4g
X-Received: by 2002:a5d:4f08:0:b0:31f:fa66:5852 with SMTP id c8-20020a5d4f08000000b0031ffa665852mr2078289wru.21.1695215484730;
        Wed, 20 Sep 2023 06:11:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsv7A65TZLETNJZ+kTvocUFDInz23b+iTJRlDZvBeoOAeqZKOgQpelJIjt2J7/WlLrTP9wYw==
X-Received: by 2002:a5d:4f08:0:b0:31f:fa66:5852 with SMTP id c8-20020a5d4f08000000b0031ffa665852mr2078270wru.21.1695215484279;
        Wed, 20 Sep 2023 06:11:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:8600:dad5:13bb:38a9:3010? (p200300cbc70b8600dad513bb38a93010.dip0.t-ipconnect.de. [2003:cb:c70b:8600:dad5:13bb:38a9:3010])
        by smtp.gmail.com with ESMTPSA id e11-20020a056000120b00b003196b1bb528sm18589753wrx.64.2023.09.20.06.11.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 06:11:23 -0700 (PDT)
Message-ID: <a86b8604-befe-23d9-3f7b-34dbaf399adf@redhat.com>
Date:   Wed, 20 Sep 2023 15:11:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 1/2] mm/ksm: support fork/exec for prctl
To:     Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, riel@surriel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Carl Klemm <carl@uvos.xyz>
References: <20230919205158.1897353-1-shr@devkernel.io>
 <20230919205158.1897353-2-shr@devkernel.io>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230919205158.1897353-2-shr@devkernel.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.09.23 22:51, Stefan Roesch wrote:
> A process can enable KSM with the prctl system call. When the process is
> forked the KSM flag is inherited by the child process. However if the
> process is executing an exec system call directly after the fork, the
> KSM setting is cleared. This patch addresses this problem.
> 
> Signed-off-by: Stefan Roesch <shr@devkernel.io>
> Reported-by: Carl Klemm <carl@uvos.xyz>
> ---
>   include/linux/sched/coredump.h | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
> index 0ee96ea7a0e9..205aa9917394 100644
> --- a/include/linux/sched/coredump.h
> +++ b/include/linux/sched/coredump.h
> @@ -87,8 +87,11 @@ static inline int get_dumpable(struct mm_struct *mm)
>   
>   #define MMF_DISABLE_THP_MASK	(1 << MMF_DISABLE_THP)
>   
> +#define MMF_VM_MERGE_ANY	29
> +#define MMF_VM_MERGE_ANY_MASK	(1 << MMF_VM_MERGE_ANY)
> +
>   #define MMF_INIT_MASK		(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
> -				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK)
> +				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK |\
> +				 MMF_VM_MERGE_ANY_MASK)
>   
> -#define MMF_VM_MERGE_ANY	29
>   #endif /* _LINUX_SCHED_COREDUMP_H */

Fixes: tag?

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

