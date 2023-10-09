Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBD47BED62
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 23:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378727AbjJIV31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 17:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378722AbjJIV3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 17:29:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B96B9C
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 14:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696886918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HbgTwu+Sc8hGI0EzdVEZj0VYB/A8KVFIZ5yH1IhJnR4=;
        b=VyJzdahf5baJ9Wag7tArIj0O88xM8kcgWsL5o2ir/hcnKjx3z74EUXpF49zlU4uv/D4J7z
        XMhQ2abjsoy7V6B77hUIu3ivTR/w1xeVgwFvua4ZSNangd3au9CblqQHTptXTUaiO+xWQX
        xUqnzFRJDVpb6PKEfjBFaT8ClbCsH38=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-YOq5ROwHPy2cvaSI7zMmjA-1; Mon, 09 Oct 2023 17:28:32 -0400
X-MC-Unique: YOq5ROwHPy2cvaSI7zMmjA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7742bab9c0cso520941985a.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 14:28:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696886911; x=1697491711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbgTwu+Sc8hGI0EzdVEZj0VYB/A8KVFIZ5yH1IhJnR4=;
        b=hUOJ6OasgpIn7e4Ex7j1jNJdj3YCPBMT/3Jd9nrFawV5mfQVPDoEwFm+PxE0LdFPo0
         OgL5HgF87YnQorQ/fZlLzzyXIWv1pkerGOqf3SLhtUOe+bPBItFCKX+nAaSrVXlW4SIn
         +0D9H+5VIfls3laQ8I4VS0alT6BR2J/ec3pO17lwt4WcY/G0iPjnAy6Ss5NUi/netU08
         zsBkJB+UdtukVRGz5/CtNwvA0tbCdnwErzqD9nO9G4RswUE0/kF/XVxgyFdzEAjn7Cx0
         q0N5Sxw/iD9eMOGfbEMHzkgyKLBBPp0rabgSugqmYxzq1u4esbgvjYvgFhYaztIXatGj
         +eTA==
X-Gm-Message-State: AOJu0YyxC/Ck/qYnIbRzng8datB0iw+YUjiR/qIptJsXZAkhOK4bgl+u
        dk9x0Lv7HxPhsNHcp07jlipUgMwCyYJpFPcQDNLEuPXPdLqc/p0Mc5IhEdkFj8Mn/6Ol0SYkbl1
        +0Xc+GqYR1opyAWLTsNH249fF
X-Received: by 2002:a05:620a:22b1:b0:76c:e5a2:444f with SMTP id p17-20020a05620a22b100b0076ce5a2444fmr13294070qkh.72.1696886911465;
        Mon, 09 Oct 2023 14:28:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkoRbuV0enbNnjYtdfo/pgK2wr/oh1oVx7ENJNu2d0aFBfln5GEmWPCa5XiSNiJa9ccN2PLQ==
X-Received: by 2002:a05:620a:22b1:b0:76c:e5a2:444f with SMTP id p17-20020a05620a22b100b0076ce5a2444fmr13294063qkh.72.1696886911094;
        Mon, 09 Oct 2023 14:28:31 -0700 (PDT)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id 2-20020a05620a078200b007742bc74184sm3792620qka.110.2023.10.09.14.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 14:28:30 -0700 (PDT)
Date:   Mon, 9 Oct 2023 16:28:28 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@quicinc.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3 04/15] firmware: qcom: add a dedicated TrustZone
 buffer allocator
Message-ID: <f6jspdoeyv6ntcrl6qndy2ud3mcdkoxxcnzqm3qpbtcd3ztdpi@7iw5f5og7is2>
References: <20231009153427.20951-1-brgl@bgdev.pl>
 <20231009153427.20951-5-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009153427.20951-5-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 05:34:16PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> We have several SCM calls that require passing buffers to the TrustZone
