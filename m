Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECCE786FFA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 15:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238046AbjHXNNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 09:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240397AbjHXNNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 09:13:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE98198A;
        Thu, 24 Aug 2023 06:13:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF6026269E;
        Thu, 24 Aug 2023 13:13:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A422AC433C7;
        Thu, 24 Aug 2023 13:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692882818;
        bh=SfeSvLlzV/QIsfQI6lGrqzROvKL38Kvs5ty/5yOH31A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZhJLIz8BGyAb2ivMZw6rmCdfIOYmFrT9z8ODxNAAJEQ85enR0GfFmnfIbFsFmArtl
         FXYOynVSVtLEblhukepFVPKrJuXATUHOsl0w7G192F+Dh01gV5/rU18iIZ1iZF5rBy
         bA5+n8aGEXbZtIfZb49YeDS5zo5cbYTnS7/mUOWs=
Date:   Thu, 24 Aug 2023 15:13:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexandra Diupina <adiupina@astralinux.ru>
Cc:     Joerg Roedel <joro@8bytes.org>, stable@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PATCH 5.10] iommu/mediatek: remove redundant comparison
Message-ID: <2023082458-mongrel-catlike-b73d@gregkh>
References: <20230824130954.29688-1-adiupina@astralinux.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824130954.29688-1-adiupina@astralinux.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 04:09:54PM +0300, Alexandra Diupina wrote:
> iommu_device_register always returns 0 in 4.11-5.12, so

What do you mean by "4.11-5.12"?

> we need to remove redundant comparison with 0

Why?

> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: b16c0170b53c ("iommu/mediatek: Make use of iommu_device_register interface")

How is this a fix if it isn't actually changing the code at all?

> Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
> ---
>  drivers/iommu/mtk_iommu.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 051815c9d2bb..208c47218b75 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -748,9 +748,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>  	iommu_device_set_ops(&data->iommu, &mtk_iommu_ops);
>  	iommu_device_set_fwnode(&data->iommu, &pdev->dev.of_node->fwnode);
>  
> -	ret = iommu_device_register(&data->iommu);
> -	if (ret)
> -		return ret;
> +	iommu_device_register(&data->iommu);

This is obviously incorrect, please fix your "tool" that is telling you
to make such a broken change.

Unless your tool wants to create buggy code?  If so, it's succeeding
very well.

greg k-h
