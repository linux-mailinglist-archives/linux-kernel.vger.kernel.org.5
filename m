Return-Path: <linux-kernel+bounces-43532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 737DA841536
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 982AF1C22F78
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4C51586ED;
	Mon, 29 Jan 2024 21:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pnrnAnlh"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2232D266D4;
	Mon, 29 Jan 2024 21:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706564597; cv=none; b=t5TWi030otfnQY/WGz1j27dteNDtI6qaSfZHA31kBo19oIczGBCPrA4w9HAqnv2Rcdkmjo+j2NXP5E5kyO+chEQY6KwXLqPLTSs5cakNQwaLMrR5Ix4KyZJspTDcxtAicix2iK+EloQq+xH9+e+PfS3NYAyqXW9ckeQVDu67ACM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706564597; c=relaxed/simple;
	bh=SAOmxPzDc+sE9G3EeDzqt518C1eEy7mLea2BSQD64UM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tbgn5NJHuJEhooCEvCKVrYkGI0zHUCdWI4HQ+WSoptPm0d4QtHt0CzgHZ4sW4syGeUWjMkB7IbULxvD18heiT+tz4W/XvUMCi3M4qltwwqNHaIcIvuI0tonZd1gf9cGaO9+GB1SToLPbKxyit2c8E0mykDX1JMd0G3Mo7hEYd3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pnrnAnlh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40TKSG8K002637;
	Mon, 29 Jan 2024 21:43:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=MfRrJuiSQYvRqzpj8rRcJ6GIvALoJcr6YOZDS6F/WAg=;
 b=pnrnAnlhRN3MCl/E/4dzNQzY334dpbgJh7p8xs+e5kJFk1MkaWfzAQuOztIRs/g9ExeE
 +mNl4juKIHQWSs7hMQIj79gr0d9y/0jXPhA0IvzGAH7Ri1WEawVIb1VnUxCYMiV0Q2+5
 X4Nz/Mbxk8xqO6pjIE9vi5sOcpCqspWIQEOAxetxr13mizuHQ7PCHVpW6/p00BzAUqoi
 Sib/pVkrCK1bJT6/FNqgkDXPIyowBOJQQd+EQRRYHioSAFUYfIa2pIfYhjArvAXahypn
 TuSrio7IXS+YwPuV65nqBtWsem6/Q4BZtzGs7XA1DaNlHGoh3kaCg1U8bkoV+pskRkUe UA== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vxk30ssjw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 21:43:13 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40TL6XQP007979;
	Mon, 29 Jan 2024 21:43:13 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vwdnktq8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 21:43:13 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40TLhCh526280474
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 21:43:12 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3AC7A58056;
	Mon, 29 Jan 2024 21:43:12 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCC3D5803F;
	Mon, 29 Jan 2024 21:43:11 +0000 (GMT)
Received: from [9.61.175.71] (unknown [9.61.175.71])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 29 Jan 2024 21:43:11 +0000 (GMT)
Message-ID: <da7859ee-73af-4c3b-b1f7-c963dc2a5b5c@linux.ibm.com>
Date: Mon, 29 Jan 2024 16:43:11 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] s390/vfio-ap: Add write support to sysfs attr
 ap_config
Content-Language: en-US
To: "Jason J. Herne" <jjherne@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com
References: <20240126143533.14043-1-jjherne@linux.ibm.com>
 <20240126143533.14043-4-jjherne@linux.ibm.com>
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20240126143533.14043-4-jjherne@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SV2i_8ugMJmF90PGa976-gLiDPYe_E7F
X-Proofpoint-ORIG-GUID: SV2i_8ugMJmF90PGa976-gLiDPYe_E7F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_14,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 phishscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401290161


On 1/26/24 9:35 AM, Jason J. Herne wrote:
> Allow writing a complete set of masks to ap_config. Doing so will
> cause the vfio-ap driver to replace the vfio-ap mediated device's entire
> state with the given set of masks. If the given state cannot be set, then
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
> The format of a mask is	as follows:
> 0xNN..NN
>
> Where NN..NN is 64 hexadecimal characters representing a 256-bit value.
> The leftmost (highest order) bit represents adapter/domain 0.
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
>   Documentation/arch/s390/vfio-ap.rst   |  27 ++++
>   drivers/s390/crypto/vfio_ap_ops.c     | 188 +++++++++++++++++++++++---
>   drivers/s390/crypto/vfio_ap_private.h |   6 +-
>   3 files changed, 197 insertions(+), 24 deletions(-)


