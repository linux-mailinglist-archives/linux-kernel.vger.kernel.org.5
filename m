Return-Path: <linux-kernel+bounces-83311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB148691B6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 668081F2A826
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9307C13B2A9;
	Tue, 27 Feb 2024 13:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hKJ7ztT7"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E671454FA5;
	Tue, 27 Feb 2024 13:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709040329; cv=none; b=rFxP/8tyJMr/zR3TU20izz7ONR/fj/+9rlpq4O0SDGXqoTevLQlc4LzgfxyBhN21t4Fbq9oCdTHp3GJR5uLHRqH75aCIiHWxllXRi//5RU4iFghNwUMtaeLoPsvNdYq1+w4yBKIFLRzrpZm5SzU4PPZR5a2UmsdHzPprQpAisIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709040329; c=relaxed/simple;
	bh=LalD/cF8ER2QGrSSamZ0LcrPWPij47eqMs8pqC0hGZo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=SrNQIPRYZo8j6Uozq3Aj9J4KiiiQRTjtgEJI/5hsOe+E8oHuPwIygoseTLTYN3KPPg0JqTQfkH2z8VY3V2SkdK2u/bP4CMFAUGLaP2PVUV3hF/1ETd9UTsgFZn3ouj9f2qnKfnixlUeaRwJN/nodaZ68yGdXNF4zhmC/bfEdu80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hKJ7ztT7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41RDNHQ4018871;
	Tue, 27 Feb 2024 13:25:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=l73Um2k+xIDmUDZDQ+01dABYhKtHgm6tZjAs+ByVLzk=;
 b=hKJ7ztT7BBJz5Tfs60llFnLb2NbSJPIpXML7O8dvpvxFROuuUAVYXUDsRUySOP1Z9ZIt
 EnxOyF+L2EJ/1jD+UIHtAj2WlPEwgX0UZvR/YDk+lTdaXzO0ngVpNWGl+Su6eCTNuNMO
 WE6Ip9eTlUQLf57Z5DxnB4BeuKOIQan3SFcONJTe+zFEbsltjbKNFirA5K7Ht/jfGyxs
 FADgez+KpxKBm1OEkNNqGU0mybUYS+/iLDIqq42LUwTxVmx2f+7qFJgZybrpvXHSwnv7
 vxt0VnqDvt74mdH1KvJ7cd6T3qdCFR6W03rXTIdEqXVFfGOxQigpFWzTzu3o2S1YGu3u Xg== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3whg9d8p0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 13:25:26 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41RBcNdm012328;
	Tue, 27 Feb 2024 13:25:25 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wfwg27c1c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 13:25:25 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41RDPMWW44237204
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 13:25:25 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A84F35804E;
	Tue, 27 Feb 2024 13:25:22 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED64658064;
	Tue, 27 Feb 2024 13:25:21 +0000 (GMT)
Received: from [9.61.171.103] (unknown [9.61.171.103])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Feb 2024 13:25:21 +0000 (GMT)
Message-ID: <3b5a812d-3832-6f34-a528-c67e59d76e65@linux.ibm.com>
Date: Tue, 27 Feb 2024 08:25:21 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] s390/vfio-ap: handle hardware checkstop state on queue
 reset operation
From: "Jason J. Herne" <jjherne@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, akrowiak@linux.ibm.com,
        borntraeger@de.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com
References: <20240215153144.14747-1-jjherne@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20240215153144.14747-1-jjherne@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BTLB_ajivKs51ie7Tr4wUmVk1P6WtsAi
X-Proofpoint-ORIG-GUID: BTLB_ajivKs51ie7Tr4wUmVk1P6WtsAi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 clxscore=1015 mlxscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402270103

Polite Ping :)

Patch already has R-b.
Thanks for taking a look.

