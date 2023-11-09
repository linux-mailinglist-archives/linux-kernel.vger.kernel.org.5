Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C7D7E6EF2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343896AbjKIQfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234475AbjKIQfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:35:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1531635A5;
        Thu,  9 Nov 2023 08:35:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F8DC433C7;
        Thu,  9 Nov 2023 16:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699547708;
        bh=DO7rti32qM8aexLDfsJn/f7IKXiyncbiQH0D8eWb7AY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FOZT5u/kJrglzPjz3w2sZ1ulGNVMQGY7/Sa2kpZQY6rNWGa+0EJ+7Ag7Cj24pTjYq
         1Mn3xl0sZXcSma6QQc6wkQPA51y52iHLxfWIswazxUXGXSiyjqpDwJ5gVHcT2D2Mhu
         ok0FKbHwVluXVLZn7nZBX8AfNwCDJkhRcMnrQ4yca4A0GBlwfdxUIb6Q/yAXtYv0cj
         f8k+4zDf6hFk6qROiCiEesdy+wOXKlIGP9KdYwtTe7cCiC002ijMDjmtrrQTTwd+SX
         jg7cbzOZ6nyuKuRL9S2lg2I2iK6sETP99wq85eJkkBUWlElu4xQkKwZ497LJE7J2pE
         DXqgQT/xkgfMA==
Date:   Thu, 9 Nov 2023 22:04:57 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_ramkri@quicinc.com, quic_skananth@quicinc.com,
        quic_parass@quicinc.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] bus: mhi: host: Add alignment check for event ring
 read pointer
Message-ID: <20231109163457.GM3752@thinkpad>
References: <20231031-alignment_check-v2-1-1441db7c5efd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231031-alignment_check-v2-1-1441db7c5efd@quicinc.com>
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
