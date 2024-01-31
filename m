Return-Path: <linux-kernel+bounces-46905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F07AA844637
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC921B2452B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A73212DD82;
	Wed, 31 Jan 2024 17:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ijLJ/ueO"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7724712BE9D;
	Wed, 31 Jan 2024 17:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706722048; cv=none; b=UROzTL95iVTBW6zWUQiw9CL+XzvnON+BG3CCM3T06JcFd8gnAZvhF7jNfzCqZ07AeuzuYb+NEyYjZoxgnlH7wHRGc7cZ5dygUSdsHDMhlZba6uR6Hs/uwxy4epCi0e478k1czT7tdZOLT6VFxduFyRBgFxtJBJKIMpXg7NCC6iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706722048; c=relaxed/simple;
	bh=FMTvWAmrYJA6h1ZoUWR00DIBE1PV9VIZryfKE6SjFI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SnraLSGdp8u4kpv3O+Fp8UmT4PL4roSfxkxDoU5z+l0R4QpK1Nh4MXZO6cN6cW8A2ot9ODov844NrZBlNfzGkqfbEFIuSFrSFRRr2GKYt+Wt/cDX9MSOsQs8U2pqQFMSyBwnioXJlIa31xQxEwf5OQcI6NlqQ7yjCC4pD7MEC5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ijLJ/ueO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40VHHJgD006611;
	Wed, 31 Jan 2024 17:27:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=lsvMoolOth0SOeipzcTmQMNAjiPxqd89r0TeAdoCg7o=;
 b=ijLJ/ueO7E+WFKtJ8omsbRYiTgcU7fnUxXl5dsJFkXD2m5D3KAkos9NtC9RqTUrG20pL
 0X1dumZvE/C1D2A+mISHtfrv/dFQo0V30SGv9R4m3A3SqnBtK2NxYuEqzQZcTSx98evb
 VJ20td+QaB0ke5pAOAL1wlJAba78t484qbJDxyKbX20QW4EOxaltNo/+V44ravo7hWML
 iJ4ZVvR/Njo/ZrLGa8ivLQSHHo8J+ux+ByKH3czUsIwfUjHkJoR+EhoOfXeRKszw1Odh
 9P3mOeEqgZuxtKdm8RvvUhhrjC2FXTh68DdUg9WGHYB/iFsrS5HAr8/9ZpZ4165XLQId pg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vytfg09g9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 17:27:12 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40VHI1N3008186;
	Wed, 31 Jan 2024 17:27:10 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vytfg08jn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 17:27:08 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40VG3DDP011231;
	Wed, 31 Jan 2024 17:25:46 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vweckpg0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 17:25:46 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40VHPjTZ28181154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 17:25:45 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9D8C58055;
	Wed, 31 Jan 2024 17:25:45 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 19D095803F;
	Wed, 31 Jan 2024 17:25:41 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 31 Jan 2024 17:25:40 +0000 (GMT)
Message-ID: <f0c5ad17-3ee3-427c-bcf3-883171e82917@linux.ibm.com>
Date: Wed, 31 Jan 2024 12:25:40 -0500
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
 <c018b014-9ba8-4395-86dc-b61346ab20a8@linux.ibm.com>
 <CAOQ4uxi6Te8izWpXROthknRaXrVA9jho5nbc+mkuQDrcTLY44Q@mail.gmail.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CAOQ4uxi6Te8izWpXROthknRaXrVA9jho5nbc+mkuQDrcTLY44Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: da6bg1rqaGfjaUZXT525S0efJqnep6By
X-Proofpoint-ORIG-GUID: YdP97E0i6OhsgP4fTtOj83B3bGJXnlLs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=999 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401310135



On 1/31/24 10:54, Amir Goldstein wrote:
> On Wed, Jan 31, 2024 at 4:40 PM Stefan Berger <stefanb@linux.ibm.com> wrote:
>>
>>
>>
>> On 1/31/24 08:16, Amir Goldstein wrote:
>>> On Wed, Jan 31, 2024 at 4:11 AM Stefan Berger <stefanb@linux.ibm.com> wrote:
>>>>
>>>>
>>>>
>>>> On 1/30/24 16:46, Stefan Berger wrote:
>>>>> Changes to the file attribute (mode bits, uid, gid) on the lower layer
>>>>> are not take into account when d_backing_inode() is used when a file is
>>>>> accessed on the overlay layer and this file has not yet been copied up.
>>>>> This is because d_backing_inode() does not return the real inode of the
>>>>> lower layer but instead returns the backing inode which holds old file
>>>>> attributes. When the old file attributes are used for calculating the
>>>>> metadata hash then the expected hash is calculated and the file then
>>>>> mistakenly passes signature verification. Therefore, use d_real_inode()
>>>>> which returns the inode of the lower layer for as long as the file has
>>>>> not been copied up and returns the upper layer's inode otherwise.
>>>>>
>>>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>>>> ---
>>>>>     security/integrity/evm/evm_crypto.c | 2 +-
>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
>>>>> index b1ffd4cc0b44..2e48fe54e899 100644
>>>>> --- a/security/integrity/evm/evm_crypto.c
>>>>> +++ b/security/integrity/evm/evm_crypto.c
>>>>> @@ -223,7 +223,7 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
>>>>>                                  size_t req_xattr_value_len,
>>>>>                                  uint8_t type, struct evm_digest *data)
>>>>>     {
>>>>> -     struct inode *inode = d_backing_inode(dentry);
>>>>> +     struct inode *inode = d_real_inode(dentry);
>>>>>         struct xattr_list *xattr;
>>>>>         struct shash_desc *desc;
>>>>>         size_t xattr_size = 0;
>>>>
>>>> We need this patch when NOT activating CONFIG_OVERLAY_FS_METACOPY but
>>>> when setting CONFIG_OVERLAY_FS_METACOPY=y it has to be reverted...  I am
>>>> not sure what the solution is.
>>>
>>> I think d_real_inode() does not work correctly for all its current users for
>>> a metacopy file.
>>>
>>> I think the solution is to change d_real_inode() to return the data inode
>>> and add another helper to get the metadata inode if needed.
>>> I will post some patches for it.
>>
>> I thought that we may have to go through vfs_getattr() but even better
>> if we don't because we don't have the file *file anywhere 'near'.
>>
>>>
>>> However, I must say that I do not know if evm_calc_hmac_or_hash()
>>> needs the lower data inode, the upper metadata inode or both.
>>
>> What it needs are data structures with mode bits, uid, and gid that stat
>> in userspace would show.
>>
>>
> 
> With or without metacopy enabled, an overlay inode st_uid st_gid st_mode
> are always taken from the upper most inode which is what d_real_inode()
> currently returns, so I do not understand what the problem is.

I have testcases that work fine with this series when 
CONFIG_OVERLAY_FS_METACOPY is not active. Once I activate this then a 
test case that changes a file's gid on the overlay layer from 0 to '12' 
while causing a copy-up allows a file to execute even thugh it should 
not execute. The reason is because d_real_inode(dentry)->i_guid shows 
the '0' while d_backing_dentry(dentry)->i_guid shows '12'. User space 
stat also shows '12' as expected.


Just saw your other email, will try that now ...

