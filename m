Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F85579BD2A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244888AbjIKVIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237406AbjIKMsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 08:48:25 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E73EE4B;
        Mon, 11 Sep 2023 05:48:19 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BC35Gh013880;
        Mon, 11 Sep 2023 12:48:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=+Cl05E6P52wxr9Cy98s8F10fhtxfqzhVr2uRA7Nhc/s=;
 b=nyJermdAWslYkHg0zyXyXmT3/sJF5CeoSzmq9gMP0h0aNeg9ufW4KeGzue7oX8jaOkbP
 qxzIv8LTCaYm7zhacaIPSeDXlcRT0w2h5p4thDffX/XjhonyJODPWIVAPDUNHuOOSA2G
 V1v/l6AiZZu/HrOeuDfFW8KVZ4jbz642MEA4kZnFQ+pfmGUXpafLhkyVncYT9MYCjJ2a
 OIp/vGs7N7yrut2hCv0mskIDzhmgAS9Q9DEJSueELS0j29oWKFi8jqL8C83UvlNrlmB0
 I/7rcX3k/b5lg5pub3jrJChaVyDuubu9SOpuhiH67lQQOj1+dZIiuxXYmuRM7rY/7D/M 9g== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t22hyg2ce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 12:48:03 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38BCm2ij006149
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 12:48:02 GMT
Received: from [10.218.5.19] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 11 Sep
 2023 05:47:55 -0700
Message-ID: <63d72a6f-ec05-1515-cd32-269d35d9a66c@quicinc.com>
Date:   Mon, 11 Sep 2023 18:17:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 4/6] clk: qcom: Use HW_CTRL_TRIGGER flag to switch
 video GDSC to HW mode
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>
CC:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Andy Gross" <agross@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        Taniya Das <tdas@qti.qualcomm.com>, <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>
References: <20230816145741.1472721-1-abel.vesa@linaro.org>
 <20230816145741.1472721-5-abel.vesa@linaro.org>
 <2fc0d771-cee2-4826-a62a-56ed4bfad3a2@linaro.org>
 <ZOXiUzxfs1cj3SWT@linaro.org>
 <07e93a9d-69ac-41b7-aa21-b855b97bf801@linaro.org>
 <ef1439f8-4a9b-53b4-34be-1229b39d2310@quicinc.com>
 <8257f7b3-dfb8-4683-85de-600f3b1ed54b@linaro.org>
 <f37d2dd8-d625-048e-9c21-bba710b40086@quicinc.com>
 <b5ae2ad9-f6c7-47d6-bab8-3f3fdb6b43e2@linaro.org>
 <8c88bca4-b562-0122-1451-ef9de7fd8737@quicinc.com>
 <5d4ba948-46e2-4b95-95a2-17775f4c9881@linaro.org>
From:   Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <5d4ba948-46e2-4b95-95a2-17775f4c9881@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Dpknb6oYYLPnAOcRwvFm5IQVmwnanzp3
X-Proofpoint-GUID: Dpknb6oYYLPnAOcRwvFm5IQVmwnanzp3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_07,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxlogscore=820 phishscore=0 spamscore=0
 impostorscore=0 mlxscore=0 adultscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309110116
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/7/2023 1:06 PM, Konrad Dybcio wrote:
> On 7.09.2023 07:55, Jagadeesh Kona wrote:
>>
>>
>> On 9/4/2023 9:32 PM, Konrad Dybcio wrote:
>>> On 4.09.2023 11:27, Jagadeesh Kona wrote:
>>>>
>>>>
>>>> On 9/2/2023 5:33 PM, Konrad Dybcio wrote:
>>>>> On 28.08.2023 08:48, Jagadeesh Kona wrote:
>>>>>>
>>>>>>
>>>>>> On 8/26/2023 4:17 PM, Konrad Dybcio wrote:
>>>>>>> On 23.08.2023 12:41, Abel Vesa wrote:
>>>>>>>> On 23-08-16 19:56:46, Konrad Dybcio wrote:
>>>>>>>>> On 16.08.2023 16:57, Abel Vesa wrote:
>>>>>>>>>> From: Jagadeesh Kona <quic_jkona@quicinc.com>
>>>>>>>>>>
>>>>>>>>>> The current HW_CTRL flag switches the video GDSC to HW control mode as
>>>>>>>>>> part of GDSC enable itself, instead of that use HW_CTRL_TRIGGER flag to
>>>>>>>>>> give consumer drivers more control and switch the GDSC mode as and when
>>>>>>>>>> required.
>>>>>>>>>>
>>>>>>>>>> HW_CTRL_TRIGGER flag allows consumer drivers to switch the video GDSC to
>>>>>>>>>> HW/SW control modes at runtime using dev_pm_genpd_set_hwmode API.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>>>>>>>>>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>>>>>>>>>> ---
>>>>>>>>> Do we have any use for the HW_CTRL flag?
>>>>>>>>>
>>>>>>>>> Perhaps it should be renamed to HW_CTRL_ALWAYS?
>>>>>>>>>
>>>>>>>>> Or even better, *if and only if* that is necessary, add a common
>>>>>>>>> property like "always_hw_managed" to the genpd code?
>>>>>>>>
>>>>>>>> The HW_CTRL flag is still needed for the consumers that expect the GDSC
>>>>>>>> to be have the HW control bit set right after it gets enabled.
>>>>>>> Guess the correct question here would be.. Are there any?
>>>>>>>
>>>>>>
>>>>>> Yes, Display GDSC(mdss_gdsc) is required to be controlled always in HW control mode when it is enabled.
>>>>> Oh really?
>>>>>
>>>>> Looking at msm-5.10 techpack, only the SDE RSC driver seems to
>>>>> trigger regulator fast mode (so, enabling gdsc hw_ctrl on downstream).
>>>>>
>>>>
>>>> Yes, on downstream, display GDSC has only one consumer(SDE RSC driver) and there are no other consumers. SDE RSC driver switches the GDSC to hw control mode once GDSC is enabled and leaves it in hw control mode. Thanks!
>>> Sorry for pulling your tongue here a bit, but would it only concern
>>> RPMh SoCs? Designs like SM6115 don't implement RSCs, should they not
>>> have HW_CTRL enabled at all times?
>>>
>>
>> Yes, for RPMh SoCs which have display RSC block, GDSC is switched to HW control mode. For SoCs which doesn't have display RSC block, display driver controls the GDSC in SW mode on downstream. Thanks!
> Thanks for explaining!
> 
> One last question, I promise.. Should we switch the MDSS GDSC to
> HW_CTRL mode only after we start controlling the DISP RSC from Linux,
> or should it be done regardless (because of the RPMh solving algos)?
> 

 From GDSC driver, MDSS GDSC can be switched to HW_CTRL mode regardless. 
Thanks!

Regards,
Jagadeesh

> Konrad
