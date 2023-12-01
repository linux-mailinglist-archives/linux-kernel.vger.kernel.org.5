Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5286800321
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 06:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377502AbjLAFnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 00:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjLAFnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 00:43:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC35F2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 21:43:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D09A4C433C9;
        Fri,  1 Dec 2023 05:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701409400;
        bh=6sMeY93ms6fPD3cyS25qVVh5+8+aMjpl27NnFtOQ4YU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ADa8Ma8zdT9RYLBuGmS00EbJSC2pkQUF9x2/Jg5Ht1RbtWZ0/vfnbrgKkOPnCebDC
         nVDrhJwyD5UClFbNwZDxHRC6HE7E10K8WhvRXVMePjIM2WMZLTO3zZXNU42CtO5O0X
         UsZbfrvvRfiKPiP3SfuXno+EMDFZ5cxODpiHDL+0IcJd3YNDjQNQDm92VBbGpQPcbn
         CRcB1mXV2NOYPT9XNEOTFUQvI7cD1bI49vcKbxxz+UuOdc7Lf8ru74joJY9IxQCBYW
         q7kc2wgZ//jxvnbbcMuIh0KCrG0Kce7sbCOEvi2sV2NiK6EG6IHflXyzabR+hxHr3C
         ugZuve0/PY7bA==
Date:   Fri, 1 Dec 2023 11:13:04 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Can Guo <quic_cang@quicinc.com>
Cc:     bvanassche@acm.org, adrian.hunter@intel.com, vkoul@kernel.org,
        beanhuo@micron.com, avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 07/10] scsi: ufs: ufs-qcom: Check return value of
 phy_set_mode_ext()
Message-ID: <20231201054304.GB4009@thinkpad>
References: <1701407001-471-1-git-send-email-quic_cang@quicinc.com>
 <1701407001-471-8-git-send-email-quic_cang@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1701407001-471-8-git-send-email-quic_cang@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 09:03:17PM -0800, Can Guo wrote:
> In ufs_qcom_power_up_sequence(), check return value of phy_set_mode_ext()
> and stop proceeding if phy_set_mode_ext() fails.
> 
> Reviewed-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> Signed-off-by: Can Guo <quic_cang@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/ufs/host/ufs-qcom.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 543939c..ee3f07a 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -475,7 +475,9 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
>  		return ret;
>  	}
>  
> -	phy_set_mode_ext(phy, mode, host->phy_gear);
> +	ret = phy_set_mode_ext(phy, mode, host->phy_gear);
> +	if (ret)
> +		goto out_disable_phy;
>  
>  	/* power on phy - start serdes and phy's power and clocks */
>  	ret = phy_power_on(phy);
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
