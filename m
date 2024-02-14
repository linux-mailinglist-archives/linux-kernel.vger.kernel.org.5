Return-Path: <linux-kernel+bounces-65791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBA28551E1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5CE11F29581
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBF11292D9;
	Wed, 14 Feb 2024 18:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CZCczcjL"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB5B85945
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 18:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707934442; cv=none; b=M4MS0HPpjTuDkBu+GRUiAfRqO3UDVAhQcsAn60MgsWQE8iB37/bdlH9+HhccKYK8c0F+v6RGqfXK4OYDoPolRIhHz5oRdAwFKmLaQqNOV5jz3sd8x3141AUW57XSTX5N1stlD1xBPPSlGWm9WFnyjHB3u6ZULYxgfQ2BhKA6MUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707934442; c=relaxed/simple;
	bh=hOxEivDLsFec5G+fAwHAZxlvSMbmWFiqoMuk2OF8eAw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EWrRDqrg9EKlugMDvrhDhjcDUDpkG2YSjRKbAiNR2M2vZZnki6a/TlkyqzoNLHGxRmFuO5qSPgoxsF5F3+vqYIK24+ear1uVmXsg7ZGUBBvKP7MpPecDcEOaGm9gnA65tEMHMl3FYKLeqD3hwhafj3HiyJ7IYfvtsElvzSj6NLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CZCczcjL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41EI2G3o027548;
	Wed, 14 Feb 2024 18:13:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=d/KbLmi+nBD4mrD2m/5GEPKn/dBx91j9UFtWVJsZHbY=;
 b=CZCczcjLTNCsDzNjriXciofWvVF76lsAjbUWndecqHVnBQ71yq9VAoIVZtoCHtmrKaLa
 BXTjwm1qFV+Yt0aB/Zuyv5ghdOLAv5gFdtNR9Tnw8F09DTBpqOCSAzOzLwcaBKQGB11I
 phLp7l0tp7umNF+2I28MO8Q/TbnWAv/udS23iWiJURnkTIuFJhEB+08VlsHzd9oBAaD6
 9IuBAsfG7vr/T19ru/I90O9b9njqyMo8xSfuo7THLbWFyRlLgGZQZ29JWcGaa3qlR2DW
 OxiV+shwTVUI0nb1ZqOU6KsuOVJSiCG81pI9LsC3aoy/+mGn3OAYOexVqsmjBhNBeSK4 4g== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w92eq8awe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 18:13:40 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41EI2fr9029078;
	Wed, 14 Feb 2024 18:13:40 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w92eq8aw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 18:13:40 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41EHsElB009920;
	Wed, 14 Feb 2024 18:13:39 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6p62y32u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 18:13:39 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41EIDXl362783962
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 18:13:35 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A66D520071;
	Wed, 14 Feb 2024 18:13:33 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E93BF2006A;
	Wed, 14 Feb 2024 18:13:29 +0000 (GMT)
Received: from [9.43.53.225] (unknown [9.43.53.225])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Feb 2024 18:13:29 +0000 (GMT)
Message-ID: <0abafe3e-7dfd-4067-8a47-fa8eea00b232@linux.ibm.com>
Date: Wed, 14 Feb 2024 23:43:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/iommu: Fix the missing iommu_group_put() during
 platform domain attach
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>, iommu@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        npiggin@gmail.com, christophe.leroy@csgroup.eu,
        aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com, jroedel@suse.de,
        tpearson@raptorengineering.com, aik@amd.com, bgray@linux.ibm.com,
        gregkh@linuxfoundation.org, gbatra@linux.vnet.ibm.com,
        vaibhav@linux.ibm.com, Michael Ellerman <mpe@ellerman.id.au>
References: <170784021983.6249.10039296655906636112.stgit@linux.ibm.com>
 <20240213172128.GM765010@ziepe.ca>
 <4f5e638d-30a2-4207-b515-d07c20b0fb47@linux.vnet.ibm.com>
 <87le7n6wcf.fsf@mail.lhotse> <20240214125819.GA1299735@ziepe.ca>
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
In-Reply-To: <20240214125819.GA1299735@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ayh_vcvCY-br2aPjrm37jCvWW48SBiVu
X-Proofpoint-ORIG-GUID: W9AtKL8zdxS3o3scSejlP-3MJfG_6ZpM
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
 definitions=2024-02-14_10,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 mlxlogscore=744
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402140142


On 2/14/24 18:28, Jason Gunthorpe wrote:
> On Wed, Feb 14, 2024 at 11:53:20PM +1100, Michael Ellerman wrote:
>> Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com> writes:
>>> Thanks for the patch. Applied this patch and verified and issue is fixed.
>>>
>>> This issue way originally reported in the below mail.
>>>
>>> https://marc.info/?l=linux-kernel&m=170737160630106&w=2
>> Please use lore for links, in this case:
>>
>> https://lore.kernel.org/all/274e0d2b-b5cc-475e-94e6-8427e88e271d@linux.vnet.ibm.com/
> Also if you are respinning you may prefer this
>
> @@ -1285,14 +1285,15 @@ spapr_tce_platform_iommu_attach_dev(struct iommu_domain *platform_domain,
>                                      struct device *dev)
>   {
>          struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> -       struct iommu_group *grp = iommu_group_get(dev);
>          struct iommu_table_group *table_group;
> +       struct iommu_group *grp;
>          int ret = -EINVAL;
>   
>          /* At first attach the ownership is already set */
>          if (!domain)
>                  return 0;
>   
> +       grp = iommu_group_get(dev);
>          if (!grp)
>                  return -ENODEV;
>
> Which is sort of why this happened in the first place :)

Right! Posted the v2 here

https://lore.kernel.org/linux-iommu/170793401503.7491.9431631474642074097.stgit@linux.ibm.com/


Thanks,

Shivaprasad

> Jason

