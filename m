Return-Path: <linux-kernel+bounces-127386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE1D894A98
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0E191F239EA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A794217C95;
	Tue,  2 Apr 2024 04:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXil8fMW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C6113AEE;
	Tue,  2 Apr 2024 04:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712033205; cv=none; b=kH3bpUv5gk4bcn+9FVJWkcCtcuk+cAJJKwb0iIfN27HLA4+SbSpr2pJudaQoSDkZ4irBQw2Hi6KvpQmSA48Xi2xmXF/grrnzvG03q0hhC32IAD+pU+DFDO6AC+qgkh69KtaKKR8rD4DDsLfG2KSLSrVQww6/0lHS//ho1/vY4t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712033205; c=relaxed/simple;
	bh=lUKvUdmng502E8VV5NpfE2lmmjOMSsIYuwLta/TI1Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBe9TmuBpH2rn5H7863lo6w1URodO4WYBbc6PCs4pAF518Z6X/dYnKcN7nKhhxvMuh5Z9SttpYOjlEtAaMKg+nkT7UFCqfYYsq2PCvXVnA294bH38DZfyAKwTJtCKD8L0fOGBkQ7ktQhChQxK81xpTK6FA97AkEv0KNK433Nkeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXil8fMW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE26C433C7;
	Tue,  2 Apr 2024 04:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712033204;
	bh=lUKvUdmng502E8VV5NpfE2lmmjOMSsIYuwLta/TI1Xo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CXil8fMWVLzd/X9doPWVhGvm55DnnKrQEe37GZzXd3Wrfq6g1MNdJzgBlIEJI9SBv
	 0qwRQNM9LhXzhSk+k2+YUsV8L+pCrTNnf1YF8voBAjKahhhJwd27Z1HakERTbxfTNn
	 U5tU1AET1DTTZL8TRVRWfUQOKtp/vhUkeA89CEAwCPHJq1hDZ8xyIOzbAa2fq2I47z
	 CfTghdvyhYfUioQmwvw0UgFxQBEEHLa8efXEDi9YDnNkU34gawdo7Tnyi9dfwM+gz2
	 GoiDP9FLAQuhwjbQ51qT6sRU5VOLegABRfYX3yU3D0BS+NSslz2zwfhGRpxfST5v8H
	 2hXBiXbrr9AvA==
Date: Tue, 2 Apr 2024 10:16:35 +0530
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
Subject: Re: [PATCH v5 03/11] scsi: ufs: qcom: Remove unnecessary mb() after
 writing testbus config
Message-ID: <20240402044635.GC2933@thinkpad>
References: <20240329-ufs-reset-ensure-effect-before-delay-v5-0-181252004586@redhat.com>
 <20240329-ufs-reset-ensure-effect-before-delay-v5-3-181252004586@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240329-ufs-reset-ensure-effect-before-delay-v5-3-181252004586@redhat.com>

On Fri, Mar 29, 2024 at 03:46:45PM -0500, Andrew Halaney wrote:
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
> But, there's really no reason to even ensure completion before
> continuing. The only requirement here is that this write is ordered to
> this endpoint (which readl()/writel() guarantees already). For that
> reason the mb() can be dropped altogether without anything forcing
> completion.
> 
> Fixes: 9c46b8676271 ("scsi: ufs-qcom: dump additional testbus registers")
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/ufs/host/ufs-qcom.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 804dc8153e7b..649fada24345 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -1445,11 +1445,6 @@ int ufs_qcom_testbus_config(struct ufs_qcom_host *host)
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
> 2.44.0
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

