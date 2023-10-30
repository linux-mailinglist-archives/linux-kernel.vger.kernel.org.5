Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E487DB917
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 12:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbjJ3Lhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 07:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJ3Lhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 07:37:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29DF4C2;
        Mon, 30 Oct 2023 04:37:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F54EFEC;
        Mon, 30 Oct 2023 04:38:23 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 500203F738;
        Mon, 30 Oct 2023 04:37:39 -0700 (PDT)
Message-ID: <4b90fc0c-2fa5-6c89-2ced-a4e63f59e170@arm.com>
Date:   Mon, 30 Oct 2023 11:37:40 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 6/8] coresight-tpdm: Add timestamp control register
 support for the CMB
Content-Language: en-US
To:     Tao Zhang <quic_taozha@quicinc.com>
Cc:     Jinlong Mao <quic_jinlmao@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Song Chai <quic_songchai@quicinc.com>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <1698202408-14608-1-git-send-email-quic_taozha@quicinc.com>
 <1698202408-14608-7-git-send-email-quic_taozha@quicinc.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <1698202408-14608-7-git-send-email-quic_taozha@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/10/2023 03:53, Tao Zhang wrote:
> CMB_TIER register is CMB subunit timestamp insertion enable register.
> Bit 0 is PATT_TSENAB bit. Set this bit to 1 to request a timestamp
> following a CMB interface pattern match. Bit 1 is XTRIG_TSENAB bit.
> Set this bit to 1 to request a timestamp following a CMB CTI timestamp
> request. Bit 2 is TS_ALL bit. Set this bit to 1 to request timestamp
> for all packets.
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> Signed-off-by: Jinlong Mao <quic_jinlmao@quicinc.com>
> ---
>  .../ABI/testing/sysfs-bus-coresight-devices-tpdm   |  35 +++++++
>  drivers/hwtracing/coresight/coresight-tpdm.c       | 116 ++++++++++++++++++++-
>  drivers/hwtracing/coresight/coresight-tpdm.h       |  14 +++
>  3 files changed, 162 insertions(+), 3 deletions(-)
> 

Reviewed-by: James Clark <james.clark@arm.com>

> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> index c17468f..d58b33ee 100644
> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> @@ -210,3 +210,38 @@ KernelVersion	6.7
>  Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
>  Description:
>  		(RW) Set/Get the mask of the pattern for the CMB subunit TPDM.
> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/cmb_patt/enable_ts
> +Date:		September 2023
> +KernelVersion	6.7
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
> +Date:		September 2023
> +KernelVersion	6.7
> +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:
> +		(RW) Set/Get the trigger timestamp of the CMB for tpdm.
> +
> +		Accepts only one of the 2 values -  0 or 1.
> +		0 : Set the CMB trigger type to false
> +		1 : Set the CMB trigger type to true
> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/cmb_ts_all
> +Date:		September 2023
> +KernelVersion	6.7
> +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:
> +		(RW) Read or write the status of timestamp upon all interface.
> +		Only value 0 and 1  can be written to this node. Set this node to 1 to requeset
> +		timestamp to all trace packet.
> +		Accepts only one of the 2 values -  0 or 1.
> +		0 : Disable the timestamp of all trace packets.
> +		1 : Enable the timestamp of all trace packets.
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> index 894d430..f6cda56 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
> @@ -331,6 +331,36 @@ static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
>  	writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
>  }
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
> +	else
> +		val &= ~TPDM_CMB_TIER_PATT_TSENAB;
> +
> +	/* Set trigger timestamp */
> +	if (drvdata->cmb->trig_ts)
> +		val |= TPDM_CMB_TIER_XTRIG_TSENAB;
> +	else
> +		val &= ~TPDM_CMB_TIER_XTRIG_TSENAB;
> +
> +	/* Set all timestamp enablement*/
> +	if (drvdata->cmb->ts_all)
> +		val |= TPDM_CMB_TIER_TS_ALL;
> +	else
> +		val &= ~TPDM_CMB_TIER_TS_ALL;
> +	writel_relaxed(val, drvdata->base + TPDM_CMB_TIER);
> +}
> +
>  static void tpdm_enable_cmb(struct tpdm_drvdata *drvdata)
>  {
>  	u32 val, i;
> @@ -347,6 +377,8 @@ static void tpdm_enable_cmb(struct tpdm_drvdata *drvdata)
>  			    drvdata->base + TPDM_CMB_XPMR(i));
>  	}
>  
> +	set_cmb_tier(drvdata);
> +
>  	val = readl_relaxed(drvdata->base + TPDM_CMB_CR);
>  	/*
>  	 * Set to 0 for continuous CMB collection mode,
> @@ -695,9 +727,17 @@ static ssize_t enable_ts_show(struct device *dev,
>  			      char *buf)
>  {
>  	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	ssize_t size = 0;
>  
> -	return sysfs_emit(buf, "%u\n",
> -			 (unsigned int)drvdata->dsb->patt_ts);
> +	if (tpdm_has_dsb_dataset(drvdata))
> +		size = sysfs_emit(buf, "%u\n",
> +				 (unsigned int)drvdata->dsb->patt_ts);
> +
> +	if (tpdm_has_cmb_dataset(drvdata))
> +		size = sysfs_emit(buf, "%u\n",
> +				 (unsigned int)drvdata->cmb->patt_ts);
> +
> +	return size;
>  }
>  
>  /*
> @@ -715,8 +755,13 @@ static ssize_t enable_ts_store(struct device *dev,
>  		return -EINVAL;
>  
>  	spin_lock(&drvdata->spinlock);
> -	drvdata->dsb->patt_ts = !!val;
> +	if (tpdm_has_dsb_dataset(drvdata))
> +		drvdata->dsb->patt_ts = !!val;
> +
> +	if (tpdm_has_cmb_dataset(drvdata))
> +		drvdata->cmb->patt_ts = !!val;
>  	spin_unlock(&drvdata->spinlock);
> +
>  	return size;
>  }
>  static DEVICE_ATTR_RW(enable_ts);
> @@ -851,6 +896,68 @@ static ssize_t cmb_mode_store(struct device *dev,
>  }
>  static DEVICE_ATTR_RW(cmb_mode);
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
> +	spin_lock(&drvdata->spinlock);
> +	if (val)
> +		drvdata->cmb->ts_all = true;
> +	else
> +		drvdata->cmb->ts_all = false;
> +	spin_unlock(&drvdata->spinlock);
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
> +	spin_lock(&drvdata->spinlock);
> +	if (val)
> +		drvdata->cmb->trig_ts = true;
> +	else
> +		drvdata->cmb->trig_ts = false;
> +	spin_unlock(&drvdata->spinlock);
> +	return size;
> +}
> +static DEVICE_ATTR_RW(cmb_trig_ts);
> +
>  static struct attribute *tpdm_dsb_edge_attrs[] = {
>  	&dev_attr_ctrl_idx.attr,
>  	&dev_attr_ctrl_val.attr,
> @@ -973,6 +1080,7 @@ static struct attribute *tpdm_cmb_patt_attrs[] = {
>  	CMB_PATT_ATTR(1),
>  	CMB_PATT_MASK_ATTR(0),
>  	CMB_PATT_MASK_ATTR(1),
> +	&dev_attr_enable_ts.attr,
>  	NULL,
>  };
>  
> @@ -985,6 +1093,8 @@ static struct attribute *tpdm_dsb_attrs[] = {
>  
>  static struct attribute *tpdm_cmb_attrs[] = {
>  	&dev_attr_cmb_mode.attr,
> +	&dev_attr_cmb_ts_all.attr,
> +	&dev_attr_cmb_trig_ts.attr,
>  	NULL,
>  };
>  
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
> index e90d008c..65b7ca6 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.h
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.h
> @@ -11,6 +11,8 @@
>  
>  /* CMB Subunit Registers */
>  #define TPDM_CMB_CR		(0xA00)
> +/*CMB subunit timestamp insertion enable register*/
> +#define TPDM_CMB_TIER		(0xA04)
>  /*CMB subunit timestamp pattern registers*/
>  #define TPDM_CMB_TPR(n)		(0xA08 + (n * 4))
>  /*CMB subunit timestamp pattern mask registers*/
> @@ -24,6 +26,12 @@
>  #define TPDM_CMB_CR_ENA		BIT(0)
>  /* Trace collection mode for CMB subunit */
>  #define TPDM_CMB_CR_MODE	BIT(1)
> +/* Timestamp control for pattern match */
> +#define TPDM_CMB_TIER_PATT_TSENAB	BIT(0)
> +/* CMB CTI timestamp request */
> +#define TPDM_CMB_TIER_XTRIG_TSENAB	BIT(1)
> +/* For timestamp fo all trace */
> +#define TPDM_CMB_TIER_TS_ALL		BIT(2)
>  
>  /*Patten register number*/
>  #define TPDM_CMB_MAX_PATT		2
> @@ -217,6 +225,9 @@ struct dsb_dataset {
>   * @patt_mask:        Save value for pattern mask
>   * @trig_patt:        Save value for trigger pattern
>   * @trig_patt_mask:   Save value for trigger pattern mask
> + * @patt_ts:          Indicates if pattern match for timestamp is enabled.
> + * @trig_ts:          Indicates if CTI trigger for timestamp is enabled.
> + * @ts_all:           Indicates if timestamp is enabled for all packets.
>   */
>  struct cmb_dataset {
>  	u32			trace_mode;
> @@ -224,6 +235,9 @@ struct cmb_dataset {
>  	u32			patt_mask[TPDM_CMB_MAX_PATT];
>  	u32			trig_patt[TPDM_CMB_MAX_PATT];
>  	u32			trig_patt_mask[TPDM_CMB_MAX_PATT];
> +	bool			patt_ts;
> +	bool			trig_ts;
> +	bool			ts_all;
>  };
>  
>  /**
