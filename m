Return-Path: <linux-kernel+bounces-99351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 841EF87871B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB05028167E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E7953819;
	Mon, 11 Mar 2024 18:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eFuoWzGV"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C075D3BB29;
	Mon, 11 Mar 2024 18:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710180945; cv=none; b=i3jHdduU41GJnbwrlu1/bvyhHSwlIofMYTGYI0lSvCmuRqNGeIMBFGTOTD9/bHDUcj3Lpw7vG+iRP4BQyoGIEVevnK5arxi/if5iUZTrx1Nry3wk41NRyb82vixOTGkVQwiBrTgcyKdSUTgIK5IMLxlhmL0LCbp1Z7AO4TyJlI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710180945; c=relaxed/simple;
	bh=KiDv1YYSDek2uDTyFZnCg9alxLJ7vbm4DEJwqRsYRFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kj98U9lRczSyym0QxlFcV1veeEjtMXhuHR/psaD408k+NfcpMIbIrstHSUEHHpshVVHdjP4LgbCXMHVV0LefFQSezdNrGwtX6iqkjWkLIferZvQvaTjg85Ti5Grxhpzy31Vz1EBXNwpmiDtBUNp0r2xh8fRExNBSAI8RT1bZ9Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eFuoWzGV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42BI0Rmv012781;
	Mon, 11 Mar 2024 18:15:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=kaxqx2bkBJWILw3UWZdF8GUlds++zvf3GmLgcvyUvgY=;
 b=eFuoWzGV05c1c4tLTig5fofL1l7OhYRhyLoR/iL41dKujFEUxB7fzpD+8zrAFvq210rV
 7NFIHtgzV98Xd5Kcq2HEpjmoHUbW4spCrKQ1UCHkwNxyi2/EbluxXzVOgw69tMbGBAm8
 Qa6U+DTSCj4X+lj1pJREXVjAkkkWXPSnfbV48fcHfPTBfRrPMKAnCt4i0LxbaWddmuQU
 sk/x7hYyo443gmoA3Kq5uq2l++Ga6STVKj8imMWIBJBq+fJumMYivkIo4lnHHz+W8AZ6
 HTCFOJQNbi5WHzmbf7Ro4Iz+FbwF5njH2s2HeeSMfA/VJeQkIwA/BYAw6TU69pYOFc5r Eg== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wt6ux89g5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 18:15:40 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42BFxEo5015485;
	Mon, 11 Mar 2024 18:15:39 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ws2fyjckg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 18:15:39 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42BIFaUt14090812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 18:15:38 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FE3358065;
	Mon, 11 Mar 2024 18:15:36 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCF4A58056;
	Mon, 11 Mar 2024 18:15:35 +0000 (GMT)
Received: from [9.61.27.161] (unknown [9.61.27.161])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 Mar 2024 18:15:35 +0000 (GMT)
Message-ID: <0389f521-e9e2-43d4-8d78-87695853a536@linux.ibm.com>
Date: Mon, 11 Mar 2024 14:15:35 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] s390/vfio-ap: Add write support to sysfs attr
 ap_config
Content-Language: en-US
To: "Jason J. Herne" <jjherne@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, borntraeger@de.ibm.com,
        agordeev@linux.ibm.com, gor@linux.ibm.com
References: <20240306140843.10782-1-jjherne@linux.ibm.com>
 <20240306140843.10782-5-jjherne@linux.ibm.com>
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20240306140843.10782-5-jjherne@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: l7r5iZOPwMCMEG3-ZZHlHi3LeUipomrk
X-Proofpoint-ORIG-GUID: l7r5iZOPwMCMEG3-ZZHlHi3LeUipomrk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_10,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 impostorscore=0 mlxscore=0
 clxscore=1015 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2403110139


On 3/6/24 9:08 AM, Jason J. Herne wrote:
> Allow writing a complete set of masks to ap_config. Doing so will
> cause the vfio-ap driver to replace the vfio-ap mediated device's entire
> state with the given set of masks. If the given state cannot be set, then


Just a nit, but it will not replace the vfio_ap mdev's entire state; it 
will replace the masks that comprise the matrix and control_domain 
attributes which comprise the guest's AP configuration profile (or the 
masks identifying the adapters, domains and control domains which a 
guest has permission to access). The guest_matrix attribute may or may 
not match the masks written via this sysfs interface.


> no changes are made to the vfio-ap mediated device.
>
> The format of the data written to ap_config is as follows:
> {amask},{dmask},{cmask}\n
>
> \n is a newline character.
>
> amask, dmask, and cmask are masks identifying which adapters, domains,
> and control domains should be assigned to the mediated device.
>
> The format of a mask is as follows:
> 0xNN..NN
>
> Where NN..NN is 64 hexadecimal characters representing a 256-bit value.
> The leftmost (highest order) bit represents adapter/domain 0.


