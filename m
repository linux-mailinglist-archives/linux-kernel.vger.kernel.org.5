Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79F4773E55
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbjHHQ3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbjHHQ1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:27:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0758E11F6C;
        Tue,  8 Aug 2023 08:50:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F37A362401;
        Tue,  8 Aug 2023 06:21:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38CF3C433C7;
        Tue,  8 Aug 2023 06:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691475661;
        bh=cCRD8gnBxWNfc9VwjYkdaIBzXW8V7v21L0Omu0Jdq1k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rQxBdUe/8TyTjOmMjZJdUp/7/CCa/I280HQUC9Ud7lbgAYZoSp0GmAmIZSX6NAw07
         Cua/ZsQ1kxh5CzIG9hNw+ZLpoLLFiwSK9e46ri/juPKAaQoJg/HxzXV/RNTejNankW
         +V19yrLSuwQ0Qxa6Gv9XIa/+QFbweoSpxJ04qpRmF8QjSUbmD85Xr7ouSlRjLOQDtJ
         OsLyuKZJciemoceMZq7YzpRqjHKOy6j0Wj1EHZOLy5yAqckshIh+D1EAzf52CHrdV/
         kahFHqAxE7OWy4Hti2840lk4UYi3aD3RLZd38a00dSC3LBOWtsATBvvA/qdjHg0lkB
         uVOsFd31c8sfQ==
Date:   Tue, 8 Aug 2023 11:50:49 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Qiang Yu <quic_qianyu@quicinc.com>
Cc:     mani@kernel.org, quic_jhugo@quicinc.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_cang@quicinc.com, quic_mrana@quicinc.com
Subject: Re: [PATCH v2] mhi: host: Add standard ELF header image download
 functionality
Message-ID: <20230808062049.GA4990@thinkpad>
References: <1691395192-16090-1-git-send-email-quic_qianyu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1691395192-16090-1-git-send-email-quic_qianyu@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 03:59:52PM +0800, Qiang Yu wrote:
> From: Mayank Rana <quic_mrana@quicinc.com>
> 

Subject prefix should be: "bus: mhi:..."

> Some devices (e.g. WLAN chips) are unable to handle the non-standard ELF
> format of the FBC image and thus need special handling of the FBC image.
> 

Which WLAN chip? Is the driver for the chip already upstreamed?

> Add standard_elf_image flag which makes decision in terms of how FBC image
> based AMSS image is being downloaded with connected endpoint.
> FBC image is having two image combine: SBL image + AMSS image.
> 1. FBC image download using legacy single ELF header image format:
> - SBL image: 512KB of FBC image is downloaded using BHI.
> - AMSS image: full FBC image is downloaded using BHIe.
> 2. FBC image download using separate ELF header image format:
> - SBL image: 512 KB of FBC image is downloaded using BHI.
> - AMSS image: 512 KB onward FBC image is downloaded using BHIe.
> There is no change for SBL image download. Although AMSS image start
> address is end address of SBL image while using separate ELF header format.
> 
> Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
> [quic_qianyu@quicinc.com: Update commit message, minor updates]
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> ---
> v1->v2: modify commit message
> 	correct author
> 	rebase on latest mhi-next branch, resolve conflicts
> 
>  drivers/bus/mhi/host/boot.c | 7 +++++++
>  include/linux/mhi.h         | 2 ++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
> index edc0ec5..586d551 100644
> --- a/drivers/bus/mhi/host/boot.c
> +++ b/drivers/bus/mhi/host/boot.c
> @@ -495,6 +495,13 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
>  	 * device transitioning into MHI READY state
>  	 */
>  	if (mhi_cntrl->fbc_download) {
> +		dev_dbg(dev, "standard_elf_image: %s\n",
> +				(mhi_cntrl->standard_elf_image ? "True" : "False"));
> +		if (mhi_cntrl->standard_elf_image) {

Commit message is saying that the devices cannot handle non-standard ELF image.
But this check is for standard ELF image. I'm confused.

> +			fw_data = firmware->data + mhi_cntrl->sbl_size;
> +			fw_sz = fw_sz - mhi_cntrl->sbl_size;
> +		}
> +
>  		ret = mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl->fbc_image, fw_sz);
>  		if (ret) {
>  			release_firmware(firmware);
> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
> index 039943e..e065101 100644
> --- a/include/linux/mhi.h
> +++ b/include/linux/mhi.h
> @@ -310,6 +310,7 @@ struct mhi_controller_config {
>   * @reg_len: Length of the MHI MMIO region (required)
>   * @fbc_image: Points to firmware image buffer
>   * @rddm_image: Points to RAM dump buffer
> + * @standard_elf_image: Flag to make decision about firmware download start address (optional)
>   * @mhi_chan: Points to the channel configuration table
>   * @lpm_chans: List of channels that require LPM notifications
>   * @irq: base irq # to request (required)
> @@ -456,6 +457,7 @@ struct mhi_controller {
>  	bool bounce_buf;
>  	bool fbc_download;
>  	bool wake_set;
> +	bool standard_elf_image;

Which driver is making use of this flag?

- Mani

>  	unsigned long irq_flags;
>  	u32 mru;
>  };
> -- 
> 2.7.4
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
