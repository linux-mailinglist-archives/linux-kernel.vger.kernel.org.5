Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341C97FE9E2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 08:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjK3Ho4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 02:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbjK3Hoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 02:44:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D964D6C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 23:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701330299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kFX81jkgr22XnPLJhetZKt46F/xnkz4cCCAQykO/SFc=;
        b=XyVIkhwzl+zGAxLTEjzT3p1UETgjn0DwdeHUjPXRBdq8z9LL0B8l041jaHQpG8IKBRxrQt
        zF8Y+L3tsVebLSKBiyyt+LeEV6PrXCOgIQEzpyUoV7Cg4l2jZxspr98E+v1/aScW1lG7Px
        hDefYpjQL15tdJh8lY3V9GOxiFTfDnA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-AHfMViECMDaF78Bs7fn4Uw-1; Thu, 30 Nov 2023 02:44:56 -0500
X-MC-Unique: AHfMViECMDaF78Bs7fn4Uw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD3E6185A781;
        Thu, 30 Nov 2023 07:44:55 +0000 (UTC)
Received: from localhost (unknown [10.72.113.121])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D7468C1596F;
        Thu, 30 Nov 2023 07:44:44 +0000 (UTC)
Date:   Thu, 30 Nov 2023 15:44:41 +0800
From:   Baoquan He <bhe@redhat.com>
To:     fuqiang wang <fuqiang.wang@easystack.cn>
Cc:     Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kexec: avoid out of bounds in crash_exclude_mem_range()
Message-ID: <ZWg9aZYoo0v+tCQ8@MiWiFi-R3L-srv>
References: <20231127025641.62210-1-fuqiang.wang@easystack.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127025641.62210-1-fuqiang.wang@easystack.cn>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/23 at 10:56am, fuqiang wang wrote:
> When the split happened, judge whether mem->nr_ranges is equal to
> mem->max_nr_ranges. If it is true, return -ENOMEM.
> 
> The advantage of doing this is that it can avoid array bounds caused by
> some bugs. E.g., Before commit 4831be702b95 ("arm64/kexec: Fix missing
> extra range for crashkres_low."), reserve both high and low memories for
> the crashkernel may cause out of bounds.
> 
> On the other hand, move this code before the split to ensure that the
> array will not be changed when return error.

If out of array boundary is caused, means the laoding failed, whether
the out of boundary happened or not. I don't see how this code change
makes sense. Do I miss anything?

Thanks
Baoquan

> 
> Signed-off-by: fuqiang wang <fuqiang.wang@easystack.cn>
> ---
>  kernel/crash_core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index efe87d501c8c..ffdc246cf425 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -611,6 +611,9 @@ int crash_exclude_mem_range(struct crash_mem *mem,
>  		}
>  
>  		if (p_start > start && p_end < end) {
> +			/* Split happened */
> +			if (mem->nr_ranges == mem->max_nr_ranges)
> +				return -ENOMEM;
>  			/* Split original range */
>  			mem->ranges[i].end = p_start - 1;
>  			temp_range.start = p_end + 1;
> @@ -626,9 +629,6 @@ int crash_exclude_mem_range(struct crash_mem *mem,
>  	if (!temp_range.end)
>  		return 0;
>  
> -	/* Split happened */
> -	if (i == mem->max_nr_ranges - 1)
> -		return -ENOMEM;
>  
>  	/* Location where new range should go */
>  	j = i + 1;
> -- 
> 2.42.0
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

