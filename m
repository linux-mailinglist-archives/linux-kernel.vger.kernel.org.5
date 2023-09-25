Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19D47ACE7D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 04:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjIYCwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 22:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjIYCwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 22:52:38 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84E692;
        Sun, 24 Sep 2023 19:52:31 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38P1lY9K019900;
        Mon, 25 Sep 2023 02:52:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=IKvp8yDyksUBVW5kQOdWE+D/FLN6W4EvfEnabZevTUc=;
 b=TN7F9e82Gt/dBVOE1lWM0s2k5p82Lix9sZBaZWUKjnDaozhYV50m+zpGvcBPKUcFKrfP
 jaxckecuMUhIvd+o+Ewxn/+xNW7p4AjpWGV//yoxYofVynHcNOci8Qilq2oqdt023946
 fr/bi9bjkECg1nfkU7zV5Gz6yb2Wh5CHzamu4kbgAWXe68M7fH4WMMpC9TDV4U285uol
 cWst2G4VYl8cBArutUY/xVunN+iu+QzIRXbE6YncSnmwHM4Q5EFH7YxH0GuEN1K9iIER
 N7UCkD93L9cazfxZ/aic8c1AF706EAevpLKGZ1GkLuaJJTx8GUf9KfYRZQh9Bhs/DuKR Bw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t9r41jgec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 02:52:19 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38P2qIoX028588
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 02:52:18 GMT
Received: from [10.239.154.73] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Sun, 24 Sep
 2023 19:52:14 -0700
Message-ID: <36e3719d-ef38-5209-2cd4-7de88257474d@quicinc.com>
Date:   Mon, 25 Sep 2023 10:52:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RESEND PATCH v6 1/3] input: pm8xxx-vib: refactor to easily
 support new SPMI vibrator
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        <linux-input@vger.kernel.org>, <quic_collinsd@quicinc.com>,
        <quic_subbaram@quicinc.com>, <quic_kamalw@quicinc.com>,
        <jestar@qti.qualcomm.com>
References: <20230922083801.3056724-1-quic_fenglinw@quicinc.com>
 <20230922083801.3056724-2-quic_fenglinw@quicinc.com>
 <CAA8EJpo7puWxNte5YHiy6=3GdQSeTYCZMe024-b4N0vnxCV0dQ@mail.gmail.com>
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
In-Reply-To: <CAA8EJpo7puWxNte5YHiy6=3GdQSeTYCZMe024-b4N0vnxCV0dQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 84rhqi-wIj0zN_q87bvYHoIwHW1EQus_
X-Proofpoint-GUID: 84rhqi-wIj0zN_q87bvYHoIwHW1EQus_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-24_21,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxscore=0 phishscore=0 spamscore=0
 mlxlogscore=489 malwarescore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309250016
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/24/2023 3:05 AM, Dmitry Baryshkov wrote:
>> +#define SSBL_VIB_DRV_REG               0x4A
> SSBI_VIB....
> 

Thanks for catching the typo, I will fix it in next patch.

>> +#define SSBI_VIB_DRV_EN_MANUAL_MASK    GENMASK(7, 2)
>> -       /* operate in manual mode */
>> -       error = regmap_read(vib->regmap, regs->drv_addr, &val);
>> -       if (error < 0)
>> -               return error;
>> +       if (data->hw_type != SSBI_VIB) {
> You can drop this condition, if ssbi_vib_data.drv_addr is 0.

I am not sure if I understood this comment: 1st, ssbi_vib_data.drv_addr 
is defined as a constant value 0x4A, so it would never be 0. 2nd, The 
condition check here is to ignore reading the register base address for 
SSBI_VIB HW, so we should do the check based on the HW type.

> 
>> +               error = fwnode_property_read_u32(pdev->dev.fwnode, "reg", &reg_base);
>> +               if (error < 0) {
>> +                       dev_err(&pdev->dev, "Failed to read reg address, rc=%d\n", error);
>> +                       return error;
>> +               }
>> +
>> +               vib->reg_base += reg_base;
