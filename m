Return-Path: <linux-kernel+bounces-46632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 347BD844239
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA728290D71
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D80284A42;
	Wed, 31 Jan 2024 14:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="C66FTSe2"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED46084A5C
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712618; cv=none; b=Oczs+/QbArJcbp/IbB4LZNM2F1tNJRx5DpwY2PoVS+8HpF6HyRDisvaPMMQWEUZM2NZdgqxN31N3myFHQT6rqHDduFbv5OUssIK7ytQ3EMRJ8awEn58r9S3a5AIuiuOriOa7U+qPgfc7vAdW+UlPNQW/e+IEWkut1vm7Pz7a8Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712618; c=relaxed/simple;
	bh=axvygkeNoFzRgiAe5RJL/4CRQBhbEC2O8vIltjrl0aA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KpRoEf8yu4chbnlCykNyWXS4Ih5rbnlY23LIeamfhXf/NlS8zjHk4aHAdlVltDHDTT7rUc5vWb96dUBPzVDAHHLB6wR//QOwSbBDsmIOopxadPuVxnKsM/KLFPiTXegM9LY0d8+4GjpZ8uIvOLP5oWGyeJUEKOE2Zhm6sCC4/aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=C66FTSe2; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40fb3e278adso6671335e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 06:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1706712612; x=1707317412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=48KPIXptxM68MPxsN0/CGFEEBwNXg3USIrwbAQKCu5U=;
        b=C66FTSe2U8rF8FvnaqSoq+2W84NoybbjSoaBWhabURFCDHKa0xdHNEcZCyHFm4yN0B
         0MF10ovwbxtKDtPfjVIefR4o6mEPp0KHzUydl4YkNAzQWJfib/WYi9aYbfkTar+/uoNo
         haGod9GdnjTFnk11cg8YIWNdJGBeUIZAd+7b3ELpu5PqBudl3Y0PwuRDjORQaS7/JefR
         ZPwPvKugU4JNYutSOjvgEZmTNIwE6Qrjzgjme1MquUs+hkanjGWT945EYcu+Rpf5PKgH
         z61ovJzJObtd6tUrif7v4ReI/y/3mP+z35H0d2LdUBYBlbvUHNEo23a2EjLDo/gp3/bO
         pDXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706712612; x=1707317412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=48KPIXptxM68MPxsN0/CGFEEBwNXg3USIrwbAQKCu5U=;
        b=gkb4B8Bp1aAur+lAnFYbGPg5IyzEEL99LyZakaD1PUXzeiojueZE35gxhL2Hj5i55x
         JhLHDXLsKUXMWh4KGzSHa/PR/eEFJURqlg+fQVo+0sBIhSVe9G9RGYYspBJ1VJpif1gT
         xvNYFawlqNkyqWmM1BE7seGSWxhTjZItwrDIcnTq7Pf2xRxhxQNQR44c7W50iVwuoovv
         wZAGBS7FVHme1PSNIkETT6abB/+tJ7yHF7g2TLdAP5zrudb8xqGv2FOmSSnOz8hz0C+a
         PRbAueaqlwsU6MPBc7vBaJIvETTk/uzXzt25IJ5Q4eglOT++RBc7aQ3mZT2sQPLzDs97
         KW5w==
X-Gm-Message-State: AOJu0Yxo2qq1j0fhlpdqKbs/Oa0/r1JXyEl4FDnd643prw9i0tuKsWFx
	aOHjWCYX8BlwpuH9fCak7PBQC9fKNSampOuGnteO1KH3aMqTTqHx2sDOg5S6iZM6SwdykPsYNXQ
	H
X-Google-Smtp-Source: AGHT+IFb7duop1rIkUmBcVs3QEpStcnSG+pI0JHKnbxzueHHrRq1Fq9sQZAC+q83rJo2fsJ82QUqXg==
X-Received: by 2002:a5d:5f83:0:b0:337:bcec:d468 with SMTP id dr3-20020a5d5f83000000b00337bcecd468mr1631780wrb.36.1706712611088;
        Wed, 31 Jan 2024 06:50:11 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f2f5c00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f2f:5c00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ch15-20020a5d5d0f000000b0033905a60689sm13850173wrb.45.2024.01.31.06.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 06:50:10 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 00/28] Fast kernel headers: reduce header dependencies
Date: Wed, 31 Jan 2024 15:49:40 +0100
Message-Id: <20240131145008.1345531-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set aims to reduce the dependencies between headers, in
order to have cleaner code and speed up the build.  It continues
previous efforts by other developers.

As a preparation, the first patch adds "#include" directives to source
files that were missing previously, but due to indirect includes, this
was never noticed.  After the cleanup, many missing directives would
result in a compiler failure.

The second patch removes superfluous "#include" directives, some of
which may be a leftover from refactoring patches.

The third patch replaces existing "#include" directives with narrower
ones, e.g. use "spinlock_types.h" instead of "spinlock.h".  This
continues the work others have done over the years.

The remaining patches add new "XXX_types.h" headers with lighter
dependencies.  They have only basic struct/enum/const/macro
definitions and maybe a few trivial inline functions, but no "extern"
functions and no complex header dependencies.

Just like the other attempts to reduce header dependencies in the
past, this is just the beginning.  There are still too many
dependencies, and the speedup gained by this large patch set is not
yet impressive.

Prior to this patch set:

 real	0m34.677s
 user	23m13.045s
 sys	2m26.007s

With this patch set:

 real	0m34.120s
 user	22m45.595s
 sys	2m21.611s

(Building the directories kernel,lib,mm on ARM64 "allyesconfig".)

I have tested this patch set with arm64 and amd64.  Pretty sure, other
architectures may fail to build, but before I test all of them, I'd
like to get some feedback on wheter my approach would be accepted.

For more gains, huge headers like "linux/mm.h", "linux/fs.h" and
"linux/sched.h" would need to be optimized.  Nearly everybody includes
them, and they include nearly everything.

