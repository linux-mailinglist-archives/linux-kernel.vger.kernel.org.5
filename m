Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B167DDC40
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 06:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346662AbjKAFSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 01:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjKAFSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 01:18:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11592B9;
        Tue, 31 Oct 2023 22:18:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F24CC433C7;
        Wed,  1 Nov 2023 05:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698815883;
        bh=DkUg7pfZ4z/iTm73K2U8uyk55cKIRa7vs2uU4EXIrts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r0Bn4roVOaKKoa+JEyY5SzXkU8sRq4zvNSr9+TIWphrBIJhavBpks65T6UU1OKKsK
         aucneQ/IhN9A48uJU4nVKfqsJmJQV4VZA4VQBIK3VbM9VVI5kc28oKZ8gTNE9L2Raa
         qVa033/FJ8zL9eD3o97RKr+YFH4+26P+/ETn5Xh0Ss5zCqDnXg5JYBizoO+Ofc1kmN
         doveXqAfMDEK7/Apz52hZDEkAHLBqLyVQZ6NpABuGwwIw5XAfc8qmcm/PQxaDW55Ey
         nW5jroJLaBEQorfE+oUN5WCUX/0Eweg/x9QhEGCiJQ7lyc51zRU9O5RmSxC6hfZZwr
         PRhm9cREuAotQ==
Date:   Wed, 1 Nov 2023 10:47:48 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_ramkri@quicinc.com, quic_skananth@quicinc.com,
        quic_parass@quicinc.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] bus: mhi: host: Add alignment check for event ring
 read pointer
Message-ID: <20231101051748.GD2897@thinkpad>
References: <20231031-alignment_check-v2-1-1441db7c5efd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231031-alignment_check-v2-1-1441db7c5efd@quicinc.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Bjorn gave his R-b tag for v1 and you didn't include it. If you dropped it on
purpose, then you should mention it in the "Changes" along with a justification.

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

-- 
மணிவண்ணன் சதாசிவம்
