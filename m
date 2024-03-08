Return-Path: <linux-kernel+bounces-97272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C792876817
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50CB22839BB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1116D2C6A9;
	Fri,  8 Mar 2024 16:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nLD93Dr9"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7A3208A4;
	Fri,  8 Mar 2024 16:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709914139; cv=none; b=BCcqyfNBdCj0X/3Xk5J2Up+74ncaaHbDqB6DNVHd4LXZ1O7Pgw6C+o6RST2D4X2lD3CtonEr5DRzdGJ6Um7CM024gMmRXcP1IxE9RNTd0acV5AcMwe9m2SOKSn07SdUHnvvDlCbSGDKYWETsDYSGrXzZIHCGPKuV0k5jxQj+wKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709914139; c=relaxed/simple;
	bh=6SXOr1Iy8XNCRAMEN6pXGlhAS7VYMWHq6m6o9qQybHY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=BQ85VoMXjbBOtZGnI8uFPU7oviLkeb4ab7n/Y/qddlh9j1v7EeOU/RIdYCPadKzDYJN17K0h4xyNkggWSiJHS1gXZCHuDg+HA93tjH5GU+YhOphY78920ex+eWX6Cm5SfpKLZvtVnPFklH5kOjh6Y52/gw/93pa5XIHeHj6/LOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nLD93Dr9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 428FqHgk006767;
	Fri, 8 Mar 2024 16:08:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=rqvCQHQSaJB4tbEh2EpaGjIG0ekuTz9t/hBKYIfpR1Y=;
 b=nLD93Dr940U6xPonyTT9pl6Pl62wcUIPfDsOmQuw6gGBiBVMUurenkPHymTFBmU1781t
 8hXxySqD7b3qvMl+aeq67P9Ea0ttt5jwxdivOqan/z6BoJkhyM7drqt7gcNFyUbkWK+x
 /0hIwHWtfUrtNUIPz/DSYbDAfGTB75Jn/mDoyF2F7ssyFBQtlu7kaDUlmze7cyCpmyWb
 WFxrWAjlidid1pRwM6SMrR29GVrT/DoVkqLVay4ZWGXY80CWNUOXaCBZw+GmlQK5V2GY
 lOwI4MV0sUBo5te+OPHcq1W0LmQEh3Dq/8kMqOJJTRAU+3xKT2LbDSSJOTywIG7DSQXY Yg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr5pj8b4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 16:08:13 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 428G6jsL018936;
	Fri, 8 Mar 2024 16:08:12 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr5pj8b49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 16:08:12 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 428DTCm9024163;
	Fri, 8 Mar 2024 16:08:11 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wpjwsrner-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 16:08:11 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 428G88Gd37683702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Mar 2024 16:08:10 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6033258072;
	Fri,  8 Mar 2024 16:08:08 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0194258064;
	Fri,  8 Mar 2024 16:08:07 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.150.204])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 Mar 2024 16:08:06 +0000 (GMT)
Message-ID: <acfb4159b16b84d8fa1517d6870edaaaadf901c8.camel@linux.ibm.com>
Subject: Re: [RFC][PATCH 6/8] ima: Use digest cache for measurement
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, corbet@lwn.net,
        dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        wufan@linux.microsoft.com, pbrobinson@gmail.com, zbyszek@in.waw.pl,
        hch@lst.de, mjg59@srcf.ucam.org, pmatilai@redhat.com, jannh@google.com,
        dhowells@redhat.com, jikos@kernel.org, mkoutny@suse.com,
        ppavlu@suse.com, petr.vorel@gmail.com, petrtesarik@huaweicloud.com,
        mzerqung@0pointer.de, kgold@linux.ibm.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Date: Fri, 08 Mar 2024 11:08:06 -0500
In-Reply-To: <20240214143525.2205481-7-roberto.sassu@huaweicloud.com>
References: <20240214143525.2205481-1-roberto.sassu@huaweicloud.com>
	 <20240214143525.2205481-7-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-23.el8_9) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qqpIrBqEDS0LeBEA8Jzro8IoOjhRTb2R
