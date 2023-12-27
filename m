Return-Path: <linux-kernel+bounces-11863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F07181ECA2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 07:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C078E1C2235B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 06:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEDD538D;
	Wed, 27 Dec 2023 06:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQrvPlfW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C07F5228;
	Wed, 27 Dec 2023 06:30:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7B6C433C7;
	Wed, 27 Dec 2023 06:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703658651;
	bh=axysAKGKpEKkYuBldpcX4OwH/06/63fo7fdgfaaiYJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lQrvPlfW/CtT5sS+oEY90/+eqaqBHhGEYLemgV/ZKcGWOjusFD97MO+09SIWOnKOo
	 tgdwO0+xBuD+X0dYrbW6kvvEQEhlc0DVt6JjrD0/kvARe7Y8Mrrf/+u9BVG0a+La/x
	 cH+jGCFdHEUUmGkBLXqJnnIgQ6s6UUPUwFt1OlXQ5xDRRVBaMikZYb8g4qIgT961Yq
	 aRWvXiarXxNcIb6V5ltQlMEMLt/vUTDfwTsqCLphFrWBouu+dJQSdsph1/N30ZLJ+6
	 ZzOwWPTdVVI2sUyluEm8Gmpqsql8oEVBD2lu3ZTDIrLQaL5CdVxaBoGB7QZDb/fJoI
	 RSoEakRp8wKjA==
Date: Wed, 27 Dec 2023 12:00:38 +0530
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
Subject: Re: [PATCH v2] ufs: mcq: Adding a function for MCQ enable
Message-ID: <20231227063038.GJ2814@thinkpad>
References: <CGME20231221065637epcas1p203dcd5cfb1d4a3964fff9543a041d78d@epcas1p2.samsung.com>
 <20231221065608.9899-1-cw9316.lee@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231221065608.9899-1-cw9316.lee@samsung.com>

On Thu, Dec 21, 2023 at 03:56:08PM +0900, Chanwoo Lee wrote:
> From: ChanWoo Lee <cw9316.lee@samsung.com>
> 
> The REG_UFS_MEM_CFG register is too general(broad)
> and it is difficult to know the meaning only with a value of 0x1.
> So far, comments were required.
> 
> Therefore, I have added new functions and defines
> to improve code readability/reusability.
> 
> Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>

I would reword the subject and description as below:

```
ufs: mcq: Add definition for REG_UFS_MEM_CFG register

Instead of hardcoding the register field, add the proper definition. While
at it, let's also use ufshcd_rmwl() to simplify updating this register.
```

- Mani
> 
> * v1->v2:
>    1) Excluding ESI_ENABLE
>    2) Replace with ufshcd_rmwl, BIT()
>    3) Separating hba->mcq_enabled
> ---
>  drivers/ufs/core/ufs-mcq.c      | 6 ++++++
>  drivers/ufs/core/ufshcd.c       | 4 +---
>  drivers/ufs/host/ufs-mediatek.c | 4 +---
>  include/ufs/ufshcd.h            | 1 +
>  include/ufs/ufshci.h            | 3 +++
>  5 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
> index 0787456c2b89..edc752e55878 100644
> --- a/drivers/ufs/core/ufs-mcq.c
> +++ b/drivers/ufs/core/ufs-mcq.c
> @@ -399,6 +399,12 @@ void ufshcd_mcq_enable_esi(struct ufs_hba *hba)
>  }
>  EXPORT_SYMBOL_GPL(ufshcd_mcq_enable_esi);
>  
> +void ufshcd_mcq_enable(struct ufs_hba *hba)
> +{
> +	ufshcd_rmwl(hba, MCQ_MODE_SELECT, MCQ_MODE_SELECT, REG_UFS_MEM_CFG);
> +}
> +EXPORT_SYMBOL_GPL(ufshcd_mcq_enable);
> +
>  void ufshcd_mcq_config_esi(struct ufs_hba *hba, struct msi_msg *msg)
>  {
>  	ufshcd_writel(hba, msg->address_lo, REG_UFS_ESILBA);
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index ae9936fc6ffb..30df6f6a72c6 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -8723,9 +8723,7 @@ static void ufshcd_config_mcq(struct ufs_hba *hba)
>  	hba->host->can_queue = hba->nutrs - UFSHCD_NUM_RESERVED;
>  	hba->reserved_slot = hba->nutrs - UFSHCD_NUM_RESERVED;
>  
> -	/* Select MCQ mode */
> -	ufshcd_writel(hba, ufshcd_readl(hba, REG_UFS_MEM_CFG) | 0x1,
> -		      REG_UFS_MEM_CFG);
> +	ufshcd_mcq_enable(hba);
>  	hba->mcq_enabled = true;
>  
>  	dev_info(hba->dev, "MCQ configured, nr_queues=%d, io_queues=%d, read_queue=%d, poll_queues=%d, queue_depth=%d\n",
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
> index d5accacae6bc..2a6989a70671 100644
> --- a/include/ufs/ufshci.h
> +++ b/include/ufs/ufshci.h
> @@ -282,6 +282,9 @@ enum {
>  /* UTMRLRSR - UTP Task Management Request Run-Stop Register 80h */
>  #define UTP_TASK_REQ_LIST_RUN_STOP_BIT		0x1
>  
> +/* REG_UFS_MEM_CFG - Global Config Registers 300h */
> +#define MCQ_MODE_SELECT 	BIT(0)
> +
>  /* CQISy - CQ y Interrupt Status Register  */
>  #define UFSHCD_MCQ_CQIS_TAIL_ENT_PUSH_STS	0x1
>  
> -- 
> 2.29.0
> 

-- 
மணிவண்ணன் சதாசிவம்

