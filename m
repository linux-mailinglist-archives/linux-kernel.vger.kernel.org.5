Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0239D792A9B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244139AbjIEQkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354118AbjIEJlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 05:41:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A50C1AD;
        Tue,  5 Sep 2023 02:41:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D7F011FB;
        Tue,  5 Sep 2023 02:41:44 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 11F2B3F793;
        Tue,  5 Sep 2023 02:41:03 -0700 (PDT)
Message-ID: <04ccbad9-3d36-0962-0027-a7a7e914b02b@arm.com>
Date:   Tue, 5 Sep 2023 10:41:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 10/13] coresight-tpdm: Add nodes to configure pattern
 match output
Content-Language: en-US
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
 <1692681973-20764-11-git-send-email-quic_taozha@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1692681973-20764-11-git-send-email-quic_taozha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/2023 06:26, Tao Zhang wrote:
> Add nodes to configure trigger pattern and trigger pattern mask.
> Each DSB subunit TPDM has maximum of n(n<7) XPR registers to
> configure trigger pattern match output. Eight 32 bit registers
> providing DSB interface trigger output pattern match comparison.
> And each DSB subunit TPDM has maximum of m(m<7) XPMR registers to
> configure trigger pattern mask match output. Eight 32 bit
> registers providing DSB interface trigger output pattern match
> mask.
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> ---
>   .../ABI/testing/sysfs-bus-coresight-devices-tpdm   | 18 +++++-
>   drivers/hwtracing/coresight/coresight-tpdm.c       | 71 +++++++++++++++++++++-
>   drivers/hwtracing/coresight/coresight-tpdm.h       | 29 +++++++++
>   3 files changed, 116 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> index 097fdc4..f5cd302 100644
> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> @@ -107,4 +107,20 @@ Date:		March 2023
>   KernelVersion	6.5
>   Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
>   Description:
> -		Read a set of the edge control mask of the DSB in TPDM.
> \ No newline at end of file
> +		Read a set of the edge control mask of the DSB in TPDM.
> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_trig_patt/xpr[0:7]
> +Date:		March 2023
> +KernelVersion	6.5

Same as previous patches

> +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:
> +		(RW) Set/Get the value of the trigger pattern for the DSB
> +		subunit TPDM.
> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_trig_patt/xpmr[0:7]
> +Date:		March 2023
> +KernelVersion	6.5

here too

