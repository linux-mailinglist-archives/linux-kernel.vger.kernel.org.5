Return-Path: <linux-kernel+bounces-44622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDED842532
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 562F91F229C7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB8E6BB22;
	Tue, 30 Jan 2024 12:42:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3C067A0B;
	Tue, 30 Jan 2024 12:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706618533; cv=none; b=t5NrglwGnPnIh6AFBLLsQiSq9y6koa1Qa6LzL56Hecfx5g9boTvH5uVB9DLpsVW50tEh2pjHNmNv7n0pDETF370d+TVEdzLdpeWH1lmEor0okKlS5K7XjyvvDGWgb/m50FXCbt7BwBWXpMvhOlcUvDdzl9JfRO4YnlCOEPqVvnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706618533; c=relaxed/simple;
	bh=DqCdDRfs3WNc2QtgxlAVEGlg6LCJDeNrFmzrcg5r+sU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PzxuVubZd5kgSMwcW/u+h5ZDWLj0UWtiaw2GXtHDjKqU/4r1gULHBauIh6hKASFUpsHFoEmJT1ZXtrUWsetpq3OULoFxG9ngaYMq/Dxp9mjzd/l/HJ2aBJH3iXPZoozTct35R/M9xLk6VsZVi6YSA+aGR3J2Pb3Z/yhH5a7oJYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 262DEDA7;
	Tue, 30 Jan 2024 04:42:54 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4DA833F762;
	Tue, 30 Jan 2024 04:42:05 -0800 (PST)
Message-ID: <2585ee0b-a898-46f8-b242-e74c0a78f672@arm.com>
Date: Tue, 30 Jan 2024 12:42:03 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/10] coresight-tpdm: Add timestamp control register
 support for the CMB
Content-Language: en-US
To: Tao Zhang <quic_taozha@quicinc.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Konrad Dybcio <konradybcio@gmail.com>, Mike Leach <mike.leach@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Jinlong Mao <quic_jinlmao@quicinc.com>, Leo Yan <leo.yan@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Tingwei Zhang <quic_tingweiz@quicinc.com>,
 Yuanfang Zhang <quic_yuanfang@quicinc.com>,
 Trilok Soni <quic_tsoni@quicinc.com>, Song Chai <quic_songchai@quicinc.com>,
 linux-arm-msm@vger.kernel.org, andersson@kernel.org
References: <1706605366-31705-1-git-send-email-quic_taozha@quicinc.com>
 <1706605366-31705-9-git-send-email-quic_taozha@quicinc.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1706605366-31705-9-git-send-email-quic_taozha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/01/2024 09:02, Tao Zhang wrote:
