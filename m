Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EDD7E3FDF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 14:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbjKGNRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 08:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjKGNQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 08:16:59 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10AB11A;
        Tue,  7 Nov 2023 05:16:56 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7DCQN4011710;
        Tue, 7 Nov 2023 13:16:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=GVlcIxCVDApckKrvxYh3Tmsu0V3EwTj/pZalGxv22JE=;
 b=mpGp03LUNmsbzIHssZds9jkd9U1AoIT+v+Mmi8SWfwlCC8TMMJKUl5UqXNXIBbezBDJn
 PC0y+95E+c41VIp43dQds+q4tPmnUVs7LLzIxFL8S6uubsIE6XtL1Amng7SLgOlE4YyY
 JVJCzvZB8ub3+iIrtsimslNIXEld8tapLavtOsFM8nSgPLWzFXueW/mIHJpXsS7982Wi
 ag0z8Hm+XKLosaXCFGgaiYZsI1IyCJ6isfL0Styl6j5deG4eKaAuxnkj7LjwoCXtTwg4
 LRkejYqlf8Wdw4NvPwZ49QyfbcwT+ZlKajn0ongAaWjuAOyx8Mc/MEk1O7kXCtNu66FI Jg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u6wer3gr5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Nov 2023 13:16:22 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A7DGLfQ014633
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Nov 2023 13:16:21 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 7 Nov
 2023 05:16:17 -0800
Message-ID: <d1e3adb5-b179-a119-fc0c-f92c2b84c7c2@quicinc.com>
Date:   Tue, 7 Nov 2023 18:46:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] soc: qcom: llcc: Fix dis_cap_alloc and retain_on_pc
 configuration
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>,
        Atul Dhudase <quic_adhudase@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <isaacm@codeaurora.org>,
        <dianders@chromium.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20231103105712.1159213-1-quic_adhudase@quicinc.com>
 <20231103193345.GY3553829@hu-bjorande-lv.qualcomm.com>
 <5e83d947-c77f-9318-4a4c-377a8304b8fd@quicinc.com>
 <CAE-0n50HwE+gNYotYXduer3b=O+c3ZWLC_8gEmpo0KQmtzmNvQ@mail.gmail.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <CAE-0n50HwE+gNYotYXduer3b=O+c3ZWLC_8gEmpo0KQmtzmNvQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: v4IPTD1xYMGlnE16jxOLB4w8TrvsFmvp
X-Proofpoint-GUID: v4IPTD1xYMGlnE16jxOLB4w8TrvsFmvp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_04,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=885 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311070110
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/7/2023 3:25 AM, Stephen Boyd wrote:
> Quoting Mukesh Ojha (2023-11-05 22:54:28)
>>
>>
>> On 11/4/2023 1:03 AM, Bjorn Andersson wrote:
>>> On Fri, Nov 03, 2023 at 04:27:12PM +0530, Atul Dhudase wrote:
>>>> While programming dis_cap_alloc and retain_on_pc, set a bit
>>>> corresponding to a specific SCID without disturbing the
>>>> previously configured bits.
>>>>
>>>
>>> As far as I can see, the only invocation of _qcom_llcc_cfg_program()
>>> comes from qcom_llcc_cfg_program(), which is only called once, from
>>> qcom_llcc_probe(), and here also seems to only be the single write to
>>> these two registers.
>>
>> It does not look to be single write but the write is for each slice
>> in the same register which was overriding other slices values.
> 
> Can you add that detail to the commit text? What's the seriousness of
> the issue? Why should it be backported to stable? Is something seriously
> broken because a slice configuration is overwritten? Does it mean that
> some allocation made in a slice is being lost over power collapse (pc)
> when it shouldn't be?

@Atul will update the commit text as per suggestion.

And yes, without this change, retention feature will not work properly.

-Mukesh
