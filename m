Return-Path: <linux-kernel+bounces-11840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9901A81EC60
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 07:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BDCAB2241D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 06:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699A25CAF;
	Wed, 27 Dec 2023 06:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/9CkDd3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EEB5668;
	Wed, 27 Dec 2023 06:01:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B540C433C8;
	Wed, 27 Dec 2023 06:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703656894;
	bh=5KBS7cLdGjQyWWqEupSKUW/EksX2rpKqU4TmWGn4AL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O/9CkDd3zpRtEelhXVPS7yeOeqe7ioRjQsvu8tHaXIafDTtj/XiyFTyO6SsASc4pC
	 RrRt23qsHLH6gkt1TAEnRqUA05Ij0r92RkWDBZKrAuzI6LBonyfvWCDdq/AyYm73Lo
	 oTVEw05K+UilQCsjDsQ59FEoCiCGsPRzuwlTmT6k725SAQcIPAcJeJvA+H/yHEz1al
	 6jCxzNCXqoStAN+sBW/rd/VMu4Mj3FlhK7/bt/pp6QKPa2eeJxLTMMnnUMm5C1SZTK
	 uEK43Nt77ZRchGrFWmCr8Ht0VMyz5YzFZaCgQKebc9qyhoNjFtTkPSEtX+gYRBam1z
	 VlFp08TXRcKUQ==
Date: Wed, 27 Dec 2023 11:31:21 +0530
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
Subject: Re: [PATCH RFC v2 04/11] scsi: ufs: qcom: Perform read back after
 writing unipro mode'
Message-ID: <20231227060121.GB2814@thinkpad>
References: <20231221-ufs-reset-ensure-effect-before-delay-v2-0-75af2a9bae51@redhat.com>
 <20231221-ufs-reset-ensure-effect-before-delay-v2-4-75af2a9bae51@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231221-ufs-reset-ensure-effect-before-delay-v2-4-75af2a9bae51@redhat.com>

On Thu, Dec 21, 2023 at 12:25:21PM -0600, Andrew Halaney wrote:
> Currently, the QUNIPRO_SEL bit is written to and then an mb() is used to
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
> Fixes: f06fcc7155dc ("scsi: ufs-qcom: add QUniPro hardware support and power optimizations")
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
>  drivers/ufs/host/ufs-qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 6df2ab3b6f23..ab1ff7432d11 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -280,7 +280,7 @@ static void ufs_qcom_select_unipro_mode(struct ufs_qcom_host *host)
>  		ufshcd_rmwl(host->hba, QUNIPRO_G4_SEL, 0, REG_UFS_CFG0);
>  
>  	/* make sure above configuration is applied before we return */
> -	mb();
> +	ufshcd_readl(host->hba, REG_UFS_CFG1);

Same comment as patch 03/11.

- Mani

>  }
>  
>  /*
> 
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

