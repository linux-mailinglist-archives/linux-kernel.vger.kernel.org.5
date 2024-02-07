Return-Path: <linux-kernel+bounces-56088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CDC84C5C9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1EC9B20FE2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AC7200A8;
	Wed,  7 Feb 2024 07:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e89edPGm"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C49200A4;
	Wed,  7 Feb 2024 07:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707292209; cv=none; b=AZeBSoOincufOKKZjtjj68GGQmBLdZzbBwttl2KUuzHP0rZ8EkLtFF06NWKZoBMT6hxeX2Q3mEJMmii567cS+nhblx75L5KwWzLNoRXCnr1KCZZRchZRm3igUi1s9nNlMipFR1v69tmPxQxSJsr1eZ0qk/Mh+WAKTB46wHPgB5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707292209; c=relaxed/simple;
	bh=zYFI4otJsxqIeo9wFv+WZfxk8yKS5kcgys/lkebUR2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=scKgk1CgS3ijaKMMqPngdKyEDu12rN2ciK24mKLxuv1zG6rX39xoL6Ra1ectzwqr8MFDmYxDpXHJUASHiWDvr0n9SjPlFFc6aCI1PrjrU3mc50o473erKofC6ocOwd/+75ZicfziIKapZnEIFvpuNnQUypMRugG/q1Y4rS8ZoPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e89edPGm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4177d02q007093;
	Wed, 7 Feb 2024 07:49:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Zv4rk/tiCoZ67nGNpsfw66RthfCklXJyCIeO3u1G998=;
 b=e89edPGmEtvWUmxERDtDpuOiLmpWHimqV8dLPqYh6whxTHbuk3kBF++MmqQ3N9mOwQ8S
 ah320dUGwH2occpXQtu09cSEOlhe88FPzfRInIuEPfCBsmSrocCpmPZTvrQrwSt9Fitn
 UP+HuDDvyge7X8sxOhh+hc1MvOI2Neo6mkMEyD5y4fAV0Vmfc2sCR6EjR8q+JSE+L3IR
 AbMAl3FFtiA1XZ77QWVhyslNUEASURwstuOhgh4xTK/KlozD2nrwOeCANbZ0k6T1HjeR
 j2m+2/oyMcFXcbZ6eaEAMnrQudUABCYzcJwFE2tBzwvp+VowHrm/LDcIAmYVSSGDToI8 AA== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w45fxger0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 07:49:50 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4175KHGF008494;
	Wed, 7 Feb 2024 07:49:49 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w221k4167-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 07:49:49 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4177nl7M39059976
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Feb 2024 07:49:48 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A11525805A;
	Wed,  7 Feb 2024 07:49:47 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7025B58051;
	Wed,  7 Feb 2024 07:49:44 +0000 (GMT)
Received: from [9.43.10.191] (unknown [9.43.10.191])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Feb 2024 07:49:44 +0000 (GMT)
Message-ID: <6d9c66ea-3ec0-40b9-a0f1-14734d5b221f@linux.vnet.ibm.com>
Date: Wed, 7 Feb 2024 13:19:43 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [revert commit 9f079dda1433] [mainline] [6.8.0-rc3] [NVME] OOPS
 kernel crash while booting
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        alan.adamson@oracle.com, kch@nvidia.com, hch@lst.de,
        "sachinp@linux.vnet.com" <sachinp@linux.vnet.com>,
        "mputtash@linux.vnet.com" <mputtash@linux.vnet.com>,
        "abdhalee@linux.vnet.ibm.com" <abdhalee@linux.vnet.ibm.com>
References: <a54c8860-18c7-474d-95e2-a0153a2da885@linux.vnet.ibm.com>
 <ZcJxyjfBniERIWiq@kbusch-mbp.mynextlight.net>
From: Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
In-Reply-To: <ZcJxyjfBniERIWiq@kbusch-mbp.mynextlight.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LG8PRONSo3pif8ImlHncm7EYDh3fW3nx
X-Proofpoint-GUID: LG8PRONSo3pif8ImlHncm7EYDh3fW3nx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_02,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=762 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 mlxscore=0 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402070057

Thanks Keith for the patch. I have tested the patch without reverting 
old commits. The patch fixes the issue.

Tested-by: Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>

On 2/6/24 23:22, Keith Busch wrote:
> On Tue, Feb 06, 2024 at 10:05:20PM +0530, Tasmiya Nalatwad wrote:
>> Greetings,
>>
>> [revert commit 9f079dda1433] [mainline] [6.8.0-rc3] [NVME] OOPS kernel crash
>> while booting to kernel
>>
>> Reverting below commit fixes the problem
>>
>> commit 9f079dda14339ee87d864306a9dc8c6b4e4da40b
>>      nvme: allow passthru cmd error logging
> Thanks for the report. Let's take a shot at fixing it before considering
> a revert. I copied you on the patch proposal.
>
-- 
Regards,
Tasmiya Nalatwad
IBM Linux Technology Center


