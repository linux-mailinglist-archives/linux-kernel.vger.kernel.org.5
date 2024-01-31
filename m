Return-Path: <linux-kernel+bounces-46615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EB9844204
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B4F128F06C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3B483CDB;
	Wed, 31 Jan 2024 14:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CycteHDg"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AC183CA6;
	Wed, 31 Jan 2024 14:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712016; cv=none; b=bc2PnPXHqkc9aDE0I6Nit+C1yCKnqlcjtO2VZt2y0X+QTVNzRtU30go4qzYAleZyfzUG9GTuT8UA6BruMh93hRsEZQxpoG57QO8JuRjHpaMkgBqypbE3AOfpTuhqhsQvVqSNNm4EMLcOa1M787ILbHpCBiioizUTdqLQNzmqTXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712016; c=relaxed/simple;
	bh=Y0pgaaXi7YzqWNFpiKMl8zHYIwKjsgcPsHxhHhb5zOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HBYBHaOThdZVToMc/tKCq0NR9DVsd/uXYd0+x3XC72wQsAzyDi9GsQu7Z3nzs03uEL0UYbOhpBVockf6C6fQgNY92iNntT2IXQy8QuC946oydmHtSFvWFfHYicV102jDbuFhAQ7hGOZEFANJJyah3ZDyylMBIN5khpJzDb6JMYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CycteHDg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40VDeVSu027685;
	Wed, 31 Jan 2024 14:40:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=KtJa0evA8R2SiByaW/FkiX63C4Oob/LD39WUTz76NVI=;
 b=CycteHDgxWbswQCzB6q9UIE7hDmH4Eh+KTIFbUDjBEUd5nTgGoDkHNh0YJIF/yktNUaX
 KohXVmZR4nIQdRuFFBdD2f2UGRlO72mgSL3RBT/9ucBwbMxHifKEeVQ2E85FrQyB4vQC
 Aw1svvIUmk8MUSL8yXsCQiME4GeWOk5TFGTvlo406Jvl5KY8FUfInZHt6KP6nT8TxMIG
 1b47WghcNvvXrEhoOtk+VmhVwjfNV+emXy4B6nfqRsQh0+CZhO3eAlyWR7NoNnrefUZs
 N4zgIJMR4e/DShVcYPHpXdc6W/VPYR2GYfUWqtpFYS3P43AXytwnvNB5kAk+0i7PzHa1 3g== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vyhyu9qgm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 14:40:05 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40VEXnLC015235;
	Wed, 31 Jan 2024 14:40:05 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vyhyu9qg7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 14:40:05 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40VDW4Tq007189;
	Wed, 31 Jan 2024 14:40:04 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vwev2dgwr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 14:40:04 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40VEe3kY44302812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 14:40:03 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73D2258055;
	Wed, 31 Jan 2024 14:40:03 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86A0958060;
	Wed, 31 Jan 2024 14:40:02 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 31 Jan 2024 14:40:02 +0000 (GMT)
Message-ID: <c018b014-9ba8-4395-86dc-b61346ab20a8@linux.ibm.com>
Date: Wed, 31 Jan 2024 09:40:02 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] evm: Use the real inode's metadata to calculate
 metadata hash
Content-Language: en-US
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        zohar@linux.ibm.com, roberto.sassu@huawei.com, miklos@szeredi.hu
References: <20240130214620.3155380-1-stefanb@linux.ibm.com>
 <20240130214620.3155380-5-stefanb@linux.ibm.com>
 <38230b4c-54ae-45ed-a6fb-34e63501e5b1@linux.ibm.com>
 <CAOQ4uxiYARZBSgzb4_W-RKvB1XLSF3GUBqeLw2kH+eVeZ_8ARQ@mail.gmail.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CAOQ4uxiYARZBSgzb4_W-RKvB1XLSF3GUBqeLw2kH+eVeZ_8ARQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 87eAHh5J_f4T3CgmxqihatbFrhyObT2c
X-Proofpoint-ORIG-GUID: PkgsQowtUmVJUJcawDd5_kM-J-6gJnG3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_08,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2401310112



On 1/31/24 08:16, Amir Goldstein wrote:
> On Wed, Jan 31, 2024 at 4:11 AM Stefan Berger <stefanb@linux.ibm.com> wrote:
>>
>>
>>
>> On 1/30/24 16:46, Stefan Berger wrote:
>>> Changes to the file attribute (mode bits, uid, gid) on the lower layer
>>> are not take into account when d_backing_inode() is used when a file is
>>> accessed on the overlay layer and this file has not yet been copied up.
>>> This is because d_backing_inode() does not return the real inode of the
>>> lower layer but instead returns the backing inode which holds old file
>>> attributes. When the old file attributes are used for calculating the
>>> metadata hash then the expected hash is calculated and the file then
>>> mistakenly passes signature verification. Therefore, use d_real_inode()
>>> which returns the inode of the lower layer for as long as the file has
>>> not been copied up and returns the upper layer's inode otherwise.
>>>
>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>> ---
>>>    security/integrity/evm/evm_crypto.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
>>> index b1ffd4cc0b44..2e48fe54e899 100644
>>> --- a/security/integrity/evm/evm_crypto.c
>>> +++ b/security/integrity/evm/evm_crypto.c
>>> @@ -223,7 +223,7 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
>>>                                 size_t req_xattr_value_len,
>>>                                 uint8_t type, struct evm_digest *data)
>>>    {
>>> -     struct inode *inode = d_backing_inode(dentry);
>>> +     struct inode *inode = d_real_inode(dentry);
>>>        struct xattr_list *xattr;
>>>        struct shash_desc *desc;
>>>        size_t xattr_size = 0;
>>
>> We need this patch when NOT activating CONFIG_OVERLAY_FS_METACOPY but
>> when setting CONFIG_OVERLAY_FS_METACOPY=y it has to be reverted...  I am
>> not sure what the solution is.
> 
> I think d_real_inode() does not work correctly for all its current users for
> a metacopy file.
> 
> I think the solution is to change d_real_inode() to return the data inode
> and add another helper to get the metadata inode if needed.
> I will post some patches for it.

I thought that we may have to go through vfs_getattr() but even better 
if we don't because we don't have the file *file anywhere 'near'.

> 
> However, I must say that I do not know if evm_calc_hmac_or_hash()
> needs the lower data inode, the upper metadata inode or both.

What it needs are data structures with mode bits, uid, and gid that stat 
in userspace would show.


> 
> The last time you tried to fix ovl+IMA, I asked for documentation
> of what data/metadata is protected with EVM and how are those
> protections supposed to work across overlayfs copy up, when the
> data and metadata are often split between 2 and myabe event 3
> differnt inode.

I always compare against what userspace sees with stat and that's what 
the EVM should also work with so it ends up in reasonable matching 
result in terms of hash calculation and then access permission/rejection.

> 
>  From the current patch set, I still don't understand what is the expected
> behavior before and after copy up of data/metadata-only.
> 
> Thanks,
> Amir.

