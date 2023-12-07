Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6393D808630
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjLGK1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 05:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjLGK1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 05:27:11 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E54128;
        Thu,  7 Dec 2023 02:27:17 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B79XKj2011699;
        Thu, 7 Dec 2023 10:26:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=RuICPUQra4CeTJPKT9XkYJ/b9ZFT1AHX1daHHwFg8KY=;
 b=me+C4CHyioh3xO7xx7c9nqXvkzL+5bEER0WA0y7rPCG+yEunUh1LVCeEp1xBYpwRgbz8
 ooeApKYNdo50OET8cjorU2xc+OY1fwBWydHQ0a1ZrYxwO+nPxGgXJl5Y7dKhuB+faejB
 dbtcjmJxjoBLOSlsBNBUUcID1qO8LiqWSbGBgjJZEeLoBbM6e5GgEHTt7awQQOR80/GW
 1KxjbvHfaiVTg9iRCMtHeryEeedVSeuqGFk90n5CwxHXzpnXXjBs+lTbEOnvublRJgnk
 7uMObRwT2HW32Lui89pkuBqWwQPo+l5kByVNcdQklurGjOF3jU9NlkMI7WLCU5bZyfRG Rw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uu928geh0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Dec 2023 10:26:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B7AQton012717
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Dec 2023 10:26:55 GMT
Received: from [10.218.45.181] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 7 Dec
 2023 02:26:48 -0800
Message-ID: <286b6f8a-c634-19ed-cf53-276cfe05d03f@quicinc.com>
Date:   Thu, 7 Dec 2023 15:56:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH V2 1/3] ufs: core: Add CPU latency QoS support for ufs
 driver
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
CC:     Naresh Maramaina <quic_mnaresh@quicinc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Peter Wang <peter.wang@mediatek.com>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, <chu.stanley@gmail.com>,
        "Alim Akhtar" <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_cang@quicinc.com>,
        <quic_nguyenb@quicinc.com>
References: <20231204143101.64163-1-quic_mnaresh@quicinc.com>
 <20231204143101.64163-2-quic_mnaresh@quicinc.com>
 <590ade27-b4da-49be-933b-e9959aa0cd4c@acm.org>
 <692cd503-5b14-4be6-831d-d8e9c282a95e@quicinc.com>
 <5e7c5c75-cb5f-4afe-9d57-b0cab01a6f26@acm.org>
 <b9373252-710c-4a54-95cc-046314796960@quicinc.com>
 <20231206153242.GI12802@thinkpad>
 <effb603e-ca7a-4f24-9783-4d62790165ae@acm.org>
 <20231207094357.GI2932@thinkpad>
Content-Language: en-US
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
In-Reply-To: <20231207094357.GI2932@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xV9ZucUUu1VnH6KXAtu8Z4m5o650ce8x
X-Proofpoint-GUID: xV9ZucUUu1VnH6KXAtu8Z4m5o650ce8x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_08,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 clxscore=1011 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312070084
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/7/2023 3:13 PM, Manivannan Sadhasivam wrote:
> On Wed, Dec 06, 2023 at 03:02:04PM -1000, Bart Van Assche wrote:
>> On 12/6/23 05:32, Manivannan Sadhasivam wrote:
>>> On Wed, Dec 06, 2023 at 07:32:54PM +0530, Naresh Maramaina wrote:
>>>> On 12/5/2023 10:41 PM, Bart Van Assche wrote:
>>>>> On 12/4/23 21:58, Naresh Maramaina wrote:
>>>>>> On 12/5/2023 12:30 AM, Bart Van Assche wrote:
>>>>>>> On 12/4/23 06:30, Maramaina Naresh wrote:
>>>>>>>> +    /* This capability allows the host controller driver to
>>>>>>>> use the PM QoS
>>>>>>>> +     * feature.
>>>>>>>> +     */
>>>>>>>> +    UFSHCD_CAP_PM_QOS                = 1 << 13,
>>>>>>>>     };
>>>>>>>
>>>>>>> Why does it depend on the host driver whether or not PM QoS is
>>>>>>> enabled? Why isn't it enabled unconditionally?
>>>>>>
>>>>>> For some platform vendors power KPI might be more important than
>>>>>> random io KPI. Hence this flag is disabled by default and can be
>>>>>> enabled based on platform requirement.
>>>>>
>>>>> How about leaving this flag out unless if a host vendor asks explicitly
>>>>> for this flag?
>>>>
>>>> IMHO, instead of completely removing this flag, how about having
>>>> flag like "UFSHCD_CAP_DISABLE_PM_QOS" which will make PMQOS enable
>>>> by default and if some host vendor wants to disable it explicitly,
>>>> they can enable that flag.
>>>> Please let me know your opinion.
>>
>> That would result in a flag that is tested but that is never set by
>> upstream code. I'm not sure that's acceptable.
>>
> 
> Agree. The flag shouldn't be introduced if there are no users.
> 
>>> If a vendor wants to disable this feature, then the driver has to be modified.
>>> That won't be very convenient. So either this has to be configured through sysfs
>>> or Kconfig if flexibility matters.
>>
>> Kconfig sounds worse to me because changing any Kconfig flag requires a
>> modification of the Android GKI kernel.
>>
> 
> Hmm, ok. Then I think we can have a sysfs hook to toggle the enable switch.

Hi Bart, Mani

How about keeping this feature enabled by default and having a module 
parameter to disable pmqos feature if required ?

Regards,
Nitin

> 
> - Mani
> 
>> Thanks,
>>
>> Bart.
> 

