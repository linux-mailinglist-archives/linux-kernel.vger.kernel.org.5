Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C669278566B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 13:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbjHWLHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 07:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbjHWLHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 07:07:51 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B4ACEF;
        Wed, 23 Aug 2023 04:07:49 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37N0KkBU010548;
        Wed, 23 Aug 2023 11:07:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=A548mUEL5+4M2kg4YdNE1YOZq3FYSzr7dLMV7n+uO/Q=;
 b=YweH7+jckWj7w4Vt8Obq2PSDnhQ/uSxFb6xzeZvoWcdIPuk4dgfJN+8R+DsvauBlzOzr
 Rx5V8F3sevnsrk9sGsvzPP3RTpJ7xkovB5R98jejfbaH5kkq6VTvysTqnvYzwGGZBvQr
 iU0HYeJRAxVKjP07axgt8+/tnYo9eEkqnZdeiXcH+5bwBmx+InJW4ShIZDi0R/XFcg0a
 Fm8oqI5jbSRc+xrB2a3lbJVrndnp8CqYJNfGeVnTewhcznZTLak+X5DdmtQd6Nvjmp6L
 0RkNViC8xxfjmblYlDClyPtjnrniODkUooGPXYIKHn0plSDCTmRJVeBdmjMASfjPxYMe pw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sn208hwgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 11:07:28 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37NB7R2C009754
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 11:07:27 GMT
Received: from [10.238.139.231] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 23 Aug
 2023 04:07:15 -0700
Message-ID: <d376686c-b700-407c-9a88-88942ef3e776@quicinc.com>
Date:   Wed, 23 Aug 2023 19:06:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: typec: qcom: check regulator enable status before
 disabling it
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Heikki Krogerus" <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_fenglinw@quicinc.com>,
        <subbaram@quicinc.com>
References: <20230823-qcom-tcpc-v1-1-fa81a09ca056@quicinc.com>
 <64b2a748-ea86-f804-9f8a-881b0dcc7050@linaro.org>
From:   hui liu <quic_huliu@quicinc.com>
In-Reply-To: <64b2a748-ea86-f804-9f8a-881b0dcc7050@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EV0QApwSelhws4LyYaFRlBhIDsfGlMLj
X-Proofpoint-ORIG-GUID: EV0QApwSelhws4LyYaFRlBhIDsfGlMLj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_06,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 bulkscore=0 impostorscore=0 mlxlogscore=503 spamscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308230101
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bryan:

This change is used to fix a real bug.
In qcom tcpc driver probe function, "qcom_pmic_typec_pdphy_start" 
function will be called, thus "qcom_pmic_typec_pdphy_disable" function 
was called. But at that time the regulator was not enabled, so it lead 
to unbalanced between enable and disable of regulator. Then below error 
logs were output:

