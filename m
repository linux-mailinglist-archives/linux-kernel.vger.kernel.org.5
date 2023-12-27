Return-Path: <linux-kernel+bounces-11846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8910081EC72
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 07:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 291E3B20E4D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 06:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0914524C;
	Wed, 27 Dec 2023 06:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erUhCOiV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055841FC4;
	Wed, 27 Dec 2023 06:06:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57EBC433C8;
	Wed, 27 Dec 2023 06:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703657179;
	bh=yJBV8w8RZHiR2mOsBa+bvaeX3R1+l1q2z/HMcJGxe1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=erUhCOiVDZ8ZGOD2dFadIuPeUwDeLeCknS2Tmv6b0xfozgYy9/+ZVvT+kj7qK+pXu
	 sK0W65d7m8dybqO6JNYt0q4oufs9gMQm9w8zYDFE3GIw9vzH93O2qFKvuV3Mzu50/Q
	 PJj3/sQZ0FU01nTqi2uGF/oZBFoV6NNeOJANQrDRVMKKS6Hr5gXHPNmqUYngnNrn3G
	 vSr3E/EzP+ds70BRyG9ygfVPeirmzMcmBI7z1LxP5anGYdFj9LG1FcMGIqid3cXaDU
	 4v1Lb8pHxJlNWrcT7xBVIz5Pzd3bqLZsx6cGqEtdrIIu3wP6xo/+gBw3+B2ZZiYVS1
	 nJO7MzhNrmLoA==
Date: Wed, 27 Dec 2023 11:36:07 +0530
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
Subject: Re: [PATCH RFC v2 06/11] scsi: ufs: cdns-pltfrm: Perform read back
 after writing HCLKDIV
Message-ID: <20231227060607.GD2814@thinkpad>
References: <20231221-ufs-reset-ensure-effect-before-delay-v2-0-75af2a9bae51@redhat.com>
 <20231221-ufs-reset-ensure-effect-before-delay-v2-6-75af2a9bae51@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231221-ufs-reset-ensure-effect-before-delay-v2-6-75af2a9bae51@redhat.com>

On Thu, Dec 21, 2023 at 12:25:23PM -0600, Andrew Halaney wrote:
> Currently, HCLKDIV is written to and then completed with an mb().
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
> Fixes: d90996dae8e4 ("scsi: ufs: Add UFS platform driver for Cadence UFS")
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/ufs/host/cdns-pltfrm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/host/cdns-pltfrm.c b/drivers/ufs/host/cdns-pltfrm.c
> index bb30267da471..66811d8d1929 100644
> --- a/drivers/ufs/host/cdns-pltfrm.c
> +++ b/drivers/ufs/host/cdns-pltfrm.c
> @@ -136,7 +136,7 @@ static int cdns_ufs_set_hclkdiv(struct ufs_hba *hba)
>  	 * Make sure the register was updated,
>  	 * UniPro layer will not work with an incorrect value.
>  	 */
> -	mb();
> +	ufshcd_readl(hba, CDNS_UFS_REG_HCLKDIV);
>  
>  	return 0;
>  }
> 
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

