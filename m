Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB26771DB3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 12:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjHGKAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 06:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjHGKAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 06:00:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5717FF4;
        Mon,  7 Aug 2023 03:00:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBCA41FB;
        Mon,  7 Aug 2023 03:01:12 -0700 (PDT)
Received: from [10.57.90.63] (unknown [10.57.90.63])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 328BF3F59C;
        Mon,  7 Aug 2023 03:00:27 -0700 (PDT)
Message-ID: <2a134787-b0a7-1acd-7ea8-efc7c1920095@arm.com>
Date:   Mon, 7 Aug 2023 11:00:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v7 08/13] coresight-tpdm: Add node to set dsb programming
 mode
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
 <1690269353-10829-9-git-send-email-quic_taozha@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1690269353-10829-9-git-send-email-quic_taozha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/2023 08:15, Tao Zhang wrote:
> Add node to set and show programming mode for TPDM DSB subunit.
> Once the DSB programming mode is set, it will be written to the
> register DSB_CR.
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> ---
>   .../ABI/testing/sysfs-bus-coresight-devices-tpdm   | 15 ++++++
>   drivers/hwtracing/coresight/coresight-tpdm.c       | 62 ++++++++++++++++++++++
>   drivers/hwtracing/coresight/coresight-tpdm.h       | 16 ++++++
>   3 files changed, 93 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> index 0b7b4ad..2a82cd0 100644
> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> @@ -45,3 +45,18 @@ Description:
>   		Accepts only one of the 2 values -  0 or 1.
>   		0 : Set the DSB trigger type to false
>   		1 : Set the DSB trigger type to true
> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_mode
> +Date:		March 2023
> +KernelVersion	6.5
> +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:
> +		(Write) Set the mode of DSB tpdm. Read the mode of DSB
> +		tpdm.

(RW) ...

> +
> +		Accepts the value needs to be greater than 0. What data
> +		bits do is listed below.
> +		Bit[0:1] : Test mode control bit for choosing the inputs.
> +		Bit[3] : Set to 0 for low performance mode.
> +				 Set to 1 for high performance mode.
> +		Bit[4:8] : Select byte lane for high performance mode.
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> index 62efc18..c38760b 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
> @@ -4,6 +4,7 @@
>    */
>   
>   #include <linux/amba/bus.h>
> +#include <linux/bitfield.h>
>   #include <linux/bitmap.h>
>   #include <linux/coresight.h>
>   #include <linux/coresight-pmu.h>
> @@ -42,6 +43,32 @@ static void tpdm_reset_datasets(struct tpdm_drvdata *drvdata)
>   	}
>   }
>   
> +static void set_dsb_test_mode(struct tpdm_drvdata *drvdata, u32 *val)
> +{
> +	u32 mode;
> +
> +	mode = TPDM_DSB_MODE_TEST(drvdata->dsb->mode);
> +	*val &= ~TPDM_DSB_TEST_MODE;
> +	*val |= FIELD_PREP(TPDM_DSB_TEST_MODE, mode);
> +}
> +
> +static void set_dsb_hpsel_mode(struct tpdm_drvdata *drvdata, u32 *val)
> +{
> +	u32 mode;
> +
> +	mode = TPDM_DSB_MODE_HPBYTESEL(drvdata->dsb->mode);
> +	*val &= ~TPDM_DSB_HPSEL;
> +	*val |= FIELD_PREP(TPDM_DSB_HPSEL, mode);
> +}
> +
> +static void set_dsb_perf_mode(struct tpdm_drvdata *drvdata, u32 *val)
> +{
> +	if (drvdata->dsb->mode & TPDM_DSB_MODE_PERF)
> +		*val |= TPDM_DSB_CR_MODE;
> +	else
> +		*val &= ~TPDM_DSB_CR_MODE;
> +}
> +
>   static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
>   {
>   	u32 val;
> @@ -55,6 +82,12 @@ static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
>   	writel_relaxed(val, drvdata->base + TPDM_DSB_TIER);
>   
>   	val = readl_relaxed(drvdata->base + TPDM_DSB_CR);

> +	/* Set the test accurate mode */
> +	set_dsb_test_mode(drvdata, &val);
> +	/* Set the byte lane for high-performance mode */
> +	set_dsb_hpsel_mode(drvdata, &val);
> +	/* Set the performance mode */
> +	set_dsb_perf_mode(drvdata, &val);

Couldn't all of them be combined to a single function, as they
operate on a single value to be written ?

	set_dsb_mode(drvdata, &val);


>   	/* Set trigger type */
>   	if (drvdata->dsb->trig_type)
>   		val |= TPDM_DSB_CR_TRIG_TYPE;
> @@ -241,6 +274,34 @@ static struct attribute_group tpdm_attr_grp = {
>   	.attrs = tpdm_attrs,
>   };
>   
> +static ssize_t dsb_mode_show(struct device *dev,
> +				  struct device_attribute *attr,
> +				  char *buf)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +
> +	return sysfs_emit(buf, "%lx\n",
> +			 (unsigned long)drvdata->dsb->mode);

It is u32 anyways, hence why not :

		(buf, "%x\n", drvdata->dsb->mode) ?


> +}
> +
> +static ssize_t dsb_mode_store(struct device *dev,
> +				   struct device_attribute *attr,
> +				   const char *buf,
> +				   size_t size)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned long val;
> +
> +	if ((kstrtoul(buf, 0, &val)) || val < 0)
> +		return -EINVAL;
> +

