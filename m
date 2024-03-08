Return-Path: <linux-kernel+bounces-97160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0516876644
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86E43282D48
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043605E098;
	Fri,  8 Mar 2024 14:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aDpakm7D"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2D65E09A;
	Fri,  8 Mar 2024 14:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709907572; cv=none; b=b9KpHn5v62ywRWJ06QGSxsEY0D+toT6gr0WAOkE8jYKxl153qP6DS1nkAIcdKBhKoBGtbXSqq1g45SEsSupMkh80eFE+PJ6f6CH9Gj446Ssm/P7WP6mwclD8ObHJIldsfSLZJpnDTwlz1hIN8zrIwY5OyPBIlTMbrI+id2cMNx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709907572; c=relaxed/simple;
	bh=kOYxEEaMHOVfx0vX9WR0taTB0+emJnmrpE5HjLADvco=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=go+73bVDoIDTgvsdOeILYsl0lfS7S7glFBr5sQ1iRlBJSUUqMRtg3jtrbmZQbJx4QmLpqZnM7DROwttyxmksMdadeBzgnQ+rWowxCT0L6enGNM59GA3ZNXrL1JvMC13KnRA0LObFTaSHILQdwi4obKqbtDPZ65saVeJus4ZNOqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aDpakm7D; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 428Dv11h009389;
	Fri, 8 Mar 2024 14:19:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=mime-version : date :
 from : to : cc : subject : reply-to : in-reply-to : references :
 message-id : content-type : content-transfer-encoding; s=pp1;
 bh=GvExlI5QRvQGi2jlPYy9ptuyzGEchZAeDh1QtaQuKR8=;
 b=aDpakm7DgD+zRFXCTsibSx+cUjRcpgVcQBuxDmfqCi3xMIRbmojqsQT9/7UlXON0aFY2
 4YepqQaCX58HcaFvCkpK22BxSZfZyE6i7r711cTNCFzn902w0+RvhI9oG0IsUZ8VLICz
 Xc9eDYtx0c9lpaB/XLlMyj5yUa2qPTgSQ3EVMtIfNmVy82l3M1/N9t0QOUAZEw6CndVP
 mne6ACLyM2zMeRTPLWpZ5nxNaij7CcieEHxprmiqxiBPEfplZwK610LuTjPjglPLPo3C
 +m4KVM5u5yaLXx2sDC4pefSPcIkA3g9FIRhPGwe3wD7SqjEWWisaK1okpc3F369fP1xm hw== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr40r0bhc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 14:19:19 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 428DZCW9010881;
	Fri, 8 Mar 2024 14:19:19 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmh52vd0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 14:19:19 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 428EJFb439780666
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Mar 2024 14:19:17 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5313858061;
	Fri,  8 Mar 2024 14:19:15 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDB655803F;
	Fri,  8 Mar 2024 14:19:14 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 Mar 2024 14:19:14 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 08 Mar 2024 15:19:14 +0100
From: Harald Freudenberger <freude@linux.ibm.com>
To: "Ricardo B. Marliere" <ricardo@marliere.net>,
        Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/6] s390: zcrypt: make zcrypt_class constant
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20240305-class_cleanup-s390-v1-1-c4ff1ec49ffd@marliere.net>
References: <20240305-class_cleanup-s390-v1-0-c4ff1ec49ffd@marliere.net>
 <20240305-class_cleanup-s390-v1-1-c4ff1ec49ffd@marliere.net>
Message-ID: <84263def1d38584cd83558a33bb52f22@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9WJtshnj7cPM-7fJM6NVdOkIhjZ1COWE
X-Proofpoint-GUID: 9WJtshnj7cPM-7fJM6NVdOkIhjZ1COWE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403080114

