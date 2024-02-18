Return-Path: <linux-kernel+bounces-70121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2020D8593A9
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 01:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8886DB216F8
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 00:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E1237B;
	Sun, 18 Feb 2024 00:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="LG4x3dES"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E699736D
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 00:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708215389; cv=none; b=HUI1EooQs7ErPfDt57tY+GHzZQ89kj/szBdGUErL+CtMA27qES6xJBvsQdECGQMOkfjaGsBlWKTnLOCg9mRHzwy9xbvhel56OWH7A+qhWe4KSHBf3NC4M0izFKimVMf6+hwXNmky2pflr6udnqB2yupwxtL/GrZmkgqJUxPgG7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708215389; c=relaxed/simple;
	bh=UuT32SyYaKCY7zsyInrLw9pJf/lsbvEouRt23HU4e8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e8HRSN+DW0X3Pys2ZrMJfDNvNGvDUnRMI5X6yYUJZsPdOIkhf3TTtJD/B/719FlyrHfk3j8DZJp7YzeVifrXaHtCcfonWz8dKQ/STE+qxL+nsIbJz6FeNML1BTzGMPYS9rM5EQ2dNHlabThfikjVAxwh4B1UE+3PT9qTlFEtNFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=LG4x3dES; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1708215378;
	bh=SdDVeMmt6qwYZT3yLAbV+2fQAihanKI9PnpnYBAS1jE=;
	h=From:To:Cc:Subject:Date:From;
	b=LG4x3dES9eOlPN2p3bw8wWtkrR+ILZTxq1KyW46qrJ3fdq9WR4mV/jMgz89Qo83T+
	 ZaKc+E7VBMXosEOs64iq8RZwmYQ8Ye7pF5bMTHEjTWcy+XImNPl8VDK7ZzGJcLyYRq
	 wdsKDJXSucROkwnRWIrclrbioms76c6DqarBNS03A8ntdKD7gHCzqjXPwJwFTuJegt
	 Ip3nkpfzbAk69mUl/8xBedpbTJxeSNks2Y3Mde4jHfZ0UcQp3wfm3tzN7fXD4tsj5I
	 +NeaiT7w+KVQJpGGp7sNskYh2HZOIA7R/yFZjqbNDa7iHqC+NuCKZQK8iDEp9QzCMV
	 OmGyI8ZNgYEJw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TcmRg5l0Rz4wc7;
	Sun, 18 Feb 2024 11:16:15 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: arnd@arndb.de, david.engraf@sysgo.com, gbatra@linux.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 matthias.schiffer@ew.tq-group.com, nathanl@linux.ibm.com,
 naveen@kernel.org, rnsastry@linux.ibm.com, sbhat@linux.ibm.com,
 sshegde@linux.ibm.com, xiaojiangfeng@huawei.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-6.8-3 tag
Date: Sun, 18 Feb 2024 11:16:14 +1100
Message-ID: <87cysu1vap.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull some more powerpc fixes for 6.8.

This is a bit of a big batch for rc4, but just due to holiday hangover and
because I didn't send any fixes last week due to a late revert request. I think
next week should be back to normal.

cheers

