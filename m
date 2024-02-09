Return-Path: <linux-kernel+bounces-59288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC7784F484
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 12:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 337E3280E5D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22E82C1B1;
	Fri,  9 Feb 2024 11:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WPOo5mjY"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B6628DC1;
	Fri,  9 Feb 2024 11:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707477659; cv=none; b=uOM745a24MjUgqBNMyaiuRcn3O5j/YvPs44c+wr20iexDTc8Iu8Qi2tIxpyBRFmH4LBuM9mrahxeZW6cA+9hU9TnMhA6CxTLxsdIKN1odMSIRRhL5/kiDvcHVyvdeMtL0cCtZaZisX7QzdstkGDmntFkF0YoNlfqx0lpSJtjMow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707477659; c=relaxed/simple;
	bh=EQDhFl9ifLuO0cWW60pqujcWcLUCCDzUvFz8nDzjWEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qoJz6xEXOSImLM/r4QPRz7GreB8Q+f0TLmEsad1EKdTRvdEGVm00d4WJZRd2M/97YiR59gYSdVwEZBk82HgESrRN7OkMwcqMolqHHFiEhRpQXbXz6uJn1v2HCDSSizx7QbAGuMetVp8x/7pOk4rdDsCpgkPJb6KDYWYtTnGZ1tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WPOo5mjY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 419B7smf017740;
	Fri, 9 Feb 2024 11:20:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=AFRBt1FCWwZFCacHJwy/3XlOLZrPPJkYg4TH+/NMzCY=;
 b=WPOo5mjYBYH2IErMw43bckQqh1/4kYc59Mlb1elBZP72pBgJxps+ciUAG95KQzIPdcV8
 Y3sXAcMbSEuAlbdkku+NXUmybtws7qQ8VFXngPu+HKrUFg+6pJ42vQN2IDvnmeYPYWfW
 nxN1pg0g4nlr7yKgldgcC9NL05Jpl1HXjZhxifysJ84z2+/p3qI2saNvZ3POkTa4Kgub
 lZJE5TjAINvFm/HtsjAP+tI1ZJ/FOg2Kjv+QsZmc7ixiZvUwXH/JnIcmjNac30ktCsP5
 UThMof80NLOpl5D3fiGJ03iLhEFbe1G9Ybwp83dBhrG0aLFvHpXIZY9uOtgA+XGoVqr3 eg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w5gkbc4pe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 11:20:52 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 419BJ0Zi005843;
	Fri, 9 Feb 2024 11:20:52 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w5gkbc4p3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 11:20:52 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4199OWPH008770;
	Fri, 9 Feb 2024 11:20:51 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w20702x02-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 11:20:51 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 419BKmWQ65864186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Feb 2024 11:20:48 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E23A20043;
	Fri,  9 Feb 2024 11:20:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0D3020040;
	Fri,  9 Feb 2024 11:20:47 +0000 (GMT)
Received: from osiris (unknown [9.179.1.234])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  9 Feb 2024 11:20:47 +0000 (GMT)
Date: Fri, 9 Feb 2024 12:20:46 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, maskray@google.com, ndesaulniers@google.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH 00/11] s390: Support linking with ld.lld
Message-ID: <20240209112046.13241-C-hca@linux.ibm.com>
References: <20240207-s390-lld-and-orphan-warn-v1-0-8a665b3346ab@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207-s390-lld-and-orphan-warn-v1-0-8a665b3346ab@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SGrVWr2aETRlna7KZhmAL39hFcON2Vc3
X-Proofpoint-ORIG-GUID: Fb5LnhK3ZSaXbrsL69WJpWi9iLmMuwBX
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_08,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 adultscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402090082

Hi Nathan,

> This series allows the s390 kernel to be linked with ld.lld (support for
> s390 is under review at [1]). This implicitly depends on [2], which was
> created and sent before it was realized that this series was necessary.
..
> There is one outstanding issue due to something that ld.lld does not
> support that the kernel relies on:
> 
>   ld.lld: error: drivers/nvme/host/fc.o:(__bug_table): writable SHF_MERGE section is not supported
> 
> This was changed in the kernel in commit e21f8baf8d9a ("s390/bug: add
> entry size to the __bug_table section"). Is this change truly necessary?
> I selectively applied a revert on top of current mainline and I did not
> observe any issues with either Clang or GCC.

No it is not necessary. As the original patch stated this was a pre-req
patch for objtool, for which we still don't have support. This (or
something different) might be needed. But for now this can easily be
reverted.

