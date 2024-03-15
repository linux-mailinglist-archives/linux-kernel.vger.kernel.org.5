Return-Path: <linux-kernel+bounces-104994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E65287D767
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 00:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B03191C21319
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 23:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CBE5A4C9;
	Fri, 15 Mar 2024 23:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="EXgUWZWl"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3224059B72
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 23:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710546437; cv=none; b=YpVqPYTIh0Vq5rvAFxtlKpde8JlVb/pdVPawGSuzmgghgl6Pp19/HKABCg1Z2KsoWrap6BbA0lVGJRUTPflPRFoU7pQZAm1EOt92PfRxZ3tDg9PVa1sRIcX5rpZs0OQmKhfm4oQf9Vmf6bRZNRvG+JeqlL2M2JeRcDhCfc1XTic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710546437; c=relaxed/simple;
	bh=1jG3+B6Wo5SKWrKN8To7QkuVseFeTSSKfqwtIDsOb7w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P9fV9Qcg1YQsO9Wvn/7WuFrvAaEGs03bjl8uPUySM0uj2DRUIEHPa8FE15Uakt37W3UkUmZvLwJprZwylUjvztakChVb3t48GfiZY3YoHhKx12boUMtHH+vyjGmi8YkiZ10RD/zg9QBHQad4mtlSItj23jjS2KgcTPO+zxh2i/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=EXgUWZWl; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1710546432;
	bh=FG2Nv0F05yJObGO8a48B/n6tf0q2gSagGtgilJ6jKhI=;
	h=From:To:Cc:Subject:Date:From;
	b=EXgUWZWlWTEpNF8Zlo0t23/wB3+R6i6t8eJzHs92gCIPaNiLiHUzSqcRf4Wfpd0Rs
	 VPzx1gKW0W1dpujMoRoV4YtCx7x6FepTKU+DMB0TDTbbw83MjtaMxlMy0Kx80wcroM
	 wYoRqpT/hsSqFiqW9vkZQ3ENzEfS4/vDpv7yf9rFQpJ9a6BPoqaQWukwgXVyi3EsOs
	 Ae+S0KmK937DFE8D4rk3+nLI14x3OADxHtbw6inCcTemK3vdLOp0NUmWbj2S5Bsd4Z
	 Ch2UbtWwBFjwgsPLXSHnz06inZaqG9EiiYI/eJhWff5WSRCgtJk3M+QgX4xLjjQgyw
	 aerNDsxUD6lOg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TxLWb4tb4z4wcC;
	Sat, 16 Mar 2024 10:47:07 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: adhemerval.zanella@linaro.org, arnd@arndb.de, bergner@linux.ibm.com,
 brking@linux.ibm.com, chentao@kylinos.cn, christophe.leroy@csgroup.eu,
 damien.lemoal@opensource.wdc.com, geoff@infradead.org,
 kjain@linux.ibm.com, kuba@kernel.org, linqiheng@huawei.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 maddy@linux.ibm.com, masahiroy@kernel.org, nathan@kernel.org,
 npiggin@gmail.com, ricardo@marliere.net, segher@kernel.crashing.org,
 set_pte_at@outlook.com, sshegde@linux.ibm.com, sv@linux.ibm.com,
 szabolcs.nagy@arm.com, u.kleine-koenig@pengutronix.de, zeming@nfschina.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-6.9-1 tag
Date: Sat, 16 Mar 2024 10:47:07 +1100
Message-ID: <87h6h72h38.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull powerpc updates for 6.9. No conflicts I'm aware of.

cheers

Notable out of area changes:
  # 9db2235326c4 powerpc/macio: Make remove callback of macio driver void r=
eturned
    drivers/ata/pata_macio.c
    drivers/net/ethernet/apple/bmac.c
    drivers/net/ethernet/apple/mace.c
    drivers/scsi/mac53c94.c
    drivers/scsi/mesh.c
    drivers/tty/serial/pmac_zilog.c
    sound/aoa/soundbus/i2sbus/core.c

  include/uapi/linux/auxvec.h # 3281366a8e79 uapi/auxvec: Define AT_HWCAP3 =
and AT_HWCAP4 aux vector, entries
  drivers/of/base.c           # 1ac8205f9075 of: Reimplement of_machine_is_=
compatible() using of_machine_compatible_match()
  include/linux/of.h          # 1ac8205f9075 of: Reimplement of_machine_is_=
compatible() using of_machine_compatible_match()

