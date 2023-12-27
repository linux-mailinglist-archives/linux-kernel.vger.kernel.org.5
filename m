Return-Path: <linux-kernel+bounces-11847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1D781EC76
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 07:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26E5EB2245C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 06:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9055397;
	Wed, 27 Dec 2023 06:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6PJY+kT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E0C5228;
	Wed, 27 Dec 2023 06:11:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B17C433C8;
	Wed, 27 Dec 2023 06:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703657465;
	bh=EbTles2opVDGaZKfZKJxC69A0Tm4AO/LxxDWp87Mq48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b6PJY+kT9ne/f1z8+DNBLcNGWxhJKg+EEixZFdmLotdeQ/w5GPlD42S+G09b6ARjG
	 hNcSTY5gUBMG2fF7Pofl4Q2nnKd2FkB/8gES0e8HuFefxgv++jO+uyH83uQ6IXSeoY
	 3jIi1QLmvDAA+9a63SecS7XrRWNezIU3LV9wLZCOVLEVek11NVb0PhNYbltc9dK9Za
	 3Q+3Rr9sN+P2iRKpcJEqlmdZ1z3i5zwd5c+luawc/Jv7XERftd0lKmHoejlwyBKrHC
	 +g2hZ4hwHb5xVCSt5Intd6/2NR7tU9m2saczP4qmoVZNXnpZD3K3/RbzyKfe3knhC/
	 Jjx9kMpevf/8w==
Date: Wed, 27 Dec 2023 11:40:53 +0530
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
Subject: Re: [PATCH RFC v2 07/11] scsi: ufs: core: Perform read back after
 writing UTP_TASK_REQ_LIST_BASE_H
Message-ID: <20231227061053.GE2814@thinkpad>
References: <20231221-ufs-reset-ensure-effect-before-delay-v2-0-75af2a9bae51@redhat.com>
 <20231221-ufs-reset-ensure-effect-before-delay-v2-7-75af2a9bae51@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231221-ufs-reset-ensure-effect-before-delay-v2-7-75af2a9bae51@redhat.com>

On Thu, Dec 21, 2023 at 12:25:24PM -0600, Andrew Halaney wrote:
> Currently, the UTP_TASK_REQ_LIST_BASE_L/UTP_TASK_REQ_LIST_BASE_H regs
> are written to and then completed with an mb().
> 
> mb() ensure that the write completes, but completion doesn't mean that
> it isn't stored in a buffer somewhere. The recommendation for
> ensuring these bits have taken effect on the device is to perform a read
> back to force it to make it all the way to the device. This is
> documented in device-io.rst and a talk by Will Deacon on this can
> be seen over here:
> 
>     https://youtu.be/i6DayghhA8Q?si=MiyxB5cKJXSaoc01&t=1678
> 
> Let's do that to ensure the bits hit the device. Because the mb()'s
> purpose wasn't to add extra ordering (on top of the ordering guaranteed
> by writel()/readl()), it can safely be removed.
> 
> Fixes: 88441a8d355d ("scsi: ufs: core: Add hibernation callbacks")
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>

This also I'm not sure whether we can safely remove readback. So,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/ufs/core/ufshcd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index d1e33328ff3f..7bfb556e5b8e 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -10351,7 +10351,7 @@ int ufshcd_system_restore(struct device *dev)
>  	 * are updated with the latest queue addresses. Only after
>  	 * updating these addresses, we can queue the new commands.
>  	 */
> -	mb();
> +	ufshcd_readl(hba, REG_UTP_TASK_REQ_LIST_BASE_H);
>  
>  	/* Resuming from hibernate, assume that link was OFF */
>  	ufshcd_set_link_off(hba);
> 
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

