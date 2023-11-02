Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BA17DEA70
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 02:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348155AbjKBBvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 21:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbjKBBvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 21:51:23 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665F6119;
        Wed,  1 Nov 2023 18:51:17 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A200vRg016058;
        Thu, 2 Nov 2023 01:50:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=fq1pqC+FAD+WkaUKkdVk3JNOO4Sx/o/JqSOCx+OkyUA=;
 b=E0VsiOHQvxW/zsH2xiuicpJ7Y3H70XfW88bdAABANmFfH8bbsWrrd+akZxjA6Yv+T3L4
 0F1sOL1x1gbvyHw09QZkR7+kwW+MM1IhOnvKs3PaqDxDtfTSmDRW2iGkteQAPfRJXSZC
 msdaNZTIQWRMSGs0Tyl0jRg0VFuULYqOWjWJphO2l+mkvlB5yBSRTKlpOB2wIGeZgTTN
 sL/hVESVbg7exF9v+HJuzsqvEsFBd6WEhNdAqO1eZlq8CTfoKE/Zjed7igIUB+/qyH6D
 k3PBwVSdy7bQGeon7tXJhntEZtLJ2mUFgPI7HDsAJ5ZQ3jtrfOWBJD8GS19/RRVg3yWC 4Q== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u3xxer9nu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Nov 2023 01:50:46 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A21ojOn006274
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Nov 2023 01:50:45 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 1 Nov
 2023 18:50:40 -0700
Message-ID: <a13c58c9-ce2c-4613-a2fc-a5fd2c46e1df@quicinc.com>
Date:   Thu, 2 Nov 2023 09:50:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] coresight-tpda: Add support to configure CMB
 element
Content-Language: en-US
To:     James Clark <james.clark@arm.com>
CC:     Jinlong Mao <quic_jinlmao@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Song Chai <quic_songchai@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <1698202408-14608-1-git-send-email-quic_taozha@quicinc.com>
 <1698202408-14608-3-git-send-email-quic_taozha@quicinc.com>
 <197007e5-e334-cd7e-0bbd-b84c828f5f7b@arm.com>
 <c1a46885-2dd0-4280-9318-798c873a0c78@quicinc.com>
 <f79adb8e-6545-f43b-c685-bc6b0d755702@arm.com>
