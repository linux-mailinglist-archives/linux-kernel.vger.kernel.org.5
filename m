Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221F47919FF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 16:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240219AbjIDOsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 10:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjIDOs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 10:48:29 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C041B9;
        Mon,  4 Sep 2023 07:48:26 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 384CjYTI019440;
        Mon, 4 Sep 2023 14:48:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=i7ckdMr/QRImhMVRVNE5lx+vrtIWJWTzTYFTxs7oA1Q=;
 b=IRNBBV2Xf5aFBgAOZz6nnxSriErZsdvQVbH0seAuCp1Ld+/yn9KxeI/YcdBgEDVUSSgT
 +REiQGc76Z3KdEu9C0CjefZMoyD6cP7JcsvUbiiBzeIiJtivuR6DVgdKmZdWksb3QZu7
 GH382I1MJX6BRjqZ2+hGJu/mR9Ya/XP8oTfpeEeTKw4lSuZG8zSaUCBXrMf/AOuEjVHi
 GEI5FRAP4XRDf27g4xQQt5m8M2EyXWC+vL8V6UgB9F+M1rw5p6m2Tgu2ohz1TwpQ823B
 77rNch+eq3oUktyGT2poDWz/kpLrBhhodrXWOnM7r8TX0nSo9wY3e1lNkQ8Ryr1E2oQS cA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3suvn6kmaq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Sep 2023 14:48:19 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 384EmIft002778
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Sep 2023 14:48:18 GMT
Received: from [10.218.45.181] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 4 Sep
 2023 07:48:13 -0700
Message-ID: <f6b030cc-6ec7-d522-d797-7b84cc48a66a@quicinc.com>
Date:   Mon, 4 Sep 2023 20:18:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH V6 5/6] scsi: ufs: qcom: Refactor ufs_qcom_cfg_timers
 function.
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
CC:     <mani@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <quic_cang@quicinc.com>,
        <quic_nguyenb@quicinc.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        "Naveen Kumar Goud Arepalli" <quic_narepall@quicinc.com>
References: <20230901114336.31339-1-quic_nitirawa@quicinc.com>
 <20230901114336.31339-6-quic_nitirawa@quicinc.com>
 <20230901160634.GV818859@hu-bjorande-lv.qualcomm.com>
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
In-Reply-To: <20230901160634.GV818859@hu-bjorande-lv.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZYF3E_y_mobDm6r5WJZ3Sm1ckpAzYulN
X-Proofpoint-GUID: ZYF3E_y_mobDm6r5WJZ3Sm1ckpAzYulN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_07,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0 mlxscore=0
 malwarescore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309040132
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/1/2023 9:36 PM, Bjorn Andersson wrote:
> On Fri, Sep 01, 2023 at 05:13:35PM +0530, Nitin Rawat wrote:
>> a)Configure SYS1CLK_1US_REG for clock scaleup pre ops.
>> b)Move ufs_qcom_cfg_timers from clk scaling post change ops
>> to clk scaling pre change ops to align with the HPG.
>> c)Introduce a new argument is_pre_scale_up for ufs_qcom_cfg_timers
>> to configure sys_1us timer for max freq as per HPG.
> 
> You forgot to describe the problem you're trying to solve. This is just
> a summary of the changes done in the code.
Sure..Will update the commit text to describe the problem we are solving
in next patchset.

> 
>>
>> Co-developed-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
>> Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
>> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
>> ---
>>   drivers/ufs/host/ufs-qcom.c | 63 +++++++++++++++++++++++++++----------
>>   1 file changed, 46 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
>> index d670fcc27ffb..c251c98a74f0 100644
>> --- a/drivers/ufs/host/ufs-qcom.c
>> +++ b/drivers/ufs/host/ufs-qcom.c
>> @@ -532,7 +532,8 @@ static int ufs_qcom_hce_enable_notify(struct ufs_hba *hba,
>>    * Return: zero for success and non-zero in case of a failure.
>>    */
>>   static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
>> -			       u32 hs, u32 rate, bool update_link_startup_timer)
> 
> Again, it doesn't seem like this variable name change has any functional
> impact, so please don't change it.
Sure..Will take care of this in next patchset.

> 
> PS. You're very welcome to send separate cleanup patches just making the
> code easier to read, but please do so separately.
Sure.

> 
> 
> You're changing the prototype of the function, but you're not updating
> the kernel-doc above, please correct this.
I'll update the kernel doc in next patchset.

> 
>> +				 u32 hs, u32 rate, bool link_startup,
>> +				 bool is_pre_scale_up)
>>   {
>>   	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
>>   	struct ufs_clk_info *clki;
>> @@ -563,11 +564,16 @@ static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
>>   	/*
>>   	 * The Qunipro controller does not use following registers:
>>   	 * SYS1CLK_1US_REG, TX_SYMBOL_CLK_1US_REG, CLK_NS_REG &
>> -	 * UFS_REG_PA_LINK_STARTUP_TIMER
>> -	 * But UTP controller uses SYS1CLK_1US_REG register for Interrupt
>> -	 * Aggregation logic.
>> -	*/
>> -	if (ufs_qcom_cap_qunipro(host) && !ufshcd_is_intr_aggr_allowed(hba))
>> +	 * UFS_REG_PA_LINK_STARTUP_TIMER.
>> +	 * However UTP controller uses SYS1CLK_1US_REG register for Interrupt
>> +	 * Aggregation logic and Auto hibern8 logic.
>> +	 * It is mandatory to write SYS1CLK_1US_REG register on UFS host
>> +	 * controller V4.0.0 onwards.
>> +	 */
>> +	if (ufs_qcom_cap_qunipro(host) &&
>> +	    !(ufshcd_is_intr_aggr_allowed(hba) ||
>> +	    ufshcd_is_auto_hibern8_supported(hba) ||
> 
> This line is indented to the start of the condition, but it's actually
> part of the !() expression starting on the line above. Please indent it
> to align with the ufshcd_is_intr_aggr_allowed() to make this obvious.
- Sure..Will correct the code identation.


> 
>> +	    host->hw_ver.major >= 4))
> 
> I think that this condition is added so that the return will only happen
> on hw_ver < 4. But if it's "significant", why is it hidden in the inner
> expression and not part of the outer expression.
> 
>    cap && !(aggr || h8 || ver >= 4)
> 
> vs
> 
>    ver < 4 && cap && !(aggr || h8)
> 
> The latter prunes the option space much faster than the latter.
Sure..Will take care of this in next patchset.

> 
> 
> Second, there are two changes to this condition in this one patch; one
> affects hw_ver >= 4, and the other affects any previous target
> supporting hibernation.
> 
> Please separate these changes, to facilitate debugging any effects of
> the hibernation change.
Sure...Would send separate patch to include hibernation change.


> 
> Regards,
> Bjorn

Thanks,
Nitin
