Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FAC7752A3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 08:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjHIGOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 02:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjHIGOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 02:14:05 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DDEE61;
        Tue,  8 Aug 2023 23:14:02 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3794nLKc001612;
        Wed, 9 Aug 2023 06:13:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=htZctuxXKE0y8Ds3Ks+eU1tAjDk4CgKGP/R4V1+yxO4=;
 b=T0AfwYm18ypbbDcQpL+yOttf3g3Yi5CEA9ZwbFbyBoLY1zELvfBUaOuFc6fuW5tedD5x
 8WIQ5pq8j0fShyQk6yePmWN4kUxS/tn98tjIm/G1pK+6oUqzlXkl5Z01kThKnwn1cPuy
 syque3llcSgZBusgXFn1uNSutAJ49PTLNMS1i7Wk1x5iayMlxyW1++xqD41PD0Etor0y
 I3miNQGDnVr1h0fvyV+2ZtkzuQSyyccapWpWufUOfKv6AaQqkFz0ZKIVH73KtPI76lG9
 BRbT8ZFCagOssUCdyUiWqknIo3lKjNXSktKkLkLffRt31ufKLZWGMo7QcDgIgmXpEuvy 3Q== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sba0qu4rp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 06:13:36 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3796DZoQ003709
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 9 Aug 2023 06:13:35 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 8 Aug
 2023 23:13:31 -0700
Message-ID: <639c64d6-7e43-8d54-92c3-87d12ba0cbd4@quicinc.com>
Date:   Wed, 9 Aug 2023 14:13:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v7 04/13] coresight-tpda: Add DSB dataset support
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
 <1690269353-10829-5-git-send-email-quic_taozha@quicinc.com>
 <94b9ae0f-b6ed-1d72-f86a-d33842527681@arm.com>