Is it not an error :
	 if (val & ~TPDM_DSB_MODE_MASK) ?

> +	spin_lock(&drvdata->spinlock);
> +	drvdata->dsb->mode = val & TPDM_DSB_MODE_MASK;
> +	spin_unlock(&drvdata->spinlock);
> +	return size;
> +}
> +static DEVICE_ATTR_RW(dsb_mode);
> +
>   static ssize_t dsb_trig_type_show(struct device *dev,
>   				     struct device_attribute *attr, char *buf)
>   {
> @@ -312,6 +373,7 @@ static ssize_t dsb_trig_ts_store(struct device *dev,
>   static DEVICE_ATTR_RW(dsb_trig_ts);
>   
>   static struct attribute *tpdm_dsb_attrs[] = {
> +	&dev_attr_dsb_mode.attr,
>   	&dev_attr_dsb_trig_ts.attr,
>   	&dev_attr_dsb_trig_type.attr,
>   	NULL,
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
> index 92c34cd..49fffb1 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.h
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.h
> @@ -15,11 +15,25 @@
>   
>   /* Enable bit for DSB subunit */
>   #define TPDM_DSB_CR_ENA		BIT(0)
> +/* Enable bit for DSB subunit perfmance mode */
> +#define TPDM_DSB_CR_MODE		BIT(1)
>   /* Enable bit for DSB subunit trigger type */
>   #define TPDM_DSB_CR_TRIG_TYPE		BIT(12)
> +
>   /* Enable bit for DSB subunit trigger timestamp */
>   #define TPDM_DSB_TIER_XTRIG_TSENAB		BIT(1)
>   
> +/* DSB programming modes */
> +/* Test mode control bit*/
> +#define TPDM_DSB_MODE_TEST(val)	(val & GENMASK(1, 0))

What is the difference between MODE_TEST ^ and the TEST_MODE ( below ).
Please could we have clear naming conventions ?

> +/* Performance mode */
> +#define TPDM_DSB_MODE_PERF		BIT(3)

> +/* High performance mode */
> +#define TPDM_DSB_MODE_HPBYTESEL(val)	(val & GENMASK(8, 4))
> +#define TPDM_DSB_MODE_MASK			GENMASK(8, 0)


> +#define TPDM_DSB_TEST_MODE		GENMASK(10, 9)
> +#define TPDM_DSB_HPSEL		GENMASK(6, 2)

Ah, I read it again and these two are really TPDM_DSB_CR_x and
1) Must be defined as such (to avoid any confusion as above)
2) And defined closer to the other value defintions for the registers ?


Suzuki

> +
>   /* TPDM integration test registers */
>   #define TPDM_ITATBCNTRL		(0xEF0)
>   #define TPDM_ITCNTRL		(0xF00)
> @@ -48,10 +62,12 @@
>   
>   /**
>    * struct dsb_dataset - specifics associated to dsb dataset
> + * @mode:             DSB programming mode
>    * @trig_ts:          Enable/Disable trigger timestamp.
>    * @trig_type:        Enable/Disable trigger type.
>    */
>   struct dsb_dataset {
> +	u32				mode;
>   	bool			trig_ts;
>   	bool			trig_type;
>   };