[  150.485973] unbalanced disables for smb2352_dummy_reg
[  150.486037] ------------[ cut here ]------------
[  150.490020] WARNING: CPU: 1 PID: 2476 at 
/local/mnt3/workspace/qcs405-087/build-qti-distro-fullstack-noselinux-debug/tmp-glibc/work-shared/qcs405-pine/kernel-source/drivers/regulator/core.c:2285 
_regulatdisable+0x15c/0x164
[  150.494751] Modules linked in: qcom_pmic_tcpm(+)
[  150.514577] CPU: 1 PID: 2476 Comm: insmod Tainted: G        W 
4.14.162 #1
[  150.519268] Hardware name: Qualcomm Technologies, Inc. QCS405 Turbox 
C405 DVT IOT WITH PINE (DT)
[  150.526307] task: 000000004869024f task.stack: 00000000db4a9141
[  150.535329] pc : _regulator_disable+0x15c/0x164
[  150.540962] lr : _regulator_disable+0x158/0x164
[  150.545475] sp : ffffff80109d3920 pstate : 60400145
[  150.549988] x29: ffffff80109d3940 x28: ffffff80109d3e18
[  150.554854] x27: ffffffd16adac0e8 x26: 0000000000000001
[  150.560407] x25: 0000000000000001 x24: ffffffd171913680
[  150.565702] x23: 0000000000000000 x22: ffffffd16ad16500
[  150.570997] x21: ffffffd1718f1f10 x20: 00000000fffffffb
[  150.576293] x19: ffffffd1718f1e80 x18: 00000000000000d8
[  150.581588] x17: 00000000000000d8 x16: 0000000000000036
[  150.586883] x15: ffffff91dfb54328 x14: 0000000000003733
[  150.592178] x13: 0000000000000004 x12: 00000000ac3774ff
[  150.597474] x11: 00000000ac3774ff x10: 0000000000000015
[  150.602770] x9 : b5bcc964516bcc00 x8 : b5bcc964516bcc00
[  150.608064] x7 : 5f32353332626d73 x6 : ffffff91e06e6171
[  150.613359] x5 : 0000000000000000 x4 : 0000000000000008
[  150.618654] x3 : 0000000000fd7195 x2 : ffffffd177487c78
[  150.623949] x1 : ffffff91dff905bc x0 : 0000000000000029
[  150.629244]
[  150.629244] PC: 0xffffff91df3dda0c:
[  150.634539] da0c  f84307f5 d65f03c0 f9421a68 b4000068 f9400101 
b50000e1 f9400268 d0006129
[  150.639496] da2c  9127c529 f9400108 f100011f 9a880121 90005900 
9126d800 97ed1ccd 321d7bf4
[  150.647568] da4c  d4210000 17ffffec f81c0ff7 a90157f6 a9024ff4 
a9037bfd 9100c3fd f9402c17
[  150.655729] da6c  aa0003f4 910242f3 aa1303e0 941df710 f9402e96 
52808401 aa1f03e2 b9001e9f
[  150.663890]
[  150.663890] LR: 0xffffff91df3dda08:
[  150.672039] da08  a9414ff4 f84307f5 d65f03c0 f9421a68 b4000068 
f9400101 b50000e1 f9400268
[  150.677082] da28  d0006129 9127c529 f9400108 f100011f 9a880121 
90005900 9126d800 97ed1ccd
[  150.685155] da48  321d7bf4 d4210000 17ffffec f81c0ff7 a90157f6 
a9024ff4 a9037bfd 9100c3fd
[  150.693316] da68  f9402c17 aa0003f4 910242f3 aa1303e0 941df710 
f9402e96 52808401 aa1f03e2
[  150.701475]
[  150.701475] SP: 0xffffff80109d38e0:
[  150.709624] 38e0  df3dda4c ffffff91 60400145 00000000 ffffffc8 
ffffff80 516bcc00 b5bcc964
[  150.714669] 3900  ffffffff 0000007f df512f6c ffffff91 109d3940 
ffffff80 df3dda4c ffffff91
[  150.722743] 3920  718f1f10 ffffffd1 dfb5b6dc ffffff91 6ffed980 
ffffffd1 718f1e80 ffffffd1
[  150.730903] 3940  109d3970 ffffff80 df3dd8a4 ffffff91 6ad16500 
ffffffd1 00000000 00000000
[  150.739062]
[  150.747202] Call trace:
[  150.748771]  _regulator_disable+0x15c/0x164
[  150.750943]  regulator_disable+0x34/0x80
[  150.755118]  qcom_pmic_typec_pdphy_start+0x40/0x144 [qcom_pmic_tcpm]
[  150.759289]  qcom_pmic_typec_probe+0x2e8/0x300 [qcom_pmic_tcpm]
[  150.765619]  platform_drv_probe+0x5c/0xb0
[  150.771256]  driver_probe_device+0x2e8/0x41c
[  150.775425]  __driver_attach+0x90/0x114
[  150.779762]  bus_for_each_dev+0x80/0xc8
[  150.783321]  driver_attach+0x20/0x28
[  150.787140]  bus_add_driver+0x138/0x240
[  150.790960]  driver_register+0x8c/0xd8
[  150.794519]  __platform_driver_register+0x40/0x48
[  150.798346]  init_module+0x2c/0x1000 [qcom_pmic_tcpm]
[  150.803119]  do_one_initcall+0xdc/0x1b0
[  150.808147]  do_init_module+0x60/0x1c4
[  150.811793]  load_module+0x23cc/0x2790
[  150.815613]  SyS_finit_module+0xbc/0x110
[  150.819345]  el0_svc_naked+0x34/0x38
[  150.823424] ---[ end trace b3846aa77ad5b668 ]---

So we add a conditional judgment before disable the regulator to fix the 
issue simply.

在 8/23/2023 5:53 PM, Bryan O'Donoghue 写道:
> On 23/08/2023 10:15, Hui Liu via B4 Relay wrote:
>> From: Hui Liu <quic_huliu@quicinc.com>
>>
>> Check regulator enable status before disabling it to avoid
>> unbalanced regulator disable warnings.
>>
>> Signed-off-by: Hui Liu <quic_huliu@quicinc.com>
>> ---
>>   drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c 
>> b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
>> index bb0b8479d80f..ca616b17b5b6 100644
>> --- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
>> +++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
>> @@ -422,7 +422,8 @@ static int qcom_pmic_typec_pdphy_disable(struct 
>> pmic_typec_pdphy *pmic_typec_pdp
>>       ret = regmap_write(pmic_typec_pdphy->regmap,
>>                  pmic_typec_pdphy->base + USB_PDPHY_EN_CONTROL_REG, 0);
>> -    regulator_disable(pmic_typec_pdphy->vdd_pdphy);
>> +    if (regulator_is_enabled(pmic_typec_pdphy->vdd_pdphy))
>> +        regulator_disable(pmic_typec_pdphy->vdd_pdphy);
>>       return ret;
>>   }
>>
>> ---
>> base-commit: bbb9e06d2c6435af9c62074ad7048910eeb2e7bc
>> change-id: 20230822-qcom-tcpc-d41954ac65fa
>>
>> Best regards,
> 
> Is this a fix for a real bug you've seen or a hypothetical use-case fix ?
> 
> ---
> bod
