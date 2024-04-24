Return-Path: <linux-kernel+bounces-156825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA5C8B08CC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0D9BB2126E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B820315B0F0;
	Wed, 24 Apr 2024 11:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Id80e8du"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F2E158DDD;
	Wed, 24 Apr 2024 11:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713959789; cv=none; b=kJq7/AaAZ5GIua2sg+Z9f9FJCL6TsXcV6S9FHjdHD05b9sTVwhtyYcByyPX+fm6sVXG85G/+RrAzVE+nCeoNTnv3bWHEZjPRNHHylGsILVCbV5+VEu2wuaNmqEfEvRp7n20iZA1eF6vT2WVzmsdsLUJZC4xjdlEXMUYqrOQlQHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713959789; c=relaxed/simple;
	bh=tAHa0uAP1XOIzwk0meIwhRRVXUzUhQWgzB2b6tqoVDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qewSW49Oh/Xgjy+uoaVlZkhPNVvXo+YyDqdMLiPs42tDaDHiX2JZ3Eno8K9K+d88FCPjHuf6B18SfV+1zrvKatCz3dJrRjIMKFkasmNJ/UMkoKNjCSCBmkm8cczsibeIMpypfqCNa77d+9Lqoc5omhpxHO/JpZslACftPIanAbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Id80e8du; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43OBqf4c020542;
	Wed, 24 Apr 2024 11:56:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=XpH7mlduGY+teRfPIZDry1r3MxwXhD+lR2HCJ3M7h20=;
 b=Id80e8du9KRHgkzMQaMuQ9JzazbKiuyAGb974iHcfri4PgE4w2/QmgBfdkh/FLLn4LEq
 slJgP6wLd6NmCKlAWqINqRJ7aCEz+kr/wb8DiAmKvSDbm8Si8MDPkmIIHIdN5FlUK5CA
 Kndcr3Xd9hVkD6HFYLYiZZYwRlwXgnIeFrSHXdtKTLyH0fGGU0JfHZlVZkdyh2qzw8Jh
 yPDnqJHqHMrpMwnbAORuuLmHCGDnYYMl8TFBda3wNUm7Xd8kCwrfL+u52ZI/lMHblLRX
 7LVpJyYvnSrdqPhzC2gnGDG3oZ5gxAnGHcWrRhDGv1wU3TXdIbmQDbjusoaqGgNMTUHX 6A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xq0sag3k9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 11:56:08 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43OBu7rI027504;
	Wed, 24 Apr 2024 11:56:07 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xq0sag3k4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 11:56:07 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43O9AlZS005355;
	Wed, 24 Apr 2024 11:56:06 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xmx3cj5ym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 11:56:06 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43OBu1o138732126
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 11:56:03 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 078132004F;
	Wed, 24 Apr 2024 11:56:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 492CE2004D;
	Wed, 24 Apr 2024 11:55:59 +0000 (GMT)
Received: from osiris (unknown [9.171.4.217])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 24 Apr 2024 11:55:59 +0000 (GMT)
Date: Wed, 24 Apr 2024 13:55:57 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>,
        Rasesh Mody <rmody@marvell.com>,
        Sudarsana Kalluru <skalluru@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
        Krishna Gudipati <kgudipat@brocade.com>,
        Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Fabian Frederick <fabf@skynet.be>,
        Saurav Kashyap <skashyap@marvell.com>,
        Javed Hasan <jhasan@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        Nilesh Javali <nilesh.javali@cavium.com>,
        Arun Easi <arun.easi@cavium.com>,
        Manish Rangankar <manish.rangankar@cavium.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, Saurav Kashyap <saurav.kashyap@cavium.com>,
        linux-s390@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 5/5] drivers/s390/cio: ensure the copied buf is NULL
 terminated
Message-ID: <20240424115557.26193-A-hca@linux.ibm.com>
References: <20240422-fix-oob-read-v1-0-e02854c30174@gmail.com>
 <20240422-fix-oob-read-v1-5-e02854c30174@gmail.com>
 <20240423065052.10211-C-hca@linux.ibm.com>
 <e4f5cbd0-c803-4c3c-9703-f52e56864106@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4f5cbd0-c803-4c3c-9703-f52e56864106@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uhfqRBb54eWKPef2hDdJnIwSrSgU2j72
X-Proofpoint-ORIG-GUID: gLWakaQraUUUlMZLADf4xlA10NLu8ZwJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_08,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=767
 lowpriorityscore=0 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404240046

On Tue, Apr 23, 2024 at 09:46:35PM +0700, Bui Quang Minh wrote:
> > > -	buffer = vmemdup_user(buf, lbuf);
> > > +	buffer = vmemdup_user(buf, lbuf + 1);
> > >   	if (IS_ERR(buffer))
> > >   		return -ENOMEM;
> > > +	buffer[lbuf] = '\0';
> > 
> > This would read one byte too much from user space, and could potentially
> > fault.
> > 
> > Why isn't this simply memdup_user_nul() like all others, which would do the
> > right thing?
..
> For this case, as the original code uses vmemdup_user, which internally uses
> kvmalloc not kmalloc, so I try to keep the original behavior. And
> vmemdup_user does not have the counterpart vmemdup_user_nul. I can
> kvmalloc(lbuf + 1), then copy_to_user(lbuf) and set buffer[lbuf] = '\0' or
> do you think I should create vmemdup_user_nul?

There is no need for vmalloc() instead of kmalloc() for this particular
case. The input string is supposed to be rather short (see the sscanf()
call). So converting to memdup_user_nul() is sufficient and solves the
potential problem.