From:   Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <f79adb8e-6545-f43b-c685-bc6b0d755702@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _3zJ2fP76a6_MqBurTKWTLwnQilWY93A
X-Proofpoint-ORIG-GUID: _3zJ2fP76a6_MqBurTKWTLwnQilWY93A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_23,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311020013
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/1/2023 7:36 PM, James Clark wrote:
>
>
> On 01/11/2023 08:53, Tao Zhang wrote:
>>
>> On 10/30/2023 7:11 PM, James Clark wrote:
>>>
>>> On 25/10/2023 03:53, Tao Zhang wrote:
>>>> Read the CMB element size from the device tree. Set the register
>>>> bit that controls the CMB element size of the corresponding port.
>>>>
>>>> Signed-off-by: Tao Zhang<quic_taozha@quicinc.com>
>>>> Signed-off-by: Mao Jinlong<quic_jinlmao@quicinc.com>
>>>> ---
>>>>   drivers/hwtracing/coresight/coresight-tpda.c | 108
>>>> ++++++++++++++++-----------
>>>>   drivers/hwtracing/coresight/coresight-tpda.h |   6 ++
>>>>   2 files changed, 69 insertions(+), 45 deletions(-)
>>>>
>>>> diff --git a/drivers/hwtracing/coresight/coresight-tpda.c
>>>> b/drivers/hwtracing/coresight/coresight-tpda.c
>>>> index 5f82737..3101d2a 100644
>>>> --- a/drivers/hwtracing/coresight/coresight-tpda.c
>>>> +++ b/drivers/hwtracing/coresight/coresight-tpda.c
>>>> @@ -28,24 +28,54 @@ static bool coresight_device_is_tpdm(struct
>>>> coresight_device *csdev)
>>>>               CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM);
>>>>   }
>>>>   +static void tpdm_clear_element_size(struct coresight_device *csdev)
>>>> +{
>>>> +    struct tpda_drvdata *drvdata = 
>>>> dev_get_drvdata(csdev->dev.parent);
>>>> +
>>>> +    if (drvdata->dsb_esize)
>>>> +        drvdata->dsb_esize = 0;
>>>> +    if (drvdata->cmb_esize)
>>>> +        drvdata->cmb_esize = 0;
>
> The ifs don't do anything here, it's just the same as always setting 
> to 0.
I will update in the next patch series.
>
>>>> +}
>>>> +
>>>> +static void tpda_set_element_size(struct tpda_drvdata *drvdata, u32
>>>> *val)
>>>> +{
>>>> +
>>>> +    if (drvdata->dsb_esize == 64)
>>>> +        *val |= TPDA_Pn_CR_DSBSIZE;
>>>> +    else if (drvdata->dsb_esize == 32)
>>>> +        *val &= ~TPDA_Pn_CR_DSBSIZE;
>>>> +
>>>> +    if (drvdata->cmb_esize == 64)
>>>> +        *val |= FIELD_PREP(TPDA_Pn_CR_CMBSIZE, 0x2);
>>>> +    else if (drvdata->cmb_esize == 32)
>>>> +        *val |= FIELD_PREP(TPDA_Pn_CR_CMBSIZE, 0x1);
>>>> +    else if (drvdata->cmb_esize == 8)
>>>> +        *val &= ~TPDA_Pn_CR_CMBSIZE;
>>>> +}
>>>> +
>>>>   /*
>>>>    * Read the DSB element size from the TPDM device
>>>>    * Returns
>>>>    *    The dsb element size read from the devicetree if available.
>>> Hi Tao,
>>>
>>> I think the function description and the return value description above
>>> need updating now.
>> I will update this in the next patch series.
>>>
>>>>    *    0 - Otherwise, with a warning once.
>>>>    */
>>>> -static int tpdm_read_dsb_element_size(struct coresight_device *csdev)
>>>> +static int tpdm_read_element_size(struct tpda_drvdata *drvdata,
>>>> +                  struct coresight_device *csdev)
>>>>   {
>>>> -    int rc = 0;
>>>> -    u8 size = 0;
>>>> -
>>>> -    rc = fwnode_property_read_u8(dev_fwnode(csdev->dev.parent),
>>>> -            "qcom,dsb-element-size", &size);
>>>> +    int rc = -EEXIST;
>>>> +
>>>> +    if (!fwnode_property_read_u8(dev_fwnode(csdev->dev.parent),
>>>> +            "qcom,dsb-element-size", &drvdata->dsb_esize))
>>>> +        rc &= 0;
>>> Is &= 0 significant? Why not = 0?
>> I will update this in the next patch series.
>>>
>>>> +    if (!fwnode_property_read_u8(dev_fwnode(csdev->dev.parent),
>>>> +            "qcom,cmb-element-size", &drvdata->cmb_esize))
>>>> +        rc &= 0;
>>>>       if (rc)
>>>>           dev_warn_once(&csdev->dev,
>>>> -            "Failed to read TPDM DSB Element size: %d\n", rc);
>>>> +            "Failed to read TPDM Element size: %d\n", rc);
>>>>   -    return size;
>>>> +    return rc;
>>>>   }
>>>>     /*
>>>> @@ -56,13 +86,17 @@ static int tpdm_read_dsb_element_size(struct
>>>> coresight_device *csdev)
>>>>    * Parameter "inport" is used to pass in the input port number
>>>>    * of TPDA, and it is set to -1 in the recursize call.
>>>>    */
>>>> -static int tpda_get_element_size(struct coresight_device *csdev,
>>>> +static int tpda_get_element_size(struct tpda_drvdata *drvdata,
>>>> +                 struct coresight_device *csdev,
>>>>                    int inport)
>>>>   {
>>>> -    int dsb_size = -ENOENT;
>>>> -    int i, size;
>>>> +    int rc = -ENOENT;
>>>> +    int i;
>>>>       struct coresight_device *in;
>>>>   +    if (inport > 0)
>>>> +        tpdm_clear_element_size(csdev);
>>>> +
>>>>       for (i = 0; i < csdev->pdata->nr_inconns; i++) {
>>>>           in = csdev->pdata->in_conns[i]->src_dev;
>>>>           if (!in)
>>>> @@ -74,25 +108,20 @@ static int tpda_get_element_size(struct
>>>> coresight_device *csdev,
>>>>               continue;
>>>>             if (coresight_device_is_tpdm(in)) {
>>>> -            size = tpdm_read_dsb_element_size(in);
>>>> +            if (rc)
>>>> +                rc = tpdm_read_element_size(drvdata, in);
>>>> +            else
>>>> +                return -EINVAL;
>>> This is quite hard to follow, is checking rc here before calling
>>> tpdm_read_element_size() some kind of way of only calling it once?
>>
>> Yes, there can only be one TPDM on one input port of TPDA. If
>> "tpdm_read_element_size" is called
>>
>> twice, it means that two TPDMs are found on one input port of TPDA.
>>
>>> rc isn't actually a return value at this point, it's just default
>>> initialised to -ENOENT.
>>
>> In this loop, "tpdm_read_element_size" will be called for the first time
>> TPDM found. If rc equals to
>>
>> 0, it means that at lease one TPDM has been found on the input port.
>> Does it make sense?
>>
>>> Then it's not clear why the else condition returns an error?
>> The same as the above.
>>>
>>>>           } else {
>>>>               /* Recurse down the path */
>>>> -            size = tpda_get_element_size(in, -1);
>>>> -        }
>>>> -
>>>> -        if (size < 0)
>>>> -            return size;
>>>> -
>>>> -        if (dsb_size < 0) {
>>>> -            /* Found a size, save it. */
>>>> -            dsb_size = size;
>>>> -        } else {
>>>> -            /* Found duplicate TPDMs */
>>>> -            return -EEXIST;
>>>> +            rc = tpda_get_element_size(drvdata, in, -1);
>>> And then why it's assigned here but not checked for an error in this
>>> case?
>>
>> |Remote ETM|                           |TPDM|
>>
>>             |    branch0                           | branch1
>>
>>                         --------------------------
>>
>>                                     funnel1
>>
>>                         ---------------------------
>>
>>                                           | input port 1
>>
>> -----------------------------
>>
>>                                                        TPDA1
>>
>> -----------------------------
>>
>> The  branches on some TPDA's input ports may not have TPDM. For example,
>> branch 0 doesn't has a
>>
>> TPDM connected, tpda_get_element_size will not return 0 here. This is a
>> normal situation. We need to
>>
>> continue to find TPDM on branch1 through recursion.
>>
>>>
>>> Maybe some comments explaining the flow would help. Or to me it seems
>>> like a second variable to track the thing that's actually intended 
>>> could
>>> be used as well. Like "bool found_element" or something, rather than
>>> re-using rc to also track another thing.
>>
>> Do you prefer to use "static bool found_element" to mark if we already
>> have read an element size in
>>
>> the recursion function?
>>
>
> You could add a static, or you could use whether a set dsb or cmb size
> exists to mark that one was found, which I think is already partially 
> done.
>
> My confusion comes from the fact that instead of just a recursive
> search, the function doesn't stop at the first found one, it continues
> to sanity check that there is only one connected across all ports.
>
> And instead of just checking the error condition at the very end, it
> does it mid recursion, relying on the rc value from a previous
> iteration. IMO the following is a simplification because it always
> returns at the first error found, and checks the final condition outside
> of the recursive function. But you could probably leave it as you have
> but with some comments explaining why:
>
>
> diff --git a/drivers/hwtracing/coresight/coresight-tpda.c 
> b/drivers/hwtracing/coresight/coresight-tpda.c
> index 3101d2a0671d..00b7607d36be 100644
> --- a/drivers/hwtracing/coresight/coresight-tpda.c
> +++ b/drivers/hwtracing/coresight/coresight-tpda.c
> @@ -90,13 +90,10 @@ static int tpda_get_element_size(struct 
> tpda_drvdata *drvdata,
>                                  struct coresight_device *csdev,
>                                  int inport)
>  {
> -       int rc = -ENOENT;
> +       int rc = 0;
>         int i;
>         struct coresight_device *in;
>
> -       if (inport > 0)
> -               tpdm_clear_element_size(csdev);
> -
>         for (i = 0; i < csdev->pdata->nr_inconns; i++) {
>                 in = csdev->pdata->in_conns[i]->src_dev;
>                 if (!in)
> @@ -108,19 +105,23 @@ static int tpda_get_element_size(struct 
> tpda_drvdata *drvdata,
>                         continue;
>
>                 if (coresight_device_is_tpdm(in)) {
> -                       if (rc)
> -                               rc = tpdm_read_element_size(drvdata, in);
> -                       else
> +                       if ((drvdata->dsb_esize) || 
> (drvdata->cmb_esize)) {
> +                               /* Error if already previously found 
> and initialised one */
> + dev_warn_once(&drvdata->csdev->dev,
> +                                       "Detected multiple TPDMs on 
> port %d", -EEXIST);
>                                 return -EINVAL;
> +                       }
> +                       rc = tpdm_read_element_size(drvdata, in);
> +                       if (rc)
> +                               return rc;
>                 } else {
>                         /* Recurse down the path */
>                         rc = tpda_get_element_size(drvdata, in, -1);
> +                       if (rc)
> +                               return rc;
>                 }
>         }
>
> -       if ((drvdata->dsb_esize) || (drvdata->cmb_esize))
> -               rc = 0;
> -
>         return rc;
>  }
>
> @@ -146,15 +147,17 @@ static int tpda_enable_port(struct tpda_drvdata 
> *drvdata, int port)
>          * Set the bit to 0 if the size is 32
>          * Set the bit to 1 if the size is 64
>          */
> +       tpdm_clear_element_size(drvdata->csdev);
>         rc = tpda_get_element_size(drvdata, drvdata->csdev, port);
> -       if (!rc) {
> +       if (!rc && ((drvdata->dsb_esize) || (drvdata->cmb_esize)))
> +       {
>                 tpda_set_element_size(drvdata, &val);
>                 /* Enable the port */
>                 val |= TPDA_Pn_CR_ENA;
>                 writel_relaxed(val, drvdata->base + TPDA_Pn_CR(port));
> -       } else if (rc == -EINVAL) {
> -               dev_warn_once(&drvdata->csdev->dev,
> -                       "Detected multiple TPDMs on port %d", -EEXIST);
> +       } else {
> +               dev_warn_once(&drvdata->csdev->dev, "Didn't find TPDM 
> elem size");
> +               rc = -EINVAL;
>         }
>
>         return rc;

Make sense. I will refine and update the code in the next patch series.


Best,

Tao

>
>
