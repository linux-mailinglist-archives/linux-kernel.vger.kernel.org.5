Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FCD7DB92A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 12:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjJ3Llf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 07:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJ3Lle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 07:41:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F66DBD;
        Mon, 30 Oct 2023 04:41:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F163FFEC;
        Mon, 30 Oct 2023 04:42:11 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0E6A3F738;
        Mon, 30 Oct 2023 04:41:27 -0700 (PDT)
Message-ID: <69e7b6ff-6eb6-74c2-be85-9ef918f64337@arm.com>
Date:   Mon, 30 Oct 2023 11:41:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 8/8] coresight-tpdm: Add msr register support for CMB
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
 <1698202408-14608-9-git-send-email-quic_taozha@quicinc.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <1698202408-14608-9-git-send-email-quic_taozha@quicinc.com>
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
> Add the nodes for CMB subunit MSR(mux select register) support.
> CMB MSRs(mux select registers) is to separate mux,arbitration,
> ,interleaving,data packing control from stream filtering control.
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>  .../ABI/testing/sysfs-bus-coresight-devices-tpdm   |  8 ++
>  drivers/hwtracing/coresight/coresight-tpdm.c       | 86 ++++++++++++++++++++++
>  drivers/hwtracing/coresight/coresight-tpdm.h       | 16 +++-
>  3 files changed, 109 insertions(+), 1 deletion(-)
> 

Reviewed-by: James Clark <james.clark@arm.com>

> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> index d58b33ee..df0f837 100644
> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> @@ -245,3 +245,11 @@ Description:
>  		Accepts only one of the 2 values -  0 or 1.
>  		0 : Disable the timestamp of all trace packets.
>  		1 : Enable the timestamp of all trace packets.
> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/cmb_msr/msr[0:31]
> +Date:		September 2023
> +KernelVersion	6.7
> +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:
> +		(RW) Set/Get the MSR(mux select register) for the CMB subunit
> +		TPDM.
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> index f6cda56..7e331ea 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
> @@ -86,6 +86,11 @@ static ssize_t tpdm_simple_dataset_show(struct device *dev,
>  			return -EINVAL;
>  		return sysfs_emit(buf, "0x%x\n",
>  			drvdata->cmb->patt_mask[tpdm_attr->idx]);
> +	case CMB_MSR:
> +		if (tpdm_attr->idx >= drvdata->cmb_msr_num)
> +			return -EINVAL;
> +		return sysfs_emit(buf, "0x%x\n",
> +				drvdata->cmb->msr[tpdm_attr->idx]);
>  	}
>  	return -EINVAL;
>  }
> @@ -162,6 +167,12 @@ static ssize_t tpdm_simple_dataset_store(struct device *dev,
>  		else
>  			ret = -EINVAL;
>  		break;
> +	case CMB_MSR:
> +		if (tpdm_attr->idx < drvdata->cmb_msr_num)
> +			drvdata->cmb->msr[tpdm_attr->idx] = val;
> +		else
> +			ret = -EINVAL;
> +		break;
>  	default:
>  		ret = -EINVAL;
>  	}
> @@ -220,6 +231,23 @@ static umode_t tpdm_dsb_msr_is_visible(struct kobject *kobj,
>  	return 0;
>  }
>  
> +static umode_t tpdm_cmb_msr_is_visible(struct kobject *kobj,
> +				       struct attribute *attr, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +
> +	struct device_attribute *dev_attr =
> +		container_of(attr, struct device_attribute, attr);
> +	struct tpdm_dataset_attribute *tpdm_attr =
> +		container_of(dev_attr, struct tpdm_dataset_attribute, attr);
> +
> +	if (tpdm_attr->idx < drvdata->cmb_msr_num)
> +		return attr->mode;
> +
> +	return 0;
> +}
> +
>  static void tpdm_reset_datasets(struct tpdm_drvdata *drvdata)
>  {
>  	if (tpdm_has_dsb_dataset(drvdata)) {
> @@ -361,6 +389,15 @@ static void set_cmb_tier(struct tpdm_drvdata *drvdata)
>  	writel_relaxed(val, drvdata->base + TPDM_CMB_TIER);
>  }
>  
> +static void set_cmb_msr(struct tpdm_drvdata *drvdata)
> +{
> +	int i;
> +
> +	for (i = 0; i < drvdata->cmb_msr_num; i++)
> +		writel_relaxed(drvdata->cmb->msr[i],
> +			   drvdata->base + TPDM_CMB_MSR(i));
> +}
> +
>  static void tpdm_enable_cmb(struct tpdm_drvdata *drvdata)
>  {
>  	u32 val, i;
> @@ -379,6 +416,8 @@ static void tpdm_enable_cmb(struct tpdm_drvdata *drvdata)
>  
>  	set_cmb_tier(drvdata);
>  
> +	set_cmb_msr(drvdata);
> +
>  	val = readl_relaxed(drvdata->base + TPDM_CMB_CR);
>  	/*
>  	 * Set to 0 for continuous CMB collection mode,
> @@ -1084,6 +1123,42 @@ static struct attribute *tpdm_cmb_patt_attrs[] = {
>  	NULL,
>  };
>  
> +static struct attribute *tpdm_cmb_msr_attrs[] = {
> +	CMB_MSR_ATTR(0),
> +	CMB_MSR_ATTR(1),
> +	CMB_MSR_ATTR(2),
> +	CMB_MSR_ATTR(3),
> +	CMB_MSR_ATTR(4),
> +	CMB_MSR_ATTR(5),
> +	CMB_MSR_ATTR(6),
> +	CMB_MSR_ATTR(7),
> +	CMB_MSR_ATTR(8),
> +	CMB_MSR_ATTR(9),
> +	CMB_MSR_ATTR(10),
> +	CMB_MSR_ATTR(11),
> +	CMB_MSR_ATTR(12),
> +	CMB_MSR_ATTR(13),
> +	CMB_MSR_ATTR(14),
> +	CMB_MSR_ATTR(15),
> +	CMB_MSR_ATTR(16),
> +	CMB_MSR_ATTR(17),
> +	CMB_MSR_ATTR(18),
> +	CMB_MSR_ATTR(19),
> +	CMB_MSR_ATTR(20),
> +	CMB_MSR_ATTR(21),
> +	CMB_MSR_ATTR(22),
> +	CMB_MSR_ATTR(23),
> +	CMB_MSR_ATTR(24),
> +	CMB_MSR_ATTR(25),
> +	CMB_MSR_ATTR(26),
> +	CMB_MSR_ATTR(27),
> +	CMB_MSR_ATTR(28),
> +	CMB_MSR_ATTR(29),
> +	CMB_MSR_ATTR(30),
> +	CMB_MSR_ATTR(31),
> +	NULL,
> +};
> +
>  static struct attribute *tpdm_dsb_attrs[] = {
>  	&dev_attr_dsb_mode.attr,
>  	&dev_attr_dsb_trig_ts.attr,
> @@ -1144,6 +1219,12 @@ static struct attribute_group tpdm_cmb_patt_grp = {
>  	.name = "cmb_patt",
>  };
>  
> +static struct attribute_group tpdm_cmb_msr_grp = {
> +	.attrs = tpdm_cmb_msr_attrs,
> +	.is_visible = tpdm_cmb_msr_is_visible,
> +	.name = "cmb_msr",
> +};
> +
>  static const struct attribute_group *tpdm_attr_grps[] = {
>  	&tpdm_attr_grp,
>  	&tpdm_dsb_attr_grp,
> @@ -1154,6 +1235,7 @@ static const struct attribute_group *tpdm_attr_grps[] = {
>  	&tpdm_cmb_attr_grp,
>  	&tpdm_cmb_trig_patt_grp,
>  	&tpdm_cmb_patt_grp,
> +	&tpdm_cmb_msr_grp,
>  	NULL,
>  };
>  
> @@ -1192,6 +1274,10 @@ static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
>  		of_property_read_u32(drvdata->dev->of_node,
>  			   "qcom,dsb-msrs-num", &drvdata->dsb_msr_num);
>  
> +	if (drvdata && tpdm_has_cmb_dataset(drvdata))
> +		of_property_read_u32(drvdata->dev->of_node,
> +			   "qcom,cmb-msrs-num", &drvdata->cmb_msr_num);
> +
>  	/* Set up coresight component description */
>  	desc.name = coresight_alloc_device_name(&tpdm_devs, dev);
>  	if (!desc.name)
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
> index 65b7ca6..255104d 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.h
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.h
> @@ -21,6 +21,8 @@
>  #define TPDM_CMB_XPR(n)		(0xA18 + (n * 4))
>  /*CMB subunit trigger pattern mask registers*/
>  #define TPDM_CMB_XPMR(n)	(0xA20 + (n * 4))
> +/* CMB MSR register */
> +#define TPDM_CMB_MSR(n)		(0xA80 + (n * 4))
>  
>  /* Enable bit for CMB subunit */
>  #define TPDM_CMB_CR_ENA		BIT(0)
> @@ -36,6 +38,9 @@
>  /*Patten register number*/
>  #define TPDM_CMB_MAX_PATT		2
>  
> +/* MAX number of DSB MSR */
> +#define TPDM_CMB_MAX_MSR 32
> +
>  /* DSB Subunit Registers */
>  #define TPDM_DSB_CR		(0x780)
>  #define TPDM_DSB_TIER		(0x784)
> @@ -186,6 +191,10 @@
>  		tpdm_simple_dataset_rw(tpmr##nr,		\
>  		CMB_PATT_MASK, nr)
>  
> +#define CMB_MSR_ATTR(nr)					\
> +		tpdm_simple_dataset_rw(msr##nr,			\
> +		CMB_MSR, nr)
> +
>  /**
>   * struct dsb_dataset - specifics associated to dsb dataset
>   * @mode:             DSB programming mode
> @@ -225,6 +234,7 @@ struct dsb_dataset {
>   * @patt_mask:        Save value for pattern mask
>   * @trig_patt:        Save value for trigger pattern
>   * @trig_patt_mask:   Save value for trigger pattern mask
> + * @msr               Save value for MSR
>   * @patt_ts:          Indicates if pattern match for timestamp is enabled.
>   * @trig_ts:          Indicates if CTI trigger for timestamp is enabled.
>   * @ts_all:           Indicates if timestamp is enabled for all packets.
> @@ -235,6 +245,7 @@ struct cmb_dataset {
>  	u32			patt_mask[TPDM_CMB_MAX_PATT];
>  	u32			trig_patt[TPDM_CMB_MAX_PATT];
>  	u32			trig_patt_mask[TPDM_CMB_MAX_PATT];
> +	u32			msr[TPDM_CMB_MAX_MSR];
>  	bool			patt_ts;
>  	bool			trig_ts;
>  	bool			ts_all;
> @@ -251,6 +262,7 @@ struct cmb_dataset {
>   * @dsb         Specifics associated to TPDM DSB.
>   * @cmb         Specifics associated to TPDM CMB.
>   * @dsb_msr_num Number of MSR supported by DSB TPDM
> + * @cmb_msr_num Number of MSR supported by CMB TPDM
>   */
>  
>  struct tpdm_drvdata {
> @@ -263,6 +275,7 @@ struct tpdm_drvdata {
>  	struct dsb_dataset	*dsb;
>  	struct cmb_dataset	*cmb;
>  	u32			dsb_msr_num;
> +	u32			cmb_msr_num;
>  };
>  
>  /* Enumerate members of various datasets */
> @@ -277,7 +290,8 @@ enum dataset_mem {
>  	CMB_TRIG_PATT,
>  	CMB_TRIG_PATT_MASK,
>  	CMB_PATT,
> -	CMB_PATT_MASK
> +	CMB_PATT_MASK,
> +	CMB_MSR
>  };
>  
>  /**
