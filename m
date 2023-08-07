Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09AD27722CE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 13:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbjHGLjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 07:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbjHGLjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:39:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8AA5D5FF4;
        Mon,  7 Aug 2023 04:36:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E069CD75;
        Mon,  7 Aug 2023 04:36:02 -0700 (PDT)
Received: from [10.57.90.63] (unknown [10.57.90.63])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1BBA53F59C;
        Mon,  7 Aug 2023 04:35:16 -0700 (PDT)
Message-ID: <b36940af-648d-2620-3086-81b30de6e401@arm.com>
Date:   Mon, 7 Aug 2023 12:35:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v7 13/13] coresight-tpdm: Add nodes for dsb msr support
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
 <1690269353-10829-14-git-send-email-quic_taozha@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1690269353-10829-14-git-send-email-quic_taozha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/2023 08:15, Tao Zhang wrote:
> Add the nodes for DSB subunit MSR(mux select register) support.
> The TPDM MSR (mux select register) interface is an optional
> interface and associated bank of registers per TPDM subunit.
> The intent of mux select registers is to control muxing structures
> driving the TPDM’s’ various subunit interfaces.
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> ---
>   .../ABI/testing/sysfs-bus-coresight-devices-tpdm   | 19 ++++-
>   drivers/hwtracing/coresight/coresight-tpdm.c       | 98 ++++++++++++++++++++++
>   drivers/hwtracing/coresight/coresight-tpdm.h       |  7 ++
>   3 files changed, 123 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> index 74a0126..ee41a14 100644
> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> @@ -185,4 +185,21 @@ Description:
>   
>   		Accepts only one of the 2 values -  0 or 1.
>   		0 : Set the DSB pattern type to value.
> -		1 : Set the DSB pattern type to toggle.
> \ No newline at end of file
> +		1 : Set the DSB pattern type to toggle.
> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_msr_idx
> +Date:		March 2023
> +KernelVersion	6.5
> +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:
> +		Read/Write the index number of MSR(mux select register) on DSB
> +		TPDM. This index number should not be greater than the number
> +		of MSR supported by this DSB TPDM.

How does a user find it ? Why don't we expose it ? Scratch all of that, 
you could create a register file per exising msr.

	dsb_msrs/msr0 ... msrN

You may :

1. either dynamically add files as you find the number

OR

2. If there is a hard limit, create that many files and control 
visibility based on the dynamic number.



> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_msr
> +Date:		March 2023
> +KernelVersion	6.5
> +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:
> +		(Write) Set the MSR(mux select register) of DSB tpdm. Read
> +		the MSR(mux select register) of DSB tpdm.

(RW)