Content-Language: en-US
From:   Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <94b9ae0f-b6ed-1d72-f86a-d33842527681@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1y1UuZeizDXLp0Bl5rdYefsFjvBUnv5f
X-Proofpoint-ORIG-GUID: 1y1UuZeizDXLp0Bl5rdYefsFjvBUnv5f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_04,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 mlxscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1011
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308090055
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On 8/4/2023 11:02 PM, Suzuki K Poulose wrote:
> On 25/07/2023 08:15, Tao Zhang wrote:
>> Read the DSB element size from the device tree. Set the register
>> bit that controls the DSB element size of the corresponding port.
>>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-tpda.c | 96 
>> +++++++++++++++++++++++++---
>>   drivers/hwtracing/coresight/coresight-tpda.h |  4 ++
>>   2 files changed, 90 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tpda.c 
>> b/drivers/hwtracing/coresight/coresight-tpda.c
>> index 8d2b9d2..7c71342 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpda.c
>> +++ b/drivers/hwtracing/coresight/coresight-tpda.c
>> @@ -21,6 +21,58 @@
>>     DEFINE_CORESIGHT_DEVLIST(tpda_devs, "tpda");
>>   +/* Search and read element data size from the TPDM node in
>
> minor nit:
>
> /*
>  * Search ...
I will update this in the next patch series.
>
>> + * the devicetree. Each input port of TPDA is connected to
>> + * a TPDM. Different TPDM supports different types of dataset,
>> + * and some may support more than one type of dataset.
>> + * Parameter "inport" is used to pass in the input port number
>> + * of TPDA, and it is set to 0 in the recursize call.
>
>> + * Parameter "parent" is used to pass in the original call.
>
> Please remove references to the past and describe "match_inport"
I will update this in the next patch series.
>
>> + */
>> +static int tpda_set_element_size(struct tpda_drvdata *drvdata,
>> +               struct coresight_device *csdev, int inport, bool 
>> match_inport)
>
> May be we could switch the order of the parameters:
>
> match_inport, int port
>
> Or even inport < 0, implies, port wont be matched.
>
> i.e.,
>
> tpda_set_element_size(drvdata, child, inport)
I will update this in the next patch series.
>
>> +{
>> +    static int nr_inport;
>> +    int i;
>> +    static bool tpdm_found;
>> +    struct coresight_device *in_csdev;
>> +
>> +    if (inport > (TPDA_MAX_INPORTS - 1))
>> +        return -EINVAL;
>> +
>> +    if (match_inport) {
>> +        nr_inport = inport;
>> +        tpdm_found = false;
>> +    }
>
> Could we not avoid the static variables and this dance by making the 
> function return the dsb_size ? See further down.
>
I will update this in the next patch series.
>
>> +
>> +    for (i = 0; i < csdev->pdata->nr_inconns; i++) {
>> +        in_csdev = csdev->pdata->in_conns[i]->src_dev;
>> +        if (!in_csdev)
>> +            break;
>         continue ?
I will update this in the next patch series.
>> +
>> +        if (match_inport)
>> +            if (csdev->pdata->in_conns[i]->dest_port != inport)
>> +                continue;
>> +
>> +        if ((in_csdev->type == CORESIGHT_DEV_TYPE_SOURCE) &&
>> +                (in_csdev->subtype.source_subtype
>> +                == CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM)) {
>
> Please provide a helper :
>
> static bool coresight_device_is_tpdm(csdev) {
>     return
>      (csdev->type == CORESIGHT_DEV_TYPE_SOURCE) &&
>      (in_csdev->subtype.source_subtype ==
>         CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM);
> }
>
I will update this in the next patch series.
>
>
>> + of_property_read_u8(in_csdev->dev.parent->of_node,
>> +                    "qcom,dsb-element-size", 
>> &drvdata->dsb_esize[nr_inport]);
>
>
>
>> +            if (!tpdm_found)
>> +                tpdm_found = true;
>> +            else
>> +                dev_warn(drvdata->dev,
>> +                    "More than one TPDM is mapped to the TPDA input 
>> port %d.\n",
>> +                    nr_inport);
>> +            continue;
>> +        }
>> +        tpda_set_element_size(drvdata, in_csdev, 0, false);
>> +    }
>> +
>
> /*
>  * Read the DSB element size from the TPDM device
>  * Returns
>  *    the size read from the firmware if available.
>  *    0 - Otherwise, with a Warning once.
>  */
> static int tpdm_read_dsb_element_size(struct coresight_device *csdev)
> {
>     int rc, size = 0;
>
>     rc = fwnode_property_read_u8(dev_fwnode(csdev->dev.parent),
>                      "qcom,dsb-element-size", &size);
>     if (rc)
>         dev_warn_once(&in->dev, "Failed to read TPDM DSB Element size: 
> %d\n",
>         rc);
>     return size;
> }
>
> static int tpda_get_element_size(struct coresight_device *csdev,
>                  int inport)
> {
>     int dsb_size = -ENOENT;
>
>     for (i = 0; i < csdev->pdata->nr_inconns; i++) {
>         in = csdev->pdata->in_conns[i]->src_dev;
>         if (!in)
>             continue;
>         if (coresight_device_is_tpdm(in)) {
>             /* Ignore the TPDMs that do not match port */
>             if (inport > 0 &&
>                 (csdev->pdata->in_conns[i]->dest_port !=
>                 inport))
>                 continue;
>             size = tpdm_read_dsb_element_size(csdev);
>         } else {
>             /* Recurse down the path */
>             size = tpda_set_element_size(in, -1);
>         }
>
>         if (size < 0)
>             return size;
>         /* We have found a size, save it. */
>         if (dsb_size < 0) {
>             dsb_size = size;
>         } else {
>             /* We have duplicate TPDMs */
>             return -EEXIST;
>         }
>     }
>     return dsb_size;
> }
>
I will update this in the next patch series.
>
>
>
>> +    return 0;
>> +}
>> +
>>   /* Settings pre enabling port control register */
>>   static void tpda_enable_pre_port(struct tpda_drvdata *drvdata)
>>   {
>> @@ -32,26 +84,43 @@ static void tpda_enable_pre_port(struct 
>> tpda_drvdata *drvdata)
>>       writel_relaxed(val, drvdata->base + TPDA_CR);
>>   }
>>   -static void tpda_enable_port(struct tpda_drvdata *drvdata, int port)
>> +static int tpda_enable_port(struct tpda_drvdata *drvdata, int port)
>>   {
>>       u32 val;
>>         val = readl_relaxed(drvdata->base + TPDA_Pn_CR(port));
>> +    /*
>> +     * Configure aggregator port n DSB data set element size
>> +     * Set the bit to 0 if the size is 32
>> +     * Set the bit to 1 if the size is 64
>> +     */
>> +    if (drvdata->dsb_esize[port] == 32)
>> +        val &= ~TPDA_Pn_CR_DSBSIZE;
>> +    else if (drvdata->dsb_esize[port] == 64)
>> +        val |= TPDA_Pn_CR_DSBSIZE;
>
> Couldn't this be detected via tpda_get_element_size()? see below.
I will update this in the next patch series.
>
>> +    else
>> +        return -EINVAL;
>> +
>>       /* Enable the port */
>>       val |= TPDA_Pn_CR_ENA;
>>       writel_relaxed(val, drvdata->base + TPDA_Pn_CR(port));
>> +
>> +    return 0;
>>   }
>>   -static void __tpda_enable(struct tpda_drvdata *drvdata, int port)
>> +static int __tpda_enable(struct tpda_drvdata *drvdata, int port)
>>   {
>> +    int ret;
>> +
>>       CS_UNLOCK(drvdata->base);
>>         if (!drvdata->csdev->enable)
>>           tpda_enable_pre_port(drvdata);
>>   -    tpda_enable_port(drvdata, port);
>> -
>> +    ret = tpda_enable_port(drvdata, port);
>>       CS_LOCK(drvdata->base);
>> +
>> +    return ret;
>>   }
>>     static int tpda_enable(struct coresight_device *csdev,
>> @@ -59,16 +128,23 @@ static int tpda_enable(struct coresight_device 
>> *csdev,
>>                  struct coresight_connection *out)
>>   {
>>       struct tpda_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>> +    int ret;
>> +
>> +    ret = tpda_set_element_size(drvdata, csdev, in->dest_port, true);
>
>     size  = tpda_get_element_size(csdev, in->dest_port);
>     switch (size) {
>     case 32:
>     case 64:
>         break;
>     case -EEXIST:
>         dev_warn_once("Detected multiple TPDMs on port %d", ..)
>         fallthrough;
>     default:
>         return size;
>     }
>
>     drvdata->dsb_esize[in->dest_port] = size;

I will update this in the next patch series.


Best,

Tao

>
> Suzuki
>
>
>
>> +    if (ret)
>> +        return ret;
>>         spin_lock(&drvdata->spinlock);
>> -    if (atomic_read(&in->dest_refcnt) == 0)
>> -        __tpda_enable(drvdata, in->dest_port);
>> +    if (atomic_read(&in->dest_refcnt) == 0) {
>> +        ret = __tpda_enable(drvdata, in->dest_port);
>> +        if (!ret) {
>> +            atomic_inc(&in->dest_refcnt);
>> +            dev_dbg(drvdata->dev, "TPDA inport %d enabled.\n", 
>> in->dest_port);
>> +        }
>> +    }
>>   -    atomic_inc(&in->dest_refcnt);
>>       spin_unlock(&drvdata->spinlock);
>> -
>> -    dev_dbg(drvdata->dev, "TPDA inport %d enabled.\n", in->dest_port);
>> -    return 0;
>> +    return ret;
>>   }
>>     static void __tpda_disable(struct tpda_drvdata *drvdata, int port)
>> diff --git a/drivers/hwtracing/coresight/coresight-tpda.h 
>> b/drivers/hwtracing/coresight/coresight-tpda.h
>> index 0399678..12a1472 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpda.h
>> +++ b/drivers/hwtracing/coresight/coresight-tpda.h
>> @@ -10,6 +10,8 @@
>>   #define TPDA_Pn_CR(n)        (0x004 + (n * 4))
>>   /* Aggregator port enable bit */
>>   #define TPDA_Pn_CR_ENA        BIT(0)
>> +/* Aggregator port DSB data set element size bit */
>> +#define TPDA_Pn_CR_DSBSIZE        BIT(8)
>>     #define TPDA_MAX_INPORTS    32
>>   @@ -23,6 +25,7 @@
>>    * @csdev:      component vitals needed by the framework.
>>    * @spinlock:   lock for the drvdata value.
>>    * @enable:     enable status of the component.
>> + * @dsb_esize:  DSB element size for each inport, it must be 32 or 64.
>>    */
>>   struct tpda_drvdata {
>>       void __iomem        *base;
>> @@ -30,6 +33,7 @@ struct tpda_drvdata {
>>       struct coresight_device    *csdev;
>>       spinlock_t        spinlock;
>>       u8            atid;
>> +    u8            dsb_esize[TPDA_MAX_INPORTS];
>>   };
>>     #endif  /* _CORESIGHT_CORESIGHT_TPDA_H */
>
