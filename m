Return-Path: <linux-kernel+bounces-127389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F167F894AA0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BED21F23FBC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9341D1863E;
	Tue,  2 Apr 2024 04:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7e1aHdr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D048A1805A;
	Tue,  2 Apr 2024 04:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712033348; cv=none; b=M1ufl/BLkbL7JzuJAVisHYRwaryBvhLkqLcxcsL1Or6QwLo11y3NXJdqug50QndG/lWr5gbrvAHh9v3IDxG/9gcXWTxwaSBBqBPSVuoximbMCS0sI4lfq8KWa7t9VaecR8OLc7I1JS8gwtsp9WVxMH5fXm/8QTe7s0m6wVoX1K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712033348; c=relaxed/simple;
	bh=deMFv+Z09/77uIkYSHktk8oFwZLK0t351nIYxAQ2gRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPKqkvJ5BRSpZlHbL0JIdX0eFGpjCnq5u0vr7MyWF5Bn7T65wanxb6PmsrlcfPLCBiAs7KllthGJMtwfEcI8MMvP59WuBv8wlATk0aOHcZMy7rVPdubUrqkeqsfYEf3RRXQ+eThpARHgN34O2Nb+nZH7zT8ix8B8ZYO4UCO5X3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7e1aHdr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3DAC433F1;
	Tue,  2 Apr 2024 04:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712033348;
	bh=deMFv+Z09/77uIkYSHktk8oFwZLK0t351nIYxAQ2gRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m7e1aHdrquLZ1SSrWYYFmKfk5TYJPrV5F4/qWbTyHS03KjurdMgYJv7NZosoYZi9h
	 RTnF/OX7x1HBPNAxeeyiT1g/g5GCOpPzRj20qvTP1aZqyXLYuaLczdGChNSdFGqTVg
	 1r4+bhu/piMyEJImGRX4yfM3dy6zqFrhWVx/Q07KXe/WaqNRQgCBya5mtNl6c7SHWA
	 Klf10yo7DHEiqBb5BkE4oCtxV4mT7FyHdOZtrmalRA/FTzDkPrQMUuuTPlJLeSEeqK
	 Yo1ZTWa1/Iu0iqpYVvuAlN1Uy3qBIzFVJCmxk6t2W4lj4QuX7zIWop9elALiF/CvpR
	 eMv9Klc9S/c4g==
Date: Tue, 2 Apr 2024 10:19:00 +0530
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
Subject: Re: [PATCH v5 10/11] scsi: ufs: core: Remove unnecessary wmb() after
 ringing doorbell
Message-ID: <20240402044900.GE2933@thinkpad>
References: <20240329-ufs-reset-ensure-effect-before-delay-v5-0-181252004586@redhat.com>
 <20240329-ufs-reset-ensure-effect-before-delay-v5-10-181252004586@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240329-ufs-reset-ensure-effect-before-delay-v5-10-181252004586@redhat.com>

On Fri, Mar 29, 2024 at 03:46:52PM -0500, Andrew Halaney wrote:
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
> But, completion and taking effect aren't necessary to guarantee here.
> 
> There's already other examples of the doorbell being rung that don't do
> this. The writel() of the doorbell guarantees prior writes by this
> thread (to the request being setup for example) complete prior to the
> ringing of the doorbell, and the following
> wait_for_completion_io_timeout() doesn't require any special memory
> barriers either.
> 
> With that in mind, just remove the wmb() altogether here.
> 
> Fixes: ad1a1b9cd67a ("scsi: ufs: commit descriptors before setting the doorbell")
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/ufs/core/ufshcd.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index dfa4f827766a..a2f2941450fd 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -7090,10 +7090,7 @@ static int __ufshcd_issue_tm_cmd(struct ufs_hba *hba,
>  
>  	/* send command to the controller */
>  	__set_bit(task_tag, &hba->outstanding_tasks);
> -
>  	ufshcd_writel(hba, 1 << task_tag, REG_UTP_TASK_REQ_DOOR_BELL);
> -	/* Make sure that doorbell is committed immediately */
> -	wmb();
>  
>  	spin_unlock_irqrestore(host->host_lock, flags);
>  
> 
> -- 
> 2.44.0
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

