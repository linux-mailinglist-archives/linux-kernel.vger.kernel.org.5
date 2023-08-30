Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319EB78E036
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343714AbjH3TZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240013AbjH3GiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 02:38:02 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D48122;
        Tue, 29 Aug 2023 23:37:59 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37U6PnDw010751;
        Wed, 30 Aug 2023 06:37:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=HbcIR+Kn93/NlEajtbl5kBccafalrW1cbrcdrDksgBo=;
 b=MKL54ircd9rPYGhyGmfvok3FeE09VMOz2aaTJHtJZQH92pZTETkaNJXbsDuFT3axmqgN
 XcH3OKotR9RNqmuDa63fZ5M+DIQKSiSk91PRw5yCxVByYbVEd6AGXRuJkvk4x6piyd5O
 9TwkTHhLzbTwvHWI5jwpMIvQ5Kp7iMQIfAFL4odxT3wIQtnrnpGjYwtQGQzNEubBbV7R
 t+deq9JWXiZpndLWvQ9JQB/eZJkBNTqI0aQSTSRfqjureEEu1FDg/r5FgcBOuKYShK1v
 ObHmAb7tnHAZPw68EaGagFP3PuOzjeScWVZ9dHShO33rohCmNs8dFd1rTyccFVXi0dJN hQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ss3fr3skm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 06:37:38 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37U6bbdR009049
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 06:37:38 GMT
Received: from [10.238.139.231] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 29 Aug
 2023 23:37:33 -0700
Message-ID: <fea72c0f-f23d-493c-beae-6bc830b9c2a2@quicinc.com>
Date:   Wed, 30 Aug 2023 14:37:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] usb: typec: qcom: Update the logic of regulator enable
 and disable
To:     Guenter Roeck <linux@roeck-us.net>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Heikki Krogerus" <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_fenglinw@quicinc.com>,
        <subbaram@quicinc.com>
References: <20230830-qcom-tcpc-v4-1-c19b0984879b@quicinc.com>
 <a2353ce6-bd39-f5ca-ad81-63b061147400@roeck-us.net>
From:   hui liu <quic_huliu@quicinc.com>
In-Reply-To: <a2353ce6-bd39-f5ca-ad81-63b061147400@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: q8MuJFT-bztLm8fDrssk0J-eRBY7gJxy
X-Proofpoint-ORIG-GUID: q8MuJFT-bztLm8fDrssk0J-eRBY7gJxy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 adultscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxlogscore=721
 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300060
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/30/2023 2:25 PM, Guenter Roeck wrote:
> On 8/29/23 20:00, Hui Liu via B4 Relay wrote:
>> From: Hui Liu <quic_huliu@quicinc.com>
>>
>> Removed the call logic of disable and enable regulator
>> in reset function. Enable the regulator in qcom_pmic_typec_start
>> function and disable it in qcom_pmic_typec_stop function to
>> avoid unbalanced regulator disable warnings.
>>
>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 
> Please drop.
I didn't get your mean. would you please explain it?
> 
>> Fixes: a4422ff22142 ("usb: typec: qcom: Add Qualcomm PMIC Type-C driver")
>> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> Acked-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> Signed-off-by: Hui Liu <quic_huliu@quicinc.com>
>> ---
>> Changes in v4:
>> - Removed regulator_enable and regulator_diable from
>> pmic_typec_pdphy_reset function. And enable regulator in
> 
> ... because I do not see the above change, and way too much changed
> in the code since I sent a Reviewed-by: to make it appropriate
> to keep it.
> 
> Actually, I don't see a difference between v3 and v4 of your patch.
> 
> Guenter
Yes, The codes are same between V3 and V4, I just update the commit log 
as Bryan said. How about I resend the V4 and update the cover letter 
like "Fixed the commit log"
> 
>> qcom_pmic_typec_pdphy_start function and disable it in
>> qcom_pmic_typec_pdphy_stop function.
>> - Link to v3: 
>> https://lore.kernel.org/r/20230828-qcom-tcpc-v3-1-e95b7afa34d9@quicinc.com
>>
>> Changes in v3:
>> - Take Bryan's proposal to remove enable/disable operation in pdphy
>> enable and pdphy disable function, then enable regulator in pdphy start
>> function and disable it in pdphy stop function.
>> - Link to v2: 
>> https://lore.kernel.org/r/20230824-qcom-tcpc-v2-1-3dd8c3424564@quicinc.com
>>
>> Changes in v2:
>> - Add Fixes tag
>> - Link to v1: 
>> https://lore.kernel.org/r/20230823-qcom-tcpc-v1-1-fa81a09ca056@quicinc.com
>> ---
>>   drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c 
>> b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
>> index bb0b8479d80f..52c81378e36e 100644
>> --- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
>> +++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
>> @@ -381,10 +381,6 @@ static int qcom_pmic_typec_pdphy_enable(struct 
>> pmic_typec_pdphy *pmic_typec_pdph
>>       struct device *dev = pmic_typec_pdphy->dev;
>>       int ret;
>> -    ret = regulator_enable(pmic_typec_pdphy->vdd_pdphy);
>> -    if (ret)
>> -        return ret;
>> -
>>       /* PD 2.0, DR=TYPEC_DEVICE, PR=TYPEC_SINK */
>>       ret = regmap_update_bits(pmic_typec_pdphy->regmap,
>>                    pmic_typec_pdphy->base + USB_PDPHY_MSG_CONFIG_REG,
>> @@ -422,8 +418,6 @@ static int qcom_pmic_typec_pdphy_disable(struct 
>> pmic_typec_pdphy *pmic_typec_pdp
>>       ret = regmap_write(pmic_typec_pdphy->regmap,
>>                  pmic_typec_pdphy->base + USB_PDPHY_EN_CONTROL_REG, 0);
>> -    regulator_disable(pmic_typec_pdphy->vdd_pdphy);
>> -
>>       return ret;
>>   }
>> @@ -447,6 +441,10 @@ int qcom_pmic_typec_pdphy_start(struct 
>> pmic_typec_pdphy *pmic_typec_pdphy,
>>       int i;
>>       int ret;
>> +    ret = regulator_enable(pmic_typec_pdphy->vdd_pdphy);
>> +    if (ret)
>> +        return ret;
>> +
>>       pmic_typec_pdphy->tcpm_port = tcpm_port;
>>       ret = pmic_typec_pdphy_reset(pmic_typec_pdphy);
>> @@ -467,6 +465,8 @@ void qcom_pmic_typec_pdphy_stop(struct 
>> pmic_typec_pdphy *pmic_typec_pdphy)
>>           disable_irq(pmic_typec_pdphy->irq_data[i].irq);
>>       qcom_pmic_typec_pdphy_reset_on(pmic_typec_pdphy);
>> +
>> +    regulator_disable(pmic_typec_pdphy->vdd_pdphy);
>>   }
>>   struct pmic_typec_pdphy *qcom_pmic_typec_pdphy_alloc(struct device 
>> *dev)
>>
>> ---
>> base-commit: bbb9e06d2c6435af9c62074ad7048910eeb2e7bc
>> change-id: 20230822-qcom-tcpc-d41954ac65fa
>>
>> Best regards,
> 
