Return-Path: <linux-kernel+bounces-108210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23233880780
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D328D2844B3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D43C5FB97;
	Tue, 19 Mar 2024 22:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hogmrlPS"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5EC364D4;
	Tue, 19 Mar 2024 22:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710888814; cv=none; b=bQsXP8QH3UBk/SYbZEYy3vVujDResdcq+6KJpPITjoZMTLrBRkh/c79nn3yZTrrQVsq8NBa2FL4pJeFXjwGE5b7sA5jrY2g9ymkeeWGq45LktpPq+SSm+CNym2uFCwZoMf1NNn52I3Qzki+1FCSyc/byuav5Nye5FsnfrwltCrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710888814; c=relaxed/simple;
	bh=iEFRccGrWfzX0WvyXCzfSqoltS3V2ahYudXpsGtpfJo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=RDDVtoNMVI32KRZg8188O6tfKPY0XE9v9r78aNnMl9C/XtNBw2cKuqEIp2tD5PrDqR+w14kA5mqXL3TwpQBa0RQU/mMI4ROQMg/A93hkHJZHehlVZWJWvuZJQNCEhv/Cn3Ips6JM7ZJ0qoaLgEop4lbL6VYrm0KIxFPAjdHAWVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hogmrlPS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JLew7H024553;
	Tue, 19 Mar 2024 22:53:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=HwNsksKxF24dTGqYC+42oJXCn+Aza9vTQw0xV4rLbIU=;
 b=hogmrlPSngOJNsSNQi0/oOlQNaqblk3kTeuoxnrmO/MYBgVbvhIQ5HHrYdPgkMpJDd0d
 IvVDpAjT2ud41COPlup9iqf1lQKioheZyN9i+D/rFg/2JYCnmH186Ayx91Qr58fxbmwI
 kczvLZukEvouGLEI4dY3IpCJttgSL3KCgR2dEtTtTMTmRnxJ2I1hdZJRJkyDh/OBYTmp
 ZUEi0xCktRUqy3UmoslctiThKhOnbV2rTyVw3n+ctxMBZtlAHVqYZ8D4vV4/MxFi1H+0
 vDf/DOziEnUItXcjJJCcojFjGDwYmqLGjLe8zkHInj1WNzeFfl629XP2rll5MAn8i/nD zg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wyg2qgg6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 22:53:14 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42JMrDJT014552;
	Tue, 19 Mar 2024 22:53:13 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wyg2qgg6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 22:53:13 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42JLbaVG015789;
	Tue, 19 Mar 2024 22:53:12 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wwp502t73-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 22:53:12 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42JMr97C5571270
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Mar 2024 22:53:12 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DEAAC5803F;
	Tue, 19 Mar 2024 22:53:09 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 676D758064;
	Tue, 19 Mar 2024 22:53:08 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.80.83])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Mar 2024 22:53:08 +0000 (GMT)
Message-ID: <6211c10334fa9f51c6aad827b14f322b09ec8760.camel@linux.ibm.com>
Subject: Re: [PATCH v3 07/10] ima: re-evaluate file integrity on file
 metadata change
From: Mimi Zohar <zohar@linux.ibm.com>
To: Stefan Berger <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-unionfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, roberto.sassu@huawei.com, amir73il@gmail.com,
        brauner@kernel.org, miklos@szeredi.hu
Date: Tue, 19 Mar 2024 18:53:07 -0400
In-Reply-To: <20240223172513.4049959-8-stefanb@linux.ibm.com>
References: <20240223172513.4049959-1-stefanb@linux.ibm.com>
	 <20240223172513.4049959-8-stefanb@linux.ibm.com>
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
X-Proofpoint-GUID: ewPzBGr9hsY6BQBxNYyMqXTO_H3isYjI
X-Proofpoint-ORIG-GUID: w7tF09W2yF-dyc_O1VNtvc-mw0_y40-o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_09,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 clxscore=1015 mlxlogscore=718 priorityscore=1501 lowpriorityscore=0
 phishscore=0 malwarescore=0 impostorscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403190176

> @@ -286,7 +288,8 @@ static int process_measurement(struct file *file, const
> struct cred *cred,
>  	}
>  
>  	/*
> -	 * On stacked filesystems, detect and re-evaluate file data changes.
> +	 * On stacked filesystems, detect and re-evaluate file data and
> +	 * metadata changes.
>  	 */
>  	real_inode = d_real_inode(file_dentry(file));
>  	if (real_inode != inode &&
> @@ -297,6 +300,15 @@ static int process_measurement(struct file *file, const
> struct cred *cred,
>  			iint->flags &= ~IMA_DONE_MASK;
>  			iint->measured_pcrs = 0;
>  		}
> +
> +		/*
> +		 * Reset the EVM status when metadata changed.
> +		 */

-> To force re-validation, reset both the EVM and IMA status when the metadata
changes.

Mimi

> +		metadata_inode = d_inode(d_real(file_dentry(file),
> +					 D_REAL_METADATA));
> +		if (evm_metadata_changed(inode, metadata_inode))
> +			iint->flags &= ~(IMA_APPRAISED |
> +					 IMA_APPRAISED_SUBMASK);
>  	}
>  
>  	/* Determine if already appraised/measured based on bitmask


