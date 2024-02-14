Return-Path: <linux-kernel+bounces-65183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A957854908
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F68A1F28B07
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65221B965;
	Wed, 14 Feb 2024 12:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="O2g1UjlX"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B717B1B958;
	Wed, 14 Feb 2024 12:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707913093; cv=none; b=Cwi69qQH8hF9mz9queFb0ARscAyvdT3jKpXKiHNQ0D9HaGMMeFZmNUCX5dcubUc2bc+qPuPilNAJrYBNeoGbACItQ2dM0Be7fA/N7wuCBsl9VZou5skfRm2+AuMKFz3/QlBjdQ9IkOwd5W3lc1gDdVlyWJIS6TT+2SDFfM016Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707913093; c=relaxed/simple;
	bh=ydQckTFp1oxftSLw2+09PZBN+NmK7Vl3pl5OWF9pR1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=scyTvuxxXobUd2PJbjh/N4EXA/5eQDaXUGC5GRzJehUNhSDX65kHzIXzUOAI0RCSev1fasHZFgL+Jq5iTzimDE/WQ9zt74pwodyJ0dLp19MJ3gSe8iYW8XKeS817erLhmhb/pyNNti4aB9J/BXBqPo0fAYj+X/355w1zBFoPQGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=O2g1UjlX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41EC6nFk027524;
	Wed, 14 Feb 2024 12:18:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=FO7kM2t1hHvlMoHVxfJUhmtbNNq5lW1oJMoCJ4hc5cM=;
 b=O2g1UjlXw3xG+Sl67LOcpTE/0vEkkypeHCW5dTO0ubQoyFzJ6tR9oDTcJ2LZgHwO4mrc
 b7aLFyHklsPoy/BjDMuRztJrsBuk614h2UO/BUpmzSqHvejwPBJJMKWj+ZQZYUcmp2cG
 0bl3xTvQz81aHmUZl8qpgxLwLjZucF+L1JT3pf1VIXCRAB3jj1n1Y72USOxmwwkzzOdO
 f5fOJXLmqA712+qPvX0/q5UTEpABhDoVhX9h4kkN0PTiho8u2E8VrO4kB9lmNld3C/m9
 e5gLCPtupydRIHKXmPhgXITezUlKuoqy6Gms9TjnufNYSsHH0nCubL4nBURlMD0WIg70 RA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w8w8409b9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 12:18:04 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41EC8F2b000930;
	Wed, 14 Feb 2024 12:18:04 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w8w84099g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 12:18:04 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41EAQm4J016517;
	Wed, 14 Feb 2024 12:18:02 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6mymnp45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 12:18:02 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41ECHudX5964342
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 12:17:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C31CE20040;
	Wed, 14 Feb 2024 12:17:56 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80FAB2004B;
	Wed, 14 Feb 2024 12:17:56 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 14 Feb 2024 12:17:56 +0000 (GMT)
Date: Wed, 14 Feb 2024 13:17:55 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Fangrui Song <maskray@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        ndesaulniers@google.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev
Subject: Re: [PATCH 06/11] s390/boot: vmlinux.lds.S: Handle '.rela' sections
Message-ID: <20240214121755.6438-C-hca@linux.ibm.com>
References: <20240207-s390-lld-and-orphan-warn-v1-0-8a665b3346ab@kernel.org>
 <20240207-s390-lld-and-orphan-warn-v1-6-8a665b3346ab@kernel.org>
 <CAFP8O3+L6Jpgktk50UBKg_SodH-DTAW2syZueUqxdZsxrOT3bg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFP8O3+L6Jpgktk50UBKg_SodH-DTAW2syZueUqxdZsxrOT3bg@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HFECV309TxvMBgETUAvxE9F6Rql2XSz-
X-Proofpoint-GUID: e4JmGb2ncB2o78Tu8NB0WgnTfDIi6Sps
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_05,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=307 adultscore=0
 spamscore=0 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402140096

On Mon, Feb 12, 2024 at 09:18:34PM -0800, Fangrui Song wrote:
> >         ASSERT(SIZEOF(.plt) == 0, "Unexpected run-time procedure linkages detected!")
> > +       .rela.dyn : {
> > +               *(.rela.*) *(.rela_*)
> > +       }
> > +       ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
..
> Commit 5354e84598f264793265cc99b4be2a2295826c86 ("x86/build: Add
> asserts for unwanted sections")
> specifies `*(.rela.*) *(.rela_*)` but it's not clear why `.rela_*` is
> included. We only need .rela.* (see also ld.bfd --verbose)
> 
> This patch LGTM with this changed.

I'll keep it as it is, just to be consistent with x86.

