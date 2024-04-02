Return-Path: <linux-kernel+bounces-127390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB954894AA3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 745B828692C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6D718028;
	Tue,  2 Apr 2024 04:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUhhC6Bo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FC717C69;
	Tue,  2 Apr 2024 04:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712033378; cv=none; b=GboywZ5WOf8T6XsSjQFBouP28xHUwuhcBNWUrOZUT4rEwh1blXL83TchmWRsOZL8/x15wanCHtXs75d6pfOkStcgm4k7jTCTT/oC1Vdv9tIeF9yaKoy7849yS2hqX5Su2K4aRWosdq8xY66RDpk+cfKrF5Jb2TfWBdZNul7sa1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712033378; c=relaxed/simple;
	bh=HQDW3ERhmazGPaTptv5BcbYjzluSXrBysFXL+s0zZTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQKZIVAE3fXX8j0zcsv5C7FiBkG/YQTQhmvC4kHVR0ea3xP++1qfuvl29aqu7/yh8oQgI5e7BIGXt+U7CUC6vnLhK0mK9ZGOa/4fz0kco8PReV9IydhlMpss8VsMLxIkh0vU5ewEngTgYv5fkmKmvtfif5xc39esEuX+XZulOsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUhhC6Bo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C899C433C7;
	Tue,  2 Apr 2024 04:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712033377;
	bh=HQDW3ERhmazGPaTptv5BcbYjzluSXrBysFXL+s0zZTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZUhhC6BorLMhZ9OipVKnviMUmboMnGAM7QgD2vHP0Pb3DPuUtRJRcmvFxo+1KPOYn
	 xTRjo+n70N/9+xNo1aCYu2GbH5cdKNbnkCxxdfy7Y1M2InC86p57u4VbUrKw2NM+r7
	 +mEodWczZ5zWVCzQufJmnjBOFaUB6f+vYPpkjlu+6YoosoTc1iuo3fIAMEbQ614V9Y
	 30Op1vzJOE4vnfmwhENdvYdjZIoi9dwBOe68OvN3pMwJgoHzgyWcWTFbxyphuwPw1t
	 FxUO0X7Uf79j0/h9ccYIMNv4WMZU9BlehJjUpRRz8qUyn8oOz1RUcXDiBlWahykLiw
	 dX4rZlYLKGydw==
Date: Tue, 2 Apr 2024 10:19:28 +0530
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
	Can Guo <quic_cang@quicinc.com>,
	Anjana Hari <quic_ahari@quicinc.com>, Will Deacon <will@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 11/11] scsi: ufs: core: Remove unnecessary wmb() prior
 to writing run/stop regs
Message-ID: <20240402044928.GF2933@thinkpad>
References: <20240329-ufs-reset-ensure-effect-before-delay-v5-0-181252004586@redhat.com>
 <20240329-ufs-reset-ensure-effect-before-delay-v5-11-181252004586@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240329-ufs-reset-ensure-effect-before-delay-v5-11-181252004586@redhat.com>

On Fri, Mar 29, 2024 at 03:46:53PM -0500, Andrew Halaney wrote:
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
> But, none of that is necessary here. All of the writel()/readl()'s here
> are to the same endpoint, so they will be ordered. There's no subsequent
> delay() etc that requires it to have taken effect already, so no
> readback is necessary here.
> 
> For that reason just drop the wmb() altogether.
> 
> Fixes: 897efe628d7e ("scsi: ufs: add missing memory barriers")
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/ufs/core/ufshcd.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index a2f2941450fd..cf6a24e550f0 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -4769,12 +4769,6 @@ int ufshcd_make_hba_operational(struct ufs_hba *hba)
>  	ufshcd_writel(hba, upper_32_bits(hba->utmrdl_dma_addr),
>  			REG_UTP_TASK_REQ_LIST_BASE_H);
>  
> -	/*
> -	 * Make sure base address and interrupt setup are updated before
> -	 * enabling the run/stop registers below.
> -	 */
> -	wmb();
> -
>  	/*
>  	 * UCRDY, UTMRLDY and UTRLRDY bits must be 1
>  	 */
> 
> -- 
> 2.44.0
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

