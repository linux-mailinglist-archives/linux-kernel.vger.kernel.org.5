Return-Path: <linux-kernel+bounces-159735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDC48B3373
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 637421C2109D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7B213CFA9;
	Fri, 26 Apr 2024 08:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YMJephqP"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD8223A8;
	Fri, 26 Apr 2024 08:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714121848; cv=none; b=qiAW6aJFknhqTNxNj1vg+spjKPiqm/LwMsacwL4BHp95JVjNX6OBgBaLN6BOSd3BKu+n1fFfIB88+iHnBzuN6tAIl7shf/lidaHzy8St83T45iEAee+xK5WdY+4O+EFmo8qFFBBe4YNCFAfqkdeOteLCJyPAtwuhYhNfjR5ZIkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714121848; c=relaxed/simple;
	bh=S2X6pFWypFpbDW9r2KdLSKZVM4P13vTCcpvnh3pp7A4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTKq16jFdzPviYF//2e2It7HEyAgSDVHQ7L1UXpERfzv68rqB5Iax2LBaRWaN5R3QCwEiDnGYKz/DIe1Skd/aM7AxB+YsVp5/OK6Pl5+LuXsjA23cDh3tEa2q2dECBY2fAyiIXvSYws1DwGIJE7XR9UE6hyQTu+bGcwUaXViejo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YMJephqP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43Q8ttUE019828;
	Fri, 26 Apr 2024 08:57:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=KmEYx2PBIUTcIiXNnKFIvbDMpi9OOhyjemAZYc14t28=;
 b=YMJephqPzXCOTmDkaEy78H1lpp72NbmDTnzTKyfVGUUHiLd/LdNelzUa6fJcb0jA93Jt
 OkKf+TFMivDo91TdvN99McCY3hb8z3Hn1k859M3KrC8FJuTCf1REfgeS8kI/CdUKoMv/
 giJsfDKgDAcPc+FoCLBeS75YGXB+09iA5MxdXjXCQZyd4OLe5JCaBDAp2g/GoM1ST5ha
 /DzkG82d6sU1izCM2IsNV1g2D4udX8rIvVsEyMJnKGvcatiAoWB/jNzCW0Lr9jaw5dDv
 eqDIDmM6G9/t7rjHJe1yZRDw9IQWJNN3qKFRJKY/KD1cPr3Yih4/N6IkF6odkP/aVD3Z iw== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xr96fr04n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 08:57:23 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43Q6GCU6015289;
	Fri, 26 Apr 2024 08:57:22 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xmshmpnes-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 08:57:22 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43Q8vHa811272674
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 08:57:19 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F05902004B;
	Fri, 26 Apr 2024 08:57:16 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 72A062004D;
	Fri, 26 Apr 2024 08:57:16 +0000 (GMT)
Received: from osiris (unknown [9.171.34.163])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 26 Apr 2024 08:57:16 +0000 (GMT)
Date: Fri, 26 Apr 2024 10:57:14 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        gor@linux.ibm.com, agordeev@linux.ibm.com, svens@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, borntraeger@de.ibm.com
Subject: Re: [PATCH v1 2/2] s390/pgtable: introduce
 _REGION3_ENTRY_HARDWARE_BITS_LARGE
Message-ID: <20240426085714.8950-F-hca@linux.ibm.com>
References: <20240425130555.73132-1-imbrenda@linux.ibm.com>
 <20240425130555.73132-3-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425130555.73132-3-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3XPSf1EYJtKaDONGHk2AEGc_p7Lia8gI
X-Proofpoint-ORIG-GUID: 3XPSf1EYJtKaDONGHk2AEGc_p7Lia8gI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_09,2024-04-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxlogscore=976 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404260057

On Thu, Apr 25, 2024 at 03:05:55PM +0200, Claudio Imbrenda wrote:
> For completeness, introduce _REGION3_ENTRY_HARDWARE_BITS_LARGE,
> containing the hardware bits used for large puds.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>  arch/s390/include/asm/pgtable.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
> index 3da2995fd196..5c0f840eee2a 100644
> --- a/arch/s390/include/asm/pgtable.h
> +++ b/arch/s390/include/asm/pgtable.h
> @@ -262,6 +262,7 @@ static inline int is_module_addr(void *addr)
>  #define _REGION3_ENTRY		(_REGION_ENTRY_TYPE_R3 | _REGION_ENTRY_LENGTH)
>  #define _REGION3_ENTRY_EMPTY	(_REGION_ENTRY_TYPE_R3 | _REGION_ENTRY_INVALID)
>  
> +#define _REGION3_ENTRY_HARDWARE_BITS_LARGE	0xffffffff8000073cUL

_REGION_ENTRY_HARDWARE_BITS is missing too. :)

And this definition also raises the question if the definition of
_SEGMENT_ENTRY_HARDWARE_BITS_LARGE should be changed so it also includes
the table type bits, which it probably should.

These masks are really a bit randomly defined and assume that the
ACCF-Validity control bit is never set, and therefore the ACC bitfield can
be assumed to be software bits (and they are used as such for format 1
segment table entries).

But the ACCF bit is also a hardware bit in any case... oh well.

