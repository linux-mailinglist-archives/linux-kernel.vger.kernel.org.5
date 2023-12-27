Return-Path: <linux-kernel+bounces-11853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD8681EC88
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 07:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13426B2253D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 06:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A065398;
	Wed, 27 Dec 2023 06:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+llo1X9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7538D5228;
	Wed, 27 Dec 2023 06:18:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B170EC433C7;
	Wed, 27 Dec 2023 06:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703657927;
	bh=f12A6QbCQVUZfP169hKVQL7gHb1oq0RYqXw5nplJHNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m+llo1X9SNv2aJzA5txMtfEhY3Fkia9Pm/Zwr96hdH3lt+tuFl+JqYzSIeMD25PbD
	 GeB4gyGUquDV2Vk9yEN3KE2jxkeY8kCp6g2VMNZjMuhV9qVWFjk4o1wDIDHYqNnbtX
	 8dUxEMwuNxiK6BU6Yvfh1ONbl0bY2GcJqRcYZ6vy5X4GnKNEM+INpF31TIRH320YjT
	 PAlfmfqMR9kWK1vppqszh6nG0c/1f9feopI2vi5MT4p5NaQiRQ6CWMaZf9B1NeBgRR
	 4i4jh76GazY0fKnGcL5JtrNNf1vXZuf3vmNdnEjUr/zEXxHvIxJK9vcTfeOKXB/ReX
	 h3UPKA0S/xGGg==
Date: Wed, 27 Dec 2023 11:48:37 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Andrew Halaney <ahalaney@redhat.com>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Hannes Reinecke <hare@suse.de>, Janek Kotas <jank@cadence.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Can Guo <quic_cang@quicinc.com>, Will Deacon <will@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v3 10/11] scsi: ufs: core: Perform read back to
 commit doorbell
Message-ID: <20231227061837.GH2814@thinkpad>
References: <20231221-ufs-reset-ensure-effect-before-delay-v3-0-2195a1b66d2e@redhat.com>
 <20231221-ufs-reset-ensure-effect-before-delay-v3-10-2195a1b66d2e@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231221-ufs-reset-ensure-effect-before-delay-v3-10-2195a1b66d2e@redhat.com>

On Thu, Dec 21, 2023 at 01:09:56PM -0600, Andrew Halaney wrote:
> Currently, the doorbell is written to and a wmb() is used to commit it
> immediately.
> 
> wmb() ensures that the write completes before following writes occur,
> but completion doesn't mean that it isn't stored in a buffer somewhere.
> The recommendation for ensuring this bit has taken effect on the device
> is to perform a read back to force it to make it all the way to the
> device. This is documented in device-io.rst and a talk by Will Deacon on
> this can be seen over here:
> 
>     https://youtu.be/i6DayghhA8Q?si=MiyxB5cKJXSaoc01&t=1678
> 
> Let's do that to ensure the bit hits the device. Because the wmb()'s
> purpose wasn't to add extra ordering (on top of the ordering guaranteed
> by writel()/readl()), it can safely be removed.
> 
> Fixes: ad1a1b9cd67a ("scsi: ufs: commit descriptors before setting the doorbell")
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/ufs/core/ufshcd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 75a03ee9a1ba..caebd589e08c 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -7050,7 +7050,7 @@ static int __ufshcd_issue_tm_cmd(struct ufs_hba *hba,
>  
>  	ufshcd_writel(hba, 1 << task_tag, REG_UTP_TASK_REQ_DOOR_BELL);
>  	/* Make sure that doorbell is committed immediately */
> -	wmb();
> +	ufshcd_readl(hba, REG_UTP_TASK_REQ_DOOR_BELL);
>  
>  	spin_unlock_irqrestore(host->host_lock, flags);
>  
> 
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

