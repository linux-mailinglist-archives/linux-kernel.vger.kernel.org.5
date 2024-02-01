Return-Path: <linux-kernel+bounces-48424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE23C845BC7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5091E1F28419
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E3A626A9;
	Thu,  1 Feb 2024 15:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b+LHouYw"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C8F6215A;
	Thu,  1 Feb 2024 15:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706802103; cv=none; b=aCeA7ouYoBBvPIEl7BBMBVI4TPM9ibL8wX7uHJq7386ZRURiKE66qhXjY11M1m30TpN2zYlyiJdt7UoUxrZUpN9xOXFPVko7TRuysSu+C9/LAAUtCjj638QbgEcItefvVII4WyEHebek1bIfBmsU7OJl5ZHzk1HjBtGPWpqxt0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706802103; c=relaxed/simple;
	bh=MgEx7ikC/L4/Xtdmd2xJp/5oDdEwDQ4koi6z3CAZUC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PDfhCp+71d/WsUff0fMo0tRIe3g6yuZWPeXRaDiHzQ25WXgoNjWPNNMRNkxAu1Zu6Rd37FGK80Q6Rut/Xi2+zh0m929f445AetBxjWD0HufMzFA/Ph4bD7GkprOfyMK/2t/0N22zj+yfYxMV0xisoHEuYrLFNaR+qhFrEpZkPqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b+LHouYw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 411FSWak015663;
	Thu, 1 Feb 2024 15:41:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Xp4rZMTnVnBxefF1gjpPyi1EmVRo9E8xKDqZHXLJzqY=;
 b=b+LHouYwHS0fb9Q7EGgDXLfIpOkgJExmtVSDjpPdoBu5mqRrA5T1NryEWAK83tW4m1cL
 6Rctj3Y1jcuIlzPfYH3n/gMNjjgX+XeQYm+RvrHZOuTGR55Jw2q701K1Sr526hJWWIKB
 Hxrm1IgrUCMqOoXeFShNCwrSIJAP/iviO86P1Q3DCPfHLNDKwuoYLD8uH7qXmZhJbvAM
 +KL6yy1ntEycSPKk+0af4F9ybcSa9XghWsHMXOZCl3htOsirS3Ii04j+O70x6L3U0C6d
 Wtnaw7xYhV0EgiehsMa7fxZByajmQOUFfGaVFyv7nHaWuJ2yF5/9Mct+XYUSI8V4W0Hf mg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w0dyq8hwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 15:41:18 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 411FSdip016911;
	Thu, 1 Feb 2024 15:41:18 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w0dyq8hw1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 15:41:18 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 411DOgaN008242;
	Thu, 1 Feb 2024 15:41:17 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vwdnmcwhu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 15:41:17 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 411FfG0o15598114
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Feb 2024 15:41:17 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9D535805A;
	Thu,  1 Feb 2024 15:41:16 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0AAC158051;
	Thu,  1 Feb 2024 15:41:16 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Feb 2024 15:41:15 +0000 (GMT)
Message-ID: <093ffc74-c5f5-49e7-8be9-77158336c878@linux.ibm.com>
Date: Thu, 1 Feb 2024 10:41:15 -0500
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
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        zohar@linux.ibm.com, roberto.sassu@huawei.com, miklos@szeredi.hu,
        Christian Brauner <brauner@kernel.org>
References: <20240130214620.3155380-1-stefanb@linux.ibm.com>
 <20240130214620.3155380-2-stefanb@linux.ibm.com>
 <CAOQ4uxjgdvGU0WE+92ByQE26Jp0j16AgfyCjNyEp7=86akOSsA@mail.gmail.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CAOQ4uxjgdvGU0WE+92ByQE26Jp0j16AgfyCjNyEp7=86akOSsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mCEDx2t6kjyYzg4wr37jSslbfkLndMPF
X-Proofpoint-GUID: U6FrtjlUTDFwrRHkX7hlF_HbsAvcq00R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_03,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=582
 priorityscore=1501 mlxscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402010123



On 1/31/24 08:25, Amir Goldstein wrote:
> On Tue, Jan 30, 2024 at 11:46 PM Stefan Berger <stefanb@linux.ibm.com> wrote:
>>
>> Copying up xattrs is solely based on the security xattr name. For finer
>> granularity add a dentry parameter to the security_inode_copy_up_xattr
>> hook definition, allowing decisions to be based on the xattr content as
>> well.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> ---
>>   fs/overlayfs/copy_up.c            | 2 +-
>>   include/linux/evm.h               | 2 +-
>>   include/linux/lsm_hook_defs.h     | 3 ++-
>>   include/linux/security.h          | 4 ++--
>>   security/integrity/evm/evm_main.c | 2 +-
>>   security/security.c               | 7 ++++---
>>   security/selinux/hooks.c          | 2 +-
>>   security/smack/smack_lsm.c        | 2 +-
>>   8 files changed, 13 insertions(+), 11 deletions(-)
>>
>> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
>> index b8e25ca51016..bd9ddcefb7a7 100644
>> --- a/fs/overlayfs/copy_up.c
>> +++ b/fs/overlayfs/copy_up.c
>> @@ -114,7 +114,7 @@ int ovl_copy_xattr(struct super_block *sb, const struct path *oldpath, struct de
>>                  if (ovl_is_private_xattr(sb, name))
>>                          continue;
>>
>> -               error = security_inode_copy_up_xattr(name);
>> +               error = security_inode_copy_up_xattr(old, name);
> 
> What do you think about:
> 
>                       error = security_inode_copy_up_xattr(name, NULL, 0);

We need 'old'.
> 
> and then later...
> 
>                       error = security_inode_copy_up_xattr(name, value, size);

Are these parameter used to first query for the necessary size of the 
buffer and then provide the buffer to fill it? Or should the function 
rather take an existing buffer and realloc it if necessary and place the 
value of the xattr into it? Unfortunately this function currently 
returns '1' for 'discard', so returning the size of the xattr value from 
it maybe not ideal but it would require maybe yet another parameter that 
indicates what the size of the xattr value is.

    Stefan

> 
> I am asking because overlayfs uses mnt_idmap(path->mnt) and you
> have used nop_mnt_idmap inside evm hook.
> this does not look right to me?
> 
> Thanks,
> Amir.

