Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C03D7BB773
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 14:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbjJFMSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 08:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbjJFMSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 08:18:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAE7C6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 05:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696594660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nY32HOXDW72xqZGyg5omYJ0OlwQ+V+TteU8t+7CEEA0=;
        b=hdwqeB/QWF6GhzWgISN6R16AdAwqHQ8Etxv77NIaS0rNMr2514U4vgmpw71hX8ay3eDy3+
        6Iyp7M7+XE/MDfa+lNM1MnlosXUMjUFd6+Xr+e/3HZv4iQgteVQ+tD+hQ8llKStTeiiav0
        irz/mAUn9GrSyDfiiEXjNU2CTouOwnw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-2-CE33WPNpiZ73P1kUZMRg-1; Fri, 06 Oct 2023 08:17:33 -0400
X-MC-Unique: 2-CE33WPNpiZ73P1kUZMRg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-32320b9d671so1509516f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 05:17:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696594652; x=1697199452;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nY32HOXDW72xqZGyg5omYJ0OlwQ+V+TteU8t+7CEEA0=;
        b=X1+6YqpswJLzvtSV24zmW31k6CiG2ijY7wIoc2e9m24CgTN4aiBIDzTvTuYl4NF1Uv
         PalonqrFJdj/l8CXv64ENujr5XBfvF0yBceF47oMiJnWjYMTaeh3lmNDhn16MjnFfrRl
         VG4JMhh7KdURkQQDvG9IoOivqOjWP25Crbqk5i/DhCBhXZnDy6CwLT4ekGE7uXrqnWvk
         LCLlMdLTj4fuk8ZBJC/TDsVyoYRu0iFdzxqm2ZDzuueN70pXJEZpB8m1ImCes0WGD0Nm
         K23u1tztJvUaG0dGmWsEeDWDHPvib9w0CVO+D+Lx893i3QwGPY6p0iEt5w2ApL+rZGur
         hH7A==
X-Gm-Message-State: AOJu0YyM60N4zrhr04Kaaj9Li1wcDz1f9JT/gywPArM/CFVoSw9Jv8Gu
        GxgnMvPCG3EKz5UbwHUtt3vLd0oFidkb3OHFyBf8zpVDVYPowB/ptAiZ53/vV1wdnh9cdppVixD
        QM8RXYbkcCQ63x9Jecd1R3FpH
X-Received: by 2002:adf:ec10:0:b0:325:a6b3:3ac1 with SMTP id x16-20020adfec10000000b00325a6b33ac1mr6486787wrn.50.1696594652564;
        Fri, 06 Oct 2023 05:17:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGRntRrPY9GmO3FVeedgGXy/N0I5nEMB+yud+wj6tOcHwIcBugpKONeRHB1d+USAEF0MJ0EQ==
X-Received: by 2002:adf:ec10:0:b0:325:a6b3:3ac1 with SMTP id x16-20020adfec10000000b00325a6b33ac1mr6486763wrn.50.1696594652095;
        Fri, 06 Oct 2023 05:17:32 -0700 (PDT)
Received: from ?IPV6:2003:cb:c715:ee00:4e24:cf8e:3de0:8819? (p200300cbc715ee004e24cf8e3de08819.dip0.t-ipconnect.de. [2003:cb:c715:ee00:4e24:cf8e:3de0:8819])
        by smtp.gmail.com with ESMTPSA id q14-20020a5d574e000000b0031aef72a021sm1539424wrw.86.2023.10.06.05.17.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 05:17:31 -0700 (PDT)
Message-ID: <ed5764f4-aeb9-7b45-94ca-f553a231618e@redhat.com>
Date:   Fri, 6 Oct 2023 14:17:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] mm: rmap.c: fix kenrel-doc warning
Content-Language: en-US
To:     Muzammil <m.muzzammilashraf@gmail.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20231006113948.51673-1-muzammil@dreambigsemi.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20231006113948.51673-1-muzammil@dreambigsemi.com>
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

On 06.10.23 13:39, Muzammil wrote:
> From: Muhammad Muzammil <m.muzzammilashraf@gmail.com>
> 
> after running make htmldocs, getting this warning
> warning: Function parameter or member 'folio' not described in
> 'folio_move_anon_rmap'
> and this patch resolves this warning
> 
> Signed-off-by: Muhammad Muzammil <m.muzzammilashraf@gmail.com>
> ---
>   mm/rmap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index c1f11c9dbe61..0863083b3472 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1129,7 +1129,7 @@ int folio_total_mapcount(struct folio *folio)
>   
>   /**
>    * folio_move_anon_rmap - move a folio to our anon_vma
> - * @page:	The folio to move to our anon_vma
> + * @folio:  struct folio - Represents a contiguous set of bytes.
>    * @vma:	The vma the folio belongs to
>    *
>    * When a folio belongs exclusively to one process after a COW event,

Thanks for taking care of that, I had to handle a family NMI the last 
couple of days.

That should be squashed into my commit.

-- 
Cheers,

David / dhildenb

