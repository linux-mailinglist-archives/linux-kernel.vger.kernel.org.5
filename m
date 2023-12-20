Return-Path: <linux-kernel+bounces-7066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF3181A12F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA36A1F22E40
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB3D3B2B3;
	Wed, 20 Dec 2023 14:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ax/u038B"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73043AC1A;
	Wed, 20 Dec 2023 14:34:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87BEEC433CA;
	Wed, 20 Dec 2023 14:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703082881;
	bh=iNsI8JfwO+C25hEOmVx+Z0q3QIW2jx9qavk1Utsxgy4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ax/u038BkU+2lQkEoNO6vULvumIx9BczrUQfu3Zkcpac03PvdKfZ7yn54XvC4IqG4
	 rYyIej/075WZvwXH/UO3s2WJ9vHe4rnVF2g3AnWgwHd/ZCjfDcpALbkr0ZyoGZIjL+
	 jhiYqau5FIXhITuc8XTbZvP5Vxt6nVp3jtIseZPB4j8HQLA8ZHVV6lVYD6ybhRheUJ
	 HHpkSashYQQxYjxU/kt743PGBPTlpuM/n/+kVJPuYyu/bhOjq79NAHH27vq/+2USbV
	 raw1KMS0sErTjbcDqKFkk24v43FMiM3XoNSDDDSfiVd/WQWUeMjHPOEiSB7XqP4+XR
	 BG+OeSv71QGBQ==
Date: Wed, 20 Dec 2023 20:04:22 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Chanwoo Lee <cw9316.lee@samsung.com>
Cc: alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
	jejb@linux.ibm.com, martin.petersen@oracle.com,
	peter.wang@mediatek.com, chu.stanley@gmail.com,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	stanley.chu@mediatek.com, quic_cang@quicinc.com,
	quic_asutoshd@quicinc.com, powen.kao@mediatek.com,
	quic_nguyenb@quicinc.com, yang.lee@linux.alibaba.com,
	beanhuo@micron.com, Arthur.Simchaev@wdc.com, ebiggers@google.com,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, grant.jung@samsung.com,
	jt77.jang@samsung.com, dh0421.hwang@samsung.com,
	sh043.lee@samsung.com
Subject: Re: [PATCH] ufs: mcq: Adding a function for MCQ enable
Message-ID: <20231220143422.GF3544@thinkpad>
References: <CGME20231220052749epcas1p3b90f6c03110ff5f63ffc547ef0f35907@epcas1p3.samsung.com>
 <20231220052737.19857-1-cw9316.lee@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231220052737.19857-1-cw9316.lee@samsung.com>