The following changes since commit 41bccc98fb7931d63d03f326a746ac4d429c1dd3:

  Linux 6.8-rc2 (2024-01-28 17:01:12 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.8-3

for you to fetch changes up to 0846dd77c8349ec92ca0079c9c71d130f34cb192:

  powerpc/iommu: Fix the missing iommu_group_put() during platform domain attach (2024-02-14 23:59:23 +1100)

- ------------------------------------------------------------------
powerpc fixes for 6.8 #3

 - Fix ftrace bug on boot caused by exit text sections with -fpatchable-function-entry.

 - Fix accuracy of stolen time on pseries since the switch to VIRT_CPU_ACCOUNTING_GEN.

 - Fix a crash in the IOMMU code when doing DLPAR remove.

 - Set pt_regs->link on scv entry to fix BPF stack unwinding.

 - Add missing PPC_FEATURE_BOOKE on 64-bit e5500/e6500, which broke gdb.

 - Fix boot on some 6xx platforms with STRICT_KERNEL_RWX enabled.

 - Fix build failures with KASAN enabled and 32KB stack size.

 - Some other minor fixes.

Thanks to: Arnd Bergmann, Benjamin Gray, Christophe Leroy, David Engraf, Gaurav
Batra, Jason Gunthorpe, Jiangfeng Xiao, Matthias Schiffer, Nathan Lynch, Naveen
N Rao, Nicholas Piggin, Nysal Jan K.A, R Nageswara Sastry, Shivaprasad G Bhat,
Shrikanth Hegde, Spoorthy, Srikar Dronamraju, Venkat Rao Bagalkote.

- ------------------------------------------------------------------
Arnd Bergmann (2):
      powerpc: udbg_memcons: mark functions static
      powerpc: 85xx: mark local functions static

David Engraf (1):
      powerpc/cputable: Add missing PPC_FEATURE_BOOKE on PPC64 Book-E

Gaurav Batra (1):
      powerpc/pseries/iommu: Fix iommu initialisation during DLPAR add

Jiangfeng Xiao (1):
      powerpc/kasan: Fix addr error caused by page alignment

Matthias Schiffer (1):
      powerpc/6xx: set High BAT Enable flag on G2_LE cores

Michael Ellerman (2):
      Revert "powerpc/pseries/iommu: Fix iommu initialisation during DLPAR add"
      powerpc/kasan: Limit KASAN thread size increase to 32KB

Nathan Lynch (1):
      powerpc/pseries/papr-sysparm: use u8 arrays for payloads

Naveen N Rao (2):
      powerpc/64: Set task pt_regs->link to the LR value on scv entry
      powerpc/ftrace: Ignore ftrace locations in exit text sections

R Nageswara Sastry (1):
      selftests/powerpc/papr_vpd: Check devfd before get_system_loc_code()

Shivaprasad G Bhat (1):
      powerpc/iommu: Fix the missing iommu_group_put() during platform domain attach

Shrikanth Hegde (1):
      powerpc/pseries: fix accuracy of stolen time


 arch/powerpc/include/asm/ftrace.h                   | 10 ++--------
 arch/powerpc/include/asm/papr-sysparm.h             |  2 +-
 arch/powerpc/include/asm/reg.h                      |  2 ++
 arch/powerpc/include/asm/sections.h                 |  1 +
 arch/powerpc/include/asm/thread_info.h              |  2 +-
 arch/powerpc/include/uapi/asm/papr-sysparm.h        |  2 +-
 arch/powerpc/kernel/cpu_setup_6xx.S                 | 20 +++++++++++++++++++-
 arch/powerpc/kernel/cpu_specs_e500mc.h              |  3 ++-
 arch/powerpc/kernel/interrupt_64.S                  |  4 ++--
 arch/powerpc/kernel/iommu.c                         |  4 +++-
 arch/powerpc/kernel/trace/ftrace.c                  | 12 ++++++++++++
 arch/powerpc/kernel/trace/ftrace_64_pg.c            |  5 +++++
 arch/powerpc/kernel/vmlinux.lds.S                   |  2 ++
 arch/powerpc/mm/kasan/init_32.c                     |  1 +
 arch/powerpc/platforms/85xx/mpc8536_ds.c            |  2 +-
 arch/powerpc/platforms/85xx/mvme2500.c              |  2 +-
 arch/powerpc/platforms/85xx/p1010rdb.c              |  2 +-
 arch/powerpc/platforms/85xx/p1022_ds.c              |  6 +++---
 arch/powerpc/platforms/85xx/p1022_rdk.c             |  6 +++---
 arch/powerpc/platforms/85xx/socrates_fpga_pic.c     |  2 ++
 arch/powerpc/platforms/85xx/xes_mpc85xx.c           |  2 +-
 arch/powerpc/platforms/pseries/lpar.c               |  8 ++++++--
 arch/powerpc/sysdev/udbg_memcons.c                  |  6 +++---
 tools/testing/selftests/powerpc/papr_vpd/papr_vpd.c |  4 ++--
 24 files changed, 77 insertions(+), 33 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmXRS0wACgkQUevqPMjh
pYBS2hAAuHWg/zSRifvkc10YwFJPMjufaGvN7/H49VPipVDqjEq8OsPWFpTC4WrK
7giDvvcR9udoNQKX9wismvHAG3zWfmmshGYozpH/+V+/ZNhf3bQAnrpx+cshB1q7
dhDEAQneNBw9q5EYY7HvXrBcXiuvFoldVOIfIbSx70wRGCHatkZAn8TSY7JVQNLj
AkbFXqoGk8mTKrL1LIRB5jSUMadXvEzFiXaaz8P9WVrC9lFTmv/o/8VcWu070j4s
NzTNJZi/ToIRrHPIOiEWjuku/Z61rakBg2XXcZbr6c9mY5BKqsdJ4RSb2sNr+/xw
DxTZF19M94aqiElAot/asV+amVpcTqz3DZNgX46QNENoGawuilT8SKH2ZdrDNgRX
vl7FTNLi9UR18kQFG84pNTQXMZEFqtapnbtvLysejfC8FTttPtcLdh9LnZBGxMmU
l7G3l7T1uisW4lnSrgI4t6d1Kq7vR4/T1TkvgGIEHVufa0R+CXdbppIRzIfokOyd
p9c4UKjWXypwACqXfhqovg6H7IwUaor1b1sr3Oyd1J8PliTgFL5q6AA2okCdx6uM
urzRgcqA6++PsZfxQSSPBlmhAAt6UrsUPO4qQa/ZKSuYTIeqX2Ucdn2T/3f7apoN
Av4ip3vtSdfJ3nQf3DiDYvNIH2TnjTa0PPFQZy7veC7NxhHEjiw=
=fGhO
-----END PGP SIGNATURE-----