Maybe the following should be in its own patch since it is a doc change?


> diff --git a/Documentation/arch/s390/vfio-ap.rst b/Documentation/arch/s390/vfio-ap.rst
> index 929ee1c1c940..a94f13916dea 100644
> --- a/Documentation/arch/s390/vfio-ap.rst
> +++ b/Documentation/arch/s390/vfio-ap.rst
> @@ -380,6 +380,33 @@ matrix device.
>       control_domains:
>         A read-only file for displaying the control domain numbers assigned to the
>         vfio_ap mediated device.
> +    ap_config:
> +      A read/write file that, when written to, allows the entire vfio_ap mediated
> +      device's ap configuration to be replaced in one shot. Three masks are given,
> +      one for adapters, one for domains, and one for control domains. If the
> +      given state cannot be set, then no changes are made to the vfio-ap
> +      mediated device.
> +
> +      The format of the data written to ap_config is as follows:
> +      {amask},{dmask},{cmask}\n
> +
> +      \n is a newline character.
> +
> +      amask, dmask, and cmask are masks identifying which adapters, domains,
> +      and control domains should be assigned to the mediated device.
> +
> +      The format of a mask is as follows:
> +      0xNN..NN
> +
> +      Where NN..NN is 64 hexadecimal characters representing a 256-bit value.
> +      The leftmost (highest order) bit represents adapter/domain 0.
> +
> +      For an example set of masks that represent your mdev's current
> +      configuration, simply cat ap_config.
> +
> +      This attribute is intended to be used by automation. End users would be
> +      better served using the respective assign/unassign attributes for adapters
> +      and domains.


s/automation/tooling/ ?

s/for adapters and domains/for adapters, domains and control domains/


>   
>   * functions:
>   
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 96293683b939..5ad134c1d5e6 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -764,10 +764,11 @@ static int vfio_ap_mdev_probe(struct mdev_device *mdev)
>   static void vfio_ap_mdev_link_queue(struct ap_matrix_mdev *matrix_mdev,
>   				    struct vfio_ap_queue *q)
>   {
> -	if (q) {
> -		q->matrix_mdev = matrix_mdev;
> -		hash_add(matrix_mdev->qtable.queues, &q->mdev_qnode, q->apqn);
> -	}
> +	if (!q || vfio_ap_mdev_get_queue(matrix_mdev, q->apqn))
> +		return;
> +
> +	q->matrix_mdev = matrix_mdev;
> +	hash_add(matrix_mdev->qtable.queues, &q->mdev_qnode, q->apqn);
>   }


The above change has nothing to do with write support for the sysfs 
ap_config attribute. I suppose it could be considered an enhancement to 
ensure a queue that is already linked does not get re-linked, but the 
callers of this function all pass in a queue that has not yet been 
linked; either because it has just been probed or just assigned to the 
mdev. In any case, I don't think this change belongs in this patch.


>   
>   static void vfio_ap_mdev_link_apqn(struct ap_matrix_mdev *matrix_mdev, int apqn)
> @@ -1048,21 +1049,25 @@ static void vfio_ap_mdev_unlink_adapter(struct ap_matrix_mdev *matrix_mdev,
>   	}
>   }
>   
> -static void vfio_ap_mdev_hot_unplug_adapter(struct ap_matrix_mdev *matrix_mdev,
> -					    unsigned long apid)
> +static void vfio_ap_mdev_hot_unplug_adapters(struct ap_matrix_mdev *matrix_mdev,
> +					    unsigned long *apids)


The commits for the patch series created to reset queues removed from 
guest's AP configuration are now merged into our master branch and will 
pre-req this series. I've made note of the changes you will need to make 
herein to conform with the changes to the hot unplug functions you 
modified. You may want to take a look in any case because you may be 
able to take advantage - or not - of some other functions without having 
to modify these; for example;

staticintreset_queues_for_apids(structap_matrix_mdev*matrix_mdev,

unsignedlong*apm_reset)


