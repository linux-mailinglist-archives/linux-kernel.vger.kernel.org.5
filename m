Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A96B77534E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 08:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjHIG4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 02:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjHIG4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 02:56:21 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FFC133;
        Tue,  8 Aug 2023 23:56:20 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3795EQaa002770;
        Wed, 9 Aug 2023 06:56:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=l6Q3kAo4PoDen4OMsfQREJFgN9uoVTu7wtELKaISERI=;
 b=ma4UaLE4UeHHDGx3BEfRl3CNaPViN2Jin2VxF9kfYwleQDdiGFgtMHsPU/719W9AeoKk
 tk9PM5c6XkQiQOMQOmprGbDD/ZaXUzeUiPLvdi6StQq6XRLlDc7+/424Wq71Dlg1Cu+C
 Q6+6CktQdD6s4loiQ2RME2Ensotkgg5AF4848JXGt9flZjecqAtAdlyCVgz3TyTZrhVL
 h5LzBPVs8hV+Z0Yf+UFjhUtyZpcFYABjWRjp/VEhn8eNFqYbnahoJByWBDDxsjm+i7E5
 oHO1KUQ5v8FoADe1FvAtRgMfMMb+/hVJCnjMhduT8PgRpGsVxENBULB4ALilXLISjSHx Tg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sbp17hymr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 06:56:06 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3796u4XW028326
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 9 Aug 2023 06:56:04 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 8 Aug
 2023 23:56:00 -0700
Message-ID: <fb6b0f72-3138-d40a-221b-57012cb133be@quicinc.com>
Date:   Wed, 9 Aug 2023 14:55:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v7 07/13] coresight-tpdm: Add nodes to set trigger
 timestamp and type
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <andersson@kernel.org>
References: <1690269353-10829-1-git-send-email-quic_taozha@quicinc.com>
 <1690269353-10829-8-git-send-email-quic_taozha@quicinc.com>
 <73a5313d-9ab2-f5f9-42af-c3d9939198c6@arm.com>
