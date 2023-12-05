Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3902804302
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 01:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343606AbjLEABU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 19:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343604AbjLEABR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 19:01:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7253810F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 16:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701734481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OlbvQ38xyZhR1pva7q+q80Q02GqbyPEePCP4ft47vxs=;
        b=Nvv2ZLkldN//nfuqGPfhEW3Ya8LdsTWvRrUIQ3cd6g9Nzhph4MLmqyvhi2coHtRcvcEqcE
        Jj+jt2065FzRQiSU1mfCt832t9uCWIVCNlq/Urjr18eibr4Br0SXc/malDioGkRlOXhHW0
        ZbvLZ7rWCKAK6v7L5/gTEP5invcU7+s=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-WSAa2u0RPVCJRA7obutnQg-1; Mon, 04 Dec 2023 19:01:19 -0500
X-MC-Unique: WSAa2u0RPVCJRA7obutnQg-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7ad60469181so342502539f.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 16:01:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701734478; x=1702339278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OlbvQ38xyZhR1pva7q+q80Q02GqbyPEePCP4ft47vxs=;
        b=H14UlpXHbCKQbsuKYgswXfLvn6oouzv+yaiNdPTd2MKTA9BL778pJuvfrH1cDtCY7R
         mwKbajzTE4c9AxD8iIQyKXsgDCo0yGpkuDyVpwguFisYv40/xGPKns8j2qwLYsbnlSHK
         fw23jNrpas46DRZV0PrdIuqyrf44Ofv9/BfdWbjsAznoprX9CvzPpRreJTdK319o+z9+
         YfO6QW/k7V7O+zYTGYlhbPmlnTqdARd1Cp+yk13Fmn691JzqWBUVcS8uIG87pYK+chgB
         vFR+dRRzVrMCXkVRCOIRW5lCQ3PuFzoEv31U1Wh3i8yK9CzhlqvsCXABPCad+dcm1SLe
         a17g==
X-Gm-Message-State: AOJu0YxifFBQF1r173jk47zuo6kXfxt/WGPmLlETGX1durc7ZxAUa5O4
        jss9hlKPLLW0AotSAhNPJCV4YyppmjJ3frDbj4dAo6c6xtHrd5RW2qVcOc8iikYKcaN2kzvAIRw
        lBXOpYC524tXrjAtYdtioPwNc
X-Received: by 2002:a6b:c541:0:b0:7b4:5ac5:9f15 with SMTP id v62-20020a6bc541000000b007b45ac59f15mr395516iof.11.1701734478702;
        Mon, 04 Dec 2023 16:01:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQnBPyeFdxlh2Qtw8/h7pN3+b1wM0h4O+feXPktnwOGXI46QpvUpfZTg/d5w35S03RXV2UDA==
X-Received: by 2002:a6b:c541:0:b0:7b4:5ac5:9f15 with SMTP id v62-20020a6bc541000000b007b45ac59f15mr395512iof.11.1701734478445;
        Mon, 04 Dec 2023 16:01:18 -0800 (PST)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id 22-20020a5d9c56000000b007b35043225fsm3092323iof.32.2023.12.04.16.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 16:01:16 -0800 (PST)
Date:   Mon, 4 Dec 2023 17:00:52 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio: account iommu allocations
Message-ID: <20231204170052.5967e9cd.alex.williamson@redhat.com>
In-Reply-To: <20231130200900.2320829-1-pasha.tatashin@soleen.com>
References: <20231130200900.2320829-1-pasha.tatashin@soleen.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Thu, 30 Nov 2023 20:09:00 +0000
Pasha Tatashin <pasha.tatashin@soleen.com> wrote:

> iommu allocations should be accounted in order to allow admins to
> monitor and limit the amount of iommu memory.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> This patch is spinned of from the series:
> https://lore.kernel.org/all/20231128204938.1453583-1-pasha.tatashin@soleen.com
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index eacd6ec04de5..b2854d7939ce 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -1436,7 +1436,7 @@ static int vfio_iommu_map(struct vfio_iommu *iommu, dma_addr_t iova,
>  	list_for_each_entry(d, &iommu->domain_list, next) {
>  		ret = iommu_map(d->domain, iova, (phys_addr_t)pfn << PAGE_SHIFT,
>  				npage << PAGE_SHIFT, prot | IOMMU_CACHE,
> -				GFP_KERNEL);
> +				GFP_KERNEL_ACCOUNT);
>  		if (ret)
>  			goto unwind;
>  
> @@ -1750,7 +1750,8 @@ static int vfio_iommu_replay(struct vfio_iommu *iommu,
>  			}
>  
>  			ret = iommu_map(domain->domain, iova, phys, size,
> -					dma->prot | IOMMU_CACHE, GFP_KERNEL);
> +					dma->prot | IOMMU_CACHE,
> +					GFP_KERNEL_ACCOUNT);
>  			if (ret) {
>  				if (!dma->iommu_mapped) {
>  					vfio_unpin_pages_remote(dma, iova,
> @@ -1845,7 +1846,8 @@ static void vfio_test_domain_fgsp(struct vfio_domain *domain, struct list_head *
>  			continue;
>  
>  		ret = iommu_map(domain->domain, start, page_to_phys(pages), PAGE_SIZE * 2,
> -				IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE, GFP_KERNEL);
> +				IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE,
> +				GFP_KERNEL_ACCOUNT);
>  		if (!ret) {
>  			size_t unmapped = iommu_unmap(domain->domain, start, PAGE_SIZE);
>  

Applied to vfio next branch for v6.8.  Thanks,

Alex