> \ No newline at end of file
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> index f9e5a1d..be7776b 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
> @@ -90,6 +90,18 @@ static void set_dsb_tier(struct tpdm_drvdata *drvdata, u32 *val)
>   
>   }
>   
> +static void set_dsb_msr(struct tpdm_drvdata *drvdata)
> +{
> +	int i;
> +


> +	if (drvdata->dsb->msr_num == 0)
> +		return;
> +
> +	for (i = 0; i < drvdata->dsb->msr_num; i++)
> +		writel_relaxed(drvdata->dsb->msr[i],
> +			   drvdata->base + TPDM_DSB_MSR(i));
> +}
> +
>   static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
>   {
>   	u32 val, i;
> @@ -116,6 +128,8 @@ static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
>   	set_dsb_tier(drvdata, &val);
>   	writel_relaxed(val, drvdata->base + TPDM_DSB_TIER);
>   
> +	set_dsb_msr(drvdata);
> +
>   	val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
>   	/* Set the test accurate mode */
>   	set_dsb_test_mode(drvdata, &val);
> @@ -234,6 +248,14 @@ static int tpdm_datasets_setup(struct tpdm_drvdata *drvdata)
>   			if (!drvdata->dsb)
>   				return -ENOMEM;
>   		}
> +		if (!of_property_read_u32(drvdata->dev->of_node,
> +			   "qcom,dsb_msr_num", &drvdata->dsb->msr_num)) {
> +			drvdata->dsb->msr = devm_kzalloc(drvdata->dev, > +				   (drvdata->dsb->msr_num * sizeof(*drvdata->dsb->msr)),

			devm_kcalloc() ?

> +				   GFP_KERNEL);
> +			if (!drvdata->dsb->msr)
> +				return -ENOMEM;
> +		}
>   	}
>   
>   	return 0;
> @@ -830,6 +852,80 @@ static ssize_t dsb_trig_ts_store(struct device *dev,
>   }
>   static DEVICE_ATTR_RW(dsb_trig_ts);
>   
> +static ssize_t dsb_msr_idx_show(struct device *dev,
> +				 struct device_attribute *attr,
> +				 char *buf)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +
> +	return sysfs_emit(buf, "%u\n",
> +			(unsigned int)drvdata->dsb->msr_idx);
> +
> +}
> +
> +static ssize_t dsb_msr_idx_store(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf,
> +				  size_t size)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned long index;
> +
> +	if (kstrtoul(buf, 0, &index))
> +		return -EINVAL;
> +	if (index >= drvdata->dsb->msr_num)
> +		return -EPERM;
> +
> +	spin_lock(&drvdata->spinlock);
> +	drvdata->dsb->msr_idx = index;
> +	spin_unlock(&drvdata->spinlock);
> +	return size;
> +}
> +static DEVICE_ATTR_RW(dsb_msr_idx);
> +
> +static ssize_t dsb_msr_show(struct device *dev,
> +				 struct device_attribute *attr,
> +				 char *buf)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned int i;
> +	unsigned long bytes;
> +	ssize_t size = 0;
> +
> +	if (drvdata->dsb->msr_num == 0)
> +		return -EINVAL;
> +
> +	spin_lock(&drvdata->spinlock);
> +	for (i = 0; i < drvdata->dsb->msr_num; i++) {
> +		bytes = sysfs_emit_at(buf, size,
> +				  "0x%x\n", drvdata->dsb->msr[i]);

Single value per single file.

Suzuki


> +		if (bytes <= 0)
> +			break;
> +		size += bytes;
> +	}
> +	spin_unlock(&drvdata->spinlock);
> +
> +	return size;
> +}
> +
> +static ssize_t dsb_msr_store(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf,
> +				  size_t size)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned long val;
> +
> +	if (kstrtoul(buf, 0, &val))
> +		return -EINVAL;
> +
> +	spin_lock(&drvdata->spinlock);
> +	drvdata->dsb->msr[drvdata->dsb->msr_idx] = val;
> +	spin_unlock(&drvdata->spinlock);
> +	return size;
> +}
> +static DEVICE_ATTR_RW(dsb_msr);
> +
>   static struct attribute *tpdm_dsb_attrs[] = {
>   	&dev_attr_dsb_mode.attr,
>   	&dev_attr_dsb_edge_ctrl_idx.attr,
> @@ -845,6 +941,8 @@ static struct attribute *tpdm_dsb_attrs[] = {
>   	&dev_attr_dsb_trig_patt_mask.attr,
>   	&dev_attr_dsb_trig_ts.attr,
>   	&dev_attr_dsb_trig_type.attr,
> +	&dev_attr_dsb_msr_idx.attr,
> +	&dev_attr_dsb_msr.attr,
>   	NULL,
>   };
>   
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
> index 7c52cf4..7b70db3 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.h
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.h
> @@ -18,6 +18,7 @@
>   #define TPDM_DSB_XPMR(n)	(0x7E8 + (n * 4))
>   #define TPDM_DSB_EDCR(n)	(0x808 + (n * 4))
>   #define TPDM_DSB_EDCMR(n)	(0x848 + (n * 4))
> +#define TPDM_DSB_MSR(n)		(0x980 + (n * 4))
>   
>   /* Enable bit for DSB subunit */
>   #define TPDM_DSB_CR_ENA		BIT(0)
> @@ -100,6 +101,9 @@
>    * @patt_mask:          Save value for pattern mask
>    * @trig_patt:          Save value for trigger pattern
>    * @trig_patt_mask:     Save value for trigger pattern mask
> + * @msr_num             Number of MSR supported by DSB TPDM
> + * @msr_idx             Index number of the MSR
> + * @msr                 Save value for MSR
>    * @patt_ts:            Enable/Disable pattern timestamp
>    * @patt_type:          Set pattern type
>    * @trig_ts:            Enable/Disable trigger timestamp.
> @@ -116,6 +120,9 @@ struct dsb_dataset {
>   	u32				patt_mask[TPDM_DSB_MAX_PATT];
>   	u32				trig_patt[TPDM_DSB_MAX_PATT];
>   	u32				trig_patt_mask[TPDM_DSB_MAX_PATT];
> +	u32				msr_num;
> +	u32				msr_idx;
> +	u32				*msr;
>   	bool			patt_ts;
>   	bool			patt_type;
>   	bool			trig_ts;

