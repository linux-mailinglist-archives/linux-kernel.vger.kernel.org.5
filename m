Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CA2793680
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 09:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbjIFHnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 03:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbjIFHnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 03:43:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876D9C9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 00:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693986130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+fdt2EUxE/XfED3p5ykjjh9CCofBUEIYRSA1UtPAGb0=;
        b=Ahs0EJnJje/rds0Qcbx2vp8KPle87ahl2wL0PTHhM0CCBsv9VfXw8WH2MSA3rbI9I785a9
        FmvQW87qfZu+Lq5cCdLoNngivhDVJT4MRDXF9ez6VpfBtCiH9SQy5gWhqx0MdbufOgm2/+
        9GKg6h+gl0et7zlOPzB4upW9SK7NMCQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-u-YGNB29MHWu_gVhjw6qVQ-1; Wed, 06 Sep 2023 03:42:09 -0400
X-MC-Unique: u-YGNB29MHWu_gVhjw6qVQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-402ccac9b1eso16689475e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 00:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693986128; x=1694590928;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+fdt2EUxE/XfED3p5ykjjh9CCofBUEIYRSA1UtPAGb0=;
        b=dv5OoCNozHz6tDAbhH1et8IuDbDoMbBWW0OeSLNjGHzJr8YUq0BY+tPjLOz7BxqKaY
         KA6bTEDY6qzOrPaQF3RUvlmMtjVMIrUEI9iIGv7alklUJKK1K+cmGH5hx+rJj5EOX3WA
         JXKmEysCFVV9oGpRw3mBsbcw/WD4y3nvIiygHHrRfjGfttY9HuxXlL0laOXoUNZY6Ewv
         wWjUx4q4xPiwsYibe26kF0JtCJhPoaY5lf9WFob0zW1qIoYHhERWe7nQoXtKbEgpVkfb
         55I5E7YXaREUbzdNZmgxQsFUPHfHUNh49zh/a+FfvIM2F9NND8mihIyDf4qd1IOeAzqj
         sxBQ==
X-Gm-Message-State: AOJu0YzOdjxVc7xxTu2cbf/HCHUPoYbr8IJH7o0Ss+zrp5+IgxjAm3tv
        qOzE92i5ph8eKkMs9GbUUUvJ5rktnMl1uJBKC7s8RIdgy9IFLHlRPIGULBeebLYaZ5TfhrjAmxI
        47E1655sJ061LQ+qacwNaOXBO
X-Received: by 2002:a5d:4c85:0:b0:317:6175:95fd with SMTP id z5-20020a5d4c85000000b00317617595fdmr1525241wrs.43.1693986128243;
        Wed, 06 Sep 2023 00:42:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvSibvvGpwzY5qzxGX02NS0IXvcFXv3566YuLrAOdwq82jQKduvKnVxaQMANAxgZwqzHWdFA==
X-Received: by 2002:a5d:4c85:0:b0:317:6175:95fd with SMTP id z5-20020a5d4c85000000b00317617595fdmr1525226wrs.43.1693986127873;
        Wed, 06 Sep 2023 00:42:07 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70c:6c00:92a4:6f8:ff7e:6853? (p200300cbc70c6c0092a406f8ff7e6853.dip0.t-ipconnect.de. [2003:cb:c70c:6c00:92a4:6f8:ff7e:6853])
        by smtp.gmail.com with ESMTPSA id a2-20020adff7c2000000b003177074f830sm19620812wrq.59.2023.09.06.00.42.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 00:42:07 -0700 (PDT)
Message-ID: <d6012fe0-9d06-f5ac-857c-c38034bf0758@redhat.com>
Date:   Wed, 6 Sep 2023 09:42:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] LoongArch: add p?d_leaf() definitions
Content-Language: en-US
To:     Hongchen Zhang <zhanghongchen@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Mike Rapoport IBM)" <rppt@kernel.org>,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        "Matthew Wilcox Oracle)" <willy@infradead.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
References: <20230905064955.16316-1-zhanghongchen@loongson.cn>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230905064955.16316-1-zhanghongchen@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.09.23 08:49, Hongchen Zhang wrote:
> When I do LTP test, LTP test case ksm06 caused panic at
> 	break_ksm_pmd_entry
> 	  -> pmd_leaf (Huge page table but False)
> 	  -> pte_present (panic)
> 

Probably there are other problematic bits without that can trigger that? 
I suspect walk_page_range*() callers might be affected,

> The reason is pmd_leaf is not defined, So like
> commit 501b81046701 ("mips: mm: add p?d_leaf() definitions")
> add p?d_leaf() definition for LoongArch.
> 

We most certainly want to cc stable, no?

Can we come up with a Fixes: tag? Probably when we added THP support to 
loongarch.

> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
> ---
>   arch/loongarch/include/asm/pgtable.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
> index 370c6568ceb8..ea54653b7aab 100644
> --- a/arch/loongarch/include/asm/pgtable.h
> +++ b/arch/loongarch/include/asm/pgtable.h
> @@ -243,6 +243,9 @@ static inline void pmd_clear(pmd_t *pmdp)
>   
>   #define pmd_phys(pmd)		PHYSADDR(pmd_val(pmd))
>   
> +#define pmd_leaf(pmd)		((pmd_val(pmd) & _PAGE_HUGE) != 0)
> +#define pud_leaf(pud)		((pud_val(pud) & _PAGE_HUGE) != 0)
> +
>   #ifndef CONFIG_TRANSPARENT_HUGEPAGE
>   #define pmd_page(pmd)		(pfn_to_page(pmd_phys(pmd) >> PAGE_SHIFT))
>   #endif /* CONFIG_TRANSPARENT_HUGEPAGE  */

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

