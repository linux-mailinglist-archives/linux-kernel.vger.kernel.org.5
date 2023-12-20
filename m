Return-Path: <linux-kernel+bounces-6828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0D1819E2C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C32B6B26231
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94DE21A01;
	Wed, 20 Dec 2023 11:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlREs5F6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3FE20DF3;
	Wed, 20 Dec 2023 11:34:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD941C433C9;
	Wed, 20 Dec 2023 11:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703072041;
	bh=RAXyl4ljakAiP1xrw3EqjOoDMXwJ4PyKKqT6SUzQ5HA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VlREs5F6Zd39xwtfPWVcwlaPWa/UsQGFUgyUrblbh5aicN1h/jnFsLs2G0hrzoL1G
	 KZcBP9H/2iqypNfcsG9tykx34d3DQMzV/xuSwZOTqKlSfJxJ4zdRkdSlT217odhyQw
	 NZIHuFYJgQhu8Ir6GhUDbTIhWrwUR6FIzL8Z3vvY2xvSnaCQYDEytHqDQb4X/hEmXK
	 3Tfu8zgPjlXwAK/Bh54i7XTSDLmVeVoS6Ffrf8W/79nC58Wh9yOWjsT2Eo/cdRyH4C
	 ZsyrLxYMNi5z5DS53F3PFvWoDemeIk1VnnoVd8bcXpV6YWrwFVVsBWXX4MEa8hVgZW
	 Gq02I2ewKV5/A==
Date: Wed, 20 Dec 2023 17:03:44 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Chanwoo Lee <cw9316.lee@samsung.com>
Cc: agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
	jejb@linux.ibm.com, martin.petersen@oracle.com,
	linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, grant.jung@samsung.com,
	jt77.jang@samsung.com, dh0421.hwang@samsung.com,
	sh043.lee@samsung.com
Subject: Re: [PATCH] scsi: ufs: qcom: Remove unnecessary goto statement from
 ufs_qcom_config_esi function
Message-ID: <20231220113344.GC3544@thinkpad>
References: <CGME20231219082757epcas1p33bda4e0723d3d57552132054d3e5a3fe@epcas1p3.samsung.com>
 <20231219082740.27644-1-cw9316.lee@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231219082740.27644-1-cw9316.lee@samsung.com>

On Tue, Dec 19, 2023 at 05:27:40PM +0900, Chanwoo Lee wrote:
> From: ChanWoo Lee <cw9316.lee@samsung.com>
> 
> There is only one place where goto is used,
> and it is unnecessary to check the ret value through 'goto out'
> because the ret value is already true.
> 
> Therefore, remove the goto statement and
> integrate the '!ret' condition into the existing code.
> 
> Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/ufs/host/ufs-qcom.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 17e24270477d..8cf803806326 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -1929,7 +1929,7 @@ static int ufs_qcom_config_esi(struct ufs_hba *hba)
>  					     ufs_qcom_write_msi_msg);
>  	if (ret) {
>  		dev_err(hba->dev, "Failed to request Platform MSI %d\n", ret);
> -		goto out;
> +		return ret;
>  	}
>  
>  	msi_lock_descs(hba->dev);
> @@ -1964,11 +1964,8 @@ static int ufs_qcom_config_esi(struct ufs_hba *hba)
>  				      REG_UFS_CFG3);
>  		}
>  		ufshcd_mcq_enable_esi(hba);
> -	}
> -
> -out:
> -	if (!ret)
>  		host->esi_enabled = true;
> +	}
>  
>  	return ret;
>  }
> -- 
> 2.29.0
> 

-- 
மணிவண்ணன் சதாசிவம்