> on top of the SMC core which allocates memory for calls that require
> more than 4 arguments.
> 
> Currently every user does their own thing which leads to code
> duplication. Many users call dma_alloc_coherent() for every call which
> is terribly unperformant (speed- and size-wise).
> 
> Provide a set of library functions for creating and managing pool of
> memory which is suitable for sharing with the TrustZone, that is:
> page-aligned, contiguous and non-cachable as well as provides a way of
> mapping of kernel virtual addresses to physical space.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/firmware/qcom/Kconfig            |  19 ++
>  drivers/firmware/qcom/Makefile           |   1 +
>  drivers/firmware/qcom/qcom_tzmem.c       | 301 +++++++++++++++++++++++
>  drivers/firmware/qcom/qcom_tzmem.h       |  13 +
>  include/linux/firmware/qcom/qcom_tzmem.h |  28 +++
>  5 files changed, 362 insertions(+)
>  create mode 100644 drivers/firmware/qcom/qcom_tzmem.c
>  create mode 100644 drivers/firmware/qcom/qcom_tzmem.h
>  create mode 100644 include/linux/firmware/qcom/qcom_tzmem.h
> 
> diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
> index 3f05d9854ddf..b80269a28224 100644
> --- a/drivers/firmware/qcom/Kconfig
> +++ b/drivers/firmware/qcom/Kconfig
> @@ -9,6 +9,25 @@ menu "Qualcomm firmware drivers"
>  config QCOM_SCM
>  	tristate
>  
> +config QCOM_TZMEM
> +	tristate
> +
> +choice
> +	prompt "TrustZone interface memory allocator mode"
> +	default QCOM_TZMEM_MODE_DEFAULT
> +	help
> +	  Selects the mode of the memory allocator providing memory buffers of
> +	  suitable format for sharing with the TrustZone. If in doubt, select
> +	  'Default'.
> +
> +config QCOM_TZMEM_MODE_DEFAULT
> +	bool "Default"
> +	help
> +	  Use the default allocator mode. The memory is page-aligned, non-cachable
> +	  and contiguous.
> +
> +endchoice
> +
>  config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
>  	bool "Qualcomm download mode enabled by default"
>  	depends on QCOM_SCM
> diff --git a/drivers/firmware/qcom/Makefile b/drivers/firmware/qcom/Makefile
> index c9f12ee8224a..0be40a1abc13 100644
> --- a/drivers/firmware/qcom/Makefile
> +++ b/drivers/firmware/qcom/Makefile
> @@ -5,5 +5,6 @@
>  
>  obj-$(CONFIG_QCOM_SCM)		+= qcom-scm.o
>  qcom-scm-objs += qcom_scm.o qcom_scm-smc.o qcom_scm-legacy.o
> +obj-$(CONFIG_QCOM_TZMEM)	+= qcom_tzmem.o
>  obj-$(CONFIG_QCOM_QSEECOM)	+= qcom_qseecom.o
>  obj-$(CONFIG_QCOM_QSEECOM_UEFISECAPP) += qcom_qseecom_uefisecapp.o
> diff --git a/drivers/firmware/qcom/qcom_tzmem.c b/drivers/firmware/qcom/qcom_tzmem.c
> new file mode 100644
> index 000000000000..eee51fed756e
> --- /dev/null
> +++ b/drivers/firmware/qcom/qcom_tzmem.c
> @@ -0,0 +1,301 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Memory allocator for buffers shared with the TrustZone.
> + *
> + * Copyright (C) 2023 Linaro Ltd.
> + */
> +
> +#include <linux/bug.h>
> +#include <linux/cleanup.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/err.h>
> +#include <linux/firmware/qcom/qcom_tzmem.h>
> +#include <linux/genalloc.h>
> +#include <linux/gfp.h>
> +#include <linux/mm.h>
> +#include <linux/radix-tree.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
> +
> +#include "qcom_tzmem.h"
> +
> +struct qcom_tzmem_pool {
> +	void *vbase;
> +	phys_addr_t pbase;
> +	size_t size;
> +	struct gen_pool *pool;
> +	void *priv;
> +};
> +
> +struct qcom_tzmem_chunk {
> +	phys_addr_t paddr;
> +	size_t size;
> +	struct qcom_tzmem_pool *owner;
> +};
> +
> +static struct device *qcom_tzmem_dev;
> +static RADIX_TREE(qcom_tzmem_chunks, GFP_ATOMIC);
> +static DEFINE_SPINLOCK(qcom_tzmem_chunks_lock);
> +
> +#if IS_ENABLED(CONFIG_QCOM_TZMEM_MODE_DEFAULT)
> +
> +static int qcom_tzmem_init(void)
> +{
> +	return 0;
> +}
> +
> +static int qcom_tzmem_init_pool(struct qcom_tzmem_pool *pool)
> +{
> +	return 0;
> +}
> +
> +static void qcom_tzmem_cleanup_pool(struct qcom_tzmem_pool *pool)
> +{
> +
> +}
> +
> +#endif /* CONFIG_QCOM_TZMEM_MODE_DEFAULT */
> +
> +/**
> + * qcom_tzmem_pool_new() - Create a new TZ memory pool.
> + * @size - Size of the new pool in bytes.
> + *
> + * Create a new pool of memory suitable for sharing with the TrustZone.
> + *
> + * Must not be used in atomic context.
> + *
> + * Returns:
> + * New memory pool address or ERR_PTR() on error.
> + */
> +struct qcom_tzmem_pool *qcom_tzmem_pool_new(size_t size)
> +{
> +	struct qcom_tzmem_pool *pool;
> +	int ret = -ENOMEM;
> +
> +	if (!size)
> +		return ERR_PTR(-EINVAL);
> +
> +	size = PAGE_ALIGN(size);
> +
> +	pool = kzalloc(sizeof(*pool), GFP_KERNEL);
> +	if (!pool)
> +		return ERR_PTR(-ENOMEM);
> +
> +	pool->size = size;
> +
> +	pool->vbase = dma_alloc_coherent(qcom_tzmem_dev, size, &pool->pbase,
> +					 GFP_KERNEL);
> +	if (!pool->vbase)
> +		goto err_kfree_pool;
> +
> +	pool->pool = gen_pool_create(PAGE_SHIFT, -1);
> +	if (!pool)
> +		goto err_dma_free;
> +
> +	gen_pool_set_algo(pool->pool, gen_pool_best_fit, NULL);
> +
> +	ret = gen_pool_add_virt(pool->pool, (unsigned long)pool->vbase,
> +				pool->pbase, size, -1);
> +	if (ret)
> +		goto err_destroy_genpool;
> +
> +	ret = qcom_tzmem_init_pool(pool);
> +	if (ret)
> +		goto err_destroy_genpool;
> +
> +	return pool;
> +
> +err_destroy_genpool:
> +	gen_pool_destroy(pool->pool);
> +err_dma_free:
> +	dma_free_coherent(qcom_tzmem_dev, size, pool->vbase, pool->pbase);
> +err_kfree_pool:
> +	kfree(pool);
> +	return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL_GPL(qcom_tzmem_pool_new);
> +
> +/**
> + * qcom_tzmem_pool_free() - Destroy a TZ memory pool and free all resources.
> + * @pool: Memory pool to free.
> + *
> + * Must not be called if any of the allocated chunks has not been freed.
> + * Must not be used in atomic context.
> + */
> +void qcom_tzmem_pool_free(struct qcom_tzmem_pool *pool)
> +{
> +	struct qcom_tzmem_chunk *chunk;
> +	struct radix_tree_iter iter;
> +	bool non_empty = false;
> +	void **slot;
> +
> +	if (!pool)
> +		return;
> +
> +	qcom_tzmem_cleanup_pool(pool);
> +
> +	scoped_guard(spinlock_irqsave, &qcom_tzmem_chunks_lock) {
> +		radix_tree_for_each_slot(slot, &qcom_tzmem_chunks, &iter, 0) {
> +			chunk = *slot;
> +
> +			if (chunk->owner == pool)
> +				non_empty = true;
> +		}
> +	}
> +
> +	WARN(non_empty, "Freeing TZ memory pool with memory still allocated");
> +
> +	gen_pool_destroy(pool->pool);
> +	dma_free_coherent(qcom_tzmem_dev, pool->size, pool->vbase, pool->pbase);
> +	kfree(pool);
> +}
> +EXPORT_SYMBOL_GPL(qcom_tzmem_pool_free);

I got these warnings with this series:

    ahalaney@fedora ~/git/linux-next (git)-[7204cc6c3d73] % ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make W=1 C=2 drivers/firmware/qcom/
    drivers/firmware/qcom/qcom_tzmem.c:137: warning: Function parameter or member 'size' not described in 'qcom_tzmem_pool_new'
      CHECK   drivers/firmware/qcom/qcom_tzmem.c
    drivers/firmware/qcom/qcom_tzmem.c:204:17: warning: incorrect type in assignment (different address spaces)
    drivers/firmware/qcom/qcom_tzmem.c:204:17:    expected void **slot
    drivers/firmware/qcom/qcom_tzmem.c:204:17:    got void [noderef] __rcu **
    drivers/firmware/qcom/qcom_tzmem.c:204:17: warning: incorrect type in assignment (different address spaces)
    drivers/firmware/qcom/qcom_tzmem.c:204:17:    expected void **slot
    drivers/firmware/qcom/qcom_tzmem.c:204:17:    got void [noderef] __rcu **
    drivers/firmware/qcom/qcom_tzmem.c:204:17: warning: incorrect type in argument 1 (different address spaces)
    drivers/firmware/qcom/qcom_tzmem.c:204:17:    expected void [noderef] __rcu **slot
    drivers/firmware/qcom/qcom_tzmem.c:204:17:    got void **slot
    drivers/firmware/qcom/qcom_tzmem.c:204:17: warning: incorrect type in assignment (different address spaces)
    drivers/firmware/qcom/qcom_tzmem.c:204:17:    expected void **slot
    drivers/firmware/qcom/qcom_tzmem.c:204:17:    got void [noderef] __rcu **
    drivers/firmware/qcom/qcom_tzmem.c:339:13: warning: context imbalance in 'qcom_tzmem_to_phys' - wrong count at exit


All are confusing me, size seems described, I don't know much about
radix tree usage / rcu, and the locking in qcom_tzmem_to_phys seems sane
to me but I'm still grappling with the new syntax.

For the one address space one, I _think_ maybe a diff like this is in
order?

    diff --git a/drivers/firmware/qcom/qcom_tzmem.c b/drivers/firmware/qcom/qcom_tzmem.c
    index b3137844fe43..5b409615198d 100644
    --- a/drivers/firmware/qcom/qcom_tzmem.c
    +++ b/drivers/firmware/qcom/qcom_tzmem.c
    @@ -193,7 +193,7 @@ void qcom_tzmem_pool_free(struct qcom_tzmem_pool *pool)
            struct qcom_tzmem_chunk *chunk;
            struct radix_tree_iter iter;
            bool non_empty = false;
    -       void **slot;
    +       void __rcu **slot;
     
            if (!pool)
                    return;
    @@ -202,7 +202,7 @@ void qcom_tzmem_pool_free(struct qcom_tzmem_pool *pool)
     
            scoped_guard(spinlock_irqsave, &qcom_tzmem_chunks_lock) {
                    radix_tree_for_each_slot(slot, &qcom_tzmem_chunks, &iter, 0) {
    -                       chunk = *slot;
    +                       chunk = radix_tree_deref_slot_protected(slot, &qcom_tzmem_chunks_lock);
     
                            if (chunk->owner == pool)
                                    non_empty = true;


Still planning on reviewing/testing the rest, but got tripped up there
so thought I'd highlight it before doing the rest.

Thanks,
Andrew

