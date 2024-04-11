Return-Path: <linux-kernel+bounces-140679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 507148A17B0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05A17283188
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5770D13AC5;
	Thu, 11 Apr 2024 14:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lAjalIOl"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349A110A12;
	Thu, 11 Apr 2024 14:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712846495; cv=none; b=NE9yD6bqzPbZND4ucAkNyVFT8mLnUd3UhrB55wnuxkeFnWb9W6fxbqj969rgxmm35YBAwVn9Kh9Rci1+ZbfnHSBMR+S3/n3O92B7pOuyZJJIMHyKyAIQxlAP2P0U5ueoq3t3nD5wf4+dUMP7dMwvW7HOLM8htewmzJyABjgAcGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712846495; c=relaxed/simple;
	bh=xDk5x1X48y95x13b69amPcrAqPG1labPWCD+8T/o+oU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eYOWbBWURcrAwscsHA/TZ7ApmWHHOKuRAhWOWAIXH6ffbMbgekyw1ZtE14U+eorLsD3mqweSni8NzM1YCciRoECwhF1vBi3JKV1O+L//5HvqhNoCLhVA80XARyoURQdOATIIIUoUAlc9wZQoR6p/as8JfIF56w9YdHe4L1oVYFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lAjalIOl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43BCKRL6015078;
	Thu, 11 Apr 2024 14:41:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=9sWfzGlrxfAUEiU/5ARVQ5E8T5RbLqXOTBDK4jDrjGA=; b=lA
	jalIOlIpMgzjU6EhgPDMslKtWRghoEJK2OAAwvbQgie3w+NOrCRSaaPTSevMJYah
	vVZHwDplZBkzuN0idTyAMgwXiyqkZ0Iekrw6Q+KJThDQw6fYObttasdyykMO/Nt0
	QmrolaPV3+Ez/JlnXQ0J2g6+L/kjrGW4a46ZmZOcwvHd3IBOSFlEYNVqlEuzkXwK
	oAgP/PJ4eD10vf64MPjsU1h+2sf/FJQrWrTmyN426w/g0OWBVdeatpgaa8iKqeEn
	5UR+JwItUiDgi++l9TwAQAg+t6zsyt0fIMcsR79PXs8TIVkNI2H5sssn5rWNZtv0
	a0qYIVAG2UKyDmk1sb6w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xebqx9f5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 14:41:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43BEfUrY018031
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 14:41:30 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 11 Apr
 2024 07:41:29 -0700
Message-ID: <ff04d11a-f5b5-6561-ef32-f85ccfe14f21@quicinc.com>
Date: Thu, 11 Apr 2024 08:41:29 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2 1/2] bus: mhi: host: Add sysfs entry to force device to
 enter EDL
Content-Language: en-US
To: Qiang Yu <quic_qianyu@quicinc.com>, <mani@kernel.org>
CC: <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_cang@quicinc.com>,
        <quic_mrana@quicinc.com>
References: <1712805329-46158-1-git-send-email-quic_qianyu@quicinc.com>
 <1712805329-46158-2-git-send-email-quic_qianyu@quicinc.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <1712805329-46158-2-git-send-email-quic_qianyu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Q0bSFpRyWnvBdigvW0v-B1CMFghYYK7d
X-Proofpoint-ORIG-GUID: Q0bSFpRyWnvBdigvW0v-B1CMFghYYK7d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_08,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 suspectscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404110107

On 4/10/2024 9:15 PM, Qiang Yu wrote:
> Add sysfs entry to allow users of MHI bus force device to enter EDL.
> Considering that the way to enter EDL mode varies from device to device and
> some devices even do not support EDL. Hence, add a callback edl_trigger in
> mhi controller as part of the sysfs entry to be invoked and MHI core will
> only create EDL sysfs entry for mhi controller that provides edl_trigger
> callback. All of the process a specific device required to enter EDL mode
> can be placed in this callback.
> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> ---
>   drivers/bus/mhi/host/init.c | 35 +++++++++++++++++++++++++++++++++++
>   include/linux/mhi.h         |  1 +

No update to Documentation/ABI/stable/sysfs-bus-mhi ?

>   2 files changed, 36 insertions(+)
> 
> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
> index 44f9349..333ac94 100644
> --- a/drivers/bus/mhi/host/init.c
> +++ b/drivers/bus/mhi/host/init.c
> @@ -127,6 +127,32 @@ static ssize_t soc_reset_store(struct device *dev,
>   }
>   static DEVICE_ATTR_WO(soc_reset);
>   
> +static ssize_t force_edl_store(struct device *dev,
> +			       struct device_attribute *attr,
> +			       const char *buf, size_t count)
> +{
> +	struct mhi_device *mhi_dev = to_mhi_device(dev);
> +	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
> +	unsigned long val;
> +	int ret;
> +
> +	ret = kstrtoul(buf, 10, &val);
> +	if (ret < 0) {
> +		dev_err(dev, "Could not parse string: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (!val)
> +		return count;
> +
> +	ret = mhi_cntrl->edl_trigger(mhi_cntrl);
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +static DEVICE_ATTR_WO(force_edl);
> +
>   static struct attribute *mhi_dev_attrs[] = {
>   	&dev_attr_serial_number.attr,
>   	&dev_attr_oem_pk_hash.attr,
> @@ -1018,6 +1044,12 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
>   	if (ret)
>   		goto err_release_dev;
>   
> +	if (mhi_cntrl->edl_trigger) {
> +		ret = sysfs_create_file(&mhi_dev->dev.kobj, &dev_attr_force_edl.attr);
> +		if (ret)
> +			goto err_release_dev;
> +	}
> +
>   	mhi_cntrl->mhi_dev = mhi_dev;
>   
>   	mhi_create_debugfs(mhi_cntrl);
> @@ -1051,6 +1083,9 @@ void mhi_unregister_controller(struct mhi_controller *mhi_cntrl)
>   	mhi_deinit_free_irq(mhi_cntrl);
>   	mhi_destroy_debugfs(mhi_cntrl);
>   
> +	if (mhi_cntrl->edl_trigger)
> +		sysfs_remove_file(&mhi_dev->dev.kobj, &dev_attr_force_edl.attr);
> +
>   	destroy_workqueue(mhi_cntrl->hiprio_wq);
>   	kfree(mhi_cntrl->mhi_cmd);
>   	kfree(mhi_cntrl->mhi_event);
> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
> index cde01e1..8db56d7 100644
> --- a/include/linux/mhi.h
> +++ b/include/linux/mhi.h
> @@ -435,6 +435,7 @@ struct mhi_controller {
>   	void (*write_reg)(struct mhi_controller *mhi_cntrl, void __iomem *addr,
>   			  u32 val);
>   	void (*reset)(struct mhi_controller *mhi_cntrl);
> +	int (*edl_trigger)(struct mhi_controller *mhi_cntrl);

No update to the documentation for this struct?



