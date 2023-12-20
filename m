Return-Path: <linux-kernel+bounces-7087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 690EE81A17A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99B1F1C21F8F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F913D992;
	Wed, 20 Dec 2023 14:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3nCfqbl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFC33D96F;
	Wed, 20 Dec 2023 14:50:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9D8C433C7;
	Wed, 20 Dec 2023 14:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703083848;
	bh=RbnKwhHVCMmtzs/gnnNR6IeXwTlPNVrUWe2V3JfuahE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z3nCfqbl6K1XjAuARXoTPBFJ4X57GygwJAsgp5Bhqh5TElE38LXeIuE3xiwom6FuV
	 sj+Gks9N0DocsTEKOFN0cVX81Fw+LmZE2hSp61o93gh17Z5U35bJAaSxdpFqF02vG+
	 mTU+I2qLqsUjjO0HsEaHEtJsxGeCWAaP5PDq9qHt2N2gnvBCjlHC08RgKQ5YBbqEIo
	 vDpgk8VKOfm8jEYaWL1LTvPwzRS+YsuglKONF+ng0QclXwr8wPhOFuytfWhrlrSjYd
	 RIFHJu8uTDCMkHuU7R3kSR/s9epcDw7Z9+QMQ+19oovFil/EYNtW71p7mEa/tWYKN/
	 Eui6fDFNUu+Sg==
Date: Wed, 20 Dec 2023 20:20:31 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Can Guo <quic_cang@quicinc.com>
Cc: bvanassche@acm.org, adrian.hunter@intel.com, beanhuo@micron.com,
	avri.altman@wdc.com, junwoo80.lee@samsung.com,
	martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Alim Akhtar <alim.akhtar@samsung.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	Stanley Chu <stanley.chu@mediatek.com>,
	Asutosh Das <quic_asutoshd@quicinc.com>,
	Peter Wang <peter.wang@mediatek.com>,
	"Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
	Arthur Simchaev <Arthur.Simchaev@wdc.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: ufs: core: Let the sq_lock protect sq_tail_slot
 access
Message-ID: <20231220145031.GI3544@thinkpad>
References: <1702913550-20631-1-git-send-email-quic_cang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1702913550-20631-1-git-send-email-quic_cang@quicinc.com>

On Mon, Dec 18, 2023 at 07:32:17AM -0800, Can Guo wrote:
> If access sq_tail_slot without the protection from the sq_lock, race
> condition can have multiple SQEs copied to duplicate SQE slot(s), which can
> lead to multiple incredible stability issues. Fix it by moving the *dest
> initialization, in ufshcd_send_command(), back under protection from the
> sq_lock.
> 
> Fixes: 3c85f087faec ("scsi: ufs: mcq: Use pointer arithmetic in ufshcd_send_command()")

Cc: stable@vger.kernel.org

> Signed-off-by: Can Guo <quic_cang@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index ae9936f..2994aac 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -2274,9 +2274,10 @@ void ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag,
>  	if (is_mcq_enabled(hba)) {
>  		int utrd_size = sizeof(struct utp_transfer_req_desc);
>  		struct utp_transfer_req_desc *src = lrbp->utr_descriptor_ptr;
> -		struct utp_transfer_req_desc *dest = hwq->sqe_base_addr + hwq->sq_tail_slot;
> +		struct utp_transfer_req_desc *dest;
>  
>  		spin_lock(&hwq->sq_lock);
> +		dest = hwq->sqe_base_addr + hwq->sq_tail_slot;
>  		memcpy(dest, src, utrd_size);
>  		ufshcd_inc_sq_tail(hwq);
>  		spin_unlock(&hwq->sq_lock);
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்

