Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0588378A73F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 10:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjH1IJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 04:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjH1II4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 04:08:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A6E132;
        Mon, 28 Aug 2023 01:08:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C499F6123A;
        Mon, 28 Aug 2023 08:08:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA71BC433C8;
        Mon, 28 Aug 2023 08:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693210108;
        bh=S9x2gvkNovMDtY+1ABs3QKTwI4PEEkzhqgoTIPPZd8Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gqtOIs1CGlVV4v1kO3s0nXPNHfOrJ4szvBsFa5uOprNWKaAop/ESyiMfjmv/49dVy
         w2QPHn+B0q/d2bPbp6yfURKXO2L/bPSZAC6PPapitIOzNhAqdoj+quu41HQmiZbAKA
         X9BHfhVeZXpGFqBXjt4Rhwe0TjFBsbAMQbGkFyTohRGHX/GRnNTwJcL2xIykCJ+VcN
         vqHpVHnEYYi982NowLC6ENQMffRUi9GH3axNXvUAYnMBEJgIOAmdRiFDH5X+D24OJ8
         bY3bu4fQ1IZWUT7N6HGvNMLQzh6cbX8J6KsDm7nnSrBOKnAeNHROAMMpTq+MHLm8ye
         9dG4V514sVtig==
Date:   Mon, 28 Aug 2023 13:38:11 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Nitin Rawat <quic_nitirawa@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        quic_cang@quicinc.com, quic_nguyenb@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Subject: Re: [PATCH V5 4/6] scsi: ufs: qcom: Align unipro clk attributes as
 per Hardware specification
Message-ID: <20230828080811.GE5148@thinkpad>
References: <20230823154413.23788-1-quic_nitirawa@quicinc.com>
 <20230823154413.23788-5-quic_nitirawa@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230823154413.23788-5-quic_nitirawa@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 09:14:11PM +0530, Nitin Rawat wrote:
> Currently CORE_CLK_1US_CYCLES, PA_VS_CORE_CLK_40NS_CYCLES are configured
> in clk scaling post change ops. Move this to clk scaling pre change ops to
> align with the hardware specification.
> 

Does this mean, the driver was doing the clk scaling at the wrong time? If so,
this patch should be moved ahead of all patches, should have fixes tag and CC
stable list.

- Mani

> Co-developed-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
> Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> ---
>  drivers/ufs/host/ufs-qcom.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 8162b19191a9..491c0173603e 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -1399,12 +1399,6 @@ static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba,
>  }
> 
>  static int ufs_qcom_clk_scale_up_pre_change(struct ufs_hba *hba)
> -{
> -	/* nothing to do as of now */
> -	return 0;
> -}
> -
> -static int ufs_qcom_clk_scale_up_post_change(struct ufs_hba *hba)
>  {
>  	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> 
> @@ -1414,6 +1408,11 @@ static int ufs_qcom_clk_scale_up_post_change(struct ufs_hba *hba)
>  	return ufs_qcom_cfg_core_clk_ctrl(hba);
>  }
> 
> +static int ufs_qcom_clk_scale_up_post_change(struct ufs_hba *hba)
> +{
> +	return 0;
> +}
> +
>  static int ufs_qcom_clk_scale_down_pre_change(struct ufs_hba *hba)
>  {
>  	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> --
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்
