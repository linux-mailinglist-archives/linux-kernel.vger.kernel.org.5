Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D4B771D12
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 11:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbjHGJYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 05:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjHGJYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:24:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 06FA91703;
        Mon,  7 Aug 2023 02:24:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 982C11FB;
        Mon,  7 Aug 2023 02:24:55 -0700 (PDT)
Received: from [10.57.90.63] (unknown [10.57.90.63])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D0C063F59C;
        Mon,  7 Aug 2023 02:24:09 -0700 (PDT)
Message-ID: <6105f48f-86b2-3a68-a33f-e2bb3ed6f9c9@arm.com>
Date:   Mon, 7 Aug 2023 10:24:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v7 09/13] coresight-tpdm: Add nodes for dsb edge control
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
 <1690269353-10829-10-git-send-email-quic_taozha@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1690269353-10829-10-git-send-email-quic_taozha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/2023 08:15, Tao Zhang wrote:
> Add the nodes to set value for DSB edge control and DSB edge
> control mask. Each DSB subunit TPDM has maximum of n(n<16) EDCR
> resgisters to configure edge control. DSB edge detection control
> 00: Rising edge detection
> 01: Falling edge detection
> 10: Rising and falling edge detection (toggle detection)
> And each DSB subunit TPDM has maximum of m(m<8) ECDMR registers to
> configure mask. Eight 32 bit registers providing DSB interface
> edge detection mask control.
> 
> Add the nodes to configure DSB edge control and DSB edge control
> mask. Each DSB subunit TPDM maximum of 256 edge detections can be
> configured. The index and value sysfs files need to be paired and
> written to order. The index sysfs file is to set the index number
> of the edge detection which needs to be configured. And the value
> sysfs file is to set the control or mask for the edge detection.
> DSB edge detection control should be set as the following values.
> 00: Rising edge detection
> 01: Falling edge detection
> 10: Rising and falling edge detection (toggle detection)
> And DSB edge mask should be set as 0 or 1.
> Each DSB subunit TPDM has maximum of n(n<16) EDCR resgisters to
> configure edge control. And each DSB subunit TPDM has maximum of
> m(m<8) ECDMR registers to configure mask.
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> ---
>   .../ABI/testing/sysfs-bus-coresight-devices-tpdm   |  39 +++++
>   drivers/hwtracing/coresight/coresight-tpdm.c       | 158 ++++++++++++++++++++-
>   drivers/hwtracing/coresight/coresight-tpdm.h       |  30 +++-
>   3 files changed, 223 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> index 2a82cd0..a4550c5 100644
> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> @@ -60,3 +60,42 @@ Description:
>   		Bit[3] : Set to 0 for low performance mode.
>   				 Set to 1 for high performance mode.
>   		Bit[4:8] : Select byte lane for high performance mode.
> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_edge_ctrl_idx
> +Date:		March 2023
> +KernelVersion	6.5
> +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:
> +		Read/Write the index number of the edge detection for the DSB
> +		subunit TPDM. Since there are at most 256 edge detections, this
> +		value ranges from 0 to 255.
> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_edge_ctrl_val
> +Date:		March 2023
> +KernelVersion	6.5
> +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:
> +		Read a set of the edge control registers of the DSB in TPDM.
> +		Write a data to control the edge detection corresponding to
> +		the index number. Before writing data to this sysfs file,
> +		"dsb_edge_ctrl_idx" should be written first to configure the
> +		index number of the edge detection which needs to be controlled.
> +
> +		Accepts only one of the following values.
> +		0 - Rising edge detection
> +		1 - Falling edge detection
> +		2 - Rising and falling edge detection (toggle detection)
> +
> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_edge_ctrl_mask
> +Date:		March 2023
> +KernelVersion	6.5
> +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:
> +		Read a set of the edge control mask registers of the DSB in TPDM.
> +		Write a data to mask the edge detection corresponding to the index
> +		number. Before writing data to this sysfs file, "dsb_edge_ctrl_idx"
> +		should be written first to configure the index number of the edge
> +		detection which needs to be masked.
> +
> +		Accepts only one of the 2 values -  0 or 1.
> \ No newline at end of file
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> index c38760b..98fd6ab 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
> @@ -71,7 +71,14 @@ static void set_dsb_perf_mode(struct tpdm_drvdata *drvdata, u32 *val)
>   
>   static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
>   {
> -	u32 val;
> +	u32 val, i;
> +
> +	for (i = 0; i < TPDM_DSB_MAX_EDCR; i++)
> +		writel_relaxed(drvdata->dsb->edge_ctrl[i],
> +			   drvdata->base + TPDM_DSB_EDCR(i));
> +	for (i = 0; i < TPDM_DSB_MAX_EDCMR; i++)
> +		writel_relaxed(drvdata->dsb->edge_ctrl_mask[i],
> +			   drvdata->base + TPDM_DSB_EDCMR(i));
>   
>   	val = readl_relaxed(drvdata->base + TPDM_DSB_TIER);
>   	/* Set trigger timestamp */
> @@ -302,6 +309,152 @@ static ssize_t dsb_mode_store(struct device *dev,
>   }
>   static DEVICE_ATTR_RW(dsb_mode);
>   
> +static ssize_t dsb_edge_ctrl_idx_show(struct device *dev,
> +				       struct device_attribute *attr,
> +				       char *buf)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +
> +	return sysfs_emit(buf, "%u\n",
> +			 (unsigned int)drvdata->dsb->edge_ctrl_idx);
> +}
> +
> +/*
> + * The EDCR registers can include up to 16 32-bit registers, and each
> + * one can be configured to control up to 16 edge detections(2 bits
> + * control one edge detection). So a total 256 edge detections can be
> + * configured. This function provides a way to set the index number of
> + * the edge detection which needs to be configured.
> + */
> +static ssize_t dsb_edge_ctrl_idx_store(struct device *dev,
> +					struct device_attribute *attr,
> +					const char *buf,
> +					size_t size)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned long val;
> +
> +	if ((kstrtoul(buf, 0, &val)) || (val >= TPDM_DSB_MAX_LINES))
> +		return -EINVAL;
> +
> +	spin_lock(&drvdata->spinlock);
> +	drvdata->dsb->edge_ctrl_idx = val;
> +	spin_unlock(&drvdata->spinlock);
> +
> +	return size;
> +}
> +static DEVICE_ATTR_RW(dsb_edge_ctrl_idx);
> +
> +static ssize_t dsb_edge_ctrl_val_show(struct device *dev,
> +				       struct device_attribute *attr,
> +				       char *buf)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	ssize_t size = 0;
> +	unsigned long bytes;
> +	int i;
> +
> +	spin_lock(&drvdata->spinlock);
> +	for (i = 0; i < TPDM_DSB_MAX_EDCR; i++) {
> +		bytes = sysfs_emit_at(buf, size,
> +				  "Val:0x%x\n", drvdata->dsb->edge_ctrl[i]);
> +		if (bytes <= 0)
> +			break;
> +		size += bytes;
> +	}
> +	spin_unlock(&drvdata->spinlock);
> +	return size;
> +}
> +
> +/*
> + * This function is used to control the edge detection according
> + * to the index number that has been set.
> + * "edge_ctrl" should be one of the following values.
> + * 0 - Rising edge detection
> + * 1 - Falling edge detection
> + * 2 - Rising and falling edge detection (toggle detection)
> + */
> +static ssize_t dsb_edge_ctrl_val_store(struct device *dev,
> +					struct device_attribute *attr,
> +					const char *buf,
> +					size_t size)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned long val, mask, edge_ctrl;
> +	int reg;
> +
> +	if ((kstrtoul(buf, 0, &edge_ctrl)) || (edge_ctrl > 0x2))
> +		return -EINVAL;
> +
> +	spin_lock(&drvdata->spinlock);
> +	/*
> +	 * There are 2 bit per DSB Edge Control line.
> +	 * Thus we have 16 lines in a 32bit word.
> +	 */
> +	reg = EDCR_TO_WORD_IDX(drvdata->dsb->edge_ctrl_idx);
> +	mask = EDCR_TO_WORD_MASK(drvdata->dsb->edge_ctrl_idx);
> +	val = drvdata->dsb->edge_ctrl[reg];
> +	val &= ~EDCR_TO_WORD_MASK(drvdata->dsb->edge_ctrl_idx);
> +	val |= EDCR_TO_WORD_VAL(edge_ctrl, drvdata->dsb->edge_ctrl_idx);
> +	drvdata->dsb->edge_ctrl[reg] = val;
> +	spin_unlock(&drvdata->spinlock);
> +
> +	return size;
> +}
> +static DEVICE_ATTR_RW(dsb_edge_ctrl_val);
> +
> +static ssize_t dsb_edge_ctrl_mask_show(struct device *dev,
> +					    struct device_attribute *attr,
> +					    char *buf)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	ssize_t size = 0;
> +	unsigned long bytes;
> +	int i;
> +
> +	spin_lock(&drvdata->spinlock);
> +	for (i = 0; i < TPDM_DSB_MAX_EDCMR; i++) {
> +		bytes = sysfs_emit_at(buf, size,
> +				  "Val:0x%x\n", drvdata->dsb->edge_ctrl_mask[i]);
> +		if (bytes <= 0)
> +			break;
> +		size += bytes;
> +	}
> +	spin_unlock(&drvdata->spinlock);
> +	return size;
> +}
> +
> +static ssize_t dsb_edge_ctrl_mask_store(struct device *dev,
> +					     struct device_attribute *attr,
> +					     const char *buf,
> +					     size_t size)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned long val;
> +	u32 set;
> +	int reg;
> +
> +	if ((kstrtoul(buf, 0, &val)) || (val & ~1UL))
> +		return -EINVAL;
> +
> +	spin_lock(&drvdata->spinlock);
> +	/*
> +	 * There is 1 bit per DSB Edge Control Mark line.
> +	 * Thus we have 32 lines in a 32bit word.
> +	 */
> +	reg = EDCMR_TO_WORD_IDX(drvdata->dsb->edge_ctrl_idx);
> +	set = drvdata->dsb->edge_ctrl_mask[reg];
> +	if (val)
> +		set |= BIT(EDCMR_TO_WORD_SHIFT(drvdata->dsb->edge_ctrl_idx));
> +	else
> +		set &= ~BIT(EDCMR_TO_WORD_SHIFT(drvdata->dsb->edge_ctrl_idx));
> +		drvdata->dsb->edge_ctrl_mask[reg] = set;


drivers/hwtracing/coresight/coresight-tpdm.c: In function 
‘dsb_edge_ctrl_mask_store’:
drivers/hwtracing/coresight/coresight-tpdm.c:449:2: error: this ‘else’ 
clause does not guard... [-Werror=misleading-indentation]
   else
   ^~~~
drivers/hwtracing/coresight/coresight-tpdm.c:451:3: note: ...this 
statement, but the latter is misleadingly indented as if it were guarded 
by the ‘else’
    drvdata->dsb->edge_ctrl_mask[reg] = set;
    ^~~~~~~
cc1: all warnings being treated as errors
make[4]: *** [scripts/Makefile.build:243: 
drivers/hwtracing/coresight/coresight-tpdm.o] Error 1
make[3]: *** [scripts/Makefile.build:480: drivers/hwtracing/coresight] 
Error 2
make[2]: *** [scripts/Makefile.build:480: drivers] Error 2
make[1]: *** [/ssd/src/LINUX-CORESIGHT/Makefile:2032: .] Error 2
make: *** [Makefile:234: __sub-make] Error 2

Suzuki
