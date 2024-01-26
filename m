Return-Path: <linux-kernel+bounces-40257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A45D283DD48
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99FA2B26141
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6601CF81;
	Fri, 26 Jan 2024 15:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WbCFRpYo"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CB91D527
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706282379; cv=none; b=oIcT6/kaDgiDGCgXyRna7VLIjXDKlXdc+jP80MlBXNPhc9mDKnaurlx1pLkMrHnPDROVFzvnKtaJuPPrSTVxLF/CHhPyS8qNCHq1pF8ztXfOahOIV4KVgocH+4/YplVr36NtH0rgQEc06mPWukALECwFxc+eeGx3HM1Xa/r9/kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706282379; c=relaxed/simple;
	bh=nYnL08UkXChtBP5jgdIKm7nTSD5MHk7dz2CCVHK8gIE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mCZr82zgQnaGjJPL/NgzwIw6KKWvPThu6Zl6/IMIu/dhBR+1EOGJdwXYNefbNGD5bT3qKC2fDPGzNCi6UcBsw0DYi2e4tx5FQr1DxD83x7RgqxY0tUu0VNG0jfj9Nk73r8fPu2uFA+zm6aJDxFIQuEWpOt8Hs/IXQlTk1dcG83I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WbCFRpYo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40QF2DcZ006856;
	Fri, 26 Jan 2024 15:19:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=V5LjmVGdzbJgz18a5DWViGzLHhFurvsunSeYcuKPsjs=;
 b=WbCFRpYoR0SMUpTyr4yZQ15GGHaNY3SD/MaN0AE/direuhl9CmKTKSnJ8BGIj1a4hTLT
 zuG3ySe9KOyFovBnYlFf88QElSch9MoQJm/EAMo0CxZOVDeQX5LsENuatc4GkRbadQTj
 GtXxzAJo2DYGEjODDaJmV+gqIKQrJetBivW5c3ciNPEgpNFT1+TVkTpmuBAZw843cKHy
 s3PnyjxHTDmcDN24hjdB13KLd2Xl3SKaTyNfPYOo2oU36Kj79yuSCZ6LLF9I6RAzS4Qy
 vSF/Kka+Gun1qaD/aco9VQGoh61UX5ewRXtJSagVUoQb35tEuemSr1GZXQtO4NfZ2r5H CQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vveeuhdyk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 15:19:13 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40QFBR58012048;
	Fri, 26 Jan 2024 15:19:12 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vveeuhdy4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 15:19:12 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40QDaFVO026475;
	Fri, 26 Jan 2024 15:19:12 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vrrgturbm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 15:19:12 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40QFJ9hC40501952
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 15:19:09 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2920220049;
	Fri, 26 Jan 2024 15:19:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0EAF20040;
	Fri, 26 Jan 2024 15:19:05 +0000 (GMT)
Received: from [9.43.53.156] (unknown [9.43.53.156])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Jan 2024 15:19:05 +0000 (GMT)
Message-ID: <c03f81bb-3a50-4191-9884-25a914e60672@linux.ibm.com>
Date: Fri, 26 Jan 2024 20:49:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommu: Fix the domain type checks when default_domain
 is set
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org,
        naveen.n.rao@linux.ibm.com, jroedel@suse.de,
        tpearson@raptorengineering.com, aik@amd.com, bgray@linux.ibm.com,
        gregkh@linuxfoundation.org, gbatra@linux.vnet.ibm.com,
        vaibhav@linux.ibm.com
References: <170618450592.3805.8216395093813382208.stgit@ltcd48-lp2.aus.stglab.ibm.com>
 <170618452753.3805.4425669653666211728.stgit@ltcd48-lp2.aus.stglab.ibm.com>
 <20240125155257.GX50608@ziepe.ca>
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
In-Reply-To: <20240125155257.GX50608@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Yx0JUC79HWRFCurxWhU3gNr5kY8QHd-K
X-Proofpoint-ORIG-GUID: c2je4RH8m4kTZROvYF205gx-VdNobq8C
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=987 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2401260112

On 1/25/24 21:22, Jason Gunthorpe wrote:
> On Thu, Jan 25, 2024 at 06:08:52AM -0600, Shivaprasad G Bhat wrote:
>> On PPC64, the iommu_ops.def_domain_type() is not defined and
>> CONFIG_IOMMU_DMA not enabled. With commit 0f6a90436a57 ("iommu: Do not
>> use IOMMU_DOMAIN_DMA if CONFIG_IOMMU_DMA is not enabled"), the
>> iommu_get_default_domain_type() return IOMMU_DOMAIN_IDENTITY. With
>> commit 2ad56efa80db ("powerpc/iommu: Setup a default domain and remove
>> set_platform_dma_ops"), the defaule_domain is set wih the type being
>> PLATFORM. With these two changes, iommu_group_alloc_default_domain()
>> ends up returning the NULL(with recent changes, ERR_PTR(-EINVAL))
>> leading to iommu_probe_device() failure and the device has no
>> iommu_group set in effect. Subsequently, the bind to vfio(VFIO_IOMMU)
>> fail as the iommu_group is not set for the device.
>>
>> Make the iommu_get_default_domain_type() to take default_domain->type
>> into consideration along with default_domain_type() and fix
>> iommu_group_alloc_default_domain() to not error out if the requested
>> type is same as default domain type.
>>
>> Fixes: 2ad56efa80db ("powerpc/iommu: Setup a default domain and remove set_platform_dma_ops")
>> Fixes: 0f6a90436a57 ("iommu: Do not use IOMMU_DOMAIN_DMA if CONFIG_IOMMU_DMA is not enabled")
>> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
>> ---
>>   drivers/iommu/iommu.c |   14 ++++++++++----
>>   1 file changed, 10 insertions(+), 4 deletions(-)
> Are you OK with this version?
>
> https://lore.kernel.org/linux-iommu/20240123174905.GS50608@ziepe.ca/
>
> ?
>
> I think it does the same thing

Yes, This works. I see a very minor difference of default_domain->type 
is given

precedence over def_domain_type(). Please keep me CC when you post this 
fix, I'll

test it with any(?) other changes if coming along with it.


Thanks,

Shivaprasad

> Jason

