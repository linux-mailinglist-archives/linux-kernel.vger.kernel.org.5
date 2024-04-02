Return-Path: <linux-kernel+bounces-127387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D19C8894A9B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F2AA1C223A4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290DD17C95;
	Tue,  2 Apr 2024 04:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpuOmR0/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C8513AEE;
	Tue,  2 Apr 2024 04:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712033265; cv=none; b=ASFfhgcmdJ5fifBQRR9jYMtg1LsL28JsO031X+jMR1YraG3BkcZ6YQBAGT8SYULmMtYuSbODkB53pLZimccKNAggEjif4r4fpcgv6hvOdWF4YA+fd7tryHptSsAbW3uv3n/I1z5vwLk3ocMqTlwNaGRc51wuC6YiW+iYcAT2F34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712033265; c=relaxed/simple;
	bh=fIbRMyu2FSJwTCkrEkncIv8XsK1ysTaoL3oaW3uwl6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0v1y9YuXwqpDAEaK8B4ylbElNy6U3rNr/XvnqmApAi0b53ZSFwutqb8vzsjojdZHxfAU9zLD3ZU3U77ZArCCo0Z/k6qJfOGsmNisVCJ7GMrLfIwSeDxT2f6otSpmT11FjNpcdNFBGBMb9OGSwzbNOSdYKxJAOZcSqr5kR5vzjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpuOmR0/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FDA9C433F1;
	Tue,  2 Apr 2024 04:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712033264;
	bh=fIbRMyu2FSJwTCkrEkncIv8XsK1ysTaoL3oaW3uwl6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NpuOmR0/FGJOnCZGzJ3S6AbppyjVo9LF7bPap4p2ckE+771FM64GhAKmoK/xo0+fc
	 1jq2EwzUQVmo64ifTR8ua9fqDQs92H9MSc0ucbwui7uKByvFdnROHhA+X8sWNwsWM/
	 0ECmn9CPLUF7nhZnp9eBZqgh9XQVTbSgKhqjr6bQk3EQ+uK42DUFdnCBtIcvrJtbPz
	 2Nat/T9kvXaZ+P+qbOULtjKOLIrXpAmu61kRBprdjiQYEQMnY5X26gD11f4DpyH8G3
	 WXhLjKELuFRceoooqMvcuiBErdYPps6rDPpuAbBeLq/QmDa5ISl8bIm98rMczdiP1p
	 6px8MEsOCJ8jQ==
Date: Tue, 2 Apr 2024 10:17:35 +0530
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
Subject: Re: [PATCH v5 04/11] scsi: ufs: qcom: Perform read back after
 writing unipro mode
Message-ID: <20240402044735.GD2933@thinkpad>
References: <20240329-ufs-reset-ensure-effect-before-delay-v5-0-181252004586@redhat.com>
 <20240329-ufs-reset-ensure-effect-before-delay-v5-4-181252004586@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240329-ufs-reset-ensure-effect-before-delay-v5-4-181252004586@redhat.com>

On Fri, Mar 29, 2024 at 03:46:46PM -0500, Andrew Halaney wrote:
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
> But, there's really no reason to even ensure completion before
> continuing. The only requirement here is that this write is ordered to
> this endpoint (which readl()/writel() guarantees already). For that
> reason the mb() can be dropped altogether without anything forcing
> completion.
> 
> Fixes: f06fcc7155dc ("scsi: ufs-qcom: add QUniPro hardware support and power optimizations")
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/ufs/host/ufs-qcom.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 649fada24345..66a6c95f5d72 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -278,9 +278,6 @@ static void ufs_qcom_select_unipro_mode(struct ufs_qcom_host *host)
>  
>  	if (host->hw_ver.major >= 0x05)
>  		ufshcd_rmwl(host->hba, QUNIPRO_G4_SEL, 0, REG_UFS_CFG0);
> -
> -	/* make sure above configuration is applied before we return */
> -	mb();
>  }
>  
>  /*
> 
> -- 
> 2.44.0
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

