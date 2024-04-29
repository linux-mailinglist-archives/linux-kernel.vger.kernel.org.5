Return-Path: <linux-kernel+bounces-162340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 094428B59D2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F5B2B2534A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339D956B6A;
	Mon, 29 Apr 2024 13:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VqczON2z"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2FD53E08;
	Mon, 29 Apr 2024 13:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714396322; cv=none; b=G+XHS1ft2U++hqZTRhJUX8rXFU6xM6i9ZwQfq3aYfX91yGlDvwOWnxzUkG5QP4ZvIgdorWGlWEmtwZzHcnLdWsYzpxZIjrHU/QJZJDLnvTKgt+MggdEPL2riS4jVYXTF8l8FtZnrInAKNd3DA33VT5AFbxwB44icOkANxnm4XHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714396322; c=relaxed/simple;
	bh=MFWWHdC5SeCYB1p3vDQDuMwidEp6zCaFXCem7rFaIiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pksd+43y+TGjvTi63Iyfurwv/JehTZnjhUY0dxIrGFK5A8YWS8YZe5e65g+exPpUB0P3AwNgHox1IHn643C26vypQv3rjY59vHyPJHsvbwpJE6wrJhW4mvQayGnIowC2lx2QaxKvTh2g19WRrcZ6/X5jP0viIdvswmBh5L3pQFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VqczON2z; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43TBPnnD025305;
	Mon, 29 Apr 2024 13:11:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Nukm+9MkQ5xXDW8B5Fz9uUrwSluyRvivZVwj+fVZxM8=;
 b=VqczON2zkBlZM53dEYiQdTainh5BkE+3A7az8MKWJXVDbo3cYs6eoJMFsGjS77nqWr9K
 FlpiH9zHTHWj1AVZBpGeI1yb1VNRnrUBcHZiLCa6xN+VJdEDpBW5v1h0GYkqi66tMlvH
 erF86dhaJYQpEE9Uf5Yhpx0mUkd9li7nup37f0c7aW5G6yKMxzBEUwCpcby9mmIFqew5
 EiA6VuXdM2V1ULUy5XWOTDazCcMy7RTvR7h+3ywewgZm0DnvXm5Zdo3BBuXiOF874nHK
 efCCfS19BUF9Y89tiQYp73wec9WK+rMMRuwK0aRU7+TaK8BcaWva+9OtgvSyeoIsqe3g sQ== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xta8egbtg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 13:11:58 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43TBrCXa003038;
	Mon, 29 Apr 2024 13:11:57 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xscpp7d3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 13:11:57 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43TDBpDB50004390
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 13:11:53 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8561A2004B;
	Mon, 29 Apr 2024 13:11:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2BA8E20040;
	Mon, 29 Apr 2024 13:11:51 +0000 (GMT)
Received: from osiris (unknown [9.171.12.101])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 29 Apr 2024 13:11:51 +0000 (GMT)
Date: Mon, 29 Apr 2024 15:11:49 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        gor@linux.ibm.com, agordeev@linux.ibm.com, svens@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, borntraeger@de.ibm.com
Subject: Re: [PATCH v3 2/2] s390/pgtable: add missing hardware bits for puds,
 pmds
Message-ID: <20240429131149.29046-M-hca@linux.ibm.com>
References: <20240426120447.34318-1-imbrenda@linux.ibm.com>
 <20240426120447.34318-3-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426120447.34318-3-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qZnZdy1HxWS5r3pjECRQsHEFvfT-Bn38
X-Proofpoint-ORIG-GUID: qZnZdy1HxWS5r3pjECRQsHEFvfT-Bn38
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_10,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0
 spamscore=0 malwarescore=0 mlxscore=0 suspectscore=0 mlxlogscore=899
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404290083

On Fri, Apr 26, 2024 at 02:04:47PM +0200, Claudio Imbrenda wrote:
> Add the table type and ACCF validity bits to _SEGMENT_ENTRY_BITS and
> _SEGMENT_ENTRY_HARDWARE_BITS{,_LARGE}.
> 
> For completeness, introduce _REGION3_ENTRY_HARDWARE_BITS_LARGE and
> _REGION3_ENTRY_HARDWARE_BITS, containing the hardware bits used for
> large puds and normal puds.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>  arch/s390/include/asm/pgtable.h | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

..
> +#define _REGION3_ENTRY_HARDWARE_BITS_LARGE	0xffffffff8001073cUL
> +#define _REGION3_ENTRY_HARDWARE_BITS		0xfffffffffffff6ffUL
..
> +#define _SEGMENT_ENTRY_BITS			0xfffffffffffffe3fUL
> +#define _SEGMENT_ENTRY_HARDWARE_BITS		0xfffffffffffffe3cUL
> +#define _SEGMENT_ENTRY_HARDWARE_BITS_LARGE	0xfffffffffff1073cUL

Please resend and make sure the order (BITS, BITS_LARGE, ...) is the
same; then Alexander can pick this up.

For the definitions:
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>