On 2/15/24 10:31 AM, Jason J. Herne wrote:
> Update vfio_ap_mdev_reset_queue() to handle an unexpected checkstop (hardware error) the
> same as the deconfigured case. This prevents unexpected and unhelpful warnings in the
> event of a hardware error.
> 
> We also stop lying about a queue's reset response code. This was originally done so we
> could force vfio_ap_mdev_filter_matrix to pass a deconfigured device through to the guest
> for the hotplug scenario. vfio_ap_mdev_filter_matrix is instead modified to allow
> passthrough for all queues with reset state normal, deconfigured, or checkstopped. In the
> checkstopped case we choose to pass the device through and let the error state be
> reflected at the guest level.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>
> ---
>   drivers/s390/crypto/vfio_ap_ops.c | 35 ++++++++++++++++---------------
>   1 file changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 983b3b16196c..fc169bc61593 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -659,6 +659,21 @@ static bool vfio_ap_mdev_filter_cdoms(struct ap_matrix_mdev *matrix_mdev)
>   			     AP_DOMAINS);
>   }
>   
> +static bool _queue_passable(struct vfio_ap_queue *q)
> +{
> +	if (!q)
> +		return false;
> +
> +	switch (q->reset_status.response_code) {
> +	case AP_RESPONSE_NORMAL:
> +	case AP_RESPONSE_DECONFIGURED:
> +	case AP_RESPONSE_CHECKSTOPPED:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>   /*
>    * vfio_ap_mdev_filter_matrix - filter the APQNs assigned to the matrix mdev
>    *				to ensure no queue devices are passed through to
> @@ -687,7 +702,6 @@ static bool vfio_ap_mdev_filter_matrix(struct ap_matrix_mdev *matrix_mdev,
>   	unsigned long apid, apqi, apqn;
>   	DECLARE_BITMAP(prev_shadow_apm, AP_DEVICES);
>   	DECLARE_BITMAP(prev_shadow_aqm, AP_DOMAINS);
> -	struct vfio_ap_queue *q;
>   
>   	bitmap_copy(prev_shadow_apm, matrix_mdev->shadow_apcb.apm, AP_DEVICES);
>   	bitmap_copy(prev_shadow_aqm, matrix_mdev->shadow_apcb.aqm, AP_DOMAINS);
> @@ -716,8 +730,7 @@ static bool vfio_ap_mdev_filter_matrix(struct ap_matrix_mdev *matrix_mdev,
>   			 * hardware device.
>   			 */
>   			apqn = AP_MKQID(apid, apqi);
> -			q = vfio_ap_mdev_get_queue(matrix_mdev, apqn);
> -			if (!q || q->reset_status.response_code) {
> +			if (!_queue_passable(vfio_ap_mdev_get_queue(matrix_mdev, apqn))) {
>   				clear_bit_inv(apid, matrix_mdev->shadow_apcb.apm);
>   
>   				/*
> @@ -1691,6 +1704,7 @@ static int apq_status_check(int apqn, struct ap_queue_status *status)
>   	switch (status->response_code) {
>   	case AP_RESPONSE_NORMAL:
>   	case AP_RESPONSE_DECONFIGURED:
> +	case AP_RESPONSE_CHECKSTOPPED:
>   		return 0;
>   	case AP_RESPONSE_RESET_IN_PROGRESS:
>   	case AP_RESPONSE_BUSY:
> @@ -1747,14 +1761,6 @@ static void apq_reset_check(struct work_struct *reset_work)
>   				memcpy(&q->reset_status, &status, sizeof(status));
>   				continue;
>   			}
> -			/*
> -			 * When an AP adapter is deconfigured, the
> -			 * associated queues are reset, so let's set the
> -			 * status response code to 0 so the queue may be
> -			 * passed through (i.e., not filtered)
> -			 */
> -			if (status.response_code == AP_RESPONSE_DECONFIGURED)
> -				q->reset_status.response_code = 0;
>   			if (q->saved_isc != VFIO_AP_ISC_INVALID)
>   				vfio_ap_free_aqic_resources(q);
>   			break;
> @@ -1781,12 +1787,7 @@ static void vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
>   		queue_work(system_long_wq, &q->reset_work);
>   		break;
>   	case AP_RESPONSE_DECONFIGURED:
> -		/*
> -		 * When an AP adapter is deconfigured, the associated
> -		 * queues are reset, so let's set the status response code to 0
> -		 * so the queue may be passed through (i.e., not filtered).
> -		 */
> -		q->reset_status.response_code = 0;
> +	case AP_RESPONSE_CHECKSTOPPED:
>   		vfio_ap_free_aqic_resources(q);
>   		break;
>   	default:

