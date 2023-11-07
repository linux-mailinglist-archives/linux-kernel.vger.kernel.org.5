Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874647E499E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 21:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbjKGUPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 15:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKGUPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 15:15:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EAFD4A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 12:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699388069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UpwVUsKsWJB8ELVQCuxVLyRNagfKcI1oOQIR0b5JV9c=;
        b=ASjxKDTFXVhq8bfonfVbFf06UZpPyIMK7nnMCuM2c0vnyTEZN9XxQxG7Sj7ts5Nv2Y/MbH
        UXwR9D75m6A/ZqDkd6ka66b7BUZcbY00U7kmVSqav+mnRye9oKpZ6YzGgLUSvsOhIweH1H
        ipxKKVTb/guEuqWSQnzfl9Q7ECgkyxE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-HghGHlpmPuavSoP2IBBJ8A-1; Tue, 07 Nov 2023 15:14:25 -0500
X-MC-Unique: HghGHlpmPuavSoP2IBBJ8A-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-670aa377deeso74708226d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 12:14:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699388064; x=1699992864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpwVUsKsWJB8ELVQCuxVLyRNagfKcI1oOQIR0b5JV9c=;
        b=XoGyWZmtSQ2Xi6djV/tYSVKoO65+i5x5Q7Hz0voBKsem/YS1adCTGUqasEVz4eRTVG
         hSCy47zQIpEeU1aSLw2yTZeSvclQz8uF05d0RrWe5nvORfB1ikeu0ibsVzaDfnGMly6Z
         KEWRls9rHYR4gTce/MM6U93slBWF/LXJ5qMO9my1XnQispfC/1WvP0oieW6we4+FmO6i
         noNGv6NXEYgzeNULu1+1ChiPBdwX6suc8Pu/yKx+nWYpzTXNp2Ot3FBuS/8gFgafpMPX
         NS5xfDLXh9MzlTh06usLPfC4yAb8lsKdRVuDN2FyTjKnj0gJiMldFFqDdwA3ltfiAAKA
         KiWA==
X-Gm-Message-State: AOJu0Yyb7p/Jpfp+f0lR9iCleFTcLcHd3CQOBKTATOmQ1RHaEEqGS6Vy
        ueZdAfrF3YBTIgp3mmIHZ74drw8qg9N+j/AByrvEnNfxzcA+t1tdUcLAD1W4Pq8lG3agxeA4R93
        DaVPRfpdSPKEgXVPXvJVcSqZ3
X-Received: by 2002:a0c:cb88:0:b0:66d:5d31:999e with SMTP id p8-20020a0ccb88000000b0066d5d31999emr29908606qvk.43.1699388064513;
        Tue, 07 Nov 2023 12:14:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVYjdKwQ+pE8aJZPxVzo9sq0Gg+0h0LojH6Wg7xle1xVHG2mmu2Be0/uKehTX60Jrx8gapeQ==
X-Received: by 2002:a0c:cb88:0:b0:66d:5d31:999e with SMTP id p8-20020a0ccb88000000b0066d5d31999emr29908579qvk.43.1699388064237;
        Tue, 07 Nov 2023 12:14:24 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id p14-20020a0cc3ce000000b0065b1f90ff8csm247125qvi.40.2023.11.07.12.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 12:14:23 -0800 (PST)
Date:   Tue, 7 Nov 2023 14:14:21 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Can Guo <cang@qti.qualcomm.com>
Cc:     quic_cang@quicinc.com, bvanassche@acm.org, mani@kernel.org,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        beanhuo@micron.com, avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        "Bao D . Nguyen" <quic_nguyenb@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/7] scsi: ufs: ufs-qcom: Setup host power mode during
 init
