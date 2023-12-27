Return-Path: <linux-kernel+bounces-11850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED3A81EC7D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 07:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1B3BB2242F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 06:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EF0538B;
	Wed, 27 Dec 2023 06:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nce85qwp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EC65C9C;
	Wed, 27 Dec 2023 06:13:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03545C433C7;
	Wed, 27 Dec 2023 06:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703657608;
	bh=Z0HbVb39Y0GB2FLNaCZrOecrN2XrOMtaehWwhJhRtMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nce85qwpQaLfStbrawAERY3lGpL3rAELIEEpHODCWbcxS+D6YjB4p/mUoaSOkVGhQ
	 jy8D3k2+pLkOMRPp1IuVlRl8fESpdS9IGPr8a6a7w1N3JkKWUuHz6N4uLf1sa9oT1z
	 CdIQY1lOqYXJGNzpLKesLSJVXlOX5fKvPofPLs/El6iwZBpj8TCSIuV301TfxlKbdv
	 R9Q6MI1nbg+iLIGfGdiEUv6C8qp68prE49Q11z2PNv4sSCHatToBlcU23nwodqbeTW
	 Cu5Y+GZD3rWhdHLwmTLulCbE/ZaBQigCYiLzNFUeVfKi570cc63Ng+AGDjjXzGjfA6
	 7OtB08tZVBdBw==
Date: Wed, 27 Dec 2023 11:43:17 +0530
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
Subject: Re: [PATCH RFC v2 08/11] scsi: ufs: core: Perform read back after
 disabling interrupts
Message-ID: <20231227061317.GF2814@thinkpad>
References: <20231221-ufs-reset-ensure-effect-before-delay-v2-0-75af2a9bae51@redhat.com>
 <20231221-ufs-reset-ensure-effect-before-delay-v2-8-75af2a9bae51@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231221-ufs-reset-ensure-effect-before-delay-v2-8-75af2a9bae51@redhat.com>

On Thu, Dec 21, 2023 at 12:25:25PM -0600, Andrew Halaney wrote:
> Currently, interrupts are cleared and disabled prior to registering the
> interrupt. An mb() is used to complete the clear/disable writes before
> the interrupt is registered.
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
> Let's do that to ensure these bits hit the device. Because the mb()'s
> purpose wasn't to add extra ordering (on top of the ordering guaranteed
> by writel()/readl()), it can safely be removed.
> 
> Fixes: 199ef13cac7d ("scsi: ufs: avoid spurious UFS host controller interrupts")
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>

Same comment as patch 07/11.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/ufs/core/ufshcd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 7bfb556e5b8e..bb603769b029 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -10568,7 +10568,7 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
>  	 * Make sure that UFS interrupts are disabled and any pending interrupt
>  	 * status is cleared before registering UFS interrupt handler.
>  	 */
> -	mb();
> +	ufshcd_readl(hba, REG_INTERRUPT_ENABLE);
>  
>  	/* IRQ registration */
>  	err = devm_request_irq(dev, irq, ufshcd_intr, IRQF_SHARED, UFSHCD, hba);
> 
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

