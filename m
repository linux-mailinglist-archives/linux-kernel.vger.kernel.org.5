Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBEDB7D63AB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbjJYHm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233479AbjJYHmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:42:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EC61FC9;
        Wed, 25 Oct 2023 00:41:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18F5C433C7;
        Wed, 25 Oct 2023 07:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698219698;
        bh=AfCalJj7ZkoRwGtErTTI+0JtKyrgUPXCqMrGPh9iMXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HqSVHNOF82q6jHZRldi3AtUFmC+HWXd9H7YAYpkMk9IilvZkDKR/OQN21yuBN0Fdi
         5ltaSGigA8T2UJJ491MKZ26/pirER1zOfUaJ0qsilGjHkx4QfRqPCqxGGrp2pAxrYL
         y6mvo6YGKGTjRDyh4xLR6kH5q8BjiJ6wDAXa8UvJqP8uxY5QrHYv/NqnGpCFSRXQWX
         OrdxwmvL0hJjF0jQpQMC5UDB+RqtVbdZm2qn9PYkCIEKII4K+FJPU/1Yhdq1Nms98U
         z88fXT0/Ti3YxTNqUvlT7McAweGE7uLLSad7L2BHS5YcIOY0ywtFSbtLFJQ0aeA/dX
         gWC2nRdqOW7Ww==
Date:   Wed, 25 Oct 2023 13:11:28 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Ziqi Chen <quic_ziqichen@quicinc.com>
Cc:     quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        bvanassche@acm.org, mani@kernel.org, beanhuo@micron.com,
        avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com, quic_nguyenb@quicinc.com,
        quic_nitirawa@quicinc.com, quic_rampraka@quicinc.com,
        linux-scsi@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: ufs: qcom: move ufs_qcom_host_reset() to
 ufs_qcom_device_reset()
Message-ID: <20231025074128.GA3648@thinkpad>
References: <1698145815-17396-1-git-send-email-quic_ziqichen@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1698145815-17396-1-git-send-email-quic_ziqichen@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 07:10:15PM +0800, Ziqi Chen wrote:
> During PISI test, we found the issue that host Tx still bursting after

What is PISI test?

> H/W reset. Move ufs_qcom_host_reset() to ufs_qcom_device_reset() and
> reset host before device reset to stop tx burst.
> 

device_reset() callback is supposed to reset only the device and not the host.
So NACK for this patch.

- Mani

> Signed-off-by: Ziqi Chen <quic_ziqichen@quicinc.com>
> ---
>  drivers/ufs/host/ufs-qcom.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 96cb8b5..43163d3 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -445,12 +445,6 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
>  	struct phy *phy = host->generic_phy;
>  	int ret;
>  
> -	/* Reset UFS Host Controller and PHY */
> -	ret = ufs_qcom_host_reset(hba);
> -	if (ret)
> -		dev_warn(hba->dev, "%s: host reset returned %d\n",
> -				  __func__, ret);
> -
>  	/* phy initialization - calibrate the phy */
>  	ret = phy_init(phy);
>  	if (ret) {
> @@ -1709,6 +1703,13 @@ static void ufs_qcom_dump_dbg_regs(struct ufs_hba *hba)
>  static int ufs_qcom_device_reset(struct ufs_hba *hba)
>  {
>  	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> +	int ret = 0;
> +
> +	/* Reset UFS Host Controller and PHY */
> +	ret = ufs_qcom_host_reset(hba);
> +	if (ret)
> +		dev_warn(hba->dev, "%s: host reset returned %d\n",
> +				  __func__, ret);
>  
>  	/* reset gpio is optional */
>  	if (!host->device_reset)
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
