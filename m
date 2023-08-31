Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6F678F41D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 22:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347362AbjHaUeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 16:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347416AbjHaUeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 16:34:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 230ADE5D;
        Thu, 31 Aug 2023 13:34:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5284C15;
        Thu, 31 Aug 2023 13:34:49 -0700 (PDT)
Received: from [10.57.91.85] (unknown [10.57.91.85])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE9663F740;
        Thu, 31 Aug 2023 13:34:07 -0700 (PDT)
Message-ID: <46a48c06-0d6c-d943-5f20-bd0002c76342@arm.com>
Date:   Thu, 31 Aug 2023 21:34:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v8 06/13] coresight-tpdm: Add reset node to TPDM node
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
 <1692681973-20764-7-git-send-email-quic_taozha@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1692681973-20764-7-git-send-email-quic_taozha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/2023 06:26, Tao Zhang wrote:
> TPDM device need a node to reset the configurations and status of
> it. This change provides a node to reset the configurations and
> disable the TPDM if it has been enabled.
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> ---
>   .../ABI/testing/sysfs-bus-coresight-devices-tpdm   | 10 ++++++++++
>   drivers/hwtracing/coresight/coresight-tpdm.c       | 22 ++++++++++++++++++++++
>   2 files changed, 32 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> index 4a58e64..2936226 100644
> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> @@ -11,3 +11,13 @@ Description:
>   		Accepts only one of the 2 values -  1 or 2.
>   		1 : Generate 64 bits data
>   		2 : Generate 32 bits data
> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/reset_dataset
> +Date:		March 2023
> +KernelVersion	6.5
> +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:
> +		(Write) Reset the dataset of the tpdm.
> +
> +		Accepts only one value -  1.
> +		1 : Reset the dataset of the tpdm
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> index 951ad4d..d6e7c8c 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
> @@ -162,6 +162,27 @@ static int tpdm_datasets_setup(struct tpdm_drvdata *drvdata)
>   	return 0;
>   }
>   
> +static ssize_t reset_dataset_store(struct device *dev,
> +					  struct device_attribute *attr,
> +					  const char *buf,
> +					  size_t size)
> +{
> +	int ret = 0;
> +	unsigned long val;
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +
> +	ret = kstrtoul(buf, 0, &val);
> +	if (ret || val != 1)
> +		return -EINVAL;
> +
> +	spin_lock(&drvdata->spinlock);
> +	tpdm_reset_datasets(drvdata);
> +	spin_unlock(&drvdata->spinlock);
> +
> +	return size;
> +}
> +static DEVICE_ATTR_WO(reset_dataset);
> +
>   /*
>    * value 1: 64 bits test data
>    * value 2: 32 bits test data
> @@ -202,6 +223,7 @@ static ssize_t integration_test_store(struct device *dev,
>   static DEVICE_ATTR_WO(integration_test);
>   
>   static struct attribute *tpdm_attrs[] = {
> +	&dev_attr_reset_dataset.attr,

Should this be only visible when DSB data set is present ?

Suzuki

>   	&dev_attr_integration_test.attr,
>   	NULL,
>   };

