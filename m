Return-Path: <linux-kernel+bounces-127385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F02D4894A95
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6BA1285F34
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EE117C8D;
	Tue,  2 Apr 2024 04:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lldcevvM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E5013AEE;
	Tue,  2 Apr 2024 04:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712033140; cv=none; b=MHXS2+DrWEF2VneKAnsTZ132LV+wLRuMFpHssxcGN526xGI8zS5+8qXVWpy1B3QMZATahnV5gwb5GAWgJUEKKzqsETcalhmDoPZd6ejFAGTx28gImzVxPCOcqW5hJ5debUaIXkDr5sMec8KbUmADUccP8aG9RepoqqEAfQ3Kxkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712033140; c=relaxed/simple;
	bh=P/mK1dfRFSt8ZMwYXQ0eLjKwfZhqrnGkRVKAy0mDLH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bD6DQZUqX5m+H0gUaZld13Yqv09GPXeO55h4sMYbHhRQMrydAw9hW9GHGdlWErboEzQimSFen9TUSTjnoHpQ8Ad9adYedUcaayva3QQVfTBE3dKfrg0g+A+8XQTJoPMtSMtAfhEwXPo4WL9B+NEZhlvZVo5JQGWVUfsc0aCriJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lldcevvM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D641C433C7;
	Tue,  2 Apr 2024 04:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712033139;
	bh=P/mK1dfRFSt8ZMwYXQ0eLjKwfZhqrnGkRVKAy0mDLH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lldcevvM6nMb0MxEG/1nqJ7IZddtFhnWFb3M1iB3AzceW25f6gyqxYIV97iaMXSK3
	 paUGiC9pG1RGQu1NRrTIz+DRUfq5LMps8oKKdhhDIGVlePHhexs7fsQVCfzrbtX4yH
	 rcuMh4KupSUyfZr3K6PNNWImxHRKWSiT+aeyzXyI4DwJfwyyBQpEFqtCwUr5xvjYmT
	 8WqzSS7/TcCIM4k7gt4BOryZWrtWtH6wGbdOjLnhGMMnDhZTPiG495ZLvi9TuEXZoc
	 uT+cUEz4NkX5jHfj31o9r4NmKx/PLoNwVIYekU34E+JrQFxLBRdxXVOQ2qQuGdDrIf
	 UWCrp1mn4TGKw==
Date: Tue, 2 Apr 2024 10:15:29 +0530
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
Subject: Re: [PATCH v5 02/11] scsi: ufs: qcom: Perform read back after
 writing REG_UFS_SYS1CLK_1US
Message-ID: <20240402044529.GB2933@thinkpad>
References: <20240329-ufs-reset-ensure-effect-before-delay-v5-0-181252004586@redhat.com>
 <20240329-ufs-reset-ensure-effect-before-delay-v5-2-181252004586@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240329-ufs-reset-ensure-effect-before-delay-v5-2-181252004586@redhat.com>

On Fri, Mar 29, 2024 at 03:46:44PM -0500, Andrew Halaney wrote:
> Currently after writing to REG_UFS_SYS1CLK_1US a mb() is used to ensure
> that write has gone through to the device.
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
> Reviewed-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/ufs/host/ufs-qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 06859e17b67b..804dc8153e7b 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -501,7 +501,7 @@ static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
>  		 * make sure above write gets applied before we return from
>  		 * this function.
>  		 */
> -		mb();
> +		ufshcd_readl(hba, REG_UFS_SYS1CLK_1US);
>  	}
>  
>  	return 0;
> 
> -- 
> 2.44.0
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

