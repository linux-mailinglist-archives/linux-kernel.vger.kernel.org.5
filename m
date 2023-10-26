Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20AA07D7AC0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 04:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbjJZCOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 22:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234479AbjJZCOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 22:14:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743A31BC;
        Wed, 25 Oct 2023 19:14:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5CDC433C8;
        Thu, 26 Oct 2023 02:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698286467;
        bh=jUa0j8kXyR+ZqrJZnoV5zjFY9ZcHXkhKnRFy040alus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mtqSjpfGC88sm08rhZHtFSzjgIa6iszerPfV9hN3YqwaTWtKtatSdNr5BCfEOOr1d
         4dyLnLt445TuTelm+nZBwnsRZE9d16gKQ24BTXG/KZYOE6TuZJ3eJp+oPw8yk331Ew
         1ya4opqyveU6lXnCpXqCzKi2F6wemq3YX+Vhw9KhAXyqSQY2IX+y/SCCQoEVvndBCK
         vyrE3BmirYKIqbZkXzRIrjxJX/NDUyEleHpIA4GJF4BnzR2wCmpmxjASbVaxgrnYMS
         +MwWPTYe8iPRzFaVYjVSAzIPfbNhcj0Px4IfOVIcyb7IeACYyt9rvRHPB/5n8e542w
         q7lnvib9JOWuw==
Date:   Wed, 25 Oct 2023 19:18:45 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
        quic_skananth@quicinc.com, quic_parass@quicinc.com
Subject: Re: [PATCH] bus: mhi: host: Add alignment check for event ring read
 pointer
Message-ID: <ixs2dtrijaft4j5hnmemhxuq6mpvmlnv64t5nkge4olnnwrldk@bfjffg7ard5g>
References: <20231023-alignment_check-v1-1-2ca5716d5c15@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023-alignment_check-v1-1-2ca5716d5c15@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 03:13:06PM +0530, Krishna chaitanya chundru wrote:
> Though we do check the event ring read pointer by "is_valid_ring_ptr"
> to make sure it is in the buffer range, but there is another risk the
> pointer may be not aligned.  Since we are expecting event ring elements
> are 128 bits(struct mhi_tre) aligned, an unaligned read pointer could lead
> to multiple issues like DoS or ring buffer memory corruption.
> 
> So add a alignment check for event ring read pointer.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> ---
>  drivers/bus/mhi/host/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
> index 499590437e9b..c907bbb67fb2 100644
> --- a/drivers/bus/mhi/host/main.c
> +++ b/drivers/bus/mhi/host/main.c
> @@ -268,7 +268,7 @@ static void mhi_del_ring_element(struct mhi_controller *mhi_cntrl,
>  
>  static bool is_valid_ring_ptr(struct mhi_ring *ring, dma_addr_t addr)
>  {
> -	return addr >= ring->iommu_base && addr < ring->iommu_base + ring->len;
> +	return addr >= ring->iommu_base && addr < ring->iommu_base + ring->len && addr % 16 == 0;
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
