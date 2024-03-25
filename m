Return-Path: <linux-kernel+bounces-117199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8915388A8A3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46C28BE7350
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53790128391;
	Mon, 25 Mar 2024 14:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2WztD+b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE865C89;
	Mon, 25 Mar 2024 14:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711375421; cv=none; b=AkbBsYbBPW7BzOITbn8enPCo9yj08aXF2EnK5OyUtMKxt4z+L6uhX2kPEpFC6ZNvMBGB0Rptkt9bOd5tAFbVjrcJSV+Hf+tS4deEGnnHQ1cd/tCHZPSd+oR37eEVs58BSfcfP5H04z8El7uqPQbpFNtTPoZmGZBtyFYorze8Fbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711375421; c=relaxed/simple;
	bh=c2zVS99udWyU0n1cfCGVbETc0ZiOOpdN9f8X1ASiXLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jVDpnA217L4X8UvktAgnDOfntZkbw6Ctopc9BSEIgKJrJ87g62ixALid3dJUCT82vxuY52RTtn2HWpOyLtlftdh9JrAoLQI995J/bhFAm8ODH3IVKunx8lCl3l+QJDanz8hy8+GiS5p8MsiOVMmSM8YaHBsO89c/SJqhtRN3H4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2WztD+b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66CAC433C7;
	Mon, 25 Mar 2024 14:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711375421;
	bh=c2zVS99udWyU0n1cfCGVbETc0ZiOOpdN9f8X1ASiXLc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r2WztD+baL87M550c1UgJ36bvvMKCmGBYxfsm+n69ymlThdRAPLD/+6pqeVAlaOTs
	 VCHHkR1q+e8LJSOfjjPaeqYhk+b0FeJGPQ/i6e9nxXk+CsWRyl/66D6NbFUaBpVJ1N
	 3vx+DUcTxY5lV7Du9WOysHkLy5I8YOrd388A/B4CRraWiiCBecCkeXa7V5uTNoEYr/
	 TUi1kEYyx9LwvNJDg2gwMTwEzD8m3kjO44idP+7h/RNNQDznewPGc10JLjwvaC5lz8
	 UajRRfpcMDEz0GAdLZDKOLW6cOQ7VXHLdU1f2o4bl9cvVxY8d2WJ7hl69KZtQwB9fM
	 YEUft56eWTddw==
Message-ID: <da4de4e0-6d13-4509-b288-a9d122d1c2d3@kernel.org>
Date: Mon, 25 Mar 2024 23:03:37 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: libsas: Add SMP request allocation handler callback
Content-Language: en-US
To: Yihang Li <liyihang9@huawei.com>, jejb@linux.ibm.com,
 martin.petersen@oracle.com, john.g.garry@oracle.com, yanaijie@huawei.com,
 chenxiang66@hisilicon.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxarm@huawei.com, prime.zeng@huawei.com, yangxingui@huawei.com
References: <20240325131751.1840329-1-liyihang9@huawei.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240325131751.1840329-1-liyihang9@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/25/24 22:17, Yihang Li wrote:
> This series [1] reducing the kmalloc() minimum alignment on arm64 to 8
> (from 128).

And ? What is the point you are trying to convey here ?

> The hisi_sas has special requirements on the memory address alignment
> (must be 16-byte-aligned) of the command request frame, so add a SMP
> request allocation callback and fill it in for the hisi_sas driver.

128 is aligned to 16. So what is the problem you are trying to solve here ?
Can you clarify ? I suspect this is all about memory allocation optimization ?

