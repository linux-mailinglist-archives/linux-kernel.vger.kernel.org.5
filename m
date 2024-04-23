Return-Path: <linux-kernel+bounces-154574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5DD8ADDCC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CA5B1F21D18
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 06:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8B62B2CF;
	Tue, 23 Apr 2024 06:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p1KCIPLA"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18D5F505;
	Tue, 23 Apr 2024 06:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713855103; cv=none; b=YPprvMEU2hOMq2x/ALeoIK8kcuhxmBRU/c1rELMXTXburP4GPpNsWgqfTv2TlEuW1S071au5SXQNIkCY7msJ7tToeP1wUluPWcQVlsxcEuBNClDOMWaHjUfGaKqA4Nlw3cEqpuPgJOooFot6NdQlZ6MhTmR5K8jZTDaHW9LCi8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713855103; c=relaxed/simple;
	bh=QperoU/mvTPRltqXgO/IwLoya48jN35EvU9e2LuVbn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FoUtwfucOD5MAb6OAyRSCQUYAkRY3RVBz/O+QUcqdEWBQtLUaLGHW52lsRSM6OFImJZ8S2hPSJa9Q04Ep7usVD/cAENpCu/2KMrMRM83UL7p36ctj6IQ07uIIHRPby0xKzX524XLLkYOG8mrrGOMotklghow/PdkveGBwntdgtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p1KCIPLA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43N6WiAK032224;
	Tue, 23 Apr 2024 06:51:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=0vDYHtZfJ1aUyePbfpMoafpgYffvxy1KKavTMUyKAF4=;
 b=p1KCIPLA0+3M/jOTJH91Ettn+kfkxFl9NTIwFZkm/W9bK1jNyvqDyW7u7eyRNiT2sHct
 ykLF3vRjDdn61hsC1nO5dBh4XmTDd0Oa1toeaQZ/0x3My4VFJ5oPg2D9yS84c65Huu+c
 dnjYWyrHG2dj8tYNBLIYnoDpnStf3ZwBWi9WL68PmylT+N2qQPo9uarstANzXbl82Cce
 L26wYggPXUsxa/yyjkJOBDKuK6xXsHe6p6a5p3V4xzY1AXnI89/UmmdSGhPn+WyIJ5MR
 GLM9dQZXRPFnxN6uA5VTFDa6X9LMRHEjDTQpS5c7GQnr9lCg2do4q/diWsEjB4qvBYoB PQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xp7t6g10p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 06:51:02 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43N6p1NU002965;
	Tue, 23 Apr 2024 06:51:02 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xp7t6g10g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 06:51:01 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43N6fD5W020920;
	Tue, 23 Apr 2024 06:51:00 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xmrdyv8r3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 06:51:00 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43N6osOE41681280
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 06:50:56 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1EEE2004D;
	Tue, 23 Apr 2024 06:50:54 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2956D20040;
	Tue, 23 Apr 2024 06:50:54 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 23 Apr 2024 06:50:54 +0000 (GMT)
Date: Tue, 23 Apr 2024 08:50:52 +0200
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
Message-ID: <20240423065052.10211-C-hca@linux.ibm.com>
References: <20240422-fix-oob-read-v1-0-e02854c30174@gmail.com>
 <20240422-fix-oob-read-v1-5-e02854c30174@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422-fix-oob-read-v1-5-e02854c30174@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JfbWZJYjgQ-6sEoUNR3sO4YsC4Gb-N7m
X-Proofpoint-ORIG-GUID: dN-FvMKmlspL8yk4i7YrijWq2YdDYnU8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_04,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=965 bulkscore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2404010000 definitions=main-2404230019

On Mon, Apr 22, 2024 at 11:41:40PM +0700, Bui Quang Minh wrote:
> Currently, we allocate a lbuf-sized kernel buffer and copy lbuf from
> userspace to that buffer. Later, we use scanf on this buffer but we don't
> ensure that the string is terminated inside the buffer, this can lead to
> OOB read when using scanf. Fix this issue by allocating 1 more byte to at
> the end of buffer and write NULL terminator to the end of buffer after
> userspace copying.
> 
> Fixes: a4f17cc72671 ("s390/cio: add CRW inject functionality")
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>  drivers/s390/cio/cio_inject.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/cio/cio_inject.c b/drivers/s390/cio/cio_inject.c
> index 8613fa937237..9b69fbf49f60 100644
> --- a/drivers/s390/cio/cio_inject.c
> +++ b/drivers/s390/cio/cio_inject.c
> @@ -95,10 +95,11 @@ static ssize_t crw_inject_write(struct file *file, const char __user *buf,
>  		return -EINVAL;
>  	}
>  
> -	buffer = vmemdup_user(buf, lbuf);
> +	buffer = vmemdup_user(buf, lbuf + 1);
>  	if (IS_ERR(buffer))
>  		return -ENOMEM;
>  
> +	buffer[lbuf] = '\0';

This would read one byte too much from user space, and could potentially
fault.

Why isn't this simply memdup_user_nul() like all others, which would do the
right thing?

