Return-Path: <linux-kernel+bounces-37062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D80983AAD5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 556A9B26DC9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5534177F14;
	Wed, 24 Jan 2024 13:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A+akZS5j"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC77199D9;
	Wed, 24 Jan 2024 13:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706102496; cv=none; b=LmZCT7q0nTCrzZ2C+Qj53mJgIUoz1+YiPSinx/zRef2ZC6Ed/GjaboWk56z2PTVREsKgfmvJQ0Cyq5GR0cOfTMAEknP2anvhPQNXMS+Pv7672SSjGq3+5bVnb83fEtSTfB8P4ykMu1vjpNzSG7YUBwt324WyRDFfrAOJ/wUrYHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706102496; c=relaxed/simple;
	bh=m3dRMirxq8C0jQkim9SM7x/xNu3NYNIzun3a1uRs+tU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwtIcGIPP/z4iIAvUfS4SGb752eYGwHbfbxWfdmoKheFTSBr2FHULsoSnJwPQSjsKDUyR2x5y1AgFB7Ibk26f4CwRctOYJvIkC+tdUAyBBf9MSGGaYzDOBkggNoOTl7UsqG7LK+LdAwuZ3wrRE3noDUSYFJd08YcK9fezHshGL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A+akZS5j; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706102494; x=1737638494;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m3dRMirxq8C0jQkim9SM7x/xNu3NYNIzun3a1uRs+tU=;
  b=A+akZS5j7STA3u0PTiMqtZUAB0gKMcO9/NnYMvt9e4iNNVeC9tNxaEjh
   E+cdoAENgChhgHDIM5MCQEoy7ZaSAwNGTf4nck7CSzlXW1Xde6HPYjRfc
   5DzQXqinYKW0JC41jT1FpFGjmo7oJ8NecZfJL3P6N/OxOvKQAB/KJsv+U
   JeXIFju3HVkgW0siJqbR78iJaL8qX52/t9RTfWpNTumg3zoWLEzCO9NNw
   PyDu85gGWY4iksELJflih8FbI1pFEwnupFwPc8J+eisqlRvbSYO5XmC3P
   4K1mAm1HXQSUSVIgzsvwv7TPbagQwjelcSXs5pGndazAeBG8rKnT4sWwX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="15363812"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="15363812"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 05:21:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="929682529"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="929682529"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 24 Jan 2024 05:21:29 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 24 Jan 2024 15:21:29 +0200
Date: Wed, 24 Jan 2024 15:21:29 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Haotien Hsu <haotienh@nvidia.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Utkarsh Patel <utkarsh.h.patel@intel.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Sing-Han Chen <singhanc@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Wayne Chang <waynec@nvidia.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, WK Tsai <wtsai@nvidia.com>
Subject: Re: [PATCH v7] ucsi_ccg: Refine the UCSI Interrupt handling
Message-ID: <ZbEO2eleoUSYKygw@kuha.fi.intel.com>
References: <20240119023409.659452-1-haotienh@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119023409.659452-1-haotienh@nvidia.com>

Hi,

