Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A1D760E08
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbjGYJKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbjGYJKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:10:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94280FD
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 02:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690276187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3q/xBZbb8dNJd9KUqNimqM/jz1gI+oQ8PYpYvQS8xzU=;
        b=IdZljzV89I1lSCerkZaYxXvZYj6OkaMkihIqbVkYKYj2pXAgtT9iD7BLyVoVVFnFn7gP1p
        D0Onn/P7y2CNXfVEA4bOfWzEYCnDmbD4UwUuLnroTVjc31NTD7gjQt9zhQtq0Jsiiv5qwT
        HAubPnRoUb8To9IrSk/1CR/tSvqe6Aw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-DxcsshbhNIC5ym-ncxc87g-1; Tue, 25 Jul 2023 05:09:45 -0400
X-MC-Unique: DxcsshbhNIC5ym-ncxc87g-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-315998d6e7fso2494147f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 02:09:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690276184; x=1690880984;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3q/xBZbb8dNJd9KUqNimqM/jz1gI+oQ8PYpYvQS8xzU=;
        b=ZrnulNrWTl+iRYH8gegP8WnkgldlTxDnTTHOvYaR07eEfOORNHAXrcdVZ+p3rVjEij
         tt5Jtw7rqtRfvXyYSPgwmb/9HeJewlRFGMbZZir56YoFd8ORe920kpTJ7wJN4tiXtNsF
         LoejoSBX798/dA4XGK/aoQ2PADd26vpyWU6XFDVApnoazxZsisfntIKJ8DartwcFuIWi
         /yKPCCwGkF31DFvVFFTq67ie0ITok0VezdcCEtU5rHKl96epYcqSIk/39IsnlGNtqPFg
         BDBiZbg9T+1pWGrtBk4LlD1b5ODzXgZCgnnyYISeVQieM/QImQyBbm0WA03os0f2dmI1
         vQmg==
X-Gm-Message-State: ABy/qLaN4381nfslSfB4BVDi/Tsvd60VxfSLG+3l33vCkb0vjHAo8C1b
        5w61cCR7LDLbYzJDRpSMF0fahQBWzHQpMJNjlftrYXDO/cXAjeZ5s/Mhzff3ymewHIKiPjQN7mH
        hFDtXHrZk2ZezfwMuwhVdWUqT
X-Received: by 2002:a05:6000:11d2:b0:317:6189:fe7a with SMTP id i18-20020a05600011d200b003176189fe7amr2929540wrx.58.1690276184632;
        Tue, 25 Jul 2023 02:09:44 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHJhKb7Na5u7xDM7XxCVQynmdPLcEhJmCjHzDLFndkhKf7ubBFimSpfzjh7MV3QAw8D9D7c8A==
X-Received: by 2002:a05:6000:11d2:b0:317:6189:fe7a with SMTP id i18-20020a05600011d200b003176189fe7amr2929526wrx.58.1690276184192;
        Tue, 25 Jul 2023 02:09:44 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73f:e900:3b0d:87a6:2953:20d1? (p200300cbc73fe9003b0d87a6295320d1.dip0.t-ipconnect.de. [2003:cb:c73f:e900:3b0d:87a6:2953:20d1])
        by smtp.gmail.com with ESMTPSA id m9-20020a5d56c9000000b00313e2abfb8dsm15804076wrw.92.2023.07.25.02.09.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 02:09:43 -0700 (PDT)
Message-ID: <d80ed0b8-c92a-f76a-6ed9-b844d58c0d14@redhat.com>
Date:   Tue, 25 Jul 2023 11:09:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] docs: mm: Fix number of base pages for 1GB HugeTLB
Content-Language: en-US
To:     Usama Arif <usama.arif@bytedance.com>, songmuchun@bytedance.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, fam.zheng@bytedance.com,
        liangma@liangbit.com
References: <20230207114456.2304801-1-usama.arif@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230207114456.2304801-1-usama.arif@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.02.23 12:44, Usama Arif wrote:
> 1GB HugeTLB page consists of 262144 base pages.
> 
> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
> ---
>   Documentation/mm/vmemmap_dedup.rst | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/mm/vmemmap_dedup.rst b/Documentation/mm/vmemmap_dedup.rst
> index a4b12ff906c4..689a6907c70b 100644
> --- a/Documentation/mm/vmemmap_dedup.rst
> +++ b/Documentation/mm/vmemmap_dedup.rst
> @@ -1,3 +1,4 @@
> +
>   .. SPDX-License-Identifier: GPL-2.0
>   
>   =========================================
> @@ -17,7 +18,7 @@ HugeTLB pages consist of multiple base page size pages and is supported by many
>   architectures. See Documentation/admin-guide/mm/hugetlbpage.rst for more
>   details. On the x86-64 architecture, HugeTLB pages of size 2MB and 1GB are
>   currently supported. Since the base page size on x86 is 4KB, a 2MB HugeTLB page
> -consists of 512 base pages and a 1GB HugeTLB page consists of 4096 base pages.
> +consists of 512 base pages and a 1GB HugeTLB page consists of 262144 base pages.
>   For each base page, there is a corresponding ``struct page``.
>   
>   Within the HugeTLB subsystem, only the first 4 ``struct page`` are used to

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