X-Proofpoint-GUID: GFNkQnj3kCNuQprUSV6gG5Zkx44eG_VH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403080129

Hi Roberto,

> diff --git a/security/integrity/ima/ima_main.c
> b/security/integrity/ima/ima_main.c
> index 3fc48214850a..48a09747ae7a 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -222,7 +222,9 @@ static int process_measurement(struct file *file, const
> struct cred *cred,
>  	bool violation_check;
>  	enum hash_algo hash_algo;
>  	unsigned int allowed_algos = 0;
> -	u64 verif_mask = 0;
> +	u64 verif_mask = 0, *verif_mask_ptr, policy_mask = 0, allow_mask = 0;
> +	struct digest_cache *digest_cache = NULL, *found_cache;
> +	digest_cache_found_t found;
>  
>  	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
>  		return 0;
> @@ -233,7 +235,7 @@ static int process_measurement(struct file *file, const
> struct cred *cred,
>  	 */
>  	action = ima_get_action(file_mnt_idmap(file), inode, cred, secid,
>  				mask, func, &pcr, &template_desc, NULL,
> -				&allowed_algos, NULL);
> +				&allowed_algos, &policy_mask);
>  	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK ||
>  			    func == MMAP_CHECK_REQPROT) &&
>  			   (ima_policy_flag & IMA_MEASURE));
> @@ -364,10 +366,34 @@ static int process_measurement(struct file *file, const
> struct cred *cred,
>  	if (!pathbuf)	/* ima_rdwr_violation possibly pre-fetched */
>  		pathname = ima_d_path(&file->f_path, &pathbuf, filename);
>  
> +	/*
> +	 * For now we don't support nested verification with digest caches.

I haven't reviewed the digest_cache LSM patch set yet.  What does 'nested' mean
in this context?  Why mention it here?

> +	 * Since we allow IMA policy rules without func=, we have to enforce
> +	 * this restriction here.
> +	 */
> +	if (rc == 0 && policy_mask && func != DIGEST_LIST_CHECK)
> +		digest_cache = digest_cache_get(file_dentry(file));

So whether or not a DIGEST_LIST_CHECK policy rule even exists,
digest_cache_get() will be called.  Similarly, even if a digest_cache list
hasn't been measured or appraised, digest_cache_get() will be called.

Basically every file in policy will check the digest_cache.

> +
> +	if (digest_cache) {
> +		found = digest_cache_lookup(file_dentry(file), digest_cache,
> +					    iint->ima_hash->digest,
> +					    iint->ima_hash->algo);
> +		/* AND what is allowed by the policy, and what IMA verified. */
> +		if (found) {
> +			found_cache = digest_cache_from_found_t(found);
> +			verif_mask_ptr = digest_cache_verif_get(found_cache,
> +								"ima");

Instead of using "verif_{set,get}' consider using '{set,get}_usage', where usage
here means measure or appraise.

> +			if (verif_mask_ptr)
> +				allow_mask = policy_mask & *verif_mask_ptr;
> +		}
> +
> +		digest_cache_put(digest_cache);
> +	}
> +

I'm wondering if it makes sense to create IMA wrappers for each of the
digest_cache functions - checking the digest_cache for the hash, setting the
digest_cache permitted usage, etc - and put all of them in a separate
ima_digest_cache.c file.  The file would only be included in the Makefile if
digest_cache is configured.

In this file you could define a static local global variable to detect whether
the digest_cache is ready to be used.  Only after successfully measuring and
appraising a digest_cache list, based on policy, set the variable.

>  	if (action & IMA_MEASURE)
>  		ima_store_measurement(iint, file, pathname,
>  				      xattr_value, xattr_len, modsig, pcr,
> -				      template_desc);
> +				      template_desc, allow_mask);

'allowed_usage'?

>  	if (rc == 0 && (action & IMA_APPRAISE_SUBMASK)) {
>  		rc = ima_check_blacklist(iint, modsig, pcr);
>  		if (rc != -EPERM) {

thanks,

Mimi


