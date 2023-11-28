Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C257FB129
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 06:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbjK1FWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 00:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232858AbjK1FW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 00:22:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B38C1AD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 21:22:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C079C433C7;
        Tue, 28 Nov 2023 05:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701148954;
        bh=KxefobUNL2PNW0ZyfHGYfAe1r6e3qhe9YnJofc4+Q08=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OhxumCsjYu2zIq/b42MO43CUcAMSBaohcn+WN2bzti1hXTJ7bhedDhS/c9HuOhCRD
         QQiSl5ZZEgjzm/T81SZ3HXoNsr9F6g5KRaqn0zOv/1MxP8ApCLScyh+3McBQMxSLCV
         KuieQs3oA2AVQ8VoSn0T6ieUJmLhlwjtyeUeRGWuZ7kY0QmYNBI3NIuyddw/fNpO8c
         7RwHML641Mn+TX1r+fVXTPdhZAFSGtDso5axv1Za0KwgrJo+xtXNPUYzD5d9qXCxt7
         WdB6GXvA8awOrrOAsBdgHHIh3ISVNeGXScNyDsaMvUqZeacnBr+OrlxYuQaDOzC934
         MrJqcaeRyrxfA==
Date:   Tue, 28 Nov 2023 10:52:21 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Can Guo <quic_cang@quicinc.com>
Cc:     bvanassche@acm.org, adrian.hunter@intel.com, beanhuo@micron.com,
        avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 02/10] scsi: ufs: ufs-qcom: No need to set hs_rate
 after ufshcd_init_host_param()
Message-ID: <20231128052221.GC3088@thinkpad>
References: <1700729190-17268-1-git-send-email-quic_cang@quicinc.com>
 <1700729190-17268-3-git-send-email-quic_cang@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1700729190-17268-3-git-send-email-quic_cang@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 12:46:22AM -0800, Can Guo wrote:
> In ufs_qcom_pwr_change_notify(), host_params.hs_rate has been set to
> PA_HS_MODE_B by ufshcd_init_host_param(), hence remove the duplicated line
> of work. Meanwhile, removed the macro UFS_QCOM_LIMIT_HS_RATE as it is only
> used here.
> 
> Signed-off-by: Can Guo <quic_cang@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/ufs/host/ufs-qcom.c | 1 -
>  drivers/ufs/host/ufs-qcom.h | 2 --
>  2 files changed, 3 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index aee66a3..cc30ad9 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -909,7 +909,6 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
>  	switch (status) {
>  	case PRE_CHANGE:
>  		ufshcd_init_host_param(&host_params);
> -		host_params.hs_rate = UFS_QCOM_LIMIT_HS_RATE;
>  
>  		/* This driver only supports symmetic gear setting i.e., hs_tx_gear == hs_rx_gear */
>  		host_params.hs_tx_gear = host_params.hs_rx_gear = ufs_qcom_get_hs_gear(hba);
> diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
> index 9950a00..82cd143 100644
> --- a/drivers/ufs/host/ufs-qcom.h
> +++ b/drivers/ufs/host/ufs-qcom.h
> @@ -27,8 +27,6 @@
>  #define SLOW 1
>  #define FAST 2
>  
> -#define UFS_QCOM_LIMIT_HS_RATE		PA_HS_MODE_B
> -
>  /* QCOM UFS host controller vendor specific registers */
>  enum {
>  	REG_UFS_SYS1CLK_1US                 = 0xC0,
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
