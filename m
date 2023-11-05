Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C387E1298
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 09:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjKEId1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 03:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjKEId1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 03:33:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE6DD9;
        Sun,  5 Nov 2023 01:33:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD600C433C7;
        Sun,  5 Nov 2023 08:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699173204;
        bh=DO7rti32qM8aexLDfsJn/f7IKXiyncbiQH0D8eWb7AY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BPkNcDBofM3ig2gdmaHp7oUelf/DCjlyfbX5zZOnCVinCSDsiRH4MdsXOq9KQFHDi
         NbiEno5Etjh22cdFCaB90JR6ILLN/qZMnRXosqprq2zL4l79yyBv/53niFxyDwmc43
         rrd4oh5PFamKyfE3RMn6miwZrR4EeizyQWbO0VECYSPmzCgRRZM8l2smKlo91V9nr9
         upC+awhR06ymL6z7HjBVxoIwwwrqLFgwqJYpbYPn384I6nMbeTDr/Q3OTW15Q5Rziu
         NPSoMONt//KASjSXS1Hhzho2LI72TToftJVi4RcySUcOA9cmJ15KbGpCAs7bgPhvOE
         M8gGSDlqrGRVQ==
Date:   Sun, 5 Nov 2023 14:03:16 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
        quic_skananth@quicinc.com, quic_parass@quicinc.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] bus: mhi: host: Add alignment check for event ring
 read pointer
Message-ID: <20231105083316.GA2508@thinkpad>
References: <20231031-alignment_check-v2-1-1441db7c5efd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231031-alignment_check-v2-1-1441db7c5efd@quicinc.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 03:21:05PM +0530, Krishna chaitanya chundru wrote:
> Though we do check the event ring read pointer by "is_valid_ring_ptr"
> to make sure it is in the buffer range, but there is another risk the
> pointer may be not aligned.  Since we are expecting event ring elements
> are 128 bits(struct mhi_ring_element) aligned, an unaligned read pointer
> could lead to multiple issues like DoS or ring buffer memory corruption.
> 
> So add a alignment check for event ring read pointer.
> 
> Fixes: ec32332df764 ("bus: mhi: core: Sanity check values from remote device before use")
> cc: stable@vger.kernel.org
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>

Applied to mhi-next!

- Mani

> ---
> Changes in v2:
> - Change the modulus operation to bit-wise & operation as suggested by Jeff.
> - Link to v1: https://lore.kernel.org/r/20231023-alignment_check-v1-1-2ca5716d5c15@quicinc.com
> ---
>  drivers/bus/mhi/host/main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
> index 499590437e9b..e765c16a99d1 100644
> --- a/drivers/bus/mhi/host/main.c
> +++ b/drivers/bus/mhi/host/main.c
> @@ -268,7 +268,8 @@ static void mhi_del_ring_element(struct mhi_controller *mhi_cntrl,
>  
>  static bool is_valid_ring_ptr(struct mhi_ring *ring, dma_addr_t addr)
>  {
> -	return addr >= ring->iommu_base && addr < ring->iommu_base + ring->len;
> +	return addr >= ring->iommu_base && addr < ring->iommu_base + ring->len &&
> +			!(addr & (sizeof(struct mhi_ring_element) - 1));
>  }
>  
>  int mhi_destroy_device(struct device *dev, void *data)
> 
> ---
> base-commit: 71e68e182e382e951d6248bccc3c960dcec5a718
> change-id: 20231013-alignment_check-c013f509d24a
> 
> Best regards,
> -- 
> Krishna chaitanya chundru <quic_krichai@quicinc.com>
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
