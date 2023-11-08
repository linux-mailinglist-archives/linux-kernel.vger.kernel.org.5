Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412227E5211
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 09:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbjKHIn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 03:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjKHIn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 03:43:27 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E74D1710;
        Wed,  8 Nov 2023 00:43:25 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A87N8iF006330;
        Wed, 8 Nov 2023 08:42:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=fMjvdbcTN+mM1stRhX8y1SgEAH+2W4UOL/UD/yX8wXA=;
 b=UEcIzoMJOwYBfiHi85XoYxknJ9oBVVapJnHlvXUwjXw3acFE4vsePXS5kvAVuzKlxDS+
 2ihgxctaK6COxd2kUe/oZXLpQP/EY5/1EpNGWQIS506xDt6W27hh+xYpKN/ManNiAY/8
 d2SrvtB8R3n1jkcJVGKtPem7K2kCrNmxKnvpzi7Mi4Kl91gimZMBu7Ygga5ahLoHf+pf
 DRKYaKf25ht119BeEFvAS+o2kmuAPQMrnWJGHmlTmX+8Hp2CZWsp2KZErbEo2otteB38
 yvCWXxv5ceXe2LUeAVphtM8esTwhleDqHphUu2L5u4F/MzLMLp8g9lF5z/JuA/p2WRqw Ew== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u7xyu0vw7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Nov 2023 08:42:51 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A88gnCU020751
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Nov 2023 08:42:49 GMT
Received: from [10.253.34.202] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 8 Nov
 2023 00:42:45 -0800
Message-ID: <59f83fcd-6c2d-6b8a-55e6-0db07bfb5744@quicinc.com>
Date:   Wed, 8 Nov 2023 16:42:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 4/7] scsi: ufs: ufs-qcom: Limit HS-G5 Rate-A to hosts
 with HW version 5
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Can Guo <cang@qti.qualcomm.com>
CC:     <bvanassche@acm.org>, <stanley.chu@mediatek.com>,
        <adrian.hunter@intel.com>, <beanhuo@micron.com>,
        <avri.altman@wdc.com>, <junwoo80.lee@samsung.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1699332374-9324-1-git-send-email-cang@qti.qualcomm.com>
 <1699332374-9324-5-git-send-email-cang@qti.qualcomm.com>
 <20231108052555.GD3296@thinkpad>
From:   Can Guo <quic_cang@quicinc.com>
In-Reply-To: <20231108052555.GD3296@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tMRjIEwacoyZnb3pbBjRcNL9tnXyxnVD
X-Proofpoint-GUID: tMRjIEwacoyZnb3pbBjRcNL9tnXyxnVD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_01,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311080071
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mani,

On 11/8/2023 1:25 PM, Manivannan Sadhasivam wrote:
> On Mon, Nov 06, 2023 at 08:46:10PM -0800, Can Guo wrote:
>> From: Can Guo <quic_cang@quicinc.com>
>>
>> Qcom UFS hosts, with HW ver 5, can only support up to HS-G5 Rate-A due to
>> HW limitations. If the HS-G5 PHY gear is used, update host_params->hs_rate
>> to Rate-A, so that the subsequent power mode changes shall stick to Rate-A.
>>
>> Signed-off-by: Can Guo <quic_cang@quicinc.com>
>> ---
>>   drivers/ufs/host/ufs-qcom.c | 18 +++++++++++++++++-
>>   1 file changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
>> index 60b35ca..55ee31d 100644
>> --- a/drivers/ufs/host/ufs-qcom.c
>> +++ b/drivers/ufs/host/ufs-qcom.c
>> @@ -442,9 +442,25 @@ static u32 ufs_qcom_get_hs_gear(struct ufs_hba *hba)
>>   static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
>>   {
>>   	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
>> +	struct ufs_host_params *host_params = &host->host_params;
>>   	struct phy *phy = host->generic_phy;
>> +	enum phy_mode mode;
>>   	int ret;
>>   
>> +	/*
>> +	 * HW ver 5 can only support up to HS-G5 Rate-A due to HW limitations.
> 
> Does this limitation apply to future targets as well or just to SM8550? If
> it's the latter, then we need to use a flag.
> 
> - ManiUFS host controller HW ver (major) 5 IPs (they may have different 
minor/step verions) can be used by many QCOM chipsets, so it applies to 
several available targets and future targets which are going to have HW 
ver 5 UFS host controller. This limitation goes away since HW ver 6.

Thanks,
Can Guo.