> +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:
> +		(RW) Set/Get the mask of the trigger pattern for the DSB
> +		subunit TPDM.
> \ No newline at end of file
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> index ba61e6a..6521019 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
> @@ -39,9 +39,46 @@ static ssize_t tpdm_simple_dataset_show(struct device *dev,
>   	case DSB_EDGE_CTRL_MASK:
>   		return sysfs_emit(buf, "0x%x\n",
>   				drvdata->dsb->edge_ctrl_mask[tpdm_attr->idx]);
> +	case DSB_TRIG_PATT:
> +		return sysfs_emit(buf, "0x%x\n",
> +				drvdata->dsb->trig_patt[tpdm_attr->idx]);
> +	case DSB_TRIG_PATT_MASK:
> +		return sysfs_emit(buf, "0x%x\n",
> +				drvdata->dsb->trig_patt_mask[tpdm_attr->idx]);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +/* Write dataset array member with the index number */
> +static ssize_t tpdm_simple_dataset_store(struct device *dev,
> +					  struct device_attribute *attr,
> +					  const char *buf,
> +					  size_t size)
> +{
> +	unsigned long val;

	ssize_t ret = size;

> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	struct tpdm_dataset_attribute *tpdm_attr =
> +		container_of(attr, struct tpdm_dataset_attribute, attr);
> +
> +	if (kstrtoul(buf, 0, &val) || (tpdm_attr->idx >= tpdm_attr->max))
> +		return -EINVAL;
> +
> +	spin_lock(&drvdata->spinlock);
> +	switch (tpdm_attr->mem) {
> +	case DSB_TRIG_PATT:
> +		drvdata->dsb->trig_patt[tpdm_attr->idx] = val;
> +		break;
> +	case DSB_TRIG_PATT_MASK:
> +		drvdata->dsb->trig_patt_mask[tpdm_attr->idx] = val;
> +		break;
>   	default:
> +		spin_unlock(&drvdata->spinlock);

		ret = -EINVAL;

Please avoid releasing the lock in two different places where possible.
Instead use a variable like above.

>   		return -EINVAL;
>   	}
> +	spin_unlock(&drvdata->spinlock);
> +
> +	return size;

	return ret;

>   }
>   
>   static bool tpdm_has_dsb_dataset(struct tpdm_drvdata *drvdata)
> @@ -102,7 +139,12 @@ static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
>   	for (i = 0; i < TPDM_DSB_MAX_EDCMR; i++)
>   		writel_relaxed(drvdata->dsb->edge_ctrl_mask[i],
>   			   drvdata->base + TPDM_DSB_EDCMR(i));
> -
> +	for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {
> +		writel_relaxed(drvdata->dsb->trig_patt[i],
> +			    drvdata->base + TPDM_DSB_XPR(i));
> +		writel_relaxed(drvdata->dsb->trig_patt_mask[i],
> +			    drvdata->base + TPDM_DSB_XPMR(i));
> +	}
>   	val = readl_relaxed(drvdata->base + TPDM_DSB_TIER);
>   	/* Set trigger timestamp */
>   	if (drvdata->dsb->trig_ts)
> @@ -531,6 +573,26 @@ static struct attribute *tpdm_dsb_edge_attrs[] = {
>   	NULL,
>   };
>   
> +static struct attribute *tpdm_dsb_trig_patt_attrs[] = {
> +	DSB_TRIG_PATT_ATTR(0),
> +	DSB_TRIG_PATT_ATTR(1),
> +	DSB_TRIG_PATT_ATTR(2),
> +	DSB_TRIG_PATT_ATTR(3),
> +	DSB_TRIG_PATT_ATTR(4),
> +	DSB_TRIG_PATT_ATTR(5),
> +	DSB_TRIG_PATT_ATTR(6),
> +	DSB_TRIG_PATT_ATTR(7),
> +	DSB_TRIG_PATT_MASK_ATTR(0),
> +	DSB_TRIG_PATT_MASK_ATTR(1),
> +	DSB_TRIG_PATT_MASK_ATTR(2),
> +	DSB_TRIG_PATT_MASK_ATTR(3),
> +	DSB_TRIG_PATT_MASK_ATTR(4),
> +	DSB_TRIG_PATT_MASK_ATTR(5),
> +	DSB_TRIG_PATT_MASK_ATTR(6),
> +	DSB_TRIG_PATT_MASK_ATTR(7),
> +	NULL,
> +};
> +
>   static struct attribute *tpdm_dsb_attrs[] = {
>   	&dev_attr_dsb_mode.attr,
>   	&dev_attr_dsb_trig_ts.attr,
> @@ -549,10 +611,17 @@ static struct attribute_group tpdm_dsb_edge_grp = {
>   	.name = "dsb_edge",
>   };
>   
> +static struct attribute_group tpdm_dsb_trig_patt_grp = {
> +	.attrs = tpdm_dsb_trig_patt_attrs,
> +	.is_visible = tpdm_dsb_is_visible,
> +	.name = "dsb_trig_patt",
> +};
> +
>   static const struct attribute_group *tpdm_attr_grps[] = {
>   	&tpdm_attr_grp,
>   	&tpdm_dsb_attrs_grp,
>   	&tpdm_dsb_edge_grp,
> +	&tpdm_dsb_trig_patt_grp,
>   	NULL,
>   };
>   
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
> index 9736e00..9e1b0a4 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.h
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.h
> @@ -12,6 +12,8 @@
>   /* DSB Subunit Registers */
>   #define TPDM_DSB_CR		(0x780)
>   #define TPDM_DSB_TIER		(0x784)
> +#define TPDM_DSB_XPR(n)		(0x7C8 + (n * 4))
> +#define TPDM_DSB_XPMR(n)	(0x7E8 + (n * 4))
>   #define TPDM_DSB_EDCR(n)	(0x808 + (n * 4))
>   #define TPDM_DSB_EDCMR(n)	(0x848 + (n * 4))
>   
> @@ -80,6 +82,8 @@
>   #define TPDM_DSB_MAX_EDCR	16
>   /* MAX number of EDCMR registers */
>   #define TPDM_DSB_MAX_EDCMR	8
> +/* MAX number of DSB pattern */
> +#define TPDM_DSB_MAX_PATT	8
>   
>   #define tpdm_simple_dataset_ro(name, mem, idx, max)			\
>   	(&((struct tpdm_dataset_attribute[]) {			\
> @@ -91,6 +95,17 @@
>   	   }								\
>   	})[0].attr.attr)
>   
> +#define tpdm_simple_dataset_rw(name, mem, idx, max)			\
> +	(&((struct tpdm_dataset_attribute[]) {			\
> +	   {								\
> +		__ATTR(name, 0644, tpdm_simple_dataset_show,		\
> +		tpdm_simple_dataset_store),		\
> +		mem,							\ > +		idx,							\
> +		max								\

Same as previous, you could get rid of max

> +	   }								\
> +	})[0].attr.attr)
> +
>   #define DSB_EDGE_CTRL_ATTR(nr)					\
>   		tpdm_simple_dataset_ro(edcr##nr,		\
>   		DSB_EDGE_CTRL, nr, TPDM_DSB_MAX_EDCR)
> @@ -99,12 +114,22 @@
>   		tpdm_simple_dataset_ro(edcmr##nr,		\
>   		DSB_EDGE_CTRL_MASK, nr, TPDM_DSB_MAX_EDCMR)
>   
> +#define DSB_TRIG_PATT_ATTR(nr)					\
> +		tpdm_simple_dataset_rw(xpr##nr,			\
> +		DSB_TRIG_PATT, nr, TPDM_DSB_MAX_PATT)
> +
> +#define DSB_TRIG_PATT_MASK_ATTR(nr)				\
> +		tpdm_simple_dataset_rw(xpmr##nr,		\
> +		DSB_TRIG_PATT_MASK, nr, TPDM_DSB_MAX_PATT)
> +
>   /**
>    * struct dsb_dataset - specifics associated to dsb dataset
>    * @mode:             DSB programming mode
>    * @edge_ctrl_idx     Index number of the edge control
>    * @edge_ctrl:        Save value for edge control
>    * @edge_ctrl_mask:   Save value for edge control mask
> + * @trig_patt:        Save value for trigger pattern
> + * @trig_patt_mask:   Save value for trigger pattern mask
>    * @trig_ts:          Enable/Disable trigger timestamp.
>    * @trig_type:        Enable/Disable trigger type.
>    */
> @@ -113,6 +138,8 @@ struct dsb_dataset {
>   	u32				edge_ctrl_idx;
>   	u32				edge_ctrl[TPDM_DSB_MAX_EDCR];
>   	u32				edge_ctrl_mask[TPDM_DSB_MAX_EDCMR];
> +	u32				trig_patt[TPDM_DSB_MAX_PATT];
> +	u32				trig_patt_mask[TPDM_DSB_MAX_PATT];
>   	bool			trig_ts;
>   	bool			trig_type;
>   };
> @@ -142,6 +169,8 @@ struct tpdm_drvdata {
>   enum dataset_mem {
>   	DSB_EDGE_CTRL,
>   	DSB_EDGE_CTRL_MASK,
> +	DSB_TRIG_PATT,
> +	DSB_TRIG_PATT_MASK,
>   };

Suzuki


