Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBF07DB904
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 12:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbjJ3LdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 07:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbjJ3LdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 07:33:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B6C5DE;
        Mon, 30 Oct 2023 04:33:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6618FEC;
        Mon, 30 Oct 2023 04:33:46 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B9963F738;
        Mon, 30 Oct 2023 04:33:02 -0700 (PDT)
Message-ID: <38112960-774b-9b22-23a5-ca1bd438f444@arm.com>
Date:   Mon, 30 Oct 2023 11:33:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 5/8] coresight-tpdm: Add pattern registers support for
 CMB
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
 <1698202408-14608-6-git-send-email-quic_taozha@quicinc.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <1698202408-14608-6-git-send-email-quic_taozha@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/10/2023 03:53, Tao Zhang wrote:
> Timestamps are requested if the monitor’s CMB data set unit input
> data matches the value in the Monitor CMB timestamp pattern and mask
> registers (M_CMB_TPR and M_CMB_TPMR) when CMB timestamp enabled
> via the timestamp insertion enable register bit(CMB_TIER.PATT_TSENAB).
> The pattern match trigger output is achieved via setting values into
> the CMB trigger pattern and mask registers (CMB_XPR and CMB_XPMR).
> After configuring a pattern through these registers, the TPDM subunit
> will assert an output trigger every time it receives new input data
> that matches the configured pattern value. Values in a given bit
> number of the mask register correspond to the same bit number in
> the corresponding pattern register.
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> Signed-off-by: Jinlong Mao <quic_jinlmao@quicinc.com>

Reviewed-by: James Clark <james.clark@arm.com>

