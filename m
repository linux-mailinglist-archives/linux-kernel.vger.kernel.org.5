Return-Path: <linux-kernel+bounces-101674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B3A87AA57
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 742C0281BEA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C2A4654F;
	Wed, 13 Mar 2024 15:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f08oAtky"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8859146425;
	Wed, 13 Mar 2024 15:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710343455; cv=none; b=jgEt4IWrOTNBIuOt5qEd0yCNg+SwDN5+Cb3CYHRDZwXIvHTInIKu1lwU9NXPKdL2hVbxlLkBuf1UpTW5qlF/pAG5PXMhtVZTQh/p2EIm2I3SRf/a9XV7wPhK1A3dQ96TU0j2i/7TyQHmQzTXGrmvCA1txRYVIB2U/HGZ2MUUDsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710343455; c=relaxed/simple;
	bh=zLmTYamDLg7r/N+uNsQ1UpNtH7QKvcEeuvYnyZUx54M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uaQsA1mbeR9pUlsc0FcXEBmNKPWXKP321DdsYfsoLG2yHZSxSHmUht/2UbDwE107VhWNGbHvLDdv+nGexMOxv0lQywKS5ZjKGGgqHM1+wxob/xum8RIsmALIeYlz4mUexHJKeWNl7qVSNNM8guSomzxzGIcnde+u2891P0sUoqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f08oAtky; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42DEsIaf001099;
	Wed, 13 Mar 2024 15:24:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=HwySBDppIHFt2ysh7QvtukIj8GXUdrmsCOcwJBJI6TI=;
 b=f08oAtkyPNRWhv7N0xsFNfd9Us2f5MoNGPFQJU49ztTsCYV4M6q0T76yMiBPzWlYWFv8
 f0qdNfGdxVXqHLmGCi8cLYzjXbdanLSSzAAxWCpt+67bQOylf5NBRsqryIuntfLKyhm8
 kAahPMwaitPcIsWVjvu3MzoXNye96SX5Q/cp5Uf0IoKcE0TaWvrA8wQI4DYiSzXxRhQP
 9++UoJdFOkQ3oVSoGGKWnvl+gweCrErFgXzYmlvsXZfDJLjnTF0yqaNTbyECN6dFne6E
 o0+MqCUiqOniVJAgTcxThbnMmQ7CSOEpR2gq58oemOIvkTA3qbz1NXPsS/r+dFIXrKCO Mg== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wud2rj892-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 15:24:11 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42DELQYX013603;
	Wed, 13 Mar 2024 15:24:10 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ws4ake9r4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 15:24:10 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42DFO5JD38142330
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Mar 2024 15:24:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2251120043;
	Wed, 13 Mar 2024 15:24:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E76D620040;
	Wed, 13 Mar 2024 15:24:04 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 13 Mar 2024 15:24:04 +0000 (GMT)
Date: Wed, 13 Mar 2024 16:24:03 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Vineeth Vijayan <vneethv@linux.ibm.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v1 1/1] s390/cio: Use while (i--) pattern to clean up
Message-ID: <20240313152403.7008-D-hca@linux.ibm.com>
References: <20240222134501.236871-1-andriy.shevchenko@linux.intel.com>
 <b4fd2ff7-9b3e-4059-9277-bef5d66bd129@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4fd2ff7-9b3e-4059-9277-bef5d66bd129@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: K4logmEkiQQUNRORr8CuWz5Y_CVckGN3
X-Proofpoint-GUID: K4logmEkiQQUNRORr8CuWz5Y_CVckGN3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_09,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=695 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403130116

On Wed, Mar 13, 2024 at 03:57:53PM +0100, Vineeth Vijayan wrote:
> 
> 
> On 2/22/24 14:45, Andy Shevchenko wrote:
> > Use more natural while (i--) patter
> 
> typo: pattern
> 
> to clean up allocated resources.
> > 
> > Signed-off-by: Andy Shevchenko<andriy.shevchenko@linux.intel.com>
> > ---
> >   drivers/s390/cio/ccwgroup.c | 4 ++--
> >   drivers/s390/cio/chsc.c     | 2 +-
> >   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> Otherwise, looks sane to me.
> Acked-by: Vineeth Vijayan <vneethv@linux.ibm.com>

Applied with typo fixed, thanks!