> 
> Link: https://lkml.kernel.org/r/20230612153201.554742-1-catalin.marinas@arm.com [1]
> Signed-off-by: Yihang Li <liyihang9@huawei.com>
> ---
>  drivers/scsi/hisi_sas/hisi_sas_main.c | 14 ++++++++++++
>  drivers/scsi/libsas/sas_expander.c    | 31 ++++++++++++++++++---------
>  include/scsi/libsas.h                 |  3 +++
>  3 files changed, 38 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
> index 097dfe4b620d..40329558d435 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas_main.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
> @@ -2031,6 +2031,19 @@ static int hisi_sas_write_gpio(struct sas_ha_struct *sha, u8 reg_type,
>  				reg_index, reg_count, write_data);
>  }
>  
> +static void *hisi_sas_alloc_smp_req(int size)
> +{
> +	u8 *p;
> +
> +	/* The address must be 16-byte-aligned. */

ARCH_DMA_MINALIGN is not always 16, right ?

> +	size = ALIGN(size, ARCH_DMA_MINALIGN);
> +	p = kzalloc(size, GFP_KERNEL);
> +	if (p)
> +		p[0] = SMP_REQUEST;
> +
> +	return p;
> +}
> +
>  static void hisi_sas_phy_disconnected(struct hisi_sas_phy *phy)
>  {
>  	struct asd_sas_phy *sas_phy = &phy->sas_phy;
> @@ -2130,6 +2143,7 @@ static struct sas_domain_function_template hisi_sas_transport_ops = {
>  	.lldd_write_gpio	= hisi_sas_write_gpio,
>  	.lldd_tmf_aborted	= hisi_sas_tmf_aborted,
>  	.lldd_abort_timeout	= hisi_sas_internal_abort_timeout,
> +	.lldd_alloc_smp_req	= hisi_sas_alloc_smp_req,

Why this complexity ? Why not simply modify alloc_smp_req() to have the required
alignment ? This will avoid a costly indirect function call.

>  };
>  
>  void hisi_sas_init_mem(struct hisi_hba *hisi_hba)
> diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
> index a2204674b680..0fd0507f7fc6 100644
> --- a/drivers/scsi/libsas/sas_expander.c
> +++ b/drivers/scsi/libsas/sas_expander.c
> @@ -141,6 +141,17 @@ static inline void *alloc_smp_req(int size)
>  	return p;
>  }
>  
> +static void *sas_alloc_smp_req(struct domain_device *dev, int size)
> +{
> +	struct sas_internal *i =
> +		to_sas_internal(dev->port->ha->shost->transportt);
> +
> +	if (i->dft->lldd_alloc_smp_req)
> +		return i->dft->lldd_alloc_smp_req(size);
> +
> +	return alloc_smp_req(size);
> +}
> +
>  static inline void *alloc_smp_resp(int size)
>  {
>  	return kzalloc(size, GFP_KERNEL);
> @@ -377,7 +388,7 @@ int sas_ex_phy_discover(struct domain_device *dev, int single)
>  	u8   *disc_req;
>  	struct smp_disc_resp *disc_resp;
>  
> -	disc_req = alloc_smp_req(DISCOVER_REQ_SIZE);
> +	disc_req = sas_alloc_smp_req(dev, DISCOVER_REQ_SIZE);
>  	if (!disc_req)
>  		return -ENOMEM;
>  
> @@ -440,7 +451,7 @@ static int sas_ex_general(struct domain_device *dev)
>  	int res;
>  	int i;
>  
> -	rg_req = alloc_smp_req(RG_REQ_SIZE);
> +	rg_req = sas_alloc_smp_req(dev, RG_REQ_SIZE);
>  	if (!rg_req)
>  		return -ENOMEM;
>  
> @@ -519,7 +530,7 @@ static int sas_ex_manuf_info(struct domain_device *dev)
>  	u8 *mi_resp;
>  	int res;
>  
> -	mi_req = alloc_smp_req(MI_REQ_SIZE);
> +	mi_req = sas_alloc_smp_req(dev, MI_REQ_SIZE);
>  	if (!mi_req)
>  		return -ENOMEM;
>  
> @@ -560,7 +571,7 @@ int sas_smp_phy_control(struct domain_device *dev, int phy_id,
>  	u8 *pc_resp;
>  	int res;
>  
> -	pc_req = alloc_smp_req(PC_REQ_SIZE);
> +	pc_req = sas_alloc_smp_req(dev, PC_REQ_SIZE);
>  	if (!pc_req)
>  		return -ENOMEM;
>  
> @@ -642,7 +653,7 @@ int sas_smp_get_phy_events(struct sas_phy *phy)
>  	struct sas_rphy *rphy = dev_to_rphy(phy->dev.parent);
>  	struct domain_device *dev = sas_find_dev_by_rphy(rphy);
>  
> -	req = alloc_smp_req(RPEL_REQ_SIZE);
> +	req = sas_alloc_smp_req(dev, RPEL_REQ_SIZE);
>  	if (!req)
>  		return -ENOMEM;
>  
> @@ -682,7 +693,7 @@ int sas_get_report_phy_sata(struct domain_device *dev, int phy_id,
>  			    struct smp_rps_resp *rps_resp)
>  {
>  	int res;
> -	u8 *rps_req = alloc_smp_req(RPS_REQ_SIZE);
> +	u8 *rps_req = sas_alloc_smp_req(dev, RPS_REQ_SIZE);
>  	u8 *resp = (u8 *)rps_resp;
>  
>  	if (!rps_req)
> @@ -1344,7 +1355,7 @@ static int sas_configure_present(struct domain_device *dev, int phy_id,
>  	*present = 0;
>  	*index = 0;
>  
> -	rri_req = alloc_smp_req(RRI_REQ_SIZE);
> +	rri_req = sas_alloc_smp_req(dev, RRI_REQ_SIZE);
>  	if (!rri_req)
>  		return -ENOMEM;
>  
> @@ -1412,7 +1423,7 @@ static int sas_configure_set(struct domain_device *dev, int phy_id,
>  	u8 *cri_req;
>  	u8 *cri_resp;
>  
> -	cri_req = alloc_smp_req(CRI_REQ_SIZE);
> +	cri_req = sas_alloc_smp_req(dev, CRI_REQ_SIZE);
>  	if (!cri_req)
>  		return -ENOMEM;
>  
> @@ -1627,7 +1638,7 @@ static int sas_get_phy_discover(struct domain_device *dev,
>  	int res;
>  	u8 *disc_req;
>  
> -	disc_req = alloc_smp_req(DISCOVER_REQ_SIZE);
> +	disc_req = sas_alloc_smp_req(dev, DISCOVER_REQ_SIZE);
>  	if (!disc_req)
>  		return -ENOMEM;
>  
> @@ -1723,7 +1734,7 @@ static int sas_get_ex_change_count(struct domain_device *dev, int *ecc)
>  	u8  *rg_req;
>  	struct smp_rg_resp  *rg_resp;
>  
> -	rg_req = alloc_smp_req(RG_REQ_SIZE);
> +	rg_req = sas_alloc_smp_req(dev, RG_REQ_SIZE);
>  	if (!rg_req)
>  		return -ENOMEM;
>  
> diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
> index f5257103fdb6..2e6e5f6e50db 100644
> --- a/include/scsi/libsas.h
> +++ b/include/scsi/libsas.h
> @@ -670,6 +670,9 @@ struct sas_domain_function_template {
>  	/* GPIO support */
>  	int (*lldd_write_gpio)(struct sas_ha_struct *, u8 reg_type,
>  			       u8 reg_index, u8 reg_count, u8 *write_data);
> +
> +	/* Allocation for SMP request */
> +	void *(*lldd_alloc_smp_req)(int size);
>  };
>  
>  extern int sas_register_ha(struct sas_ha_struct *);

-- 
Damien Le Moal
Western Digital Research


