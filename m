Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C500678A60F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 08:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjH1GtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 02:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjH1GtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 02:49:07 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9414C10D;
        Sun, 27 Aug 2023 23:49:05 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37S6196F021198;
        Mon, 28 Aug 2023 06:48:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ZkKeM4FclNAHL+N6xLWvTF+AySgNT0OlDIdrec2T3hM=;
 b=GZVD8uLF7iary1yUcjjQ82tYYf57VtUakrCt4jZ48c6DoRnNqhT1tmp7rP1MzKNg3jKe
 ngeAPdHPRA3r3sREWuLwE/GieHQIucQPIrdxZBDqLCGfx2s6mXt/gyJyYzmEG6kifD1I
 LXIXtH0uwrnEBlRshqA72M+DWUp6eMH0QVPfYIuoAP8aH1D/aDaeSHIVwaITw9XBCuvz
 Cg6KRBvELuewUzP5CYHPx5gR9GIBfxUgG16fMlHZIej667Ia3rlGjt5u6P4c2b7frN+d
 8iMrshmoGgBwjEGjfn6VcaOsO5kjv4HwdNPushoQ+f0GBZaogzlwo+aciKdwbUFvg2aY iQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sqa5ptv53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 06:48:49 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37S6ml4d025319
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 06:48:47 GMT
Received: from [10.217.216.47] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Sun, 27 Aug
 2023 23:48:42 -0700
Message-ID: <ef1439f8-4a9b-53b4-34be-1229b39d2310@quicinc.com>
Date:   Mon, 28 Aug 2023 12:18:30 +0530
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
From:   Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <07e93a9d-69ac-41b7-aa21-b855b97bf801@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xUzvyVDW9nBF7cT3b23So4sTWTa4jiaO
X-Proofpoint-GUID: xUzvyVDW9nBF7cT3b23So4sTWTa4jiaO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_03,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 suspectscore=0 clxscore=1011 mlxlogscore=721 lowpriorityscore=0
 spamscore=0 adultscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308280060
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/26/2023 4:17 PM, Konrad Dybcio wrote:
> On 23.08.2023 12:41, Abel Vesa wrote:
>> On 23-08-16 19:56:46, Konrad Dybcio wrote:
>>> On 16.08.2023 16:57, Abel Vesa wrote:
>>>> From: Jagadeesh Kona <quic_jkona@quicinc.com>
>>>>
>>>> The current HW_CTRL flag switches the video GDSC to HW control mode as
>>>> part of GDSC enable itself, instead of that use HW_CTRL_TRIGGER flag to
>>>> give consumer drivers more control and switch the GDSC mode as and when
>>>> required.
>>>>
>>>> HW_CTRL_TRIGGER flag allows consumer drivers to switch the video GDSC to
>>>> HW/SW control modes at runtime using dev_pm_genpd_set_hwmode API.
>>>>
>>>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>>>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>>>> ---
>>> Do we have any use for the HW_CTRL flag?
>>>
>>> Perhaps it should be renamed to HW_CTRL_ALWAYS?
>>>
>>> Or even better, *if and only if* that is necessary, add a common
>>> property like "always_hw_managed" to the genpd code?
>>
>> The HW_CTRL flag is still needed for the consumers that expect the GDSC
>> to be have the HW control bit set right after it gets enabled.
> Guess the correct question here would be.. Are there any?
> 

Yes, Display GDSC(mdss_gdsc) is required to be controlled always in HW 
control mode when it is enabled.

Thanks,
Jagadeesh

> Konrad
