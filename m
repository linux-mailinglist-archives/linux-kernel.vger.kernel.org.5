Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2300C77290B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjHGPXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjHGPXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:23:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D423F10FD
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 08:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691421746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4h12AIk7L/c0oP7stLiuZR/eX5q/mQ5GkvzWyc7yNXg=;
        b=Dh5GTXVJWJz4/CCx/vJ07B2AGBl0xZ4Qwx6W/YQ7mxfckFDIJvy6u7mbfB3ss5wtjlh6ou
        zBgfcuvIHl+e016MWJoiNRI1YoYmheIuVQhdGVpzp7Mty3YOgGZ7pRJgOwXv+oigofHpiC
        VxfeUtiM7MMZXrxHRsFVgaoXDl69Hbw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-JV-xu71EOsKqSwAA8fO31w-1; Mon, 07 Aug 2023 11:22:25 -0400
X-MC-Unique: JV-xu71EOsKqSwAA8fO31w-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-317a84a3ebeso2399818f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 08:22:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691421744; x=1692026544;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4h12AIk7L/c0oP7stLiuZR/eX5q/mQ5GkvzWyc7yNXg=;
        b=gMwgFy/u2By8/jxccvLiBTp1TNs9YN6BL/7zhdgz+NUm9EzhVYMFedTVWLV5NZEih3
         mj1ezntvu7h5ZkQmelUDWmQ2VkmtzNCSE86b+kBvHSE71mLdnKwSz0sEkZJqca/Yp1v8
         u569dUKXCIPSL4IL2IKXhJnf9TLiXhozRlnTqpNa11Lbv2z73tfUsj4KYKJM2WvLnxNO
         8xgb/kIuPKyBCxjNmzwz6T+tgsJyU6LrYwOpEeFCmWuRhKzuvuNSM6rJYo/crU8S0096
         JnMo/0Na/FtSrvXaBbeH+RI0p5g5OM7ZNaSlu9JooEgHbmgya4c5U2PY2yI1Wb6mE0Wg
         WUiw==
X-Gm-Message-State: AOJu0YyDvTDl46x47spzsnCjkwX5g08OU18rZ57aQW7e0W1Z7xSXqkEe
        HTbB3KWbxe1QdDtYrUXNhRXModjiCCFkEyKSmSwsz/yb6eMvoOJeUMuk2Qt2PiJILsRrCzjfAgX
        K+VZLlxw2ih5r7x4pfLkeD9JQzr3E9Avm
X-Received: by 2002:a5d:660e:0:b0:317:e9d7:9387 with SMTP id n14-20020a5d660e000000b00317e9d79387mr2649704wru.25.1691421744158;
        Mon, 07 Aug 2023 08:22:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHT+CRJxwBtjETCZhueOO73oT3V/JAO1GgSXHBmBFiXNWByV4hMkGXVBufEggmc7Ta4sJA7ow==
X-Received: by 2002:a5d:660e:0:b0:317:e9d7:9387 with SMTP id n14-20020a5d660e000000b00317e9d79387mr2649685wru.25.1691421743773;
        Mon, 07 Aug 2023 08:22:23 -0700 (PDT)
Received: from ?IPV6:2003:cb:c740:5d00:5143:1cd2:a300:ceff? (p200300cbc7405d0051431cd2a300ceff.dip0.t-ipconnect.de. [2003:cb:c740:5d00:5143:1cd2:a300:ceff])
        by smtp.gmail.com with ESMTPSA id n12-20020adff08c000000b00317b5c8a4f1sm10743469wro.60.2023.08.07.08.22.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 08:22:23 -0700 (PDT)
Message-ID: <a90dcf9c-f1dd-3cbe-3e35-f86499985790@redhat.com>
Date:   Mon, 7 Aug 2023 17:22:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] mm: no need to export mm_kobj
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <2023080436-algebra-cabana-417d@gregkh>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <2023080436-algebra-cabana-417d@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.08.23 08:43, Greg Kroah-Hartman wrote:
> There are no modules using mm_kobj, so do not export it.
> 
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>   mm/mm_init.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index a1963c3322af..1c9d6f428906 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -154,7 +154,6 @@ early_param("mminit_loglevel", set_mminit_loglevel);
>   #endif /* CONFIG_DEBUG_MEMORY_INIT */
>   
>   struct kobject *mm_kobj;
> -EXPORT_SYMBOL_GPL(mm_kobj);
>   
>   #ifdef CONFIG_SMP
>   s32 vm_committed_as_batch = 32;

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

