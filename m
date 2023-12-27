Return-Path: <linux-kernel+bounces-11852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EACC981EC84
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 07:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96EFF1F22CC8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 06:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605535398;
	Wed, 27 Dec 2023 06:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThxYqMvO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8035228;
	Wed, 27 Dec 2023 06:16:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00222C433C7;
	Wed, 27 Dec 2023 06:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703657815;
	bh=xeDTzdrMNGeLNsQQDrVyYpHIyrS5BKqx04uyRK+srLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ThxYqMvO1YjI9pkuJybIpFlVa3JMqPU6xE+JhsU9wQVZk5BZA7v2sYgZupMJlLZk9
	 Iz9dzP/ArKrQw6B+WZN9rDgkEG2/N3yxVK9PN6fxsqS4hPO5WUbsenbX7fsIKLczrZ
	 hv09IIaaJhzvtxI4Jd53qQjb7Qh7pS2hCmNFQVsk74wzA22hUj+TLoGdlTYHd4VIT7
	 8RnLSWL/TFOqqcW3naaapGRqv4JKL1RQbQEFvCWuaDwQWwXvmlaCA60jf+m9bCGaAX
	 oWSiztiyvr9xNiFQsNLHqFVksxd9DMovNgHdoMPviPhm8p/g60KEOSYWuWMm0ppXI+
	 R4ZKXx8KowVYQ==
Date: Wed, 27 Dec 2023 11:46:43 +0530
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
Subject: Re: [PATCH RFC v3 09/11] scsi: ufs: core: Perform read back after
 disabling UIC_COMMAND_COMPL
Message-ID: <20231227061643.GG2814@thinkpad>
References: <20231221-ufs-reset-ensure-effect-before-delay-v3-0-2195a1b66d2e@redhat.com>
 <20231221-ufs-reset-ensure-effect-before-delay-v3-9-2195a1b66d2e@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231221-ufs-reset-ensure-effect-before-delay-v3-9-2195a1b66d2e@redhat.com>

On Thu, Dec 21, 2023 at 01:09:55PM -0600, Andrew Halaney wrote:
> Currently, the UIC_COMMAND_COMPL interrupt is disabled and a wmb() is
> used to complete the register write before any following writes.
> 
> wmb() ensures the writes complete in that order, but completion doesn't
> mean that it isn't stored in a buffer somewhere. The recommendation for
> ensuring this bit has taken effect on the device is to perform a read
> back to force it to make it all the way to the device. This is
> documented in device-io.rst and a talk by Will Deacon on this can
> be seen over here:
> 
>     https://youtu.be/i6DayghhA8Q?si=MiyxB5cKJXSaoc01&t=1678
> 
> Let's do that to ensure the bit hits the device. Because the wmb()'s
> purpose wasn't to add extra ordering (on top of the ordering guaranteed
> by writel()/readl()), it can safely be removed.
> 
> Fixes: d75f7fe495cf ("scsi: ufs: reduce the interrupts for power mode change requests")
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/ufs/core/ufshcd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index bb603769b029..75a03ee9a1ba 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -4240,7 +4240,7 @@ static int ufshcd_uic_pwr_ctrl(struct ufs_hba *hba, struct uic_command *cmd)
>  		 * Make sure UIC command completion interrupt is disabled before
>  		 * issuing UIC command.
>  		 */
> -		wmb();
> +		ufshcd_readl(hba, REG_INTERRUPT_ENABLE);
>  		reenable_intr = true;
>  	}
>  	spin_unlock_irqrestore(hba->host->host_lock, flags);
> 
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