>   {
> -	int loop_cursor;
> -	struct vfio_ap_queue *q;
>   	struct ap_queue_table *qtable = kzalloc(sizeof(*qtable), GFP_KERNEL);


The vfio_ap_queue struct now has a field for adding it to a list of 
queues that need to be reset, so this qtable is now defined:

structlist_headqlist;


> +	struct vfio_ap_queue *q;
> +	unsigned long apid;
> +	int loop_cursor;
>   
>   	hash_init(qtable->queues);
> -	vfio_ap_mdev_unlink_adapter(matrix_mdev, apid, qtable);
>   
> -	if (test_bit_inv(apid, matrix_mdev->shadow_apcb.apm)) {
> -		clear_bit_inv(apid, matrix_mdev->shadow_apcb.apm);
> -		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
> +	for_each_set_bit_inv(apid, apids, AP_DEVICES) {
> +		vfio_ap_mdev_unlink_adapter(matrix_mdev, apid, qtable);
> +
> +		if (test_bit_inv(apid, matrix_mdev->shadow_apcb.apm))
> +			clear_bit_inv(apid, matrix_mdev->shadow_apcb.apm);
>   	}
>   
> +	vfio_ap_mdev_update_guest_apcb(matrix_mdev);
> +
>   	vfio_ap_mdev_reset_queues(qtable);


The call here is now:

vfio_ap_mdev_reset_qlist(&qlist)


>   
>   	hash_for_each(qtable->queues, loop_cursor, q, mdev_qnode) {
> @@ -1073,6 +1078,15 @@ static void vfio_ap_mdev_hot_unplug_adapter(struct ap_matrix_mdev *matrix_mdev,
>   	kfree(qtable);
>   }
>   
> +static void vfio_ap_mdev_hot_unplug_adapter(struct ap_matrix_mdev *matrix_mdev,
> +					    unsigned long apid)
> +{
> +	DECLARE_BITMAP(apids, AP_DEVICES);
> +
> +	set_bit_inv(apid, apids);
> +	vfio_ap_mdev_hot_unplug_adapters(matrix_mdev, apids);
> +}
> +
>   /**
>    * unassign_adapter_store - parses the APID from @buf and clears the
>    * corresponding bit in the mediated matrix device's APM
> @@ -1235,21 +1249,24 @@ static void vfio_ap_mdev_unlink_domain(struct ap_matrix_mdev *matrix_mdev,
>   	}
>   }
>   
> -static void vfio_ap_mdev_hot_unplug_domain(struct ap_matrix_mdev *matrix_mdev,
> -					   unsigned long apqi)
> +static void vfio_ap_mdev_hot_unplug_domains(struct ap_matrix_mdev *matrix_mdev,
> +					   unsigned long *apqis)
>   {
> -	int loop_cursor;
> -	struct vfio_ap_queue *q;
>   	struct ap_queue_table *qtable = kzalloc(sizeof(*qtable), GFP_KERNEL);


The vfio_ap_queue struct now has a field for adding it to a list of 
queues that need to be reset, so this qtable is now defined:

structlist_headqlist;


> +	struct vfio_ap_queue *q;
> +	unsigned long apqi;
> +	int loop_cursor;
>   
>   	hash_init(qtable->queues);
> -	vfio_ap_mdev_unlink_domain(matrix_mdev, apqi, qtable);
>   
> -	if (test_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm)) {
> -		clear_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm);
> -		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
> +	for_each_set_bit_inv(apqi, apqis, AP_DOMAINS) {
> +		vfio_ap_mdev_unlink_domain(matrix_mdev, apqi, qtable);
> +
> +		if (test_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm))
> +			clear_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm);
>   	}
>   
> +	vfio_ap_mdev_update_guest_apcb(matrix_mdev);
>   	vfio_ap_mdev_reset_queues(qtable);


The call here is now:

vfio_ap_mdev_reset_qlist(&qlist)


>   
>   	hash_for_each(qtable->queues, loop_cursor, q, mdev_qnode) {
> @@ -1260,6 +1277,15 @@ static void vfio_ap_mdev_hot_unplug_domain(struct ap_matrix_mdev *matrix_mdev,
>   	kfree(qtable);
>   }
>   
> +static void vfio_ap_mdev_hot_unplug_domain(struct ap_matrix_mdev *matrix_mdev,
> +					   unsigned long apqi)
> +{
> +	DECLARE_BITMAP(apqis, AP_DOMAINS);
> +
> +	set_bit_inv(apqi, apqis);
> +	vfio_ap_mdev_hot_unplug_domains(matrix_mdev, apqis);
> +}
> +
>   /**
>    * unassign_domain_store - parses the APQI from @buf and clears the
>    * corresponding bit in the mediated matrix device's AQM
> @@ -1527,10 +1553,130 @@ static ssize_t ap_config_show(struct device *dev, struct device_attribute *attr,
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
> +		parse_bitmap(&rest, m_new.adm, AP_DOMAINS)) {
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +
> +	bitmap_andnot(m_removed.apm, m_old.apm, m_new.apm, AP_DEVICES);
> +	bitmap_andnot(m_removed.aqm, m_old.aqm, m_new.aqm, AP_DOMAINS);
> +	bitmap_andnot(m_added.apm, m_new.apm, m_old.apm, AP_DEVICES);
> +	bitmap_andnot(m_added.aqm, m_new.aqm, m_old.aqm, AP_DOMAINS);


Rather than copying m_new to matrix-mdev->matrix and then possibly 
having to restore it later, why not modify ap_matrix_length_check to 
take a struct ap_matrix and pass in the m_new. If that fails, you can 
bail out without going through the copying steps. Note that you can use 
the vfio_ap_matrix_init(matrix_dev->info, m_new) function to populate 
the apm_max, aqm_max and adm_max fields of the matrix, or you can pass 
in matrix_mdev->matrix and retrieve those values from there.


> +
> +	/* Need new bitmaps in matrix_mdev for validation */
> +	ap_matrix_copy(&matrix_mdev->matrix, &m_new);
> +
> +	/* Ensure new state is valid, else undo new state */
> +	rc = vfio_ap_mdev_validate_masks(matrix_mdev);


If you do what I suggested above, you can skip all of the copying below.


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


I'm wondering if it might eliminate a lot of code duplication if you 
made changes similar to what you did for the 
vfio_ap_mdev_hot_unplug_adapter/domain functions. Maybe you could 
refactor the code in vfio_ap_mdev_assign_adapter/domain_store functions 
into other functions and call them; for example, something like this?:

staticssize_tassign_adapters_store(struct ap_matrix_mdev *matrix_mdev, 
unsigned long *apids)

{

unsigned long apid;

ssize_t apids_set = 0;

for_each_set_bit_inv(apid, apids, AP_DEVICES) {

if(apid > matrix_mdev->matrix.apm_max)

?????? We may have successfully set one or more prior to this, so what 
do we do?

if(test_bit_inv(apid, matrix_mdev->matrix.apm)) {

apids_set += 1

continue;

}

set_bit_inv(apid, matrix_mdev->matrix.apm);

ret = vfio_ap_mdev_validate_masks(matrix_mdev);

if(ret) {

clear_bit_inv(apid, matrix_mdev->matrix.apm);

return 0;

}

vfio_ap_mdev_link_adapter(matrix_mdev, apid);

if(vfio_ap_mdev_filter_matrix(matrix_mdev, apm_filtered)) {

vfio_ap_mdev_update_guest_apcb(matrix_mdev);

reset_queues_for_apids(matrix_mdev, apm_filtered);

}

apids_set += 1;

}

ret = apids_set;

}


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
> +	do_update = vfio_ap_mdev_filter_matrix(matrix_mdev->matrix.apm,
> +				matrix_mdev->matrix.aqm, matrix_mdev);


If you decide to reject my suggestion above, you will need to make a 
change to the call to filter above. The vfio_ap_mdev_filter_matrix 
function has changed, so the call would look like this:

     DECLARE_BITMAP(apm_filtered, AP_DEVICES);

     vfio_ap_mdev_filter_matrix(matrix_mdev, apm_filtered);

The apm_filtered bitmap may contain APIDs filterred from 
matrix_mdev->shadow_apcb, so the associated queues will need to be reset 
(see comment below).
> +	do_update |= vfio_ap_mdev_filter_cdoms(matrix_mdev);
> +
> +	/* Apply changes to shadow apbc if things changed */
> +	if (do_update)
> +		vfio_ap_mdev_update_guest_apcb(matrix_mdev);


After the call above, you will need to call the function below to reset 
the queues associated with any APIDs filtered from matrix_mdev->shadow_apcb:

     reset_queues_for_apids(matrix_mdev, apm_filtered);



> +out:
> +	release_update_locks_for_mdev(matrix_mdev);
> +	mutex_unlock(&ap_perms_mutex);
> +	kfree(newbuf);
> +	return rc;
>   }
>   static DEVICE_ATTR_RW(ap_config);
>   
> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> index 88aff8b81f2f..e2cf07c184bf 100644
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

