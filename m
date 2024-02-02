Return-Path: <linux-kernel+bounces-50098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B0B847435
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BB121F2C15C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EAB14AD34;
	Fri,  2 Feb 2024 16:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Gd3aBJRb"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCA01482F0;
	Fri,  2 Feb 2024 16:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889998; cv=none; b=N6DzfcBQHVAqZlej6K0X+zyViFk+94VrNAsZRwYNqVMomi663lwL1MweRST6suSZpDWbmuG5Zn+4p2QoRNXhZVb7BugAfe6OmuQty/0GnIl6DZC0rXEByCHNxzdse9tLzf54lDpLFQa9cu16wSDbsmtIu4iC7ChZdVCHDSMIJNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889998; c=relaxed/simple;
	bh=jLZsE3YE1ug+yBFhGwQ/pC5GaezhyTAOOjZaOlis1/I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UG0p7J/uNxJ7djMFXWE8ljqDQq+TzFkwv5wTd8nSU4AcvwLGzW/RiqoXWDTE2KcM15AtdFb4DWk7XwUXM3ZFvGBRD7GXz3xHoXm14xNdYqIyx+Im/a0amvMHYXwuItid/QGKP8ExZyBTlipQhAMpoccUHpMXGZaWt1PDH4+tyHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Gd3aBJRb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 412FkMYZ008860;
	Fri, 2 Feb 2024 16:06:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=/E+WuCjKQPiiURGGWsjQq1Iyn1sVx7K0BbL4KUuNK8Y=;
 b=Gd3aBJRb8MTIk7JnF/DahHdMyYjTb/eYTIAEu3nxPI+gRoaH19kgTQWeOVZcGJKiAOW+
 7yH2gNn6glpzZmRkC7qG3eR8rvoLr+hnSIsvqx/rFbOr+eUmRu9aCibS+WUxXyUsPPaK
 6VmlO/rFF1iiavsfDLfWblC3Nbo3Sz1vykZWhY1vPehhXA4GJYoOXZB24YStUeruP51k
 rvBbzDbzRT/s69ncTO+m2QJE7k+24B7k+m4WSVkMNOWqIML4m+5uS6i9obJgCaBajYu4
 YTv3VKmBpOjXEzzTw0paoC5O7fW7vW2/Yw9dmNecHbJ5Aq+7mPBB+qi5svHqKfDeXOTX kA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w119t3wy5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 16:06:19 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 412FxvbM029524;
	Fri, 2 Feb 2024 16:06:18 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w119t3wx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 16:06:18 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 412E6BSP007179;
	Fri, 2 Feb 2024 16:06:17 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vwev2uv99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 16:06:17 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 412G6HRr17629872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Feb 2024 16:06:17 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB3A258061;
	Fri,  2 Feb 2024 16:06:16 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A43858057;
	Fri,  2 Feb 2024 16:06:16 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  2 Feb 2024 16:06:16 +0000 (GMT)
Message-ID: <4ce0e20d-ed14-490d-9446-a6cfbd532bca@linux.ibm.com>
Date: Fri, 2 Feb 2024 11:06:15 -0500
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
 <427ce381-73fa-48f9-8e18-77e23813b918@linux.ibm.com>
 <CAOQ4uxggqa7j0NS1MN3KSvF_qG1FMVmFxacEYSTx+LuvuosJ5g@mail.gmail.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CAOQ4uxggqa7j0NS1MN3KSvF_qG1FMVmFxacEYSTx+LuvuosJ5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2y_aCeSLe7tGdxEIE6jRH5UhMSX_MP9d
X-Proofpoint-GUID: vr8S7mobe0get83rL5-UGnw9YD3sTiCY
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 impostorscore=0 spamscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402020116



On 2/2/24 10:51, Amir Goldstein wrote:
> On Fri, Feb 2, 2024 at 4:59 PM Stefan Berger <stefanb@linux.ibm.com> wrote:
>>
>>
>>
>> On 2/2/24 04:24, Amir Goldstein wrote:
>>> On Thu, Feb 1, 2024 at 10:35 PM Stefan Berger <stefanb@linux.ibm.com> wrote:
>>
>>>
>>>>
>>>> and your suggested change to this patch :
>>>>
>>>> -       struct inode *inode = d_real_inode(dentry);
>>>> +       struct inode *inode = d_inode(d_real(dentry, false));;
>>>>
>>>
>>> In the new version I change the API to use an enum instead of bool, e.g.:
>>>
>>>          struct inode *inode = d_inode(d_real(dentry, D_REAL_METADATA));
>>
>> Thanks. I will use it.
>>
>>>
>>> This catches in build time and in run time, callers that were not converted
>>> to the new API.
>>>
>>>> The test cases are now passing with and without metacopy enabled. Yay!
>>>
>>> Too soon to be happy.
>>> I guess you are missing a test for the following case:
>>> 1. file was meta copied up (change is detected)
>>> 2. the lower file that contains the data is being changed (change is
>>> not detected)
>>
>> Right. Though it seems there's something wrong with overlayfs as well
>> after appending a byte to the file on the lower.
>>
>> -rwxr-xr-x    1 0        0               25 Feb  2 14:55
>> /ext4.mount/lower/test_rsa_portable2
>> -rwxr-xr-x    1 0        0               24 Feb  2 14:55
>> /ext4.mount/overlay/test_rsa_portable2
>> bb16aa5350bcc8863da1a873c846fec9281842d9
>> /ext4.mount/lower/test_rsa_portable2
>> bb16aa5350bcc8863da1a873c846fec9281842d9
>> /ext4.mount/overlay/test_rsa_portable2
>>
>> We have a hash collision on a file with 24 bytes and the underlying one
>> with 25 byte. (-;  :-)
> 
> https://docs.kernel.org/filesystems/overlayfs.html#changes-to-underlying-filesystems
> 
> If you modify the lower file underneath overlayfs, you get no
> guarantee from overlayfs about expected results.
> 
> This makes your work more challenging.
The odd thing is my updated test case '2' seems to indicate that 
everything already works as expected with CONFIG_OVERLAY_FS_METACOPY=y. 
After causing copy-up of metadata changes to the file content on the 
lower layer still cause permission error to file execution on the 
overlay layer and after restoring the file content on the lower the file 
on the overlay again runs as expected. The file content change + copy-up 
of file content also has completely decoupled the lower file from the 
file on the overlay and changes to the file on the lower cause no more 
file execution rejections on the overlay.

  Stefan
> 
> Thanks,
> Amir.

