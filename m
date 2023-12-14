Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B88812FA3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572900AbjLNMFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 07:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444191AbjLNMFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:05:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B96E10A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 04:05:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FAD3C433C8;
        Thu, 14 Dec 2023 12:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702555514;
        bh=PoZg7dwthRu54cxelOx2fInbC9KQc4SVNLq1rSG4o6M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MK7PEfFlMM0ZUC6BHHY/7ZKtMjLkVdjBB0rIoWzcS960SBIFx1aio99zaaXMow0CW
         wFS11QMbL5aie76SfTiI4hF/lzG4s3XaBDskL8VTDbPz7UZN3pbsskt5VDufjW0csG
         QLRWUMAOu0ZgjOz52xiBXi9cLIMVCKTey3Eb51KG+cmgPE65Yn8c6xWpXJNFMTs7s2
         6UU+aADoti+YI0Y5nSw8JOvfVcLtU27DPxaN+lZXUqK6K2owF3F5vRSPfThPE5DCMp
         y1aKFI7Q0i6GcbkdptK+qHOHTenDerzKRVUrciC2zg1kLvJ/rCluQ2qkoN9PG23Ajg
         b5M6OQT/8SYRA==
Date:   Thu, 14 Dec 2023 17:34:59 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Chanwoo Lee <cw9316.lee@samsung.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        p.zabel@pengutronix.de, linux-arm-msm@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        grant.jung@samsung.com, jt77.jang@samsung.com,
        dh0421.hwang@samsung.com, sh043.lee@samsung.com,
        Andrew Halaney <ahalaney@redhat.com>
Subject: Re: [PATCH v2] scsi: ufs: qcom: Re-fix for error handling
Message-ID: <20231214120459.GD48078@thinkpad>
References: <CGME20231214021405epcas1p3cef80b85df56b7bead7f2f2ebd52f4ac@epcas1p3.samsung.com>
 <20231214021401.26474-1-cw9316.lee@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231214021401.26474-1-cw9316.lee@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 11:14:01AM +0900, Chanwoo Lee wrote:
> From: ChanWoo Lee <cw9316.lee@samsung.com>
> 
> I modified the code to handle errors.
> 
> The error handling code has been changed from the patch below.
> -'commit 031312dbc695 ("scsi: ufs: ufs-qcom: Remove unnecessary goto statements")'
> 
> This is the case I checked.
> * ufs_qcom_clk_scale_notify -> 'ufs_qcom_clk_scale_up_/down_pre_change' error -> return 0;
> 
> It is unknown whether the above commit was intended to change error handling.
> However, if it is not an intended fix, a patch may be needed.
> 

Fixes: 031312dbc695 ("scsi: ufs: ufs-qcom: Remove unnecessary goto statements")

> Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks for spotting and fixing the issue! This is one of the reasons why the
error path should directly return instead of slipping.

- Mani

> Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
> ---
> v1->v2: Remove things already in progress
>  1) ufs_qcom_host_reset -> 'reset_control_deassert' error -> return 0;
>    -> https://lore.kernel.org/linux-arm-msm/20231208065902.11006-8-manivannan.sadhasivam@linaro.org/#t
>  2) ufs_qcom_init_lane_clks -> 'ufs_qcom_host_clk_get(tx_lane1_sync_clk)' error -> return 0;
>    -> https://lore.kernel.org/linux-arm-msm/20231208065902.11006-2-manivannan.sadhasivam@linaro.org/
> ---
> ---
>  drivers/ufs/host/ufs-qcom.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 96cb8b5b4e66..17e24270477d 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -1516,9 +1516,11 @@ static int ufs_qcom_clk_scale_notify(struct ufs_hba *hba,
>  			err = ufs_qcom_clk_scale_up_pre_change(hba);
>  		else
>  			err = ufs_qcom_clk_scale_down_pre_change(hba);
> -		if (err)
> -			ufshcd_uic_hibern8_exit(hba);
>  
> +		if (err) {
> +			ufshcd_uic_hibern8_exit(hba);
> +			return err;
> +		}
>  	} else {
>  		if (scale_up)
>  			err = ufs_qcom_clk_scale_up_post_change(hba);
> -- 
> 2.29.0
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
