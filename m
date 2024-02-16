Return-Path: <linux-kernel+bounces-69174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F27C85855D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1555B1F25C3D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D861350ED;
	Fri, 16 Feb 2024 18:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3igEePE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EC812FB18;
	Fri, 16 Feb 2024 18:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708108757; cv=none; b=N3CQah54tOtbBkgEEpmcVX6os8A7/6OVGNkN5vzbWDJq/vDYYNycTy2hk10wPs53Hh5PO04QmhXlcGgU4OWGrulqfB/E27SzTSF84fz4/oAK4ypSy/NmKvD9LAnGoWsnBEZhGBiZaxzr868btLKKq82ObsqUVnUi+x/w+4gC/TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708108757; c=relaxed/simple;
	bh=c52Bjk2RQnn7DIN2AN3Dt13KP2BKtoclcR7LSa6bwgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvSFSnL8ghRMaPF9S80X/yTBB6ZBIaLREwirBHXwbaOQ42gP9GNnw/qOhPvJl8LFtmXnY9lZidqkGOAyt7HolhYw3lty+GpWGECiMlrFWANvcEQKCNOvHCU+bt5d70P7hTqdF3aGUkpdtan4LDNmsSWkq8AemM7hkMusOJZb+Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3igEePE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE102C433F1;
	Fri, 16 Feb 2024 18:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708108756;
	bh=c52Bjk2RQnn7DIN2AN3Dt13KP2BKtoclcR7LSa6bwgE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P3igEePEy1/PnswfNRWUu+JU7dPo6agq07TwhdbIMZqb7HTGvrfAHN0bZ0mx7pIm6
	 g+6ojphnhIrXU6rG3tJTPQ3smk4UPoAuhjSV2ZblYRfh6L+EZlQ7wvyzvtM6NE2Rh+
	 KaWcMyUoA13HOqD/KOLXACONwvaaU6dbUdE6+nb6J2zn5M19HnhDRKwuwej7ZIr2E4
	 mJuktNaCneKE2AuDh9V+YQQwBu2jNRb8epndhA0vghGllgf7QVvbwODZLNJ0nfixcb
	 MG5NYM7ptJXaM8mzKlWznplyHTwIe2I1Low0Y71J4A+dvT+3byreoujfIHzXluUpqP
	 nEqD9/fQwQ4DQ==
Date: Fri, 16 Feb 2024 12:39:14 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Mukesh Ojha <quic_mojha@quicinc.com>
Cc: konrad.dybcio@linaro.org, linus.walleij@linaro.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v11 1/4] firmware: qcom: scm: provide a read-modify-write
 function
Message-ID: <jyfpwd3jiwwqgbap3vk7uzhumqaj2rt2udiakink7rgxk4k5le@hqclapr7wizu>
References: <1704727654-13999-1-git-send-email-quic_mojha@quicinc.com>
 <1704727654-13999-2-git-send-email-quic_mojha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1704727654-13999-2-git-send-email-quic_mojha@quicinc.com>

On Mon, Jan 08, 2024 at 08:57:31PM +0530, Mukesh Ojha wrote:
> It was realized by Srinivas K. that there is a need of

"need" is a strong word for this functionality, unless there's some use
case that I'm missing.

> read-modify-write scm exported function so that it can
> be used by multiple clients.
> 
> Let's introduce qcom_scm_io_rmw() which masks out the bits
> and write the passed value to that bit-offset.
> 
> Suggested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> Tested-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com> # IPQ9574 and IPQ5332
> ---
>  drivers/firmware/qcom/qcom_scm.c       | 26 ++++++++++++++++++++++++++
>  include/linux/firmware/qcom/qcom_scm.h |  1 +
>  2 files changed, 27 insertions(+)
> 
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index 520de9b5633a..25549178a30f 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -19,6 +19,7 @@
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
> +#include <linux/spinlock.h>
>  #include <linux/reset-controller.h>
>  #include <linux/types.h>
>  
> @@ -41,6 +42,8 @@ struct qcom_scm {
>  	int scm_vote_count;
>  
>  	u64 dload_mode_addr;
> +	/* Atomic context only */
> +	spinlock_t lock;
>  };
>  
>  struct qcom_scm_current_perm_info {
> @@ -481,6 +484,28 @@ static int qcom_scm_disable_sdi(void)
>  	return ret ? : res.result[0];
>  }
>  
> +int qcom_scm_io_rmw(phys_addr_t addr, unsigned int mask, unsigned int val)
> +{
> +	unsigned int old, new;
> +	int ret;
> +
> +	if (!__scm)
> +		return -EINVAL;
> +
> +	spin_lock(&__scm->lock);

Please express that this lock is just for create mutual exclusion
between rmw operations, nothing else.

Also please make a statement why this is desirable and/or needed.

Regards,
Bjorn

> +	ret = qcom_scm_io_readl(addr, &old);
> +	if (ret)
> +		goto unlock;
> +
> +	new = (old & ~mask) | (val & mask);
> +
> +	ret = qcom_scm_io_writel(addr, new);
> +unlock:
> +	spin_unlock(&__scm->lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(qcom_scm_io_rmw);
> +
>  static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
>  {
>  	struct qcom_scm_desc desc = {
> @@ -1824,6 +1849,7 @@ static int qcom_scm_probe(struct platform_device *pdev)
>  		return ret;
>  
>  	mutex_init(&scm->scm_bw_lock);
> +	spin_lock_init(&scm->lock);
>  
>  	scm->path = devm_of_icc_get(&pdev->dev, NULL);
>  	if (IS_ERR(scm->path))
> diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
> index ccaf28846054..3a8bb2e603b3 100644
> --- a/include/linux/firmware/qcom/qcom_scm.h
> +++ b/include/linux/firmware/qcom/qcom_scm.h
> @@ -82,6 +82,7 @@ bool qcom_scm_pas_supported(u32 peripheral);
>  
>  int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val);
>  int qcom_scm_io_writel(phys_addr_t addr, unsigned int val);
> +int qcom_scm_io_rmw(phys_addr_t addr, unsigned int mask, unsigned int val);
>  
>  bool qcom_scm_restore_sec_cfg_available(void);
>  int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare);
> -- 
> 2.7.4
> 

