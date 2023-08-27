Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28745789BA3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 09:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjH0HDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 03:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjH0HDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 03:03:14 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF4B120;
        Sun, 27 Aug 2023 00:03:11 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3ff1c397405so21411035e9.3;
        Sun, 27 Aug 2023 00:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693119790; x=1693724590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iV4y6Ekr4RdgR6lmtQFo/ijea7yN94G6IUPIKArMQeo=;
        b=aACccfRCQED+gEg5zgxIiU7QAEIC55kXPx7Wq+ly1RTG3eDM9+sY7LDLKttu4jWTDO
         BG3Q0X8lqtUOHRwalmdrIZJfbF4PxLaf43Gry65I1taVZrmHZEXTVasrG9D/ju4GT+HO
         wtaAlIjVfrN/3MNP+EDe60ffiI6rfNHF9hHdDKx8zMycIHs0Bn9LtSVmuUlct0jsQB+H
         Jt/YHDt2KPys0FmrcBQmlRKEE1xcyVM6qpm+zmU/DhqJ4EKTRB1T9mbmMTL8G3ftfse/
         vGv47KjTZJliP0ng65T2TFpaFlH4j4fOM4KzSuWoBRh/Bom4XR2md0HUhrPI25Tu8Rgx
         3PLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693119790; x=1693724590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iV4y6Ekr4RdgR6lmtQFo/ijea7yN94G6IUPIKArMQeo=;
        b=N0HKz/DOtWKa4ZXpboUKwro7q0xk+WwdKE/isRcUI0A4XWJUWuRZDtZXAzlI6drFWg
         ZCiFIf2pUUMQcNy1uJ9nduKfVOT9Ki//0QpetD8n41kHZn7ZRJS7nkIqJCfio8ZrP/Gd
         1KzrUN589jnjp+llUA3UVuA4/dHrBDa0Qyd5f9WUk7mVDSzrYLRG6006UW1otev0QENe
         7NwsvbGpVO93w27K/eKxoeB/zleue/Z7qFBrlhg5gRLj+kMXfNfPSDoT5Ogpoyaolb7/
         mBOxypQsgCC6xasAwB5hrbWIPxa/ewdTOjV2oCEQqZrAWzNsIN7EjPOiV06Ab9AgTnbw
         AHcg==
X-Gm-Message-State: AOJu0Yzyz7pRQpzHVPwiAahZESeBC3jUvMg5fNluZawFLRdc13gHbKfU
        28eVxNvyiDKsm4ih4z2l77FaaRJA/O4=
X-Google-Smtp-Source: AGHT+IGz+nVEO6yAgt+pwnoQroxvPEu952BYqy05z1Y13fu9bXL3/S9IWFw8xdDSRLj+4J5oK/AhIQ==
X-Received: by 2002:a05:600c:2191:b0:401:c075:d5b with SMTP id e17-20020a05600c219100b00401c0750d5bmr2277572wme.26.1693119789550;
        Sun, 27 Aug 2023 00:03:09 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id t15-20020a7bc3cf000000b004013797efb6sm9867605wmj.9.2023.08.27.00.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 00:03:08 -0700 (PDT)
Date:   Sun, 27 Aug 2023 08:03:07 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Add vmalloc_user_node()
Message-ID: <9e369ffd-8577-4416-83eb-35c25ca4f838@lucifer.local>
References: <20230820194031.1395870-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230820194031.1395870-1-willy@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2023 at 08:40:31PM +0100, Matthew Wilcox (Oracle) wrote:
> Allow memory to be allocated on a specified node.  Use it in the
> perf ring-buffer code.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
> I was looking at the perf ringbuffer code for other reasons, and I noticed
> that everything else gets allocated on the specified node ... except
> there's no way to do this for vmalloc.  I assume it'd be helpful here too.
>
>  include/linux/vmalloc.h     | 17 ++++++++++++++++-
>  kernel/events/ring_buffer.c |  2 +-
>  mm/vmalloc.c                |  9 +++++----
>  3 files changed, 22 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index c720be70c8dd..030bfe1a60ab 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -6,6 +6,7 @@
>  #include <linux/init.h>
>  #include <linux/list.h>
>  #include <linux/llist.h>
> +#include <linux/numa.h>
>  #include <asm/page.h>		/* pgprot_t */
>  #include <linux/rbtree.h>
>  #include <linux/overflow.h>
> @@ -139,7 +140,7 @@ static inline unsigned long vmalloc_nr_pages(void) { return 0; }
>
>  extern void *vmalloc(unsigned long size) __alloc_size(1);
>  extern void *vzalloc(unsigned long size) __alloc_size(1);
> -extern void *vmalloc_user(unsigned long size) __alloc_size(1);
> +extern void *vmalloc_user_node(unsigned long size, int node) __alloc_size(1);
>  extern void *vmalloc_node(unsigned long size, int node) __alloc_size(1);
>  extern void *vzalloc_node(unsigned long size, int node) __alloc_size(1);
>  extern void *vmalloc_32(unsigned long size) __alloc_size(1);
> @@ -158,6 +159,20 @@ extern void *vmalloc_array(size_t n, size_t size) __alloc_size(1, 2);
>  extern void *__vcalloc(size_t n, size_t size, gfp_t flags) __alloc_size(1, 2);
>  extern void *vcalloc(size_t n, size_t size) __alloc_size(1, 2);
>
> +/**
> + * vmalloc_user - allocate zeroed virtually contiguous memory for userspace
> + * @size: allocation size
> + *
> + * The resulting memory area is zeroed so it can be mapped to userspace
> + * without leaking data.
> + *
> + * Return: pointer to the allocated memory or %NULL on error
> + */
> +static inline void *vmalloc_user(size_t size)
> +{
> +	return vmalloc_user_node(size, NUMA_NO_NODE);
> +}
> +
>  extern void vfree(const void *addr);
>  extern void vfree_atomic(const void *addr);
>
> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> index cc90d5299005..c73add132618 100644
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -918,7 +918,7 @@ struct perf_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
>
>  	INIT_WORK(&rb->work, rb_free_work);
>
> -	all_buf = vmalloc_user((nr_pages + 1) * PAGE_SIZE);
> +	all_buf = vmalloc_user_node((nr_pages + 1) * PAGE_SIZE, node);
>  	if (!all_buf)
>  		goto fail_all_buf;
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 228a4a5312f2..3616bfe4348f 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3461,22 +3461,23 @@ void *vzalloc(unsigned long size)
>  EXPORT_SYMBOL(vzalloc);
>
>  /**
> - * vmalloc_user - allocate zeroed virtually contiguous memory for userspace
> + * vmalloc_user_node - allocate zeroed virtually contiguous memory for userspace
>   * @size: allocation size
> + * @node: NUMA node
>   *
>   * The resulting memory area is zeroed so it can be mapped to userspace
>   * without leaking data.
>   *
>   * Return: pointer to the allocated memory or %NULL on error
>   */
> -void *vmalloc_user(unsigned long size)
> +void *vmalloc_user_node(unsigned long size, int node)
>  {
>  	return __vmalloc_node_range(size, SHMLBA,  VMALLOC_START, VMALLOC_END,
>  				    GFP_KERNEL | __GFP_ZERO, PAGE_KERNEL,
> -				    VM_USERMAP, NUMA_NO_NODE,
> +				    VM_USERMAP, node,
>  				    __builtin_return_address(0));
>  }
> -EXPORT_SYMBOL(vmalloc_user);
> +EXPORT_SYMBOL(vmalloc_user_node);
>
>  /**
>   * vmalloc_node - allocate memory on a specific node
> --
> 2.40.1
>

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
