Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DB47FB8BB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 12:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344088AbjK1K7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbjK1K7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:59:52 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD0618F;
        Tue, 28 Nov 2023 02:59:58 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASAEBK9010595;
        Tue, 28 Nov 2023 10:59:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=CMvSo3+l07aKZg2M3+0zJOLmSaZeNzfKKgykk/9lmEg=;
 b=kYvhyKr32pbPd7/RyJv+OE3dZ5nNZ4tkRzQtA3hEyen5+9zILvhHsojfJ6gemF7evFDA
 b+bc/Uur0bfPCU79ktIaBSvIuketnS04eAFC6fhezqEAHlr79md1+eFCSYQSo9Hk2ILe
 VMqCDwjmOeIaRlLDIfgc4nfwsm7iW6a+yrLcx/zrmb6/x6jJqF/bPBTnkd3qEn759j2i
 sjB5ahTaITYsmS94UXHZA8pEnnln1ZVXZx4iTzCKf9lzqH522zsdrdajTMtPcr1E43JV
 craCsCttKc8tSoRKtYBT+dpwfguxDURBudhBCpGqyUmD7dXLMjzQOk4WYNec5fXJZKCf aQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3umsvak5k8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 10:59:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ASAxiVO032519
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 10:59:44 GMT
Received: from [10.253.11.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 28 Nov
 2023 02:59:41 -0800
Message-ID: <46b24613-cffc-4a87-9232-8b93e09906f1@quicinc.com>
Date:   Tue, 28 Nov 2023 18:59:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/10] scsi: ufs: ufs-qcom: Limit HS-G5 Rate-A to hosts
 with HW version 5
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
 <1700729190-17268-7-git-send-email-quic_cang@quicinc.com>
 <20231128055520.GG3088@thinkpad>
 <4648b6a0-92cb-4411-9b58-03219962505d@quicinc.com>
 <20231128105506.GO3088@thinkpad>
From:   Can Guo <quic_cang@quicinc.com>
In-Reply-To: <20231128105506.GO3088@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SiENWPrHB3apQgZf_VdtwooeCgvhdGpQ
X-Proofpoint-GUID: SiENWPrHB3apQgZf_VdtwooeCgvhdGpQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_10,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 phishscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
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



On 11/28/2023 6:55 PM, Manivannan Sadhasivam wrote:
> On Tue, Nov 28, 2023 at 03:48:02PM +0800, Can Guo wrote:
>> Hi Mani,
>>
>> On 11/28/2023 1:55 PM, Manivannan Sadhasivam wrote:
>>> On Thu, Nov 23, 2023 at 12:46:26AM -0800, Can Guo wrote:
>>>> Qcom UFS hosts, with HW ver 5, can only support up to HS-G5 Rate-A due to
>>>> HW limitations. If the HS-G5 PHY gear is used, update host_params->hs_rate
>>>> to Rate-A, so that the subsequent power mode changes shall stick to Rate-A.
>>>>
>>>> Signed-off-by: Can Guo <quic_cang@quicinc.com>
>>>
>>> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>>
>>> One question below...
>>>
>>>> ---
>>>>    drivers/ufs/host/ufs-qcom.c | 18 +++++++++++++++++-
>>>>    1 file changed, 17 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
>>>> index 9613ad9..6756f8d 100644
>>>> --- a/drivers/ufs/host/ufs-qcom.c
>>>> +++ b/drivers/ufs/host/ufs-qcom.c
>>>> @@ -442,9 +442,25 @@ static u32 ufs_qcom_get_hs_gear(struct ufs_hba *hba)
>>>>    static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
>>>>    {
>>>>    	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
>>>> +	struct ufs_host_params *host_params = &host->host_params;
>>>>    	struct phy *phy = host->generic_phy;
>>>> +	enum phy_mode mode;
>>>>    	int ret;
>>>> +	/*
>>>> +	 * HW ver 5 can only support up to HS-G5 Rate-A due to HW limitations.
>>>> +	 * If the HS-G5 PHY gear is used, update host_params->hs_rate to Rate-A,
>>>> +	 * so that the subsequent power mode change shall stick to Rate-A.
>>>> +	 */
>>>> +	if (host->hw_ver.major == 0x5) {
>>>> +		if (host->phy_gear == UFS_HS_G5)
>>>> +			host_params->hs_rate = PA_HS_MODE_A;
>>>> +		else
>>>> +			host_params->hs_rate = PA_HS_MODE_B;
>>>
>>> Is this 'else' part really needed? Since there wouldn't be any 2nd init, I think
>>> we can skip that.
>>
>> We need it because, even there is only one init, if a UFS3.1 device is
>> attached, phy_gear is given as UFS_HS_G4 in ufs_qcom_set_phy_gear(), hence
>> we need to put the UFS at HS-G4 Rate B, not Rate A.
>>
> 
> But the default hs_rate is PA_HS_MODE_B only and the else condition would be not
> needed for the 1st init.

You are right, but still we need this in case the UFS device version is 
not populated, meaning dual init can also happen to SM8550. We need to 
apply the right hs_rate in case the 2nd init asks for HS_G4.

Thanks,
Can Guo.

> 
> - Mani
> 
>> Thanks,
>> Can Guo.
>>
>>>
>>> - Mani
>>>
>>>> +	}
>>>> +
>>>> +	mode = host_params->hs_rate == PA_HS_MODE_B ? PHY_MODE_UFS_HS_B : PHY_MODE_UFS_HS_A;
>>>> +
>>>>    	/* Reset UFS Host Controller and PHY */
>>>>    	ret = ufs_qcom_host_reset(hba);
>>>>    	if (ret)
>>>> @@ -459,7 +475,7 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
>>>>    		return ret;
>>>>    	}
>>>> -	phy_set_mode_ext(phy, PHY_MODE_UFS_HS_B, host->phy_gear);
>>>> +	phy_set_mode_ext(phy, mode, host->phy_gear);
>>>>    	/* power on phy - start serdes and phy's power and clocks */
>>>>    	ret = phy_power_on(phy);
>>>> -- 
>>>> 2.7.4
>>>>
>>>
> 
