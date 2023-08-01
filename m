Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEEBF76BC1E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 20:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjHASQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 14:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjHASQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 14:16:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326F41718
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 11:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690913713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aebcEwGh27gNIQ03Imyal/tAdi6Up/DQcokGZ4ckJ+Y=;
        b=ViIAR+gf4vvOYxcWzkOmWq9tURF3Y6Iqa6sHFo0M66D/RKiZzG7ZaQ9IMiR/du18hXc16P
        rZxxXZvNIQNC21/E5JMfXe2oyyY5UgJQ/vF1RYWLjy7Fl4QbPA0PvDz3atJmDWyUze/y8D
        iOHox/DMN83S52ZuL32Sbe4kf1gT9rQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-U3pjU8jzMNGwCoHOSR_8NA-1; Tue, 01 Aug 2023 14:15:12 -0400
X-MC-Unique: U3pjU8jzMNGwCoHOSR_8NA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fe25f8c4bfso9957135e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 11:15:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690913696; x=1691518496;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aebcEwGh27gNIQ03Imyal/tAdi6Up/DQcokGZ4ckJ+Y=;
        b=kkqIAbzB7ui2K9eMAhOejg2ndFmawwe04O3GQqxtrzb04vd0DqAk0uUz2x8ptP59Zx
         Tul+yaTWBNJ39AGR9ZBNtHnkeYc+cMnBYIOd78r6GlgDtMgtS6vlSxOvD7554xEqVue8
         zvTh3U4eYY89UZGnwGbbuifVH7al9dY/qm9h4qWXHwa6PaAPmEXnekWKUYnRmAOa4Bwl
         23GTSTJnJW/mvaVYB85WYf0c8YEmC8pe5nJbiOjTD9bqsCTo0n1l6tsz8V+TkfEdXF/Y
         cwAi/RfYDNNi74zpXEAj+QBt0jN8GbEY6H+zm3bKztswGfkdPoh/Idw6gzmeQnAoDIi7
         oTCg==
X-Gm-Message-State: ABy/qLZ5ODf9rA6J0VBx5BS+OTv4Q8VmlwDdICAfZ6NZ+t+fovGeNW4q
        qjTzbaD41CDRJmVXPoiXFGlQucq9+LzSfwzxFLk+hU7ELoQaGQkVzA9HsJTmi94p6AftrIr13vk
        YdzFAiPnK5oqhGI1zHP1SoKcX
X-Received: by 2002:a05:600c:2991:b0:3fe:1f98:deb7 with SMTP id r17-20020a05600c299100b003fe1f98deb7mr3227756wmd.35.1690913695683;
        Tue, 01 Aug 2023 11:14:55 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHjAyBiUjEr3ZWEVqJbYhIbSVEFxyFvlkeCGfJy70Ndyc8CB99cVZI0cTQrSpDMu/5BC6J9pA==
X-Received: by 2002:a05:600c:2991:b0:3fe:1f98:deb7 with SMTP id r17-20020a05600c299100b003fe1f98deb7mr3227726wmd.35.1690913695269;
        Tue, 01 Aug 2023 11:14:55 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:d100:871b:ec55:67d:5247? (p200300cbc705d100871bec55067d5247.dip0.t-ipconnect.de. [2003:cb:c705:d100:871b:ec55:67d:5247])
        by smtp.gmail.com with ESMTPSA id e19-20020a05600c219300b003fbdbd0a7desm17194996wme.27.2023.08.01.11.14.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 11:14:54 -0700 (PDT)
Message-ID: <70442e7f-a401-1b4a-3060-ee1d9ac45290@redhat.com>
Date:   Tue, 1 Aug 2023 20:14:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] fs/proc/kcore: reinstate bounce buffer for KCORE_TEXT
 regions
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        linux-fsdevel@vger.kernel.org, Jiri Olsa <olsajiri@gmail.com>,
        Will Deacon <will@kernel.org>, Mike Galbraith <efault@gmx.de>,
        Mark Rutland <mark.rutland@arm.com>,
        wangkefeng.wang@huawei.com, catalin.marinas@arm.com,
        ardb@kernel.org,
        Linux regression tracking <regressions@leemhuis.info>,
        regressions@lists.linux.dev, Matthew Wilcox <willy@infradead.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        stable@vger.kernel.org
References: <20230731215021.70911-1-lstoakes@gmail.com>
 <0af1bc20-8ba2-c6b6-64e6-c1f58d521504@redhat.com>
 <dc30a97b-853e-4d2a-b171-e68fb3ab026c@lucifer.local>
 <b6cb8d7f-f3f3-93c3-3ea0-4c184109a4db@redhat.com>
 <525a3f14-74fa-4c22-9fca-9dab4de8a0c3@lucifer.local>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <525a3f14-74fa-4c22-9fca-9dab4de8a0c3@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Hm good point, actually, now we're using the bounce buffer we don't need to
>>> avoid usermode hardening any more.
>>>
>>> However since we've established a bounce buffer ourselves its still
>>> appropriate to use _copy_to_iter() as we know the source region is good to
>>> copy from.
>>>
>>> To make life easy I'll just respin with an updated comment :)
>>
>> I'm not too picky this time, no need to resend if everybody else is fine :P
>>
> 
> Haha you know the classic Lorenzo respin spiral and want to avoid it I see ;)

Don't want to make your apparently stressful week more stressful. Not 
this time ;)

> 
> The comment is actually inaccurate now, so to avoid noise + make life easy
> (maybe) for Andrew here's a fix patch that just corrects the comment:-
> 
> ----8<----
> 
>  From d2b8fb271f21b79048e5630699133f77a93d0481 Mon Sep 17 00:00:00 2001
> From: Lorenzo Stoakes <lstoakes@gmail.com>
> Date: Tue, 1 Aug 2023 17:36:08 +0100
> Subject: [PATCH] fs/proc/kcore: correct comment
> 
> Correct comment to be strictly correct about reasoning.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>   fs/proc/kcore.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
> index 3bc689038232..23fc24d16b31 100644
> --- a/fs/proc/kcore.c
> +++ b/fs/proc/kcore.c
> @@ -568,8 +568,8 @@ static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
>   					goto out;
>   				}
>   			/*
> -			 * We use _copy_to_iter() to bypass usermode hardening
> -			 * which would otherwise prevent this operation.
> +			 * We know the bounce buffer is safe to copy from, so
> +			 * use _copy_to_iter() directly.
>   			 */
>   			} else if (_copy_to_iter(buf, tsz, iter) != tsz) {
>   				ret = -EFAULT;
> --
> 2.41.0
> 

Thanks!

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

