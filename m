Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B272777D169
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 19:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239003AbjHORyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 13:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239000AbjHORxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 13:53:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578A110F4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 10:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692121972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HVQ3sb9xVMcL/Jj/o9MHbLWoxuzHNOB7Lrqi8OAIuDg=;
        b=VsUbTZ+Kb4yJjSed2X8B6EaO8YzBQvtnVEiFoNpsspDVGogj5mY5oeeKVE+s0JQs4x6K0B
        T5o7R9ej2BC2dZlOWhFHLVnnDAj2NeOFA6wlU2kzTGk0Hw48V3nVfT/OCNy9reQAERB/Tn
        PAYQ4dk7zrDt4Z0f60b5xiWvlt8k0AM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-STPUdVTIPHam0pBYJ8nYWw-1; Tue, 15 Aug 2023 13:52:51 -0400
X-MC-Unique: STPUdVTIPHam0pBYJ8nYWw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fe919c0348so13796715e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 10:52:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692121970; x=1692726770;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HVQ3sb9xVMcL/Jj/o9MHbLWoxuzHNOB7Lrqi8OAIuDg=;
        b=Uq/mwF6K9BDdM3ZGypTZmckaK2CHvVKq67/WXlHlUyTr6W8vXsvW3P+wgBv4wqzbp9
         GzgXJnmjscXdRKrhf8yGd3XFY0AIiGUKXPfKWJXPtG2abCNtwRh+weJPyIZb9FElACrW
         SOzp2usu3/eUt+dMayDcNcScPX7n7ENJVAj3Vbsi3dgB8H9lo0BNIyxMFtlmAr1WQPTK
         B0YGIO1LziYCXC2lWQY3C/oKs7fMS889dl213s/ybdiXQ4OdcnDz93OhK4CsqBfFIshQ
         0jksCZtpFpSK2rMMBWaaJbP24iVEbv07ifuHQtuBhiOgoeDNsaA4l5iCEmg7mBtZAcgq
         OrzA==
X-Gm-Message-State: AOJu0YzBaaqugTGb12qq5XlLi3n00WYyLJJxcqTQH+Ov6LZFwtj8J9Vl
        JC5tDjhg6/U3yRB4P1L+FM0H3ZI4LhgRjXFTYbY2a5J4XGr81z0Oz1sMrjMGHntw0ddNBWkK8y/
        goMbDmTfHBJ5ujraTVG2Gtt6N
X-Received: by 2002:a05:600c:4444:b0:3fe:21f1:aba8 with SMTP id v4-20020a05600c444400b003fe21f1aba8mr2049390wmn.12.1692121969938;
        Tue, 15 Aug 2023 10:52:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGwOSu+t9TGNZbyeOtEGVbD6aZZJCbyTZyAsgHlDRI/h/8rHIpPiY8Ko2pF8wnkyhG30kILA==
X-Received: by 2002:a05:600c:4444:b0:3fe:21f1:aba8 with SMTP id v4-20020a05600c444400b003fe21f1aba8mr2049371wmn.12.1692121969574;
        Tue, 15 Aug 2023 10:52:49 -0700 (PDT)
Received: from ?IPV6:2003:cb:c701:3100:c642:ba83:8c37:b0e? (p200300cbc7013100c642ba838c370b0e.dip0.t-ipconnect.de. [2003:cb:c701:3100:c642:ba83:8c37:b0e])
        by smtp.gmail.com with ESMTPSA id f14-20020adffcce000000b00317a04131c5sm18593268wrs.57.2023.08.15.10.52.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 10:52:49 -0700 (PDT)
Message-ID: <ea0a401d-3144-22f8-eae0-c962f9fbe0e4@redhat.com>
Date:   Tue, 15 Aug 2023 19:52:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] mm,thp: fix nodeN/meminfo output alignment
Content-Language: en-US
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <dc264fd6-40bb-6510-db36-9340a5f01d94@google.com>
 <be861b50-a790-e041-bcb0-2a987dcfd1a@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <be861b50-a790-e041-bcb0-2a987dcfd1a@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.08.23 22:01, Hugh Dickins wrote:
> Add one more space to FileHugePages and FilePmdMapped, so the output
> is aligned with other rows in /sys/devices/system/node/nodeN/meminfo.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>   drivers/base/node.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 9de524e56307..8e871ba9162f 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -446,8 +446,8 @@ static ssize_t node_read_meminfo(struct device *dev,
>   			     "Node %d AnonHugePages:  %8lu kB\n"
>   			     "Node %d ShmemHugePages: %8lu kB\n"
>   			     "Node %d ShmemPmdMapped: %8lu kB\n"
> -			     "Node %d FileHugePages: %8lu kB\n"
> -			     "Node %d FilePmdMapped: %8lu kB\n"
> +			     "Node %d FileHugePages:  %8lu kB\n"
> +			     "Node %d FilePmdMapped:  %8lu kB\n"
>   #endif
>   #ifdef CONFIG_UNACCEPTED_MEMORY
>   			     "Node %d Unaccepted:     %8lu kB\n"

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

