Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3C17F6030
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 14:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345462AbjKWN1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 08:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345271AbjKWN1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 08:27:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2999D40
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 05:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700746064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XlCNcFS7+nGLr8i/szhMFxjsyTieH5TNHlOyuSvsHHk=;
        b=f7cYKaYOFAtFJXNOJPQArwUusntX1ZVVFaTmDDREg2scZ5CKjWpVSXtsdS2O1BEDjFaWPw
        yLNuQv/VzVggZqnGtboDbOPczk9iAcgjOXQ9Qp6+NQVeAkUllm8ex5dxc0yd3//vRWjj/1
        XwQ2ynPKHNCvccFYCG77YnWXXe0Yz1Q=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-LNixVYSgNR6zfKelwTaWZg-1; Thu,
 23 Nov 2023 08:27:38 -0500
X-MC-Unique: LNixVYSgNR6zfKelwTaWZg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 368F43C027B1;
        Thu, 23 Nov 2023 13:27:38 +0000 (UTC)
Received: from localhost (unknown [10.72.112.97])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AB1BD36E2;
        Thu, 23 Nov 2023 13:27:29 +0000 (UTC)
Date:   Thu, 23 Nov 2023 21:27:25 +0800
From:   Baoquan He <bhe@redhat.com>
To:     akpm@linux-foundation.org
Cc:     kexec@lists.infradead.org, x86@kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        takahiro.akashi@linaro.org
Subject: Re: [PATCH v2 1/2] resource: add walk_system_ram_res_rev()
Message-ID: <ZV9TPRw65TiCeXyS@MiWiFi-R3L-srv>
References: <20231114091658.228030-1-bhe@redhat.com>
 <20231114091658.228030-2-bhe@redhat.com>
 <ZVTA6z/06cLnWKUz@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVTA6z/06cLnWKUz@MiWiFi-R3L-srv>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 11/15/23 at 09:00pm, Baoquan He wrote:
> This function, being a variant of walk_system_ram_res() introduced in
> commit 8c86e70acead ("resource: provide new functions to walk through
> resources"), walks through a list of all the resources of System RAM
> in reversed order, i.e., from higher to lower.
> 
> It will be used in kexec_file code to load kernel, initrd etc when
> preparing kexec reboot.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
> v1->v2:
> - Use kvrealloc() to reallocate memory instead of kvcalloc(), this
>   simplifies code. Suggested by Andrew.
> 
>  include/linux/ioport.h |  3 +++
>  kernel/resource.c      | 57 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 60 insertions(+)

Gentle ping.

Could you pick this patchset into next tree so that it can be run on
testing robots?

Thanks
Baoquan

> 
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index 14f5cfabbbc8..db7fe25f3370 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -331,6 +331,9 @@ extern int
>  walk_system_ram_res(u64 start, u64 end, void *arg,
>  		    int (*func)(struct resource *, void *));
>  extern int
> +walk_system_ram_res_rev(u64 start, u64 end, void *arg,
> +			int (*func)(struct resource *, void *));
> +extern int
>  walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start, u64 end,
>  		    void *arg, int (*func)(struct resource *, void *));
>  
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 866ef3663a0b..e8a244300e5b 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -27,6 +27,8 @@
>  #include <linux/mount.h>
>  #include <linux/resource_ext.h>
>  #include <uapi/linux/magic.h>
> +#include <linux/string.h>
> +#include <linux/vmalloc.h>
>  #include <asm/io.h>
>  
>  
> @@ -429,6 +431,61 @@ int walk_system_ram_res(u64 start, u64 end, void *arg,
>  				     func);
>  }
>  
> +/*
> + * This function, being a variant of walk_system_ram_res(), calls the @func
> + * callback against all memory ranges of type System RAM which are marked as
> + * IORESOURCE_SYSTEM_RAM and IORESOUCE_BUSY in reversed order, i.e., from
> + * higher to lower.
> + */
> +int walk_system_ram_res_rev(u64 start, u64 end, void *arg,
> +				int (*func)(struct resource *, void *))
> +{
> +	struct resource res, *rams;
> +	int rams_size = 16, i;
> +	unsigned long flags;
> +	int ret = -1;
> +
> +	/* create a list */
> +	rams = kvcalloc(rams_size, sizeof(struct resource), GFP_KERNEL);
> +	if (!rams)
> +		return ret;
> +
> +	flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> +	i = 0;
> +	while ((start < end) &&
> +		(!find_next_iomem_res(start, end, flags, IORES_DESC_NONE, &res))) {
> +		if (i >= rams_size) {
> +			/* re-alloc */
> +			struct resource *rams_new;
> +
> +			rams_new = kvrealloc(rams, rams_size * sizeof(struct resource),
> +					     (rams_size + 16) * sizeof(struct resource),
> +					     GFP_KERNEL);
> +			if (!rams_new)
> +				goto out;
> +
> +			rams = rams_new;
> +			rams_size += 16;
> +		}
> +
> +		rams[i].start = res.start;
> +		rams[i++].end = res.end;
> +
> +		start = res.end + 1;
> +	}
> +
> +	/* go reverse */
> +	for (i--; i >= 0; i--) {
> +		ret = (*func)(&rams[i], arg);
> +		if (ret)
> +			break;
> +	}
> +
> +out:
> +	kvfree(rams);
> +	return ret;
> +}
> +
>  /*
>   * This function calls the @func callback against all memory ranges, which
>   * are ranges marked as IORESOURCE_MEM and IORESOUCE_BUSY.
> -- 
> 2.41.0
> 

