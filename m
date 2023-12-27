Return-Path: <linux-kernel+bounces-11835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FE981EC50
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 06:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A3061C215F3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 05:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B815238;
	Wed, 27 Dec 2023 05:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDSHgRlG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7016B4403;
	Wed, 27 Dec 2023 05:47:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 780BDC433C8;
	Wed, 27 Dec 2023 05:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703656067;
	bh=HmpjSaYrmUUsg9E2xroGEt/cOrPn7cVKnOx0gLYZpSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PDSHgRlGhvQ5EJ8TvsFa7lgIbVlMlVn/INxni06BVCcRvBbJFZAfQPP8DxLOVU2Iw
	 z2JGKDdYtQc8hSk/Pn7Ma9bjubSXUwevcK7sfUg5GwTZTUkWPXDor9U2lrh9zx+JHv
	 6rK1B6rnhYaGbA/uGGeRT919GevcHwCLPVHPgbodua7V4foksZxwGYYCo7Tg5FeO0i
	 ZqRya950f4RXRb/oPepio2Fke8tsGjPk/9GFGl74aecqz81Y9w10PEeSx4RaxP3MbM
	 jWZG4N2AiDvkvC/J7eBkyiNAUjgZr0vu/Vo954DLFeEpcwHNx25tMt1bc4jpMiGpdG
	 Lig9eDHfbZohw==
Date: Wed, 27 Dec 2023 11:17:34 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Andrew Halaney <ahalaney@redhat.com>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
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
Subject: Re: [PATCH RFC v2 03/11] scsi: ufs: qcom: Perform read back after
 writing testbus config
Message-ID: <20231227054734.GA2814@thinkpad>
References: <20231221-ufs-reset-ensure-effect-before-delay-v2-0-75af2a9bae51@redhat.com>
 <20231221-ufs-reset-ensure-effect-before-delay-v2-3-75af2a9bae51@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231221-ufs-reset-ensure-effect-before-delay-v2-3-75af2a9bae51@redhat.com>

On Thu, Dec 21, 2023 at 12:25:20PM -0600, Andrew Halaney wrote:
> Currently, the testbus configuration is written and completed with an
> mb().
> 
> mb() ensure that the write completes, but completion doesn't mean
> that it isn't stored in a buffer somewhere. The recommendation for
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
> Fixes: 9c46b8676271 ("scsi: ufs-qcom: dump additional testbus registers")
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
>  drivers/ufs/host/ufs-qcom.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 4c15c8a1d058..6df2ab3b6f23 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -1332,6 +1332,9 @@ static void ufs_qcom_enable_test_bus(struct ufs_qcom_host *host)
>  	ufshcd_rmwl(host->hba, UFS_REG_TEST_BUS_EN,
>  			UFS_REG_TEST_BUS_EN, REG_UFS_CFG1);
>  	ufshcd_rmwl(host->hba, TEST_BUS_EN, TEST_BUS_EN, REG_UFS_CFG1);
> +
> +	/* dummy read to ensure this has been enabled prior to returning */
> +	ufshcd_readl(host->hba, REG_UFS_CFG1);

In this case, I do not see the necessity to do a read back itself since there is
no delay afterwards nor any dependent operation in an altogether different
domain.

So removing the mb() should be sufficient.

- Mani

>  }
>  
>  static void ufs_qcom_get_default_testbus_cfg(struct ufs_qcom_host *host)
> @@ -1429,11 +1432,6 @@ int ufs_qcom_testbus_config(struct ufs_qcom_host *host)
>  		    (u32)host->testbus.select_minor << offset,
>  		    reg);
>  	ufs_qcom_enable_test_bus(host);
> -	/*
> -	 * Make sure the test bus configuration is
> -	 * committed before returning.
> -	 */
> -	mb();
>  
>  	return 0;
>  }
> 
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

