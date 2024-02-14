Return-Path: <linux-kernel+bounces-65290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DDC854AAF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33C6C1C264DE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05F854BD3;
	Wed, 14 Feb 2024 13:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cbQeKhef"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A90535DF;
	Wed, 14 Feb 2024 13:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707918221; cv=none; b=e22ydHnswNX1zPKsmwF8A2RMIuHpMZ9dwP1d1/euK3nhXFLati39kUcd3FXG85jz4eIM8QWbHXLs9PLerpX9frP4kD1FRA9FN6ln7pwBNUCqBQJJN+0JYL+dZ527GYa5Cc/KrdfuFcdnw1d8wrQRn6dppKNBcGoZF/xYI6qL8wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707918221; c=relaxed/simple;
	bh=jWkxWAn2QwY1HKIGYXamG4b+Y2/BkSkavkG8tJphE8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CXQuHSx2Ql/k03ZLfavCtxmaQqGz2FiK04yDTo/ikGxDQ/ppHMV4IyQwlSpSC/RUkI2sTsuNo11l8NND80xkxPNUyzlWPbPEszJPI/VMuFdM5T73+e8kymOhGBDN54YkmmEuV0rxMwdFaKMnEdP0MFGSnEN7FE6vQudCnqAm2og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cbQeKhef; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41EDbMLK019282;
	Wed, 14 Feb 2024 13:43:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=s0tK1YoNd0xkyc0b/gg/hjxmXmHJUfA0TyP0+P9d5z0=;
 b=cbQeKhef9ZAgG8zLtNhUy4gHkn3L60qJPKnHRTE1GcgRMg2BXbaslZ+3+rTAPY1KgkNq
 YvYvekytyWbXH8WETGoeCh9O5CZs3ZrxeEKil1PejNFf04vEYDs7jvx/OPNIkNEFz/gG
 1CGN9fz/DnsfvIjpHUci1441/y7h+LX2xgNIDdrqjv+8gsjZPj9rC/loQj8z09qlotCN
 Cjugm1QPHmJsbsfrjjN1mwmnFiB7sOuT0agmrkIwtnUzDSiLS077ZGfWrMir1K9WrTVr
 cyOfjqMzJR5vdiy2PMvT7tH9uVVjOrIwuPZBczk8jzRqoehPRym6q/1+HJo9n4i60N1o Fw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w8xjb05bw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 13:43:36 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41EDbqMs020160;
	Wed, 14 Feb 2024 13:43:36 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w8xjb05b5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 13:43:36 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41ECJQhk032614;
	Wed, 14 Feb 2024 13:43:35 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6kftpdbe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 13:43:34 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41EDhUi759375994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 13:43:32 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BD4A20040;
	Wed, 14 Feb 2024 13:43:30 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF24220077;
	Wed, 14 Feb 2024 13:43:29 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 14 Feb 2024 13:43:29 +0000 (GMT)
Date: Wed, 14 Feb 2024 14:43:28 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, maskray@google.com, ndesaulniers@google.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH 00/11] s390: Support linking with ld.lld
Message-ID: <20240214134328.6438-F-hca@linux.ibm.com>
References: <20240207-s390-lld-and-orphan-warn-v1-0-8a665b3346ab@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207-s390-lld-and-orphan-warn-v1-0-8a665b3346ab@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oOfebv6eWff_gDkXmzDSQ8BBROJ-BwB1
X-Proofpoint-ORIG-GUID: bJ9d1QWArnZ3dPo5kt745E2He42PEyF6
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_06,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=757 impostorscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402140106

On Wed, Feb 07, 2024 at 05:14:52PM -0700, Nathan Chancellor wrote:
> Hi all,
> 
> This series allows the s390 kernel to be linked with ld.lld (support for
> s390 is under review at [1]). This implicitly depends on [2], which was
> created and sent before it was realized that this series was necessary.
..
> Nathan Chancellor (11):
>       s390: boot: Add support for CONFIG_LD_ORPHAN_WARN
>       s390: vmlinux.lds.S: Handle '.data.rel' sections explicitly
>       s390: vmlinux.lds.S: Explicitly handle '.got' and '.plt' sections
>       s390: vmlinux.lds.S: Discard unnecessary sections
>       s390/boot: vmlinux.lds.S: Handle '.init.text'
>       s390/boot: vmlinux.lds.S: Handle '.rela' sections
>       s390/boot: vmlinux.lds.S: Handle DWARF debug sections
>       s390/boot: vmlinux.lds.S: Handle ELF required sections
>       s390/boot: vmlinux.lds.S: Handle commonly discarded sections
>       s390: Select CONFIG_ARCH_WANT_LD_ORPHAN_WARN
>       s390: Link vmlinux with '-z notext'
> 
>  arch/s390/Kconfig              |  1 +
>  arch/s390/Makefile             |  2 +-
>  arch/s390/boot/Makefile        |  5 +++--
>  arch/s390/boot/vmlinux.lds.S   | 28 ++++++++++++++++++++++++++++
>  arch/s390/kernel/vmlinux.lds.S | 28 +++++++++++++++++++++++++++-
>  5 files changed, 60 insertions(+), 4 deletions(-)

Now available at:
https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/log/?h=features

And should be in linux-next soon.

Thanks a lot! :)

