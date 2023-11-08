Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA347E51A4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 09:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbjKHIHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 03:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjKHIHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 03:07:30 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0699A119;
        Wed,  8 Nov 2023 00:07:28 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A82qV2R014988;
        Wed, 8 Nov 2023 08:07:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=9eyiYNrLu9ByGJR2DrKWtV3PSoPk0VBh9FCDFkPpn/g=;
 b=GaxFJuAnUlkoKWveNtlEtRzF838KSgYWDSWpUOlBci9+S8AYxmW1ojDrSXP5SAG7rbBb
 ODTJt3mfmB+DETjHJCRRQlfmi0+HLnwroQRmor5kSWDqFpkQ06HLC5Es4UMUlKF5mnSL
 QBIMJtaltzbI0rjCkA4BKffqVaIb4pwuuqErDfVvKA6sKdlW0cxIsQAtKEh+f3DZJGrv
 LdBvojymXTqv+mP7yHzfJ+woHFTouZjxWp2KMhATpX/wHlPZhMEQ8zv/9n+UEzN1fqoH
 Vj6q7L/zVFhW8VS4MJsoTILrgdwyUbNIAGIQ+eb/gLgXPXxmKkgPlfQIe69eS69DOpoU Mw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u7w2ds265-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Nov 2023 08:07:13 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A887DFg024653
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Nov 2023 08:07:13 GMT
Received: from [10.253.34.202] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 8 Nov
 2023 00:07:09 -0800
Message-ID: <d34cf12d-e42c-89e1-7eeb-400f305f7632@quicinc.com>
Date:   Wed, 8 Nov 2023 16:07:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/7] scsi: ufs: ufs-qcom: Setup host power mode during
 init
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Can Guo <cang@qti.qualcomm.com>
CC:     <bvanassche@acm.org>, <stanley.chu@mediatek.com>,
        <adrian.hunter@intel.com>, <beanhuo@micron.com>,
        <avri.altman@wdc.com>, <junwoo80.lee@samsung.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>,
        "Bao D . Nguyen" <quic_nguyenb@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1699332374-9324-1-git-send-email-cang@qti.qualcomm.com>
 <1699332374-9324-3-git-send-email-cang@qti.qualcomm.com>
 <20231108050729.GA3296@thinkpad>
From:   Can Guo <quic_cang@quicinc.com>
In-Reply-To: <20231108050729.GA3296@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: R3C_AkNydWNgxD-QYRfWF25uQfPD8bc8
X-Proofpoint-ORIG-GUID: R3C_AkNydWNgxD-QYRfWF25uQfPD8bc8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_01,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311080066
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mani,

On 11/8/2023 1:07 PM, Manivannan Sadhasivam wrote:
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
> 
> As Andrew spotted, this gets removed without explanation. So, I'd also suggest
> doing it in a separate patch.
> 
> - Mani
Sure, will do

Thanks,

Can Guo.