Max Kellermann (28):
  include: add missing includes
  include: remove unnecessary #include directives
  include: reduce header dependencies by using "*_types.h"
  workqueue.h: move struct delayed_work to workqueue_types.h
  kref.h: move declarations to kref_types.h
  kobject.h: move declarations to kobject_types.h
  sysfs.h: move declarations to sysfs_types.h
  maple_tree.h: move declarations to maple_tree_types.h
  rwsem.h: move declarations to rwsem_types.h
  uprobes.h: move declarations to uprobes_types.h
  percpu_counter.h: move declarations to percpu_counter_types.h
  bvec.h: move declarations to bvec_types.h
  wait.h: move declarations to wait_types.h
  swait.h: move declarations to swait_types.h
  completion.h: move declarations to completion_types.h
  device.h: move declarations to device_types.h
  xarray.h: move declarations to xarray_types.h
  blkdev.h: move blk_op_is_passthrough() to blk_types.h
  bio.h: move bio_has_data() and bio_no_advance_iter() to blk_types.h
  bio.h: move declarations to bio_types.h
  percpu-refcount.h: move declarations to percpu-refcount_types.h
  blkdev.h: move declarations to blkdev_types.h
  sbitmap.h: move declarations to sbitmap_types.h
  list_lru.h: move declarations to list_lru_types.h
  list_bl.h: move declarations to list_bl_types.h
  percpu-rwsem.h: move declarations to percpu-rwsem_types.h
  quota.h: move declarations to quota_types.h
  radix-tree.h: move declarations to radix-tree_types.h

 arch/arm64/kernel/cpufeature.c                |   1 +
 arch/arm64/kernel/cpuinfo.c                   |   2 +
 arch/arm64/kernel/ftrace.c                    |   1 +
 arch/arm64/kernel/mte.c                       |   2 +
 arch/arm64/kernel/signal.c                    |   1 +
 arch/arm64/kvm/arch_timer.c                   |   2 +
 arch/arm64/kvm/hypercalls.c                   |   1 +
 arch/arm64/kvm/vgic/vgic-mmio-v3.c            |   1 +
 arch/arm64/kvm/vgic/vgic-mmio.c               |   1 +
 arch/arm64/kvm/vgic/vgic-v2.c                 |   1 +
 arch/arm64/kvm/vgic/vgic-v3.c                 |   1 +
 arch/arm64/kvm/vgic/vgic-v4.c                 |   1 +
 arch/arm64/kvm/vgic/vgic.h                    |   1 +
 arch/x86/events/amd/uncore.c                  |   1 +
 arch/x86/events/intel/uncore.c                |   1 +
 arch/x86/events/rapl.c                        |   1 +
 arch/x86/kernel/cpu/intel.c                   |   1 +
 arch/x86/kernel/cpu/umwait.c                  |   1 +
 arch/x86/kvm/vmx/nested.c                     |   1 +
 arch/x86/kvm/xen.c                            |   1 +
 arch/x86/platform/efi/runtime-map.c           |   1 +
 block/bdev.c                                  |   1 +
 block/bfq-iosched.c                           |   1 +
 block/blk-cgroup.c                            |   1 +
 block/blk-crypto-sysfs.c                      |   2 +
 block/blk-ia-ranges.c                         |   2 +
 block/blk-iocost.c                            |   1 +
 block/blk-mq-sched.c                          |   1 +
 block/blk-mq-sysfs.c                          |   1 +
 block/blk-mq.c                                |   1 +
 block/blk-mq.h                                |   1 +
 block/blk-sysfs.c                             |   1 +
 block/bsg-lib.c                               |   1 +
 block/bsg.c                                   |   1 +
 block/disk-events.c                           |   2 +
 block/early-lookup.c                          |   1 +
 block/elevator.c                              |   1 +
 block/elevator.h                              |   1 +
 block/genhd.c                                 |   1 +
 block/holder.c                                |   2 +
 block/kyber-iosched.c                         |   2 +
 block/mq-deadline.c                           |   2 +
 block/partitions/core.c                       |   2 +
 drivers/accel/ivpu/ivpu_pm.c                  |   1 +
 .../accessibility/speakup/speakup_acntpc.c    |   1 +
 .../accessibility/speakup/speakup_acntsa.c    |   2 +
 .../accessibility/speakup/speakup_apollo.c    |   1 +
 .../accessibility/speakup/speakup_audptr.c    |   2 +
 drivers/accessibility/speakup/speakup_bns.c   |   2 +
 .../accessibility/speakup/speakup_decext.c    |   1 +
 drivers/accessibility/speakup/speakup_decpc.c |   1 +
 .../accessibility/speakup/speakup_dectlk.c    |   1 +
 drivers/accessibility/speakup/speakup_dtlk.c  |   1 +
 drivers/accessibility/speakup/speakup_dummy.c |   2 +
 drivers/accessibility/speakup/speakup_keypc.c |   1 +
 drivers/accessibility/speakup/speakup_ltlk.c  |   2 +
 drivers/accessibility/speakup/speakup_soft.c  |   1 +
 .../accessibility/speakup/speakup_spkout.c    |   2 +
 drivers/accessibility/speakup/speakup_txprt.c |   2 +
 drivers/acpi/ac.c                             |   1 +
 drivers/acpi/acpi_fpdt.c                      |   1 +
 drivers/acpi/acpi_ipmi.c                      |   1 +
 drivers/acpi/bgrt.c                           |   1 +
 drivers/acpi/bus.c                            |   1 +
 drivers/acpi/container.c                      |   1 +
 drivers/acpi/device_sysfs.c                   |   1 +
 drivers/acpi/dock.c                           |   1 +
 drivers/acpi/ec.c                             |   1 +
 drivers/acpi/pfr_telemetry.c                  |   1 +
 drivers/acpi/sbs.c                            |   1 +
 drivers/acpi/sysfs.c                          |   1 +
 drivers/ata/libata-acpi.c                     |   1 +
 drivers/ata/libata-core.c                     |   1 +
 drivers/ata/pata_parport/pata_parport.c       |   1 +
 drivers/base/base.h                           |   5 +
 drivers/base/container.c                      |   1 +
 drivers/base/core.c                           |   1 +
 drivers/base/devcoredump.c                    |   1 +
 drivers/base/firmware_loader/builtin/main.c   |   1 +
 drivers/base/firmware_loader/fallback.c       |   1 +
 drivers/base/firmware_loader/sysfs.c          |   1 +
 drivers/base/soc.c                            |   1 +
 drivers/base/swnode.c                         |   1 +
 drivers/base/topology.c                       |   2 +
 drivers/base/transport_class.c                |   3 +
 drivers/block/drbd/drbd_nl.c                  |   1 +
 drivers/block/loop.c                          |   1 +
 drivers/block/nbd.c                           |   1 +
 drivers/block/null_blk/main.c                 |   1 +
 drivers/block/rnbd/rnbd-clt-sysfs.c           |   1 +
 drivers/block/rnbd/rnbd-clt.c                 |   1 +
 drivers/block/rnbd/rnbd-srv.c                 |   1 +
 drivers/block/ublk_drv.c                      |   1 +
 drivers/block/virtio_blk.c                    |   1 +
 drivers/block/xen-blkback/blkback.c           |   2 +
 drivers/block/zram/zcomp.c                    |   1 +
 drivers/bus/mhi/ep/main.c                     |   2 +
 drivers/bus/mhi/host/init.c                   |   1 +
 drivers/char/hw_random/core.c                 |   1 +
 drivers/char/hw_random/virtio-rng.c           |   1 +
 drivers/char/ipmi/ipmi_msghandler.c           |   2 +
 drivers/char/misc.c                           |   1 +
 drivers/char/ppdev.c                          |   1 +
 drivers/char/tpm/tpm-chip.c                   |   1 +
 drivers/char/virtio_console.c                 |   1 +
 drivers/char/xillybus/xillybus_class.c        |   1 +
 drivers/char/xillybus/xillyusb.c              |   1 +
 drivers/clk/clk.c                             |   1 +
 drivers/clk/qcom/clk-regmap-mux-div.h         |   1 +
 drivers/clk/qcom/gdsc.c                       |   1 +
 drivers/clk/samsung/clk-cpu.h                 |   2 +
 drivers/clk/sunxi-ng/ccu_common.h             |   1 +
 drivers/comedi/comedi_buf.c                   |   1 +
 drivers/comedi/comedi_fops.c                  |   2 +
 drivers/counter/counter-chrdev.c              |   1 +
 drivers/cpufreq/apple-soc-cpufreq.c           |   1 +
 drivers/cpufreq/cpufreq_governor.h            |   1 +
 drivers/cpufreq/freq_table.c                  |   1 +
 drivers/cxl/core/port.c                       |   1 +
 drivers/cxl/cxl.h                             |   4 +
 drivers/cxl/cxlmem.h                          |   1 +
 drivers/dax/bus.c                             |   2 +
 drivers/devfreq/devfreq-event.c               |   1 +
 drivers/devfreq/event/rockchip-dfi.c          |   1 +
 drivers/dma-buf/st-dma-fence.c                |   1 +
 drivers/dma/ioat/sysfs.c                      |   1 +
 drivers/dma/qcom/hidma_mgmt_sys.c             |   1 +
 drivers/eisa/eisa-bus.c                       |   1 +
 drivers/extcon/devres.c                       |   1 +
 drivers/extcon/extcon.h                       |   1 +
 drivers/firmware/arm_ffa/bus.c                |   2 +
 drivers/firmware/arm_scmi/bus.c               |   1 +
 drivers/firmware/dmi-id.c                     |   1 +
 drivers/firmware/dmi-sysfs.c                  |   1 +
 drivers/firmware/dmi_scan.c                   |   1 +
 drivers/firmware/edd.c                        |   1 +
 .../firmware/efi/libstub/efi-stub-helper.c    |   1 +
 drivers/firmware/google/gsmi.c                |   1 +
 drivers/firmware/memmap.c                     |   2 +
 drivers/firmware/qemu_fw_cfg.c                |   1 +
 drivers/fpga/dfl.c                            |   2 +
 drivers/gnss/core.c                           |   1 +
 drivers/gpio/gpio-tegra.c                     |   1 +
 drivers/gpio/gpio-tegra186.c                  |   1 +
 drivers/gpio/gpio-thunderx.c                  |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h        |   3 +
 .../arm/display/komeda/komeda_color_mgmt.c    |   2 +
 drivers/gpu/drm/drm_auth.c                    |   1 +
 drivers/gpu/drm/drm_connector.c               |   1 +
 drivers/gpu/drm/drm_drv.c                     |   1 +
 drivers/gpu/drm/i915/i915_perf.c              |   1 +
 drivers/gpu/drm/i915/i915_perf_types.h        |   1 +
 drivers/gpu/drm/i915/i915_scatterlist.h       |   1 +
 drivers/gpu/drm/mcde/mcde_clk_div.c           |   1 +
 drivers/gpu/drm/msm/msm_drv.h                 |   1 +
 drivers/gpu/drm/msm/msm_gem.h                 |   1 +
 drivers/gpu/drm/nouveau/dispnv50/disp.c       |   1 +
 drivers/gpu/drm/nouveau/nvkm/core/memory.c    |   2 +
 .../gpu/drm/nouveau/nvkm/engine/fifo/cgrp.c   |   1 +
 .../gpu/drm/nouveau/nvkm/engine/fifo/chid.c   |   2 +
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c |   1 +
 .../gpu/drm/renesas/rcar-du/rcar_du_encoder.c |   1 +
 .../drm/renesas/rcar-du/rcar_du_writeback.c   |   2 +
 drivers/gpu/drm/sun4i/sun4i_layer.c           |   2 +
 drivers/gpu/drm/sun4i/sun4i_tcon_dclk.c       |   1 +
 drivers/gpu/drm/tidss/tidss_encoder.c         |   1 +
 drivers/gpu/drm/tidss/tidss_plane.c           |   1 +
 drivers/gpu/drm/xe/xe_gpu_scheduler.c         |   2 +
 drivers/gpu/drm/xe/xe_guc_ct.h                |   2 +
 drivers/greybus/connection.c                  |   1 +
 drivers/greybus/core.c                        |   1 +
 drivers/greybus/operation.c                   |   1 +
 drivers/hid/hid-core.c                        |   2 +
 drivers/hid/hid-cougar.c                      |   1 +
 drivers/hid/hid-debug.c                       |   1 +
 drivers/hid/hid-logitech-dj.c                 |   1 +
 drivers/hid/hid-wiimote-core.c                |   1 +
 drivers/hid/intel-ish-hid/ishtp/bus.c         |   1 +
 drivers/hid/wacom_sys.c                       |   2 +
 drivers/hwmon/acpi_power_meter.c              |   1 +
 drivers/hwmon/coretemp.c                      |   1 +
 drivers/hwmon/nct6775-core.c                  |   1 +
 drivers/hwtracing/stm/core.c                  |   1 +
 drivers/iio/adc/ti-tsc2046.c                  |   1 +
 drivers/iio/buffer/industrialio-buffer-dma.c  |   1 +
 drivers/iio/industrialio-buffer.c             |   1 +
 drivers/infiniband/core/cache.c               |   1 +
 drivers/infiniband/core/cm.c                  |   1 +
 drivers/infiniband/core/counters.c            |   2 +
 drivers/infiniband/core/device.c              |   2 +
 drivers/infiniband/core/restrack.c            |   1 +
 drivers/infiniband/core/sysfs.c               |   1 +
 drivers/infiniband/hw/erdma/erdma_cm.c        |   1 +
 drivers/infiniband/hw/erdma/erdma_qp.c        |   2 +
 drivers/infiniband/hw/hfi1/rc.c               |   1 +
 drivers/infiniband/hw/mlx4/sysfs.c            |   1 +
 drivers/infiniband/hw/qedr/qedr_iw_cm.c       |   2 +
 drivers/infiniband/hw/qib/qib_file_ops.c      |   1 +
 drivers/infiniband/hw/usnic/usnic_ib_main.c   |   1 +
 drivers/infiniband/hw/usnic/usnic_ib_sysfs.c  |   1 +
 drivers/infiniband/sw/rdmavt/cq.c             |   1 +
 drivers/infiniband/sw/rdmavt/qp.c             |   1 +
 drivers/infiniband/sw/rxe/rxe_pool.h          |   2 +
 drivers/infiniband/sw/rxe/rxe_queue.c         |   1 +
 drivers/infiniband/sw/siw/siw.h               |   1 +
 drivers/infiniband/ulp/isert/ib_isert.c       |   1 +
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c  |   2 +
 drivers/infiniband/ulp/rtrs/rtrs-clt.c        |   1 +
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c  |   2 +
 drivers/infiniband/ulp/rtrs/rtrs-srv.c        |   1 +
 drivers/infiniband/ulp/rtrs/rtrs.c            |   1 +
 drivers/infiniband/ulp/srp/ib_srp.c           |   1 +
 drivers/infiniband/ulp/srpt/ib_srpt.c         |   1 +
 drivers/input/input.c                         |   1 +
 drivers/input/serio/serio.c                   |   1 +
 drivers/input/vivaldi-fmap.c                  |   1 +
 drivers/iommu/virtio-iommu.c                  |   1 +
 drivers/ipack/ipack.c                         |   1 +
 drivers/isdn/mISDN/core.c                     |   1 +
 drivers/leds/led-triggers.c                   |   1 +
 drivers/mailbox/mailbox.c                     |   1 +
 drivers/mcb/mcb-core.c                        |   1 +
 drivers/md/bcache/bset.c                      |   1 +
 drivers/md/bcache/sysfs.h                     |   2 +
 drivers/md/dm-verity-target.c                 |   1 +
 drivers/media/cec/core/cec-core.c             |   1 +
 drivers/media/cec/core/cec-pin.c              |   1 +
 drivers/media/dvb-core/dvb_ca_en50221.c       |   1 +
 drivers/media/dvb-core/dvb_frontend.c         |   1 +
 drivers/media/dvb-core/dvbdev.c               |   1 +
 drivers/media/mc/mc-devnode.c                 |   1 +
 drivers/media/pci/pt3/pt3.c                   |   1 +
 drivers/media/rc/rc-main.c                    |   1 +
 drivers/memory/tegra/tegra234.c               |   1 +
 drivers/memstick/core/memstick.c              |   1 +
 drivers/mfd/abx500-core.c                     |   1 +
 drivers/misc/cardreader/alcor_pci.c           |   1 +
 drivers/misc/dw-xdata-pcie.c                  |   1 +
 drivers/misc/genwqe/card_dev.c                |   1 +
 drivers/misc/lkdtm/heap.c                     |   1 +
 drivers/misc/mei/bus.c                        |   1 +
 drivers/misc/mei/client.c                     |   1 +
 drivers/misc/mei/debugfs.c                    |   1 +
 drivers/misc/mei/main.c                       |   1 +
 drivers/misc/pci_endpoint_test.c              |   1 +
 drivers/misc/ti-st/st_kim.c                   |   1 +
 drivers/misc/tifm_core.c                      |   1 +
 drivers/misc/vcpu_stall_detector.c            |   1 +
 drivers/misc/xilinx_sdfec.c                   |   1 +
 drivers/most/most_cdev.c                      |   1 +
 drivers/mtd/mtd_blkdevs.c                     |   2 +
 drivers/net/bonding/bond_main.c               |   1 +
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    |   1 +
 .../net/can/spi/mcp251xfd/mcp251xfd-ring.c    |   2 +
 drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c  |   1 +
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c |   1 +
 .../chelsio/inline_crypto/chtls/chtls.h       |   1 +
 .../chelsio/inline_crypto/chtls/chtls_cm.c    |   1 +
 .../ethernet/chelsio/libcxgb/libcxgb_ppm.c    |   1 +
 drivers/net/ethernet/cortina/gemini.c         |   1 +
 drivers/net/ethernet/freescale/fec_ptp.c      |   1 +
 drivers/net/ethernet/hisilicon/hip04_eth.c    |   1 +
 drivers/net/ethernet/intel/ice/ice_sriov.c    |   2 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   |   2 +
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c |   1 +
 .../ethernet/mellanox/mlx5/core/lib/devcom.c  |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/uar.c |   1 +
 .../netronome/nfp/nfpcore/nfp_cppcore.c       |   1 +
 drivers/net/ethernet/qlogic/qede/qede_rdma.c  |   1 +
 .../ethernet/qlogic/qlcnic/qlcnic_minidump.c  |   2 +
 .../ethernet/qualcomm/rmnet/rmnet_map_data.c  |   1 +
 drivers/net/ethernet/ti/am65-cpsw-nuss.c      |   1 +
 drivers/net/mdio/mdio-mux-meson-gxl.c         |   1 +
 drivers/net/mdio/mdio-mux-multiplexer.c       |   1 +
 drivers/net/pse-pd/pse_core.c                 |   1 +
 drivers/net/wireless/ath/carl9170/tx.c        |   1 +
 drivers/net/wireless/ath/wil6210/interrupt.c  |   1 +
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |   1 +
 .../wireless/mediatek/mt76/mt76x02_usb_core.c |   2 +
 drivers/net/wireless/virtual/mac80211_hwsim.c |   1 +
 drivers/net/wwan/iosm/iosm_ipc_imem.c         |   1 +
 drivers/net/xen-netback/xenbus.c              |   1 +
 drivers/nvdimm/bus.c                          |   1 +
 drivers/nvdimm/core.c                         |   1 +
 drivers/nvdimm/dimm.c                         |   1 +
 drivers/nvdimm/dimm_devs.c                    |   1 +
 drivers/nvme/host/core.c                      |   1 +
 drivers/nvme/host/fc.c                        |   1 +
 drivers/nvme/host/nvme.h                      |   1 +
 drivers/nvme/target/fc.c                      |   1 +
 drivers/nvme/target/nvmet.h                   |   1 +
 drivers/of/dynamic.c                          |   1 +
 drivers/of/kobj.c                             |   1 +
 drivers/of/of_numa.c                          |   1 +
 drivers/of/unittest.c                         |   1 +
 drivers/pci/controller/vmd.c                  |   1 +
 drivers/pci/host-bridge.c                     |   1 +
 drivers/pci/hotplug/acpiphp_glue.c            |   1 +
 drivers/pci/iov.c                             |   1 +
 drivers/pci/pci.c                             |   1 +
 drivers/pci/slot.c                            |   1 +
 drivers/pci/switch/switchtec.c                |   2 +
 drivers/pcmcia/cs.c                           |   1 +
 drivers/pcmcia/ds.c                           |   1 +
 drivers/perf/thunderx2_pmu.c                  |   1 +
 drivers/platform/chrome/wilco_ec/telemetry.c  |   1 +
 drivers/platform/surface/aggregator/bus.c     |   1 +
 drivers/platform/x86/amd/pmf/tee-if.c         |   1 +
 .../dell/dell-wmi-sysman/biosattr-interface.c |   1 +
 .../dell/dell-wmi-sysman/enum-attributes.c    |   2 +
 .../x86/dell/dell-wmi-sysman/int-attributes.c |   2 +
 .../dell/dell-wmi-sysman/passobj-attributes.c |   3 +
 .../dell-wmi-sysman/passwordattr-interface.c  |   1 +
 .../dell/dell-wmi-sysman/string-attributes.c  |   2 +
 .../x86/dell/dell-wmi-sysman/sysman.c         |   1 +
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c  |   1 +
 .../x86/hp/hp-bioscfg/enum-attributes.c       |   3 +
 .../x86/hp/hp-bioscfg/int-attributes.c        |   3 +
 .../x86/hp/hp-bioscfg/order-list-attributes.c |   2 +
 .../x86/hp/hp-bioscfg/passwdobj-attributes.c  |   3 +
 .../x86/hp/hp-bioscfg/spmobj-attributes.c     |   2 +
 .../x86/hp/hp-bioscfg/string-attributes.c     |   3 +
 .../x86/hp/hp-bioscfg/surestart-attributes.c  |   2 +
 drivers/platform/x86/intel/pmt/telemetry.c    |   1 +
 .../uncore-frequency-common.c                 |   1 +
 .../uncore-frequency-common.h                 |   1 +
 drivers/platform/x86/think-lmi.c              |   1 +
 drivers/platform/x86/wmi.c                    |   1 +
 drivers/pmdomain/governor.c                   |   1 +
 drivers/power/reset/ltc2952-poweroff.c        |   1 +
 drivers/power/supply/power_supply_sysfs.c     |   1 +
 drivers/powercap/dtpm.c                       |   1 +
 drivers/pps/clients/pps-ktimer.c              |   1 +
 drivers/pps/clients/pps-ldisc.c               |   1 +
 drivers/pps/clients/pps_parport.c             |   1 +
 drivers/pps/kapi.c                            |   1 +
 drivers/pps/pps.c                             |   2 +
 drivers/rapidio/rio-driver.c                  |   1 +
 drivers/rpmsg/mtk_rpmsg.c                     |   1 +
 drivers/rpmsg/qcom_glink_native.c             |   1 +
 drivers/rpmsg/qcom_smd.c                      |   1 +
 drivers/rpmsg/virtio_rpmsg_bus.c              |   1 +
 drivers/rtc/class.c                           |   1 +
 drivers/rtc/interface.c                       |   1 +
 drivers/scsi/bnx2fc/bnx2fc_els.c              |   2 +
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c             |   1 +
 drivers/scsi/bnx2fc/bnx2fc_hwi.c              |   2 +
 drivers/scsi/bnx2fc/bnx2fc_io.c               |   2 +
 drivers/scsi/bnx2fc/bnx2fc_tgt.c              |   3 +
 drivers/scsi/ch.c                             |   1 +
 drivers/scsi/cxgbi/libcxgbi.h                 |   1 +
 drivers/scsi/device_handler/scsi_dh_alua.c    |   1 +
 drivers/scsi/device_handler/scsi_dh_rdac.c    |   1 +
 drivers/scsi/elx/efct/efct_hw.c               |   2 +
 drivers/scsi/elx/efct/efct_io.c               |   2 +
 drivers/scsi/elx/efct/efct_lio.c              |   2 +
 drivers/scsi/elx/efct/efct_scsi.c             |   2 +
 drivers/scsi/elx/efct/efct_unsol.c            |   2 +
 drivers/scsi/elx/libefc/efc_domain.c          |   2 +
 drivers/scsi/elx/libefc/efc_els.c             |   1 +
 drivers/scsi/elx/libefc/efc_node.c            |   2 +
 drivers/scsi/elx/libefc/efc_nport.c           |   2 +
 drivers/scsi/fcoe/fcoe_ctlr.c                 |   1 +
 drivers/scsi/hosts.c                          |   1 +
 drivers/scsi/ipr.c                            |   1 +
 drivers/scsi/isci/isci.h                      |   1 +
 drivers/scsi/iscsi_boot_sysfs.c               |   1 +
 drivers/scsi/libfc/fc_disc.c                  |   1 +
 drivers/scsi/libfc/fc_exch.c                  |   1 +
 drivers/scsi/libfc/fc_lport.c                 |   1 +
 drivers/scsi/libfc/fc_rport.c                 |   1 +
 drivers/scsi/libsas/sas_internal.h            |   1 +
 drivers/scsi/lpfc/lpfc_bsg.c                  |   1 +
 drivers/scsi/lpfc/lpfc_debugfs.c              |   1 +
 drivers/scsi/lpfc/lpfc_els.c                  |   1 +
 drivers/scsi/lpfc/lpfc_hbadisc.c              |   1 +
 drivers/scsi/lpfc/lpfc_init.c                 |   2 +
 drivers/scsi/lpfc/lpfc_nportdisc.c            |   1 +
 drivers/scsi/lpfc/lpfc_nvme.c                 |   1 +
 drivers/scsi/lpfc/lpfc_nvmet.c                |   1 +
 drivers/scsi/lpfc/lpfc_sli.c                  |   1 +
 drivers/scsi/mpi3mr/mpi3mr.h                  |   1 +
 drivers/scsi/mpt3sas/mpt3sas_base.h           |   1 +
 drivers/scsi/qedf/qedf_dbg.c                  |   1 +
 drivers/scsi/qedf/qedf_els.c                  |   2 +
 drivers/scsi/qedf/qedf_io.c                   |   1 +
 drivers/scsi/qedf/qedf_main.c                 |   1 +
 drivers/scsi/qla2xxx/qla_inline.h             |   3 +
 drivers/scsi/qla4xxx/ql4_isr.c                |   2 +
 drivers/scsi/qla4xxx/ql4_nx.c                 |   1 +
 drivers/scsi/qla4xxx/ql4_os.c                 |   1 +
 drivers/scsi/scsi_lib.c                       |   1 +
 drivers/scsi/scsi_scan.c                      |   1 +
 drivers/scsi/scsi_sysfs.c                     |   2 +
 drivers/scsi/ses.c                            |   1 +
 drivers/scsi/sg.c                             |   1 +
 drivers/slimbus/slimbus.h                     |   1 +
 drivers/soc/nuvoton/wpcm450-soc.c             |   1 +
 drivers/soc/qcom/smem_state.c                 |   1 +
 drivers/soundwire/bus.c                       |   1 +
 drivers/soundwire/intel_auxdevice.c           |   1 +
 drivers/spi/spi-stm32.c                       |   1 +
 drivers/staging/fbtft/fb_ssd1351.c            |   1 +
 drivers/staging/fieldbus/dev_core.c           |   1 +
 .../staging/greybus/audio_manager_module.c    |   1 +
 drivers/staging/greybus/authentication.c      |   1 +
 drivers/staging/greybus/fw-download.c         |   1 +
 drivers/staging/greybus/fw-management.c       |   1 +
 drivers/staging/greybus/gbphy.c               |   1 +
 .../interface/vchiq_arm/vchiq_bus.c           |   1 +
 drivers/target/iscsi/iscsi_target.c           |   1 +
 drivers/target/iscsi/iscsi_target_nego.c      |   1 +
 drivers/target/iscsi/iscsi_target_tpg.c       |   1 +
 drivers/target/target_core_alua.c             |   1 +
 drivers/target/target_core_device.c           |   1 +
 drivers/target/target_core_fabric_configfs.c  |   1 +
 drivers/target/target_core_file.c             |   1 +
 drivers/target/target_core_pr.c               |   2 +
 drivers/target/target_core_tmr.c              |   2 +
 drivers/target/target_core_tpg.c              |   1 +
 drivers/target/target_core_transport.c        |   1 +
 drivers/target/target_core_user.c             |   1 +
 drivers/target/target_core_xcopy.c            |   2 +
 drivers/tee/tee_core.c                        |   1 +
 drivers/thermal/devfreq_cooling.c             |   1 +
 drivers/thermal/intel/intel_powerclamp.c      |   1 +
 drivers/thermal/intel/therm_throt.c           |   1 +
 drivers/thunderbolt/domain.c                  |   1 +
 drivers/thunderbolt/switch.c                  |   1 +
 drivers/thunderbolt/tb.c                      |   1 +
 drivers/thunderbolt/xdomain.c                 |   1 +
 drivers/tty/rpmsg_tty.c                       |   1 +
 drivers/tty/serial/8250/8250_bcm7271.c        |   1 +
 drivers/tty/serial/8250/8250_port.c           |   1 +
 drivers/tty/serial/imx.c                      |   1 +
 drivers/tty/serial/serial_base.h              |   2 +
 drivers/tty/serial/sh-sci.c                   |   1 +
 drivers/tty/serial/xilinx_uartps.c            |   1 +
 drivers/tty/tty_io.c                          |   1 +
 drivers/usb/cdns3/cdnsp-mem.c                 |   1 +
 drivers/usb/chipidea/otg_fsm.c                |   1 +
 drivers/usb/core/config.c                     |   1 +
 drivers/usb/core/driver.c                     |   1 +
 drivers/usb/core/hcd.c                        |   1 +
 drivers/usb/core/hub.c                        |   1 +
 drivers/usb/core/message.c                    |   1 +
 drivers/usb/core/urb.c                        |   1 +
 drivers/usb/dwc2/hcd_queue.c                  |   1 +
 drivers/usb/gadget/function/f_fs.c            |   1 +
 drivers/usb/gadget/function/f_ncm.c           |   1 +
 drivers/usb/gadget/udc/core.c                 |   1 +
 drivers/usb/gadget/udc/max3420_udc.c          |   1 +
 drivers/usb/host/oxu210hp-hcd.c               |   1 +
 drivers/usb/misc/usblcd.c                     |   1 +
 drivers/usb/roles/class.c                     |   1 +
 drivers/usb/typec/bus.c                       |   1 +
 drivers/usb/typec/class.c                     |   1 +
 drivers/usb/typec/class.h                     |   1 +
 drivers/usb/typec/pd.c                        |   1 +
 drivers/vdpa/vdpa_user/vduse_dev.c            |   1 +
 drivers/vfio/container.c                      |   1 +
 drivers/vfio/group.c                          |   1 +
 drivers/vfio/mdev/mdev_core.c                 |   1 +
 drivers/vfio/mdev/mdev_sysfs.c                |   1 +
 drivers/vhost/scsi.c                          |   1 +
 .../fbdev/omap2/omapfb/dss/display-sysfs.c    |   1 +
 drivers/video/fbdev/omap2/omapfb/dss/dsi.c    |   1 +
 .../fbdev/omap2/omapfb/dss/manager-sysfs.c    |   1 +
 drivers/video/fbdev/omap2/omapfb/dss/pll.c    |   1 +
 drivers/video/fbdev/smscufx.c                 |   1 +
 drivers/virt/coco/tsm.c                       |   1 +
 drivers/virt/vmgenid.c                        |   1 +
 drivers/xen/xen-scsiback.c                    |   1 +
 drivers/xen/xenbus/xenbus_dev_frontend.c      |   1 +
 drivers/xen/xenbus/xenbus_probe_backend.c     |   1 +
 drivers/xen/xenbus/xenbus_probe_frontend.c    |   1 +
 fs/9p/v9fs.c                                  |   1 +
 fs/aio.c                                      |   1 +
 fs/bcachefs/chardev.c                         |   1 +
 fs/bcachefs/fs.c                              |   1 +
 fs/btrfs/qgroup.c                             |   1 +
 fs/btrfs/sysfs.c                              |   1 +
 fs/buffer.c                                   |   1 +
 fs/ceph/metric.h                              |   2 +
 fs/ceph/super.h                               |   1 +
 fs/configfs/item.c                            |   1 +
 fs/configfs/mount.c                           |   2 +
 fs/crypto/bio.c                               |   1 +
 fs/debugfs/inode.c                            |   1 +
 fs/ecryptfs/main.c                            |   1 +
 fs/erofs/data.c                               |   1 +
 fs/erofs/internal.h                           |   1 +
 fs/erofs/super.c                              |   1 +
 fs/eventpoll.c                                |   1 +
 fs/exec.c                                     |   1 +
 fs/ext4/super.c                               |   1 +
 fs/ext4/sysfs.c                               |   2 +
 fs/f2fs/f2fs.h                                |   1 +
 fs/fs_struct.c                                |   1 +
 fs/fuse/cuse.c                                |   1 +
 fs/fuse/inode.c                               |   1 +
 fs/gfs2/incore.h                              |   1 +
 fs/gfs2/recovery.c                            |   1 +
 fs/gfs2/sys.c                                 |   1 +
 fs/hfsplus/wrapper.c                          |   1 +
 fs/iomap/buffered-io.c                        |   1 +
 fs/iomap/direct-io.c                          |   1 +
 fs/namespace.c                                |   2 +
 fs/nfs/client.c                               |   1 +
 fs/nfs/nfs42xattr.c                           |   1 +
 fs/ntfs3/fsntfs.c                             |   3 +-
 fs/ntfs3/super.c                              |   1 +
 fs/pnode.c                                    |   1 +
 fs/proc/uptime.c                              |   1 +
 fs/pstore/inode.c                             |   1 +
 fs/reiserfs/reiserfs.h                        |   1 +
 fs/super.c                                    |   1 +
 fs/sysctls.c                                  |   1 +
 fs/sysfs/mount.c                              |   1 +
 fs/tracefs/inode.c                            |   1 +
 fs/ubifs/io.c                                 |   1 +
 fs/ubifs/super.c                              |   1 +
 fs/ubifs/sysfs.c                              |   1 +
 fs/xfs/xfs_error.c                            |   1 +
 fs/xfs/xfs_qm.h                               |   1 +
 fs/xfs/xfs_qm_syscalls.c                      |   2 +
 fs/xfs/xfs_quotaops.c                         |   1 +
 fs/xfs/xfs_super.c                            |   1 +
 fs/xfs/xfs_sysfs.c                            |   1 +
 fs/xfs/xfs_sysfs.h                            |   2 +
 fs/xfs/xfs_trans_dquot.c                      |   2 +
 fs/zonefs/sysfs.c                             |   1 +
 include/clocksource/samsung_pwm.h             |   2 +-
 include/crypto/algapi.h                       |   2 +-
 include/crypto/drbg.h                         |   3 +-
 include/crypto/if_alg.h                       |   1 -
 include/crypto/internal/geniv.h               |   2 +-
 include/drm/drm_atomic.h                      |   2 +
 include/drm/drm_audio_component.h             |   2 +-
 include/drm/drm_auth.h                        |   3 +-
 include/drm/drm_bridge.h                      |   2 +-
 include/drm/drm_client.h                      |   2 +-
 include/drm/drm_color_mgmt.h                  |   1 +
 include/drm/drm_crtc.h                        |   2 +-
 include/drm/drm_debugfs.h                     |   2 +
 include/drm/drm_device.h                      |   4 +-
 include/drm/drm_file.h                        |   2 +-
 include/drm/drm_flip_work.h                   |   4 +-
 include/drm/drm_framebuffer.h                 |   1 +
 include/drm/drm_gem.h                         |   2 +-
 include/drm/drm_gem_shmem_helper.h            |   1 -
 include/drm/drm_gpuvm.h                       |   2 +-
 include/drm/drm_managed.h                     |   2 +-
 include/drm/drm_mipi_dbi.h                    |   2 +-
 include/drm/drm_mm.h                          |   3 +-
 include/drm/drm_mode_config.h                 |   4 +-
 include/drm/drm_mode_object.h                 |   2 +-
 include/drm/drm_modeset_lock.h                |   1 +
 include/drm/drm_panel.h                       |   2 +-
 include/drm/drm_prime.h                       |   4 +-
 include/drm/drm_print.h                       |   2 +
 include/drm/drm_privacy_screen_driver.h       |   2 +-
 include/drm/drm_util.h                        |   1 -
 include/drm/drm_vblank.h                      |   2 +-
 include/drm/drm_vma_manager.h                 |   1 -
 include/drm/drm_writeback.h                   |   2 +-
 include/drm/gpu_scheduler.h                   |   7 +-
 include/drm/i915_hdcp_interface.h             |   2 +-
 include/drm/i915_pxp_tee_interface.h          |   2 +-
 include/drm/ttm/ttm_device.h                  |   1 -
 include/drm/ttm/ttm_pool.h                    |   2 +-
 include/drm/ttm/ttm_resource.h                |   1 -
 include/keys/asymmetric-subtype.h             |   1 +
 include/kunit/test.h                          |   3 +-
 include/kvm/arm_arch_timer.h                  |   2 +-
 include/kvm/arm_vgic.h                        |   6 +-
 include/linux/acpi.h                          |   4 +-
 include/linux/acpi_amd_wbrf.h                 |   7 +-
 include/linux/acpi_dma.h                      |   3 +-
 include/linux/agpgart.h                       |   2 +-
 include/linux/alarmtimer.h                    |   2 +-
 include/linux/async_tx.h                      |   1 -
 include/linux/atmdev.h                        |   2 -
 include/linux/backing-dev-defs.h              |  20 +-
 include/linux/backing-dev.h                   |   1 +
 include/linux/backlight.h                     |   2 +-
 include/linux/badblocks.h                     |   2 +-
 include/linux/balloon_compaction.h            |   2 +-
 include/linux/bcm47xx_wdt.h                   |   2 +-
 include/linux/bio.h                           |  97 +---
 include/linux/bio_types.h                     |  84 +++
 include/linux/blk-crypto.h                    |   2 +-
 include/linux/blk-integrity.h                 |   1 +
 include/linux/blk-mq.h                        |   5 +-
 include/linux/blk_types.h                     |  33 +-
 include/linux/blkdev.h                        | 468 +---------------
 include/linux/blkdev_types.h                  | 461 ++++++++++++++++
 include/linux/blktrace_api.h                  |   2 -
 include/linux/bpf-cgroup-defs.h               |   4 +-
 include/linux/bpf-cgroup.h                    |   2 +-
 include/linux/bpf-netns.h                     |   1 -
 include/linux/bpf.h                           |   7 +-
 include/linux/bpf_mem_alloc.h                 |   2 +-
 include/linux/bsg-lib.h                       |   2 +-
 include/linux/buffer_head.h                   |   2 +-
 include/linux/bvec.h                          |  84 +--
 include/linux/bvec_types.h                    |  95 ++++
 include/linux/cacheinfo.h                     |   1 -
 include/linux/can/dev.h                       |   1 +
 include/linux/capability.h                    |   2 +-
 include/linux/cb710.h                         |   2 +-
 include/linux/ccp.h                           |   2 +-
 include/linux/cdev.h                          |   4 +-
 include/linux/cdrom.h                         |   2 +-
 include/linux/ceph/libceph.h                  |   5 +-
 include/linux/ceph/messenger.h                |   7 +-
 include/linux/ceph/mon_client.h               |   4 +-
 include/linux/ceph/osd_client.h               |   8 +-
 include/linux/ceph/osdmap.h                   |   2 +-
 include/linux/ceph/pagelist.h                 |   2 +-
 include/linux/ceph/string_table.h             |   2 +-
 include/linux/cgroup-defs.h                   |  10 +-
 include/linux/cgroup.h                        |   2 +-
 include/linux/clk/zynq.h                      |   2 +-
 include/linux/clocksource.h                   |   1 -
 include/linux/comedi/comedidev.h              |   6 +-
 include/linux/completion.h                    |  18 +-
 include/linux/completion_types.h              |  31 ++
 include/linux/configfs.h                      |   4 +-
 include/linux/connector.h                     |   3 +-
 include/linux/console_struct.h                |   4 +-
 include/linux/container.h                     |   2 +-
 include/linux/coresight.h                     |   2 +-
 include/linux/counter.h                       |   6 +-
 include/linux/cpu_rmap.h                      |   4 +-
 include/linux/cpufreq.h                       |   6 +-
 include/linux/cpuidle.h                       |   1 -
 include/linux/cpuset.h                        |   2 +-
 include/linux/cred.h                          |   2 +-
 include/linux/crush/crush.h                   |   2 +-
 include/linux/crypto.h                        |   2 +-
 include/linux/damon.h                         |   2 +-
 include/linux/dax.h                           |   1 -
 include/linux/dcache.h                        |   4 +-
 include/linux/dccp.h                          |   1 -
 include/linux/debugfs.h                       |   1 +
 include/linux/debugobjects.h                  |   1 -
 include/linux/dev_printk.h                    |   3 +-
 include/linux/devfreq-event.h                 |   2 +-
 include/linux/devfreq.h                       |   2 +-
 include/linux/device-mapper.h                 |   1 -
 include/linux/device.h                        | 475 +----------------
 include/linux/device/bus.h                    |   4 +-
 include/linux/device/class.h                  |   4 +-
 include/linux/device/driver.h                 |   2 -
 include/linux/device_types.h                  | 500 ++++++++++++++++++
 include/linux/dim.h                           |   2 +-
 include/linux/dm-bufio.h                      |   2 +-
 include/linux/dma-buf.h                       |   2 +-
 include/linux/dma-fence.h                     |   1 -
 include/linux/dma-resv.h                      |   1 -
 include/linux/dmaengine.h                     |   4 +-
 include/linux/dmi.h                           |   1 -
 include/linux/dpll.h                          |   1 -
 include/linux/dtpm.h                          |   2 +
 include/linux/edac.h                          |   6 +-
 include/linux/enclosure.h                     |   2 +-
 include/linux/energy_model.h                  |   4 +-
 include/linux/eventfd.h                       |   2 +-
 include/linux/extcon.h                        |   8 +-
 include/linux/fault-inject.h                  |   2 +-
 include/linux/fb.h                            |   6 +-
 include/linux/fdtable.h                       |   2 +-
 include/linux/filter.h                        |   1 -
 include/linux/firewire.h                      |  11 +-
 include/linux/firmware.h                      |   3 +-
 include/linux/flex_proportions.h              |   9 +-
 include/linux/fpga/fpga-bridge.h              |   2 +-
 include/linux/fpga/fpga-mgr.h                 |   2 +-
 include/linux/fpga/fpga-region.h              |   2 +-
 include/linux/framer/framer-provider.h        |   1 +
 include/linux/framer/framer.h                 |   6 +-
 include/linux/freezer.h                       |   1 -
 include/linux/fs.h                            |  13 +-
 include/linux/fs_context.h                    |   4 +-
 include/linux/fs_struct.h                     |   2 +-
 include/linux/fsl/bestcomm/bestcomm_priv.h    |   2 +-
 include/linux/fsl/bestcomm/sram.h             |   2 +-
 include/linux/futex.h                         |   1 +
 include/linux/gameport.h                      |   2 +-
 include/linux/gfp_api.h                       |   2 +-
 include/linux/gnss.h                          |   6 +-
 include/linux/gpio/driver.h                   |   2 +-
 include/linux/greybus/connection.h            |   3 +-
 include/linux/greybus/operation.h             |   8 +-
 include/linux/hdmi.h                          |   2 +-
 include/linux/hid.h                           |   5 +-
 include/linux/hisi_acc_qm.h                   |   1 +
 include/linux/hp_sdc.h                        |   2 +-
 include/linux/hrtimer.h                       |   7 +-
 include/linux/hsi/hsi.h                       |   2 +-
 include/linux/hugetlb.h                       |   4 +-
 include/linux/hw_random.h                     |   4 +-
 include/linux/hwmon-sysfs.h                   |   2 +-
 include/linux/hyperv.h                        |   3 +-
 include/linux/i2c-smbus.h                     |   2 -
 include/linux/i2c.h                           |   2 +-
 include/linux/i3c/master.h                    |   5 +-
 include/linux/i8253.h                         |   2 +-
 include/linux/idr.h                           |   2 +-
 include/linux/if_eql.h                        |   4 +-
 include/linux/if_pppox.h                      |   2 +-
 include/linux/igmp.h                          |   4 +-
 include/linux/iio/buffer-dma.h                |   6 +-
 include/linux/iio/buffer.h                    |   2 +-
 include/linux/iio/buffer_impl.h               |   5 +-
 include/linux/iio/iio.h                       |   3 +-
 include/linux/inetdevice.h                    |   2 +-
 include/linux/init_task.h                     |   2 -
 include/linux/input.h                         |   2 +-
 include/linux/interconnect.h                  |   1 -
 include/linux/interrupt.h                     |   5 +-
 include/linux/interval_tree.h                 |   3 +-
 include/linux/io_uring.h                      |   1 -
 include/linux/io_uring_types.h                |   2 +-
 include/linux/iocontext.h                     |   4 +-
 include/linux/iomap.h                         |   2 +-
 include/linux/iov_iter.h                      |   2 +-
 include/linux/iova.h                          |   2 +-
 include/linux/ipc.h                           |   6 +-
 include/linux/ipc_namespace.h                 |   4 +-
 include/linux/irqdesc.h                       |   4 +-
 include/linux/irqdomain.h                     |   4 +-
 include/linux/ism.h                           |   2 -
 include/linux/jbd2.h                          |   4 +-
 include/linux/journal-head.h                  |   2 +-
 include/linux/jump_label_ratelimit.h          |   2 +-
 include/linux/kernel_stat.h                   |   1 -
 include/linux/kernfs.h                        |   9 +-
 include/linux/key.h                           |   5 +-
 include/linux/klist.h                         |   4 +-
 include/linux/kmod.h                          |   2 +-
 include/linux/kmsan.h                         |   2 +-
 include/linux/kobj_map.h                      |   4 +-
 include/linux/kobject.h                       |  83 +--
 include/linux/kobject_types.h                 |  84 +++
 include/linux/kprobes.h                       |   4 +-
 include/linux/kref.h                          |   6 +-
 include/linux/kref_types.h                    |  12 +
 include/linux/kvm_host.h                      |   5 +-
 include/linux/kvm_types.h                     |   2 +-
 include/linux/lapb.h                          |   1 -
 include/linux/lcd.h                           |   2 +-
 include/linux/leds-pca9532.h                  |   2 +-
 include/linux/leds.h                          |   8 +-
 include/linux/libata.h                        |   2 +-
 include/linux/libnvdimm.h                     |   5 +-
 include/linux/libps2.h                        |   4 +-
 include/linux/list_bl.h                       |  19 +-
 include/linux/list_bl_types.h                 |  36 ++
 include/linux/list_lru.h                      |  33 +-
 include/linux/list_lru_types.h                |  42 ++
 include/linux/livepatch.h                     |   2 +-
 include/linux/lockd/lockd.h                   |   4 +-
 include/linux/lockref.h                       |   2 +-
 include/linux/lp.h                            |   4 +-
 include/linux/lru_cache.h                     |   1 -
 include/linux/lsm_audit.h                     |   1 -
 include/linux/mISDNhw.h                       |   2 +-
 include/linux/mISDNif.h                       |   3 +-
 include/linux/mailbox_client.h                |   2 +-
 include/linux/mailbox_controller.h            |   6 +-
 include/linux/maple_tree.h                    | 323 +----------
 include/linux/maple_tree_types.h              | 341 ++++++++++++
 include/linux/mbcache.h                       |   2 +-
 include/linux/mc146818rtc.h                   |   2 +-
 include/linux/mdio-mux.h                      |   6 +-
 include/linux/mdio/mdio-mscc-miim.h           |   8 +-
 include/linux/mdio/mdio-xgene.h               |   2 +-
 include/linux/memory-tiers.h                  |   4 +-
 include/linux/memory.h                        |   2 +-
 include/linux/memory_hotplug.h                |   1 +
 include/linux/mempolicy.h                     |   5 +-
 include/linux/mempool.h                       |   2 +-
 include/linux/memstick.h                      |   2 +-
 include/linux/mfd/abx500/ab8500.h             |   2 +-
 include/linux/mfd/altera-a10sr.h              |   1 -
 include/linux/mfd/cs42l43.h                   |   6 +-
 include/linux/mfd/da9052/da9052.h             |   2 +-
 include/linux/mfd/intel-m10-bmc.h             |   2 +-
 include/linux/mfd/ipaq-micro.h                |   2 +-
 include/linux/mfd/lochnagar.h                 |   2 +-
 include/linux/mfd/madera/core.h               |   2 +-
 include/linux/mfd/max8907.h                   |   3 +-
 include/linux/mfd/mt6397/core.h               |   2 +-
 include/linux/mfd/mt6397/rtc.h                |   2 +-
 include/linux/mfd/pcf50633/core.h             |   3 +-
 include/linux/mfd/rc5t583.h                   |   2 +-
 include/linux/mfd/stmpe.h                     |   2 +-
 include/linux/mfd/ucb1x00.h                   |   2 +-
 include/linux/mfd/wm831x/core.h               |   1 -
 include/linux/mfd/wm8350/core.h               |   4 +-
 include/linux/mfd/wm8350/supply.h             |   1 -
 include/linux/mfd/wm8400-private.h            |   1 -
 include/linux/mfd/wm8994/core.h               |   1 -
 include/linux/mhi.h                           |   8 +-
 include/linux/mlx4/device.h                   |   4 +-
 include/linux/mlx5/cq.h                       |   1 +
 include/linux/mlx5/driver.h                   |  10 +-
 include/linux/mm.h                            |   7 +-
 include/linux/mm_inline.h                     |   4 +
 include/linux/mm_types.h                      |  20 +-
 include/linux/mmc/core.h                      |   2 +-
 include/linux/mmu_notifier.h                  |   1 -
 include/linux/mmzone.h                        |   9 +-
 include/linux/module.h                        |   3 +-
 include/linux/moxtet.h                        |   2 +-
 include/linux/mroute_base.h                   |   2 +-
 include/linux/msi.h                           |   4 +-
 include/linux/mtd/blktrans.h                  |   6 +-
 include/linux/mtd/doc2000.h                   |   2 +-
 include/linux/mtd/flashchip.h                 |   2 +-
 include/linux/mtd/onenand.h                   |   4 +-
 include/linux/mtd/qinfo.h                     |   2 -
 include/linux/mtd/sh_flctl.h                  |   2 +-
 include/linux/mtd/spinand.h                   |   2 +-
 include/linux/mutex.h                         |   2 +-
 include/linux/ndctl.h                         |   2 +
 include/linux/net.h                           |   2 +-
 include/linux/netdevice.h                     |   5 +-
 include/linux/netfilter.h                     |   1 -
 include/linux/netfs.h                         |   2 +-
 include/linux/netpoll.h                       |   2 +-
 include/linux/nfs4.h                          |   2 +-
 include/linux/nfs_fs.h                        |   7 +-
 include/linux/nfs_fs_sb.h                     |   4 +-
 include/linux/nfs_page.h                      |   3 +-
 include/linux/node.h                          |   4 +-
 include/linux/nodemask.h                      |   3 +
 include/linux/notifier.h                      |   1 +
 include/linux/ns_common.h                     |   3 +-
 include/linux/nsproxy.h                       |   1 -
 include/linux/ntb.h                           |   2 +-
 include/linux/objpool.h                       |   2 +-
 include/linux/oom.h                           |   2 +-
 include/linux/padata.h                        |   8 +-
 include/linux/pagemap.h                       |   2 +-
 include/linux/parport.h                       |   4 +-
 include/linux/part_stat.h                     |   2 +-
 include/linux/pci.h                           |   2 +-
 include/linux/peci.h                          |   2 +-
 include/linux/percpu-refcount.h               |  66 +--
 include/linux/percpu-refcount_types.h         |  71 +++
 include/linux/percpu-rwsem.h                  |  15 +-
 include/linux/percpu-rwsem_types.h            |  24 +
 include/linux/percpu_counter.h                |  18 +-
 include/linux/percpu_counter_types.h          |  37 ++
 include/linux/perf/arm_pmu.h                  |   1 -
 include/linux/perf_event.h                    |  12 +-
 include/linux/phy.h                           |   6 +-
 include/linux/phylink.h                       |   2 -
 include/linux/pid.h                           |   2 +-
 include/linux/pid_namespace.h                 |   1 -
 include/linux/pktcdvd.h                       |   5 +-
 include/linux/platform_data/asoc-ti-mcbsp.h   |   1 -
 include/linux/platform_data/cros_ec_proto.h   |   2 +-
 .../linux/platform_data/cros_ec_sensorhub.h   |   2 +-
 include/linux/platform_data/wilco-ec.h        |   2 +-
 include/linux/platform_data/xilinx-ll-temac.h |   2 +-
 include/linux/pm.h                            |  15 +-
 include/linux/pm_clock.h                      |   2 +-
 include/linux/pm_domain.h                     |   6 +-
 include/linux/pm_qos.h                        |   2 +-
 include/linux/poll.h                          |   2 +-
 include/linux/posix-clock.h                   |   2 +-
 include/linux/posix-timers.h                  |   3 +-
 include/linux/power_supply.h                  |   6 +-
 include/linux/powercap.h                      |   2 +-
 include/linux/pps_kernel.h                    |   3 +-
 include/linux/pruss_driver.h                  |   2 +-
 include/linux/psi_types.h                     |   5 +-
 include/linux/pstore.h                        |   4 +-
 include/linux/pwm.h                           |   1 -
 include/linux/qed/qede_rdma.h                 |   2 +-
 include/linux/quota.h                         |  40 +-
 include/linux/quota_types.h                   |  68 +++
 include/linux/quotaops.h                      |   1 +
 include/linux/radix-tree.h                    |  45 +-
 include/linux/radix-tree_types.h              |  50 ++
 include/linux/raid/pq.h                       |   2 +-
 include/linux/raid_class.h                    |   2 +
 include/linux/random.h                        |   1 -
 include/linux/rcupdate_wait.h                 |   2 +-
 include/linux/regmap.h                        |   3 +-
 include/linux/relay.h                         |   5 +-
 include/linux/remoteproc.h                    |   3 +-
 include/linux/resctrl.h                       |   5 +-
 include/linux/reset/reset-simple.h            |   2 +-
 include/linux/rfkill.h                        |   2 -
 include/linux/rhashtable-types.h              |   2 +-
 include/linux/ring_buffer.h                   |   1 -
 include/linux/rpmsg.h                         |   4 +-
 include/linux/rslib.h                         |   2 +-
 include/linux/rtc.h                           |   4 +-
 include/linux/rtc/ds1685.h                    |   1 -
 include/linux/rtnetlink.h                     |   4 +-
 include/linux/rwsem.h                         |  48 +-
 include/linux/rwsem_types.h                   |  78 +++
 include/linux/sbitmap.h                       | 125 +----
 include/linux/sbitmap_types.h                 | 129 +++++
 include/linux/sched/clock.h                   |   2 +-
 include/linux/sched/signal.h                  |   4 +-
 include/linux/sched/user.h                    |   6 +-
 include/linux/scs.h                           |   2 +-
 include/linux/seq_file.h                      |   3 +-
 include/linux/serial_core.h                   |   1 -
 include/linux/serio.h                         |   2 +-
 include/linux/sh_clk.h                        |   3 +-
 include/linux/shmem_fs.h                      |   2 +-
 include/linux/skbuff.h                        |   2 +-
 include/linux/slab.h                          |   5 +-
 include/linux/slimbus.h                       |   3 +-
 include/linux/soc/apple/rtkit.h               |   3 +-
 include/linux/soc/apple/sart.h                |   2 +-
 include/linux/soc/mediatek/mtk-cmdq.h         |   1 -
 include/linux/soc/qcom/apr.h                  |   2 +-
 include/linux/soc/qcom/qcom_aoss.h            |   2 +-
 include/linux/soc/qcom/qmi.h                  |   4 +-
 include/linux/socket.h                        |   2 +-
 include/linux/soundwire/sdw.h                 |   1 +
 include/linux/spi/spi.h                       |   2 +-
 include/linux/spi/spi_bitbang.h               |   3 +-
 include/linux/srcu.h                          |   2 -
 include/linux/srcutree.h                      |   4 +-
 include/linux/ssb/ssb.h                       |   2 +-
 include/linux/ssb/ssb_driver_gige.h           |   2 +-
 include/linux/stackdepot.h                    |   3 +-
 include/linux/stat.h                          |   2 +-
 include/linux/stm.h                           |   4 +-
 include/linux/sunrpc/auth.h                   |   1 -
 include/linux/sunrpc/auth_gss.h               |   2 +-
 include/linux/sunrpc/clnt.h                   |   2 +-
 include/linux/sunrpc/metrics.h                |   5 +-
 include/linux/sunrpc/rpc_pipe_fs.h            |   4 +-
 include/linux/sunrpc/sched.h                  |   5 +-
 include/linux/sunrpc/svc.h                    |   1 -
 include/linux/sunrpc/svc_rdma.h               |   1 -
 include/linux/sunrpc/types.h                  |   4 +-
 include/linux/sunrpc/xprt.h                   |   2 +-
 include/linux/surface_aggregator/serial_hub.h |   2 +-
 include/linux/swait.h                         |  16 +-
 include/linux/swait_types.h                   |  20 +
 include/linux/swap.h                          |   2 +-
 include/linux/swap_slots.h                    |   4 +-
 include/linux/swapops.h                       |   1 -
 include/linux/swiotlb.h                       |   7 +-
 include/linux/sync_file.h                     |   1 -
 include/linux/sys_soc.h                       |   3 +-
 include/linux/syscalls.h                      |   1 -
 include/linux/sysctl.h                        |   4 +-
 include/linux/sysfs.h                         |  70 +--
 include/linux/sysfs_types.h                   |  89 ++++
 include/linux/syslog.h                        |   2 +-
 include/linux/tee_drv.h                       |   2 +-
 include/linux/thermal.h                       |   6 +-
 include/linux/thunderbolt.h                   |   2 +-
 include/linux/tifm.h                          |   4 +-
 include/linux/torture.h                       |   4 -
 include/linux/trace_recursion.h               |   1 +
 include/linux/tracefs.h                       |   1 -
 include/linux/transport_class.h               |   3 +-
 include/linux/tty.h                           |   6 +-
 include/linux/tty_buffer.h                    |   4 +-
 include/linux/tty_driver.h                    |   1 +
 include/linux/tty_ldisc.h                     |   4 +-
 include/linux/tty_port.h                      |   2 +-
 include/linux/u64_stats_sync.h                |   5 +
 include/linux/umh.h                           |   4 +-
 include/linux/uprobes.h                       |  12 +-
 include/linux/uprobes_types.h                 |  25 +
 include/linux/usb.h                           |   6 +-
 include/linux/usb/gadget.h                    |   2 +-
 include/linux/usb/hcd.h                       |   1 -
 include/linux/usb/ljca.h                      |   2 +-
 include/linux/usb/otg-fsm.h                   |   2 +-
 include/linux/usb/role.h                      |   5 +-
 include/linux/usb/serial.h                    |   4 +-
 include/linux/user_namespace.h                |   5 +-
 include/linux/vfio.h                          |   2 +-
 include/linux/vfio_pci_core.h                 |   3 +-
 include/linux/via-core.h                      |   2 +-
 include/linux/virtio.h                        |   4 +-
 include/linux/vmalloc.h                       |   3 +-
 include/linux/vmpressure.h                    |   6 +-
 include/linux/vmw_vmci_api.h                  |   2 +-
 include/linux/vt_kern.h                       |   1 -
 include/linux/w1.h                            |   2 +-
 include/linux/wait.h                          |  23 +-
 include/linux/wait_bit.h                      |   5 +-
 include/linux/wait_types.h                    |  31 ++
 include/linux/watch_queue.h                   |   2 +-
 include/linux/workqueue.h                     |   9 -
 include/linux/workqueue_types.h               |   9 +
 include/linux/writeback.h                     |   2 +-
 include/linux/ww_mutex.h                      |   1 +
 include/linux/xarray.h                        |  56 +-
 include/linux/xarray_types.h                  |  70 +++
 include/media/cec.h                           |   3 +-
 include/media/dmxdev.h                        |   7 +-
 include/media/drv-intf/saa7146.h              |   2 +-
 include/media/dvb_demux.h                     |   5 +-
 include/media/dvb_frontend.h                  |   2 +-
 include/media/dvb_ringbuffer.h                |   4 +-
 include/media/dvb_vb2.h                       |   2 +-
 include/media/i2c/adp1653.h                   |   2 +-
 include/media/media-device.h                  |   3 +-
 include/media/media-devnode.h                 |   2 +-
 include/media/media-request.h                 |   1 +
 include/media/rc-core.h                       |   3 +-
 include/media/v4l2-async.h                    |   1 -
 include/media/v4l2-dev.h                      |   2 +-
 include/media/v4l2-device.h                   |   2 +
 include/media/v4l2-event.h                    |   1 -
 include/media/v4l2-ioctl.h                    |   1 -
 include/media/videobuf2-core.h                |   2 +-
 include/net/af_unix.h                         |   4 +-
 include/net/af_vsock.h                        |   2 +-
 include/net/atmclip.h                         |   2 +-
 include/net/ax25.h                            |   5 +-
 include/net/bluetooth/bluetooth.h             |   3 +-
 include/net/bluetooth/hci_core.h              |   1 +
 include/net/bonding.h                         |   1 -
 include/net/bpf_sk_storage.h                  |   4 -
 include/net/caif/cfcnfg.h                     |   1 -
 include/net/caif/cfsrvl.h                     |   1 -
 include/net/cfg802154.h                       |   2 +-
 include/net/devlink.h                         |  11 +-
 include/net/dsa.h                             |   2 -
 include/net/dsa_stubs.h                       |   1 -
 include/net/dst.h                             |   2 +-
 include/net/flow.h                            |   2 +-
 include/net/fq.h                              |   2 +-
 include/net/hwbm.h                            |   2 +-
 include/net/inet_connection_sock.h            |   2 +-
 include/net/inet_frag.h                       |   2 +-
 include/net/inet_hashtables.h                 |   3 +-
 include/net/inet_timewait_sock.h              |   3 +-
 include/net/inetpeer.h                        |   1 -
 include/net/ip6_fib.h                         |   2 +-
 include/net/ip_fib.h                          |   1 -
 include/net/ip_vs.h                           |   6 +-
 include/net/lib80211.h                        |   5 +-
 include/net/llc.h                             |   2 +-
 include/net/llc_conn.h                        |   2 +-
 include/net/neighbour.h                       |   5 +-
 include/net/net_namespace.h                   |   3 +-
 include/net/net_ratelimit.h                   |   2 -
 include/net/netdev_rx_queue.h                 |   4 +-
 include/net/netfilter/nf_conntrack_count.h    |   2 +-
 include/net/netns/can.h                       |   4 +-
 include/net/netns/conntrack.h                 |   2 -
 include/net/netns/ipv4.h                      |   4 +-
 include/net/netns/ipv6.h                      |   4 +
 include/net/netns/mctp.h                      |   3 +-
 include/net/netns/nexthop.h                   |   2 +-
 include/net/netns/packet.h                    |   2 +-
 include/net/netns/sctp.h                      |   2 +-
 include/net/netns/smc.h                       |   2 +-
 include/net/netns/unix.h                      |   2 +-
 include/net/netns/xdp.h                       |   3 +-
 include/net/netns/xfrm.h                      |   3 +-
 include/net/netrom.h                          |   1 -
 include/net/nfc/nfc.h                         |   2 +-
 include/net/phonet/pn_dev.h                   |   2 +-
 include/net/pkt_cls.h                         |   3 +-
 include/net/sch_generic.h                     |   7 +-
 include/net/sctp/sctp.h                       |   2 +-
 include/net/sctp/structs.h                    |   2 +-
 include/net/smc.h                             |   6 +-
 include/net/snmp.h                            |   1 -
 include/net/sock.h                            |   6 +-
 include/net/sock_reuseport.h                  |   2 +-
 include/net/tcp.h                             |   5 +-
 include/net/tls.h                             |   2 +-
 include/net/tls_toe.h                         |   2 +-
 include/net/udp.h                             |   3 +-
 include/net/xdp_sock.h                        |   6 +-
 include/net/xfrm.h                            |   3 +-
 include/pcmcia/ss.h                           |   4 +-
 include/rdma/ib_sa.h                          |   2 +-
 include/rdma/ib_sysfs.h                       |   2 +-
 include/rdma/ib_umem.h                        |   1 -
 include/rdma/ib_verbs.h                       |   6 +-
 include/rdma/rdma_counter.h                   |   2 +-
 include/rdma/rdma_vt.h                        |   2 +-
 include/rdma/restrack.h                       |   5 +-
 include/rdma/uverbs_types.h                   |   1 +
 include/scsi/libfc.h                          |   2 +-
 include/scsi/libfcoe.h                        |   2 +-
 include/scsi/libiscsi.h                       |   8 +-
 include/scsi/libsas.h                         |   2 +-
 include/scsi/scsi_cmnd.h                      |   3 +-
 include/scsi/scsi_device.h                    |   5 +-
 include/scsi/scsi_host.h                      |   5 +-
 include/scsi/scsi_tcq.h                       |   2 +-
 include/scsi/scsi_transport.h                 |   2 +-
 include/scsi/scsi_transport_iscsi.h           |   2 +-
 include/scsi/scsi_transport_sas.h             |   2 +-
 include/scsi/scsi_transport_spi.h             |   2 +-
 include/scsi/scsi_transport_srp.h             |   2 +-
 include/soc/fsl/qe/qe.h                       |   2 +-
 include/sound/ac97_codec.h                    |   2 +-
 include/sound/control.h                       |   2 +-
 include/sound/core.h                          |  11 +-
 include/sound/emu10k1.h                       |   2 +-
 include/sound/rawmidi.h                       |   8 +-
 include/sound/soc.h                           |   2 +-
 include/sound/util_mem.h                      |   3 +-
 include/target/iscsi/iscsi_target_stat.h      |   2 +-
 include/target/target_core_base.h             |   4 +-
 include/trace/events/block.h                  |   2 +-
 include/trace/events/iommu.h                  |   3 +-
 include/trace/events/kyber.h                  |   2 +-
 include/trace/events/lock.h                   |   2 +-
 include/trace/events/mmc.h                    |   2 +-
 include/trace/events/power.h                  |   1 +
 include/trace/events/workqueue.h              |   2 +-
 include/video/atmel_lcdc.h                    |   2 -
 include/video/omapfb_dss.h                    |   2 +-
 include/xen/interface/memory.h                |   2 -
 include/xen/xenbus.h                          |   3 +-
 init/init_task.c                              |   1 +
 init/initramfs.c                              |   1 +
 init/main.c                                   |   1 +
 io_uring/cancel.c                             |   1 +
 io_uring/io_uring.c                           |   2 +
 io_uring/timeout.h                            |   2 +
 ipc/mq_sysctl.c                               |   1 +
 ipc/mqueue.c                                  |   1 +
 ipc/namespace.c                               |   1 +
 ipc/sem.c                                     |   1 +
 kernel/bpf/helpers.c                          |   1 +
 kernel/cgroup/cgroup.c                        |   1 +
 kernel/cpu.c                                  |   1 +
 kernel/dma/debug.c                            |   1 +
 kernel/entry/common.c                         |   1 +
 kernel/events/core.c                          |   1 +
 kernel/exit.c                                 |   3 +
 kernel/fork.c                                 |   1 +
 kernel/futex/core.c                           |   1 +
 kernel/futex/pi.c                             |   1 +
 kernel/futex/requeue.c                        |   1 +
 kernel/futex/syscalls.c                       |   1 +
 kernel/futex/waitwake.c                       |   1 +
 kernel/irq/irqdomain.c                        |   1 +
 kernel/irq/manage.c                           |   1 +
 kernel/kheaders.c                             |   1 +
 kernel/livepatch/core.c                       |   2 +
 kernel/livepatch/transition.c                 |   1 +
 kernel/locking/rtmutex.c                      |   1 +
 kernel/locking/rtmutex_common.h               |   1 +
 kernel/module/main.c                          |   1 +
 kernel/module/sysfs.c                         |   1 +
 kernel/padata.c                               |   2 +
 kernel/panic.c                                |   2 +
 kernel/params.c                               |   1 +
 kernel/power/energy_model.c                   |   1 +
 kernel/reboot.c                               |   2 +
 kernel/relay.c                                |   1 +
 kernel/signal.c                               |   1 +
 kernel/smpboot.c                              |   1 +
 kernel/time/hrtimer.c                         |   1 +
 kernel/time/namespace.c                       |   1 +
 kernel/time/posix-timers.c                    |   1 +
 kernel/time/timer_list.c                      |   1 +
 kernel/trace/blktrace.c                       |   1 +
 kernel/trace/bpf_trace.c                      |   1 +
 kernel/trace/trace_osnoise.c                  |   1 +
 kernel/tsacct.c                               |   1 +
 kernel/ucount.c                               |   1 +
 kernel/user.c                                 |   3 +
 kernel/watch_queue.c                          |   1 +
 kernel/watchdog.c                             |   1 +
 kernel/workqueue.c                            |   1 +
 lib/cpu_rmap.c                                |   2 +
 lib/flex_proportions.c                        |   3 +
 lib/group_cpus.c                              |   1 +
 lib/klist.c                                   |   1 +
 lib/kobject.c                                 |   4 +
 lib/lockref.c                                 |   2 +
 lib/objpool.c                                 |   2 +
 lib/test_lockup.c                             |   1 +
 mm/cma_sysfs.c                                |   1 +
 mm/damon/sysfs-common.c                       |   2 +
 mm/damon/sysfs-common.h                       |   2 +-
 mm/damon/sysfs-schemes.c                      |   2 +
 mm/damon/sysfs.c                              |   2 +
 mm/folio-compat.c                             |   1 +
 mm/huge_memory.c                              |   1 +
 mm/hugetlb.c                                  |   1 +
 mm/khugepaged.c                               |   2 +
 mm/ksm.c                                      |   2 +
 mm/memory-tiers.c                             |   2 +
 mm/memory.c                                   |   1 +
 mm/memory_hotplug.c                           |   1 +
 mm/mempolicy.c                                |   2 +
 mm/shmem.c                                    |   1 +
 mm/swap_state.c                               |   1 +
 mm/vmscan.c                                   |   1 +
 mm/workingset.c                               |   1 +
 mm/z3fold.c                                   |   1 +
 mm/zswap.c                                    |   1 +
 net/9p/trans_virtio.c                         |   1 +
 net/bridge/br_sysfs_br.c                      |   1 +
 net/can/j1939/bus.c                           |   2 +
 net/can/j1939/main.c                          |   1 +
 net/can/j1939/transport.c                     |   2 +
 net/ceph/string_table.c                       |   1 +
 net/dsa/dsa.c                                 |   1 +
 net/nfc/llcp_core.c                           |   1 +
 net/qrtr/af_qrtr.c                            |   1 +
 net/rds/message.c                             |   1 +
 net/rds/rdma.c                                |   1 +
 net/rfkill/core.c                             |   1 +
 net/sched/act_gate.c                          |   1 +
 net/tipc/node.c                               |   2 +
 net/tipc/subscr.c                             |   2 +
 net/tipc/topsrv.c                             |   1 +
 net/tls/tls_toe.c                             |   1 +
 net/wireless/reg.c                            |   1 +
 net/xfrm/xfrm_state.c                         |   1 +
 samples/vfio-mdev/mtty.c                      |   1 +
 security/integrity/ima/ima_mok.c              |   1 +
 security/keys/proc.c                          |   1 +
 sound/core/init.c                             |   1 +
 sound/hda/hda_bus_type.c                      |   1 +
 sound/hda/hdac_sysfs.c                        |   1 +
 sound/soc/intel/avs/avs.h                     |   1 +
 sound/soc/qcom/qdsp6/q6apm.c                  |   1 +
 sound/soc/qcom/qdsp6/q6apm.h                  |   1 +
 sound/soc/sof/sof-audio.h                     |   1 +
 1243 files changed, 4054 insertions(+), 2940 deletions(-)
 create mode 100644 include/linux/bio_types.h
 create mode 100644 include/linux/blkdev_types.h
 create mode 100644 include/linux/bvec_types.h
 create mode 100644 include/linux/completion_types.h
 create mode 100644 include/linux/device_types.h
 create mode 100644 include/linux/kobject_types.h
 create mode 100644 include/linux/kref_types.h
 create mode 100644 include/linux/list_bl_types.h
 create mode 100644 include/linux/list_lru_types.h
 create mode 100644 include/linux/maple_tree_types.h
 create mode 100644 include/linux/percpu-refcount_types.h
 create mode 100644 include/linux/percpu-rwsem_types.h
 create mode 100644 include/linux/percpu_counter_types.h
 create mode 100644 include/linux/quota_types.h
 create mode 100644 include/linux/radix-tree_types.h
 create mode 100644 include/linux/rwsem_types.h
 create mode 100644 include/linux/sbitmap_types.h
 create mode 100644 include/linux/swait_types.h
 create mode 100644 include/linux/sysfs_types.h
 create mode 100644 include/linux/uprobes_types.h
 create mode 100644 include/linux/wait_types.h
 create mode 100644 include/linux/xarray_types.h

-- 
2.39.2


