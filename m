Return-Path: <linux-kernel+bounces-64521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8188F853FD9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39F522860C3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B5562A10;
	Tue, 13 Feb 2024 23:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Prch+VJa"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AE163116;
	Tue, 13 Feb 2024 23:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707866074; cv=none; b=t7KfAif8kM0Ktg+GdoZeNRDBh9W9mSinLeZdlU/e34Z+qCYLcELTvnLY+yHR9UJsrF6noUUA2/R4XRMSUtWfodNyIp87c9BCBUSTx17f0hMq6VjjTW3Ej62ZqTkS//+MI+oxFdpDWJqceR7yeXhhaZhwIHBiw6BCEgZ7W/H7lvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707866074; c=relaxed/simple;
	bh=qcm0VaqswDmHTQcQKJr19LpuA/JZkDnXui5/NabS0Dg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CejfKvH8bq0sPnWvy/Ga/P85TePKLxW7Z6kGc8gB87+JL1/b+p48EPbqdMM1Gj5DI8dXVGWbCCpVX5MY1LDIQ++Br03FB06OGCjdz0mVAHBokLV1F2zoZwrqarcxiktJYV5L0Y2K70UEowOb8k0QD5PTR1InkZW6+K5kFwGOWgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Prch+VJa; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41DNE9RM030557;
	Tue, 13 Feb 2024 23:14:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=5VExLh8Q6ohli8PnsUbpj419eWG+ssin/sOgusm8ZBY=;
 b=Prch+VJas4YL4J06hDkMRs37m3UfeRKziGVwIAXwd2Q+Gclr5PSqBveALM/v0tZk+4xQ
 Tuv87KR4+s+k2xSS67JE4E/TZFvvBO9jUP1CjnzF5S7yzfuf7FSfKd0nYZ7pvUisRRyw
 ANXzFIe2fyee8AAdeoG/lMDUPHNiWl33/F7ZQGdfYC8SI9v9rRQMnA5F/53XWnnsZTfy
 01FuoxFrhdim+FPm+1cyDt+LTc1lFzz3O2jHya1rgOaofmInitXwQi0Le3piNNljSu1e
 Jb5R5ZojKwDMoBiCTMt2ItEuItNplgrB3kz1bWNih/l8Mfhz7LXyl2O4zM1o+iBYRZwp jw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w8hwx0039-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 23:14:09 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41DNE8wV030303;
	Tue, 13 Feb 2024 23:14:08 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w8hwx0033-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 23:14:08 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41DMM6Bc004247;
	Tue, 13 Feb 2024 23:14:08 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6kv0amsa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 23:14:08 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41DNE5Lx35062338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 23:14:07 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DD5D58052;
	Tue, 13 Feb 2024 23:14:05 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98F7E58063;
	Tue, 13 Feb 2024 23:14:00 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Feb 2024 23:14:00 +0000 (GMT)
Message-ID: <fa242ec4-3f7b-4ae0-9430-b1b39255e10d@linux.ibm.com>
Date: Tue, 13 Feb 2024 18:14:00 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] ima: Record i_version of real_inode for change
 detection
Content-Language: en-US
To: Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        zohar@linux.ibm.com, roberto.sassu@huawei.com, brauner@kernel.org,
        miklos@szeredi.hu
References: <20240205182506.3569743-1-stefanb@linux.ibm.com>
 <20240205182506.3569743-10-stefanb@linux.ibm.com>
 <CAOQ4uxhQgCqNZ_4Dy1PghCHBg7H4qaf-st2pWhXe9eq1+dsHHA@mail.gmail.com>
 <754c1617c27660eff17bc0d7f4921c59d2471603.camel@kernel.org>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <754c1617c27660eff17bc0d7f4921c59d2471603.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Xa57Hqy3qImganGjlIxAgKl2-f4Ts7qT
X-Proofpoint-ORIG-GUID: PVp4pAvDGr1kdMhzm99YG1MRnKMA07ot
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_14,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2402130182



