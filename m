Return-Path: <linux-kernel+bounces-128221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA058957DD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A10B9283364
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E74912D771;
	Tue,  2 Apr 2024 15:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="X8imzE1e"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFB312C534;
	Tue,  2 Apr 2024 15:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712070583; cv=none; b=h8rooiH1czDPSE0hDqy82rsKdaxYc+rQs7Fzj7lwFuN0SqrUiF7VdlKjo2Kxz2AmarLjsMFVoc2Zxv+JY09P4ujX1UARWEdrwOtEJF+4nb4D4nV/Is/UXwDdyRMPmiLMBbZ6pHGB6tWn9NANCrFT2jZC3qdjsxCMWDkK4rNmRFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712070583; c=relaxed/simple;
	bh=+peFD21JcBTS6CBdlR+aa/hSltRqOtFDfptmi6JsOp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RECeCKpN4MyCEQV2/Vm+RexcRdc3e4nJLDdCrbZwWPF1fosX7wmVhGJLA0MMqD3PsMTOHcPQmSsC++XKnGM8SaAdLN0/w/CG0xIBXoB6Nr6Yg44t5WNLV7R7rER65FZVVN1PcfFrirfhXog//vtZ4Knm5hlyGLzxCsmzaG4/K8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=X8imzE1e; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 432EqK0V006662;
	Tue, 2 Apr 2024 15:09:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=ITn/Kb704VlD5FJwMVHmPen0llG6tvxh8lrw6mzr3s8=;
 b=X8imzE1eMVclqPDvi9n2q3QB8X3skcRhRMxLS/P3Nb9hAVzQTykJmquu4FLkSvwa2GEz
 HCzHmiVPgkifxh4j953JvxlsYlBhIWLwwHyWb/TI5tRGc/s5YLQolLLwC9yiVD15uqR/
 +KwELP09rPiTX3Z3X2ey20s/UBT80rvy2H05hQOt6pj9NwL0A+pIODz5mUNMWVobZSO6
 5SryF/r3EODO4UpDOwh35rxuk7rUQFTbk+/J++YR+EwsrtOpfvr0oM21F1E1PLMvavUf
 d+0+fF2/lGtYjAxKu+2aAMMZkyWRu+N31MWU0x9xyH5RP1/YOkrl319y2hJ2LAHjwhik 6w== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x8m5mg28c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 15:09:30 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 432F9Twx004325;
	Tue, 2 Apr 2024 15:09:30 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x8m5mg287-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 15:09:29 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 432DeTZ8027138;
	Tue, 2 Apr 2024 15:09:28 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x6wf07c3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 15:09:28 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 432F9OMO37945802
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Apr 2024 15:09:26 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7454A2005A;
	Tue,  2 Apr 2024 15:09:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D97E2004F;
	Tue,  2 Apr 2024 15:09:23 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.179.1.65])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  2 Apr 2024 15:09:23 +0000 (GMT)
Date: Tue, 2 Apr 2024 18:09:21 +0300
From: Mike Rapoport <rppt@linux.ibm.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: xingwei lee <xrivendell7@gmail.com>, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, samsun1006219@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        netdev@vger.kernel.org
Subject: Re: BUG: unable to handle kernel paging request in crypto_sha3_update
Message-ID: <ZgwfoSj7GqFiOOsc@linux.ibm.com>
References: <CABOYnLzjayx369ygmr0PsGYGeRpnBnaH1XPqfbispL5nAeOJ9w@mail.gmail.com>
 <ZgvDe6fdJzgb8aZZ@gondor.apana.org.au>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgvDe6fdJzgb8aZZ@gondor.apana.org.au>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iYy8icHc0YbYmnBA7qp0fFyP8akUseXg
X-Proofpoint-GUID: n0TVUuoTuJ7Ax4p-JDwxtCIYmrd1Ixl4
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_08,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 clxscore=1011 priorityscore=1501
 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 mlxlogscore=839 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404020111

On Tue, Apr 02, 2024 at 04:36:11PM +0800, Herbert Xu wrote:
> On Wed, Mar 20, 2024 at 10:57:53AM +0800, xingwei lee wrote:
> >
> >   syscall(__NR_bind, /*fd=*/r[0], /*addr=*/0x20000000ul, /*addrlen=*/0x58ul);
> >   res = syscall(__NR_accept, /*fd=*/r[0], /*peer=*/0ul, /*peerlen=*/0ul);
> >   if (res != -1)
> >     r[1] = res;
> >   res = syscall(__NR_memfd_secret, /*flags=*/0ul);
> >   if (res != -1)
> >     r[2] = res;
> 
> So this is the key to the issue.  The whole point of memfd_secret is
> to make the pages inaccessible to the kernel.  The issue is those
> pages are then gifted to the kernel through sendmsg.  Somewhere
> along the line someone is supposed to throw up an error about this,
> or map the pages properly.  I guess neither happened which is why
> we end up with a page fault.

Yeah, there was a bug in folio_is_secretmem() that should have throw an
error about this.

David Hildenbrand sent a fix, it's in Andrew's tree

https://lore.kernel.org/all/20240326143210.291116-1-david@redhat.com
 
> I'll cc the memfd_secret authors to see what should catch this.
> 
> >   syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0xb36000ul,
> >           /*prot=*/0x2000003ul, /*flags=*/0x28011ul, /*fd=*/r[2],
> >           /*offset=*/0ul);
> >   syscall(__NR_ftruncate, /*fd=*/r[2], /*len=*/0xde99ul);
> >   *(uint64_t*)0x20000180 = 0;
> >   *(uint32_t*)0x20000188 = 0;
> >   *(uint64_t*)0x20000190 = 0x20000140;
> >   *(uint64_t*)0x20000140 = 0x20000080;
> >   *(uint64_t*)0x20000148 = 0xb0;
> >   *(uint64_t*)0x20000198 = 1;
> >   *(uint64_t*)0x200001a0 = 0;
> >   *(uint64_t*)0x200001a8 = 0;
> >   *(uint32_t*)0x200001b0 = 0;
> >   syscall(__NR_sendmsg, /*fd=*/r[1], /*msg=*/0x20000180ul,
> >           /*f=*/0x47933e2b0522cf63ul);
> 
> This is the spot where the memfd_secret pages are given to the kernel
> for processing through sendmsg.
> 
> Thanks,
> -- 
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

-- 
Sincerely yours,
Mike.