The following changes since commit 41bccc98fb7931d63d03f326a746ac4d429c1dd3:

  Linux 6.8-rc2 (2024-01-28 17:01:12 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/po=
werpc-6.9-1

for you to fetch changes up to 9db2235326c4b868b6e065dfa3a69011ee570848:

  powerpc/macio: Make remove callback of macio driver void returned (2024-0=
3-07 23:06:19 +1100)

- ------------------------------------------------------------------
powerpc updates for 6.9

 - Add AT_HWCAP3 and AT_HWCAP4 aux vector entries for future use by glibc.

 - Add support for recognising the Power11 architected and raw PVRs.

 - Add support for nr_cpus=3Dn on the command line where the boot CPU is >=
=3D n.

 - Add ppcxx_allmodconfig targets for all 32-bit sub-arches.

 - Other small features, cleanups and fixes.

Thanks to: Akanksha J N, Brian King, Christophe Leroy, Dawei Li, Geoff Leva=
nd,
Greg Kroah-Hartman, Jan-Benedict Glaw, Kajol Jain, Kunwu Chan, Li zeming,
Madhavan Srinivasan, Masahiro Yamada, Nathan Chancellor, Nicholas Piggin, P=
eter
Bergner, Qiheng Lin, Randy Dunlap, Ricardo B. Marliere, Rob Herring, Sathvi=
ka
Vasireddy, Shrikanth Hegde, Uwe Kleine-K=C3=B6nig, Vaibhav Jain, Wen Xiong.

- ------------------------------------------------------------------
Brian King (1):
      powerpc: Enable support for 32 bit MSI-X vectors

Christophe Leroy (11):
      powerpc: Force inlining of arch_vmap_p{u/m}d_supported()
      powerpc/trace: Restrict hash_fault trace event to HASH MMU
      powerpc: Use user_mode() macro when possible
      powerpc: Implement set_memory_rox()
      powerpc/kprobes: Handle error returned by set_memory_rox()
      powerpc: Refactor __kernel_map_pages()
      powerpc: Don't ignore errors from set_memory_{n}p() in __kernel_map_p=
ages()
      of: Reimplement of_machine_is_compatible() using of_machine_compatibl=
e_match()
      powerpc/machdep: Define 'compatibles' property in ppc_md and use it
      powerpc: Stop using of_root
      powerpc: Remove cpu-as-y completely

Dawei Li (1):
      powerpc/macio: Make remove callback of macio driver void returned

Geoff Levand (1):
      Revert "powerpc/ps3_defconfig: Disable PPC64_BIG_ENDIAN_ELF_ABI_V2"

Kajol Jain (1):
      powerpc/hv-gpci: Fix the H_GET_PERF_COUNTER_INFO hcall return value c=
hecks

Kunwu Chan (1):
      powerpc/mm: Code cleanup for __hash_page_thp

Li zeming (1):
      powerpc/boot: Handle allocation failure in simple_realloc()

Madhavan Srinivasan (2):
      powerpc: Add Power11 architected and raw mode
      powerpc/perf: Power11 Performance Monitoring support

Masahiro Yamada (1):
      powerpc: remove unused KCSAN_SANITIZE_early_64.o in Makefile

Michael Ellerman (22):
      powerpc/smp: Adjust nr_cpu_ids to cover all threads of a core
      powerpc/smp: Increase nr_cpu_ids to include the boot CPU
      powerpc/smp: Lookup avail once per device tree node
      powerpc/smp: Factor out assign_threads()
      powerpc/smp: Remap boot CPU onto core 0 if >=3D nr_cpu_ids
      powerpc/32: fix ADB_CUDA kconfig warning
      powerpc/boot: Only free if realloc() succeeds
      powerpc/85xx: Make some pic_init functions static
      powerpc: Add allmodconfig for all 32-bit sub-arches
      of: Add of_machine_compatible_match()
      of: Change of_machine_is_compatible() to return bool
      powerpc/irq: Allow softirq to hardirq stack transition
      powerpc/64s: Move dcbt/dcbtst sequence into a macro
      powerpc/64s: Use .machine power4 around dcbt
      powerpc/fsl: Fix mfpmr build errors with newer binutils
      powerpc/fsl: Modernise mt/mfpmr
      powerpc/fsl: Fix mfpmr() asm constraint error
      powerpc/embedded6xx: Fix no previous prototype for avr_uart_send() et=
c.
      powerpc/amigaone: Make several functions static
      powerpc/4xx: Fix warp_gpio_leds build failure
      powerpc/64s: Fix get_hugepd_cache_index() build failure
      powerpc/83xx: Fix build failure with FPU=3Dn

Nathan Chancellor (1):
      powerpc: xor_vmx: Add '-mhard-float' to CFLAGS

Nicholas Piggin (5):
      powerpc/pseries: Add a clear modifier to ibm,pa/pi-features parser
      powerpc/pseries: Set CPU_FTR_DBELL according to ibm,pi-features
      powerpc/ps3: Fix lv1 hcall assembly for ELFv2 calling convention
      powerpc/ps3: lv1 hcall code use symbolic constant for LR save offset
      powerpc/ps3: Make real stack frames for LV1 hcalls

Peter Bergner (1):
      uapi/auxvec: Define AT_HWCAP3 and AT_HWCAP4 aux vector, entries

Qiheng Lin (1):
      powerpc/pseries: Fix potential memleak in papr_get_attr()

Ricardo B. Marliere (6):
      powerpc: vio: move device attributes into a new ifdef
      powerpc: vio: make vio_bus_type const
      powerpc: mpic: make mpic_subsys const
      powerpc: pmac: make macio_bus_type const
      powerpc: ibmebus: make ibmebus_bus_type const
      macintosh/adb: make adb_dev_class constant

Sathvika Vasireddy (1):
      powerpc/32: Curb objtool unannotated intra-function call warning

Shrikanth Hegde (1):
      powerpc: Remove duplicate/unnecessary ifdefs

Uwe Kleine-K=C3=B6nig (13):
      macintosh: therm_windtunnel: Convert to platform remove callback retu=
rning void
      macintosh: windfarm_pm112: Convert to platform remove callback return=
ing void
      macintosh: windfarm_pm121: Convert to platform remove callback return=
ing void
      macintosh: windfarm_pm72: Convert to platform remove callback returni=
ng void
      macintosh: windfarm_pm81: Convert to platform remove callback returni=
ng void
      macintosh: windfarm_pm91: Convert to platform remove callback returni=
ng void
      macintosh: windfarm_rm31: Convert to platform remove callback returni=
ng void
      powerpc: sgy_cts1000: Convert to platform remove callback returning v=
oid
      powerpc: gpio_mdio: Convert to platform remove callback returning void
      powerpc: opal-prd: Convert to platform remove callback returning void
      powerpc: papr_scm: Convert to platform remove callback returning void
      powerpc: fsl_msi: Convert to platform remove callback returning void
      powerpc: pmi: Convert to platform remove callback returning void


 arch/powerpc/Makefile                                     |  32 ++-
 arch/powerpc/boot/simple_alloc.c                          |   7 +-
 arch/powerpc/configs/40x.config                           |   2 +
 arch/powerpc/configs/44x.config                           |   2 +
 arch/powerpc/configs/85xx-32bit.config                    |   1 +
 arch/powerpc/configs/8xx.config                           |   2 +
 arch/powerpc/configs/ps3_defconfig                        |   1 -
 arch/powerpc/include/asm/book3s/64/hash.h                 |   2 -
 arch/powerpc/include/asm/book3s/64/pgtable-64k.h          |   4 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h              |  10 -
 arch/powerpc/include/asm/book3s/64/radix.h                |   2 -
 arch/powerpc/include/asm/cputable.h                       |  14 +-
 arch/powerpc/include/asm/ibmebus.h                        |   2 +-
 arch/powerpc/include/asm/interrupt.h                      |   2 +-
 arch/powerpc/include/asm/machdep.h                        |   1 +
 arch/powerpc/include/asm/macio.h                          |   4 +-
 arch/powerpc/include/asm/mmu.h                            |   1 +
 arch/powerpc/include/asm/mpic.h                           |   2 +-
 arch/powerpc/include/asm/paca.h                           |   4 -
 arch/powerpc/include/asm/ppc_asm.h                        |  26 +-
 arch/powerpc/include/asm/reg.h                            |   2 +
 arch/powerpc/include/asm/reg_fsl_emb.h                    |  25 +-
 arch/powerpc/include/asm/set_memory.h                     |   7 +
 arch/powerpc/include/asm/smp.h                            |   1 +
 arch/powerpc/include/asm/switch_to.h                      |   4 +
 arch/powerpc/include/asm/trace.h                          |   3 +-
 arch/powerpc/include/asm/vio.h                            |   2 +-
 arch/powerpc/include/asm/vmalloc.h                        |   4 +-
 arch/powerpc/kernel/Makefile                              |   1 -
 arch/powerpc/kernel/asm-offsets.c                         |   2 -
 arch/powerpc/kernel/cpu_specs_book3s_64.h                 |  34 +++
 arch/powerpc/kernel/dt_cpu_ftrs.c                         |  10 +
 arch/powerpc/kernel/irq.c                                 |   5 +-
 arch/powerpc/kernel/kprobes.c                             |  10 +-
 arch/powerpc/kernel/prom.c                                |  32 ++-
 arch/powerpc/kernel/prom_init.c                           |  10 +-
 arch/powerpc/kernel/secure_boot.c                         |   8 +-
 arch/powerpc/kernel/setup-common.c                        |  60 ++--
 arch/powerpc/kernel/syscall.c                             |   2 +-
 arch/powerpc/kernel/traps.c                               |   4 +-
 arch/powerpc/kexec/ranges.c                               |   8 +-
 arch/powerpc/kexec/relocate_32.S                          |   2 +
 arch/powerpc/kvm/book3s_hv.c                              |   1 +
 arch/powerpc/lib/Makefile                                 |   2 +-
 arch/powerpc/lib/copypage_power7.S                        |  12 +-
 arch/powerpc/lib/copyuser_power7.S                        |  12 +-
 arch/powerpc/lib/memcpy_power7.S                          |  10 +-
 arch/powerpc/lib/sstep.c                                  |  23 +-
 arch/powerpc/mm/book3s64/hash_hugepage.c                  |  15 +-
 arch/powerpc/mm/book3s64/hash_utils.c                     |   3 +-
 arch/powerpc/mm/book3s64/radix_pgtable.c                  |  14 -
 arch/powerpc/mm/drmem.c                                   |  10 +-
 arch/powerpc/mm/mmu_decl.h                                |   2 +
 arch/powerpc/mm/numa.c                                    |   6 +-
 arch/powerpc/mm/pageattr.c                                |  28 ++
 arch/powerpc/mm/pgtable_32.c                              |  15 -
 arch/powerpc/perf/core-book3s.c                           |   4 +-
 arch/powerpc/perf/hv-gpci.c                               |  29 +-
 arch/powerpc/perf/internal.h                              |   1 +
 arch/powerpc/perf/power10-pmu.c                           |  27 ++
 arch/powerpc/platforms/40x/ppc40x_simple.c                |   9 +-
 arch/powerpc/platforms/44x/warp.c                         |   1 +
 arch/powerpc/platforms/512x/mpc512x_generic.c             |   4 +-
 arch/powerpc/platforms/52xx/efika.c                       |   4 +-
 arch/powerpc/platforms/52xx/lite5200.c                    |  10 +-
 arch/powerpc/platforms/52xx/mpc5200_simple.c              |  10 +-
 arch/powerpc/platforms/83xx/mpc830x_rdb.c                 |  10 +-
 arch/powerpc/platforms/83xx/mpc831x_rdb.c                 |  10 +-
 arch/powerpc/platforms/83xx/mpc837x_rdb.c                 |  10 +-
 arch/powerpc/platforms/83xx/suspend.c                     |   3 +-
 arch/powerpc/platforms/85xx/bsc913x_qds.c                 |   2 +-
 arch/powerpc/platforms/85xx/bsc913x_rdb.c                 |   2 +-
 arch/powerpc/platforms/85xx/corenet_generic.c             |   2 +-
 arch/powerpc/platforms/85xx/ge_imp3a.c                    |   2 +-
 arch/powerpc/platforms/85xx/sgy_cts1000.c                 |   6 +-
 arch/powerpc/platforms/85xx/tqm85xx.c                     |  10 +-
 arch/powerpc/platforms/amigaone/setup.c                   |   8 +-
 arch/powerpc/platforms/embedded6xx/linkstation.c          |   3 -
 arch/powerpc/platforms/embedded6xx/mpc10x.h               |   3 +
 arch/powerpc/platforms/pasemi/gpio_mdio.c                 |   6 +-
 arch/powerpc/platforms/pasemi/pci.c                       |   4 +-
 arch/powerpc/platforms/powermac/Kconfig                   |   2 +-
 arch/powerpc/platforms/powermac/feature.c                 |   2 -
 arch/powerpc/platforms/powernv/opal-prd.c                 |   5 +-
 arch/powerpc/platforms/ps3/hvcall.S                       | 298 ++++++++++=
+---------
 arch/powerpc/platforms/pseries/ibmebus.c                  |   4 +-
 arch/powerpc/platforms/pseries/lparcfg.c                  |   6 +-
 arch/powerpc/platforms/pseries/msi.c                      |  11 +-
 arch/powerpc/platforms/pseries/papr_platform_attributes.c |   8 +-
 arch/powerpc/platforms/pseries/papr_scm.c                 |   6 +-
 arch/powerpc/platforms/pseries/setup.c                    |  12 +-
 arch/powerpc/platforms/pseries/vio.c                      |  61 ++--
 arch/powerpc/sysdev/fsl_msi.c                             |   6 +-
 arch/powerpc/sysdev/mpic.c                                |   2 +-
 arch/powerpc/sysdev/pmi.c                                 |   6 +-
 arch/powerpc/xmon/xmon.c                                  |   6 +-
 drivers/ata/pata_macio.c                                  |   4 +-
 drivers/macintosh/adb.c                                   |  10 +-
 drivers/macintosh/macio_asic.c                            |   2 +-
 drivers/macintosh/rack-meter.c                            |   4 +-
 drivers/macintosh/therm_windtunnel.c                      |   6 +-
 drivers/macintosh/windfarm_pm112.c                        |   6 +-
 drivers/macintosh/windfarm_pm121.c                        |   5 +-
 drivers/macintosh/windfarm_pm72.c                         |   7 +-
 drivers/macintosh/windfarm_pm81.c                         |   8 +-
 drivers/macintosh/windfarm_pm91.c                         |   8 +-
 drivers/macintosh/windfarm_rm31.c                         |   7 +-
 drivers/net/ethernet/apple/bmac.c                         |   4 +-
 drivers/net/ethernet/apple/mace.c                         |   4 +-
 drivers/of/base.c                                         |  15 +-
 drivers/scsi/mac53c94.c                                   |   5 +-
 drivers/scsi/mesh.c                                       |   5 +-
 drivers/tty/serial/pmac_zilog.c                           |   7 +-
 include/linux/of.h                                        |  20 +-
 include/uapi/linux/auxvec.h                               |   2 +
 sound/aoa/soundbus/i2sbus/core.c                          |   4 +-
 tools/testing/selftests/powerpc/copyloops/asm/ppc_asm.h   |  12 +
 117 files changed, 733 insertions(+), 537 deletions(-)
 create mode 100644 arch/powerpc/configs/40x.config
 create mode 100644 arch/powerpc/configs/44x.config
 create mode 100644 arch/powerpc/configs/8xx.config
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmX024EACgkQUevqPMjh
pYAwDQ/7Bnr6iWaAXidpWx7jVMKz2GLcQNX7DLiWKYoX4AaMX22EhDYHW2SlDYDf
Q5ALqqo/CQmAta/WMgGjilihUdXiO38gJom3NjCuxQ3bmSFjYKosyEkBEXYN54Mv
iSaaNJnnr7ZmdvpFiHJQWXWKy+QEWa6Oh/hRdXd+vWX8FafmGtp6nxDsxn3vTQPg
JQ2oK2I4YuvmkH8DX+jx7PxPMS+iZ5IaCLUz7fZs0bq4xKuz6YRPi3q2QFv2yPnH
kn+8GPSGODFli54/n6UqPVfgRM4yK2r2hgSGQeyPD0KpolEc4CD59SvrrmIpX23o
5MaAoFfDGyBwPinBlMGTUdHX2/4OiXPF6YFolCLo9ufdZHO1SuDMh+9K7gJLxPvr
+L6ijOm88i9J5j7zQgXqqX3VzM/bwMWj3uQyUNy9UkzUfjP2tNme6B63dp6GJ5Cw
jwtFY/YGuyTi45WRGcVSAmypZahSmr8zt6pQSDKva8b3YSV4gX8lqrJKc0pfslXI
egQqugG4qI03IEe2bI6yFUo5nY+22swBz81mPWKF6mdlC4Aj81ACQIg2qx9seQJ1
n0Dhf0aaOYZZwdEIRkI62mldXwwre3jF36vKdezOCpGL+7Cs5ja5hzF7uYrufY7P
+QEh499ToJELKJuhOjCl3ecYxpeUjaOTqx7SD47zPjx3PTDZzXc=3D
=3DAFwm
-----END PGP SIGNATURE-----

