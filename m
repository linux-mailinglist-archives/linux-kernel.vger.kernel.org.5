Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFB77722D7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 13:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbjHGLj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 07:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbjHGLje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:39:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A806A2698;
        Mon,  7 Aug 2023 04:36:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20C571FB;
        Mon,  7 Aug 2023 04:28:05 -0700 (PDT)
Received: from [10.57.90.63] (unknown [10.57.90.63])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 574AC3F59C;
        Mon,  7 Aug 2023 04:27:19 -0700 (PDT)
Message-ID: <19e7b5e1-d549-8627-b73b-112df5f8890e@arm.com>
Date:   Mon, 7 Aug 2023 12:27:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v7 11/13] coresight-tpdm: Add nodes for timestamp request
To:     Tao Zhang <quic_taozha@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org
References: <1690269353-10829-1-git-send-email-quic_taozha@quicinc.com>
 <1690269353-10829-12-git-send-email-quic_taozha@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1690269353-10829-12-git-send-email-quic_taozha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/2023 08:15, Tao Zhang wrote:
> Add nodes to configure the timestamp request based on input
> pattern match. Each TPDM that support DSB subunit has maximum of
> n(n<7) TPR registers to configure value for timestamp request
> based on input pattern match. Eight 32 bit registers providing
> DSB interface timestamp request  pattern match comparison. And
> each TPDM that support DSB subunit has maximum of m(m<7) TPMR
> registers to configure pattern mask for timestamp request. Eight
> 32 bit registers providing DSB interface timestamp request
> pattern match mask generation. Add nodes to enable/disable
> pattern timestamp and set pattern timestamp type.
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> ---
>   .../ABI/testing/sysfs-bus-coresight-devices-tpdm   |  57 +++++-
>   drivers/hwtracing/coresight/coresight-tpdm.c       | 205 ++++++++++++++++++++-
>   drivers/hwtracing/coresight/coresight-tpdm.h       |  16 ++
>   3 files changed, 272 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> index 66f9582..74a0126 100644
> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> @@ -130,4 +130,59 @@ Description:
>   		to the index number. Before writing data to this sysfs file,
>   		"dsb_trig_patt_idx" should be written first to configure the
>   		index number of the trigger pattern mask which needs to be
> -		configured.
> \ No newline at end of file
> +		configured.
> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_patt_idx
> +Date:		March 2023
> +KernelVersion	6.5
> +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:
> +		Read/Write the index number of the DSB tpdm pattern. Since
> +		there are at most 8 TPR and TPMR registers for the parttern,
> +		this value ranges from 0 to 7.

If it is only 0-7 and we read/write full registers, why not expose 
individual registers as mentioned in the previous comments and avoid
multi-line output for "show" routines. You may even group the registers
under a directory structure to avoid confusion.

e.g, :

	dsb_patt/
		\- mask0 ... mask7
		\- ts0 ... ts7
		\- type0 ... type7

	dsb_edge/
		\- edcr0 ... edcr15
		\- edcmr0 ... edcmr7
		\- ctrl_idx
		\- ctrl_idx_val
....



> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_patt_val
> +Date:		March 2023
> +KernelVersion	6.5
> +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:
> +		Read a set of the pattern values of the DSB TPDM. Write a data
> +		to configure the pattern corresponding to the index number.
> +		Before writing data to this sysfs file, "dsb_patt_idx" should be
> +		written first to configure the index number of the pattern which
> +		needs to be configured.
> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_patt_mask
> +Date:		March 2023
> +KernelVersion	6.5
> +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:
> +		Read a set of the pattern mask values of the DSB TPDM. Write a
> +		data to configure the pattern mask corresponding to the index
> +		number. Before writing data to this sysfs file, "dsb_patt_idx"
> +		should be written first to configure the index number of the
> +		pattern mask which needs to be configured.
> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_patt_ts
> +Date:		March 2023
> +KernelVersion	6.5
> +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:
> +		(Write) Set the pattern timestamp of DSB tpdm. Read
> +		the pattern timestamp of DSB tpdm.
> +
> +		Accepts only one of the 2 values -  0 or 1.
> +		0 : Disable DSB pattern timestamp.
> +		1 : Enable DSB pattern timestamp.
> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_patt_type
> +Date:		March 2023
> +KernelVersion	6.5
> +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:
> +		(Write) Set the pattern type of DSB tpdm. Read
> +		the pattern type of DSB tpdm.
> +
> +		Accepts only one of the 2 values -  0 or 1.
> +		0 : Set the DSB pattern type to value.
> +		1 : Set the DSB pattern type to toggle.
> \ No newline at end of file
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> index 1c32d27..f9e5a1d 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
> @@ -69,6 +69,27 @@ static void set_dsb_perf_mode(struct tpdm_drvdata *drvdata, u32 *val)
>   		*val &= ~TPDM_DSB_CR_MODE;
>   }
>   
> +static void set_dsb_tier(struct tpdm_drvdata *drvdata, u32 *val)
> +{
> +	/* Set pattern timestamp type and enablement */
> +	if (drvdata->dsb->patt_ts) {
> +		*val |= TPDM_DSB_TIER_PATT_TSENAB;
> +		if (drvdata->dsb->patt_type)
> +			*val |= TPDM_DSB_TIER_PATT_TYPE;
> +		else
> +			*val &= ~TPDM_DSB_TIER_PATT_TYPE;
> +	} else {
> +		*val &= ~TPDM_DSB_TIER_PATT_TSENAB;
> +	}
> +
> +	/* Set trigger timestamp */
> +	if (drvdata->dsb->trig_ts)
> +		*val |= TPDM_DSB_TIER_XTRIG_TSENAB;
> +	else
> +		*val &= ~TPDM_DSB_TIER_XTRIG_TSENAB;
> +
> +}
> +
>   static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
>   {
>   	u32 val, i;
> @@ -81,6 +102,10 @@ static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
>   			   drvdata->base + TPDM_DSB_EDCMR(i));
>   
>   	for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {
> +		writel_relaxed(drvdata->dsb->patt_val[i],
> +			    drvdata->base + TPDM_DSB_TPR(i));
> +		writel_relaxed(drvdata->dsb->patt_mask[i],
> +			    drvdata->base + TPDM_DSB_TPMR(i));
>   		writel_relaxed(drvdata->dsb->trig_patt[i],
>   			    drvdata->base + TPDM_DSB_XPR(i));
>   		writel_relaxed(drvdata->dsb->trig_patt_mask[i],
> @@ -88,11 +113,7 @@ static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
>   	}
>   
>   	val = readl_relaxed(drvdata->base + TPDM_DSB_TIER);
> -	/* Set trigger timestamp */
> -	if (drvdata->dsb->trig_ts)
> -		val |= TPDM_DSB_TIER_XTRIG_TSENAB;
> -	else
> -		val &= ~TPDM_DSB_TIER_XTRIG_TSENAB;
> +	set_dsb_tier(drvdata, &val);
>   	writel_relaxed(val, drvdata->base + TPDM_DSB_TIER);
>   
>   	val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
> @@ -462,6 +483,175 @@ static ssize_t dsb_edge_ctrl_mask_store(struct device *dev,
>   }
>   static DEVICE_ATTR_RW(dsb_edge_ctrl_mask);
>   
> +static ssize_t dsb_patt_idx_show(struct device *dev,
> +				struct device_attribute *attr,
> +				char *buf)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +
> +	return sysfs_emit(buf, "%u\n",
> +			 (unsigned int)drvdata->dsb->patt_idx);
> +
> +}
> +
> +static ssize_t dsb_patt_idx_store(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf,
> +				size_t size)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned long index;
> +
> +	if ((kstrtoul(buf, 0, &index)) || (index >= TPDM_DSB_MAX_PATT))
> +		return -EINVAL;
> +
> +	spin_lock(&drvdata->spinlock);
> +	drvdata->dsb->patt_idx = index;
> +	spin_unlock(&drvdata->spinlock);
> +
> +	return size;
> +
> +}
> +static DEVICE_ATTR_RW(dsb_patt_idx);
> +
> +static ssize_t dsb_patt_val_show(struct device *dev,
> +				struct device_attribute *attr,
> +				char *buf)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	ssize_t size = 0;
> +	unsigned long bytes;
> +	int i = 0;
> +
> +	spin_lock(&drvdata->spinlock);
> +	for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {
> +		bytes = sysfs_emit_at(buf, size,
> +				  "Value: 0x%x\n", drvdata->dsb->patt_val[i]);

Please see my comment on the other patches.

> +		if (bytes <= 0)
> +			break;
> +		size += bytes;
> +	}
> +	spin_unlock(&drvdata->spinlock);
> +	return size;
> +}
> +
> +static ssize_t dsb_patt_val_store(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf,
> +				size_t size)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned long val;
> +
> +	if (kstrtoul(buf, 0, &val))

You have used the base for all such conversions inconsistently,
throughout the series. You can always stick to 0.

$ git grep kstrtoul drivers/hwtracing/coresight/coresight-tpdm.c
drivers/hwtracing/coresight/coresight-tpdm.c:   ret = kstrtoul(buf, 10, 
&val);
drivers/hwtracing/coresight/coresight-tpdm.c:   ret = kstrtoul(buf, 10, 
&val);
drivers/hwtracing/coresight/coresight-tpdm.c:   if ((kstrtoul(buf, 0, 
&val)) || val < 0)
drivers/hwtracing/coresight/coresight-tpdm.c:   if ((kstrtoul(buf, 0, 
&val)) || (val >= TPDM_DSB_MAX_LINES))
drivers/hwtracing/coresight/coresight-tpdm.c:   if ((kstrtoul(buf, 0, 
&edge_ctrl)) || (edge_ctrl > 0x2))
drivers/hwtracing/coresight/coresight-tpdm.c:   if ((kstrtoul(buf, 0, 
&val)) || (val & ~1UL))
drivers/hwtracing/coresight/coresight-tpdm.c:   if ((kstrtoul(buf, 0, 
&val)) || (val & ~1UL))
drivers/hwtracing/coresight/coresight-tpdm.c:   if ((kstrtoul(buf, 0, 
&val)) || (val & ~1UL))



Suzuki


