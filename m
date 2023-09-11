Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C9579A510
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 09:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbjIKHxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 03:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234122AbjIKHwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 03:52:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2733FFA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 00:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694418724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lo9kYBjcwcg+Bla6VGzlFJ7YdU16409moEvZnL5aPOs=;
        b=gOShqcza/FmmznebLzHIMEl5fiHa5WP8w/XYAI033eBvAHkDiC6tD8J/DIM4Ajxbm1btLL
        xfmeLGyCOWkQNTGToGlRduFp7cw7Yu+BiZQu/oBuTnpKwPAjaWLtblK8z5tK8RLfyIrSdB
        v+DjfIBbfMO4Bs9ed1X5kY9tUunjGtw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-xFSAOZBJNQioQWFRVjNn9g-1; Mon, 11 Sep 2023 03:52:02 -0400
X-MC-Unique: xFSAOZBJNQioQWFRVjNn9g-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fbdf341934so32220665e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 00:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694418721; x=1695023521;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lo9kYBjcwcg+Bla6VGzlFJ7YdU16409moEvZnL5aPOs=;
        b=jTeYlFbFCWqPDhvOGiAIc3R4FBSRKVButIL46DQ1ZMkiEeAGRzSmPWwveV/woOHkxs
         yH6Sd+ZN7d8X61siBxTBj2DtVuNoYB+X0cWaDRaJD1MzoybRkgAgr+GZtHNtZ2xzPacr
         EKkqp6kiuAT46xAYXzavsxxl4lNfG7s7xCO8KKxbGPz+hxJ1TlEId0wsSbQRGSFkblgl
         U+eZvq7sFvjJUEP9BzLPaRsS4Z/rW26NH5DrCP4+4MvWt2jILhXCDtscHASfawdhXFym
         z7JFTOCcASNrUPI8jjCZatFST0/94hOHZW6xA0mj+Hx852kk8JDtdYFQI3mafoRuIkWa
         AucQ==
X-Gm-Message-State: AOJu0YwwFGqlQTPY8tKCCzI0jaR4yehCNE6ZSd+CvkuJKk2tW263umWR
        hOV/EG5UB6isuRBr0Lk35U1EeGHd91Wa+cRb8NXYli5Hnqv46UhKm5FG6OzdwMf0Wp8WXxMxprp
        eb/12wbXAkP4wNsJMSwc6zEYA
X-Received: by 2002:adf:e588:0:b0:317:6edb:6138 with SMTP id l8-20020adfe588000000b003176edb6138mr8529462wrm.62.1694418721173;
        Mon, 11 Sep 2023 00:52:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFu4smCOXh0ckAScKZWq5ZVlJNUH98a/3xcVhXZs5uFbXyEKKZKRW0Nm8vAmbIPCHmr5lkBWQ==
X-Received: by 2002:adf:e588:0:b0:317:6edb:6138 with SMTP id l8-20020adfe588000000b003176edb6138mr8529453wrm.62.1694418720807;
        Mon, 11 Sep 2023 00:52:00 -0700 (PDT)
Received: from ?IPV6:2003:cb:c743:5500:a9bd:94ab:74e9:782f? (p200300cbc7435500a9bd94ab74e9782f.dip0.t-ipconnect.de. [2003:cb:c743:5500:a9bd:94ab:74e9:782f])
        by smtp.gmail.com with ESMTPSA id r18-20020a5d6952000000b003141a3c4353sm9348450wrw.30.2023.09.11.00.51.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 00:52:00 -0700 (PDT)
Message-ID: <85a25d3b-c37d-9255-1fe2-19917a81f1ef@redhat.com>
Date:   Mon, 11 Sep 2023 09:51:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] mm/mm_init.c: remove redundant pr_info when node is
 memoryless
Content-Language: en-US
To:     Yajun Deng <yajun.deng@linux.dev>, rppt@kernel.org,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230906091113.4029983-1-yajun.deng@linux.dev>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230906091113.4029983-1-yajun.deng@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.09.23 11:11, Yajun Deng wrote:
> There is a similar pr_info in free_area_init_node(), so remove the
> redundant pr_info.
> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
>   mm/mm_init.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 50f2f34745af..6be6f50813b1 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1871,8 +1871,6 @@ void __init free_area_init(unsigned long *max_zone_pfn)
>   		pg_data_t *pgdat;
>   
>   		if (!node_online(nid)) {
> -			pr_info("Initializing node %d as memoryless\n", nid);
> -
>   			/* Allocator not initialized yet */
>   			pgdat = arch_alloc_nodedata(nid);
>   			if (!pgdat)


Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

