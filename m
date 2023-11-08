Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101C37E5164
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 08:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjKHHxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 02:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjKHHxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 02:53:14 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152C4199;
        Tue,  7 Nov 2023 23:53:12 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A85xPJL013886;
        Wed, 8 Nov 2023 07:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=DSdKhTWjAzHr2mcHRgsJUwEb5EUT4mdrBCAfJ1bYdK8=;
 b=idV0dt1YILpTkyt0O5dsfYjgcbd1kosGufIxMqo8Vy/9ww5/4Z6icaqRZjezZm6FMfNH
 4cMXBclqX+95qULaq13Cl5I9sPVzDc1lPdoW3N0Wiuyohb13jR4KZA0zxUvm6ZpbK4Jv
 TyBDnJZIloYEUeiIFDSbgJHAILpVaWRFM75G4AoDXaDpax3rEz7T19cl9kN7VY4LHd2m
 o/NjxB1c5Y1mbXbupLo4BRQkJd1nx7+/n9iO9uww+1n/pKK140x2JNg0OryQJGKBZ+9X
 NxM9S4eDp0dCeWm4HeZJ5/UIbAc3j+2Xq4L9FVKgDIYIHfmicml+2zxUtrh6X7Iy5or7 gA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u7wt28wqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Nov 2023 07:48:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A87lxE3030244
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Nov 2023 07:47:59 GMT
Received: from [10.253.34.202] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 7 Nov
 2023 23:47:55 -0800
Message-ID: <4efa0d56-7c36-2e4f-5597-fbade94231b1@quicinc.com>
Date:   Wed, 8 Nov 2023 15:47:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/7] scsi: ufs: ufs-qcom: Setup host power mode during
 init
Content-Language: en-US
To:     Andrew Halaney <ahalaney@redhat.com>,
        Can Guo <cang@qti.qualcomm.com>
CC:     <bvanassche@acm.org>, <mani@kernel.org>,
        <stanley.chu@mediatek.com>, <adrian.hunter@intel.com>,
        <beanhuo@micron.com>, <avri.altman@wdc.com>,
        <junwoo80.lee@samsung.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>,
        "Bao D . Nguyen" <quic_nguyenb@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1699332374-9324-1-git-send-email-cang@qti.qualcomm.com>
 <1699332374-9324-3-git-send-email-cang@qti.qualcomm.com>
 <pami4442fspxmmyg32jjn2iyzozkyeblcuzwpmkql7wfa3xvq5@ftblajt7hsgo>
From:   Can Guo <quic_cang@quicinc.com>
In-Reply-To: <pami4442fspxmmyg32jjn2iyzozkyeblcuzwpmkql7wfa3xvq5@ftblajt7hsgo>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: b9zSSijwM2iyoYOSrAZwlT2m6ktxGKEQ
X-Proofpoint-GUID: b9zSSijwM2iyoYOSrAZwlT2m6ktxGKEQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_01,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 bulkscore=0 adultscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311080063
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 11/8/2023 4:14 AM, Andrew Halaney wrote:
> On Mon, Nov 06, 2023 at 08:46:08PM -0800, Can Guo wrote:
>> From: Can Guo <quic_cang@quicinc.com>
>>
>> Setup host power mode and its limitations during UFS host driver init to
>> avoid repetitive work during every power mode change.
>>
>> Co-developed-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
>> Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
>> Signed-off-by: Can Guo <quic_cang@quicinc.com>
>> ---
>>   drivers/ufs/host/ufs-qcom.c | 22 ++++++++++++++--------
>>   drivers/ufs/host/ufs-qcom.h |  1 +
>>   2 files changed, 15 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
>> index aee66a3..cc0eb37 100644
>> --- a/drivers/ufs/host/ufs-qcom.c
>> +++ b/drivers/ufs/host/ufs-qcom.c
>> @@ -898,7 +898,7 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
>>   				struct ufs_pa_layer_attr *dev_req_params)
>>   {
>>   	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
>> -	struct ufs_host_params host_params;
>> +	struct ufs_host_params *host_params = &host->host_params;
>>   	int ret = 0;
>>   
>>   	if (!dev_req_params) {
>> @@ -908,13 +908,7 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
>>   
>>   	switch (status) {
>>   	case PRE_CHANGE:
>> -		ufshcd_init_host_param(&host_params);
>> -		host_params.hs_rate = UFS_QCOM_LIMIT_HS_RATE;
> You drop the setting of hs_rate in your new function. It seems setting that's
> also overkill since UFS_QCOM_LIMIT_HS_RATE == PA_HS_MODE_B. hs_rate is
> already set to that in ufshcd_init_host_param(), so removing it makes
> sense.
>
> Can you remove it prior in its own patch, and remove the now unused
> UFS_QCOM_LIMIT_HS_RATE as well from ufs-qcom.h?

Sure, will address this in next version.

>
> With that in place this seems like a good improvement:
>
> Acked-by: Andrew Halaney <ahalaney@redhat.com>


Thanks,

Can Guo.