On 2024-03-05 12:25, Ricardo B. Marliere wrote:
> Since commit 43a7206b0963 ("driver core: class: make class_register() 
> take
> a const *"), the driver core allows for struct class to be in read-only
> memory, so move the zcrypt_class structure to be declared at build time
> placing it into read-only memory, instead of having to be dynamically
> allocated at boot time.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---
>  drivers/s390/crypto/zcrypt_api.c | 33 
> +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/s390/crypto/zcrypt_api.c 
> b/drivers/s390/crypto/zcrypt_api.c
> index e8742757085b..d0358bb6ccf2 100644
> --- a/drivers/s390/crypto/zcrypt_api.c
> +++ b/drivers/s390/crypto/zcrypt_api.c
> @@ -116,7 +116,11 @@ EXPORT_SYMBOL(zcrypt_msgtype);
> 
>  struct zcdn_device;
> 
> -static struct class *zcrypt_class;
> +static void zcdn_device_release(struct device *dev);
> +static const struct class zcrypt_class = {
> +	.name = ZCRYPT_NAME,
> +	.dev_release = zcdn_device_release,
> +};
>  static dev_t zcrypt_devt;
>  static struct cdev zcrypt_cdev;
> 
> @@ -139,7 +143,7 @@ static int zcdn_destroy(const char *name);
>   */
>  static inline struct zcdn_device *find_zcdndev_by_name(const char 
> *name)
>  {
> -	struct device *dev = class_find_device_by_name(zcrypt_class, name);
> +	struct device *dev = class_find_device_by_name(&zcrypt_class, name);
> 
>  	return dev ? to_zcdn_dev(dev) : NULL;
>  }
> @@ -151,7 +155,7 @@ static inline struct zcdn_device
> *find_zcdndev_by_name(const char *name)
>   */
>  static inline struct zcdn_device *find_zcdndev_by_devt(dev_t devt)
>  {
> -	struct device *dev = class_find_device_by_devt(zcrypt_class, devt);
> +	struct device *dev = class_find_device_by_devt(&zcrypt_class, devt);
> 
>  	return dev ? to_zcdn_dev(dev) : NULL;
>  }
> @@ -405,7 +409,7 @@ static int zcdn_create(const char *name)
>  		goto unlockout;
>  	}
>  	zcdndev->device.release = zcdn_device_release;
> -	zcdndev->device.class = zcrypt_class;
> +	zcdndev->device.class = &zcrypt_class;
>  	zcdndev->device.devt = devt;
>  	zcdndev->device.groups = zcdn_dev_attr_groups;
>  	if (name[0])
> @@ -2067,12 +2071,9 @@ static int __init zcdn_init(void)
>  	int rc;
> 
>  	/* create a new class 'zcrypt' */
> -	zcrypt_class = class_create(ZCRYPT_NAME);
> -	if (IS_ERR(zcrypt_class)) {
> -		rc = PTR_ERR(zcrypt_class);
> +	rc = class_register(&zcrypt_class);
> +	if (rc)
>  		goto out_class_create_failed;
> -	}
> -	zcrypt_class->dev_release = zcdn_device_release;
> 
>  	/* alloc device minor range */
>  	rc = alloc_chrdev_region(&zcrypt_devt,
> @@ -2088,35 +2089,35 @@ static int __init zcdn_init(void)
>  		goto out_cdev_add_failed;
> 
>  	/* need some class specific sysfs attributes */
> -	rc = class_create_file(zcrypt_class, &class_attr_zcdn_create);
> +	rc = class_create_file(&zcrypt_class, &class_attr_zcdn_create);
>  	if (rc)
>  		goto out_class_create_file_1_failed;
> -	rc = class_create_file(zcrypt_class, &class_attr_zcdn_destroy);
> +	rc = class_create_file(&zcrypt_class, &class_attr_zcdn_destroy);
>  	if (rc)
>  		goto out_class_create_file_2_failed;
> 
>  	return 0;
> 
>  out_class_create_file_2_failed:
> -	class_remove_file(zcrypt_class, &class_attr_zcdn_create);
> +	class_remove_file(&zcrypt_class, &class_attr_zcdn_create);
>  out_class_create_file_1_failed:
>  	cdev_del(&zcrypt_cdev);
>  out_cdev_add_failed:
>  	unregister_chrdev_region(zcrypt_devt, ZCRYPT_MAX_MINOR_NODES);
>  out_alloc_chrdev_failed:
> -	class_destroy(zcrypt_class);
> +	class_unregister(&zcrypt_class);
>  out_class_create_failed:
>  	return rc;
>  }
> 
>  static void zcdn_exit(void)
>  {
> -	class_remove_file(zcrypt_class, &class_attr_zcdn_create);
> -	class_remove_file(zcrypt_class, &class_attr_zcdn_destroy);
> +	class_remove_file(&zcrypt_class, &class_attr_zcdn_create);
> +	class_remove_file(&zcrypt_class, &class_attr_zcdn_destroy);
>  	zcdn_destroy_all();
>  	cdev_del(&zcrypt_cdev);
>  	unregister_chrdev_region(zcrypt_devt, ZCRYPT_MAX_MINOR_NODES);
> -	class_destroy(zcrypt_class);
> +	class_unregister(&zcrypt_class);
>  }
> 
>  /*

Thanks Ricardo, nice work.
The only thing I would do is to rename the label 
"out_class_create_failed"
with "out_class_register_failed".

Who will pick this patch? As this is part of a bundle of fixes, Richardo
do you have a way to push this into the kernel? Otherwise as the 
AP/zcrypt
maintainer I would pick only this patch and forward it to the s390 
subsystem.

Acked-by: Harald Freudenberger <freude@linux.ibm.com>


