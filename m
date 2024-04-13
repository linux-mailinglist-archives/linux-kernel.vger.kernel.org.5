Return-Path: <linux-kernel+bounces-143617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EB68A3B77
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 09:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BB5D1C21348
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 07:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1488C1CF8D;
	Sat, 13 Apr 2024 07:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ONhNwM1e"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C111CD20
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 07:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712993158; cv=none; b=SecC+wxBUjwPYQcfxjVgpmNaq1t1U0h9QAUlI4gwDZ/ChfSii05ZNQm+w4JsRlPBZHztt2KChZxddjhV+AjCyD3ERQRKVGpGIkOG3fImQ1RAYzwxl/8GK4y1ONPn60cJ/yK/k5AX8YGOf4vAO6cFDUJTuQRMqMIYhVxGYMI0cjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712993158; c=relaxed/simple;
	bh=4Erf9Rt4sPkumENQESlsNUKyORqfH45bQPB5uRtqa/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h2TwGiN9lgh0S5ym/y0zJu6coIjRKaA9sgmp0Ep4WM7WkhThK0UvuDkAjNocDwWKAb0ixqRXQPahAX5F105J/ajUOouLymWMBzqST9cndZnG/6/nCBnkeHytsn+iEW1Lmh8UIXj1+5M4RzevbJV9/nbOrLcb3qYsB/OobevIJ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ONhNwM1e; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43D6Hod1010897;
	Sat, 13 Apr 2024 07:25:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=0IMzX6iDWZRVvLqCZ8aFNlqCahIEeuwtl0+fPNR+nxs=;
 b=ONhNwM1e4wJjIFrT8OtddSBFiA+eJDm9EXkW3G50sibk9GfvzvtgvjA9ss5HHs6PqXqw
 lF6wbqI7S6vZLwgdWoQeer2SFLYnCiLR1MFF3uHYMNDY6plZioisbmtwY9yHhP7b6BT2
 S9Y8IHjfLohl8eds6+B0u/SWaWhF1jSIglJJQfW09yG9vd+KW3ZNIAymUfap5vIzyhgK
 ka7qNzckomq6uwjexenkt6konCopzKB64iEIgyS8cJPXdWGwyKsfdLwEiC6KMO4UDHkH
 BHJYkvNJVdlusLl9HaBuMaDY7m/017sDwchbCRhtluoUeqjY1U5QneIk/DwcaFit5euM Zw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xfffcrd8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Apr 2024 07:25:09 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43D7P87H001214;
	Sat, 13 Apr 2024 07:25:08 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xfffcrd88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Apr 2024 07:25:08 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43D4SNcY029951;
	Sat, 13 Apr 2024 07:22:48 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xbj7mxgur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Apr 2024 07:22:48 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43D7MhOi52298082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 13 Apr 2024 07:22:45 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09C0520040;
	Sat, 13 Apr 2024 07:22:43 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92E752004B;
	Sat, 13 Apr 2024 07:22:41 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.5.235])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat, 13 Apr 2024 07:22:41 +0000 (GMT)
Date: Sat, 13 Apr 2024 09:22:40 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, anil.s.keshavamurthy@intel.com,
        aou@eecs.berkeley.edu, bp@alien8.de, catalin.marinas@arm.com,
        dave.hansen@linux.intel.com, davem@davemloft.net, gor@linux.ibm.com,
        hca@linux.ibm.com, jarkko@kernel.org, jcalvinowens@gmail.com,
        linux-arm-kernel@lists.infradead.org, mhiramat@kernel.org,
        mingo@redhat.com, mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com, tglx@linutronix.de,
        will@kernel.org
Subject: Re: [PATCH 3/4] kprobes/treewide: Explicitly override alloc/free
 functions
Message-ID: <ZhoywPS0QqG0c6jw@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20240326163624.3253157-1-mark.rutland@arm.com>
 <20240326163624.3253157-4-mark.rutland@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326163624.3253157-4-mark.rutland@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 24HscaZvXpTG5cOhisu_6kfN5XOznRoa
X-Proofpoint-ORIG-GUID: f5cB7aRyRqOWxMomDikx-RE178gKgcna
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_18,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 phishscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 suspectscore=0 mlxlogscore=712 spamscore=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404130052

On Tue, Mar 26, 2024 at 04:36:23PM +0000, Mark Rutland wrote:
Hi Mark,

..
> (a) Architectures using the generic kprobes_free_insn_page() and
                                      kprobes_alloc_insn_page()?
>     kprobes_free_insn_page() are left as-is. The __weak annotation is
>     removed from the generic implementations so that accidental
>     overrides/misuse can be detected easily.
> 
> (b) Architectures which provide their own kprobes_free_insn_page() are
                                            kprobes_alloc_insn_page()?
>     given a matching implementation of kprobes_free_insn_page(), and
>     select HAVE_KPROBES_ALLOC.
.
>  arch/s390/Kconfig                  | 3 ++-
>  arch/s390/kernel/kprobes.c         | 5 +++++

I tried the repo:
git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git    kprobes/without-modules

For s390:
Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>

Thanks!