From:   Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <73a5313d-9ab2-f5f9-42af-c3d9939198c6@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: py_pP_6sFWYkdz2RWOvHH3Via35XFN3C
X-Proofpoint-GUID: py_pP_6sFWYkdz2RWOvHH3Via35XFN3C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_04,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308090061
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/7/2023 5:42 PM, Suzuki K Poulose wrote:
> On 25/07/2023 08:15, Tao Zhang wrote:
>> The nodes are needed to set or show the trigger timestamp and
>> trigger type. This change is to add these nodes to achieve these
>> function.
>>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> ---
>>   .../ABI/testing/sysfs-bus-coresight-devices-tpdm   | 24 ++++++
>>   drivers/hwtracing/coresight/coresight-tpdm.c       | 94 
>> ++++++++++++++++++++++
>>   2 files changed, 118 insertions(+)
>>
>> diff --git 
>> a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm 
>> b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>> index dbc2fbd0..0b7b4ad 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>> @@ -21,3 +21,27 @@ Description:
>>             Accepts only one value -  1.
>>           1 : Reset the dataset of the tpdm
>> +
>> +What: /sys/bus/coresight/devices/<tpdm-name>/dsb_trig_type
>> +Date:        March 2023
>> +KernelVersion    6.5
>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang 
>> (QUIC) <quic_taozha@quicinc.com>
>> +Description:
>> +        (Write) Set the trigger type of DSB tpdm. Read the trigger
>> +        type of DSB tpdm.
>
> Please use: (RW) instead of (Write).
>
>         (RW) Set/Get the trigger type of the DSB for TPDM.
> Similarly for the items below.
I will update this in the next patch series.
>
>> +
>> +        Accepts only one of the 2 values -  0 or 1.
>> +        0 : Set the DSB trigger type to false
>> +        1 : Set the DSB trigger type to true
>> +
>> +What: /sys/bus/coresight/devices/<tpdm-name>/dsb_trig_ts
>> +Date:        March 2023
>> +KernelVersion    6.5
>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang 
>> (QUIC) <quic_taozha@quicinc.com>
>> +Description:
>> +        (Write) Set the trigger timestamp of DSB tpdm. Read the
>> +        trigger timestamp of DSB tpdm.
>> +
>> +        Accepts only one of the 2 values -  0 or 1.
>> +        0 : Set the DSB trigger type to false
>> +        1 : Set the DSB trigger type to true
>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c 
>> b/drivers/hwtracing/coresight/coresight-tpdm.c
>> index acc3eea..62efc18 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
>> @@ -20,6 +20,18 @@
>>     DEFINE_CORESIGHT_DEVLIST(tpdm_devs, "tpdm");
>>   +static umode_t tpdm_dsb_is_visible(struct kobject *kobj,
>> +                       struct attribute *attr, int n)
>
> Please keep the alignment.
I will update this in the next patch series.
>
>> +{
>> +    struct device *dev = kobj_to_dev(kobj);
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +
>> +    if (drvdata && (drvdata->datasets & TPDM_PIDR0_DS_DSB))
>
> As suggested earlier, add a wrapper for the above check.
I will update this in the next patch series.
>
>> +        return attr->mode;
>> +
>> +    return 0;
>> +}
>> +
>>   static void tpdm_reset_datasets(struct tpdm_drvdata *drvdata)
>>   {
>>       if (drvdata->datasets & TPDM_PIDR0_DS_DSB) {
>> @@ -229,8 +241,90 @@ static struct attribute_group tpdm_attr_grp = {
>>       .attrs = tpdm_attrs,
>>   };
>>   +static ssize_t dsb_trig_type_show(struct device *dev,
>> +                     struct device_attribute *attr, char *buf)
>
> Please follow the above alignment for all functions throughout the 
> series. There are unaligned parameter lists scattered around the series.

I will update this in the next patch series.


Best,

Tao

>
>> +{
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +
>> +    return sysfs_emit(buf, "%u\n",
>> +             (unsigned int)drvdata->dsb->trig_type);
>> +}
>> +
>> +/*
>> + * Trigger type (boolean):
>> + * false - Disable trigger type.
>> + * true  - Enable trigger type.
>> + */
>> +static ssize_t dsb_trig_type_store(struct device *dev,
>> +                      struct device_attribute *attr,
>> +                      const char *buf,
>> +                      size_t size)
>> +{
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +    unsigned long val;
>> +
>> +    if ((kstrtoul(buf, 0, &val)) || (val & ~1UL))
>> +        return -EINVAL;
>> +
>> +    spin_lock(&drvdata->spinlock);
>> +    if (val)
>> +        drvdata->dsb->trig_type = true;
>> +    else
>> +        drvdata->dsb->trig_type = false;
>> +    spin_unlock(&drvdata->spinlock);
>> +    return size;
>> +}
>> +static DEVICE_ATTR_RW(dsb_trig_type);
>> +
>> +static ssize_t dsb_trig_ts_show(struct device *dev,
>> +                     struct device_attribute *attr, char *buf)
>> +{
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +
>> +    return sysfs_emit(buf, "%u\n",
>> +             (unsigned int)drvdata->dsb->trig_ts);
>> +}
>> +
>> +/*
>> + * Trigger timestamp (boolean):
>> + * false - Disable trigger timestamp.
>> + * true  - Enable trigger timestamp.
>> + */
>> +static ssize_t dsb_trig_ts_store(struct device *dev,
>> +                      struct device_attribute *attr,
>> +                      const char *buf,
>> +                      size_t size)
>> +{
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +    unsigned long val;
>> +
>> +    if ((kstrtoul(buf, 0, &val)) || (val & ~1UL))
>> +        return -EINVAL;
>> +
>> +    spin_lock(&drvdata->spinlock);
>> +    if (val)
>> +        drvdata->dsb->trig_ts = true;
>> +    else
>> +        drvdata->dsb->trig_ts = false;
>> +    spin_unlock(&drvdata->spinlock);
>> +    return size;
>> +}
>> +static DEVICE_ATTR_RW(dsb_trig_ts);
>> +
>> +static struct attribute *tpdm_dsb_attrs[] = {
>> +    &dev_attr_dsb_trig_ts.attr,
>> +    &dev_attr_dsb_trig_type.attr,
>> +    NULL,
>> +};
>> +
>> +static struct attribute_group tpdm_dsb_attr_grp = {
>> +    .attrs = tpdm_dsb_attrs,
>> +    .is_visible = tpdm_dsb_is_visible,
>> +};
>> +
>>   static const struct attribute_group *tpdm_attr_grps[] = {
>>       &tpdm_attr_grp,
>> +    &tpdm_dsb_attr_grp,
>>       NULL,
>>   };
>
> Rest looks fine.
>
> Suzuk
>
