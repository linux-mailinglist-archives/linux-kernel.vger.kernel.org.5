Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E8580C4C9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbjLKJgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjLKJgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:36:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B16B3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:36:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A86C433C7;
        Mon, 11 Dec 2023 09:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702287406;
        bh=PKwxxJaQ8XbMiumsFpz0ev2d9al4VPTBHyScl5V41AE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qOC5z0ZNq4fxQKIPsHGxX0cSM5q9bqqrcDfxrM/B9lO8dp2LAHHF+oW81I6+x4aBL
         gzs9V47UnzJj7GxwM7y4Jr+BIyMDk3HPiXeVJz//NZOx/kOn/e27kka5o5dLPZ1l96
         I7rYpnmxLmRbi+0y1z/kYkGEMrBf30/pTIHmPnWuz+LEkGjFCxpoOcJSqVujQibD/l
         a5F8ZORDmEdv5v6P2ktPH2+SB45owIBe4F92tiVWNzqtvYqsi4mWoxEp0EiPh8nD9s
         hjgJqVBAgdLr2iXsrbYXIRHArq1piCP/MZoTBhQtuTPOao7h56nmHEDqGo4XPGZrQl
         ASgCQG4qoPIww==
Date:   Mon, 11 Dec 2023 15:06:30 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Yaniv Gardi <ygardi@codeaurora.org>,
        Dov Levenglick <dovl@codeaurora.org>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: ufs: qcom: Perform read back after writing reset
 bit
Message-ID: <20231211093630.GA2894@thinkpad>
References: <20231208-ufs-reset-ensure-effect-before-delay-v1-1-8a0f82d7a09e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231208-ufs-reset-ensure-effect-before-delay-v1-1-8a0f82d7a09e@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 02:19:44PM -0600, Andrew Halaney wrote:
> Currently, the reset bit for the UFS provided reset controller (used by
> its phy) is written to, and then a mb() happens to try and ensure that
> hit the device. Immediately afterwards a usleep_range() occurs.
> 
> mb() ensure that the write completes, but completion doesn't mean that
> it isn't stored in a buffer somewhere. The recommendation for
> ensuring this bit has taken effect on the device is to perform a read
> back to force it to make it all the way to the device. This is
> documented in device-io.rst and a talk by Will Deacon on this can
> be seen over here:
> 
>     https://youtu.be/i6DayghhA8Q?si=MiyxB5cKJXSaoc01&t=1678
> 
> Let's do that to ensure the bit hits the device. By doing so and
> guaranteeing the ordering against the immediately following
> usleep_range(), the mb() can safely be removed.
> 
> Fixes: 81c0fc51b7a7 ("ufs-qcom: add support for Qualcomm Technologies Inc platforms")
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

> ---
> This is based on top of:
> 
>     https://lore.kernel.org/linux-arm-msm/20231208065902.11006-1-manivannan.sadhasivam@linaro.org/T/#ma6bf749cc3d08ab8ce05be98401ebce099fa92ba
> 
> Since it mucks with the reset as well, and looks like it will go in
> soon.
> 
> I'm unsure if this is totally correct. The goal of this
> seems to be "ensure the device reset bit has taken effect before
> delaying afterwards". As I describe in the commit message, mb()
> doesn't guarantee that, the read back does... if it's against a udelay().
> I can't quite totally 100% convince myself that applies to usleep_range(),
> but I think it should be.
> 

This patch is perfectly fine. I did similar cleanups earlier, but missed this
one. Thanks!

> In either case, I think the read back makes sense, the question is "is
> it safe to remove the mb()?".
> 
> Sorry, Will's talk over has inspired me to poke the bear whenever I see
> a memory barrier in a driver I play with :)
> 
>     https://youtu.be/i6DayghhA8Q?si=12B0wCqImx1lz8QX&t=1677

Yeah, this inspired me too :)

- Mani

> --->  drivers/ufs/host/ufs-qcom.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
> index cdceeb795e70..c8cd59b1b8a8 100644
> --- a/drivers/ufs/host/ufs-qcom.h
> +++ b/drivers/ufs/host/ufs-qcom.h
> @@ -147,10 +147,10 @@ static inline void ufs_qcom_assert_reset(struct ufs_hba *hba)
>  	ufshcd_rmwl(hba, UFS_PHY_SOFT_RESET, UFS_PHY_SOFT_RESET, REG_UFS_CFG1);
>  
>  	/*
> -	 * Make sure assertion of ufs phy reset is written to
> -	 * register before returning
> +	 * Dummy read to ensure the write takes effect before doing any sort
> +	 * of delay
>  	 */
> -	mb();
> +	ufshcd_readl(hba, REG_UFS_CFG1);
>  }
>  
>  static inline void ufs_qcom_deassert_reset(struct ufs_hba *hba)
> @@ -158,10 +158,10 @@ static inline void ufs_qcom_deassert_reset(struct ufs_hba *hba)
>  	ufshcd_rmwl(hba, UFS_PHY_SOFT_RESET, 0, REG_UFS_CFG1);
>  
>  	/*
> -	 * Make sure de-assertion of ufs phy reset is written to
> -	 * register before returning
> +	 * Dummy read to ensure the write takes effect before doing any sort
> +	 * of delay
>  	 */
> -	mb();
> +	ufshcd_readl(hba, REG_UFS_CFG1);
>  }
>  
>  /* Host controller hardware version: major.minor.step */
> 
> ---
> base-commit: 8fdfb333a099b142b49510f2e55778d654a5b224
> change-id: 20231208-ufs-reset-ensure-effect-before-delay-6e06899d5419
> 
> Best regards,
> -- 
> Andrew Halaney <ahalaney@redhat.com>
> 

-- 
மணிவண்ணன் சதாசிவம்
