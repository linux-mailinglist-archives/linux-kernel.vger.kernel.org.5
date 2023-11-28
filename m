Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017277FB8E5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 12:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344443AbjK1LED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 06:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344331AbjK1LD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 06:03:56 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7B1A3;
        Tue, 28 Nov 2023 03:04:01 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AS48moO029212;
        Tue, 28 Nov 2023 11:03:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KSo20Un2/Lnvkx5ReP8LPWosM7ux6fjmTV9ToFT3EWw=;
 b=h2sqorHxGjlXkOgzVTcxY07WhUu5oKxrCnJuLqteYjjh7BlmxEsvJMi7I8OeBFNBiiK3
 ++bwihC43pun2DqjWMf2yGxl1juW4D1ZQmeOs3galC3Icpl5rZSfRmdPIlYPYY/NyM46
 s7nFMJppayxLMmtI8mbWFGee4SrOhtvvi45x9SgPQ/YQkYk846NGobQFihUvOVxrcCdN
 4aOpI9eojQCSrK0sPDps3+EIH0XvLjO4mARLOE1PfbVJkvulmL91eNLhnsMZLapdBSfL
 XCPq2JdZqo2+FIiSr9tZIdePezROJG5lSLSptkMWkybBK4JdZ6MeHovurwWgJfj/fxUd +g== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3un02h20uw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 11:03:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ASB3lNX005594
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 11:03:47 GMT
Received: from [10.253.11.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 28 Nov
 2023 03:03:44 -0800
Message-ID: <238a3df1-5631-4922-b268-83d3dfb80c6a@quicinc.com>
Date:   Tue, 28 Nov 2023 19:03:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/10] scsi: ufs: ufs-qcom: Limit negotiated gear to
 selected PHY gear
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <bvanassche@acm.org>, <adrian.hunter@intel.com>,
        <beanhuo@micron.com>, <avri.altman@wdc.com>,
        <junwoo80.lee@samsung.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1700729190-17268-1-git-send-email-quic_cang@quicinc.com>
 <1700729190-17268-5-git-send-email-quic_cang@quicinc.com>
 <20231128054522.GF3088@thinkpad>
 <bc69d9ef-6ddc-4389-8bf0-9405385a494b@quicinc.com>
 <20231128105237.GN3088@thinkpad>
From:   Can Guo <quic_cang@quicinc.com>
In-Reply-To: <20231128105237.GN3088@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Oj0iJPKTX0ClYzcCPOYKZr_r7tjf7B9Q
X-Proofpoint-ORIG-GUID: Oj0iJPKTX0ClYzcCPOYKZr_r7tjf7B9Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_10,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 malwarescore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311280087
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/28/2023 6:52 PM, Manivannan Sadhasivam wrote:
> On Tue, Nov 28, 2023 at 04:05:59PM +0800, Can Guo wrote:
>> Hi Mani,
>>
>> On 11/28/2023 1:45 PM, Manivannan Sadhasivam wrote:
>>> On Thu, Nov 23, 2023 at 12:46:24AM -0800, Can Guo wrote:
>>>> In the dual init scenario, the initial PHY gear is set to HS-G2, and the
>>>> first Power Mode Change (PMC) is meant to find the best matching PHY gear
>>>> for the 2nd init. However, for the first PMC, if the negotiated gear (say
>>>> HS-G4) is higher than the initial PHY gear, we cannot go ahead let PMC to
>>>> the negotiated gear happen, because the programmed UFS PHY settings may not
>>>> support the negotiated gear. Fix it by overwriting the negotiated gear with
>>>> the PHY gear.
>>>>
>>>
>>> I don't quite understand this patch. If the phy_gear is G2 initially and the
>>> negotiated gear is G4, then as per this change,
>>>
>>> phy_gear = G4;
>>> negotiated gear = G2;
>>>
>>> Could you please explain how this make sense?
>>
>> phy_gear was G2 (in the beginning) and just now changed to G4, but the PHY
>> settings programmed in the beginning can only support no-G4 (not G4).
>> Without this change, as the negotiated gear is G4, the power mode change is
>> going to put UFS at HS-G4 mode, but the PHY settings programmed is no-G4.
> 
> But we are going to reinit the PHY anyway, isn't it?

We are power mode changing to HS-G4 with no-G4 PHY settings programmed, 
the power mode change operation, in the 1st init, may immediately cause 
UIC errors and lead to probe fail. We are not seeing issues as of now, 
maybe because the amount of HW used for testing is not large enough.

This change is not really related to this specific series, I can remove 
it in next version.

Thanks,
Can Guo.

> 
>> This change is to limit the negotiated gear to HS-G2 for the 1st init. In
>> the 2nd init, as the new PHY gear is G4, G4 PHY settings would be
>> programmed, it'd be safe to put the UFS at HS-G4 mode.
>>
> 
> Why do we need to limit it since we already have the logic in place to set
> whatever gear mode applicable for 1st init?
> 
> - Mani
> 
>> Thanks,
>> Can Guo.
>>>
>>> - Mani
>>>
>>>> Signed-off-by: Can Guo <quic_cang@quicinc.com>
>>>> ---
>>>>    drivers/ufs/host/ufs-qcom.c | 7 ++++++-
>>>>    1 file changed, 6 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
>>>> index cc0eb37..d4edf58 100644
>>>> --- a/drivers/ufs/host/ufs-qcom.c
>>>> +++ b/drivers/ufs/host/ufs-qcom.c
>>>> @@ -920,8 +920,13 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
>>>>    		 * because, the PHY gear settings are backwards compatible and we only need to
>>>>    		 * change the PHY gear settings while scaling to higher gears.
>>>>    		 */
>>>> -		if (dev_req_params->gear_tx > host->phy_gear)
>>>> +		if (dev_req_params->gear_tx > host->phy_gear) {
>>>> +			u32 old_phy_gear = host->phy_gear;
>>>> +
>>>>    			host->phy_gear = dev_req_params->gear_tx;
>>>> +			dev_req_params->gear_tx = old_phy_gear;
>>>> +			dev_req_params->gear_rx = old_phy_gear;
>>>> +		}
>>>>    		/* enable the device ref clock before changing to HS mode */
>>>>    		if (!ufshcd_is_hs_mode(&hba->pwr_info) &&
>>>> -- 
>>>> 2.7.4
>>>>
>>>
> 