On 2/6/24 10:54, Jeff Layton wrote:
> On Tue, 2024-02-06 at 17:23 +0200, Amir Goldstein wrote:
>> On Mon, Feb 5, 2024 at 8:25 PM Stefan Berger <stefanb@linux.ibm.com> wrote:
>>>
>>> process_measurement() will try to detect file content changes for not-yet-
>>> copied-up files on a stacked filesystem based on the i_version number of
>>> the real inode: !inode_eq_iversion(real_inode, iint->version)
>>> Therefore, take a snapshot of the i_version of the real file to be used
>>> for i_version number-based file content change detection by IMA in
>>> process_meassurements().
>>>
>>> In this case vfs_getattr_nosec() cannot be used since it will return the
>>> i_version number of the file on the overlay layer which will trigger more
>>> iint resets in process_measurements() than necessary since this i_version
>>> number represents different state than that of the real_inode (of a
>>> not-yet-copied up file).
>>>
>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>> ---
>>>   security/integrity/ima/ima_api.c | 28 +++++++++++++++-------------
>>>   1 file changed, 15 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
>>> index 597ea0c4d72f..530888cc481e 100644
>>> --- a/security/integrity/ima/ima_api.c
>>> +++ b/security/integrity/ima/ima_api.c
>>> @@ -14,6 +14,7 @@
>>>   #include <linux/xattr.h>
>>>   #include <linux/evm.h>
>>>   #include <linux/fsverity.h>
>>> +#include <linux/iversion.h>
>>>
>>>   #include "ima.h"
>>>
>>> @@ -250,7 +251,6 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
>>>          int result = 0;
>>>          int length;
>>>          void *tmpbuf;
>>> -       u64 i_version = 0;
>>>
>>>          /*
>>>           * Always collect the modsig, because IMA might have already collected
>>> @@ -263,16 +263,6 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
>>>          if (iint->flags & IMA_COLLECTED)
>>>                  goto out;
>>>
>>> -       /*
>>> -        * Detecting file change is based on i_version. On filesystems
>>> -        * which do not support i_version, support was originally limited
>>> -        * to an initial measurement/appraisal/audit, but was modified to
>>> -        * assume the file changed.
>>> -        */
>>> -       result = vfs_getattr_nosec(&file->f_path, &stat, STATX_CHANGE_COOKIE,
>>> -                                  AT_STATX_SYNC_AS_STAT);
>>> -       if (!result && (stat.result_mask & STATX_CHANGE_COOKIE))
>>> -               i_version = stat.change_cookie;
>>>          hash.hdr.algo = algo;
>>>          hash.hdr.length = hash_digest_size[algo];
>>>
>>> @@ -302,10 +292,22 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
>>>
>>>          iint->ima_hash = tmpbuf;
>>>          memcpy(iint->ima_hash, &hash, length);
>>> -       iint->version = i_version;
>>> -       if (real_inode != inode) {
>>> +       if (real_inode == inode) {
>>> +               /*
>>> +                * Detecting file change is based on i_version. On filesystems
>>> +                * which do not support i_version, support was originally limited
>>> +                * to an initial measurement/appraisal/audit, but was modified to
>>> +                * assume the file changed.
>>> +                */
>>> +               result = vfs_getattr_nosec(&file->f_path, &stat,
>>> +                                          STATX_CHANGE_COOKIE,
>>> +                                          AT_STATX_SYNC_AS_STAT);
>>> +               if (!result && (stat.result_mask & STATX_CHANGE_COOKIE))
>>> +                       iint->version = stat.change_cookie;
>>> +       } else {
>>>                  iint->real_ino = real_inode->i_ino;
>>>                  iint->real_dev = real_inode->i_sb->s_dev;
>>> +               iint->version = inode_query_iversion(real_inode);
> 
> You only want to do this if IS_I_VERSION(inode) is true. If the
> underlying filesystem is doing its own thing wrt the i_version field,
> calling inode_query_iversion on it may corrupt it.
> 
> 
>>>          }
>>>
>>
>> The commit that removed inode_query_iversion db1d1e8b9867 ("IMA: use
>> vfs_getattr_nosec to get the i_version") claimed to do that because
>> inode_query_iversion() did not work in overlayfs and now this commit
>> uses inode_query_iversion() only for overlayfs.

Following this patch inode_query_version() would only be used when 
real_inode != inode, such as when a copy-up has not occurred, yet. If 
real_inode == inode then this is the case for the 'overlay' layer of 
overlayfs as well as any other non-stacked filesystem that would then 
still use vfs_getattr_nosec(). So is vfs_getattr_nosec() NOT the more 
general approach for all filesystems to use here?

>>
>> STATX_CHANGE_COOKIE does not seem to make much sense in this
>> code anymore, unless it is still needed, according to original commit to
>> "allow IMA to work properly with a broader class of filesystems in the future."
> 
> I don't have a real opinion here. When I did the original patch that
> switched this over to to use vfs_getattr_nosec, I didn't consider that
> it could end up being called from an atomic context. Reverting that

Under what conditions do we have an atomic context here? I was/am not 
aware of this.

> seems like the correct thing to do if it's still broken.
> 
> If you're fine with this only working on a subset of local filesystems,
> then doing something like this is probably fine:
> 
> 	if (IS_I_VERSION(real_inode))
> 		iint->version = inode_query_iversion(real_inode);
> 
> ...but it's not clear to me what you should do if IS_I_VERSION is false.
> I guess IMA just falls back to checking the ctime in that case?

It does not use ctime but assumes that something has changed.

