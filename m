Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F75792950
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350368AbjIEQ0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354092AbjIEJgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 05:36:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2FBA41A7;
        Tue,  5 Sep 2023 02:36:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF77D11FB;
        Tue,  5 Sep 2023 02:36:48 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 36D7F3F793;
        Tue,  5 Sep 2023 02:36:08 -0700 (PDT)
Message-ID: <4370a34d-e36f-421c-aa02-48dd96c0af77@arm.com>
Date:   Tue, 5 Sep 2023 10:36:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 09/13] coresight-tpdm: Add nodes for dsb edge control
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
 <1692681973-20764-10-git-send-email-quic_taozha@quicinc.com>
 <167f1869-9b73-f56a-f6aa-7587e23fc582@arm.com>
 <27042351-ba5d-7048-adc1-f58955c6d116@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <27042351-ba5d-7048-adc1-f58955c6d116@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/2023 17:01, Tao Zhang wrote:
> 
> On 9/1/2023 10:07 PM, Suzuki K Poulose wrote:
>> On 22/08/2023 06:26, Tao Zhang wrote:
>>> Add the nodes to set value for DSB edge control and DSB edge
>>> control mask. Each DSB subunit TPDM has maximum of n(n<16) EDCR
>>> resgisters to configure edge control. DSB edge detection control
>>> 00: Rising edge detection
>>> 01: Falling edge detection
>>> 10: Rising and falling edge detection (toggle detection)
>>> And each DSB subunit TPDM has maximum of m(m<8) ECDMR registers to
>>> configure mask. Eight 32 bit registers providing DSB interface
>>> edge detection mask control.
>>>
>>> Add the nodes to configure DSB edge control and DSB edge control
>>> mask. Each DSB subunit TPDM maximum of 256 edge detections can be
>>> configured. The index and value sysfs files need to be paired and
>>> written to order. The index sysfs file is to set the index number
>>> of the edge detection which needs to be configured. And the value
>>> sysfs file is to set the control or mask for the edge detection.
>>> DSB edge detection control should be set as the following values.
>>> 00: Rising edge detection
>>> 01: Falling edge detection
>>> 10: Rising and falling edge detection (toggle detection)
>>> And DSB edge mask should be set as 0 or 1.
>>> Each DSB subunit TPDM has maximum of n(n<16) EDCR resgisters to
>>> configure edge control. And each DSB subunit TPDM has maximum of
>>> m(m<8) ECDMR registers to configure mask.
>>>
>>> Add the nodes to read a set of the edge control value and mask
>>> of the DSB in TPDM.
>>>
>>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>>> ---
>>>   .../ABI/testing/sysfs-bus-coresight-devices-tpdm   |  51 ++++++
>>>   drivers/hwtracing/coresight/coresight-tpdm.c       | 177 
>>> ++++++++++++++++++++-
>>>   drivers/hwtracing/coresight/coresight-tpdm.h       |  63 ++++++++
>>>   3 files changed, 288 insertions(+), 3 deletions(-)
>>>
>>> diff --git 
>>> a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm 
>>> b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>>> index e17d1b4..097fdc4 100644
>>> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>>> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>>> @@ -57,3 +57,54 @@ Description:
>>>           Bit[3] : Set to 0 for low performance mode.
>>>                    Set to 1 for high performance mode.
>>>           Bit[4:8] : Select byte lane for high performance mode.
>>> +
>>> +What: /sys/bus/coresight/devices/<tpdm-name>/dsb_edge/ctrl_idx
>>> +Date:        March 2023
>>> +KernelVersion    6.5
>>
>> s/6.5/6.7
> Sure, I will update this in the next patch series.
>>
>>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang 
>>> (QUIC) <quic_taozha@quicinc.com>
>>> +Description:
>>> +        (RW) Set/Get the index number of the edge detection for the DSB
>>> +        subunit TPDM. Since there are at most 256 edge detections, this
>>> +        value ranges from 0 to 255.
>>> +
>>> +What: /sys/bus/coresight/devices/<tpdm-name>/dsb_edge/ctrl_val
>>> +Date:        March 2023
>>> +KernelVersion    6.5
>>
>> same as above
>>
>>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang 
>>> (QUIC) <quic_taozha@quicinc.com>
>>> +Description:
>>> +        Write a data to control the edge detection corresponding to
>>> +        the index number. Before writing data to this sysfs file,
>>> +        "ctrl_idx" should be written first to configure the index
>>> +        number of the edge detection which needs to be controlled.
>>> +
>>> +        Accepts only one of the following values.
>>> +        0 - Rising edge detection
>>> +        1 - Falling edge detection
>>> +        2 - Rising and falling edge detection (toggle detection)
>>> +
>>> +
>>> +What: /sys/bus/coresight/devices/<tpdm-name>/dsb_edge/ctrl_mask
>>> +Date:        March 2023
>>> +KernelVersion    6.5
>>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang 
>>> (QUIC) <quic_taozha@quicinc.com>
>>> +Description:
>>> +        Write a data to mask the edge detection corresponding to the 
>>> index
>>> +        number. Before writing data to this sysfs file, "ctrl_idx" 
>>> should
>>> +        be written first to configure the index number of the edge 
>>> detection
>>> +        which needs to be masked.
>>> +
>>> +        Accepts only one of the 2 values -  0 or 1.
>>> +
>>> +What: /sys/bus/coresight/devices/<tpdm-name>/dsb_edge/edcr[0:15]
>>> +Date:        March 2023
>>> +KernelVersion    6.5
>>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang 
>>> (QUIC) <quic_taozha@quicinc.com>
>>> +Description:
>>> +        Read a set of the edge control value of the DSB in TPDM.
>>
>> Read edge control register n for edcr<n>.
> 
> In fact, we don't read the register directly through this sysfs file, 
> but read the value
> 
> we set to be written to the registers. Do I still need to modify it here?

