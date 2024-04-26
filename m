Return-Path: <linux-kernel+bounces-159729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F24CB8B3343
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEFA1282B21
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4176813C9AA;
	Fri, 26 Apr 2024 08:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YYK/UEaJ"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6406514293;
	Fri, 26 Apr 2024 08:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714121433; cv=none; b=fzfKILN/pX5TOSZYbtzrX6gxlxyKcP0xww5zuTUCLF0MZsDg1bmHw4TbjYlbnKU50eZ+dN5Cv/H1Bpd8Nen8CIhiWk30z42hpdyruTxtVNY37mEVmmiU2qeflhT3KIQfLX6tpMyTIECyk9xHuQ3PaoJcVIO5SPq1ktSdXhDAwi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714121433; c=relaxed/simple;
	bh=KRBem6yyH/hsarYTRIMbpvFb6J+7dWjqrcQljKdmr9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1EKfdZJfQSiWObnc3/XFgfFffFASVTMckAN4Ml3GRZWX7kze+tSZKS8tYVvFFwa8Y7PP6bdt/CY5WYtI/sE+uBfpXSIIiZnA4oGvwIDSF/tTnVj9jkSTMAT7yAvJpjKgLEWSv9zcQzvkm0K+Q4TnMYl0JuNxx//0zZ3F7KZIFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YYK/UEaJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43Q8Jq4P023551;
	Fri, 26 Apr 2024 08:50:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=f+t4HTh4Ix4xV1YHIH/zdI8jS/jqqnAYQL0A/VtbcJw=;
 b=YYK/UEaJOLXdwp+xlkUXHLVxSjgLY4K1vWUux92S+k6pU9102vOh5QPx2C8yAt18Zf6y
 PrMZIFY3tWFYhIwPtJpIQTDdovFh6shNZUMivyEcLkGK56tfUzqAwUQXhmi65xfqjq2T
 0d5MMdSeJMG0vIiLmBQsH8IRj2OHjjDEBtkCX5JbARW/RIJLiHY8Gk36dpEG5BvPDIWw
 /qhswUe/7lzSfOEYbTM/lgAeK35Y3wH+KS2nQ7LYBKKv/pwpdlR29dQIVotKHE7eForU
 VE3WDOJdauosmgiEmrvGHRczfrLoS+tXIqzSvj71l0fTiy/rjxSBJRhBPJvHmEDgvDGb BQ== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xr8ddg3ny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 08:50:29 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43Q7vev5028341;
	Fri, 26 Apr 2024 08:50:29 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xmtr2xacg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 08:50:28 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43Q8oNBL46792960
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 08:50:25 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5C8D2004D;
	Fri, 26 Apr 2024 08:50:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29F972004B;
	Fri, 26 Apr 2024 08:50:23 +0000 (GMT)
Received: from osiris (unknown [9.171.34.163])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 26 Apr 2024 08:50:23 +0000 (GMT)
Date: Fri, 26 Apr 2024 10:50:21 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        gor@linux.ibm.com, agordeev@linux.ibm.com, svens@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, borntraeger@de.ibm.com
Subject: Re: [PATCH v1 1/2] s390/pgtable: switch read and write softbits for
 puds
Message-ID: <20240426085021.8950-E-hca@linux.ibm.com>
References: <20240425130555.73132-1-imbrenda@linux.ibm.com>
 <20240425130555.73132-2-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425130555.73132-2-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -ymecmfiFOyw2Om_A95F-Gz_ntyzkcbb
X-Proofpoint-ORIG-GUID: -ymecmfiFOyw2Om_A95F-Gz_ntyzkcbb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_09,2024-04-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=568 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404260056

On Thu, Apr 25, 2024 at 03:05:54PM +0200, Claudio Imbrenda wrote:
> There is no reason for the read and write softbits to be swapped in the
> puds compared to pmds. They are different only because the softbits for
> puds were introduced at the same time when the softbits for pmds were
> swapped.
> 
> The current implementation is not wrong per se, since the macros are
> defined correctly; only the documentation does not reflect reality.
> 
> With this patch, the read and write softbits for large pmd and large
> puds will have the same layout, and will match the existing
> documentation.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>  arch/s390/include/asm/pgtable.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>

