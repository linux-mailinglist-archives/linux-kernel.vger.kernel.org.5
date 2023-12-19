Return-Path: <linux-kernel+bounces-5462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F870818AE7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57AB21C2412E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2572136B;
	Tue, 19 Dec 2023 15:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PSc9NTSd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A986820DCF
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 15:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJ9x1M1028212;
	Tue, 19 Dec 2023 15:12:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=UaswPlapQgTOrQCXRO6Sikc98XChcNdv3fRByyOCHHg=;
 b=PSc9NTSdjou+aPN61iWpkvdMh4EDb9ifGf6YDWExoP1RVeb4SCgFpSgFZUxs2breEx+q
 es9DshjDyid3wdqPqAgCw5USWflixoBN9RWRidN3ZJov3qVGHkspDWeuDvSQKi7fd9y5
 VkpKutO3YSiiodEFlL3PxF+wwvaRHDIPSBsi3d4Svl9m/fL6QUny8/JbzOzyIYj5IJBf
 nqs5rTtAR0/OE95xAIHCk39pP7h10BHuAm9F8hoyhKoDdQ/48YqblZfifNU4dAK4TQWJ
 EO0oe3Qv/FdAaOxGR6eoXjZWE2T7SaEShBiON1bv2AeQEspVkLflmfZOiJ8V+e7ofi/Q 1g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v12aee28h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 15:12:09 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJDuAKF028981;
	Tue, 19 Dec 2023 15:12:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v12b6w755-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 15:12:08 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BJF7SdL008899;
	Tue, 19 Dec 2023 15:12:07 GMT
Received: from localhost.localdomain (dhcp-10-175-58-169.vpn.oracle.com [10.175.58.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3v12b6w71u-1;
	Tue, 19 Dec 2023 15:12:07 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Brian Gerst <brgerst@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: [PATCH 0/5] replace magic numbers in GDT descriptors
Date: Tue, 19 Dec 2023 16:11:55 +0100
Message-Id: <20231219151200.2878271-1-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-19_08,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312190113
X-Proofpoint-ORIG-GUID: KpkXXeoffvIn8Zbh3afs-T50til_7GzJ
X-Proofpoint-GUID: KpkXXeoffvIn8Zbh3afs-T50til_7GzJ

Linus suggested replacing the magic numbers in the GDT descriptors
using preprocessor macros [1].

[1] https://lore.kernel.org/all/CAHk-=wib5XLebuEra7y2YH96wxdk=8vJnA8XoVq0FExpzVvN=Q@mail.gmail.com/

For patch 3 ("x86: replace magic numbers in GDT descriptors, part 2") I've
verified it to the best of my abilities on 32-bit and 64-bit by ensuring
that the object files are bitwise identical before and after applying the
patch and ensuring that all the object files were rebuilt on at least one
of the two configs:

32-bit:
  arch/x86/boot/pm.o -- no change
  arch/x86/kernel/apm_32.o -- no change
  arch/x86/kernel/cpu/common.o -- no change
  arch/x86/kernel/head64.o -- not built for 32
  arch/x86/kernel/setup_percpu.o -- no change
  arch/x86/platform/pvh/head.o -- not built for 32
  arch/x86/realmode/rm/reboot.o -- no change
  drivers/firmware/efi/libstub/x86-5lvl.o -- not built for 32
  drivers/pnp/pnpbios/bioscalls.o -- no change

64-bit:
  arch/x86/boot/pm.o -- no change
  arch/x86/kernel/apm_32.o -- not built for 64
  arch/x86/kernel/cpu/common.o -- no change
  arch/x86/kernel/head64.o -- no change
  arch/x86/kernel/setup_percpu.o -- no change
  arch/x86/platform/pvh/head.o -- no change
  arch/x86/realmode/rm/reboot.o -- no change
  drivers/firmware/efi/libstub/x86-5lvl.o -- no change
  drivers/pnp/pnpbios/bioscalls.o -- not built for 64

Patches 2+3 can be squashed to a single commit, but I've submitted them
separately because it makes verifying correctness easier.

I've done basic boot testing on both 32-bit and 64-bit with all of the
patches.

Vegard Nossum (5):
  x86: provide new infrastructure for GDT descriptors
  x86: replace magic numbers in GDT descriptors, part 1
  x86: replace magic numbers in GDT descriptors, part 2
  x86: always set A (accessed) flag in GDT descriptors
  x86: add DB flag to 32-bit percpu GDT entry

 arch/x86/boot/pm.c                      |  7 +--
 arch/x86/include/asm/desc_defs.h        | 68 ++++++++++++++++++++++---
 arch/x86/kernel/apm_32.c                |  2 +-
 arch/x86/kernel/cpu/common.c            | 50 ++++++++----------
 arch/x86/kernel/head64.c                |  6 +--
 arch/x86/kernel/setup_percpu.c          |  4 +-
 arch/x86/platform/pvh/head.S            |  7 +--
 arch/x86/realmode/rm/reboot.S           |  3 +-
 drivers/firmware/efi/libstub/x86-5lvl.c |  4 +-
 drivers/pnp/pnpbios/bioscalls.c         |  2 +-
 10 files changed, 100 insertions(+), 53 deletions(-)

-- 
2.34.1

This is the script I used for verifying no binary changes (pass rev of
patch 3 to build as the only argumnet):

#! /bin/bash

set -e
set -u

rev=$(git rev-parse $1)

# get the paths that changed
paths="$(git diff --name-only $rev^- | grep '\.[cS]$' | sed 's/\.[cS]$/.o/')"

build() {
	id=$1

	# build without patch and save result as <path>.pre-<id>
	git checkout -d $rev^
	rm -f $paths
	make -j128
	for p in $paths
	do
		if [ -e $p ]
		then
			mv -f $p $p.pre-$id
		fi
	done

	# build with patch and save result as <path>.post-<id>
	git checkout -d $rev
	rm -f $paths
	make -j128
	for p in $paths
	do
		if [ -e $p ]
		then
			mv -f $p $p.post-$id
		fi
	done
}

# build i386
make defconfig
scripts/config --disable 64BIT
scripts/config --disable MODULES
# for arch/x86/kernel/apm_32.o
scripts/config --enable APM
# for drivers/pnp/pnpbios/bioscalls.o
scripts/config --enable ISA --enable PNP --enable PNPBIOS
make olddefconfig
build 32

# build x86_64
make defconfig
scripts/config --disable MODULES
# for arch/x86/platform/pvh/head.o
scripts/config --enable XEN --enable XEN_PVHVM --enable PVH
make olddefconfig
build 64

echo
echo results:
echo

for id in 32 64
do
	echo $id:

	for p in $paths
	do
		if [ -e $p.pre-$id ] && [ -e $p.post-$id ]
		then
			if cmp -s $p.pre-$id $p.post-$id
			then
				echo $p -- no change
			else
				echo $p -- differences:
				diff -U3 <(objdump -dr $p.pre-$id | tail -n +3) <(objdump -dr $p.post-$id | tail -n +3) || true
			fi
		else
			echo $p -- not built for $id
		fi
	done

	echo
done