On Wed, Dec 20, 2023 at 02:27:37PM +0900, Chanwoo Lee wrote:
> From: ChanWoo Lee <cw9316.lee@samsung.com>
> 
> The REG_UFS_MEM_CFG register is too general(broad)
> and it is difficult to know the meaning of only values of 0x1 and 0x2.
> So far, comments were required.
> 
> Therefore, I have added new functions and defines
> to improve code readability/reusability.
> 
> Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>
> ---
>  drivers/ufs/core/ufs-mcq.c      | 10 +++++++++-
>  drivers/ufs/core/ufshcd.c       |  5 +----
>  drivers/ufs/host/ufs-mediatek.c |  4 +---
>  include/ufs/ufshcd.h            |  1 +
>  include/ufs/ufshci.h            |  4 ++++
>  5 files changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
> index 0787456c2b89..a34ef3aac540 100644
> --- a/drivers/ufs/core/ufs-mcq.c
> +++ b/drivers/ufs/core/ufs-mcq.c
> @@ -394,11 +394,19 @@ EXPORT_SYMBOL_GPL(ufshcd_mcq_make_queues_operational);
>  
>  void ufshcd_mcq_enable_esi(struct ufs_hba *hba)
>  {
> -	ufshcd_writel(hba, ufshcd_readl(hba, REG_UFS_MEM_CFG) | 0x2,
> +	ufshcd_writel(hba, ufshcd_readl(hba, REG_UFS_MEM_CFG) | ESI_ENABLE,
>  		      REG_UFS_MEM_CFG);

This change should be a separate patch.

>  }
>  EXPORT_SYMBOL_GPL(ufshcd_mcq_enable_esi);
>  
> +void ufshcd_mcq_enable(struct ufs_hba *hba)
> +{
> +	ufshcd_writel(hba, ufshcd_readl(hba, REG_UFS_MEM_CFG) | MCQ_MODE_SELECT,
> +		      REG_UFS_MEM_CFG);

Use ufshcd_rmwl().

> +	hba->mcq_enabled = true;
> +}
> +EXPORT_SYMBOL_GPL(ufshcd_mcq_enable);
> +
>  void ufshcd_mcq_config_esi(struct ufs_hba *hba, struct msi_msg *msg)
>  {
>  	ufshcd_writel(hba, msg->address_lo, REG_UFS_ESILBA);
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index ae9936fc6ffb..8195e01e7a3f 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -8723,10 +8723,7 @@ static void ufshcd_config_mcq(struct ufs_hba *hba)
>  	hba->host->can_queue = hba->nutrs - UFSHCD_NUM_RESERVED;
>  	hba->reserved_slot = hba->nutrs - UFSHCD_NUM_RESERVED;
>  
> -	/* Select MCQ mode */
> -	ufshcd_writel(hba, ufshcd_readl(hba, REG_UFS_MEM_CFG) | 0x1,
> -		      REG_UFS_MEM_CFG);
> -	hba->mcq_enabled = true;
> +	ufshcd_mcq_enable(hba);
>  
>  	dev_info(hba->dev, "MCQ configured, nr_queues=%d, io_queues=%d, read_queue=%d, poll_queues=%d, queue_depth=%d\n",
>  		 hba->nr_hw_queues, hba->nr_queues[HCTX_TYPE_DEFAULT],
> diff --git a/drivers/ufs/host/ufs-mediatek.c b/drivers/ufs/host/ufs-mediatek.c
> index fc61790d289b..1048add66419 100644
> --- a/drivers/ufs/host/ufs-mediatek.c
> +++ b/drivers/ufs/host/ufs-mediatek.c
> @@ -1219,9 +1219,7 @@ static int ufs_mtk_link_set_hpm(struct ufs_hba *hba)
>  		ufs_mtk_config_mcq(hba, false);
>  		ufshcd_mcq_make_queues_operational(hba);
>  		ufshcd_mcq_config_mac(hba, hba->nutrs);
> -		/* Enable MCQ mode */
> -		ufshcd_writel(hba, ufshcd_readl(hba, REG_UFS_MEM_CFG) | 0x1,
> -			      REG_UFS_MEM_CFG);
> +		ufshcd_mcq_enable(hba);

hba->mcq_enabled flag will be set now which is not done previously.

>  	}
>  
>  	if (err)
> diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
> index d862c8ddce03..a96c45fa4b4b 100644
> --- a/include/ufs/ufshcd.h
> +++ b/include/ufs/ufshcd.h
> @@ -1257,6 +1257,7 @@ unsigned long ufshcd_mcq_poll_cqe_lock(struct ufs_hba *hba,
>  					 struct ufs_hw_queue *hwq);
>  void ufshcd_mcq_make_queues_operational(struct ufs_hba *hba);
>  void ufshcd_mcq_enable_esi(struct ufs_hba *hba);
> +void ufshcd_mcq_enable(struct ufs_hba *hba);
>  void ufshcd_mcq_config_esi(struct ufs_hba *hba, struct msi_msg *msg);
>  
>  int ufshcd_opp_config_clks(struct device *dev, struct opp_table *opp_table,
> diff --git a/include/ufs/ufshci.h b/include/ufs/ufshci.h
> index d5accacae6bc..e669fad11fd4 100644
> --- a/include/ufs/ufshci.h
> +++ b/include/ufs/ufshci.h
> @@ -282,6 +282,10 @@ enum {
>  /* UTMRLRSR - UTP Task Management Request Run-Stop Register 80h */
>  #define UTP_TASK_REQ_LIST_RUN_STOP_BIT		0x1
>  
> +/* REG_UFS_MEM_CFG - Global Config Registers 300h */
> +#define MCQ_MODE_SELECT 	0x1
> +#define ESI_ENABLE		0x2

Use BIT() macros.

- Mani

> +
>  /* CQISy - CQ y Interrupt Status Register  */
>  #define UFSHCD_MCQ_CQIS_TAIL_ENT_PUSH_STS	0x1
>  
> -- 
> 2.29.0
> 

-- 
மணிவண்ணன் சதாசிவம்

