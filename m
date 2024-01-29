Return-Path: <linux-kernel+bounces-43003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 153298409F8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 421391C22CB3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25A1153BCD;
	Mon, 29 Jan 2024 15:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YDybLPvy"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8B0154426;
	Mon, 29 Jan 2024 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706542230; cv=none; b=JULZaTvxFOVQiApnxNDPsFHPXpeIx3EIpDQx6BNQYJhZIy/r9BKqhbVwH3RPCUe62WI8glzeN9m4XucmKiVMSNpHZE4Bn2aQ1wF9HsBddN2fXHRf4lw81/CyrDBknMyaNE3uYSaKSgSk1y3pbHAirOqFvRs6H0+gIxyOAl9fEzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706542230; c=relaxed/simple;
	bh=ADOUcfO9BAXK+ArTQf4CiioOi/GC2wmgYUYgnqHW5M4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RP7kKwU/8YUp9U8R+vmx7jw6W5M0DUsoBgUgtxHW7qicKkzkZrpMMZWH4rDEX4Iu3g2Q8wcHTJ/EF+1qqnE1EjDappwuqPjkvHoB55B0YPVKz/Qmn13DmM4mCmOIXuF93RBDDlFVBzExXmGLZrAaF1VZQ8nzlp2TpSl0+FZh1KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YDybLPvy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40TFI6i0027879;
	Mon, 29 Jan 2024 15:30:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=FMoN6Y3mzid3UaSKiL5CP2GkuvxfysV43zj3BH+tO7o=;
 b=YDybLPvyaUvkg43MkAJuRjF25NkyFBY3oPnChzax0AqH7+d9OGpZ2MYkVcSs+MU36fBR
 7n/MIGgbqDpAUy5u1qNfwaxwIRvbetkiWoelaJEcQwVoisrmJ8RMlN4Y9Z3Ye5T2diWa
 Kp5EJRprVz6wHaV7UylF/rR2qMUbJQOM2cM1xOveqHwY66VQS8t3xFPqT8XIwIT+SUZx
 pinkbAeAoXKNtsxAyTB07fof1chwustEE122T4qgMV8HphjWdiiIN5+RZY/tPQfouMZ0
 sy+eAX0nnRFoCiEEHG5UV4MzJj+jKZ39D6DdfWAdJTS1jYfUatKL1v4hZtdsUA7GN7Wa ZQ== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vxehg0dpj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 15:30:27 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40TERm5r017755;
	Mon, 29 Jan 2024 15:30:26 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vwchyh69r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 15:30:26 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40TFUP9010289886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 15:30:25 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FB0D58061;
	Mon, 29 Jan 2024 15:30:25 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C5965803F;
	Mon, 29 Jan 2024 15:30:24 +0000 (GMT)
Received: from [9.61.175.71] (unknown [9.61.175.71])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 29 Jan 2024 15:30:24 +0000 (GMT)
Message-ID: <b6baa132-7a32-4ce5-bb30-1b0773d801ae@linux.ibm.com>
Date: Mon, 29 Jan 2024 10:30:24 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] s390/vfio-ap: Add sysfs attr, queue_configuration, to
 export mdev state
Content-Language: en-US
To: "Jason J. Herne" <jjherne@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com
References: <20240126143533.14043-1-jjherne@linux.ibm.com>
 <20240126143533.14043-3-jjherne@linux.ibm.com>
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20240126143533.14043-3-jjherne@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: P3BIuFMIr7W2DfNwGoKuVloKz_pYF2rL
X-Proofpoint-ORIG-GUID: P3BIuFMIr7W2DfNwGoKuVloKz_pYF2rL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_10,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 mlxscore=0 priorityscore=1501 phishscore=0 impostorscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401290113

Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>

On 1/26/24 9:35 AM, Jason J. Herne wrote:
> Add ap_config sysfs attribute. This will provide the means for
> setting or displaying the adapters, domains and control domains assigned
> to the vfio-ap mediated device in a single operation. This sysfs
> attribute is comprised of three masks: One for adapters, one for domains,
> and one for control domains.
>
> This attribute is intended to be used by mdevctl to query a vfio-ap
> mediated device's state.
>
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> ---
>   drivers/s390/crypto/vfio_ap_ops.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
>
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 243d252bc631..96293683b939 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -1508,6 +1508,32 @@ static ssize_t guest_matrix_show(struct device *dev,
>   }
>   static DEVICE_ATTR_RO(guest_matrix);
>   
> +static ssize_t write_ap_bitmap(unsigned long *bitmap, char *buf, int offset, char sep)
> +{
> +	return sysfs_emit_at(buf, offset, "0x%016lx%016lx%016lx%016lx%c",
> +			 bitmap[0], bitmap[1], bitmap[2], bitmap[3], sep);
> +}
> +
> +static ssize_t ap_config_show(struct device *dev, struct device_attribute *attr,
> +			      char *buf)
> +{
> +	struct ap_matrix_mdev *matrix_mdev = dev_get_drvdata(dev);
> +	int idx = 0;
> +
> +	idx += write_ap_bitmap(matrix_mdev->matrix.apm, buf, idx, ',');
> +	idx += write_ap_bitmap(matrix_mdev->matrix.aqm, buf, idx, ',');
> +	idx += write_ap_bitmap(matrix_mdev->matrix.adm, buf, idx, '\n');
> +
> +	return idx;
> +}
> +
> +static ssize_t ap_config_store(struct device *dev, struct device_attribute *attr,
> +			       const char *buf, size_t count)
> +{
> +	return count;
> +}
> +static DEVICE_ATTR_RW(ap_config);
> +
>   static struct attribute *vfio_ap_mdev_attrs[] = {
>   	&dev_attr_assign_adapter.attr,
>   	&dev_attr_unassign_adapter.attr,
> @@ -1515,6 +1541,7 @@ static struct attribute *vfio_ap_mdev_attrs[] = {
>   	&dev_attr_unassign_domain.attr,
>   	&dev_attr_assign_control_domain.attr,
>   	&dev_attr_unassign_control_domain.attr,
> +	&dev_attr_ap_config.attr,
>   	&dev_attr_control_domains.attr,
>   	&dev_attr_matrix.attr,
>   	&dev_attr_guest_matrix.attr,

