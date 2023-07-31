Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F35768AFE
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 07:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjGaFO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 01:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjGaFO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 01:14:57 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1421B1A5;
        Sun, 30 Jul 2023 22:14:55 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36V3ilEd003349;
        Mon, 31 Jul 2023 05:14:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=yZwONjKHySnDZRuapdHrCNlECA9A+ypflVHU3EdKGfM=;
 b=HOeyL1Z+DENmiQ0yjNW6kuIg2JsIb+iIhg0HrxqBP54f4zrV12psj3Bshxx4CcICj/0w
 gGLtl7shc2zcjjzdAbJbOGikawy1VD9bb719UZb2w501pKWBuqCrlTr9fAYOnQfBQnm9
 AhSZQU+OLxAk+4orBayBJ23VDZdnvTAHPuXY5AREbMoLbz6n/vR5naloTztIlzX3WCXb
 te9IZWFOfBvvZVrVj5gAtky6uYUmDcCvXORtdfRq7MKn200Ow6i6sZRk4A5MLB1Aq9IT
 wZvMUgnBnlGX0QL6sS3glb4jXIBRC7bPsR4t2C38jePFZP8wTfnOXBJquDC0JgeqEiXw dA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s4v2djmh8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 05:14:52 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36V5EpSW020030
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 05:14:51 GMT
Received: from [10.201.206.238] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Sun, 30 Jul
 2023 22:14:44 -0700
Message-ID: <4d278763-153c-bb9c-56d4-4b262ed2cc99@quicinc.com>
Date:   Mon, 31 Jul 2023 10:44:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v4 07/11] firmware: qcom_scm: ipq5332: add msa lock/unlock
 support
Content-Language: en-US
To:     Guru Das Srinagesh <quic_gurus@quicinc.com>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <quic_eberman@quicinc.com>, <kvalo@kernel.org>,
        <loic.poulain@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_varada@quicinc.com>
References: <20230728063412.1641856-1-quic_mmanikan@quicinc.com>
 <20230728063412.1641856-8-quic_mmanikan@quicinc.com>
 <20230729003037.GA25463@quicinc.com>
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <20230729003037.GA25463@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4X2b7Cp-hv2RsNuR-_Oq4m9KWeOVgaIu
X-Proofpoint-ORIG-GUID: 4X2b7Cp-hv2RsNuR-_Oq4m9KWeOVgaIu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 clxscore=1015
 adultscore=0 impostorscore=0 bulkscore=0 mlxscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307310048
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/29/2023 6:00 AM, Guru Das Srinagesh wrote:
> On Jul 28 2023 12:04, Manikanta Mylavarapu wrote:
>> IPQ5332 user pd remoteproc firmwares need to be locked
>> with MSA(modem secure access) features. This patch add
>> support to lock/unlock MSA features.
>>
>> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
>> ---
>> Changes in v4:
>> 	- Rebased on linux-next
>>
>>   drivers/firmware/qcom_scm.c            | 78 ++++++++++++++++++++++++++
>>   drivers/firmware/qcom_scm.h            |  2 +
>>   include/linux/firmware/qcom/qcom_scm.h |  2 +
>>   3 files changed, 82 insertions(+)
>>
>> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
>> index 3bc8c63a997f..2275cf7bc887 100644
>> --- a/drivers/firmware/qcom_scm.c
>> +++ b/drivers/firmware/qcom_scm.c
>> @@ -676,6 +676,84 @@ bool qcom_scm_pas_supported(u32 peripheral)
>>   }
>>   EXPORT_SYMBOL(qcom_scm_pas_supported);
>>   
>> +/**
>> + * qcom_scm_msa_lock() - Lock given peripheral firmware region as MSA
>> + *
>> + * @peripheral:	peripheral id
>> + *
>> + * Return 0 on success.
>> + */
>> +int qcom_scm_msa_lock(u32 peripheral)
>> +{
>> +	int ret;
>> +	struct qcom_scm_desc desc = {
>> +		.svc = QCOM_SCM_SVC_PIL,
>> +		.cmd = QCOM_SCM_MSA_LOCK,
>> +		.arginfo = QCOM_SCM_ARGS(1),
>> +		.args[0] = peripheral,
>> +		.owner = ARM_SMCCC_OWNER_SIP,
>> +	};
>> +	struct qcom_scm_res res;
>> +
>> +	if (!__qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_PIL,
>> +					  QCOM_SCM_MSA_LOCK))
>> +		return 0;
>> +
>> +	ret = qcom_scm_clk_enable();
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = qcom_scm_bw_enable();
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = qcom_scm_call(__scm->dev, &desc, &res);
>> +	qcom_scm_bw_disable();
>> +	qcom_scm_clk_disable();
>> +
>> +	return ret ? : res.result[0];
>> +}
>> +EXPORT_SYMBOL(qcom_scm_msa_lock);
> 
> Could you please convert this to EXPORT_SYMBOL_GPL?
> 
Ok, sure.

>> +
>> +/**
>> + * qcom_scm_msa_unlock() - Unlock given peripheral MSA firmware region
>> + *
>> + * @peripheral:	peripheral id
>> + *
>> + * Return 0 on success.
>> + */
>> +int qcom_scm_msa_unlock(u32 peripheral)
>> +{
>> +	int ret;
>> +	struct qcom_scm_desc desc = {
>> +		.svc = QCOM_SCM_SVC_PIL,
>> +		.cmd = QCOM_SCM_MSA_UNLOCK,
>> +		.arginfo = QCOM_SCM_ARGS(1),
>> +		.args[0] = peripheral,
>> +		.owner = ARM_SMCCC_OWNER_SIP,
>> +	};
>> +	struct qcom_scm_res res;
>> +
>> +	if (!__qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_PIL,
>> +					  QCOM_SCM_MSA_UNLOCK))
>> +		return 0;
>> +
>> +	ret = qcom_scm_clk_enable();
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = qcom_scm_bw_enable();
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = qcom_scm_call(__scm->dev, &desc, &res);
>> +	qcom_scm_bw_disable();
>> +	qcom_scm_clk_disable();
>> +
>> +	return ret ? : res.result[0];
>> +}
>> +EXPORT_SYMBOL(qcom_scm_msa_unlock);
> 
> This one too?
> 
Ok, sure.

> Reference: [1]
> The whole driver has now moved to using EXPORT_SYMBOL_GPL() now.
> 
> [1] https://lore.kernel.org/lkml/19d9ac0bf79f957574ef9b3b73246ea0113cc0fd.1690503893.git.quic_gurus@quicinc.com/
> 
> Thank you.
> 
> Guru Das.

Thanks & Regards,
Manikanta.
