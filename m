Return-Path: <linux-kernel+bounces-49979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0640C847276
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65A76B29248
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00840145B22;
	Fri,  2 Feb 2024 14:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MtJy1EyA"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695D914532F;
	Fri,  2 Feb 2024 14:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706885985; cv=none; b=UkC0MeFY1NoQKBPKKolbq5pzn8zeQ4mo6NCd/UJbL6ZSLI6POgJT5KNsvgQ+pZzjO/jmNCVpynaNsHrP0VAnA4Sk/PqTNJBpdgmtEm3GVDz49WxlIb3Bap8vTWe7GXmRwpQgSMnFc7OhVjgvIv4MZYiDwcY29RcGkF80MTl8dhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706885985; c=relaxed/simple;
	bh=j9o/D4PX8P6MAHXX8Li5cakqXSJZBBqE79iYgK9s8xk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=obOO8kWj3Xki5DVzd7Wib8qEzraHRZL1nrSRoShSI85aKK0Nk8A/KruQfD+GrHg+GLQkiejqvgf39Ga+OFjHmrFHktG4KhSaoN0CT4Tog/151OPGEOPtAfB27780fSKZ2AJttGNWvEAlbNFcv93Pg2AR/pnCU9OxPU51d65UIwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MtJy1EyA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 412ElDTD029311;
	Fri, 2 Feb 2024 14:59:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=lavWl5ZUgUmZW7XwY/1Pku4zomLlRtgMX26Nnc+GCZM=;
 b=MtJy1EyA5q7LktsdR4IXWCVqBdi4/reR084RIJ/8sbzYItLurHsAl7FY4iQTrzu36W8s
 dCARAVfJhHuIjxy7OscPneErUp0WQzByxXxOxZklJOIWdfcwDzKVkXwzs5+CjEdv0nZQ
 jwzGfFTP9RcM3noxc2ew/cQ7RKXxy1RhsnLd8f3TqVzLgtiCprs2gEfSfNnw2J5p2ID9
 BJI8PefIQXiA8qHc+yx7EOZvl1rn1d3qfnpHz1JifBZPc9dr7NUgAUmKACSDdoQSrWKv
 V0SGZNloronpOGcrl5MkTt6Cu446BB62AN+Vhx9qsif15GKrgCGV3vSy/cYgss3PHgcm 5Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w12f78aeu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 14:59:21 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 412Elh9X031100;
	Fri, 2 Feb 2024 14:59:20 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w12f78ae0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 14:59:20 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 412CbmDH010564;
	Fri, 2 Feb 2024 14:59:19 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vwd5pbwup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 14:59:19 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 412ExIRw28181208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Feb 2024 14:59:19 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BEA0C58058;
	Fri,  2 Feb 2024 14:59:18 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0997158057;
	Fri,  2 Feb 2024 14:59:18 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  2 Feb 2024 14:59:17 +0000 (GMT)
Message-ID: <427ce381-73fa-48f9-8e18-77e23813b918@linux.ibm.com>
Date: Fri, 2 Feb 2024 09:59:17 -0500
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
 <CAOQ4uxigdNeE+2nfr4VxS9piQf5hez=ryT0a-jzW+tW0BT-zuw@mail.gmail.com>
 <492ea12a-d79d-47da-9bbe-a7f33051bd3f@linux.ibm.com>
 <CAOQ4uxgiO1RbsmqOu4F4Foy-MBPecnEXO7BvgDGz-Lzb1Eysog@mail.gmail.com>
 <4c584bfb-d282-4584-bb20-18c26b1033c0@linux.ibm.com>
 <CAOQ4uxjftr7GGx6tuW_yB_MTaVB57m6p_d=UHhN3Z23YVXY0QQ@mail.gmail.com>
 <11abffea-15c5-4d13-9d0f-edbc54b09bf3@linux.ibm.com>
 <CAOQ4uxjZ6p9+H54G0LNTUnU56WRaoLtWOUj2nOaKJ4JvBGqLVg@mail.gmail.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CAOQ4uxjZ6p9+H54G0LNTUnU56WRaoLtWOUj2nOaKJ4JvBGqLVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nNkl4IhpdK-es4OdrpqLPUVI1hg5a2Li
X-Proofpoint-ORIG-GUID: hrDn8ECO5a-V7MBqtbrwJpXdRv35DWCs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_08,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 mlxlogscore=948 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402020109



On 2/2/24 04:24, Amir Goldstein wrote:
> On Thu, Feb 1, 2024 at 10:35 PM Stefan Berger <stefanb@linux.ibm.com> wrote:

> 
>>
>> and your suggested change to this patch :
>>
>> -       struct inode *inode = d_real_inode(dentry);
>> +       struct inode *inode = d_inode(d_real(dentry, false));;
>>
> 
> In the new version I change the API to use an enum instead of bool, e.g.:
> 
>         struct inode *inode = d_inode(d_real(dentry, D_REAL_METADATA));

Thanks. I will use it.

> 
> This catches in build time and in run time, callers that were not converted
> to the new API.
> 
>> The test cases are now passing with and without metacopy enabled. Yay!
> 
> Too soon to be happy.
> I guess you are missing a test for the following case:
> 1. file was meta copied up (change is detected)
> 2. the lower file that contains the data is being changed (change is
> not detected)

Right. Though it seems there's something wrong with overlayfs as well 
after appending a byte to the file on the lower.

-rwxr-xr-x    1 0        0               25 Feb  2 14:55 
/ext4.mount/lower/test_rsa_portable2
-rwxr-xr-x    1 0        0               24 Feb  2 14:55 
/ext4.mount/overlay/test_rsa_portable2
bb16aa5350bcc8863da1a873c846fec9281842d9 
/ext4.mount/lower/test_rsa_portable2
bb16aa5350bcc8863da1a873c846fec9281842d9 
/ext4.mount/overlay/test_rsa_portable2

We have a hash collision on a file with 24 bytes and the underlying one 
with 25 byte. (-;  :-)

   Stefan