> CMB_TIER register is CMB subunit timestamp insertion enable register.
> Bit 0 is PATT_TSENAB bit. Set this bit to 1 to request a timestamp
> following a CMB interface pattern match. Bit 1 is XTRIG_TSENAB bit.
> Set this bit to 1 to request a timestamp following a CMB CTI timestamp
> request. Bit 2 is TS_ALL bit. Set this bit to 1 to request timestamp
> for all packets.
> 
> Reviewed-by: James Clark <james.clark@arm.com>
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> Signed-off-by: Jinlong Mao <quic_jinlmao@quicinc.com>
> ---
>   .../testing/sysfs-bus-coresight-devices-tpdm  |  35 +++++
>   drivers/hwtracing/coresight/coresight-tpdm.c  | 121 +++++++++++++++++-
>   drivers/hwtracing/coresight/coresight-tpdm.h  |  31 +++++
>   3 files changed, 180 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> index b6cf050861ed..e8c76ce4dd15 100644
> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> @@ -214,3 +214,38 @@ KernelVersion	6.9
>   Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
>   Description:
>   		(RW) Set/Get the mask of the pattern for the CMB subunit TPDM.
> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/cmb_patt/enable_ts
> +Date:		January 2024
> +KernelVersion	6.9
> +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:
> +		(Write) Set the pattern timestamp of CMB tpdm. Read
> +		the pattern timestamp of CMB tpdm.
> +
> +		Accepts only one of the 2 values -  0 or 1.
> +		0 : Disable CMB pattern timestamp.
> +		1 : Enable CMB pattern timestamp.
> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/cmb_trig_ts
> +Date:		January 2024
> +KernelVersion	6.9
> +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:
> +		(RW) Set/Get the trigger timestamp of the CMB for tpdm.
> +
> +		Accepts only one of the 2 values -  0 or 1.
> +		0 : Set the CMB trigger type to false
> +		1 : Set the CMB trigger type to true
> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/cmb_ts_all
> +Date:		January 2024
> +KernelVersion	6.9
> +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:
> +		(RW) Read or write the status of timestamp upon all interface.
> +		Only value 0 and 1  can be written to this node. Set this node to 1 to requeset
> +		timestamp to all trace packet.
> +		Accepts only one of the 2 values -  0 or 1.
> +		0 : Disable the timestamp of all trace packets.
> +		1 : Enable the timestamp of all trace packets.
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> index 07587287d9fa..22966d541230 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
> @@ -322,6 +322,31 @@ static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
>   	writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
>   }
>   
> +static void set_cmb_tier(struct tpdm_drvdata *drvdata)
> +{
> +	u32 val;
> +
> +	val = readl_relaxed(drvdata->base + TPDM_CMB_TIER);
> +
> +	/* Clear all relevant fields */
> +	val &= ~(TPDM_CMB_TIER_PATT_TSENAB | TPDM_CMB_TIER_TS_ALL |
> +		 TPDM_CMB_TIER_XTRIG_TSENAB);
> +
> +	/* Set pattern timestamp type and enablement */
> +	if (drvdata->cmb->patt_ts)
> +		val |= TPDM_CMB_TIER_PATT_TSENAB;
> +
> +	/* Set trigger timestamp */
> +	if (drvdata->cmb->trig_ts)
> +		val |= TPDM_CMB_TIER_XTRIG_TSENAB;
> +
> +	/* Set all timestamp enablement*/
> +	if (drvdata->cmb->ts_all)
> +		val |= TPDM_CMB_TIER_TS_ALL;
> +
> +	writel_relaxed(val, drvdata->base + TPDM_CMB_TIER);
> +}
> +
>   static void tpdm_enable_cmb(struct tpdm_drvdata *drvdata)
>   {
>   	u32 val, i;
> @@ -341,6 +366,8 @@ static void tpdm_enable_cmb(struct tpdm_drvdata *drvdata)
>   			drvdata->base + TPDM_CMB_XPMR(i));
>   	}
>   
> +	set_cmb_tier(drvdata);
> +
>   	val = readl_relaxed(drvdata->base + TPDM_CMB_CR);
>   	/*
>   	 * Set to 0 for continuous CMB collection mode,
> @@ -687,9 +714,18 @@ static ssize_t enable_ts_show(struct device *dev,
>   			      char *buf)
>   {
>   	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	struct tpdm_dataset_attribute *tpdm_attr =
> +		container_of(attr, struct tpdm_dataset_attribute, attr);
> +	ssize_t size = -EINVAL;
>   
> -	return sysfs_emit(buf, "%u\n",
> -			 (unsigned int)drvdata->dsb->patt_ts);
> +	if (tpdm_attr->mem == DSB_PATT)
> +		size = sysfs_emit(buf, "%u\n",
> +				  (unsigned int)drvdata->dsb->patt_ts);
> +	else if (tpdm_attr->mem == CMB_PATT)
> +		size = sysfs_emit(buf, "%u\n",
> +				  (unsigned int)drvdata->cmb->patt_ts);
> +
> +	return size;
>   }
>   
>   /*
> @@ -701,17 +737,23 @@ static ssize_t enable_ts_store(struct device *dev,
>   			       size_t size)
>   {
>   	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	struct tpdm_dataset_attribute *tpdm_attr =
> +		container_of(attr, struct tpdm_dataset_attribute, attr);
>   	unsigned long val;
>   
>   	if ((kstrtoul(buf, 0, &val)) || (val & ~1UL))
>   		return -EINVAL;
>   
> -	spin_lock(&drvdata->spinlock);
> -	drvdata->dsb->patt_ts = !!val;
> -	spin_unlock(&drvdata->spinlock);
> +	guard(spinlock)(&drvdata->spinlock);
> +	if (tpdm_attr->mem == DSB_PATT)
> +		drvdata->dsb->patt_ts = !!val;
> +	else if (tpdm_attr->mem == CMB_PATT)
> +		drvdata->cmb->patt_ts = !!val;
> +	else
> +		return -EINVAL;
> +
>   	return size;
>   }
> -static DEVICE_ATTR_RW(enable_ts);
>   
>   static ssize_t set_type_show(struct device *dev,
>   			     struct device_attribute *attr,
> @@ -842,6 +884,68 @@ static ssize_t cmb_mode_store(struct device *dev,
>   }
>   static DEVICE_ATTR_RW(cmb_mode);
>   
> +static ssize_t cmb_ts_all_show(struct device *dev,
> +			       struct device_attribute *attr,
> +			       char *buf)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +
> +	return sysfs_emit(buf, "%u\n",
> +			  (unsigned int)drvdata->cmb->ts_all);
> +}
> +
> +static ssize_t cmb_ts_all_store(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf,
> +				size_t size)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned long val;
> +
> +	if ((kstrtoul(buf, 0, &val)) || (val & ~1UL))
> +		return -EINVAL;
> +
> +	guard(spinlock)(&drvdata->spinlock);
> +	if (val)
> +		drvdata->cmb->ts_all = true;
> +	else
> +		drvdata->cmb->ts_all = false;
> +
> +	return size;
> +}
> +static DEVICE_ATTR_RW(cmb_ts_all);
> +
> +static ssize_t cmb_trig_ts_show(struct device *dev,
> +				struct device_attribute *attr,
> +				char *buf)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +
> +	return sysfs_emit(buf, "%u\n",
> +			  (unsigned int)drvdata->cmb->trig_ts);
> +}
> +
> +static ssize_t cmb_trig_ts_store(struct device *dev,
> +				 struct device_attribute *attr,
> +				 const char *buf,
> +				 size_t size)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned long val;
> +
> +	if ((kstrtoul(buf, 0, &val)) || (val & ~1UL))
> +		return -EINVAL;
> +
> +	guard(spinlock)(&drvdata->spinlock);
> +	if (val)
> +		drvdata->cmb->trig_ts = true;
> +	else
> +		drvdata->cmb->trig_ts = false;
> +
> +	return size;
> +}
> +static DEVICE_ATTR_RW(cmb_trig_ts);
> +
>   static struct attribute *tpdm_dsb_edge_attrs[] = {
>   	&dev_attr_ctrl_idx.attr,
>   	&dev_attr_ctrl_val.attr,
> @@ -910,7 +1014,7 @@ static struct attribute *tpdm_dsb_patt_attrs[] = {
>   	DSB_PATT_MASK_ATTR(5),
>   	DSB_PATT_MASK_ATTR(6),
>   	DSB_PATT_MASK_ATTR(7),
> -	&dev_attr_enable_ts.attr,
> +	DSB_PATT_ENABLE_TS,
>   	&dev_attr_set_type.attr,
>   	NULL,
>   };
> @@ -964,6 +1068,7 @@ static struct attribute *tpdm_cmb_patt_attrs[] = {
>   	CMB_PATT_ATTR(1),
>   	CMB_PATT_MASK_ATTR(0),
>   	CMB_PATT_MASK_ATTR(1),
> +	CMB_PATT_ENABLE_TS,
>   	NULL,
>   };
>   
> @@ -976,6 +1081,8 @@ static struct attribute *tpdm_dsb_attrs[] = {
>   
>   static struct attribute *tpdm_cmb_attrs[] = {
>   	&dev_attr_cmb_mode.attr,
> +	&dev_attr_cmb_ts_all.attr,
> +	&dev_attr_cmb_trig_ts.attr,
>   	NULL,
>   };
>   
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
> index 8cb8a9b35384..725a35e5893f 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.h
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.h
> @@ -11,6 +11,8 @@
>   
>   /* CMB Subunit Registers */
>   #define TPDM_CMB_CR		(0xA00)
> +/*CMB subunit timestamp insertion enable register*/

     ^^ Minor nit: Same as previous patch.          ^^

Suzuki