On Fri, Jan 19, 2024 at 10:34:09AM +0800, Haotien Hsu wrote:
> With the Cypress CCGx Type-C controller the following error is
> sometimes observed on boot:
> [   16.087147] ucsi_ccg 1-0008: failed to reset PPM!
> [   16.087319] ucsi_ccg 1-0008: PPM init failed (-110)
> 
> When the above timeout occurs the following happens:
> 1. The function ucsi_reset_ppm() is called to reset UCSI controller.
>    This function performs an async write to start reset and then
>    polls for completion.
> 2. An interrupt occurs when the reset completes. In the interrupt
>    handler, the OPM field in the INTR_REG is cleared and this clears
>    the CCI data in the PPM. Hence, the reset completion status is
>    cleared.
> 3. The function ucsi_reset_ppm() continues to poll for the reset
>    completion, but has missed the reset completion event and
>    eventually timeouts.
> 
> In this patch, we store CCI when handling the interrupt and make
> reading after async write gets the correct value.
> 
> To align with the CCGx UCSI interface guide, this patch updates the
> driver to copy CCI and MESSAGE_IN before they are reset when UCSI
> interrupt acknowledged.
> 
> When a new command is sent, the driver will clear the old CCI to avoid
> ucsi_ccg_read() getting wrong CCI after ucsi_ccg_async_write() when
> the UCSI interrupt is not handled.
> 
> Finally, acking the UCSI_READ_INT interrupt before calling complete()
> in ISR to ensure that the ucsi_ccg_sync_write() would wait for the
> interrupt handling to complete.
> 
> Signed-off-by: Sing-Han Chen <singhanc@nvidia.com>
> Signed-off-by: Haotien Hsu <haotienh@nvidia.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> V1->V2
> - Fix uninitialized symbol 'cci'
> v2->v3
> - Remove misusing Reported-by tags
> v3->v4
> - Add comments for op_lock
> v4->v5
> - Specify the endianness of registers in struct op_region
> - Replace ccg_op_region_read() with inline codes
> - Replace ccg_op_region_clean() with inline codes
> - Replace stack memory with GFP_ATOMIC allocated memory in ccg_op_region_update()
> - Add comments for resetting CCI in ucsi_ccg_async_write()
> v5->v6
> - Fix sparse warning: incorrect type in assignment
> v6->v7
> - Move changelog to below
> ---
>  drivers/usb/typec/ucsi/ucsi_ccg.c | 92 ++++++++++++++++++++++++++++---
>  1 file changed, 84 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
> index 449c125f6f87..dda7c7c94e08 100644
> --- a/drivers/usb/typec/ucsi/ucsi_ccg.c
> +++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
> @@ -192,6 +192,12 @@ struct ucsi_ccg_altmode {
>  	bool checked;
>  } __packed;
>  
> +#define CCGX_MESSAGE_IN_MAX 4
> +struct op_region {
> +	__le32 cci;
> +	__le32 message_in[CCGX_MESSAGE_IN_MAX];
> +};
> +
>  struct ucsi_ccg {
>  	struct device *dev;
>  	struct ucsi *ucsi;
> @@ -222,6 +228,13 @@ struct ucsi_ccg {
>  	bool has_multiple_dp;
>  	struct ucsi_ccg_altmode orig[UCSI_MAX_ALTMODES];
>  	struct ucsi_ccg_altmode updated[UCSI_MAX_ALTMODES];
> +
> +	/*
> +	 * This spinlock protects op_data which includes CCI and MESSAGE_IN that
> +	 * will be updated in ISR
> +	 */
> +	spinlock_t op_lock;
> +	struct op_region op_data;
>  };
>  
>  static int ccg_read(struct ucsi_ccg *uc, u16 rab, u8 *data, u32 len)
> @@ -305,12 +318,42 @@ static int ccg_write(struct ucsi_ccg *uc, u16 rab, const u8 *data, u32 len)
>  	return 0;
>  }
>  
> +static int ccg_op_region_update(struct ucsi_ccg *uc, u32 cci)
> +{
> +	u16 reg = CCGX_RAB_UCSI_DATA_BLOCK(UCSI_MESSAGE_IN);
> +	struct op_region *data = &uc->op_data;
> +	unsigned char *buf;
> +	size_t size = sizeof(data->message_in);
> +
> +	buf = kzalloc(size, GFP_ATOMIC);
> +	if (!buf)
> +		return -ENOMEM;
> +	if (UCSI_CCI_LENGTH(cci)) {
> +		int ret = ccg_read(uc, reg, (void *)buf, size);
> +
> +		if (ret) {
> +			kfree(buf);
> +			return ret;
> +		}
> +	}
> +
> +	spin_lock(&uc->op_lock);
> +	data->cci = cpu_to_le32(cci);
> +	if (UCSI_CCI_LENGTH(cci))
> +		memcpy(&data->message_in, buf, size);
> +	spin_unlock(&uc->op_lock);
> +	kfree(buf);
> +	return 0;
> +}
> +
>  static int ucsi_ccg_init(struct ucsi_ccg *uc)
>  {
>  	unsigned int count = 10;
>  	u8 data;
>  	int status;
>  
> +	spin_lock_init(&uc->op_lock);
> +
>  	data = CCGX_RAB_UCSI_CONTROL_STOP;
>  	status = ccg_write(uc, CCGX_RAB_UCSI_CONTROL, &data, sizeof(data));
>  	if (status < 0)
> @@ -520,9 +563,20 @@ static int ucsi_ccg_read(struct ucsi *ucsi, unsigned int offset,
>  	u16 reg = CCGX_RAB_UCSI_DATA_BLOCK(offset);
>  	struct ucsi_capability *cap;
>  	struct ucsi_altmode *alt;
> -	int ret;
> +	int ret = 0;
> +
> +	if (offset == UCSI_CCI) {
> +		spin_lock(&uc->op_lock);
> +		memcpy(val, &(uc->op_data).cci, val_len);
> +		spin_unlock(&uc->op_lock);
> +	} else if (offset == UCSI_MESSAGE_IN) {
> +		spin_lock(&uc->op_lock);
> +		memcpy(val, &(uc->op_data).message_in, val_len);
> +		spin_unlock(&uc->op_lock);
> +	} else {
> +		ret = ccg_read(uc, reg, val, val_len);
> +	}
>  
> -	ret = ccg_read(uc, reg, val, val_len);
>  	if (ret)
>  		return ret;
>  
> @@ -559,9 +613,18 @@ static int ucsi_ccg_read(struct ucsi *ucsi, unsigned int offset,
>  static int ucsi_ccg_async_write(struct ucsi *ucsi, unsigned int offset,
>  				const void *val, size_t val_len)
>  {
> +	struct ucsi_ccg *uc = ucsi_get_drvdata(ucsi);
>  	u16 reg = CCGX_RAB_UCSI_DATA_BLOCK(offset);
>  
> -	return ccg_write(ucsi_get_drvdata(ucsi), reg, val, val_len);
> +	/*
> +	 * UCSI may read CCI instantly after async_write,
> +	 * clear CCI to avoid caller getting wrong data before we get CCI from ISR
> +	 */
> +	spin_lock(&uc->op_lock);
> +	uc->op_data.cci = 0;
> +	spin_unlock(&uc->op_lock);
> +
> +	return ccg_write(uc, reg, val, val_len);
>  }
>  
>  static int ucsi_ccg_sync_write(struct ucsi *ucsi, unsigned int offset,
> @@ -615,13 +678,18 @@ static irqreturn_t ccg_irq_handler(int irq, void *data)
>  	u16 reg = CCGX_RAB_UCSI_DATA_BLOCK(UCSI_CCI);
>  	struct ucsi_ccg *uc = data;
>  	u8 intr_reg;
> -	u32 cci;
> -	int ret;
> +	u32 cci = 0;
> +	int ret = 0;
>  
>  	ret = ccg_read(uc, CCGX_RAB_INTR_REG, &intr_reg, sizeof(intr_reg));
>  	if (ret)
>  		return ret;
>  
> +	if (!intr_reg)
> +		return IRQ_HANDLED;
> +	else if (!(intr_reg & UCSI_READ_INT))
> +		goto err_clear_irq;
> +
>  	ret = ccg_read(uc, reg, (void *)&cci, sizeof(cci));
>  	if (ret)
>  		goto err_clear_irq;
> @@ -629,13 +697,21 @@ static irqreturn_t ccg_irq_handler(int irq, void *data)
>  	if (UCSI_CCI_CONNECTOR(cci))
>  		ucsi_connector_change(uc->ucsi, UCSI_CCI_CONNECTOR(cci));
>  
> -	if (test_bit(DEV_CMD_PENDING, &uc->flags) &&
> -	    cci & (UCSI_CCI_ACK_COMPLETE | UCSI_CCI_COMMAND_COMPLETE))
> -		complete(&uc->complete);
> +	/*
> +	 * As per CCGx UCSI interface guide, copy CCI and MESSAGE_IN
> +	 * to the OpRegion before clear the UCSI interrupt
> +	 */
> +	ret = ccg_op_region_update(uc, cci);
> +	if (ret)
> +		goto err_clear_irq;
>  
>  err_clear_irq:
>  	ccg_write(uc, CCGX_RAB_INTR_REG, &intr_reg, sizeof(intr_reg));
>  
> +	if (!ret && test_bit(DEV_CMD_PENDING, &uc->flags) &&
> +	    cci & (UCSI_CCI_ACK_COMPLETE | UCSI_CCI_COMMAND_COMPLETE))
> +		complete(&uc->complete);
> +
>  	return IRQ_HANDLED;
>  }
>  
> -- 
> 2.34.1

-- 
heikki

