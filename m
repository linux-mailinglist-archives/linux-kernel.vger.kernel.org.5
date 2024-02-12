Return-Path: <linux-kernel+bounces-61774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63037851700
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71DFBB26708
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF154C601;
	Mon, 12 Feb 2024 13:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DxQCJbvS"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E9C4B5CD;
	Mon, 12 Feb 2024 13:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707746126; cv=none; b=E+LY1Ffpx5LLk4Gp+DGdNgSwuZxb5QEGtHufsdaEOdRETjuWcuWSsMHtm8ZtvZ1b+B9T3dYrDqbmX7RyNpFOD5NbKXPsC0vlQW0XKDt93OGtLFEyF7sF67i5TZpntBwmS7J1TDoIlQVox2NLYOu4LSakFCZ4be4KygJR5PlMUyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707746126; c=relaxed/simple;
	bh=l8lJVhpkkMOQn4SYIDOmKjhE1C4PJtr6LTU/kQWgbWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o9/OY4ygrHxsUbyiI3RLPoFtq8Xiid3u7nHGikTuVjr5K/0anmyCCxaERnBoHzvP+yraO3C7M38gvS1P+lPQaqMCFM73GicNZb4Sm50nE30Qsrn8/96TWQ9RWxCImngk3fetodfj8GZz3KHWip7ZZtpwIgnEKxa4DjecEfzHFLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DxQCJbvS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41CDll6R002089;
	Mon, 12 Feb 2024 13:55:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=1VsmOyecYehuELNL1sbz6IGptMSx6hES5aL/RB2W1V8=;
 b=DxQCJbvSXEYk/EtPG7SslOqdyu76QYro297XQenBo3AbxyjIOrWw7qJED+5ls5ysySY9
 2y5WTncbztnEnJxUHbSCipJ2m7dfS0BLI+DAgQPvhAwh0IeFLSXkFuYCAEKH9OMnVdGz
 lAaAlcnaSFv5aH8hRLneWSai2QnH1BPMsN6lAAY7jMow0Lp1/oJe2rkSjam+rV6VMt84
 gB9sEAKCqQvG0d5dQvObAvLS7syI0XbolWIu2wdL408mD4MB6+hHEbbfzoeK1hoFeT+N
 roDNtT3AHOCPl4CMfKg+ex2LrcKLUKE4tEh4JkNQUdV9L05C3KDlDBVyw7cBYxMks7Ce TQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7mheg56b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 13:55:21 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41CDn1N3006548;
	Mon, 12 Feb 2024 13:55:20 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7mheg561-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 13:55:20 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41CDhtIc024961;
	Mon, 12 Feb 2024 13:55:19 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6mfp0vce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 13:55:19 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41CDtDnF17105456
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 13:55:15 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1C2920043;
	Mon, 12 Feb 2024 13:55:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02BFD20040;
	Mon, 12 Feb 2024 13:55:13 +0000 (GMT)
Received: from osiris (unknown [9.171.5.16])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 12 Feb 2024 13:55:12 +0000 (GMT)
Date: Mon, 12 Feb 2024 14:55:11 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, maskray@google.com, ndesaulniers@google.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH 04/11] s390: vmlinux.lds.S: Discard unnecessary sections
Message-ID: <20240212135511.65142-A-hca@linux.ibm.com>
References: <20240207-s390-lld-and-orphan-warn-v1-0-8a665b3346ab@kernel.org>
 <20240207-s390-lld-and-orphan-warn-v1-4-8a665b3346ab@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207-s390-lld-and-orphan-warn-v1-4-8a665b3346ab@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tuVIMDreazdkQtVfRLrmJ6yBZCO6xFUF
X-Proofpoint-GUID: y5h8jGMhNdFw4guclN1-R3JpP2Oi7u6i
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_10,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0
 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402120105

On Wed, Feb 07, 2024 at 05:14:56PM -0700, Nathan Chancellor wrote:
> When building with CONFIG_LD_ORPHAN_WARN after selecting
> CONFIG_ARCH_HAS_LD_ORPHAN_WARN, there are some warnings around certain
> ELF sections that are unnecessary for the kernel's purposes.
> 
>   s390-linux-ld: warning: orphan section `.dynstr' from `arch/s390/kernel/head64.o' being placed in section `.dynstr'
>   s390-linux-ld: warning: orphan section `.dynamic' from `arch/s390/kernel/head64.o' being placed in section `.dynamic'
>   s390-linux-ld: warning: orphan section `.hash' from `arch/s390/kernel/head64.o' being placed in section `.hash'
>   s390-linux-ld: warning: orphan section `.gnu.hash' from `arch/s390/kernel/head64.o' being placed in section `.gnu.hash'
> 
> Add them to the discards to clear up the warnings, which matches other
> architectures.
> 
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  arch/s390/kernel/vmlinux.lds.S | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
..
> -		*(.interp)
> +		*(.interp .dynamic)
> +		*(.dynstr .hash .gnu.hash)

This seems to be wrong, since it leads to 1000s of error messages when
using the "crash" utility e.g. when looking into a live dump of system
with the generated debug info:

BFD: /usr/lib/debug/usr/lib/modules/6.8.0-20240211.rc3.git0.bdca9b8dcf3f.300.fc39.s390x/vmlinux: attempt to load strings from a non-string section (number 0)

I will change this commit to the below; it seems to work and is in
line with other architectures:

-----

When building with CONFIG_LD_ORPHAN_WARN after selecting
CONFIG_ARCH_HAS_LD_ORPHAN_WARN, there are some warnings around certain
ELF sections:

  s390-linux-ld: warning: orphan section `.dynstr' from `arch/s390/kernel/head64.o' being placed in section `.dynstr'
  s390-linux-ld: warning: orphan section `.dynamic' from `arch/s390/kernel/head64.o' being placed in section `.dynamic'
  s390-linux-ld: warning: orphan section `.hash' from `arch/s390/kernel/head64.o' being placed in section `.hash'
  s390-linux-ld: warning: orphan section `.gnu.hash' from `arch/s390/kernel/head64.o' being placed in section `.gnu.hash'

Explicitly keep those sections like other architectures when
CONFIG_RELOCATABLE is enabled, which is always true for s390.

[hca@linux.ibm.com: keep sections instead of discarding]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/r/20240207-s390-lld-and-orphan-warn-v1-4-8a665b3346ab@kernel.org
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/vmlinux.lds.S | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index 661a487a3048..d46e3c383952 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -200,6 +200,21 @@ SECTIONS
 		*(.rela*)
 		__rela_dyn_end = .;
 	}
+	.dynamic ALIGN(8) : {
+		*(.dynamic)
+	}
+	.dynsym ALIGN(8) : {
+		*(.dynsym)
+	}
+	.dynstr ALIGN(8) : {
+		*(.dynstr)
+	}
+	.hash ALIGN(8) : {
+		*(.hash)
+	}
+	.gnu.hash ALIGN(8) : {
+		*(.gnu.hash)
+	}
 
 	. = ALIGN(PAGE_SIZE);
 	__init_end = .;		/* freed after init ends here */
-- 
2.40.1


