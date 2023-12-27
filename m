Return-Path: <linux-kernel+bounces-11845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FD881EC6E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 07:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11EC5282F34
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 06:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71C953B5;
	Wed, 27 Dec 2023 06:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNjCzd0g"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4BA4C9F;
	Wed, 27 Dec 2023 06:05:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3F9C433C8;
	Wed, 27 Dec 2023 06:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703657101;
	bh=z9Ut5+T79zJ4io2Ut8tIiKTSBH8zmGKCzu0ENVeM97Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CNjCzd0goUTC7Y0K5OoM5H95LekDRNkGykp/RBYKyEYCk8FM5hMV6nc/1Vf7bRy7+
	 Yny7rz77CPhaHHGFO3xnXAEHl1rX/dKKuieDKgkBZtbMzL4V6hu76RXlhcLpHZQB4J
	 jfVstwBnOWrYzIoIf1KgrGsZb6juO6+6wq11OeNVraRJIKGSBpFxtNXzhjzoLNluUV
	 RX2w/Uw4jeZyONH/VMwVHWx0RUEpVKt6TjBR8eLsQQQq98Li1ijM9bbX6ObizyJXLE
	 FuQg/zvekHRyb5Rr4RTQnQcbMcWVlH9AOgCe2uiNacyKz1akKkELp7qs0s0OegdPbv
	 Iiquk9nTA4Lpw==
Date: Wed, 27 Dec 2023 11:34:48 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Andrew Halaney <ahalaney@redhat.com>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Yaniv Gardi <ygardi@codeaurora.org>,
	Dov Levenglick <dovl@codeaurora.org>,
	Hannes Reinecke <hare@suse.de>,
	Subhash Jadavani <subhashj@codeaurora.org>,
	Gilad Broner <gbroner@codeaurora.org>,
	Venkat Gopalakrishnan <venkatg@codeaurora.org>,
	Janek Kotas <jank@cadence.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Anjana Hari <quic_ahari@quicinc.com>,
	Dolev Raviv <draviv@codeaurora.org>,
	Can Guo <quic_cang@quicinc.com>, Will Deacon <will@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 05/11] scsi: ufs: qcom: Perform read back after
 writing CGC enable'
Message-ID: <20231227060448.GC2814@thinkpad>
References: <20231221-ufs-reset-ensure-effect-before-delay-v2-0-75af2a9bae51@redhat.com>
 <20231221-ufs-reset-ensure-effect-before-delay-v2-5-75af2a9bae51@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231221-ufs-reset-ensure-effect-before-delay-v2-5-75af2a9bae51@redhat.com>

On Thu, Dec 21, 2023 at 12:25:22PM -0600, Andrew Halaney wrote:
> Currently, the CGC enable bit is written and then an mb() is used to
> ensure that completes before continuing.
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
> Let's do that to ensure the bit hits the device. Because the mb()'s
> purpose wasn't to add extra ordering (on top of the ordering guaranteed
> by writel()/readl()), it can safely be removed.
> 
> Fixes: 81c0fc51b7a7 ("ufs-qcom: add support for Qualcomm Technologies Inc platforms")
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>

For this patch, a read back would make sense since I'm not sure if the ICE block
getting enabled afterwards is in the same domain or not.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/ufs/host/ufs-qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index ab1ff7432d11..3db19591d008 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -409,7 +409,7 @@ static void ufs_qcom_enable_hw_clk_gating(struct ufs_hba *hba)
>  		    REG_UFS_CFG2);
>  
>  	/* Ensure that HW clock gating is enabled before next operations */
> -	mb();
> +	ufshcd_readl(hba, REG_UFS_CFG2);
>  }
>  
>  static int ufs_qcom_hce_enable_notify(struct ufs_hba *hba,
> 
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

