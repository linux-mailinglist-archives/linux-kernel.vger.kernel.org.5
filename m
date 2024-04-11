Return-Path: <linux-kernel+bounces-140757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D308A18C8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE3701F2659C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CA91B806;
	Thu, 11 Apr 2024 15:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="THvyO334"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073A317597
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849497; cv=none; b=p+pgouyvqZgBSwUzOD+l5wlIoIhc4TjGYenZQcnn03XzFgyWGcBQ7qx1xekvnYWAj93qosmmBxiKb1s5dWrgeNeNZw0rkv/vT91c3mdpfKms2VnwTS//rixQfkdHGB44n5jyc/Nplt98tMHKAvAVInN7Cg/995/Y0zak1W/4t/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849497; c=relaxed/simple;
	bh=Eh45+hgvDgPK3RSsQZiiI94gobTQabRcYeJMC4aVH3w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=CYB3kl/s3VsVRi2pRMW5rO6Unw9fGDBCjePRH7llUdiavoFziLReNXDAnXRQHpf8m73PSiCl+PftooLJZjjSLKFHks02kSB9VW43l8cC+qitlWae91aP5qe7O/9QnMQuFeVMg9Lcm3AX49BRGcoA8uMAyJPjnOX0TbE3CC3akiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=THvyO334; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so8836939f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849490; x=1713454290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=n38P9aKIM5z629iUfdwJ1Zs0wCApOipzstbbex0Jmyk=;
        b=THvyO334dxAoNaUCVudkAxBbgmToaapX7xvNnKMqcoeH2+8WGh06B/I20+PzLSaDm0
         WWsjs8SiENqkJVPiiZpyiopCrqfruvl2D27Tk3nuzT9c/kmlUIXHwUweumEAA9reWy1S
         6Ekq4vXqaMhuH8UKjG32401cfUYD+AXHCwNrU745Zjf74tAA/sgB84HBGyYGal01R1lj
         a1L/lu2ssq05rZDDRX5px6HQgH3bOgKmHnSuEKspiqmN8XHAbSAtUbtWsJqucMyTPXBq
         qAEa+jd0nLnl70PnyDk1DXnE0GJceTGpshoKhwc/uQGr9dcJYQQaQIIJK3Q2kIl+vT9V
         2BZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849490; x=1713454290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n38P9aKIM5z629iUfdwJ1Zs0wCApOipzstbbex0Jmyk=;
        b=Je4wr5oZvmRjfnsVU/Py1M2r2j1eE75Q7gULR0nYczWoGHSZXTCligzbT9gIR6QZmC
         06cW+Q6xbuRWNR+xgNjRGSNMyz35SIenxVwqE4R89XY3kTnQOXm1SR12D4Q3v1b7/dX1
         Dqko6KGzA/WwtkCZYu6j+ILxj54e6g+VGYsdMQTfTIFNyMsBuiJnKLcvJKqw0nnSfEAt
         s2FNGNDGaqF3Ed4iTeUG3oMaBJtbPVLGXViIMLtuzcF+WVkhy1mTDo0NPqwtsejaZCf2
         93jYgywvs2LXy65KXaUxh9Jn0uew+JTaSc+WXxuTCKFJS1uV+xUu3WL1tthAefZI/41G
         /DUg==
X-Gm-Message-State: AOJu0Yy69uQagMCMwMm0h+QqbBimXd/189vZhyryO9fqXGd5Oodlk1uV
	LgAVYRFfdYJThIAlUQz+Bu/ySlP+/xQQSpuClbX/z2pIhvaaJOsRwots0nx8rTHemhLdhewgSUh
	U
X-Google-Smtp-Source: AGHT+IFS4Grv59VBEPcToadCA5LPSARyuXWXv5zpplhbaqxS/yvnumLzb3Ile8isZ4xLbvgIqxIT+Q==
X-Received: by 2002:a05:6602:21d7:b0:7d6:9ddf:5095 with SMTP id c23-20020a05660221d700b007d69ddf5095mr778ioc.1.1712849489088;
        Thu, 11 Apr 2024 08:31:29 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.31.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:31:28 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Subject: [PATCHSET RFC 0/437] Kill off old fops ->read() and ->write()
Date: Thu, 11 Apr 2024 09:12:20 -0600
Message-ID: <20240411153126.16201-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patchset will obviously be split, commit messages updated, and
specific driver patches targeted to where they belong. But I figured
it'd be useful to blast out the full set at least once for reference,
and then I'll continue down the right path for the next one.

Subject line says it all, really. 10 years ago we added ->read_iter()
and ->write_iter() to struct file_operations. These are great, as they
pass in an iov_iter rather than a user buffer + length, and they also
take a struct kiocb rather than just a file. Since then we've had two
paths for any read or write - one legacy one that can't do per-IO hints
like "This read should be non-blocking", they strictly only work with
O_NONBLOCK on the file, and a newer one that supports everything the
old path does and a bunch more. We've had a few issues with the
iov_iter based path being slower, but those have basically been
resolved with solutions like ITER_UBUF to optimize the single segment
case that is often the fast path.

There are basically three parts to this series:

1) Add generic helpers that we need to convert drivers.
2) Convert any use of fops->read() and ->write()
3) Kill off old cruft.
3a) Profit.

Notes:

- Part 1 adds FOPS_READ_ITER_HELPER() and FOPS_WRITE_ITER_HELPER() to
  ease conversion of some drivers, as those just wrap the existing
  read or write function with vfs_{read,write}_iter(). Where possible
  this has been avoided and a clean implementation been done. However,
  due to lack of man power, I didn't dig super deep in some spots. It's
  my hope that drivers with active developers/maintainers will take it
  a step further and help get their driver fully converted.

- This is based on my 'read_iter' branch that adds one helper and
  converts timerfd/userfaultfd/signalfd. This branch is queued for
  6.10.

- I'm sure there are a few spots that I haven't converted just yet
  because I've missed them. If you see any, please let me know and
  I'll take care of it.

- The kernel builds allyesconfig/allmodconfig on (at least) the
  following architectures: x86-64, arm64, sparc64, s390, powerpc.
  With the above caveat that there may still be old crufty drivers
  somewhere in the tree that are missing a conversion, it should be
  fairly complete.

- Resulting kernel boots just fine, tested on x86-64 and arm64.
  Caveat emptor if you want to test it, however!

- As you may be able to tell, diffstat looks promising. The lines
  removed will continue to go up with removal of FOPS_*() wrappers.
  There are currently about 150 read side wrappers and 200 write side
  wrappers.

- I haven't done detailed analysis of text/bss sizes just yet, but
  preliminary looks show about a 100K reduction in kernel image size
  for my standard test box build.

Please have a look! A continually rebased branch for these patches can
be found here:

