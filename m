Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2350D788441
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 12:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242679AbjHYKDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 06:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243345AbjHYKDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 06:03:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E832106;
        Fri, 25 Aug 2023 03:03:39 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37P8SiPE006593;
        Fri, 25 Aug 2023 10:03:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=U/ZcCXDFjz8CJhrGf3q8NmlPiawYAFQSce8Uk7s19m8=;
 b=RJ9Z4uDlKp5ccDjrpHhgtKv6OF9U++EuF/TYBnIgbjMHk8hdxQcZ9zWwA1HQocK1xZYI
 qoflPaltf3eiNGalaa15s9CF3wc7ZVeX4ePJY/mlVWRCa8IOWyFUgp62peePn/li5Gpn
 2VthJ+i8NoOxP3Gf+MbON6IJhXvkW6JqkVDynb2LyzP++AQTGedWDk6T6VztzTp4DdtM
 GnPcBuMvj2CYimel5FDnZU0oIkp6SUvEqZpleT+qO1Vg30zCHuhy0jenz6YXNdlTRnB+
 ZxGzBRZiIo9lrqatrn/trfsiC84DrStglQHC4wbNNcQILE8RhyO/mSNmnIZAM5quYqIX jQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3spmny0mx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 10:03:17 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37PA3GZL032514
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 10:03:16 GMT
Received: from [10.238.139.231] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 25 Aug
 2023 03:03:12 -0700
Message-ID: <0b6b864c-3e41-4b41-ac35-9ab8edb156a0@quicinc.com>
Date:   Fri, 25 Aug 2023 18:03:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: typec: qcom: check regulator enable status before
 disabling it
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_fenglinw@quicinc.com>,
        <subbaram@quicinc.com>
References: <20230824-qcom-tcpc-v2-1-3dd8c3424564@quicinc.com>
 <ZOdlOQ+N2J7jyIEZ@kuha.fi.intel.com> <ZOdt+dz7XXljFJcK@kuha.fi.intel.com>
From:   hui liu <quic_huliu@quicinc.com>
In-Reply-To: <ZOdt+dz7XXljFJcK@kuha.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dRvMyf5UnPF_kG8qqmm5BsV-ZD3FUmoJ
X-Proofpoint-GUID: dRvMyf5UnPF_kG8qqmm5BsV-ZD3FUmoJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_07,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 mlxlogscore=748 impostorscore=0
 bulkscore=0 clxscore=1015 phishscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250086
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

I will let Bryan to comment, I am using the driver to support the pdphy 
in SMB2352 and there is no external regulator required, so I am just 
using a dummy regulator device and I saw this unbalanced regulator 
disabling warnings, so my intention for this change is just fixing the 
warning message. However, I am fine with whatever suggestion you have, 
since the logic is straightforward, and I can make the changes once you 
have the agreement.

Thanks,
Hui

On 8/24/2023 10:49 PM, Heikki Krogerus wrote:
> On Thu, Aug 24, 2023 at 05:12:14PM +0300, Heikki Krogerus wrote:
>> On Thu, Aug 24, 2023 at 10:32:03AM +0800, Hui Liu via B4 Relay wrote:
>>> From: Hui Liu <quic_huliu@quicinc.com>
>>>
>>> Check regulator enable status before disabling it to avoid
>>> unbalanced regulator disable warnings.
>>>
>>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>>> Fixes: a4422ff22142 ("usb: typec: qcom: Add Qualcomm PMIC Type-C driver")
>>> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>>> Signed-off-by: Hui Liu <quic_huliu@quicinc.com>
>>> ---
>>> Changes in v2:
>>> - Add Fixes tag
>>> - Link to v1: https://lore.kernel.org/r/20230823-qcom-tcpc-v1-1-fa81a09ca056@quicinc.com
>>> ---
>>>   drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
>>> index bb0b8479d80f..ca616b17b5b6 100644
>>> --- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
>>> +++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
>>> @@ -422,7 +422,8 @@ static int qcom_pmic_typec_pdphy_disable(struct pmic_typec_pdphy *pmic_typec_pdp
>>>   	ret = regmap_write(pmic_typec_pdphy->regmap,
>>>   			   pmic_typec_pdphy->base + USB_PDPHY_EN_CONTROL_REG, 0);
>>>   
>>> -	regulator_disable(pmic_typec_pdphy->vdd_pdphy);
>>> +	if (regulator_is_enabled(pmic_typec_pdphy->vdd_pdphy))
>>> +		regulator_disable(pmic_typec_pdphy->vdd_pdphy);
>>
>> Would it be an option to just enable the regulator in
>> qcom_pmic_typec_pdphy_start() and disable it in
>> qcom_pmic_typec_pdphy_stop()?
>>
>> Now the whole thing looks weird. That regulator is in practice
>> only disabled and then enabled in one and the same place -
>> pmic_typec_pdphy_reset(). It's not touched anywhere else. That makes
>> the above condition confusing to me. I may be missing something.
>>
>> At least more explanation is needed.
> 
> I took a closer look at these drivers, and I think I understand the
> code path now. This driver is made with an assumption that the
> regulator is "on" when the driver is probed, but in your case it's
> actually "off".
> 
> So there is something wrong here, but I don't know where the root
> cause is. If the regulator is really "on" when this driver is probed,
> then there should be another user for it somewhere (no?). In that case
> the driver can't just switch off the regulator like it does now - this
> part I think really has to be fixed (or explained).
> 
> The problem with your fix is that it will leave the regulator always
> on when the driver is removed, which it really can't do, not at least
> if the regulator was off by default.
> 
> I would propose this:
> 
> diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
> index bb0b8479d80f..bbe40634e821 100644
> --- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
> +++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
> @@ -449,6 +449,10 @@ int qcom_pmic_typec_pdphy_start(struct pmic_typec_pdphy *pmic_typec_pdphy,
>   
>          pmic_typec_pdphy->tcpm_port = tcpm_port;
>   
> +       ret = regulator_enable(pmic_typec_pdphy->vdd_pdphy);
> +       if (ret)
> +               return ret;
> +
>          ret = pmic_typec_pdphy_reset(pmic_typec_pdphy);
>          if (ret)
>                  return ret;
> @@ -467,6 +471,7 @@ void qcom_pmic_typec_pdphy_stop(struct pmic_typec_pdphy *pmic_typec_pdphy)
>                  disable_irq(pmic_typec_pdphy->irq_data[i].irq);
>   
>          qcom_pmic_typec_pdphy_reset_on(pmic_typec_pdphy);
> +       regulator_disable(pmic_typec_pdphy->vdd_pdphy);
>   }
>   
>   struct pmic_typec_pdphy *qcom_pmic_typec_pdphy_alloc(struct device *dev)
> 
> 
> The problem with it is that the regulator is not going to be disabled
> if there really is another user for it when the component is expected
> to be reset. But as said above, if there really is an other user, then
> this driver simply can't just turn off the regulator.
> 
> thanks,
> 
