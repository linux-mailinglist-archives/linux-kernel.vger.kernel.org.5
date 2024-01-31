Return-Path: <linux-kernel+bounces-45626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A04484332E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 03:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC9731C25E01
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799547492;
	Wed, 31 Jan 2024 02:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UA044uZA"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14266AC0;
	Wed, 31 Jan 2024 02:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706667093; cv=none; b=VFuTfm1XanTSpr1eIdjRMzFhCiml9Rjq6o/MeQ4o+dZJr4YJ2VNdwZlJLAuOqBQPqZGSpqayV12IPJ0JgKdxhZj5bBh6ILCeL1iG6dfGSMWUnGfE2deaJvXo5hSJv4bpBlF4I+wzznjhrVn97XegmOyCpluYM6eXP3c8qnbjkFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706667093; c=relaxed/simple;
	bh=5V+1lVSFCwl0HqD4XTm+JK1RWoUpkuJT6j5pOs1vZ4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=albxGSOxOYxFRKgvLmMZxLinmFkUwjRkZmwk4ojRQH7lOasHzTw/JDQ39jJ4ktalcZB/PD4VWNp7hSuyRb4w4C0ed+1ZiOwOTXcs8nG/8pE3Rwh0kTa8TRaaYDo3v/pPuPu4vR49ft2cS7gdvZcs774r0691unANYz5pUTdW1E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UA044uZA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40UNr8SG014227;
	Wed, 31 Jan 2024 02:11:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=titW6woM4Us3aYaR4S1UO/MqF5zLOoOIb81u5xnqcLA=;
 b=UA044uZAKJwp402Sybb0iOQkotJv4O2uAg4KnLxRPItk8jnFjMeqB4YX2xuQTvHupzOq
 B5nekJ8yzW/ZYaPhr8Ea9i7EISbJHjd6CKZf0JIYNS36FbRSYRJ0oiKWNli8fObXb+QD
 s7d6WZzm0tkJ6d0qq0MlPuqeTDzrbQhm41K63bVdJXnAhtRkB1sgz6LG9p9CX+dw5sqn
 P5tE3gJX2oEYxlynUgwRgvYtjKDi7lQ6YY8LX+xx3rxNiBWb8V4GLPVtZimKON9FaYKY
 bXBKp7sq8swv/Gz/QG8v5y7O+sRCLe/wd2u/IEuxNltjThvkO2XkUrWIML02PsY7T5AC YA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vyb5x2df3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 02:11:18 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40V1xgus014362;
	Wed, 31 Jan 2024 02:11:18 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vyb5x2da0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 02:11:17 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40V20Hcb008234;
	Wed, 31 Jan 2024 02:10:49 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vwdnm2ggp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 02:10:49 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40V2AmYS5440320
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 02:10:48 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A483958052;
	Wed, 31 Jan 2024 02:10:48 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C15A158056;
	Wed, 31 Jan 2024 02:10:47 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 31 Jan 2024 02:10:47 +0000 (GMT)
Message-ID: <38230b4c-54ae-45ed-a6fb-34e63501e5b1@linux.ibm.com>
Date: Tue, 30 Jan 2024 21:10:47 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] evm: Use the real inode's metadata to calculate
 metadata hash
To: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, zohar@linux.ibm.com, roberto.sassu@huawei.com,
        amir73il@gmail.com, miklos@szeredi.hu
References: <20240130214620.3155380-1-stefanb@linux.ibm.com>
 <20240130214620.3155380-5-stefanb@linux.ibm.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240130214620.3155380-5-stefanb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Zc1qrXxFCD3ijIZFAPrQM6sGqbDaSGHp
X-Proofpoint-ORIG-GUID: zaUA5QI1SqCbCcF4YyZKcyyHfxVKhZXa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_14,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 phishscore=0 impostorscore=0 mlxscore=0
 adultscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401310017



On 1/30/24 16:46, Stefan Berger wrote:
> Changes to the file attribute (mode bits, uid, gid) on the lower layer
> are not take into account when d_backing_inode() is used when a file is
> accessed on the overlay layer and this file has not yet been copied up.
> This is because d_backing_inode() does not return the real inode of the
> lower layer but instead returns the backing inode which holds old file
> attributes. When the old file attributes are used for calculating the
> metadata hash then the expected hash is calculated and the file then
> mistakenly passes signature verification. Therefore, use d_real_inode()
> which returns the inode of the lower layer for as long as the file has
> not been copied up and returns the upper layer's inode otherwise.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>   security/integrity/evm/evm_crypto.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
> index b1ffd4cc0b44..2e48fe54e899 100644
> --- a/security/integrity/evm/evm_crypto.c
> +++ b/security/integrity/evm/evm_crypto.c
> @@ -223,7 +223,7 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
>   				 size_t req_xattr_value_len,
>   				 uint8_t type, struct evm_digest *data)
>   {
> -	struct inode *inode = d_backing_inode(dentry);
> +	struct inode *inode = d_real_inode(dentry);
>   	struct xattr_list *xattr;
>   	struct shash_desc *desc;
>   	size_t xattr_size = 0;

We need this patch when NOT activating CONFIG_OVERLAY_FS_METACOPY but 
when setting CONFIG_OVERLAY_FS_METACOPY=y it has to be reverted...  I am 
not sure what the solution is.

