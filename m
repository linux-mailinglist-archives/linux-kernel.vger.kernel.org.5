Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953377721B5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 13:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjHGLYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 07:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbjHGLXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:23:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D7F03C30;
        Mon,  7 Aug 2023 04:21:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9861D75;
        Mon,  7 Aug 2023 04:15:47 -0700 (PDT)
Received: from [10.57.90.63] (unknown [10.57.90.63])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0882A3F59C;
        Mon,  7 Aug 2023 04:15:01 -0700 (PDT)
Message-ID: <6535a243-b69c-8571-2d2c-c686f25a9dc5@arm.com>
Date:   Mon, 7 Aug 2023 12:15:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v7 10/13] coresight-tpdm: Add nodes to configure pattern
 match output
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
 <1690269353-10829-11-git-send-email-quic_taozha@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1690269353-10829-11-git-send-email-quic_taozha@quicinc.com>
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
>   .../ABI/testing/sysfs-bus-coresight-devices-tpdm   |  34 +++++-
>   drivers/hwtracing/coresight/coresight-tpdm.c       | 118 +++++++++++++++++++++
>   drivers/hwtracing/coresight/coresight-tpdm.h       |  10 ++
>   3 files changed, 161 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> index a4550c5..66f9582 100644
> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> @@ -98,4 +98,36 @@ Description:
>   		should be written first to configure the index number of the edge
>   		detection which needs to be masked.
>   
> -		Accepts only one of the 2 values -  0 or 1.
> \ No newline at end of file
> +		Accepts only one of the 2 values -  0 or 1.
> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_trig_patt_idx
> +Date:		March 2023
> +KernelVersion	6.5
> +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:
> +		Read/Write the index number of the trigger pattern value of DSB
> +		tpdm. Since there are at most 8 XPR and XPMR registers for the
> +		trigger parttern, this value ranges from 0 to 7.
> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_trig_patt_val
> +Date:		March 2023
> +KernelVersion	6.5
> +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:
> +		Read a set of the trigger pattern values of the DSB TPDM.
> +		Write a data to configure the trigger pattern corresponding to
> +		the index number. Before writing data to this sysfs file,
> +		"dsb_trig_patt_idx" should be written first to configure the
> +		index number of the trigger pattern which needs to be configured.
> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_trig_patt_mask
> +Date:		March 2023
> +KernelVersion	6.5
> +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:
> +		Read a set of the trigger pattern mask of the DSB TPDM.
> +		Write a data to configure the trigger pattern mask corresponding
> +		to the index number. Before writing data to this sysfs file,
> +		"dsb_trig_patt_idx" should be written first to configure the
> +		index number of the trigger pattern mask which needs to be
> +		configured.
> \ No newline at end of file
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> index 98fd6ab..1c32d27 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
> @@ -80,6 +80,13 @@ static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
>   		writel_relaxed(drvdata->dsb->edge_ctrl_mask[i],
>   			   drvdata->base + TPDM_DSB_EDCMR(i));
>   
> +	for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {
> +		writel_relaxed(drvdata->dsb->trig_patt[i],
> +			    drvdata->base + TPDM_DSB_XPR(i));
> +		writel_relaxed(drvdata->dsb->trig_patt_mask[i],
> +			    drvdata->base + TPDM_DSB_XPMR(i));
> +	}
> +
>   	val = readl_relaxed(drvdata->base + TPDM_DSB_TIER);
>   	/* Set trigger timestamp */
>   	if (drvdata->dsb->trig_ts)
> @@ -455,6 +462,114 @@ static ssize_t dsb_edge_ctrl_mask_store(struct device *dev,
>   }
>   static DEVICE_ATTR_RW(dsb_edge_ctrl_mask);
>   
> +static ssize_t dsb_trig_patt_idx_show(struct device *dev,
> +					   struct device_attribute *attr,
> +					   char *buf)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +
> +	return sysfs_emit(buf, "%u\n",
> +			 (unsigned int)drvdata->dsb->trig_patt_idx);
> +}
> +
> +static ssize_t dsb_trig_patt_idx_store(struct device *dev,
> +					    struct device_attribute *attr,
> +					    const char *buf,
> +					    size_t size)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned long index;
> +
> +	if (kstrtoul(buf, 0, &index))
> +		return -EINVAL;
> +	if (index >= TPDM_DSB_MAX_PATT)
> +		return -EPERM;
> +
> +	spin_lock(&drvdata->spinlock);
> +	drvdata->dsb->trig_patt_idx = index;
> +	spin_unlock(&drvdata->spinlock);
> +	return size;
> +}
> +static DEVICE_ATTR_RW(dsb_trig_patt_idx);
> +
> +static ssize_t dsb_trig_patt_val_show(struct device *dev,
> +					   struct device_attribute *attr,
> +					   char *buf)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	ssize_t size = 0;
> +	unsigned long bytes;
> +	int i = 0;
> +
> +	spin_lock(&drvdata->spinlock);
> +	for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {
> +		bytes = sysfs_emit_at(buf, size,
> +				  "Value: 0x%x\n", drvdata->dsb->trig_patt[i]);
> +		if (bytes <= 0)
> +			break;
> +		size += bytes;
> +	}
> +	spin_unlock(&drvdata->spinlock);
> +	return size;
> +}
> +
> +static ssize_t dsb_trig_patt_val_store(struct device *dev,
> +					    struct device_attribute *attr,
> +					    const char *buf,
> +					    size_t size)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned long val;
> +
> +	if (kstrtoul(buf, 0, &val))
> +		return -EINVAL;
> +
> +	spin_lock(&drvdata->spinlock);
> +	drvdata->dsb->trig_patt[drvdata->dsb->trig_patt_idx] = val;
> +	spin_unlock(&drvdata->spinlock);
> +	return size;
> +}
> +static DEVICE_ATTR_RW(dsb_trig_patt_val);
> +
> +static ssize_t dsb_trig_patt_mask_show(struct device *dev,
> +					    struct device_attribute *attr,
> +					    char *buf)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	ssize_t size = 0;
> +	unsigned long bytes;
> +	int i = 0;
> +
> +	spin_lock(&drvdata->spinlock);
> +	for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {
> +		bytes = sysfs_emit_at(buf, size,
> +			  "Value: 0x%x\n", drvdata->dsb->trig_patt_mask[i]);

As mentioned above, please stick to single value. In this case, we could 
simply expose :

dsb_trig_patt_mask0..7 as RW and directly let the user set/get the 
values and get rid of the idx.

You may be able to use an device_ext_attribute to store the index and 
use a single function to support all registers.

Suzuki