https://git.kernel.dk/cgit/linux/log/?h=rw_iter

 arch/arm/common/bL_switcher_dummy_if.c        |   8 +-
 arch/mips/kernel/rtlx.c                       |   6 +-
 arch/mips/kernel/vpe.c                        |  14 +-
 arch/mips/mm/sc-debugfs.c                     |  16 +-
 arch/parisc/kernel/perf.c                     |  14 +-
 arch/powerpc/kernel/dawr.c                    |  10 +-
 arch/powerpc/kernel/eeh.c                     |  58 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c           |  25 +-
 arch/powerpc/kvm/book3s_64_mmu_radix.c        |  19 +-
 arch/powerpc/kvm/book3s_hv.c                  |  26 +-
 arch/powerpc/kvm/timing.c                     |  14 +-
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c     |   7 +-
 arch/powerpc/platforms/cell/spufs/file.c      | 312 +++++------
 arch/powerpc/platforms/cell/spufs/inode.c     |   2 +-
 arch/powerpc/platforms/powernv/eeh-powernv.c  |  11 +-
 arch/powerpc/platforms/powernv/memtrace.c     |   9 +-
 arch/powerpc/platforms/powernv/opal-lpc.c     |   6 +-
 arch/powerpc/platforms/powernv/opal-prd.c     |  22 +-
 arch/powerpc/platforms/powernv/opal-xscom.c   |  30 +-
 arch/powerpc/platforms/pseries/dtl.c          |  16 +-
 arch/powerpc/platforms/pseries/lpar.c         |  11 +-
 arch/powerpc/platforms/pseries/papr-vpd.c     |   8 +-
 arch/s390/crypto/prng.c                       |  18 +-
 arch/s390/hypfs/hypfs_dbfs.c                  |  11 +-
 arch/s390/kernel/debug.c                      |  29 +-
 arch/s390/kernel/sysinfo.c                    |   6 +-
 arch/s390/pci/pci_debug.c                     |  12 +-
 arch/sh/mm/tlb-debugfs.c                      |   2 +-
 arch/sparc/kernel/mdesc.c                     |  18 +-
 arch/um/drivers/harddog_kern.c                |   6 +-
 arch/um/drivers/hostaudio_kern.c              |  22 +-
 arch/um/drivers/mmapper_kern.c                |  16 +-
 arch/x86/kernel/apm_32.c                      |  10 +-
 arch/x86/kernel/callthunks.c                  |   2 +-
 arch/x86/kernel/cpu/debugfs.c                 |   4 +-
 arch/x86/kernel/cpu/mce/dev-mcelog.c          |  38 +-
 arch/x86/kernel/cpu/mce/inject.c              |  27 +-
 arch/x86/kernel/cpu/mce/severity.c            |  11 +-
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c     |  18 +-
 arch/x86/kernel/cpuid.c                       |  16 +-
 arch/x86/kernel/kdebugfs.c                    |  14 +-
 arch/x86/kernel/msr.c                         |  28 +-
 arch/x86/kernel/tboot.c                       |  17 +-
 arch/x86/kvm/debugfs.c                        |   2 +-
 arch/x86/mm/pat/memtype.c                     |   2 +-
 arch/x86/mm/pat/set_memory.c                  |   2 +-
 arch/x86/mm/pkeys.c                           |  15 +-
 arch/x86/mm/tlb.c                             |  15 +-
 block/blk-mq-debugfs.c                        |  20 +-
 block/blk-mq-debugfs.h                        |   2 +-
 drivers/accel/habanalabs/common/debugfs.c     | 307 +++++------
 drivers/accel/habanalabs/common/habanalabs.h  |   3 +-
 drivers/accel/ivpu/ivpu_debugfs.c             |  84 ++-
 drivers/accessibility/speakup/devsynth.c      |  27 +-
 drivers/accessibility/speakup/speakup_soft.c  |  46 +-
 drivers/acpi/acpi_dbg.c                       |   6 +-
 drivers/acpi/apei/erst-dbg.c                  |  23 +-
 drivers/acpi/ec_sys.c                         |   6 +-
 drivers/acpi/pfr_update.c                     |   3 +-
 drivers/auxdisplay/charlcd.c                  |   3 +-
 drivers/auxdisplay/panel.c                    |   3 +-
 drivers/base/power/wakeup.c                   |   2 +-
 drivers/base/regmap/regmap-debugfs.c          | 115 ++--
 drivers/block/aoe/aoechr.c                    |  15 +-
 drivers/block/drbd/drbd_debugfs.c             |  10 +-
 drivers/block/mtip32xx/mtip32xx.c             |  36 +-
 drivers/block/zram/zram_drv.c                 |  14 +-
 drivers/bluetooth/btmrvl_debugfs.c            |  57 +-
 drivers/bluetooth/btusb.c                     |  20 +-
 drivers/bluetooth/hci_vhci.c                  |  73 ++-
 drivers/bus/mhi/host/debugfs.c                |  38 +-
 drivers/bus/moxtet.c                          |  30 +-
 drivers/cache/sifive_ccache.c                 |   8 +-
 drivers/char/adi.c                            |  26 +-
 drivers/char/apm-emulation.c                  |  10 +-
 drivers/char/applicom.c                       |   7 +-
 drivers/char/ds1620.c                         |   7 +-
 drivers/char/dsp56k.c                         |   6 +-
 drivers/char/dtlk.c                           |   6 +-
 drivers/char/hpet.c                           |   3 +-
 drivers/char/hw_random/core.c                 |   3 +-
 drivers/char/hw_random/s390-trng.c            |   9 +-
 drivers/char/ipmi/bt-bmc.c                    |  27 +-
 drivers/char/ipmi/ipmb_dev_int.c              |  19 +-
 drivers/char/ipmi/ipmi_watchdog.c             |  16 +-
 drivers/char/ipmi/kcs_bmc_cdev_ipmi.c         |  23 +-
 drivers/char/ipmi/ssif_bmc.c                  |  25 +-
 drivers/char/lp.c                             |  21 +-
 drivers/char/mem.c                            | 106 +---
 drivers/char/mwave/mwavedd.c                  |  19 +-
 drivers/char/nsc_gpio.c                       |  22 +-
 drivers/char/nvram.c                          |  19 +-
 drivers/char/nwbutton.c                       |   7 +-
 drivers/char/nwflash.c                        |  12 +-
 drivers/char/pc8736x_gpio.c                   |   4 +-
 drivers/char/powernv-op-panel.c               |  25 +-
 drivers/char/ppdev.c                          |  18 +-
 drivers/char/ps3flash.c                       |   6 +-
 drivers/char/scx200_gpio.c                    |   4 +-
 drivers/char/sonypi.c                         |   3 +-
 drivers/char/tlclk.c                          |   9 +-
 drivers/char/tpm/eventlog/common.c            |   2 +-
 drivers/char/tpm/tpm-dev-common.c             |  26 +-
 drivers/char/tpm/tpm-dev.c                    |   4 +-
 drivers/char/tpm/tpm-dev.h                    |   6 +-
 drivers/char/tpm/tpm_vtpm_proxy.c             |  20 +-
 drivers/char/tpm/tpmrm-dev.c                  |   4 +-
 drivers/char/virtio_console.c                 |   6 +-
 drivers/char/xilinx_hwicap/xilinx_hwicap.c    |  31 +-
 drivers/char/xillybus/xillybus_core.c         |  36 +-
 drivers/char/xillybus/xillyusb.c              |   6 +-
 drivers/clk/clk.c                             |  11 +-
 .../clk/starfive/clk-starfive-jh7110-pll.c    |   2 +-
 drivers/comedi/comedi_fops.c                  |  26 +-
 drivers/counter/counter-chrdev.c              |   3 +-
 drivers/crypto/ccp/ccp-debugfs.c              |  51 +-
 drivers/crypto/hisilicon/debugfs.c            |  51 +-
 drivers/crypto/hisilicon/hpre/hpre_main.c     |  23 +-
 drivers/crypto/hisilicon/qm.c                 |  22 +-
 drivers/crypto/hisilicon/sec2/sec_main.c      |  23 +-
 drivers/crypto/hisilicon/zip/zip_main.c       |  23 +-
 drivers/crypto/intel/iaa/iaa_crypto_stats.c   |   2 +-
 .../intel/qat/qat_common/adf_cnv_dbgfs.c      |  10 +-
 .../intel/qat/qat_common/adf_fw_counters.c    |   2 +-
 .../qat/qat_common/adf_heartbeat_dbgfs.c      |  60 +--
 .../intel/qat/qat_common/adf_pm_dbgfs.c       |   3 +-
 .../intel/qat/qat_common/adf_tl_debugfs.c     |  18 +-
 drivers/dma/xilinx/xilinx_dpdma.c             |  15 +-
 drivers/edac/altera_edac.c                    |  46 +-
 drivers/edac/debugfs.c                        |   9 +-
 drivers/edac/i5100_edac.c                     |   9 +-
 drivers/edac/npcm_edac.c                      |   8 +-
 drivers/edac/thunderx_edac.c                  |  71 ++-
 drivers/edac/versal_edac.c                    |  20 +-
 drivers/edac/xgene_edac.c                     |  43 +-
 drivers/edac/zynqmp_edac.c                    |  26 +-
 drivers/extcon/extcon-rtk-type-c.c            |   4 +-
 drivers/firewire/core-cdev.c                  |  15 +-
 drivers/firewire/nosy.c                       |  18 +-
 drivers/firmware/arm_scmi/raw_mode.c          |  94 ++--
 drivers/firmware/cirrus/cs_dsp.c              |  26 +-
 drivers/firmware/efi/capsule-loader.c         |  16 +-
 drivers/firmware/psci/psci.c                  |   2 +-
 drivers/firmware/tegra/bpmp-debugfs.c         |  26 +-
 drivers/firmware/turris-mox-rwtm.c            |  22 +-
 drivers/firmware/xilinx/zynqmp-debug.c        |  22 +-
 drivers/fsi/fsi-core.c                        |  28 +-
 drivers/fsi/fsi-occ.c                         |  20 +-
 drivers/fsi/fsi-sbefifo.c                     |   6 +-
 drivers/fsi/fsi-scom.c                        |  24 +-
 drivers/fsi/i2cr-scom.c                       |  23 +-
 drivers/gnss/core.c                           |  14 +-
 drivers/gpio/gpio-mockup.c                    |  26 +-
 drivers/gpio/gpiolib-cdev.c                   |  41 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c       |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |  71 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   2 +-
 .../drm/amd/amdgpu/amdgpu_fw_attestation.c    |  23 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c       |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c    |  18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c       |  14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  34 +-
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    |  22 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c      |   6 +-
 .../gpu/drm/amd/amdgpu/amdgpu_securedisplay.c |  14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  56 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |   3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c      |  13 +-
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c   |  19 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 111 ++--
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  11 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  17 +-
 drivers/gpu/drm/arm/malidp_drv.c              |  11 +-
 drivers/gpu/drm/armada/armada_debugfs.c       |  13 +-
 drivers/gpu/drm/bridge/ite-it6505.c           |  14 +-
 drivers/gpu/drm/drm_debugfs.c                 |  28 +-
 drivers/gpu/drm/drm_debugfs_crc.c             |  26 +-
 drivers/gpu/drm/drm_file.c                    |  22 +-
 drivers/gpu/drm/drm_mipi_dbi.c                |  14 +-
 drivers/gpu/drm/gma500/psb_drv.c              |   2 +-
 .../drm/i915/display/intel_display_debugfs.c  | 114 ++--
 .../display/intel_display_debugfs_params.c    |  36 +-
 drivers/gpu/drm/i915/display/intel_hotplug.c  |  28 +-
 drivers/gpu/drm/i915/display/intel_wm.c       |  42 +-
 drivers/gpu/drm/i915/display/skl_watermark.c  |  14 +-
 drivers/gpu/drm/i915/gt/intel_gt_debugfs.c    |   2 +-
 drivers/gpu/drm/i915/gt/intel_gt_debugfs.h    |   2 +-
 .../drm/i915/gt/uc/intel_guc_log_debugfs.c    |  13 +-
 drivers/gpu/drm/i915/i915_debugfs_params.c    |  43 +-
 drivers/gpu/drm/i915/i915_driver.c            |   2 +-
 drivers/gpu/drm/i915/i915_gpu_error.c         |  28 +-
 drivers/gpu/drm/i915/i915_perf.c              |   3 +-
 drivers/gpu/drm/imagination/pvr_fw_trace.c    |   2 +-
 drivers/gpu/drm/imagination/pvr_params.c      |   4 +-
 drivers/gpu/drm/loongson/lsdc_crtc.c          |  14 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c |  20 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       |  20 +-
 drivers/gpu/drm/msm/dp/dp_debug.c             |  15 +-
 drivers/gpu/drm/msm/msm_debugfs.c             |   4 +-
 drivers/gpu/drm/msm/msm_perf.c                |  12 +-
 drivers/gpu/drm/msm/msm_rd.c                  |  12 +-
 drivers/gpu/drm/nouveau/dispnv50/crc.c        |  13 +-
 drivers/gpu/drm/nouveau/nouveau_debugfs.c     |  12 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c         |   2 +-
 drivers/gpu/drm/omapdrm/dss/dss.c             |   2 +-
 drivers/gpu/drm/radeon/radeon_drv.c           |   2 +-
 drivers/gpu/drm/radeon/radeon_ttm.c           |  40 +-
 drivers/gpu/drm/tegra/drm.c                   |   2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c           |   2 +-
 drivers/gpu/drm/xe/xe_device.c                |   2 +-
 drivers/gpu/vga/vga_switcheroo.c              |  10 +-
 drivers/greybus/es2.c                         |  29 +-
 drivers/greybus/svc.c                         |  27 +-
 drivers/hid/hid-debug.c                       |   3 +-
 drivers/hid/hid-picolcd_debugfs.c             |  65 +--
 drivers/hid/hid-roccat.c                      |  12 +-
 drivers/hid/hid-sensor-custom.c               |   3 +-
 drivers/hid/hid-wiimote-debug.c               |  15 +-
 drivers/hid/hidraw.c                          |  15 +-
 drivers/hid/uhid.c                            |  15 +-
 drivers/hid/usbhid/hiddev.c                   |  17 +-
 drivers/hsi/clients/cmt_speech.c              |  22 +-
 drivers/hsi/clients/hsi_char.c                |  22 +-
 drivers/hv/hv_utils_transport.c               |  20 +-
 drivers/hwmon/asus_atk0110.c                  |   9 +-
 drivers/hwmon/fschmd.c                        |  10 +-
 drivers/hwmon/mr75203.c                       |  20 +-
 drivers/hwmon/pmbus/acbel-fsg032.c            |  10 +-
 drivers/hwmon/pmbus/ibm-cffps.c               |  35 +-
 drivers/hwmon/pmbus/max20730.c                |  10 +-
 drivers/hwmon/pmbus/pmbus_core.c              |  10 +-
 drivers/hwmon/pmbus/q54sj108a2.c              |  25 +-
 drivers/hwmon/pmbus/ucd9000.c                 |  11 +-
 drivers/hwmon/pt5161l.c                       |  31 +-
 drivers/hwmon/w83793.c                        |  10 +-
 .../hwtracing/coresight/coresight-cpu-debug.c |  15 +-
 drivers/hwtracing/coresight/coresight-etb10.c |  18 +-
 .../hwtracing/coresight/coresight-tmc-core.c  |  14 +-
 drivers/hwtracing/coresight/ultrasoc-smb.c    |  12 +-
 drivers/hwtracing/intel_th/msu.c              |  46 +-
 drivers/hwtracing/stm/core.c                  |  10 +-
 drivers/i2c/i2c-dev.c                         |  25 +-
 drivers/iio/gyro/adis16136.c                  |   9 +-
 drivers/iio/iio_core.h                        |   7 +-
 drivers/iio/imu/adis16400.c                   |  10 +-
 drivers/iio/imu/adis16475.c                   |  22 +-
 drivers/iio/imu/adis16480.c                   |  20 +-
 drivers/iio/imu/bno055/bno055.c               |   9 +-
 drivers/iio/industrialio-buffer.c             |  20 +-
 drivers/iio/industrialio-core.c               |  34 +-
 drivers/iio/industrialio-event.c              |   3 +-
 drivers/infiniband/core/ucma.c                |   3 +-
 drivers/infiniband/core/user_mad.c            |   6 +-
 drivers/infiniband/core/uverbs_main.c         |  11 +-
 drivers/infiniband/hw/cxgb4/device.c          |  35 +-
 drivers/infiniband/hw/hfi1/debugfs.c          | 162 +++---
 drivers/infiniband/hw/hfi1/debugfs.h          |   6 +-
 drivers/infiniband/hw/hfi1/fault.c            |  27 +-
 drivers/infiniband/hw/hns/hns_roce_debugfs.c  |   2 +-
 drivers/infiniband/hw/mlx5/cong.c             |  19 +-
 drivers/infiniband/hw/mlx5/devx.c             |  24 +-
 drivers/infiniband/hw/mlx5/main.c             |  20 +-
 drivers/infiniband/hw/mlx5/mr.c               |  38 +-
 drivers/infiniband/hw/ocrdma/ocrdma_stats.c   |  26 +-
 drivers/infiniband/hw/qib/qib_debugfs.c       |   2 +-
 drivers/infiniband/hw/qib/qib_diag.c          |  18 +-
 drivers/infiniband/hw/qib/qib_file_ops.c      |   4 +-
 drivers/infiniband/hw/qib/qib_fs.c            | 119 ++---
 drivers/infiniband/hw/usnic/usnic_debugfs.c   |  22 +-
 drivers/input/evdev.c                         |   6 +-
 drivers/input/joydev.c                        |  22 +-
 drivers/input/keyboard/applespi.c             |  11 +-
 drivers/input/misc/uinput.c                   |   6 +-
 drivers/input/mousedev.c                      |  16 +-
 drivers/input/serio/serio_raw.c               |   6 +-
 drivers/input/serio/userio.c                  |  22 +-
 drivers/input/touchscreen/edt-ft5x06.c        |  19 +-
 drivers/iommu/intel/debugfs.c                 |  14 +-
 drivers/iommu/omap-iommu-debug.c              |  11 +-
 drivers/isdn/capi/capi.c                      |  22 +-
 drivers/isdn/mISDN/timerdev.c                 |  16 +-
 drivers/leds/uleds.c                          |  33 +-
 drivers/macintosh/adb.c                       |  22 +-
 drivers/macintosh/ans-lcd.c                   |  29 +-
 drivers/macintosh/smu.c                       |  40 +-
 drivers/macintosh/via-pmu.c                   |  19 +-
 drivers/mailbox/bcm-pdc-mailbox.c             |   9 +-
 drivers/mailbox/mailbox-test.c                |  37 +-
 drivers/md/bcache/debug.c                     |  11 +-
 drivers/media/cec/core/cec-core.c             |  12 +-
 drivers/media/common/siano/smsdvb-debugfs.c   |  17 +-
 drivers/media/dvb-core/dmxdev.c               |   9 +-
 drivers/media/dvb-core/dvb_ca_en50221.c       |  25 +-
 drivers/media/mc/mc-devnode.c                 |   6 +-
 drivers/media/pci/bt8xx/dst_ca.c              |   8 +-
 drivers/media/pci/ddbridge/ddbridge-core.c    |   6 +-
 drivers/media/pci/ngene/ngene-dvb.c           |   6 +-
 drivers/media/platform/amphion/vpu_dbg.c      |  24 +-
 .../mediatek/vcodec/common/mtk_vcodec_dbgfs.c |  21 +-
 drivers/media/platform/mediatek/vpu/mtk_vpu.c |   9 +-
 drivers/media/radio/radio-si476x.c            |  60 +--
 drivers/media/rc/imon.c                       |  26 +-
 drivers/media/rc/lirc_dev.c                   |  15 +-
 drivers/media/usb/uvc/uvc_debugfs.c           |  10 +-
 drivers/media/v4l2-core/v4l2-dev.c            |   6 +-
 drivers/mfd/aat2870-core.c                    |  20 +-
 drivers/mfd/tps65010.c                        |   2 +-
 drivers/misc/bcm-vk/bcm_vk.h                  |   6 +-
 drivers/misc/bcm-vk/bcm_vk_dev.c              |   4 +-
 drivers/misc/bcm-vk/bcm_vk_msg.c              |  23 +-
 drivers/misc/cxl/api.c                        |   7 +-
 drivers/misc/cxl/cxl.h                        |   2 +-
 drivers/misc/cxl/file.c                       |  23 +-
 drivers/misc/eeprom/idt_89hpesx.c             |  21 +-
 drivers/misc/hpilo.c                          |  21 +-
 drivers/misc/ibmasm/ibmasmfs.c                |  94 ++--
 drivers/misc/ibmvmc.c                         |  40 +-
 drivers/misc/lis3lv02d/lis3lv02d.c            |  13 +-
 drivers/misc/lkdtm/core.c                     |  40 +-
 drivers/misc/mei/debugfs.c                    |  12 +-
 drivers/misc/mei/main.c                       |  53 +-
 drivers/misc/ocxl/file.c                      |  20 +-
 drivers/misc/open-dice.c                      |  19 +-
 drivers/misc/tps6594-pfsm.c                   |  30 +-
 drivers/mmc/core/block.c                      |  10 +-
 drivers/mmc/core/debugfs.c                    |  11 +-
 drivers/mmc/core/mmc_test.c                   |  12 +-
 drivers/most/most_cdev.c                      |  50 +-
 drivers/mtd/mtdchar.c                         |  52 +-
 drivers/mtd/ubi/cdev.c                        |  58 +-
 drivers/mtd/ubi/debug.c                       |  38 +-
 drivers/mtd/ubi/ubi.h                         |   4 +-
 drivers/mtd/ubi/upd.c                         |  24 +-
 drivers/net/ethernet/amd/xgbe/xgbe-debugfs.c  | 233 ++++----
 .../net/ethernet/broadcom/bnxt/bnxt_debugfs.c |  13 +-
 .../net/ethernet/brocade/bna/bnad_debugfs.c   |  47 +-
 .../ethernet/chelsio/cxgb4/cxgb4_debugfs.c    | 321 +++++------
 drivers/net/ethernet/chelsio/cxgb4/l2t.c      |   2 +-
 .../ethernet/hisilicon/hns3/hns3_debugfs.c    |  15 +-
 .../net/ethernet/huawei/hinic/hinic_debugfs.c |  13 +-
 .../net/ethernet/intel/fm10k/fm10k_debugfs.c  |  10 +-
 .../net/ethernet/intel/i40e/i40e_debugfs.c    | 103 ++--
 drivers/net/ethernet/intel/ice/ice_debugfs.c  | 181 +++----
 .../net/ethernet/intel/ixgbe/ixgbe_debugfs.c  |  99 ++--
 .../marvell/octeontx2/af/rvu_debugfs.c        | 159 +++---
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c |  78 +--
 .../net/ethernet/mellanox/mlx5/core/debugfs.c |  49 +-
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  |  13 +-
 drivers/net/ieee802154/ca8210.c               |  29 +-
 drivers/net/netdevsim/dev.c                   |  73 ++-
 drivers/net/netdevsim/fib.c                   |  16 +-
 drivers/net/netdevsim/health.c                |  12 +-
 drivers/net/netdevsim/hwstats.c               |  13 +-
 drivers/net/netdevsim/ipsec.c                 |  10 +-
 drivers/net/netdevsim/psample.c               |  12 +-
 drivers/net/netdevsim/udp_tunnels.c           |   9 +-
 drivers/net/ppp/ppp_generic.c                 |  13 +-
 drivers/net/wireless/ath/ath10k/debug.c       | 502 ++++++++----------
 drivers/net/wireless/ath/ath10k/debugfs_sta.c | 119 ++---
 drivers/net/wireless/ath/ath10k/spectral.c    |  65 ++-
 drivers/net/wireless/ath/ath11k/debugfs.c     | 300 +++++------
 .../wireless/ath/ath11k/debugfs_htt_stats.c   |  56 +-
 drivers/net/wireless/ath/ath11k/debugfs_sta.c | 163 +++---
 drivers/net/wireless/ath/ath11k/spectral.c    |  69 ++-
 drivers/net/wireless/ath/ath5k/debug.c        | 148 +++---
 drivers/net/wireless/ath/ath6kl/debug.c       | 312 +++++------
 drivers/net/wireless/ath/ath9k/common-debug.c |  36 +-
 .../net/wireless/ath/ath9k/common-spectral.c  | 111 ++--
 drivers/net/wireless/ath/ath9k/debug.c        | 210 ++++----
 drivers/net/wireless/ath/ath9k/debug_sta.c    |  18 +-
 drivers/net/wireless/ath/ath9k/dfs_debug.c    |  30 +-
 .../net/wireless/ath/ath9k/htc_drv_debug.c    |  82 ++-
 drivers/net/wireless/ath/ath9k/tx99.c         |  40 +-
 drivers/net/wireless/ath/carl9170/debug.c     |  25 +-
 drivers/net/wireless/ath/wcn36xx/debug.c      |  42 +-
 drivers/net/wireless/ath/wil6210/debugfs.c    | 235 ++++----
 drivers/net/wireless/ath/wil6210/pmc.c        |  27 +-
 drivers/net/wireless/ath/wil6210/pmc.h        |   2 +-
 drivers/net/wireless/broadcom/b43/debugfs.c   |  30 +-
 .../net/wireless/broadcom/b43legacy/debugfs.c |  31 +-
 .../broadcom/brcm80211/brcmfmac/core.c        |  10 +-
 .../broadcom/brcm80211/brcmsmac/debug.c       |   2 +-
 drivers/net/wireless/intel/iwlegacy/3945-rs.c |   9 +-
 drivers/net/wireless/intel/iwlegacy/4965-rs.c |  39 +-
 drivers/net/wireless/intel/iwlegacy/debug.c   | 280 +++++-----
 .../net/wireless/intel/iwlwifi/dvm/debugfs.c  | 455 ++++++++--------
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c   |  42 +-
 .../net/wireless/intel/iwlwifi/fw/debugfs.c   |  23 +-
 drivers/net/wireless/intel/iwlwifi/mei/main.c |  18 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |   7 +-
 .../wireless/intel/iwlwifi/mvm/debugfs-vif.c  |  81 ++-
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  | 227 ++++----
 .../net/wireless/intel/iwlwifi/mvm/debugfs.h  |   9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   |  62 ++-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  85 ++-
 .../net/wireless/marvell/libertas/debugfs.c   | 242 ++++-----
 .../net/wireless/marvell/mwifiex/debugfs.c    | 183 +++----
 .../wireless/mediatek/mt76/mt7615/debugfs.c   |  20 +-
 .../wireless/mediatek/mt76/mt7915/debugfs.c   |  52 +-
 .../wireless/mediatek/mt76/mt7996/debugfs.c   |  33 +-
 .../net/wireless/ralink/rt2x00/rt2x00debug.c  | 122 ++---
 drivers/net/wireless/realtek/rtlwifi/debug.c  |   5 +-
 drivers/net/wireless/realtek/rtw88/debug.c    | 163 +++---
 drivers/net/wireless/realtek/rtw89/debug.c    | 155 +++---
 drivers/net/wireless/rsi/rsi_91x_debugfs.c    |  20 +-
 drivers/net/wireless/silabs/wfx/debug.c       |  34 +-
 drivers/net/wireless/st/cw1200/debug.c        |  10 +-
 drivers/net/wireless/ti/wl1251/debugfs.c      |  38 +-
 drivers/net/wireless/ti/wl18xx/debugfs.c      |  73 ++-
 drivers/net/wireless/ti/wlcore/debugfs.c      | 373 ++++++-------
 drivers/net/wireless/ti/wlcore/debugfs.h      |  37 +-
 drivers/net/wwan/iosm/iosm_ipc_trace.c        |  21 +-
 drivers/net/wwan/wwan_core.c                  |  26 +-
 drivers/net/wwan/wwan_hwsim.c                 |  42 +-
 drivers/net/xen-netback/xenbus.c              |  19 +-
 drivers/nfc/virtual_ncidev.c                  |  21 +-
 drivers/ntb/hw/amd/ntb_hw_amd.c               |  10 +-
 drivers/ntb/hw/idt/ntb_hw_idt.c               |  29 +-
 drivers/ntb/hw/intel/ntb_hw_gen1.c            |  21 +-
 drivers/ntb/hw/intel/ntb_hw_gen3.c            |   8 +-
 drivers/ntb/hw/intel/ntb_hw_gen3.h            |   3 +-
 drivers/ntb/hw/intel/ntb_hw_gen4.c            |   8 +-
 drivers/ntb/hw/intel/ntb_hw_gen4.h            |   5 +-
 drivers/ntb/ntb_transport.c                   |   9 +-
 drivers/ntb/test/ntb_perf.c                   |  49 +-
 drivers/ntb/test/ntb_tool.c                   | 307 +++++------
 drivers/nvme/host/fabrics.c                   |  12 +-
 drivers/opp/debugfs.c                         |   9 +-
 drivers/parisc/eisa_eeprom.c                  |  12 +-
 drivers/pci/hotplug/cpqphp_sysfs.c            |   9 +-
 drivers/pci/pcie/aer_inject.c                 |   9 +-
 drivers/pci/switch/switchtec.c                |  33 +-
 drivers/pci/vgaarb.c                          |  21 +-
 drivers/phy/mediatek/phy-mtk-tphy.c           |  28 +-
 drivers/pinctrl/pinmux.c                      |  10 +-
 drivers/platform/chrome/cros_ec_chardev.c     |  20 +-
 drivers/platform/chrome/cros_ec_debugfs.c     |  33 +-
 drivers/platform/chrome/wilco_ec/debugfs.c    |  19 +-
 drivers/platform/chrome/wilco_ec/event.c      |  18 +-
 drivers/platform/chrome/wilco_ec/telemetry.c  |  20 +-
 drivers/platform/goldfish/goldfish_pipe.c     |   6 +-
 drivers/platform/olpc/olpc-ec.c               |  15 +-
 .../surface/surface_aggregator_cdev.c         |   3 +-
 drivers/platform/surface/surface_dtx.c        |   3 +-
 drivers/platform/x86/amd/pmc/pmc.c            |  21 +-
 drivers/platform/x86/amd/pmf/tee-if.c         |  10 +-
 drivers/platform/x86/apple-gmux.c             |  25 +-
 drivers/platform/x86/asus-wmi.c               |   2 +-
 drivers/platform/x86/dell/dell-smbios-wmi.c   |  11 +-
 drivers/platform/x86/dell/dell-smo8800.c      |   3 +-
 drivers/platform/x86/intel/pmc/core.c         |  24 +-
 drivers/platform/x86/intel/pmc/core.h         |   4 +-
 .../platform/x86/intel/telemetry/debugfs.c    |  24 +-
 drivers/platform/x86/intel/tpmi.c             |  11 +-
 drivers/platform/x86/sony-laptop.c            |   3 +-
 drivers/rapidio/devices/rio_mport_cdev.c      |  14 +-
 drivers/ras/amd/fmpm.c                        |   2 +-
 drivers/ras/debugfs.c                         |   2 +-
 drivers/regulator/core.c                      |  12 +-
 drivers/remoteproc/remoteproc_cdev.c          |   9 +-
 drivers/remoteproc/remoteproc_debugfs.c       |  68 ++-
 drivers/rtc/dev.c                             |  20 +-
 drivers/rtc/rtc-m41t80.c                      |  18 +-
 drivers/s390/block/dasd.c                     |  34 +-
 drivers/s390/block/dasd_eer.c                 |  12 +-
 drivers/s390/block/dasd_int.h                 |   1 +
 drivers/s390/block/dasd_proc.c                |   2 +-
 drivers/s390/char/fs3270.c                    |   6 +-
 drivers/s390/char/hmcdrv_dev.c                |  12 +-
 drivers/s390/char/monreader.c                 |  16 +-
 drivers/s390/char/monwriter.c                 |  12 +-
 drivers/s390/char/tape_char.c                 |  10 +-
 drivers/s390/char/vmcp.c                      |  23 +-
 drivers/s390/char/vmlogrdr.c                  |  15 +-
 drivers/s390/char/vmur.c                      |   6 +-
 drivers/s390/char/zcore.c                     |  25 +-
 drivers/s390/cio/cio_inject.c                 |  11 +-
 drivers/s390/cio/qdio_debug.c                 |  12 +-
 drivers/s390/crypto/zcrypt_api.c              |  10 +-
 drivers/sbus/char/envctrl.c                   |  27 +-
 drivers/sbus/char/flash.c                     |  14 +-
 drivers/sbus/char/oradax.c                    |  37 +-
 drivers/scsi/bfa/bfad_debugfs.c               |  51 +-
 drivers/scsi/csiostor/csio_init.c             |  16 +-
 drivers/scsi/cxlflash/ocxl_hw.c               |  17 +-
 drivers/scsi/fnic/fnic_debugfs.c              |  82 ++-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c        | 105 ++--
 drivers/scsi/lpfc/lpfc_debugfs.c              | 427 +++++++--------
 drivers/scsi/megaraid/megaraid_sas_debugfs.c  |   9 +-
 drivers/scsi/mpt3sas/mpt3sas_debugfs.c        |  10 +-
 drivers/scsi/qedf/qedf_dbg.h                  |   6 +-
 drivers/scsi/qedf/qedf_debugfs.c              |  76 ++-
 drivers/scsi/qedi/qedi_dbg.h                  |   6 +-
 drivers/scsi/qedi/qedi_debugfs.c              |  20 +-
 drivers/scsi/qla2xxx/qla_dfs.c                |  12 +-
 drivers/scsi/scsi_debug.c                     |  26 +-
 drivers/scsi/sg.c                             |   6 +-
 drivers/scsi/snic/snic_debugfs.c              |  25 +-
 drivers/scsi/st.c                             |  10 +-
 drivers/soc/aspeed/aspeed-lpc-snoop.c         |   3 +-
 drivers/soc/fsl/dpaa2-console.c               |  15 +-
 drivers/soc/mediatek/mtk-svs.c                |  15 +-
 drivers/soc/qcom/cmd-db.c                     |   2 +-
 drivers/soc/qcom/qcom_aoss.c                  |  14 +-
 drivers/soc/qcom/rmtfs_mem.c                  |  38 +-
 drivers/soc/qcom/socinfo.c                    |   4 +-
 drivers/spi/spidev.c                          |  33 +-
 drivers/staging/axis-fifo/axis-fifo.c         |  35 +-
 drivers/staging/fieldbus/dev_core.c           |   6 +-
 drivers/staging/greybus/camera.c              |  22 +-
 drivers/staging/greybus/raw.c                 |   6 +-
 drivers/staging/media/av7110/av7110_av.c      |   6 +-
 drivers/staging/media/av7110/av7110_ca.c      |   6 +-
 drivers/staging/pi433/pi433_if.c              |  13 +-
 .../interface/vchiq_arm/vchiq_debugfs.c       |  16 +-
 drivers/staging/vme_user/vme_user.c           |   6 +-
 drivers/thunderbolt/debugfs.c                 |  19 +-
 drivers/tty/serial/pch_uart.c                 |   9 +-
 drivers/tty/vt/vc_screen.c                    |  32 +-
 drivers/ufs/core/ufs-debugfs.c                |  14 +-
 drivers/uio/uio.c                             |  22 +-
 drivers/usb/chipidea/debug.c                  |  13 +-
 drivers/usb/class/cdc-wdm.c                   |  18 +-
 drivers/usb/class/usblp.c                     |   6 +-
 drivers/usb/class/usbtmc.c                    |   6 +-
 drivers/usb/core/devices.c                    |   3 +-
 drivers/usb/core/devio.c                      |   3 +-
 drivers/usb/dwc2/debugfs.c                    |  12 +-
 drivers/usb/dwc3/debugfs.c                    |  48 +-
 drivers/usb/fotg210/fotg210-hcd.c             |  17 +-
 drivers/usb/gadget/function/f_fs.c            |   6 +-
 drivers/usb/gadget/function/f_hid.c           |  17 +-
 drivers/usb/gadget/function/f_printer.c       |  26 +-
 drivers/usb/gadget/legacy/inode.c             |   6 +-
 drivers/usb/gadget/udc/atmel_usba_udc.c       |  15 +-
 drivers/usb/gadget/udc/renesas_usb3.c         |  14 +-
 drivers/usb/host/ehci-dbg.c                   |  19 +-
 drivers/usb/host/ohci-dbg.c                   |  17 +-
 drivers/usb/host/uhci-debug.c                 |   9 +-
 drivers/usb/host/xhci-debugfs.c               |  28 +-
 drivers/usb/image/mdc800.c                    |  15 +-
 drivers/usb/misc/adutux.c                     |   6 +-
 drivers/usb/misc/chaoskey.c                   |  13 +-
 drivers/usb/misc/idmouse.c                    |  15 +-
 drivers/usb/misc/iowarrior.c                  |   6 +-
 drivers/usb/misc/ldusb.c                      |  24 +-
 drivers/usb/misc/legousbtower.c               |  26 +-
 drivers/usb/misc/sisusbvga/sisusbvga.c        |   6 +-
 drivers/usb/misc/usblcd.c                     |  20 +-
 drivers/usb/misc/yurex.c                      |  19 +-
 drivers/usb/mon/mon_bin.c                     |   3 +-
 drivers/usb/mon/mon_stat.c                    |   9 +-
 drivers/usb/mon/mon_text.c                    |   6 +-
 drivers/usb/mtu3/mtu3_debugfs.c               |  40 +-
 drivers/usb/musb/musb_debugfs.c               |  24 +-
 drivers/usb/usb-skeleton.c                    |  26 +-
 .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    |  31 +-
 drivers/vfio/pci/mlx5/main.c                  |   6 +-
 drivers/vfio/pci/pds/lm.c                     |  32 +-
 drivers/vfio/vfio_main.c                      |   6 +-
 drivers/video/fbdev/core/fb_chrdev.c          |   6 +-
 drivers/video/fbdev/pxa3xx-gcu.c              |  12 +-
 drivers/virt/fsl_hypervisor.c                 |  14 +-
 drivers/watchdog/acquirewdt.c                 |   8 +-
 drivers/watchdog/advantechwdt.c               |   8 +-
 drivers/watchdog/alim1535_wdt.c               |   8 +-
 drivers/watchdog/alim7101_wdt.c               |   8 +-
 drivers/watchdog/at91rm9200_wdt.c             |   7 +-
 drivers/watchdog/ath79_wdt.c                  |   9 +-
 drivers/watchdog/cpu5wdt.c                    |   6 +-
 drivers/watchdog/cpwd.c                       |  13 +-
 drivers/watchdog/eurotechwdt.c                |  14 +-
 drivers/watchdog/gef_wdt.c                    |   9 +-
 drivers/watchdog/geodewdt.c                   |   8 +-
 drivers/watchdog/ib700wdt.c                   |   8 +-
 drivers/watchdog/ibmasr.c                     |   8 +-
 drivers/watchdog/indydog.c                    |   6 +-
 drivers/watchdog/it8712f_wdt.c                |   8 +-
 drivers/watchdog/m54xx_wdt.c                  |   9 +-
 drivers/watchdog/machzwd.c                    |   8 +-
 drivers/watchdog/mei_wdt.c                    |  18 +-
 drivers/watchdog/mixcomwd.c                   |   9 +-
 drivers/watchdog/mtx-1_wdt.c                  |   6 +-
 drivers/watchdog/nv_tco.c                     |   8 +-
 drivers/watchdog/pc87413_wdt.c                |  14 +-
 drivers/watchdog/pcwd.c                       |  15 +-
 drivers/watchdog/pcwd_pci.c                   |  15 +-
 drivers/watchdog/pcwd_usb.c                   |  16 +-
 drivers/watchdog/pika_wdt.c                   |   9 +-
 drivers/watchdog/rc32434_wdt.c                |   8 +-
 drivers/watchdog/rdc321x_wdt.c                |   6 +-
 drivers/watchdog/riowd.c                      |   6 +-
 drivers/watchdog/sa1100_wdt.c                 |   6 +-
 drivers/watchdog/sb_wdog.c                    |   8 +-
 drivers/watchdog/sbc60xxwdt.c                 |   8 +-
 drivers/watchdog/sbc7240_wdt.c                |   8 +-
 drivers/watchdog/sbc8360.c                    |   9 +-
 drivers/watchdog/sbc_epx_c3.c                 |   6 +-
 drivers/watchdog/sbc_fitpc2_wdt.c             |   9 +-
 drivers/watchdog/sc1200wdt.c                  |   9 +-
 drivers/watchdog/sc520_wdt.c                  |   8 +-
 drivers/watchdog/sch311x_wdt.c                |   8 +-
 drivers/watchdog/scx200_wdt.c                 |   9 +-
 drivers/watchdog/smsc37b787_wdt.c             |   8 +-
 drivers/watchdog/w83877f_wdt.c                |   8 +-
 drivers/watchdog/w83977f_wdt.c                |   8 +-
 drivers/watchdog/wafer5823wdt.c               |   8 +-
 drivers/watchdog/watchdog_dev.c               |  10 +-
 drivers/watchdog/wdrtas.c                     |  21 +-
 drivers/watchdog/wdt.c                        |  28 +-
 drivers/watchdog/wdt285.c                     |   7 +-
 drivers/watchdog/wdt977.c                     |   9 +-
 drivers/watchdog/wdt_pci.c                    |  21 +-
 drivers/xen/evtchn.c                          |  25 +-
 drivers/xen/mcelog.c                          |  17 +-
 drivers/xen/xenbus/xenbus_dev_frontend.c      |  24 +-
 drivers/xen/xenfs/super.c                     |   7 +-
 drivers/xen/xenfs/xenstored.c                 |  11 +-
 drivers/xen/xenfs/xensyms.c                   |   2 +-
 fs/9p/vfs_dir.c                               |   4 +-
 fs/adfs/dir.c                                 |   2 +-
 fs/affs/dir.c                                 |   2 +-
 fs/autofs/root.c                              |   4 +-
 fs/bcachefs/chardev.c                         |  10 +-
 fs/bcachefs/debug.c                           |  24 +-
 fs/bcachefs/fs.c                              |   2 +-
 fs/bcachefs/thread_with_file.c                |  14 +-
 fs/befs/linuxvfs.c                            |   2 +-
 fs/bfs/dir.c                                  |   2 +-
 fs/binfmt_misc.c                              |  27 +-
 fs/btrfs/inode.c                              |   2 +-
 fs/cachefiles/daemon.c                        |  35 +-
 fs/cachefiles/internal.h                      |   4 +-
 fs/cachefiles/ondemand.c                      |   5 +-
 fs/ceph/dir.c                                 |  15 +-
 fs/coda/dir.c                                 |   2 +-
 fs/coda/psdev.c                               |  17 +-
 fs/configfs/dir.c                             |   2 +-
 fs/cramfs/inode.c                             |   2 +-
 fs/debugfs/file.c                             | 160 +++---
 fs/dlm/debug_fs.c                             |  51 +-
 fs/dlm/plock.c                                |  16 +-
 fs/dlm/user.c                                 |  17 +-
 fs/ecryptfs/file.c                            |   2 +-
 fs/ecryptfs/miscdev.c                         |  24 +-
 fs/efivarfs/file.c                            |  31 +-
 fs/efs/dir.c                                  |   2 +-
 fs/erofs/dir.c                                |   2 +-
 fs/eventfd.c                                  |  12 +-
 fs/exfat/dir.c                                |   2 +-
 fs/ext2/dir.c                                 |   2 +-
 fs/ext4/dir.c                                 |   2 +-
 fs/f2fs/dir.c                                 |   2 +-
 fs/fat/dir.c                                  |   2 +-
 fs/file_table.c                               |   4 +-
 fs/freevxfs/vxfs_lookup.c                     |   2 +-
 fs/fsopen.c                                   |  11 +-
 fs/fuse/control.c                             |  86 ++-
 fs/fuse/dir.c                                 |   2 +-
 fs/gfs2/glock.c                               |   6 +-
 fs/hfs/dir.c                                  |   2 +-
 fs/hfsplus/dir.c                              |   2 +-
 fs/hostfs/hostfs_kern.c                       |   2 +-
 fs/hpfs/dir.c                                 |   2 +-
 fs/isofs/dir.c                                |   2 +-
 fs/jffs2/dir.c                                |   2 +-
 fs/jfs/namei.c                                |   2 +-
 fs/kernfs/dir.c                               |   2 +-
 fs/libfs.c                                    | 127 ++++-
 fs/minix/dir.c                                |   2 +-
 fs/nfs/dir.c                                  |   2 +-
 fs/nfsd/nfs4state.c                           |   5 +-
 fs/nfsd/nfsctl.c                              |  10 +-
 fs/nilfs2/dir.c                               |   2 +-
 fs/notify/fanotify/fanotify_user.c            |   6 +-
 fs/notify/inotify/inotify_user.c              |   3 +-
 fs/ntfs3/dir.c                                |   2 +-
 fs/ocfs2/cluster/heartbeat.c                  |  15 +-
 fs/ocfs2/cluster/netdebug.c                   |  17 +-
 fs/ocfs2/dlm/dlmdebug.c                       |  18 +-
 fs/ocfs2/dlmfs/dlmfs.c                        |  38 +-
 fs/ocfs2/dlmglue.c                            |   2 +-
 fs/ocfs2/file.c                               |   4 +-
 fs/ocfs2/stack_user.c                         |   6 +-
 fs/ocfs2/super.c                              |  15 +-
 fs/omfs/dir.c                                 |   2 +-
 fs/open.c                                     |   4 +-
 fs/openpromfs/inode.c                         |   4 +-
 fs/orangefs/devorangefs-req.c                 |  23 +-
 fs/orangefs/dir.c                             |   2 +-
 fs/orangefs/orangefs-debugfs.c                |  42 +-
 fs/overlayfs/readdir.c                        |   2 +-
 fs/proc/array.c                               |   2 +-
 fs/proc/base.c                                | 328 ++++++------
 fs/proc/fd.c                                  |   6 +-
 fs/proc/generic.c                             |   2 +-
 fs/proc/inode.c                               |  18 +-
 fs/proc/namespaces.c                          |   2 +-
 fs/proc/proc_net.c                            |   2 +-
 fs/proc/proc_sysctl.c                         |   2 +-
 fs/proc/root.c                                |   2 +-
 fs/proc/task_mmu.c                            |  37 +-
 fs/proc/task_nommu.c                          |   2 +-
 fs/pstore/ftrace.c                            |  16 +-
 fs/pstore/inode.c                             |  13 +-
 fs/pstore/pmsg.c                              |   3 +-
 fs/qnx4/dir.c                                 |   2 +-
 fs/qnx6/dir.c                                 |   2 +-
 fs/read_write.c                               |  74 ++-
 fs/reiserfs/dir.c                             |   2 +-
 fs/romfs/super.c                              |   2 +-
 fs/smb/client/cifsfs.c                        |   2 +-
 fs/squashfs/dir.c                             |   2 +-
 fs/sysv/dir.c                                 |   2 +-
 fs/tracefs/event_inode.c                      |   2 +-
 fs/tracefs/inode.c                            |  12 +-
 fs/ubifs/debug.c                              |  57 +-
 fs/ubifs/dir.c                                |   2 +-
 fs/udf/dir.c                                  |   2 +-
 fs/ufs/dir.c                                  |   2 +-
 fs/vboxsf/dir.c                               |   2 +-
 fs/xfs/scrub/stats.c                          |  27 +-
 fs/xfs/xfs_file.c                             |   2 +-
 fs/zonefs/super.c                             |   2 +-
 include/drm/drm_accel.h                       |   2 +-
 include/drm/drm_file.h                        |   3 +-
 include/drm/drm_gem.h                         |   2 +-
 include/drm/drm_gem_dma_helper.h              |   2 +-
 include/linux/debugfs.h                       |  55 +-
 include/linux/fs.h                            |  48 +-
 include/linux/ftrace.h                        |  11 +-
 include/linux/kstrtox.h                       |  33 +-
 include/linux/nsc_gpio.h                      |   8 +-
 include/linux/seq_file.h                      |   8 +-
 include/linux/string.h                        |   4 +
 include/linux/string_helpers.h                |   3 +-
 include/linux/uio.h                           |   3 +
 include/linux/user_namespace.h                |  10 +-
 include/misc/cxl.h                            |   3 +-
 include/net/cfg80211.h                        |  24 +-
 io_uring/rw.c                                 |  70 ---
 ipc/mqueue.c                                  |  10 +-
 kernel/bpf/bpf_iter.c                         |  14 +-
 kernel/bpf/inode.c                            |   2 +-
 kernel/bpf/syscall.c                          |  18 +-
 kernel/dma/debug.c                            |  15 +-
 kernel/events/core.c                          |   3 +-
 kernel/fail_function.c                        |  10 +-
 kernel/gcov/fs.c                              |  23 +-
 kernel/irq/debugfs.c                          |  12 +-
 kernel/kcsan/debugfs.c                        |  10 +-
 kernel/kprobes.c                              |  15 +-
 kernel/locking/lock_events.c                  |  18 +-
 kernel/locking/lock_events.h                  |   4 +-
 kernel/locking/qspinlock_stat.h               |   7 +-
 kernel/module/stats.c                         |   8 +-
 kernel/module/tracking.c                      |   2 +-
 kernel/power/qos.c                            |  21 +-
 kernel/power/user.c                           |  28 +-
 kernel/printk/printk.c                        |  12 +-
 kernel/relay.c                                |  20 +-
 kernel/sched/debug.c                          |  53 +-
 kernel/time/posix-clock.c                     |   3 +-
 kernel/time/test_udelay.c                     |  10 +-
 kernel/trace/blktrace.c                       |  19 +-
 kernel/trace/ftrace.c                         |  68 ++-
 kernel/trace/rv/rv.c                          |  58 +-
 kernel/trace/rv/rv_reactors.c                 |  32 +-
 kernel/trace/trace.c                          | 386 ++++++--------
 kernel/trace/trace_dynevent.c                 |   5 +-
 kernel/trace/trace_events.c                   | 116 ++--
 kernel/trace/trace_events_hist.c              |   4 +-
 kernel/trace/trace_events_inject.c            |  19 +-
 kernel/trace/trace_events_synth.c             |   5 +-
 kernel/trace/trace_events_trigger.c           |  22 +-
 kernel/trace/trace_events_user.c              |  17 +-
 kernel/trace/trace_functions_graph.c          |  20 +-
 kernel/trace/trace_hwlat.c                    |  20 +-
 kernel/trace/trace_kprobe.c                   |   7 +-
 kernel/trace/trace_osnoise.c                  |  42 +-
 kernel/trace/trace_printk.c                   |   2 +-
 kernel/trace/trace_recursion_record.c         |  10 +-
 kernel/trace/trace_sched_switch.c             |  21 +-
 kernel/trace/trace_stack.c                    |  27 +-
 kernel/trace/trace_stat.c                     |   2 +-
 kernel/trace/trace_uprobe.c                   |   7 +-
 kernel/user_namespace.c                       |  39 +-
 lib/dynamic_debug.c                           |   5 +-
 lib/kstrtox.c                                 |  46 +-
 lib/kunit/debugfs.c                           |  13 +-
 lib/string_helpers.c                          |  14 +-
 lib/test_firmware.c                           |  10 +-
 lib/xz/xz_dec_test.c                          |   9 +-
 mm/damon/dbgfs.c                              |  84 +--
 mm/huge_memory.c                              |  10 +-
 mm/kmemleak.c                                 |   5 +-
 mm/page_owner.c                               |   5 +-
 mm/shrinker_debug.c                           |  12 +-
 mm/slub.c                                     |   2 +-
 mm/util.c                                     |  57 ++
 mm/vmscan.c                                   |  14 +-
 net/6lowpan/debugfs.c                         |  14 +-
 net/bluetooth/6lowpan.c                       |  12 +-
 net/bluetooth/hci_debugfs.c                   | 150 +++---
 net/bluetooth/selftest.c                      |   9 +-
 net/bluetooth/smp.c                           |   9 +-
 net/core/datagram.c                           |  10 +-
 net/l2tp/l2tp_debugfs.c                       |   2 +-
 net/mac80211/debugfs.c                        | 185 +++----
 net/mac80211/debugfs.h                        |   4 +-
 net/mac80211/debugfs_key.c                    |  81 ++-
 net/mac80211/debugfs_netdev.c                 | 126 ++---
 net/mac80211/debugfs_sta.c                    | 146 +++--
 net/mac80211/rate.c                           |  10 +-
 net/mac80211/rc80211_minstrel_ht_debugfs.c    |  11 +-
 net/rfkill/core.c                             |  22 +-
 net/sunrpc/cache.c                            |  14 +-
 net/sunrpc/debugfs.c                          |   4 +-
 net/sunrpc/rpc_pipe.c                         |   8 +-
 net/wireless/debugfs.c                        |  57 +-
 samples/vfio-mdev/mtty.c                      |  30 +-
 security/apparmor/apparmorfs.c                |  55 +-
 security/inode.c                              |   9 +-
 security/integrity/evm/evm_secfs.c            |  60 +--
 security/integrity/ima/ima_fs.c               |  41 +-
 security/landlock/syscalls.c                  |  15 +-
 security/lockdown/lockdown.c                  |  10 +-
 security/safesetid/securityfs.c               |  14 +-
 security/selinux/selinuxfs.c                  | 168 +++---
 security/smack/smackfs.c                      | 281 +++++-----
 security/tomoyo/securityfs_if.c               |  21 +-
 sound/core/compress_offload.c                 |   7 +-
 sound/core/control.c                          |  14 +-
 sound/core/hwdep.c                            |   6 +-
 sound/core/init.c                             |  10 +-
 sound/core/jack.c                             |  83 ++-
 sound/core/oss/pcm_oss.c                      |   6 +-
 sound/core/pcm_native.c                       |  22 +-
 sound/core/rawmidi.c                          |   6 +-
 sound/core/seq/oss/seq_oss.c                  |  11 +-
 sound/core/seq/seq_clientmgr.c                |   8 +-
 sound/core/timer.c                            |  23 +-
 sound/drivers/pcmtest.c                       |  36 +-
 sound/oss/dmasound/dmasound_core.c            |   8 +-
 sound/soc/fsl/imx-audmux.c                    |  11 +-
 sound/soc/intel/avs/debugfs.c                 |  69 +--
 sound/soc/intel/avs/pcm.c                     |   9 +-
 sound/soc/intel/skylake/skl-debug.c           |  19 +-
 sound/soc/soc-dapm.c                          |  21 +-
 sound/soc/soc-pcm.c                           |  10 +-
 sound/soc/sof/debug.c                         |  34 +-
 sound/soc/sof/ipc3-dtrace.c                   |  17 +-
 sound/soc/sof/ipc4-mtrace.c                   |  17 +-
 sound/soc/sof/ipc4-telemetry.c                |  14 +-
 sound/soc/sof/sof-client-ipc-flood-test.c     |  19 +-
 .../soc/sof/sof-client-ipc-kernel-injector.c  |  15 +-
 sound/soc/sof/sof-client-ipc-msg-injector.c   |  67 ++-
 sound/soc/sof/sof-client-probes.c             |  31 +-
 virt/kvm/kvm_main.c                           |  10 +-
 859 files changed, 11379 insertions(+), 12492 deletions(-)

-- 
Jens Axboe


