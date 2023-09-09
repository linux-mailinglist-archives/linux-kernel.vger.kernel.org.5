Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8E0799684
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 08:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234968AbjIIGDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 02:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjIIGDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 02:03:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330561BD3;
        Fri,  8 Sep 2023 23:03:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26224C433C8;
        Sat,  9 Sep 2023 06:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694239420;
        bh=D/qZHs6VWJY9qqhwtf08OymHikqt+nVKX982NNZ2RYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FDfp+svWZoK6H4kUONHktO5Vuy10qGZnfuBbt0xcd+yzd/PChcz/gy69qUP29zkmX
         VNHrADeiip9Y3oTvVwFUM8ZeIhFMViVXePZiY72V69QTIC3EzDpoq2WFS3/x4MpO4n
         bVnkL/M4TIPRZrf1qPkFj8Sx4zH6MNfx4922ukYeBd90JWflq59qePzk3roA9cCEK5
         OVxRl+oCAbAGbg4EkMUGJBEMP7n51NvprNKMPCnt0w6ar9XoCm9IkKlwBBjJt+LS3O
         cxRU6tGFfTwjXbBG1iggysEzPwBIY9H/BkIP9ooncdb8Z/PDhXBNCkzMjBpIimNjHd
         1CXLvKWP5tq1A==
Date:   Sat, 9 Sep 2023 11:33:27 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@quicinc.com,
        quic_charante@quicinc.com, quic_kaushalk@quicinc.com
Subject: Re: [PATCH] mtd: nand: qcom: Fix the node for nand unmap resource
Message-ID: <20230909060327.GA5847@thinkpad>
References: <20230907092854.11408-1-quic_bibekkum@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230907092854.11408-1-quic_bibekkum@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 02:58:54PM +0530, Bibek Kumar Patro wrote:
> While unmapping the nand resource in case of err_core_clk
> the dev node being passed is res_start instead of nand->dma_base
> (where the iova returned from map operation is stored) causing
> failure in unmap operation. Hence modifying the unmap operation
> to pass the nand->base_dma instead of res_start.
> 
> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> ---
>  drivers/mtd/nand/raw/qcom_nandc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> index f583022755a2..e085a0f588eb 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -3322,7 +3322,7 @@ static int qcom_nandc_probe(struct platform_device *pdev)
>  err_aon_clk:
>  	clk_disable_unprepare(nandc->core_clk);
>  err_core_clk:
> -	dma_unmap_resource(dev, res->start, resource_size(res),
> +	dma_unmap_resource(dev, nandc->base_dma, resource_size(res),
>  			   DMA_BIDIRECTIONAL, 0);
>  	dev_err(&pdev->dev, "DEBUG: probe failed for nandc module\n");

This error indicates that you are sending the patch against downstream tree.
That's not appropriate. Please send your patches against mainline/mtd-next
instead and also validate properly.

- Mani

>  	return ret;
> -- 
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்