Message-ID: <pami4442fspxmmyg32jjn2iyzozkyeblcuzwpmkql7wfa3xvq5@ftblajt7hsgo>
References: <1699332374-9324-1-git-send-email-cang@qti.qualcomm.com>
 <1699332374-9324-3-git-send-email-cang@qti.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1699332374-9324-3-git-send-email-cang@qti.qualcomm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 08:46:08PM -0800, Can Guo wrote:
> From: Can Guo <quic_cang@quicinc.com>
> 
> Setup host power mode and its limitations during UFS host driver init to
> avoid repetitive work during every power mode change.
> 
> Co-developed-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
> Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> ---
>  drivers/ufs/host/ufs-qcom.c | 22 ++++++++++++++--------
>  drivers/ufs/host/ufs-qcom.h |  1 +
>  2 files changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index aee66a3..cc0eb37 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -898,7 +898,7 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
>  				struct ufs_pa_layer_attr *dev_req_params)
>  {
>  	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> -	struct ufs_host_params host_params;
> +	struct ufs_host_params *host_params = &host->host_params;
>  	int ret = 0;
>  
>  	if (!dev_req_params) {
> @@ -908,13 +908,7 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
>  
>  	switch (status) {
>  	case PRE_CHANGE:
> -		ufshcd_init_host_param(&host_params);
> -		host_params.hs_rate = UFS_QCOM_LIMIT_HS_RATE;

You drop the setting of hs_rate in your new function. It seems setting that's
also overkill since UFS_QCOM_LIMIT_HS_RATE == PA_HS_MODE_B. hs_rate is
already set to that in ufshcd_init_host_param(), so removing it makes
sense.

Can you remove it prior in its own patch, and remove the now unused
UFS_QCOM_LIMIT_HS_RATE as well from ufs-qcom.h?

With that in place this seems like a good improvement:

Acked-by: Andrew Halaney <ahalaney@redhat.com>

> -
> -		/* This driver only supports symmetic gear setting i.e., hs_tx_gear == hs_rx_gear */
> -		host_params.hs_tx_gear = host_params.hs_rx_gear = ufs_qcom_get_hs_gear(hba);
> -
> -		ret = ufshcd_negotiate_pwr_param(&host_params, dev_max_params, dev_req_params);
> +		ret = ufshcd_negotiate_pwr_param(host_params, dev_max_params, dev_req_params);
>  		if (ret) {
>  			dev_err(hba->dev, "%s: failed to determine capabilities\n",
>  					__func__);
> @@ -1049,6 +1043,17 @@ static void ufs_qcom_advertise_quirks(struct ufs_hba *hba)
>  		hba->quirks |= UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH;
>  }
>  
> +static void ufs_qcom_set_host_params(struct ufs_hba *hba)
> +{
> +	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> +	struct ufs_host_params *host_params = &host->host_params;
> +
> +	ufshcd_init_host_param(host_params);
> +
> +	/* This driver only supports symmetic gear setting i.e., hs_tx_gear == hs_rx_gear */
> +	host_params->hs_tx_gear = host_params->hs_rx_gear = ufs_qcom_get_hs_gear(hba);
> +}
> +
>  static void ufs_qcom_set_caps(struct ufs_hba *hba)
>  {
>  	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> @@ -1273,6 +1278,7 @@ static int ufs_qcom_init(struct ufs_hba *hba)
>  
>  	ufs_qcom_set_caps(hba);
>  	ufs_qcom_advertise_quirks(hba);
> +	ufs_qcom_set_host_params(hba);
>  
>  	err = ufs_qcom_ice_init(host);
>  	if (err)
> diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
> index 9950a00..ab94c54 100644
> --- a/drivers/ufs/host/ufs-qcom.h
> +++ b/drivers/ufs/host/ufs-qcom.h
> @@ -240,6 +240,7 @@ struct ufs_qcom_host {
>  
>  	struct gpio_desc *device_reset;
>  
> +	struct ufs_host_params host_params;
>  	u32 phy_gear;
>  
>  	bool esi_enabled;
> -- 
> 2.7.4
> 
> 