thats fine.

> 
>>
>>> +
>>> +What: /sys/bus/coresight/devices/<tpdm-name>/dsb_edge/edcmr[0:7]
>>> +Date:        March 2023
>>> +KernelVersion    6.5
>>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang 
>>> (QUIC) <quic_taozha@quicinc.com>
>>> +Description:
>>> +        Read a set of the edge control mask of the DSB in TPDM.
>>> \ No newline at end of file
>>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c 
>>> b/drivers/hwtracing/coresight/coresight-tpdm.c
>>> index 2424eb7..ba61e6a 100644
>>> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
>>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
>>> @@ -21,6 +21,29 @@
>>>     DEFINE_CORESIGHT_DEVLIST(tpdm_devs, "tpdm");
>>>   +/* Read dataset array member with the index number */
>>> +static ssize_t tpdm_simple_dataset_show(struct device *dev,
>>> +               struct device_attribute *attr, char *buf)
>>> +{
>>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>>> +    struct tpdm_dataset_attribute *tpdm_attr =
>>> +        container_of(attr, struct tpdm_dataset_attribute, attr);
>>> +
>>> +    if (tpdm_attr->idx >= tpdm_attr->max)
>>
>> minor nit: See my comment on max below. We could skip max.
> I will update this in the next patch series.
>>
>>> +        return -EINVAL;
>>> +
>>> +    switch (tpdm_attr->mem) {
>>> +    case DSB_EDGE_CTRL:
>>         if (tmp_attr->idx > TPDM_DSB_MAX_EDCR)
>>             break;
>>
>>> +        return sysfs_emit(buf, "0x%x\n",
>>> + drvdata->dsb->edge_ctrl[tpdm_attr->idx]);
>>> +    case DSB_EDGE_CTRL_MASK:
>>         if (tmp_attr->idx > TPDM_DSB_MAX_EDCMR)
>>             break;
>>
>>> +        return sysfs_emit(buf, "0x%x\n",
>>> + drvdata->dsb->edge_ctrl_mask[tpdm_attr->idx]);
>>     }
>>
>>     return -EINVAL;
> Why do we need to return this error code here?
>>


The whole block would look like :

	switch (tpdm->attr->mem) {
	case DSB_EDGE_CTRL:
		if (tmp_attr->idx > TPDM_DSB_MAX_EDCR)
			break;
		return sysfs_...
	case DSB_EDGE_CTRL_MASK:
		if (tmp_attr->idx > TPDM_DSB_MAX_EDCMR)
			break;
		return sysfs_...
	}

	return -EINVAL;

Suzuki

