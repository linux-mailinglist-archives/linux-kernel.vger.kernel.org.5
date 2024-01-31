Return-Path: <linux-kernel+bounces-46672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6A884427A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FA201C21EA5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B171529CA;
	Wed, 31 Jan 2024 14:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OsnhFnMI"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A2D5A7A1;
	Wed, 31 Jan 2024 14:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706713002; cv=none; b=aVxM8js7+z4VJTEj1SuckYvkScq7UqlRpN3/GetC2zBUnwGQKJnO2hZ5hI1JrmBwmBDUhfCY3u0uiy3kwxCasDZXPno9ncOWbkEnSklS7Jy2DDwsc3I50iAfPH7uqA0I2ut9gBWSeH62CU8feyj30N5z994eIdY54kZhXdTMhjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706713002; c=relaxed/simple;
	bh=m1kKG/OLqqlepJ3C9hX+fm1JJZfXqHJuu2JoGe8e/Q0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pq0gLVtUvSvOH8jqCgeeE/r6O/mE8RqXe61e6cWG3ny5M7f1LvCOFUDsKGi7fv7U/b1T7mZxmoUy72vrZUEltavpanydQP2aKhJibVjXM0rQ3A25arBPdjYNTNJGoRZlSd28LIdDb3UuKL2ALXAYQqbjWt3fGH8+f5mT9qX5quo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OsnhFnMI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40VEOmGO018763;
	Wed, 31 Jan 2024 14:56:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=LhgpvjTYjabLh3xse1S1Padwl0ZlIsQ4O+aF3f3U70E=;
 b=OsnhFnMIwkqMLpEmrGHimJe6Tu7Q7p9ZZTjNvZrvkvhnTuS7RiXCY+HQeo+rH2hfMOP2
 +lGCxKsnpejs+u8cJuMTsEEIwvQEnkOcZ8rU77UFxfHG6Kieq9Wp7yByaXMApVc2Hvjz
 vs2tjjBJLp7URqqluaQ+b2F+pnN2BhnzYZLK7jCRttI7oJBzrsqQ+eYE3+RD8JQ0O0WS
 oS/DgKoIbg0JE6mX1RWQ0LpwM5NBJNbfbVvG22shgZQ/NFD+2YVH9yspfV90Epnoj4qW
 f1+fEzXnE+GMC/Qnx7Cd0FwUVUqua5aehkoZ62Hr7gcAOGKszRn3/5BcbS+ya8YB6ubi ww== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vyp9y3c9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 14:56:30 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40VE0TKx011497;
	Wed, 31 Jan 2024 14:56:29 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vyp9y3c93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 14:56:29 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40VDXUwc007200;
	Wed, 31 Jan 2024 14:56:28 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vwev2dk6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 14:56:28 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40VEuS5Q14287574
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 14:56:28 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 076DA5804E;
	Wed, 31 Jan 2024 14:56:28 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C9F358056;
	Wed, 31 Jan 2024 14:56:26 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 31 Jan 2024 14:56:26 +0000 (GMT)
Message-ID: <05fe58a1-9b2c-4c1f-80a6-4cb5094a2126@linux.ibm.com>
Date: Wed, 31 Jan 2024 09:56:25 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] security: allow finer granularity in permitting
 copy-up of security xattrs
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        zohar@linux.ibm.com, roberto.sassu@huawei.com, miklos@szeredi.hu
References: <20240130214620.3155380-1-stefanb@linux.ibm.com>
 <20240130214620.3155380-2-stefanb@linux.ibm.com>
 <CAOQ4uxjgdvGU0WE+92ByQE26Jp0j16AgfyCjNyEp7=86akOSsA@mail.gmail.com>
 <20240131-lacht-elend-536d94682370@brauner>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240131-lacht-elend-536d94682370@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FP8kjeJ98L7OgLG4mRpuAjGRVNzC3Ggg
X-Proofpoint-ORIG-GUID: gv3rZ-oEmA7mDo0G8vLGQhoibsmV0QeL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_08,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=588 adultscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401310115



On 1/31/24 09:25, Christian Brauner wrote:
> On Wed, Jan 31, 2024 at 03:25:29PM +0200, Amir Goldstein wrote:
>> On Tue, Jan 30, 2024 at 11:46 PM Stefan Berger <stefanb@linux.ibm.com> wrote:
>>>
>>> Copying up xattrs is solely based on the security xattr name. For finer
>>> granularity add a dentry parameter to the security_inode_copy_up_xattr
>>> hook definition, allowing decisions to be based on the xattr content as
>>> well.
>>>
>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>> ---
>>>   fs/overlayfs/copy_up.c            | 2 +-
>>>   include/linux/evm.h               | 2 +-
>>>   include/linux/lsm_hook_defs.h     | 3 ++-
>>>   include/linux/security.h          | 4 ++--
>>>   security/integrity/evm/evm_main.c | 2 +-
>>>   security/security.c               | 7 ++++---
>>>   security/selinux/hooks.c          | 2 +-
>>>   security/smack/smack_lsm.c        | 2 +-
>>>   8 files changed, 13 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
>>> index b8e25ca51016..bd9ddcefb7a7 100644
>>> --- a/fs/overlayfs/copy_up.c
>>> +++ b/fs/overlayfs/copy_up.c
>>> @@ -114,7 +114,7 @@ int ovl_copy_xattr(struct super_block *sb, const struct path *oldpath, struct de
>>>                  if (ovl_is_private_xattr(sb, name))
>>>                          continue;
>>>
>>> -               error = security_inode_copy_up_xattr(name);
>>> +               error = security_inode_copy_up_xattr(old, name);
>>
>> What do you think about:
>>
>>                       error = security_inode_copy_up_xattr(name, NULL, 0);
>>
>> and then later...
>>
>>                       error = security_inode_copy_up_xattr(name, value, size);
>>
>> I am asking because overlayfs uses mnt_idmap(path->mnt) and you
>> have used nop_mnt_idmap inside evm hook.
>> this does not look right to me?
> 
> So it's relevant if they interact with xattrs that care about the
> idmapping and that's POSIX ACLs and fscaps. And only if they perform
> permission checks such as posix_acl_update_mode() or something. IOW, it
> depends on what exactly EVM is doing.

In 2/5 we are reading the value of security.evm to look at its contents.

> 
> IIRC, I already added custom security_*() hooks specifically for POSIX
> ACLs as they can't be retrieved through vfs_xattr*() helpers anymore.

