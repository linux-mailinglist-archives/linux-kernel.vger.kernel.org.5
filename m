Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D8278A567
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 07:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjH1Fxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 01:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjH1FxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 01:53:19 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B9AA9;
        Sun, 27 Aug 2023 22:53:17 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37S5ocsI029304;
        Mon, 28 Aug 2023 05:52:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=OXYmdMy79R6QKETpCZPnezdbgFpTmEBl3XuaE+p/LbA=;
 b=B5SBLHGcDkN1rzHh/64RNkUmbZ663XTY0tOYFUUoYgxuFxEeHSQmlu9rF5kJZ92lLNYx
 hGnydn4+DEbSnhN7oyGsj6Cdxo4NbylAuuIUfjQR9wTE37koQxXLzdGcEROJNpTMmlMG
 jGIOu1zj7NxU9ZpLyAaqsIiO35TO00MsId17ofNZK06OHIO7Vbx2ZSUegF258V/e86mn
 Cb3vGQeLQLafdxphQNyMcCYOi5aMeutGxXMWabQUxCaZYXWIc+tNzBhR9FIocHkvvWMl
 ijTCjIKBHhKe387wbeXmym9tParnmmoZt4H3aODEBVA7synKlcVbh8mO7d+r9x/mdHpX 3A== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sq8qrtnx6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 05:52:59 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37S5qwFi016865
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 05:52:58 GMT
Received: from [10.238.139.231] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Sun, 27 Aug
 2023 22:52:54 -0700
Message-ID: <6187e719-d1a4-4985-b43f-efaeca2dde89@quicinc.com>
Date:   Mon, 28 Aug 2023 13:51:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: typec: qcom: check regulator enable status before
 disabling it
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     Guenter Roeck <linux@roeck-us.net>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_fenglinw@quicinc.com>,
        <subbaram@quicinc.com>
References: <20230824-qcom-tcpc-v2-1-3dd8c3424564@quicinc.com>
 <ZOdlOQ+N2J7jyIEZ@kuha.fi.intel.com> <ZOdt+dz7XXljFJcK@kuha.fi.intel.com>
 <0b6b864c-3e41-4b41-ac35-9ab8edb156a0@quicinc.com>
 <47547f9e-73d3-f4bc-e3ac-f1be42730dd6@linaro.org>
From:   hui liu <quic_huliu@quicinc.com>
In-Reply-To: <47547f9e-73d3-f4bc-e3ac-f1be42730dd6@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BaoH108eblaLKkVYE-Y78KSbKPh_lkJ_
X-Proofpoint-GUID: BaoH108eblaLKkVYE-Y78KSbKPh_lkJ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_03,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 mlxlogscore=387 bulkscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308280053
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/25/2023 6:11 PM, Bryan O'Donoghue wrote:
> On 25/08/2023 11:03, hui liu wrote:
>> Hi Heikki,
>>
>> I will let Bryan to comment, I am using the driver to support the 
>> pdphy in SMB2352 and there is no external regulator required, so I am 
>> just using a dummy regulator device and I saw this unbalanced 
>> regulator disabling warnings, so my intention for this change is just 
>> fixing the warning message. However, I am fine with whatever 
>> suggestion you have, since the logic is straightforward, and I can 
>> make the changes once you have the agreement.
>>
>> Thanks,
>> Hui
> 
> Err well on real hardware with a real regulator I don't see this error.
Just a doublt, if real regulator has no this error, who enabled it 
before it was reseted?
> 
> I'd say we should try the second proposed changed in pdphy_start 
> pdphy_stop since it looks neater.
> 
I updated the code refer to the proposal, and it worked well,but I just 
thought it makes code a little redundant. Why don't we only keep one 
pdphy_enable/pdphy_disable or pdphy_start/pdphy_stop?
> If it works then fine, else lets stick to your original fix.
> 
> ---
> bod
