Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7797BB6E8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 13:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjJFLro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 07:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbjJFLrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:47:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677DFD6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 04:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696592813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VwDEmV5KmlrQfqzDjIwSSkU9hP9njGS1sXV+Vn+3c1c=;
        b=b6GGyoOt15IJe07LOitZiZKo6bYhTMU5HjXEYMtN6/pLGbOYvweI7/87YZlqngqzkWVCs7
        gFW9k8J/7dQeAd1IxVnYG+K5qY3xg4HJpQq3aNEsWzf7/Nyp2Tdv0od7iS3l/b9MdOirpN
        xqRkAMEL1AAWTUjmTGJTuhE4ll9wpUI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-Lkcj0xtxPAKJgKVW6fa_ag-1; Fri, 06 Oct 2023 07:46:52 -0400
X-MC-Unique: Lkcj0xtxPAKJgKVW6fa_ag-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4065d52a83aso13330445e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 04:46:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696592811; x=1697197611;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VwDEmV5KmlrQfqzDjIwSSkU9hP9njGS1sXV+Vn+3c1c=;
        b=BXigJVEPiRazyFH1rKy/lmaxoiPcTcm0rglkH6rBBA+VlZFaCxsLBPykMmQklrjKXR
         6tnRVYkbaQfUfyLWwa7xtAdiJwpZohgJ08uT3CGE4qUMvY4/YE7wEZi4sqBBXVnfX45M
         L7cMML4RLbCjBlEeT13cFl4ixDj4jsLKgD90X3Ne9XzWh6RP4Sq85X7ktR14knvVpsy8
         QhcrYsQaUHbBZUi+050mVctMzCgRAIXMwEprR8gwbAvP5L7VAwLt4aeQvQ2o8xfJu7Ii
         cImjdT5CEKceeOGmwtrwQpJ4rkMcc75g6H8MbQ6blNwZLG8+ZybQCaWfdKubODg/9Yba
         bNpQ==
X-Gm-Message-State: AOJu0YycuyXu6/RHdek3c/VuIxsjRmjsWdt1Q3R0m0oR8C9qFdsr5vof
        4omNlMV9on7YTqcQ5NiDPFop4myY63JPFFyecgoZmT1ub10QY8g62mgxeF4LQLFZemmKS/mHCBJ
        Lu7TbvIUhQEBZfi4wDmOJIQhm
X-Received: by 2002:a7b:ce09:0:b0:403:b86:f624 with SMTP id m9-20020a7bce09000000b004030b86f624mr7031284wmc.23.1696592810991;
        Fri, 06 Oct 2023 04:46:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeWk54tr1wiv5GwuvQWHMPw0Y03qDFvwApFRsFR7lU48zNkAY/GeJWmUBy1XHBBKOsjNWh+Q==
X-Received: by 2002:a7b:ce09:0:b0:403:b86:f624 with SMTP id m9-20020a7bce09000000b004030b86f624mr7031262wmc.23.1696592810361;
        Fri, 06 Oct 2023 04:46:50 -0700 (PDT)
Received: from ?IPV6:2003:cb:c715:ee00:4e24:cf8e:3de0:8819? (p200300cbc715ee004e24cf8e3de08819.dip0.t-ipconnect.de. [2003:cb:c715:ee00:4e24:cf8e:3de0:8819])
        by smtp.gmail.com with ESMTPSA id 6-20020a05600c22c600b0040303a9965asm5835228wmg.40.2023.10.06.04.46.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 04:46:49 -0700 (PDT)
Message-ID: <6fa290a6-0e1b-856e-cda0-2e99de6de53f@redhat.com>
Date:   Fri, 6 Oct 2023 13:46:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] mm/memory-hotplug: fix typo in documentation
Content-Language: en-US
To:     Amos Wenger <amos@bearcove.net>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:MEMORY HOT(UN)PLUG" <linux-mm@kvack.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20231006112636.97128-1-amos@bearcove.net>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20231006112636.97128-1-amos@bearcove.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.10.23 13:26, Amos Wenger wrote:
> I'm 90% sure memory hotunplugging doesn't involve a "fist" phase

:D Thanks!

Reviewed-by: David Hildenbrand <david@redhat.com>

> 
> Signed-off-by: Amos Wenger <amos@bearcove.net>
> ---
>   Documentation/admin-guide/mm/memory-hotplug.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
> index cfe034cf1e87..fbf2c22f890d 100644
> --- a/Documentation/admin-guide/mm/memory-hotplug.rst
> +++ b/Documentation/admin-guide/mm/memory-hotplug.rst
> @@ -75,7 +75,7 @@ Memory hotunplug consists of two phases:
>   (1) Offlining memory blocks
>   (2) Removing the memory from Linux
>   
> -In the fist phase, memory is "hidden" from the page allocator again, for
> +In the first phase, memory is "hidden" from the page allocator again, for
>   example, by migrating busy memory to other memory locations and removing all
>   relevant free pages from the page allocator After this phase, the memory is no
>   longer visible in memory statistics of the system.

-- 
Cheers,

David / dhildenb