> Then build the kernel with 'LD=ld.lld' in addition to whatever command
> line you use (I tested both Clang and GCC). I can boot an ld.lld linked
> kernel built with both compilers in QEMU with this series.
> 
> [    1.386970] Linux version 6.8.0-rc3-00043-g05761ede85d6-dirty (nathan@dev-fedora.aadp) (s390-linux-gcc (GCC) 13.2.0, ClangBuiltLinux LLD 19.0.0) #1 SMP Wed Feb  7 16:51:12 MST 2024
> 
> [    0.871923] Linux version 6.8.0-rc3-00043-g05761ede85d6-dirty (nathan@dev-fedora.aadp) (ClangBuiltLinux clang version 19.0.0git (https://github.com/llvm/llvm-project 417075e56aeba5a5b20301c7bfeba9c2a800982b), ClangBuiltLinux LLD 19.0.0) #1 SMP Wed Feb  7 17:01:22 MST 2024

Tested, and works for me. Thanks a lot for your work. This is highly
appreciated!

I applied this series internally to get some CI runs over the weekend, and
push it to our external repository beginning of next week. As suggested by
you I reverted the commit you mentioned above, and also removed ENTRY from
our vdso linker scripts, similar to what you did already for powerpc (see
patches below).

Please feel free to send patches for both of the issues, and I'll replace
my patches with your patches.

From 30a0a88d0e6c4802b748a942bb3f6f1b223f53ba Mon Sep 17 00:00:00 2001
From: Heiko Carstens <hca@linux.ibm.com>
Date: Fri, 9 Feb 2024 11:48:25 +0100
Subject: [PATCH 1/2] s390/bug: remove entry size from __bug_table section

Commit e21f8baf8d9a ("s390/bug: add entry size to the __bug_table section")
changed the __EMIT_BUG() inline assembly to emit mergeable __bug_table
entries. This is at least currently not needed, but causes problems with
the upcoming s390 ld.lld support:

  ld.lld: error: drivers/nvme/host/fc.o:(__bug_table): writable SHF_MERGE section is not supported

Therefore revert the change for now.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/all/20240207-s390-lld-and-orphan-warn-v1-0-8a665b3346ab@kernel.org/
Suggested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/bug.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/bug.h b/arch/s390/include/asm/bug.h
index aebe1e22c7be..c500d45fb465 100644
--- a/arch/s390/include/asm/bug.h
+++ b/arch/s390/include/asm/bug.h
@@ -14,7 +14,7 @@
 		".section .rodata.str,\"aMS\",@progbits,1\n"	\
 		"1:	.asciz	\""__FILE__"\"\n"		\
 		".previous\n"					\
-		".section __bug_table,\"awM\",@progbits,%2\n"	\
+		".section __bug_table,\"aw\"\n"			\
 		"2:	.long	0b-.\n"				\
 		"	.long	1b-.\n"				\
 		"	.short	%0,%1\n"			\
@@ -30,7 +30,7 @@
 #define __EMIT_BUG(x) do {					\
 	asm_inline volatile(					\
 		"0:	mc	0,0\n"				\
-		".section __bug_table,\"awM\",@progbits,%1\n"	\
+		".section __bug_table,\"aw\"\n"			\
 		"1:	.long	0b-.\n"				\
 		"	.short	%0\n"				\
 		"	.org	1b+%1\n"			\
-- 
2.40.1

From bdca9b8dcf3f0884341f491d54502d4cbe660446 Mon Sep 17 00:00:00 2001
From: Heiko Carstens <hca@linux.ibm.com>
Date: Fri, 9 Feb 2024 11:54:01 +0100
Subject: [PATCH 2/2] s390/vdso: remove unused ENTRY in linker scripts

When linking vdso64.so.dbg with ld.lld, there is a warning about not
finding _start for the starting address:

  ld.lld: warning: cannot find entry symbol _start; not setting start address

Fix this be removing the unused ENTRY in both vdso linker scripts. See
commit e247172854a5 ("powerpc/vdso: Remove unused ENTRY in linker
scripts"), which solved the same problem for powerpc, for further details.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/vdso32/vdso32.lds.S | 1 -
 arch/s390/kernel/vdso64/vdso64.lds.S | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/s390/kernel/vdso32/vdso32.lds.S b/arch/s390/kernel/vdso32/vdso32.lds.S
index edf5ff1debe1..65b9513a5a0e 100644
--- a/arch/s390/kernel/vdso32/vdso32.lds.S
+++ b/arch/s390/kernel/vdso32/vdso32.lds.S
@@ -9,7 +9,6 @@
 
 OUTPUT_FORMAT("elf32-s390", "elf32-s390", "elf32-s390")
 OUTPUT_ARCH(s390:31-bit)
-ENTRY(_start)
 
 SECTIONS
 {
diff --git a/arch/s390/kernel/vdso64/vdso64.lds.S b/arch/s390/kernel/vdso64/vdso64.lds.S
index 4461ea151e49..37e2a505e81d 100644
--- a/arch/s390/kernel/vdso64/vdso64.lds.S
+++ b/arch/s390/kernel/vdso64/vdso64.lds.S
@@ -9,7 +9,6 @@
 
 OUTPUT_FORMAT("elf64-s390", "elf64-s390", "elf64-s390")
 OUTPUT_ARCH(s390:64-bit)
-ENTRY(_start)
 
 SECTIONS
 {
-- 
2.40.1


