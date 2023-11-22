Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557437F3DF8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 07:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234718AbjKVGPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 01:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjKVGPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 01:15:35 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8A9D40;
        Tue, 21 Nov 2023 22:15:31 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AM5kqSV001503;
        Wed, 22 Nov 2023 06:15:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=wYDNyT+fybxznp+VAFlr6au6RMMN4XBDNwkEIag44Yg=;
 b=MZj8FJuVK33KmlSs43xfH2C+BWqAB5QwHv3nqlC7VUmQSSiOn2TvUhaGXz2CrzmcW5uq
 kiA+wTdSO73Kjvn0ChaRipGYQfRo7oxoHONoAPdznOvY0UdoKnOLLQMUKechuR+VDJCK
 QYQspCXVrggbaUtQw+Sfg5/RDepnDz44e2B0iwBoubAoj9Uq0Ew6tEHCyggdxYrhp3sv
 Yk9plrdTwXbajsK8H/bgU4xLwklx6ln86jpO5c5ULuExFfD7+L82sV44+C6Ln4+C12cV
 4bafqSbzasEntFgWnwykbEcv34lKACSz25U+UTAVOWlj0xy6B0n8fNQMO44UWcL00HQD 0A== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uh477gvvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 06:15:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AM6F5Hl028121
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 06:15:05 GMT
Received: from [10.253.15.194] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 21 Nov
 2023 22:15:00 -0800
Message-ID: <85d7a1ef-92c4-49ae-afe0-727c1b446f55@quicinc.com>
Date:   Wed, 22 Nov 2023 14:14:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: ufs: qcom: move ufs_qcom_host_reset() to
 ufs_qcom_device_reset()
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Ziqi Chen <quic_ziqichen@quicinc.com>
CC:     <quic_asutoshd@quicinc.com>, <bvanassche@acm.org>,
        <beanhuo@micron.com>, <avri.altman@wdc.com>,
        <junwoo80.lee@samsung.com>, <martin.petersen@oracle.com>,
        <quic_nguyenb@quicinc.com>, <quic_nitirawa@quicinc.com>,
        <quic_rampraka@quicinc.com>, <linux-scsi@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1698145815-17396-1-git-send-email-quic_ziqichen@quicinc.com>
 <20231025074128.GA3648@thinkpad>
Content-Language: en-US
From:   Can Guo <quic_cang@quicinc.com>
In-Reply-To: <20231025074128.GA3648@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RLh3YGxEGWi-AlI53KP2pIPZ0pez9c9i
X-Proofpoint-GUID: RLh3YGxEGWi-AlI53KP2pIPZ0pez9c9i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_03,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015
 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311220043
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/2023 3:41 PM, Manivannan Sadhasivam wrote:
> On Tue, Oct 24, 2023 at 07:10:15PM +0800, Ziqi Chen wrote:
>> During PISI test, we found the issue that host Tx still bursting after
> 
> What is PISI test?
> 
>> H/W reset. Move ufs_qcom_host_reset() to ufs_qcom_device_reset() and
>> reset host before device reset to stop tx burst.
>>
> 
> device_reset() callback is supposed to reset only the device and not the host.
> So NACK for this patch.

Agree, the change should come in a more reasonable way.

Actually, similar code is already there in ufs_mtk_device_reset() in 
ufs-mediatek.c, I guess here is trying to mimic that fashion.

This change, from its functionality point of view, we do need it, 
because I occasionally (2 out of 10) hit PHY error on lane 0 during 
reboot test (in my case, I tried SM8350, SM8450 and SM8550， all same).

[    1.911188] [DEBUG]ufshcd_update_uic_error: UECPA:0x80000002
[    1.922843] [DEBUG]ufshcd_update_uic_error: UECDL:0x80004000
[    1.934473] [DEBUG]ufshcd_update_uic_error: UECN:0x0
[    1.944688] [DEBUG]ufshcd_update_uic_error: UECT:0x0
[    1.954901] [DEBUG]ufshcd_update_uic_error: UECDME:0x0

I found out that the PHY error pops out right after UFS device gets 
reset in the 2nd init. After having this change in place, the PA/DL 
errors are gone.

Thanks,
Can Guo.
> 
> - Mani
> 
>> Signed-off-by: Ziqi Chen <quic_ziqichen@quicinc.com>
>> ---
>>   drivers/ufs/host/ufs-qcom.c | 13 +++++++------
>>   1 file changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
>> index 96cb8b5..43163d3 100644
>> --- a/drivers/ufs/host/ufs-qcom.c
>> +++ b/drivers/ufs/host/ufs-qcom.c
>> @@ -445,12 +445,6 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
>>   	struct phy *phy = host->generic_phy;
>>   	int ret;
>>   
>> -	/* Reset UFS Host Controller and PHY */
>> -	ret = ufs_qcom_host_reset(hba);
>> -	if (ret)
>> -		dev_warn(hba->dev, "%s: host reset returned %d\n",
>> -				  __func__, ret);
>> -
>>   	/* phy initialization - calibrate the phy */
>>   	ret = phy_init(phy);
>>   	if (ret) {
>> @@ -1709,6 +1703,13 @@ static void ufs_qcom_dump_dbg_regs(struct ufs_hba *hba)
>>   static int ufs_qcom_device_reset(struct ufs_hba *hba)
>>   {
>>   	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
>> +	int ret = 0;
>> +
>> +	/* Reset UFS Host Controller and PHY */
>> +	ret = ufs_qcom_host_reset(hba);
>> +	if (ret)
>> +		dev_warn(hba->dev, "%s: host reset returned %d\n",
>> +				  __func__, ret);
>>   
>>   	/* reset gpio is optional */
>>   	if (!host->device_reset)
>> -- 
>> 2.7.4
>>
> 