> ---
>  .../ABI/testing/sysfs-bus-coresight-devices-tpdm   | 30 ++++++++
>  drivers/hwtracing/coresight/coresight-tpdm.c       | 88 +++++++++++++++++++++-
>  drivers/hwtracing/coresight/coresight-tpdm.h       | 39 ++++++++++
>  3 files changed, 156 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> index ace7231..c17468f 100644
> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> @@ -180,3 +180,33 @@ Description:	(Write) Set the data collection mode of CMB tpdm.
>  		Accepts only one of the 2 values -  0 or 1.
>  		0 : Continuous CMB collection mode.
>  		1 : Trace-on-change CMB collection mode.
> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/cmb_trig_patt/xpr[0:1]
> +Date:		March 2023
> +KernelVersion	6.7
> +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:
> +		(RW) Set/Get the value of the trigger pattern for the CMB
> +		subunit TPDM.
> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/cmb_trig_patt/xpmr[0:1]
> +Date:		March 2023
> +KernelVersion	6.7
> +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:
> +		(RW) Set/Get the mask of the trigger pattern for the CMB
> +		subunit TPDM.
> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_patt/tpr[0:1]
> +Date:		March 2023
> +KernelVersion	6.7
> +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:
> +		(RW) Set/Get the value of the pattern for the CMB subunit TPDM.
> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_patt/tpmr[0:1]
> +Date:		March 2023
> +KernelVersion	6.7
> +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:
> +		(RW) Set/Get the mask of the pattern for the CMB subunit TPDM.
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> index efb376e..894d430 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
> @@ -66,6 +66,26 @@ static ssize_t tpdm_simple_dataset_show(struct device *dev,
>  			return -EINVAL;
>  		return sysfs_emit(buf, "0x%x\n",
>  				drvdata->dsb->msr[tpdm_attr->idx]);
> +	case CMB_TRIG_PATT:
> +		if (tpdm_attr->idx >= TPDM_CMB_MAX_PATT)
> +			return -EINVAL;
> +		return sysfs_emit(buf, "0x%x\n",
> +			drvdata->cmb->trig_patt[tpdm_attr->idx]);
> +	case CMB_TRIG_PATT_MASK:
> +		if (tpdm_attr->idx >= TPDM_CMB_MAX_PATT)
> +			return -EINVAL;
> +		return sysfs_emit(buf, "0x%x\n",
> +			drvdata->cmb->trig_patt_mask[tpdm_attr->idx]);
> +	case CMB_PATT:
> +		if (tpdm_attr->idx >= TPDM_CMB_MAX_PATT)
> +			return -EINVAL;
> +		return sysfs_emit(buf, "0x%x\n",
> +			drvdata->cmb->patt_val[tpdm_attr->idx]);
> +	case CMB_PATT_MASK:
> +		if (tpdm_attr->idx >= TPDM_CMB_MAX_PATT)
> +			return -EINVAL;
> +		return sysfs_emit(buf, "0x%x\n",
> +			drvdata->cmb->patt_mask[tpdm_attr->idx]);
>  	}
>  	return -EINVAL;
>  }
> @@ -118,6 +138,30 @@ static ssize_t tpdm_simple_dataset_store(struct device *dev,
>  		else
>  			ret = -EINVAL;
>  		break;
> +	case CMB_TRIG_PATT:
> +		if (tpdm_attr->idx < TPDM_CMB_MAX_PATT)
> +			drvdata->cmb->trig_patt[tpdm_attr->idx] = val;
> +		else
> +			ret = -EINVAL;
> +		break;
> +	case CMB_TRIG_PATT_MASK:
> +		if (tpdm_attr->idx < TPDM_CMB_MAX_PATT)
> +			drvdata->cmb->trig_patt_mask[tpdm_attr->idx] = val;
> +		else
> +			ret = -EINVAL;
> +		break;
> +	case CMB_PATT:
> +		if (tpdm_attr->idx < TPDM_CMB_MAX_PATT)
> +			drvdata->cmb->patt_val[tpdm_attr->idx] = val;
> +		else
> +			ret = -EINVAL;
> +		break;
> +	case CMB_PATT_MASK:
> +		if (tpdm_attr->idx < TPDM_CMB_MAX_PATT)
> +			drvdata->cmb->patt_mask[tpdm_attr->idx] = val;
> +		else
> +			ret = -EINVAL;
> +		break;
>  	default:
>  		ret = -EINVAL;
>  	}
> @@ -289,7 +333,19 @@ static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
>  
>  static void tpdm_enable_cmb(struct tpdm_drvdata *drvdata)
>  {
> -	u32 val;
> +	u32 val, i;
> +
> +	/* Configure pattern registers */
> +	for (i = 0; i < TPDM_CMB_MAX_PATT; i++) {
> +		writel_relaxed(drvdata->cmb->patt_val[i],
> +			    drvdata->base + TPDM_CMB_TPR(i));
> +		writel_relaxed(drvdata->cmb->patt_mask[i],
> +			    drvdata->base + TPDM_CMB_TPMR(i));
> +		writel_relaxed(drvdata->cmb->trig_patt[i],
> +			    drvdata->base + TPDM_CMB_XPR(i));
> +		writel_relaxed(drvdata->cmb->trig_patt_mask[i],
> +			    drvdata->base + TPDM_CMB_XPMR(i));
> +	}
>  
>  	val = readl_relaxed(drvdata->base + TPDM_CMB_CR);
>  	/*
> @@ -904,6 +960,22 @@ static struct attribute *tpdm_dsb_msr_attrs[] = {
>  	NULL,
>  };
>  
> +static struct attribute *tpdm_cmb_trig_patt_attrs[] = {
> +	CMB_TRIG_PATT_ATTR(0),
> +	CMB_TRIG_PATT_ATTR(1),
> +	CMB_TRIG_PATT_MASK_ATTR(0),
> +	CMB_TRIG_PATT_MASK_ATTR(1),
> +	NULL,
> +};
> +
> +static struct attribute *tpdm_cmb_patt_attrs[] = {
> +	CMB_PATT_ATTR(0),
> +	CMB_PATT_ATTR(1),
> +	CMB_PATT_MASK_ATTR(0),
> +	CMB_PATT_MASK_ATTR(1),
> +	NULL,
> +};
> +
>  static struct attribute *tpdm_dsb_attrs[] = {
>  	&dev_attr_dsb_mode.attr,
>  	&dev_attr_dsb_trig_ts.attr,
> @@ -950,6 +1022,18 @@ static struct attribute_group tpdm_cmb_attr_grp = {
>  	.is_visible = tpdm_cmb_is_visible,
>  };
>  
> +static struct attribute_group tpdm_cmb_trig_patt_grp = {
> +	.attrs = tpdm_cmb_trig_patt_attrs,
> +	.is_visible = tpdm_cmb_is_visible,
> +	.name = "cmb_trig_patt",
> +};
> +
> +static struct attribute_group tpdm_cmb_patt_grp = {
> +	.attrs = tpdm_cmb_patt_attrs,
> +	.is_visible = tpdm_cmb_is_visible,
> +	.name = "cmb_patt",
> +};
> +
>  static const struct attribute_group *tpdm_attr_grps[] = {
>  	&tpdm_attr_grp,
>  	&tpdm_dsb_attr_grp,
> @@ -958,6 +1042,8 @@ static const struct attribute_group *tpdm_attr_grps[] = {
>  	&tpdm_dsb_patt_grp,
>  	&tpdm_dsb_msr_grp,
>  	&tpdm_cmb_attr_grp,
> +	&tpdm_cmb_trig_patt_grp,
> +	&tpdm_cmb_patt_grp,
>  	NULL,
>  };
>  
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
> index c6b36d2..e90d008c 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.h
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.h
> @@ -11,12 +11,23 @@
>  
>  /* CMB Subunit Registers */
>  #define TPDM_CMB_CR		(0xA00)
> +/*CMB subunit timestamp pattern registers*/
> +#define TPDM_CMB_TPR(n)		(0xA08 + (n * 4))
> +/*CMB subunit timestamp pattern mask registers*/
> +#define TPDM_CMB_TPMR(n)	(0xA10 + (n * 4))
> +/*CMB subunit trigger pattern registers*/
> +#define TPDM_CMB_XPR(n)		(0xA18 + (n * 4))
> +/*CMB subunit trigger pattern mask registers*/
> +#define TPDM_CMB_XPMR(n)	(0xA20 + (n * 4))
>  
>  /* Enable bit for CMB subunit */
>  #define TPDM_CMB_CR_ENA		BIT(0)
>  /* Trace collection mode for CMB subunit */
>  #define TPDM_CMB_CR_MODE	BIT(1)
>  
> +/*Patten register number*/
> +#define TPDM_CMB_MAX_PATT		2
> +
>  /* DSB Subunit Registers */
>  #define TPDM_DSB_CR		(0x780)
>  #define TPDM_DSB_TIER		(0x784)
> @@ -151,6 +162,22 @@
>  		tpdm_simple_dataset_rw(msr##nr,			\
>  		DSB_MSR, nr)
>  
> +#define CMB_TRIG_PATT_ATTR(nr)					\
> +		tpdm_simple_dataset_rw(xpr##nr,			\
> +		CMB_TRIG_PATT, nr)
> +
> +#define CMB_TRIG_PATT_MASK_ATTR(nr)				\
> +		tpdm_simple_dataset_rw(xpmr##nr,		\
> +		CMB_TRIG_PATT_MASK, nr)
> +
> +#define CMB_PATT_ATTR(nr)					\
> +		tpdm_simple_dataset_rw(tpr##nr,			\
> +		CMB_PATT, nr)
> +
> +#define CMB_PATT_MASK_ATTR(nr)					\
> +		tpdm_simple_dataset_rw(tpmr##nr,		\
> +		CMB_PATT_MASK, nr)
> +
>  /**
>   * struct dsb_dataset - specifics associated to dsb dataset
>   * @mode:             DSB programming mode
> @@ -186,9 +213,17 @@ struct dsb_dataset {
>  /**
>   * struct cmb_dataset
>   * @trace_mode:       Dataset collection mode
> + * @patt_val:         Save value for pattern
> + * @patt_mask:        Save value for pattern mask
> + * @trig_patt:        Save value for trigger pattern
> + * @trig_patt_mask:   Save value for trigger pattern mask
>   */
>  struct cmb_dataset {
>  	u32			trace_mode;
> +	u32			patt_val[TPDM_CMB_MAX_PATT];
> +	u32			patt_mask[TPDM_CMB_MAX_PATT];
> +	u32			trig_patt[TPDM_CMB_MAX_PATT];
> +	u32			trig_patt_mask[TPDM_CMB_MAX_PATT];
>  };
>  
>  /**
> @@ -225,6 +260,10 @@ enum dataset_mem {
>  	DSB_PATT,
>  	DSB_PATT_MASK,
>  	DSB_MSR,
> +	CMB_TRIG_PATT,
> +	CMB_TRIG_PATT_MASK,
> +	CMB_PATT,
> +	CMB_PATT_MASK
>  };
>  
>  /**