I won't reject giving an r-b for the above, but could be more 
informative; maybe more along the lines of how this is described in all 
documentation:


Where NN..NN is 64 hexadecimal characters comprising a bitmap containing 
256 bits. Each bit, from left

to right, corresponds to a number from 0 to 255. If a bit is set, the

corresponding adapter, domain or control domain is assigned to the 
vfio_ap mdev.

You could also mention that setting an adapter or domain number greater 
than the maximum allowed for

for the system will result in an error.


>
> For an example set of masks that represent your mdev's current
> configuration, simply cat ap_config.
>
> This attribute is intended to be used by an mdevctl callout script
> supporting the mdev type vfio_ap-passthrough to atomically update a
> vfio-ap mediated device's state.
>
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> ---
>   drivers/s390/crypto/vfio_ap_ops.c     | 172 ++++++++++++++++++++++++--
>   drivers/s390/crypto/vfio_ap_private.h |   6 +-
>   2 files changed, 162 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 259130347d00..c382e46f620f 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -1106,19 +1106,22 @@ static void vfio_ap_mdev_unlink_adapter(struct ap_matrix_mdev *matrix_mdev,
>   	}
>   }
>   
> -static void vfio_ap_mdev_hot_unplug_adapter(struct ap_matrix_mdev *matrix_mdev,
> -					    unsigned long apid)
> +static void vfio_ap_mdev_hot_unplug_adapters(struct ap_matrix_mdev *matrix_mdev,
> +					    unsigned long *apids)
>   {
>   	struct vfio_ap_queue *q, *tmpq;
>   	struct list_head qlist;
> +	unsigned long apid;
>   
>   	INIT_LIST_HEAD(&qlist);
> -	vfio_ap_mdev_unlink_adapter(matrix_mdev, apid, &qlist);
>   
> -	if (test_bit_inv(apid, matrix_mdev->shadow_apcb.apm)) {
> -		clear_bit_inv(apid, matrix_mdev->shadow_apcb.apm);
> -		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
> +	for_each_set_bit_inv(apid, apids, AP_DEVICES) {
> +		vfio_ap_mdev_unlink_adapter(matrix_mdev, apid, &qlist);
> +
> +		if (test_bit_inv(apid, matrix_mdev->shadow_apcb.apm))
> +			clear_bit_inv(apid, matrix_mdev->shadow_apcb.apm);
>   	}
> +	vfio_ap_mdev_update_guest_apcb(matrix_mdev);


I wouldn't do the hot plug unless at least one of the APIDs in the apids 
parameter is assigned to matrix_mdev->shadow_apcb. The 
vfio_ap_mdev_update_guest_apcb function calls the 
kvm_arch_crypto_set_masks function which takes the guest's VCPUs out of 
SIE, copies the apm/aqm/adm from matrix_mdev->shadow_apcb to the APCB in 
the SIE state description, then restores the VCPUs to SIE. If no changes 
have been made to matrix_mdev->shadow_apcb, then it doesn't make sense 
to impact the guest in such a manner. So maybe something like this:

if (bitmap_intersects(apids, matrix_mdev->shadow_apcb.apm, AP_DEVICES))

         vfio_ap_mdev_update_guest_apcb(matrix_mdev)



>   
>   	vfio_ap_mdev_reset_qlist(&qlist);
>   
> @@ -1128,6 +1131,15 @@ static void vfio_ap_mdev_hot_unplug_adapter(struct ap_matrix_mdev *matrix_mdev,
>   	}
>   }
>   
> +static void vfio_ap_mdev_hot_unplug_adapter(struct ap_matrix_mdev *matrix_mdev,
> +					    unsigned long apid)
> +{
> +	DECLARE_BITMAP(apids, AP_DEVICES);


I'm not sure about this, but should the apids bitmap be zeroed out?

memset(apids, 0, sizeof(apids));


> +
> +	set_bit_inv(apid, apids);
> +	vfio_ap_mdev_hot_unplug_adapters(matrix_mdev, apids);
> +}
> +
>   /**
>    * unassign_adapter_store - parses the APID from @buf and clears the
>    * corresponding bit in the mediated matrix device's APM
> @@ -1288,19 +1300,22 @@ static void vfio_ap_mdev_unlink_domain(struct ap_matrix_mdev *matrix_mdev,
>   	}
>   }
>   
> -static void vfio_ap_mdev_hot_unplug_domain(struct ap_matrix_mdev *matrix_mdev,
> -					   unsigned long apqi)
> +static void vfio_ap_mdev_hot_unplug_domains(struct ap_matrix_mdev *matrix_mdev,
> +					   unsigned long *apqis)
>   {
>   	struct vfio_ap_queue *q, *tmpq;
>   	struct list_head qlist;
> +	unsigned long apqi;
>   
>   	INIT_LIST_HEAD(&qlist);
> -	vfio_ap_mdev_unlink_domain(matrix_mdev, apqi, &qlist);
>   
> -	if (test_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm)) {
> -		clear_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm);
> -		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
> +	for_each_set_bit_inv(apqi, apqis, AP_DOMAINS) {
> +		vfio_ap_mdev_unlink_domain(matrix_mdev, apqi, &qlist);
> +
> +		if (test_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm))
> +			clear_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm);
>   	}
> +	vfio_ap_mdev_update_guest_apcb(matrix_mdev);


Same comment here as for vfio_ap_mdev_hot_unplug_adapters function.


>   
>   	vfio_ap_mdev_reset_qlist(&qlist);
>   
> @@ -1310,6 +1325,15 @@ static void vfio_ap_mdev_hot_unplug_domain(struct ap_matrix_mdev *matrix_mdev,
>   	}
>   }
>   
> +static void vfio_ap_mdev_hot_unplug_domain(struct ap_matrix_mdev *matrix_mdev,
> +					   unsigned long apqi)
> +{
> +	DECLARE_BITMAP(apqis, AP_DOMAINS);


See comment/question in vfio_ap_mdev_hot_unplug_adapter function.


> +
> +	set_bit_inv(apqi, apqis);
> +	vfio_ap_mdev_hot_unplug_domains(matrix_mdev, apqis);
> +}
> +
>   /**
>    * unassign_domain_store - parses the APQI from @buf and clears the
>    * corresponding bit in the mediated matrix device's AQM
> @@ -1577,10 +1601,132 @@ static ssize_t ap_config_show(struct device *dev, struct device_attribute *attr,
>   	return idx;
>   }
>   
> +/* Number of characters needed for a complete hex mask representing the bits in ..  */
> +#define AP_DEVICES_STRLEN	(AP_DEVICES/4 + 3)
> +#define AP_DOMAINS_STRLEN	(AP_DOMAINS/4 + 3)
> +#define AP_CONFIG_STRLEN	(AP_DEVICES_STRLEN + 2 * AP_DOMAINS_STRLEN)
> +
> +static int parse_bitmap(char **strbufptr, unsigned long *bitmap, int nbits)
> +{
> +	char *curmask;
> +
> +	curmask = strsep(strbufptr, ",\n");
> +	if (!curmask)
> +		return -EINVAL;
> +
> +	bitmap_clear(bitmap, 0, nbits);
> +	return ap_hex2bitmap(curmask, bitmap, nbits);
> +}
> +
> +static int ap_matrix_length_check(struct ap_matrix_mdev *matrix_mdev)


We're not really checking the matrix length here, we're checking whether 
any set bits exceed that maximum value, so maybe something like:

ap_matrix_max_bitnum_check(struct ap_matrix_mdev *matrix_mdev)?

Not critical though.


> +{
> +	unsigned long bit;
> +
> +	for_each_set_bit_inv(bit, matrix_mdev->matrix.apm, AP_DEVICES) {
> +		if (bit > matrix_mdev->matrix.apm_max)
> +			return -ENODEV;
> +	}
> +
> +	for_each_set_bit_inv(bit, matrix_mdev->matrix.aqm, AP_DOMAINS) {
> +		if (bit > matrix_mdev->matrix.aqm_max)
> +			return -ENODEV;
> +	}
> +
> +	for_each_set_bit_inv(bit, matrix_mdev->matrix.adm, AP_DOMAINS) {
> +		if (bit > matrix_mdev->matrix.adm_max)
> +			return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +static void ap_matrix_copy(struct ap_matrix *dst, struct ap_matrix *src)
> +{
> +	bitmap_copy(dst->apm, src->apm, AP_DEVICES);
> +	bitmap_copy(dst->aqm, src->aqm, AP_DOMAINS);
> +	bitmap_copy(dst->adm, src->adm, AP_DOMAINS);
> +}
> +
>   static ssize_t ap_config_store(struct device *dev, struct device_attribute *attr,
>   			       const char *buf, size_t count)
>   {
> -	return count;
> +	struct ap_matrix_mdev *matrix_mdev = dev_get_drvdata(dev);
> +	struct ap_matrix m_new, m_old, m_added, m_removed;
> +	DECLARE_BITMAP(apm_filtered, AP_DEVICES);
> +	unsigned long newbit;
> +	char *newbuf, *rest;
> +	int rc = count;
> +	bool do_update;
> +
> +	newbuf = rest = kstrndup(buf, AP_CONFIG_STRLEN, GFP_KERNEL);
> +	if (!newbuf)
> +		return -ENOMEM;
> +
> +	mutex_lock(&ap_perms_mutex);
> +	get_update_locks_for_mdev(matrix_mdev);
> +
> +	/* Save old state */
> +	ap_matrix_copy(&m_old, &matrix_mdev->matrix);
> +
> +	if (parse_bitmap(&rest, m_new.apm, AP_DEVICES) ||
> +	    parse_bitmap(&rest, m_new.aqm, AP_DOMAINS) ||
> +	    parse_bitmap(&rest, m_new.adm, AP_DOMAINS)) {
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +
> +	bitmap_andnot(m_removed.apm, m_old.apm, m_new.apm, AP_DEVICES);
> +	bitmap_andnot(m_removed.aqm, m_old.aqm, m_new.aqm, AP_DOMAINS);
> +	bitmap_andnot(m_added.apm, m_new.apm, m_old.apm, AP_DEVICES);
> +	bitmap_andnot(m_added.aqm, m_new.aqm, m_old.aqm, AP_DOMAINS);
> +
> +	/* Need new bitmaps in matrix_mdev for validation */
> +	ap_matrix_copy(&matrix_mdev->matrix, &m_new);
> +
> +	/* Ensure new state is valid, else undo new state */
> +	rc = vfio_ap_mdev_validate_masks(matrix_mdev);
> +	if (rc) {
> +		ap_matrix_copy(&matrix_mdev->matrix, &m_old);
> +		goto out;
> +	}
> +	rc = ap_matrix_length_check(matrix_mdev);
> +	if (rc) {
> +		ap_matrix_copy(&matrix_mdev->matrix, &m_old);
> +		goto out;
> +	}
> +	rc = count;
> +
> +	/* Need old bitmaps in matrix_mdev for unplug/unlink */
> +	ap_matrix_copy(&matrix_mdev->matrix, &m_old);
> +
> +	/* Unlink removed adapters/domains */
> +	vfio_ap_mdev_hot_unplug_adapters(matrix_mdev, m_removed.apm);
> +	vfio_ap_mdev_hot_unplug_domains(matrix_mdev, m_removed.aqm);
> +
> +	/* Need new bitmaps in matrix_mdev for linking new adapters/domains */
> +	ap_matrix_copy(&matrix_mdev->matrix, &m_new);
> +
> +	/* Link newly added adapters */
> +	for_each_set_bit_inv(newbit, m_added.apm, AP_DEVICES)
> +		vfio_ap_mdev_link_adapter(matrix_mdev, newbit);
> +
> +	for_each_set_bit_inv(newbit, m_added.aqm, AP_DOMAINS)
> +		vfio_ap_mdev_link_domain(matrix_mdev, newbit);
> +
> +	/* filter resources not bound to vfio-ap */
> +	do_update = vfio_ap_mdev_filter_matrix(matrix_mdev, apm_filtered);
> +	do_update |= vfio_ap_mdev_filter_cdoms(matrix_mdev);
> +
> +	/* Apply changes to shadow apbc if things changed */
> +	if (do_update) {
> +		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
> +		reset_queues_for_apids(matrix_mdev, apm_filtered);
> +	}
> +out:
> +	release_update_locks_for_mdev(matrix_mdev);
> +	mutex_unlock(&ap_perms_mutex);
> +	kfree(newbuf);
> +	return rc;
>   }
>   static DEVICE_ATTR_RW(ap_config);
>   
> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> index 98d37aa27044..437a161c8659 100644
> --- a/drivers/s390/crypto/vfio_ap_private.h
> +++ b/drivers/s390/crypto/vfio_ap_private.h
> @@ -75,11 +75,11 @@ extern struct ap_matrix_dev *matrix_dev;
>    */
>   struct ap_matrix {
>   	unsigned long apm_max;
> -	DECLARE_BITMAP(apm, 256);
> +	DECLARE_BITMAP(apm, AP_DEVICES);
>   	unsigned long aqm_max;
> -	DECLARE_BITMAP(aqm, 256);
> +	DECLARE_BITMAP(aqm, AP_DOMAINS);
>   	unsigned long adm_max;
> -	DECLARE_BITMAP(adm, 256);
> +	DECLARE_BITMAP(adm, AP_DOMAINS);
>   };
>   
>   /**

