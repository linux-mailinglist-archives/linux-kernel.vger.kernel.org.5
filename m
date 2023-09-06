Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D8E793853
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 11:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237139AbjIFJd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 05:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237162AbjIFJds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 05:33:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7C6F1733;
        Wed,  6 Sep 2023 02:32:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00CD61063;
        Wed,  6 Sep 2023 02:32:52 -0700 (PDT)
Received: from [10.57.92.132] (unknown [10.57.92.132])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBC3E3F7C5;
        Wed,  6 Sep 2023 02:32:10 -0700 (PDT)
Message-ID: <f6565ae1-0955-d27c-a370-ea496aeb4ba8@arm.com>
Date:   Wed, 6 Sep 2023 10:32:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v8 13/13] coresight-tpdm: Add nodes for dsb msr support
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
References: <1692681973-20764-1-git-send-email-quic_taozha@quicinc.com>
 <1692681973-20764-14-git-send-email-quic_taozha@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1692681973-20764-14-git-send-email-quic_taozha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/2023 06:26, Tao Zhang wrote:
> Add the nodes for DSB subunit MSR(mux select register) support.
> The TPDM MSR (mux select register) interface is an optional
> interface and associated bank of registers per TPDM subunit.
> The intent of mux select registers is to control muxing structures
> driving the TPDM’s’ various subunit interfaces.
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> ---
>   .../ABI/testing/sysfs-bus-coresight-devices-tpdm   |  8 +++
>   drivers/hwtracing/coresight/coresight-tpdm.c       | 79 ++++++++++++++++++++++
>   drivers/hwtracing/coresight/coresight-tpdm.h       | 12 ++++
>   3 files changed, 99 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> index 46a5535..9b7e172 100644
> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> @@ -162,3 +162,11 @@ Description:
>   		Accepts only one of the 2 values -  0 or 1.
>   		0 : Set the DSB pattern type to value.
>   		1 : Set the DSB pattern type to toggle.
> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_msr/msr[0:31]
> +Date:		March 2023
> +KernelVersion	6.5
> +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:
> +		(RW) Set/Get the MSR(mux select register) for the DSB subunit
> +		TPDM.
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> index 9b0e060..367c5e2 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
> @@ -51,6 +51,9 @@ static ssize_t tpdm_simple_dataset_show(struct device *dev,
>   	case DSB_PATT_MASK:
>   		return sysfs_emit(buf, "0x%x\n",
>   				drvdata->dsb->patt_mask[tpdm_attr->idx]);
> +	case DSB_MSR:
> +		return sysfs_emit(buf, "0x%x\n",
> +				drvdata->dsb->msr[tpdm_attr->idx]);
>   	default:
>   		return -EINVAL;
>   	}
> @@ -84,6 +87,9 @@ static ssize_t tpdm_simple_dataset_store(struct device *dev,
>   	case DSB_PATT_MASK:
>   		drvdata->dsb->patt_mask[tpdm_attr->idx] = val;
>   		break;
> +	case DSB_MSR:
> +		drvdata->dsb->msr[tpdm_attr->idx] = val;
> +		break;
>   	default:
>   		spin_unlock(&drvdata->spinlock);
>   		return -EINVAL;
> @@ -110,6 +116,22 @@ static umode_t tpdm_dsb_is_visible(struct kobject *kobj,
>   	return 0;
>   }
>   
> +static umode_t tpdm_dsb_msr_is_visible(struct kobject *kobj,
> +					   struct attribute *attr, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +
> +	if (drvdata && tpdm_has_dsb_dataset(drvdata)) {
> +		of_property_read_u32(drvdata->dev->of_node,
> +			   "qcom,dsb_msr_num", &drvdata->dsb->msr_num);

Why don't we read this during probe and use that here ?

> +		if (drvdata->dsb->msr_num != 0)

Also, could we not check the index of the attribute and make sure it is
available on this TPDM ?

		attr->idx < drvdata->dsb->msr_num ??

> +			return attr->mode;
> +	}
> +
> +	return 0;
> +}
> +
>   static void tpdm_reset_datasets(struct tpdm_drvdata *drvdata)
>   {
>   	if (tpdm_has_dsb_dataset(drvdata)) {
> @@ -162,6 +184,18 @@ static void set_dsb_tier(struct tpdm_drvdata *drvdata, u32 *val)
>   
>   }
>   
> +static void set_dsb_msr(struct tpdm_drvdata *drvdata)
> +{
> +	int i;
> +
> +	if (drvdata->dsb->msr_num == 0)
> +		return;

You don;t need this special case, the loop handles it
already

> +
> +	for (i = 0; i < drvdata->dsb->msr_num; i++)
> +		writel_relaxed(drvdata->dsb->msr[i],
> +			   drvdata->base + TPDM_DSB_MSR(i));
> +}
> +
>   static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
>   {
>   	u32 val, i;
> @@ -186,6 +220,8 @@ static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
>   	set_dsb_tier(drvdata, &val);
>   	writel_relaxed(val, drvdata->base + TPDM_DSB_TIER);
>   
> +	set_dsb_msr(drvdata);
> +
>   	val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
>   	/* Set the mode of DSB dataset */
>   	set_dsb_mode(drvdata, &val);
> @@ -707,6 +743,42 @@ static struct attribute *tpdm_dsb_patt_attrs[] = {
>   	NULL,
>   };
>   
> +static struct attribute *tpdm_dsb_msr_attrs[] = {
> +	DSB_MSR_ATTR(0),
> +	DSB_MSR_ATTR(1),
> +	DSB_MSR_ATTR(2),
> +	DSB_MSR_ATTR(3),
> +	DSB_MSR_ATTR(4),
> +	DSB_MSR_ATTR(5),
> +	DSB_MSR_ATTR(6),
> +	DSB_MSR_ATTR(7),
> +	DSB_MSR_ATTR(8),
> +	DSB_MSR_ATTR(9),
> +	DSB_MSR_ATTR(10),
> +	DSB_MSR_ATTR(11),
> +	DSB_MSR_ATTR(12),
> +	DSB_MSR_ATTR(13),
> +	DSB_MSR_ATTR(14),
> +	DSB_MSR_ATTR(15),
> +	DSB_MSR_ATTR(16),
> +	DSB_MSR_ATTR(17),
> +	DSB_MSR_ATTR(18),
> +	DSB_MSR_ATTR(19),
> +	DSB_MSR_ATTR(20),
> +	DSB_MSR_ATTR(21),
> +	DSB_MSR_ATTR(22),
> +	DSB_MSR_ATTR(23),
> +	DSB_MSR_ATTR(24),
> +	DSB_MSR_ATTR(25),
> +	DSB_MSR_ATTR(26),
> +	DSB_MSR_ATTR(27),
> +	DSB_MSR_ATTR(28),
> +	DSB_MSR_ATTR(29),
> +	DSB_MSR_ATTR(30),
> +	DSB_MSR_ATTR(31),
> +	NULL,
> +};
> +
>   static struct attribute *tpdm_dsb_attrs[] = {
>   	&dev_attr_dsb_mode.attr,
>   	&dev_attr_dsb_patt_ts.attr,
> @@ -739,12 +811,19 @@ static struct attribute_group tpdm_dsb_patt_grp = {
>   	.name = "dsb_patt",
>   };
>   
> +static struct attribute_group tpdm_dsb_msr_grp = {
> +	.attrs = tpdm_dsb_msr_attrs,
> +	.is_visible = tpdm_dsb_msr_is_visible,
> +	.name = "dsb_msr",
> +};
> +
>   static const struct attribute_group *tpdm_attr_grps[] = {
>   	&tpdm_attr_grp,
>   	&tpdm_dsb_attrs_grp,
>   	&tpdm_dsb_edge_grp,
>   	&tpdm_dsb_trig_patt_grp,
>   	&tpdm_dsb_patt_grp,
> +	&tpdm_dsb_msr_grp,
>   	NULL,
>   };
>   
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
> index 9173e80..270e946 100644
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
> @@ -90,6 +91,8 @@
>   #define TPDM_DSB_MAX_EDCMR	8
>   /* MAX number of DSB pattern */
>   #define TPDM_DSB_MAX_PATT	8
> +/* MAX number of DSB MSR */
> +#define TPDM_DSB_MAX_MSR 32
>   
>   #define tpdm_simple_dataset_ro(name, mem, idx, max)			\
>   	(&((struct tpdm_dataset_attribute[]) {			\
> @@ -136,16 +139,22 @@
>   		tpdm_simple_dataset_rw(tpmr##nr,		\
>   		DSB_PATT_MASK, nr, TPDM_DSB_MAX_PATT)
>   
> +#define DSB_MSR_ATTR(nr)						\
> +		tpdm_simple_dataset_rw(msr##nr,			\
> +		DSB_MSR, nr, TPDM_DSB_MAX_MSR)
> +
>   /**
>    * struct dsb_dataset - specifics associated to dsb dataset
>    * @mode:             DSB programming mode
>    * @edge_ctrl_idx     Index number of the edge control
> + * @msr_num           Number of MSR supported by DSB TPDM
>    * @edge_ctrl:        Save value for edge control
>    * @edge_ctrl_mask:   Save value for edge control mask
>    * @patt_val:         Save value for pattern
>    * @patt_mask:        Save value for pattern mask
>    * @trig_patt:        Save value for trigger pattern
>    * @trig_patt_mask:   Save value for trigger pattern mask
> + * @msr               Save value for MSR
>    * @patt_ts:          Enable/Disable pattern timestamp
>    * @patt_type:        Set pattern type
>    * @trig_ts:          Enable/Disable trigger timestamp.
> @@ -154,12 +163,14 @@
>   struct dsb_dataset {
>   	u32				mode;
>   	u32				edge_ctrl_idx;
> +	u32				msr_num;

Why should this be part of the dataset ? If I remember correctly,
this data structure is zeroed on reset via sysfs ? Shouldn't that
be part of the drvdata-> instead ? So that you read it once during
probe and don't mess with it.

Suzuki

>   	u32				edge_ctrl[TPDM_DSB_MAX_EDCR];
>   	u32				edge_ctrl_mask[TPDM_DSB_MAX_EDCMR];
>   	u32				patt_val[TPDM_DSB_MAX_PATT];
>   	u32				patt_mask[TPDM_DSB_MAX_PATT];
>   	u32				trig_patt[TPDM_DSB_MAX_PATT];
>   	u32				trig_patt_mask[TPDM_DSB_MAX_PATT];
> +	u32				msr[TPDM_DSB_MAX_MSR];
>   	bool			patt_ts;
>   	bool			patt_type;
>   	bool			trig_ts;
> @@ -195,6 +206,7 @@ enum dataset_mem {
>   	DSB_TRIG_PATT_MASK,
>   	DSB_PATT,
>   	DSB_PATT_MASK,
> +	DSB_MSR,
>   };
>   
>   /**

