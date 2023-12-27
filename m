Return-Path: <linux-kernel+bounces-11854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8DC81EC8B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 07:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07FC61C21214
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 06:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1593D63AD;
	Wed, 27 Dec 2023 06:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtcfljAs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF936105;
	Wed, 27 Dec 2023 06:21:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209CEC433C7;
	Wed, 27 Dec 2023 06:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703658093;
	bh=uSrf39EJ3m2nWoWySm/WpjS4Iw8WDsXjJGD5Xt+c8eo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WtcfljAsXrB0OyllKXtg8mhcJCrl06MXO3isk1FLVmuY3tbWgcgunFO+vIq9Q1Q3L
	 K/+AJOPVdbx24Z2iBvA52ig2KUk4TEj7Dv8csNFB47ZA87F2CTMNnRkPllXEB3NBpZ
	 u6slESNZ6jbV+VDGCvbGYZBJZLgbxQ9SRxMCfJ7Zhx7ZqEA2BhdLi/btvtM+pGwVAi
	 ZVoGcRq1uTnqHo6Y18LlCVOSJxFFejK1Tdh+Ef7HXFPUTseOHbYbZ7ux91Q7HVOD/X
	 ryIInmXuPMukYIsb+/9X4+lxNn0Y9/iXWuNWCgh79eNHX5AdyNfSHrVKw54Go4jKzQ
	 PH4JI00KI7wEA==
Date: Wed, 27 Dec 2023 11:51:23 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Andrew Halaney <ahalaney@redhat.com>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Hannes Reinecke <hare@suse.de>, Janek Kotas <jank@cadence.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Can Guo <quic_cang@quicinc.com>, Will Deacon <will@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v3 11/11] scsi: ufs: core: Perform read back before
 writing run/stop regs
Message-ID: <20231227062123.GI2814@thinkpad>
References: <20231221-ufs-reset-ensure-effect-before-delay-v3-0-2195a1b66d2e@redhat.com>
 <20231221-ufs-reset-ensure-effect-before-delay-v3-11-2195a1b66d2e@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231221-ufs-reset-ensure-effect-before-delay-v3-11-2195a1b66d2e@redhat.com>

On Thu, Dec 21, 2023 at 01:09:57PM -0600, Andrew Halaney wrote:
> Currently a wmb() is used to ensure that writes to the
> UTP_TASK_REQ_LIST_BASE* regs are completed prior to following writes to
> the run/stop registers.
> 
> wmb() ensure that the write completes, but completion doesn't mean that
> it isn't stored in a buffer somewhere. The recommendation for
> ensuring the bits have taken effect on the device is to perform a read
> back to force it to make it all the way to the device. This is
> documented in device-io.rst and a talk by Will Deacon on this can
> be seen over here:
> 
>     https://youtu.be/i6DayghhA8Q?si=MiyxB5cKJXSaoc01&t=1678
> 
> Let's do that to ensure the bits hit the device. Because the wmb()'s
> purpose wasn't to add extra ordering (on top of the ordering guaranteed
> by writel()/readl()), it can safely be removed.
> 
> Fixes: 897efe628d7e ("scsi: ufs: add missing memory barriers")
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
>  drivers/ufs/core/ufshcd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index caebd589e08c..7c1975a1181f 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -4726,7 +4726,7 @@ int ufshcd_make_hba_operational(struct ufs_hba *hba)
>  	 * Make sure base address and interrupt setup are updated before
>  	 * enabling the run/stop registers below.
>  	 */
> -	wmb();
> +	ufshcd_readl(hba, REG_UTP_TASK_REQ_LIST_BASE_H);

I don't think the readback is really needed here. Because, the dependency is
with UTP registers and both should be in the same domain. So there is no way the
following write can happen before prior UTP write completion.

- Mani

>  
>  	/*
>  	 * UCRDY, UTMRLDY and UTRLRDY bits must be 1
> 
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

