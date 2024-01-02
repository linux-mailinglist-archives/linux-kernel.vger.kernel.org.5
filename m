Return-Path: <linux-kernel+bounces-14805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD978222A0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 21:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5168F1F23620
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 20:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6615B1642B;
	Tue,  2 Jan 2024 20:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="USUEz1at"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5377616410;
	Tue,  2 Jan 2024 20:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 402KTbF2012670;
	Tue, 2 Jan 2024 20:33:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=vmjxe9XwHidyB+gjEeLkZQFfIRNKZJrOImocyOmQabs=; b=US
	UEz1atSMTOHCJVCNjWRj6XFMwUr1Xn2oojZJOQWwTOCFODutx3yhJ3cZQeclRQMF
	tcb5HTUxlYnD3JmhB0fbrdH1cK0jiKJU1naZ4Ng5mplMmPt2sI/L5UKQrb0MTzOr
	eEwzT6M5H5VSe+3QidqTqumS8OSY3GffDJzMUKy2OtDmvRjzpwPKXQDot61r8bOC
	9JFUCTyNxUIjIrX66btJop71g4xaOIUJo+Un03suTF9ntL6d7rb54gf7y+RQVwEC
	8Bu5ee2D/GdqtSVOnEoYfnO+V2qfBEndcjRtna47Z+KUVsJmaE3rmNf0dPjlV4Yb
	88hdjoThs2xADwFD9ZFg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vcg41977q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jan 2024 20:33:22 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 402KXLl2028048
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Jan 2024 20:33:21 GMT
Received: from [192.168.143.77] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 2 Jan
 2024 12:33:20 -0800
Message-ID: <76fb76cc-70d6-7a5f-7fcd-e8161ae72299@quicinc.com>
Date: Tue, 2 Jan 2024 12:33:20 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] scsi: ufs: core: Let the sq_lock protect sq_tail_slot
 access
To: Can Guo <quic_cang@quicinc.com>, <bvanassche@acm.org>, <mani@kernel.org>,
        <adrian.hunter@intel.com>, <beanhuo@micron.com>, <avri.altman@wdc.com>,
        <junwoo80.lee@samsung.com>, <martin.petersen@oracle.com>
CC: <linux-scsi@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Alim Akhtar
	<alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Asutosh Das
	<quic_asutoshd@quicinc.com>,
        Peter Wang <peter.wang@mediatek.com>,
        "Arthur
 Simchaev" <Arthur.Simchaev@wdc.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1702913550-20631-1-git-send-email-quic_cang@quicinc.com>
Content-Language: en-US
From: "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
In-Reply-To: <1702913550-20631-1-git-send-email-quic_cang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wsIyvjIJr7V944lrYzvcDlEk0rKbpo45
X-Proofpoint-ORIG-GUID: wsIyvjIJr7V944lrYzvcDlEk0rKbpo45
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 phishscore=0 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401020153

On 12/18/2023 7:32 AM, Can Guo wrote:
> If access sq_tail_slot without the protection from the sq_lock, race
> condition can have multiple SQEs copied to duplicate SQE slot(s), which can
> lead to multiple incredible stability issues. Fix it by moving the *dest
> initialization, in ufshcd_send_command(), back under protection from the
> sq_lock.
> 
> Fixes: 3c85f087faec ("scsi: ufs: mcq: Use pointer arithmetic in ufshcd_send_command()")
> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index ae9936f..2994aac 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -2274,9 +2274,10 @@ void ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag,
>   	if (is_mcq_enabled(hba)) {
>   		int utrd_size = sizeof(struct utp_transfer_req_desc);
>   		struct utp_transfer_req_desc *src = lrbp->utr_descriptor_ptr;
> -		struct utp_transfer_req_desc *dest = hwq->sqe_base_addr + hwq->sq_tail_slot;
> +		struct utp_transfer_req_desc *dest;
>   
>   		spin_lock(&hwq->sq_lock);
> +		dest = hwq->sqe_base_addr + hwq->sq_tail_slot;
>   		memcpy(dest, src, utrd_size);
>   		ufshcd_inc_sq_tail(hwq);
>   		spin_unlock(&hwq->sq_lock);

Reviewed and Tested-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>

