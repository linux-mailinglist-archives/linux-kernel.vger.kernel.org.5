Return-Path: <linux-kernel+bounces-46642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1BF84424D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAE69B2E74E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD4D12DD81;
	Wed, 31 Jan 2024 14:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="XbzNg5rd"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C185012AAF4
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712630; cv=none; b=LOGTMt09AUnrtvwbPQPr31V32L3TYEheJYx8GAc02a9iRn+BTNoLwrc9Z3VHYJ5ZqTlzxEOcStPJ0A3k+G/BLonUWhCUObyNoEpCgHvSCd+LewOrMeXnK/6sednd5NRSiNxcMjkFyItvYWEwvt1eYXMkuDJMGwZt0lGJwV3/m2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712630; c=relaxed/simple;
	bh=QWBRxxB5jcH6bUGdO7nLUC0n8B1JmPclLsioVKfB53I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RKIMffJsndwW61vWIrGBoFibmJZmy1GuDamMRbT9Qf//s6Q3Zn0AMnGwtCzHPIL8i9slA+F28iGbbL3VQjTnql/KWfRvFGAl21xICakuD6yGklGYrNUujbrfJVv0iaak9N8zRGhkRvBZMVMuDLI9H7Fg1j3iYV3SrMDUSyAXq4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=XbzNg5rd; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33ae3be1c37so627438f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 06:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1706712621; x=1707317421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHJyFXGeiVNC332fAlfNLHyLWIsWJJW2TP9JiWfV86Y=;
        b=XbzNg5rdQCJUjUcO96pPdj4Xm91ovduWMaK55fB74wQJkf6JZx6FBVYWbPyWhqA9K0
         8Pvw26BICdw58qR9yq4P0Ni3zlNVUk5ZjESQjPonHZLn96hWHO8F3yMK99wPBUYg0ZeE
         SGgYCSXFaudEcWu1VoPR2FsgLFngZsSTcGFdjkbSr2//nhfh68c3x+Oz+0McBrSmQk4n
         PbzPC+2pbbrEFg8aXaDikAx4nUzSGsVTiiUJoXafQlEpmZjMRrkEpvqyEG6E7Xoqmtvk
         h9gu7r0gHx6ESfLYwS94eR+ZQ0rVIUSdsWm2Ktc1bgOpPpiLW+TSe/Yg4aM6rJIjZvn8
         mGuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706712621; x=1707317421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BHJyFXGeiVNC332fAlfNLHyLWIsWJJW2TP9JiWfV86Y=;
        b=qBlKe1KRmT6A20m9/z8b6/DpALKedYolyDBIdxdHDrTbEOFeNZB2/utXRbpx0b33Xn
         JPxfU0GOhRISVc/hPj+i595ilLPolxrzmUUZ7BXWUcXW4lZ9NDL1owqDpc5VddxraYTI
         9lGG9xrv1XQRyPTbHl5AZWV+7PTOvLtvfIy7guv7FhpdQ19sYh+jRsiIZnUgk20T/L9Z
         q59flbEYEMwUz++J46q1cR0f2FU+riPuPHWkCHotDY3KCLOhJ2YXrL5VjpNMeETmM6pv
         Ot2hziZwBP9iUnYZJIoJPGsR345wCEd+K7+3jLSj5Yo4KJWr7S21LKKM7CBkSlu9C8KI
         8O9w==
X-Gm-Message-State: AOJu0Yw11Z+NFp79ZVa23XslNfdcpvWFwQU4Dss0fVeQJKyU9y1ho9U7
	BXF+Jjo8j1dnpu3NwD8p9DDprEjVsKZuFISj04nn+YDiTAjaYMv2B+zADUCzOVbsoLIdODj58IS
	W
X-Google-Smtp-Source: AGHT+IH0eAz7brY+UAYUJfSdj9W65/yQsGLENNIYTtdMZIQRmBOXtt2v4QPowdeDVIFPcif5XwxSJQ==
X-Received: by 2002:a05:6000:1c3:b0:33a:ff6f:815e with SMTP id t3-20020a05600001c300b0033aff6f815emr1892831wrx.8.1706712619801;
        Wed, 31 Jan 2024 06:50:19 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f2f5c00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f2f:5c00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ch15-20020a5d5d0f000000b0033905a60689sm13850173wrb.45.2024.01.31.06.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 06:50:19 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 06/28] kobject.h: move declarations to kobject_types.h
Date: Wed, 31 Jan 2024 15:49:46 +0100
Message-Id: <20240131145008.1345531-7-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240131145008.1345531-1-max.kellermann@ionos.com>
References: <20240131145008.1345531-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By providing declarations in a lean header, we can reduce header
dependencies.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 arch/arm64/kernel/cpuinfo.c                   |  1 +
 block/bdev.c                                  |  1 +
 block/bfq-iosched.c                           |  1 +
 block/blk-crypto-sysfs.c                      |  1 +
 block/blk-ia-ranges.c                         |  1 +
 block/blk-mq-sched.c                          |  1 +
 block/blk-mq-sysfs.c                          |  1 +
 block/blk-mq.c                                |  1 +
 block/blk-sysfs.c                             |  1 +
 block/disk-events.c                           |  1 +
 block/elevator.c                              |  1 +
 block/genhd.c                                 |  1 +
 block/holder.c                                |  1 +
 block/kyber-iosched.c                         |  1 +
 block/mq-deadline.c                           |  1 +
 block/partitions/core.c                       |  1 +
 .../accessibility/speakup/speakup_acntpc.c    |  1 +
 .../accessibility/speakup/speakup_acntsa.c    |  2 +
 .../accessibility/speakup/speakup_apollo.c    |  1 +
 .../accessibility/speakup/speakup_audptr.c    |  2 +
 drivers/accessibility/speakup/speakup_bns.c   |  2 +
 .../accessibility/speakup/speakup_decext.c    |  1 +
 drivers/accessibility/speakup/speakup_decpc.c |  1 +
 .../accessibility/speakup/speakup_dectlk.c    |  1 +
 drivers/accessibility/speakup/speakup_dtlk.c  |  1 +
 drivers/accessibility/speakup/speakup_dummy.c |  2 +
 drivers/accessibility/speakup/speakup_keypc.c |  1 +
 drivers/accessibility/speakup/speakup_ltlk.c  |  2 +
 drivers/accessibility/speakup/speakup_soft.c  |  1 +
 .../accessibility/speakup/speakup_spkout.c    |  2 +
 drivers/accessibility/speakup/speakup_txprt.c |  2 +
 drivers/acpi/ac.c                             |  1 +
 drivers/acpi/acpi_fpdt.c                      |  1 +
 drivers/acpi/bgrt.c                           |  1 +
 drivers/acpi/bus.c                            |  1 +
 drivers/acpi/container.c                      |  1 +
 drivers/acpi/device_sysfs.c                   |  1 +
 drivers/acpi/dock.c                           |  1 +
 drivers/acpi/sysfs.c                          |  1 +
 drivers/ata/libata-acpi.c                     |  1 +
 drivers/base/devcoredump.c                    |  1 +
 drivers/base/firmware_loader/fallback.c       |  1 +
 drivers/base/firmware_loader/sysfs.c          |  1 +
 drivers/block/drbd/drbd_nl.c                  |  1 +
 drivers/block/loop.c                          |  1 +
 drivers/block/nbd.c                           |  1 +
 drivers/block/rnbd/rnbd-clt-sysfs.c           |  1 +
 drivers/block/rnbd/rnbd-clt.c                 |  1 +
 drivers/block/rnbd/rnbd-srv.c                 |  1 +
 drivers/block/ublk_drv.c                      |  1 +
 drivers/bus/mhi/ep/main.c                     |  1 +
 drivers/bus/mhi/host/init.c                   |  1 +
 drivers/char/virtio_console.c                 |  1 +
 drivers/char/xillybus/xillybus_class.c        |  1 +
 drivers/comedi/comedi_fops.c                  |  1 +
 drivers/cxl/core/port.c                       |  1 +
 drivers/dax/bus.c                             |  1 +
 drivers/dma/qcom/hidma_mgmt_sys.c             |  1 +
 drivers/firmware/arm_ffa/bus.c                |  1 +
 drivers/firmware/dmi-id.c                     |  1 +
 drivers/firmware/dmi_scan.c                   |  1 +
 drivers/firmware/memmap.c                     |  1 +
 drivers/firmware/qemu_fw_cfg.c                |  1 +
 drivers/gnss/core.c                           |  1 +
 drivers/greybus/core.c                        |  1 +
 drivers/hid/hid-core.c                        |  1 +
 drivers/hid/hid-wiimote-core.c                |  1 +
 drivers/hid/wacom_sys.c                       |  1 +
 drivers/hwmon/acpi_power_meter.c              |  1 +
 drivers/hwtracing/stm/core.c                  |  1 +
 drivers/infiniband/core/device.c              |  1 +
 drivers/infiniband/core/sysfs.c               |  1 +
 drivers/infiniband/hw/mlx4/sysfs.c            |  1 +
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c  |  2 +
 drivers/infiniband/ulp/rtrs/rtrs-clt.c        |  1 +
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c  |  2 +
 drivers/infiniband/ulp/rtrs/rtrs-srv.c        |  1 +
 drivers/input/input.c                         |  1 +
 drivers/input/serio/serio.c                   |  1 +
 drivers/ipack/ipack.c                         |  1 +
 drivers/isdn/mISDN/core.c                     |  1 +
 drivers/leds/led-triggers.c                   |  1 +
 drivers/mcb/mcb-core.c                        |  1 +
 drivers/md/dm-verity-target.c                 |  1 +
 drivers/media/cec/core/cec-core.c             |  1 +
 drivers/media/mc/mc-devnode.c                 |  1 +
 drivers/media/rc/rc-main.c                    |  1 +
 drivers/memstick/core/memstick.c              |  1 +
 drivers/misc/ti-st/st_kim.c                   |  1 +
 drivers/misc/tifm_core.c                      |  1 +
 drivers/most/most_cdev.c                      |  1 +
 drivers/net/bonding/bond_main.c               |  1 +
 .../ethernet/qlogic/qlcnic/qlcnic_minidump.c  |  2 +
 drivers/net/wireless/ath/wil6210/interrupt.c  |  1 +
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  1 +
 drivers/net/xen-netback/xenbus.c              |  1 +
 drivers/nvdimm/bus.c                          |  1 +
 drivers/nvme/host/core.c                      |  1 +
 drivers/nvme/host/fc.c                        |  1 +
 drivers/pci/host-bridge.c                     |  1 +
 drivers/pci/iov.c                             |  1 +
 drivers/pcmcia/cs.c                           |  1 +
 drivers/pcmcia/ds.c                           |  1 +
 drivers/platform/surface/aggregator/bus.c     |  1 +
 drivers/power/supply/power_supply_sysfs.c     |  1 +
 drivers/pps/pps.c                             |  1 +
 drivers/rapidio/rio-driver.c                  |  1 +
 drivers/scsi/ipr.c                            |  1 +
 drivers/scsi/iscsi_boot_sysfs.c               |  1 +
 drivers/scsi/qedf/qedf_dbg.c                  |  1 +
 drivers/scsi/qla4xxx/ql4_nx.c                 |  1 +
 drivers/scsi/scsi_lib.c                       |  1 +
 drivers/scsi/scsi_sysfs.c                     |  1 +
 drivers/scsi/ses.c                            |  1 +
 drivers/staging/fieldbus/dev_core.c           |  1 +
 drivers/staging/greybus/gbphy.c               |  1 +
 .../interface/vchiq_arm/vchiq_bus.c           |  1 +
 drivers/tee/tee_core.c                        |  1 +
 drivers/thunderbolt/domain.c                  |  1 +
 drivers/thunderbolt/switch.c                  |  1 +
 drivers/thunderbolt/tb.c                      |  1 +
 drivers/thunderbolt/xdomain.c                 |  1 +
 drivers/tty/tty_io.c                          |  1 +
 drivers/usb/core/driver.c                     |  1 +
 drivers/usb/gadget/udc/core.c                 |  1 +
 drivers/usb/roles/class.c                     |  1 +
 drivers/usb/typec/bus.c                       |  1 +
 drivers/usb/typec/class.c                     |  1 +
 drivers/vdpa/vdpa_user/vduse_dev.c            |  1 +
 drivers/vfio/mdev/mdev_core.c                 |  1 +
 drivers/vfio/mdev/mdev_sysfs.c                |  1 +
 .../fbdev/omap2/omapfb/dss/display-sysfs.c    |  1 +
 .../fbdev/omap2/omapfb/dss/manager-sysfs.c    |  1 +
 drivers/virt/vmgenid.c                        |  1 +
 drivers/xen/xenbus/xenbus_probe_backend.c     |  1 +
 drivers/xen/xenbus/xenbus_probe_frontend.c    |  1 +
 fs/9p/v9fs.c                                  |  1 +
 fs/configfs/mount.c                           |  1 +
 fs/ecryptfs/main.c                            |  1 +
 fs/ext4/super.c                               |  1 +
 fs/ext4/sysfs.c                               |  1 +
 fs/fuse/cuse.c                                |  1 +
 fs/fuse/inode.c                               |  1 +
 fs/namespace.c                                |  1 +
 fs/nfs/client.c                               |  1 +
 fs/ubifs/sysfs.c                              |  1 +
 fs/xfs/xfs_sysfs.h                            |  2 +
 include/linux/cdev.h                          |  2 +-
 include/linux/cpufreq.h                       |  2 +-
 include/linux/device.h                        |  2 +-
 include/linux/irqdesc.h                       |  2 +-
 include/linux/kobject.h                       | 78 +----------------
 include/linux/kobject_types.h                 | 84 +++++++++++++++++++
 include/linux/module.h                        |  2 +-
 include/linux/padata.h                        |  2 +-
 include/linux/pci.h                           |  2 +-
 include/net/netdev_rx_queue.h                 |  2 +-
 include/video/omapfb_dss.h                    |  2 +-
 init/initramfs.c                              |  1 +
 kernel/cgroup/cgroup.c                        |  1 +
 kernel/exit.c                                 |  2 +
 kernel/module/main.c                          |  1 +
 kernel/module/sysfs.c                         |  1 +
 kernel/padata.c                               |  1 +
 kernel/panic.c                                |  1 +
 kernel/params.c                               |  1 +
 kernel/reboot.c                               |  1 +
 mm/damon/sysfs-common.c                       |  1 +
 mm/damon/sysfs-common.h                       |  2 +-
 mm/damon/sysfs-schemes.c                      |  1 +
 mm/damon/sysfs.c                              |  1 +
 mm/huge_memory.c                              |  1 +
 mm/hugetlb.c                                  |  1 +
 mm/khugepaged.c                               |  1 +
 mm/mempolicy.c                                |  1 +
 mm/shmem.c                                    |  1 +
 mm/swap_state.c                               |  1 +
 mm/vmscan.c                                   |  1 +
 net/9p/trans_virtio.c                         |  1 +
 net/bridge/br_sysfs_br.c                      |  1 +
 net/rfkill/core.c                             |  1 +
 net/wireless/reg.c                            |  1 +
 sound/core/init.c                             |  1 +
 sound/hda/hda_bus_type.c                      |  1 +
 sound/hda/hdac_sysfs.c                        |  1 +
 185 files changed, 280 insertions(+), 87 deletions(-)
 create mode 100644 include/linux/kobject_types.h

diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index d30ad1215ab8..d7a9a8bb5d80 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -17,6 +17,7 @@
 #include <linux/elf.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/personality.h>
 #include <linux/preempt.h>
 #include <linux/printk.h>
diff --git a/block/bdev.c b/block/bdev.c
index e9f1b12bd75c..995d575c819a 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -9,6 +9,7 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/kmod.h>
+#include <linux/kobject.h>
 #include <linux/major.h>
 #include <linux/device_cgroup.h>
 #include <linux/blkdev.h>
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 88df08a246fa..fc36ffa488f8 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -117,6 +117,7 @@
 #include <linux/slab.h>
 #include <linux/blkdev.h>
 #include <linux/cgroup.h>
+#include <linux/kobject.h>
 #include <linux/ktime.h>
 #include <linux/rbtree.h>
 #include <linux/ioprio.h>
diff --git a/block/blk-crypto-sysfs.c b/block/blk-crypto-sysfs.c
index 233d04b9116b..67a62b907419 100644
--- a/block/blk-crypto-sysfs.c
+++ b/block/blk-crypto-sysfs.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/blk-crypto-profile.h>
+#include <linux/kobject.h>
 #include <linux/sysfs.h>
 
 #include "blk-crypto-internal.h"
diff --git a/block/blk-ia-ranges.c b/block/blk-ia-ranges.c
index 4a6bb87a0143..75602267fbe7 100644
--- a/block/blk-ia-ranges.c
+++ b/block/blk-ia-ranges.c
@@ -9,6 +9,7 @@
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/init.h>
+#include <linux/kobject.h>
 
 #include "blk.h"
 
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 451a2c1f1f32..6f4a294057d0 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2016 Jens Axboe
  */
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/list_sort.h>
 
diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 156e9bb07abf..88d2220860b1 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -4,6 +4,7 @@
 #include <linux/backing-dev.h>
 #include <linux/bio.h>
 #include <linux/blkdev.h>
+#include <linux/kobject.h>
 #include <linux/mm.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff --git a/block/blk-mq.c b/block/blk-mq.c
index aff9e9492f59..88b5bac815eb 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -12,6 +12,7 @@
 #include <linux/blkdev.h>
 #include <linux/blk-integrity.h>
 #include <linux/kmemleak.h>
+#include <linux/kobject.h>
 #include <linux/mm.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 6b2429cad81a..2dd002780316 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -10,6 +10,7 @@
 #include <linux/backing-dev.h>
 #include <linux/blktrace_api.h>
 #include <linux/debugfs.h>
+#include <linux/kobject.h>
 
 #include "blk.h"
 #include "blk-mq.h"
diff --git a/block/disk-events.c b/block/disk-events.c
index 2f697224386a..e5b3006bcef6 100644
--- a/block/disk-events.c
+++ b/block/disk-events.c
@@ -5,6 +5,7 @@
 #include <linux/export.h>
 #include <linux/moduleparam.h>
 #include <linux/blkdev.h>
+#include <linux/kobject.h>
 #include "blk.h"
 
 struct disk_events {
diff --git a/block/elevator.c b/block/elevator.c
index 5ff093cb3cf8..9aa58cf86ac2 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -35,6 +35,7 @@
 #include <linux/hash.h>
 #include <linux/uaccess.h>
 #include <linux/pm_runtime.h>
+#include <linux/kobject.h>
 
 #include <trace/events/block.h>
 
diff --git a/block/genhd.c b/block/genhd.c
index d74fb5b4ae68..4202ca032195 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -10,6 +10,7 @@
 #include <linux/fs.h>
 #include <linux/kdev_t.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
 #include <linux/init.h>
diff --git a/block/holder.c b/block/holder.c
index a9affd4757cd..fe8d5f707f60 100644
--- a/block/holder.c
+++ b/block/holder.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/blkdev.h>
+#include <linux/kobject.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index 68fe2b6c12de..b46f1d84ad25 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -8,6 +8,7 @@
 
 #include <linux/kernel.h>
 #include <linux/blkdev.h>
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/sbitmap.h>
 #include <linux/sysfs.h>
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 25dee768d2ba..38ea20cee530 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -9,6 +9,7 @@
 #include <linux/fs.h>
 #include <linux/blkdev.h>
 #include <linux/bio.h>
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/init.h>
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 5f5ed5c75f04..e6aad6f5f97f 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2020 Christoph Hellwig
  */
 #include <linux/fs.h>
+#include <linux/kobject.h>
 #include <linux/major.h>
 #include <linux/slab.h>
 #include <linux/ctype.h>
diff --git a/drivers/accessibility/speakup/speakup_acntpc.c b/drivers/accessibility/speakup/speakup_acntpc.c
index a27e6bbf05da..1b348204e396 100644
--- a/drivers/accessibility/speakup/speakup_acntpc.c
+++ b/drivers/accessibility/speakup/speakup_acntpc.c
@@ -14,6 +14,7 @@
 #include <linux/jiffies.h>
 #include <linux/sched.h>
 #include <linux/timer.h>
+#include <linux/kobject.h>
 #include <linux/kthread.h>
 
 #include "spk_priv.h"
diff --git a/drivers/accessibility/speakup/speakup_acntsa.c b/drivers/accessibility/speakup/speakup_acntsa.c
index 26bb9f9399d3..fc2e6ff9167c 100644
--- a/drivers/accessibility/speakup/speakup_acntsa.c
+++ b/drivers/accessibility/speakup/speakup_acntsa.c
@@ -14,6 +14,8 @@
 #include "speakup.h"
 #include "speakup_acnt.h" /* local header file for Accent values */
 
+#include <linux/kobject.h>
+
 #define DRV_VERSION "2.11"
 #define PROCSPEECH '\r'
 
diff --git a/drivers/accessibility/speakup/speakup_apollo.c b/drivers/accessibility/speakup/speakup_apollo.c
index d2fbb3f57221..2d9b39b85d04 100644
--- a/drivers/accessibility/speakup/speakup_apollo.c
+++ b/drivers/accessibility/speakup/speakup_apollo.c
@@ -12,6 +12,7 @@
 #include <linux/jiffies.h>
 #include <linux/sched.h>
 #include <linux/timer.h>
+#include <linux/kobject.h>
 #include <linux/kthread.h>
 #include <linux/serial_reg.h>	/* for UART_MCR* constants */
 
diff --git a/drivers/accessibility/speakup/speakup_audptr.c b/drivers/accessibility/speakup/speakup_audptr.c
index 55813f3e40ff..d73001b90b5e 100644
--- a/drivers/accessibility/speakup/speakup_audptr.c
+++ b/drivers/accessibility/speakup/speakup_audptr.c
@@ -12,6 +12,8 @@
 #include "spk_priv.h"
 #include "speakup.h"
 
+#include <linux/kobject.h>
+
 #define DRV_VERSION "2.11"
 #define SYNTH_CLEAR 0x18 /* flush synth buffer */
 #define PROCSPEECH '\r' /* start synth processing speech char */
diff --git a/drivers/accessibility/speakup/speakup_bns.c b/drivers/accessibility/speakup/speakup_bns.c
index 60507756499c..c5802637f723 100644
--- a/drivers/accessibility/speakup/speakup_bns.c
+++ b/drivers/accessibility/speakup/speakup_bns.c
@@ -12,6 +12,8 @@
 #include "spk_priv.h"
 #include "speakup.h"
 
+#include <linux/kobject.h>
+
 #define DRV_VERSION "2.11"
 #define SYNTH_CLEAR 0x18
 #define PROCSPEECH '\r'
diff --git a/drivers/accessibility/speakup/speakup_decext.c b/drivers/accessibility/speakup/speakup_decext.c
index 271bcf279bf9..41ece15f408b 100644
--- a/drivers/accessibility/speakup/speakup_decext.c
+++ b/drivers/accessibility/speakup/speakup_decext.c
@@ -12,6 +12,7 @@
 #include <linux/jiffies.h>
 #include <linux/sched.h>
 #include <linux/timer.h>
+#include <linux/kobject.h>
 #include <linux/kthread.h>
 
 #include "spk_priv.h"
diff --git a/drivers/accessibility/speakup/speakup_decpc.c b/drivers/accessibility/speakup/speakup_decpc.c
index 083ca9265805..5b539641aa62 100644
--- a/drivers/accessibility/speakup/speakup_decpc.c
+++ b/drivers/accessibility/speakup/speakup_decpc.c
@@ -19,6 +19,7 @@
 #include <linux/jiffies.h>
 #include <linux/sched.h>
 #include <linux/timer.h>
+#include <linux/kobject.h>
 #include <linux/kthread.h>
 
 #include "spk_priv.h"
diff --git a/drivers/accessibility/speakup/speakup_dectlk.c b/drivers/accessibility/speakup/speakup_dectlk.c
index 56334405d865..859fd7c7a878 100644
--- a/drivers/accessibility/speakup/speakup_dectlk.c
+++ b/drivers/accessibility/speakup/speakup_dectlk.c
@@ -15,6 +15,7 @@
 #include <linux/spinlock.h>
 #include <linux/sched.h>
 #include <linux/timer.h>
+#include <linux/kobject.h>
 #include <linux/kthread.h>
 #include "speakup.h"
 #include "spk_priv.h"
diff --git a/drivers/accessibility/speakup/speakup_dtlk.c b/drivers/accessibility/speakup/speakup_dtlk.c
index fa826568937b..d47274678e73 100644
--- a/drivers/accessibility/speakup/speakup_dtlk.c
+++ b/drivers/accessibility/speakup/speakup_dtlk.c
@@ -13,6 +13,7 @@
 #include <linux/jiffies.h>
 #include <linux/sched.h>
 #include <linux/timer.h>
+#include <linux/kobject.h>
 #include <linux/kthread.h>
 
 #include "spk_priv.h"
diff --git a/drivers/accessibility/speakup/speakup_dummy.c b/drivers/accessibility/speakup/speakup_dummy.c
index 52b2c5d44576..0e11bebb8db0 100644
--- a/drivers/accessibility/speakup/speakup_dummy.c
+++ b/drivers/accessibility/speakup/speakup_dummy.c
@@ -14,6 +14,8 @@
 #include "spk_priv.h"
 #include "speakup.h"
 
+#include <linux/kobject.h>
+
 #define PROCSPEECH '\n'
 #define DRV_VERSION "2.11"
 #define SYNTH_CLEAR '!'
diff --git a/drivers/accessibility/speakup/speakup_keypc.c b/drivers/accessibility/speakup/speakup_keypc.c
index 9356f6379560..d5ff75843f74 100644
--- a/drivers/accessibility/speakup/speakup_keypc.c
+++ b/drivers/accessibility/speakup/speakup_keypc.c
@@ -11,6 +11,7 @@
 #include <linux/jiffies.h>
 #include <linux/sched.h>
 #include <linux/timer.h>
+#include <linux/kobject.h>
 #include <linux/kthread.h>
 #include <linux/serial_reg.h>
 
diff --git a/drivers/accessibility/speakup/speakup_ltlk.c b/drivers/accessibility/speakup/speakup_ltlk.c
index 1e279ae143bf..f1806c86ea6b 100644
--- a/drivers/accessibility/speakup/speakup_ltlk.c
+++ b/drivers/accessibility/speakup/speakup_ltlk.c
@@ -13,6 +13,8 @@
 #include "spk_priv.h"
 #include "speakup_dtlk.h" /* local header file for LiteTalk values */
 
+#include <linux/kobject.h>
+
 #define DRV_VERSION "2.11"
 #define PROCSPEECH 0x0d
 
diff --git a/drivers/accessibility/speakup/speakup_soft.c b/drivers/accessibility/speakup/speakup_soft.c
index 6d446824677b..48e0fab55682 100644
--- a/drivers/accessibility/speakup/speakup_soft.c
+++ b/drivers/accessibility/speakup/speakup_soft.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/unistd.h>
+#include <linux/kobject.h>
 #include <linux/miscdevice.h>	/* for misc_register, and MISC_DYNAMIC_MINOR */
 #include <linux/poll.h>		/* for poll_wait() */
 
diff --git a/drivers/accessibility/speakup/speakup_spkout.c b/drivers/accessibility/speakup/speakup_spkout.c
index d3f26095b0ee..2929c5b6236a 100644
--- a/drivers/accessibility/speakup/speakup_spkout.c
+++ b/drivers/accessibility/speakup/speakup_spkout.c
@@ -12,6 +12,8 @@
 #include "spk_priv.h"
 #include "speakup.h"
 
+#include <linux/kobject.h>
+
 #define DRV_VERSION "2.11"
 #define SYNTH_CLEAR 0x18
 #define PROCSPEECH '\r'
diff --git a/drivers/accessibility/speakup/speakup_txprt.c b/drivers/accessibility/speakup/speakup_txprt.c
index 4d0a0d4c41f0..361d6cd6ba75 100644
--- a/drivers/accessibility/speakup/speakup_txprt.c
+++ b/drivers/accessibility/speakup/speakup_txprt.c
@@ -12,6 +12,8 @@
 #include "spk_priv.h"
 #include "speakup.h"
 
+#include <linux/kobject.h>
+
 #define DRV_VERSION "2.11"
 #define SYNTH_CLEAR 0x18
 #define PROCSPEECH '\r' /* process speech char */
diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 2d4a35e6dd18..3c500e4bec6d 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -9,6 +9,7 @@
 #define pr_fmt(fmt) "ACPI: AC: " fmt
 
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/init.h>
diff --git a/drivers/acpi/acpi_fpdt.c b/drivers/acpi/acpi_fpdt.c
index 271092f2700a..e4a73eb0cb66 100644
--- a/drivers/acpi/acpi_fpdt.c
+++ b/drivers/acpi/acpi_fpdt.c
@@ -9,6 +9,7 @@
 #define pr_fmt(fmt) "ACPI FPDT: " fmt
 
 #include <linux/acpi.h>
+#include <linux/kobject.h>
 
 /*
  * FPDT contains ACPI table header and a number of fpdt_subtable_entries.
diff --git a/drivers/acpi/bgrt.c b/drivers/acpi/bgrt.c
index e4fb9e225ddf..f7936665160f 100644
--- a/drivers/acpi/bgrt.c
+++ b/drivers/acpi/bgrt.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/sysfs.h>
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 569bd15f211b..2824ee35d5b9 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/list.h>
 #include <linux/sched.h>
 #include <linux/pm.h>
diff --git a/drivers/acpi/container.c b/drivers/acpi/container.c
index 5b7e3b9ae370..5ee7b4aadb1e 100644
--- a/drivers/acpi/container.c
+++ b/drivers/acpi/container.c
@@ -11,6 +11,7 @@
  */
 #include <linux/acpi.h>
 #include <linux/container.h>
+#include <linux/kobject.h>
 
 #include "internal.h"
 
diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index 23373faa35ec..0855833166a1 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -14,6 +14,7 @@
 #include <linux/acpi.h>
 #include <linux/device.h>
 #include <linux/export.h>
+#include <linux/kobject.h>
 #include <linux/nls.h>
 
 #include "internal.h"
diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index a89bdbe00184..4586f9d10868 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/moduleparam.h>
 #include <linux/slab.h>
 #include <linux/init.h>
diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 687524b50085..852a4b80ce04 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -9,6 +9,7 @@
 #include <linux/bitmap.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/kstrtox.h>
 #include <linux/moduleparam.h>
 
diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index d36e71f475ab..a8130c6edaa7 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -13,6 +13,7 @@
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/acpi.h>
 #include <linux/libata.h>
 #include <linux/pci.h>
diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index 7e2d1f0d903a..7fb7ecd270c4 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -6,6 +6,7 @@
  * Author: Johannes Berg <johannes@sipsolutions.net>
  */
 #include <linux/module.h>
+#include <linux/kobject.h>
 #include <linux/device.h>
 #include <linux/devcoredump.h>
 #include <linux/list.h>
diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index 3ef0b312ae71..2f5f613fbd1e 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -6,6 +6,7 @@
 #include <linux/security.h>
 #include <linux/umh.h>
 #include <linux/sysctl.h>
+#include <linux/kobject.h>
 #include <linux/module.h>
 
 #include "fallback.h"
diff --git a/drivers/base/firmware_loader/sysfs.c b/drivers/base/firmware_loader/sysfs.c
index c9c93b47d9a5..895943a20c04 100644
--- a/drivers/base/firmware_loader/sysfs.c
+++ b/drivers/base/firmware_loader/sysfs.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/highmem.h>
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/security.h>
 #include <linux/slab.h>
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 43747a1aae43..3d20b724f762 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -28,6 +28,7 @@
 #include <asm/unaligned.h>
 #include <linux/drbd_limits.h>
 #include <linux/kthread.h>
+#include <linux/kobject.h>
 
 #include <net/genetlink.h>
 
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index f8145499da38..77be516ee6f8 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -4,6 +4,7 @@
  */
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/kobject.h>
 #include <linux/sched.h>
 #include <linux/fs.h>
 #include <linux/pagemap.h>
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 33a8f37bb6a1..2df76356d74a 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -38,6 +38,7 @@
 #include <linux/types.h>
 #include <linux/debugfs.h>
 #include <linux/blk-mq.h>
+#include <linux/kobject.h>
 
 #include <linux/uaccess.h>
 #include <asm/types.h>
diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnbd-clt-sysfs.c
index 39887556cf95..8d11b2e563b9 100644
--- a/drivers/block/rnbd/rnbd-clt-sysfs.c
+++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
@@ -18,6 +18,7 @@
 #include <linux/fs.h>
 #include <linux/uaccess.h>
 #include <linux/device.h>
+#include <linux/kobject.h>
 #include <rdma/ib.h>
 #include <rdma/rdma_cm.h>
 
diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 4044c369d22a..8a67a173b744 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/blkdev.h>
 #include <linux/hdreg.h>
+#include <linux/kobject.h>
 #include <linux/scatterlist.h>
 #include <linux/idr.h>
 
diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 3a0d5dcec6f2..3b88036cbc77 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -11,6 +11,7 @@
 
 #include <linux/module.h>
 #include <linux/blkdev.h>
+#include <linux/kobject.h>
 
 #include "rnbd-srv.h"
 #include "rnbd-srv-trace.h"
diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 1dfb2e77898b..dca6fa1063ef 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -43,6 +43,7 @@
 #include <asm/page.h>
 #include <linux/task_work.h>
 #include <linux/namei.h>
+#include <linux/kobject.h>
 #include <linux/kref.h>
 #include <uapi/linux/ublk_cmd.h>
 
diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index e358d192f0d8..2c3926b51e18 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -13,6 +13,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/kobject.h>
 #include <linux/mhi_ep.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
index 6d3b045ab259..e9f74e1af4d2 100644
--- a/drivers/bus/mhi/host/init.c
+++ b/drivers/bus/mhi/host/init.c
@@ -12,6 +12,7 @@
 #include <linux/idr.h>
 #include <linux/interrupt.h>
 #include <linux/list.h>
+#include <linux/kobject.h>
 #include <linux/mhi.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 035f89f1a251..f1c5aa63260b 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -26,6 +26,7 @@
 #include <linux/workqueue.h>
 #include <linux/module.h>
 #include <linux/dma-mapping.h>
+#include <linux/kobject.h>
 #include "../tty/hvc/hvc_console.h"
 
 #define is_rproc_enabled IS_ENABLED(CONFIG_REMOTEPROC)
diff --git a/drivers/char/xillybus/xillybus_class.c b/drivers/char/xillybus/xillybus_class.c
index c92a628e389e..62bbdd3ed2fe 100644
--- a/drivers/char/xillybus/xillybus_class.c
+++ b/drivers/char/xillybus/xillybus_class.c
@@ -11,6 +11,7 @@
 #include <linux/fs.h>
 #include <linux/cdev.h>
 #include <linux/slab.h>
+#include <linux/kobject.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
 
diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
index 469560b7aba6..d15caee0504e 100644
--- a/drivers/comedi/comedi_fops.c
+++ b/drivers/comedi/comedi_fops.c
@@ -25,6 +25,7 @@
 #include <linux/fs.h>
 #include <linux/comedi/comedidev.h>
 #include <linux/cdev.h>
+#include <linux/kobject.h>
 #include <linux/kref.h>
 
 #include <linux/io.h>
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index e59d9d37aa65..abfd43666e60 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
 #include <linux/platform_device.h>
+#include <linux/kobject.h>
 #include <linux/memregion.h>
 #include <linux/workqueue.h>
 #include <linux/debugfs.h>
diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 7a54bca555c4..5c90dd345d65 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -7,6 +7,7 @@
 #include <linux/slab.h>
 #include <linux/dax.h>
 #include <linux/io.h>
+#include <linux/kobject.h>
 #include <linux/kref.h>
 #include "dax-private.h"
 #include "bus.h"
diff --git a/drivers/dma/qcom/hidma_mgmt_sys.c b/drivers/dma/qcom/hidma_mgmt_sys.c
index 930eae0a6257..4ea5bdfc4b3a 100644
--- a/drivers/dma/qcom/hidma_mgmt_sys.c
+++ b/drivers/dma/qcom/hidma_mgmt_sys.c
@@ -7,6 +7,7 @@
 
 #include <linux/sysfs.h>
 #include <linux/platform_device.h>
+#include <linux/kobject.h>
 
 #include "hidma_mgmt.h"
 
diff --git a/drivers/firmware/arm_ffa/bus.c b/drivers/firmware/arm_ffa/bus.c
index 50914dd5afd6..3795fa0bfb01 100644
--- a/drivers/firmware/arm_ffa/bus.c
+++ b/drivers/firmware/arm_ffa/bus.c
@@ -10,6 +10,7 @@
 #include <linux/fs.h>
 #include <linux/idr.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/types.h>
diff --git a/drivers/firmware/dmi-id.c b/drivers/firmware/dmi-id.c
index 5f3a3e913d28..72ac916e8e34 100644
--- a/drivers/firmware/dmi-id.c
+++ b/drivers/firmware/dmi-id.c
@@ -7,6 +7,7 @@
 
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/init.h>
 #include <linux/dmi.h>
 #include <linux/device.h>
diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
index 015c95a825d3..cef3b638c23b 100644
--- a/drivers/firmware/dmi_scan.c
+++ b/drivers/firmware/dmi_scan.c
@@ -2,6 +2,7 @@
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/init.h>
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/ctype.h>
 #include <linux/dmi.h>
diff --git a/drivers/firmware/memmap.c b/drivers/firmware/memmap.c
index 8e59be3782cb..a92d17c6fc0f 100644
--- a/drivers/firmware/memmap.c
+++ b/drivers/firmware/memmap.c
@@ -8,6 +8,7 @@
 #include <linux/string.h>
 #include <linux/firmware-map.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/memblock.h>
diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
index 5f43dfa22f79..dbca29ceb504 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -34,6 +34,7 @@
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
+#include <linux/kobject.h>
 #include <uapi/linux/qemu_fw_cfg.h>
 #include <linux/delay.h>
 #include <linux/crash_dump.h>
diff --git a/drivers/gnss/core.c b/drivers/gnss/core.c
index 48f2ee0f78c4..24b914fb0581 100644
--- a/drivers/gnss/core.c
+++ b/drivers/gnss/core.c
@@ -14,6 +14,7 @@
 #include <linux/idr.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/poll.h>
 #include <linux/slab.h>
diff --git a/drivers/greybus/core.c b/drivers/greybus/core.c
index 5714be740470..6ec29875fcfd 100644
--- a/drivers/greybus/core.c
+++ b/drivers/greybus/core.c
@@ -10,6 +10,7 @@
 
 #define CREATE_TRACE_POINTS
 #include <linux/greybus.h>
+#include <linux/kobject.h>
 #include "greybus_trace.h"
 
 #define GB_BUNDLE_AUTOSUSPEND_MS	3000
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index d429bc5cc183..a7f16517cc1c 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/mm.h>
diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index 26167cfb696f..ca1a4101b2d0 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -11,6 +11,7 @@
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/input.h>
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 157de6bdd639..660dd3edeb62 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -6,6 +6,7 @@
 #include "wacom_wac.h"
 #include "wacom.h"
 #include <linux/input/mt.h>
+#include <linux/kobject.h>
 #include <linux/kref.h>
 
 #define WAC_MSG_RETRIES		5
diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index 703666b95bf4..33fe78a620f7 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -18,6 +18,7 @@
 #include <linux/time.h>
 #include <linux/err.h>
 #include <linux/acpi.h>
+#include <linux/kobject.h>
 
 #define ACPI_POWER_METER_NAME		"power_meter"
 #define ACPI_POWER_METER_DEVICE_NAME	"Power Meter"
diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index 534fbefc7f6a..b7563efeabf6 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -10,6 +10,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/uaccess.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/compat.h>
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index cd2599f49168..a067ee0439d9 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -35,6 +35,7 @@
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/kref.h>
 #include <linux/slab.h>
 #include <linux/init.h>
diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index 9f97bef02149..e43f72567d51 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -39,6 +39,7 @@
 #include <linux/string.h>
 #include <linux/netdevice.h>
 #include <linux/ethtool.h>
+#include <linux/kobject.h>
 
 #include <rdma/ib_mad.h>
 #include <rdma/ib_pma.h>
diff --git a/drivers/infiniband/hw/mlx4/sysfs.c b/drivers/infiniband/hw/mlx4/sysfs.c
index 88f534cf690e..d45d2bd1995f 100644
--- a/drivers/infiniband/hw/mlx4/sysfs.c
+++ b/drivers/infiniband/hw/mlx4/sysfs.c
@@ -32,6 +32,7 @@
 
 /*#include "core_priv.h"*/
 #include "mlx4_ib.h"
+#include <linux/kobject.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/stat.h>
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
index d3c436ead694..1cc12c3bda71 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
@@ -13,6 +13,8 @@
 #include "rtrs-clt.h"
 #include "rtrs-log.h"
 
+#include <linux/kobject.h>
+
 #define MIN_MAX_RECONN_ATT -1
 #define MAX_MAX_RECONN_ATT 9999
 
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 79dcbfad93c0..1fdc0a3a9aa5 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -10,6 +10,7 @@
 #undef pr_fmt
 #define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt
 
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/rculist.h>
 #include <linux/random.h>
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
index 3f305e694fe8..60c7dc4e6e61 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
@@ -13,6 +13,8 @@
 #include "rtrs-srv.h"
 #include "rtrs-log.h"
 
+#include <linux/kobject.h>
+
 static void rtrs_srv_release(struct kobject *kobj)
 {
 	struct rtrs_srv_path *srv_path;
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 1d33efb8fb03..015e77e82177 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -10,6 +10,7 @@
 #undef pr_fmt
 #define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt
 
+#include <linux/kobject.h>
 #include <linux/module.h>
 
 #include "rtrs-srv.h"
diff --git a/drivers/input/input.c b/drivers/input/input.c
index de7884a5be39..715daa05becb 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -22,6 +22,7 @@
 #include <linux/pm.h>
 #include <linux/poll.h>
 #include <linux/device.h>
+#include <linux/kobject.h>
 #include <linux/kstrtox.h>
 #include <linux/mutex.h>
 #include <linux/rcupdate.h>
diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
index 767fc9efb4a8..345e78f69ffe 100644
--- a/drivers/input/serio/serio.c
+++ b/drivers/input/serio/serio.c
@@ -10,6 +10,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/stddef.h>
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/serio.h>
 #include <linux/errno.h>
diff --git a/drivers/ipack/ipack.c b/drivers/ipack/ipack.c
index b1471ba016a5..377b86a78155 100644
--- a/drivers/ipack/ipack.c
+++ b/drivers/ipack/ipack.c
@@ -11,6 +11,7 @@
 #include <linux/idr.h>
 #include <linux/io.h>
 #include <linux/ipack.h>
+#include <linux/kobject.h>
 
 #define to_ipack_dev(device) container_of(device, struct ipack_device, dev)
 #define to_ipack_driver(drv) container_of(drv, struct ipack_driver, driver)
diff --git a/drivers/isdn/mISDN/core.c b/drivers/isdn/mISDN/core.c
index c829c4eac0e2..caf593b8af78 100644
--- a/drivers/isdn/mISDN/core.c
+++ b/drivers/isdn/mISDN/core.c
@@ -6,6 +6,7 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/stddef.h>
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/spinlock.h>
 #include <linux/mISDNif.h>
diff --git a/drivers/leds/led-triggers.c b/drivers/leds/led-triggers.c
index bd59a14a4a90..3cd5719ac2a9 100644
--- a/drivers/leds/led-triggers.c
+++ b/drivers/leds/led-triggers.c
@@ -9,6 +9,7 @@
 
 #include <linux/export.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/device.h>
diff --git a/drivers/mcb/mcb-core.c b/drivers/mcb/mcb-core.c
index 61994da7bad0..b2f484818c12 100644
--- a/drivers/mcb/mcb-core.c
+++ b/drivers/mcb/mcb-core.c
@@ -6,6 +6,7 @@
  * Author: Johannes Thumshirn <johannes.thumshirn@men.de>
  */
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/types.h>
diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index 14e58ae70521..c56c3a3871e0 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -17,6 +17,7 @@
 #include "dm-verity-fec.h"
 #include "dm-verity-verify-sig.h"
 #include "dm-audit.h"
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/reboot.h>
 #include <linux/scatterlist.h>
diff --git a/drivers/media/cec/core/cec-core.c b/drivers/media/cec/core/cec-core.c
index 7e153c5cad04..dcd171fc3923 100644
--- a/drivers/media/cec/core/cec-core.c
+++ b/drivers/media/cec/core/cec-core.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/kmod.h>
+#include <linux/kobject.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
 #include <linux/string.h>
diff --git a/drivers/media/mc/mc-devnode.c b/drivers/media/mc/mc-devnode.c
index 9c8fe9335dc1..e3cb51595fb2 100644
--- a/drivers/media/mc/mc-devnode.c
+++ b/drivers/media/mc/mc-devnode.c
@@ -25,6 +25,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/kmod.h>
+#include <linux/kobject.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
 #include <linux/string.h>
diff --git a/drivers/media/rc/rc-main.c b/drivers/media/rc/rc-main.c
index 6bdad6341844..197a4c9f4214 100644
--- a/drivers/media/rc/rc-main.c
+++ b/drivers/media/rc/rc-main.c
@@ -15,6 +15,7 @@
 #include <linux/idr.h>
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/kobject.h>
 #include "rc-core-priv.h"
 
 /* Sizes are in bytes, 256 bytes allows for 32 entries on x64 */
diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
index bbfaf6536903..15ff608c934b 100644
--- a/drivers/memstick/core/memstick.c
+++ b/drivers/memstick/core/memstick.c
@@ -13,6 +13,7 @@
 #include <linux/fs.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
 
diff --git a/drivers/misc/ti-st/st_kim.c b/drivers/misc/ti-st/st_kim.c
index 4b1be0bb6ac0..899f3723e317 100644
--- a/drivers/misc/ti-st/st_kim.c
+++ b/drivers/misc/ti-st/st_kim.c
@@ -19,6 +19,7 @@
 #include <linux/sched.h>
 #include <linux/sysfs.h>
 #include <linux/tty.h>
+#include <linux/kobject.h>
 
 #include <linux/skbuff.h>
 #include <linux/ti_wilink_st.h>
diff --git a/drivers/misc/tifm_core.c b/drivers/misc/tifm_core.c
index eee9b6581604..25812dfde277 100644
--- a/drivers/misc/tifm_core.c
+++ b/drivers/misc/tifm_core.c
@@ -7,6 +7,7 @@
 
 #include <linux/tifm.h>
 #include <linux/slab.h>
+#include <linux/kobject.h>
 #include <linux/init.h>
 #include <linux/idr.h>
 #include <linux/module.h>
diff --git a/drivers/most/most_cdev.c b/drivers/most/most_cdev.c
index 3ed8f461e01e..d106ac4879cb 100644
--- a/drivers/most/most_cdev.c
+++ b/drivers/most/most_cdev.c
@@ -13,6 +13,7 @@
 #include <linux/cdev.h>
 #include <linux/poll.h>
 #include <linux/kfifo.h>
+#include <linux/kobject.h>
 #include <linux/uaccess.h>
 #include <linux/idr.h>
 #include <linux/most.h>
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 4e0600c7b050..27b5a9ef70d4 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -33,6 +33,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/fcntl.h>
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_minidump.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_minidump.c
index 7ecb3dfe30bd..cf1038e15c1a 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_minidump.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_minidump.c
@@ -11,6 +11,8 @@
 #include "qlcnic_83xx_hw.h"
 #include "qlcnic_hw.h"
 
+#include <linux/kobject.h>
+
 #define QLC_83XX_MINIDUMP_FLASH		0x520000
 #define QLC_83XX_OCM_INDEX			3
 #define QLC_83XX_PCI_INDEX			0
diff --git a/drivers/net/wireless/ath/wil6210/interrupt.c b/drivers/net/wireless/ath/wil6210/interrupt.c
index 67172385a5d6..831bf61b6e35 100644
--- a/drivers/net/wireless/ath/wil6210/interrupt.c
+++ b/drivers/net/wireless/ath/wil6210/interrupt.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/interrupt.h>
+#include <linux/kobject.h>
 
 #include "wil6210.h"
 #include "trace.h"
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 63e13577aff8..14648c9c5d7d 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -11,6 +11,7 @@
 #include <linux/bitops.h>
 #include <linux/gfp.h>
 #include <linux/vmalloc.h>
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/wait.h>
 #include <linux/seq_file.h>
diff --git a/drivers/net/xen-netback/xenbus.c b/drivers/net/xen-netback/xenbus.c
index a78a25b87240..c226915dd72b 100644
--- a/drivers/net/xen-netback/xenbus.c
+++ b/drivers/net/xen-netback/xenbus.c
@@ -9,6 +9,7 @@
 #include "common.h"
 #include <linux/vmalloc.h>
 #include <linux/rtnetlink.h>
+#include <linux/kobject.h>
 
 static int connect_data_rings(struct backend_info *be,
 			      struct xenvif_queue *queue);
diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index ef3d0f83318b..1d9e7ff22cdc 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -19,6 +19,7 @@
 #include <linux/io.h>
 #include <linux/mm.h>
 #include <linux/nd.h>
+#include <linux/kobject.h>
 #include "nd-core.h"
 #include "nd.h"
 #include "pfn.h"
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 85ab0fcf9e88..5af4ead71a29 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -12,6 +12,7 @@
 #include <linux/errno.h>
 #include <linux/hdreg.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/backing-dev.h>
 #include <linux/slab.h>
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 16847a316421..ff144e1d854b 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -17,6 +17,7 @@
 #include "fc.h"
 #include <scsi/scsi_transport_fc.h>
 #include <linux/blk-mq-pci.h>
+#include <linux/kobject.h>
 
 /* *************************** Data Structures/Defines ****************** */
 
diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
index afa50b446567..5893d33878ca 100644
--- a/drivers/pci/host-bridge.c
+++ b/drivers/pci/host-bridge.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/pci.h>
 #include <linux/module.h>
 
diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index aaa33e8dc4c9..36c595e0b733 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -9,6 +9,7 @@
 
 #include <linux/pci.h>
 #include <linux/slab.h>
+#include <linux/kobject.h>
 #include <linux/export.h>
 #include <linux/string.h>
 #include <linux/delay.h>
diff --git a/drivers/pcmcia/cs.c b/drivers/pcmcia/cs.c
index b33be1e63c98..858c8ed73655 100644
--- a/drivers/pcmcia/cs.c
+++ b/drivers/pcmcia/cs.c
@@ -13,6 +13,7 @@
 #include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/string.h>
 #include <linux/major.h>
 #include <linux/errno.h>
diff --git a/drivers/pcmcia/ds.c b/drivers/pcmcia/ds.c
index b4b8363d1de2..12b4ad3d37d4 100644
--- a/drivers/pcmcia/ds.c
+++ b/drivers/pcmcia/ds.c
@@ -19,6 +19,7 @@
 #include <linux/workqueue.h>
 #include <linux/crc32.h>
 #include <linux/firmware.h>
+#include <linux/kobject.h>
 #include <linux/kref.h>
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
diff --git a/drivers/platform/surface/aggregator/bus.c b/drivers/platform/surface/aggregator/bus.c
index 118caa651bec..ffbecf4160ea 100644
--- a/drivers/platform/surface/aggregator/bus.c
+++ b/drivers/platform/surface/aggregator/bus.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/device.h>
+#include <linux/kobject.h>
 #include <linux/property.h>
 #include <linux/slab.h>
 
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 977611e16373..86fb1807e889 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -12,6 +12,7 @@
 
 #include <linux/ctype.h>
 #include <linux/device.h>
+#include <linux/kobject.h>
 #include <linux/power_supply.h>
 #include <linux/slab.h>
 #include <linux/stat.h>
diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
index a689fd42ccaa..02db9c69df9e 100644
--- a/drivers/pps/pps.c
+++ b/drivers/pps/pps.c
@@ -8,6 +8,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/sched.h>
diff --git a/drivers/rapidio/rio-driver.c b/drivers/rapidio/rio-driver.c
index 1b3b4c2e015d..b3a687983de4 100644
--- a/drivers/rapidio/rio-driver.c
+++ b/drivers/rapidio/rio-driver.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/rio.h>
 #include <linux/rio_ids.h>
diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index 3819f7c42788..b06e21cdd384 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -45,6 +45,7 @@
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/ioport.h>
diff --git a/drivers/scsi/iscsi_boot_sysfs.c b/drivers/scsi/iscsi_boot_sysfs.c
index a64abe38db2d..03a8b98bf819 100644
--- a/drivers/scsi/iscsi_boot_sysfs.c
+++ b/drivers/scsi/iscsi_boot_sysfs.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/kobject.h>
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
diff --git a/drivers/scsi/qedf/qedf_dbg.c b/drivers/scsi/qedf/qedf_dbg.c
index 0d2aed82882a..476e10ffdd66 100644
--- a/drivers/scsi/qedf/qedf_dbg.c
+++ b/drivers/scsi/qedf/qedf_dbg.c
@@ -4,6 +4,7 @@
  *  Copyright (c) 2016-2018 Cavium Inc.
  */
 #include "qedf_dbg.h"
+#include <linux/kobject.h>
 #include <linux/vmalloc.h>
 
 void
diff --git a/drivers/scsi/qla4xxx/ql4_nx.c b/drivers/scsi/qla4xxx/ql4_nx.c
index 47adff9f0506..8d6974ee2bc7 100644
--- a/drivers/scsi/qla4xxx/ql4_nx.c
+++ b/drivers/scsi/qla4xxx/ql4_nx.c
@@ -5,6 +5,7 @@
  */
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/kobject.h>
 #include <linux/pci.h>
 #include <linux/ratelimit.h>
 #include "ql4_def.h"
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index c095ea928847..f711b3a5fe3c 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -14,6 +14,7 @@
 #include <linux/blkdev.h>
 #include <linux/completion.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/export.h>
 #include <linux/init.h>
 #include <linux/pci.h>
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index dbd5e097a1fd..99fe53486ce0 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -14,6 +14,7 @@
 #include <linux/device.h>
 #include <linux/pm_runtime.h>
 #include <linux/bsg.h>
+#include <linux/kobject.h>
 #include <linux/kref.h>
 
 #include <scsi/scsi.h>
diff --git a/drivers/scsi/ses.c b/drivers/scsi/ses.c
index 0f2c87cc95e6..6e9bc4c675ae 100644
--- a/drivers/scsi/ses.c
+++ b/drivers/scsi/ses.c
@@ -8,6 +8,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/enclosure.h>
 #include <asm/unaligned.h>
 
diff --git a/drivers/staging/fieldbus/dev_core.c b/drivers/staging/fieldbus/dev_core.c
index 370a229443a1..4edf1feb3a44 100644
--- a/drivers/staging/fieldbus/dev_core.c
+++ b/drivers/staging/fieldbus/dev_core.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/idr.h>
+#include <linux/kobject.h>
 #include <linux/fs.h>
 #include <linux/slab.h>
 #include <linux/poll.h>
diff --git a/drivers/staging/greybus/gbphy.c b/drivers/staging/greybus/gbphy.c
index d827f03f5253..32dd32020124 100644
--- a/drivers/staging/greybus/gbphy.c
+++ b/drivers/staging/greybus/gbphy.c
@@ -11,6 +11,7 @@
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/slab.h>
 #include <linux/device.h>
 #include <linux/greybus.h>
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.c
index 933027e0011e..d6b84a5d8e80 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.c
@@ -7,6 +7,7 @@
 
 #include <linux/device/bus.h>
 #include <linux/dma-mapping.h>
+#include <linux/kobject.h>
 #include <linux/of_device.h>
 #include <linux/slab.h>
 #include <linux/string.h>
diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 792d6fae4354..98c409cb42e7 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -9,6 +9,7 @@
 #include <linux/cred.h>
 #include <linux/fs.h>
 #include <linux/idr.h>
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/tee_drv.h>
diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
index ee8a894bd70d..3d1855ae627e 100644
--- a/drivers/thunderbolt/domain.c
+++ b/drivers/thunderbolt/domain.c
@@ -8,6 +8,7 @@
 
 #include <linux/device.h>
 #include <linux/idr.h>
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index bca6f28c553b..a44543e15ba8 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -8,6 +8,7 @@
 
 #include <linux/delay.h>
 #include <linux/idr.h>
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/nvmem-provider.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 9a261560d0f4..2455d51e76a4 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -11,6 +11,7 @@
 #include <linux/delay.h>
 #include <linux/pm_runtime.h>
 #include <linux/platform_data/x86/apple.h>
+#include <linux/kobject.h>
 
 #include "tb.h"
 #include "tb_regs.h"
diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index b48df88981bd..7c0a8744771d 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -10,6 +10,7 @@
 #include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/kmod.h>
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/prandom.h>
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 407b0d87b7c1..c823939b2689 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -83,6 +83,7 @@
 #include <linux/timer.h>
 #include <linux/ctype.h>
 #include <linux/kd.h>
+#include <linux/kobject.h>
 #include <linux/mm.h>
 #include <linux/string.h>
 #include <linux/slab.h>
diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index e02ba15f6e34..0cee73f8d326 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -31,6 +31,7 @@
 #include <linux/usb.h>
 #include <linux/usb/quirks.h>
 #include <linux/usb/hcd.h>
+#include <linux/kobject.h>
 
 #include "usb.h"
 
diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index d59f94464b87..76ff62c42959 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -9,6 +9,7 @@
 #define pr_fmt(fmt)	"UDC core: " fmt
 
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/list.h>
diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
index ae41578bd014..7e20cb977804 100644
--- a/drivers/usb/roles/class.c
+++ b/drivers/usb/roles/class.c
@@ -10,6 +10,7 @@
 #include <linux/usb/role.h>
 #include <linux/property.h>
 #include <linux/device.h>
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
diff --git a/drivers/usb/typec/bus.c b/drivers/usb/typec/bus.c
index 6ea103e1abae..8675faa2a360 100644
--- a/drivers/usb/typec/bus.c
+++ b/drivers/usb/typec/bus.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/usb/pd_vdo.h>
+#include <linux/kobject.h>
 
 #include "bus.h"
 #include "class.h"
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index caea2b829980..4b3dd32992d0 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -6,6 +6,7 @@
  * Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
  */
 
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/property.h>
diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 1d24da79c399..0670955456ce 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -23,6 +23,7 @@
 #include <linux/nospec.h>
 #include <linux/vmalloc.h>
 #include <linux/sched/mm.h>
+#include <linux/kobject.h>
 #include <uapi/linux/vduse.h>
 #include <uapi/linux/vdpa.h>
 #include <uapi/linux/virtio_config.h>
diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
index ed4737de4528..c1668a8d634f 100644
--- a/drivers/vfio/mdev/mdev_core.c
+++ b/drivers/vfio/mdev/mdev_core.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
+#include <linux/kobject.h>
 #include <linux/mdev.h>
 
 #include "mdev_private.h"
diff --git a/drivers/vfio/mdev/mdev_sysfs.c b/drivers/vfio/mdev/mdev_sysfs.c
index 9d2738e10c0b..e1f2af0c4def 100644
--- a/drivers/vfio/mdev/mdev_sysfs.c
+++ b/drivers/vfio/mdev/mdev_sysfs.c
@@ -10,6 +10,7 @@
 #include <linux/sysfs.h>
 #include <linux/ctype.h>
 #include <linux/slab.h>
+#include <linux/kobject.h>
 #include <linux/mdev.h>
 
 #include "mdev_private.h"
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c b/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c
index ae937854403b..dbb97f50b92b 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c
@@ -10,6 +10,7 @@
 #define DSS_SUBSYS_NAME "DISPLAY"
 
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/manager-sysfs.c b/drivers/video/fbdev/omap2/omapfb/dss/manager-sysfs.c
index 1b644be5fe2e..dac243070c65 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/manager-sysfs.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/manager-sysfs.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/kstrtox.h>
 #include <linux/slab.h>
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/jiffies.h>
diff --git a/drivers/virt/vmgenid.c b/drivers/virt/vmgenid.c
index b67a28da4702..884fefcd569e 100644
--- a/drivers/virt/vmgenid.c
+++ b/drivers/virt/vmgenid.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/acpi.h>
 #include <linux/random.h>
diff --git a/drivers/xen/xenbus/xenbus_probe_backend.c b/drivers/xen/xenbus/xenbus_probe_backend.c
index 5ebb7233076f..d9fdf215837f 100644
--- a/drivers/xen/xenbus/xenbus_probe_backend.c
+++ b/drivers/xen/xenbus/xenbus_probe_backend.c
@@ -43,6 +43,7 @@
 #include <linux/ctype.h>
 #include <linux/fcntl.h>
 #include <linux/mm.h>
+#include <linux/kobject.h>
 #include <linux/notifier.h>
 #include <linux/export.h>
 #include <linux/semaphore.h>
diff --git a/drivers/xen/xenbus/xenbus_probe_frontend.c b/drivers/xen/xenbus/xenbus_probe_frontend.c
index fcb335bb7b18..691356164521 100644
--- a/drivers/xen/xenbus/xenbus_probe_frontend.c
+++ b/drivers/xen/xenbus/xenbus_probe_frontend.c
@@ -13,6 +13,7 @@
 #include <linux/mm.h>
 #include <linux/proc_fs.h>
 #include <linux/notifier.h>
+#include <linux/kobject.h>
 #include <linux/kthread.h>
 #include <linux/mutex.h>
 #include <linux/io.h>
diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 61dbe52bb3a3..790484189659 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
+#include <linux/kobject.h>
 #include <linux/sched.h>
 #include <linux/cred.h>
 #include <linux/parser.h>
diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
index 57a6ab996950..7b4a67d02a10 100644
--- a/fs/configfs/mount.c
+++ b/fs/configfs/mount.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/mount.h>
 #include <linux/fs_context.h>
diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index 2dc927ba067f..7cb95a278bd9 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -18,6 +18,7 @@
 #include <linux/mount.h>
 #include <linux/pagemap.h>
 #include <linux/key.h>
+#include <linux/kobject.h>
 #include <linux/parser.h>
 #include <linux/fs_stack.h>
 #include <linux/slab.h>
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index dcba0f85dfe2..fbbb70f85bc1 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -43,6 +43,7 @@
 #include <linux/iversion.h>
 #include <linux/unicode.h>
 #include <linux/part_stat.h>
+#include <linux/kobject.h>
 #include <linux/kthread.h>
 #include <linux/freezer.h>
 #include <linux/fsnotify.h>
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index a982ea569b9d..9860b03368fa 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -10,6 +10,7 @@
 
 #include <linux/time.h>
 #include <linux/fs.h>
+#include <linux/kobject.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index 91e89e68177e..1100a450225c 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -40,6 +40,7 @@
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/kdev_t.h>
+#include <linux/kobject.h>
 #include <linux/kthread.h>
 #include <linux/list.h>
 #include <linux/magic.h>
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 2a6d44f91729..54ad222af837 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -13,6 +13,7 @@
 #include <linux/file.h>
 #include <linux/seq_file.h>
 #include <linux/init.h>
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/fs_context.h>
diff --git a/fs/namespace.c b/fs/namespace.c
index d80479bcf76c..e8ff4faaac9f 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -34,6 +34,7 @@
 #include <linux/sysfs.h>
 #include <linux/mnt_idmapping.h>
 #include <linux/nospec.h>
+#include <linux/kobject.h>
 
 #include "pnode.h"
 #include "internal.h"
diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 44eca51b2808..898283bfd202 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -11,6 +11,7 @@
 #include <linux/sched.h>
 #include <linux/time.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/mm.h>
 #include <linux/string.h>
 #include <linux/stat.h>
diff --git a/fs/ubifs/sysfs.c b/fs/ubifs/sysfs.c
index 1c958148bb87..ac5eef88af0d 100644
--- a/fs/ubifs/sysfs.c
+++ b/fs/ubifs/sysfs.c
@@ -9,6 +9,7 @@
 
 
 #include <linux/fs.h>
+#include <linux/kobject.h>
 #include "ubifs.h"
 
 enum attr_id_t {
diff --git a/fs/xfs/xfs_sysfs.h b/fs/xfs/xfs_sysfs.h
index 148893ebfdef..72a2d45be825 100644
--- a/fs/xfs/xfs_sysfs.h
+++ b/fs/xfs/xfs_sysfs.h
@@ -7,6 +7,8 @@
 #ifndef __XFS_SYSFS_H__
 #define __XFS_SYSFS_H__
 
+#include <linux/kobject.h>
+
 extern const struct kobj_type xfs_mp_ktype;	/* xfs_mount */
 extern const struct kobj_type xfs_dbg_ktype;	/* debug */
 extern const struct kobj_type xfs_log_ktype;	/* xlog */
diff --git a/include/linux/cdev.h b/include/linux/cdev.h
index 6f4892ff3a40..81f07bc82f3c 100644
--- a/include/linux/cdev.h
+++ b/include/linux/cdev.h
@@ -2,7 +2,7 @@
 #ifndef _LINUX_CDEV_H
 #define _LINUX_CDEV_H
 
-#include <linux/kobject.h>
+#include <linux/kobject_types.h>
 #include <linux/kdev_t.h>
 #include <linux/list.h>
 
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 25658fe36a9b..9f57e106b040 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -12,7 +12,7 @@
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
 #include <linux/completion.h>
-#include <linux/kobject.h>
+#include <linux/kobject_types.h>
 #include <linux/notifier.h>
 #include <linux/of.h>
 #include <linux/pm_opp.h>
diff --git a/include/linux/device.h b/include/linux/device.h
index 235c780b5b65..3e221c132d89 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -15,7 +15,7 @@
 #include <linux/dev_printk.h>
 #include <linux/energy_model.h>
 #include <linux/ioport.h>
-#include <linux/kobject.h>
+#include <linux/kobject_types.h>
 #include <linux/klist.h>
 #include <linux/list.h>
 #include <linux/lockdep.h>
diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 1f2c9b81baae..ec5c41b36569 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -3,7 +3,7 @@
 #define _LINUX_IRQDESC_H
 
 #include <linux/rcupdate.h>
-#include <linux/kobject.h>
+#include <linux/kobject_types.h>
 #include <linux/mutex_types.h>
 
 /*
diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index c120ea4addca..fc5c0fffc262 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -15,20 +15,16 @@
 #ifndef _KOBJECT_H_
 #define _KOBJECT_H_
 
+#include <linux/kobject_types.h>
 #include <linux/types.h>
 #include <linux/list.h>
 #include <linux/sysfs.h>
 #include <linux/compiler.h>
 #include <linux/container_of.h>
 #include <linux/spinlock_types.h>
-#include <linux/kref_types.h>
 #include <linux/kobject_ns.h>
 #include <linux/uidgid_types.h>
 
-#ifdef CONFIG_DEBUG_KOBJECT_RELEASE
-#include <linux/workqueue_types.h>
-#endif
-
 #define UEVENT_HELPER_PATH_LEN		256
 #define UEVENT_NUM_ENVP			64	/* number of env pointers */
 #define UEVENT_BUFFER_SIZE		2048	/* buffer for the variables */
@@ -41,55 +37,9 @@ extern char uevent_helper[];
 /* counter to tag the uevent, read only except for the kobject core */
 extern u64 uevent_seqnum;
 
-/*
- * The actions here must match the index to the string array
- * in lib/kobject_uevent.c
- *
- * Do not add new actions here without checking with the driver-core
- * maintainers. Action strings are not meant to express subsystem
- * or device specific properties. In most cases you want to send a
- * kobject_uevent_env(kobj, KOBJ_CHANGE, env) with additional event
- * specific variables added to the event environment.
- */
-enum kobject_action {
-	KOBJ_ADD,
-	KOBJ_REMOVE,
-	KOBJ_CHANGE,
-	KOBJ_MOVE,
-	KOBJ_ONLINE,
-	KOBJ_OFFLINE,
-	KOBJ_BIND,
-	KOBJ_UNBIND,
-};
-
-struct kobject {
-	const char		*name;
-	struct list_head	entry;
-	struct kobject		*parent;
-	struct kset		*kset;
-	const struct kobj_type	*ktype;
-	struct kernfs_node	*sd; /* sysfs directory entry */
-	struct kref		kref;
-
-	unsigned int state_initialized:1;
-	unsigned int state_in_sysfs:1;
-	unsigned int state_add_uevent_sent:1;
-	unsigned int state_remove_uevent_sent:1;
-	unsigned int uevent_suppress:1;
-
-#ifdef CONFIG_DEBUG_KOBJECT_RELEASE
-	struct delayed_work	release;
-#endif
-};
-
 __printf(2, 3) int kobject_set_name(struct kobject *kobj, const char *name, ...);
 __printf(2, 0) int kobject_set_name_vargs(struct kobject *kobj, const char *fmt, va_list vargs);
 
-static inline const char *kobject_name(const struct kobject *kobj)
-{
-	return kobj->name;
-}
-
 void kobject_init(struct kobject *kobj, const struct kobj_type *ktype);
 __printf(3, 4) __must_check int kobject_add(struct kobject *kobj,
 					    struct kobject *parent,
@@ -147,32 +97,6 @@ struct kobj_attribute {
 
 extern const struct sysfs_ops kobj_sysfs_ops;
 
-struct sock;
-
-/**
- * struct kset - a set of kobjects of a specific type, belonging to a specific subsystem.
- *
- * A kset defines a group of kobjects.  They can be individually
- * different "types" but overall these kobjects all want to be grouped
- * together and operated on in the same manner.  ksets are used to
- * define the attribute callbacks and other common events that happen to
- * a kobject.
- *
- * @list: the list of all kobjects for this kset
- * @list_lock: a lock for iterating over the kobjects
- * @kobj: the embedded kobject for this kset (recursion, isn't it fun...)
- * @uevent_ops: the set of uevent operations for this kset.  These are
- * called whenever a kobject has something happen to it so that the kset
- * can add new environment variables, or filter out the uevents if so
- * desired.
- */
-struct kset {
-	struct list_head list;
-	spinlock_t list_lock;
-	struct kobject kobj;
-	const struct kset_uevent_ops *uevent_ops;
-} __randomize_layout;
-
 void kset_init(struct kset *kset);
 int __must_check kset_register(struct kset *kset);
 void kset_unregister(struct kset *kset);
diff --git a/include/linux/kobject_types.h b/include/linux/kobject_types.h
new file mode 100644
index 000000000000..b7a6b880354e
--- /dev/null
+++ b/include/linux/kobject_types.h
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef _KOBJECT_TYPES_H_
+#define _KOBJECT_TYPES_H_
+
+#include <linux/list.h>
+#include <linux/kref_types.h>
+#include <linux/spinlock_types.h>
+
+#ifdef CONFIG_DEBUG_KOBJECT_RELEASE
+#include <linux/workqueue.h>
+#endif
+
+/*
+ * The actions here must match the index to the string array
+ * in lib/kobject_uevent.c
+ *
+ * Do not add new actions here without checking with the driver-core
+ * maintainers. Action strings are not meant to express subsystem
+ * or device specific properties. In most cases you want to send a
+ * kobject_uevent_env(kobj, KOBJ_CHANGE, env) with additional event
+ * specific variables added to the event environment.
+ */
+enum kobject_action {
+	KOBJ_ADD,
+	KOBJ_REMOVE,
+	KOBJ_CHANGE,
+	KOBJ_MOVE,
+	KOBJ_ONLINE,
+	KOBJ_OFFLINE,
+	KOBJ_BIND,
+	KOBJ_UNBIND,
+};
+
+struct kobject {
+	const char		*name;
+	struct list_head	entry;
+	struct kobject		*parent;
+	struct kset		*kset;
+	const struct kobj_type	*ktype;
+	struct kernfs_node	*sd; /* sysfs directory entry */
+	struct kref		kref;
+
+	unsigned int state_initialized:1;
+	unsigned int state_in_sysfs:1;
+	unsigned int state_add_uevent_sent:1;
+	unsigned int state_remove_uevent_sent:1;
+	unsigned int uevent_suppress:1;
+
+#ifdef CONFIG_DEBUG_KOBJECT_RELEASE
+	struct delayed_work	release;
+#endif
+};
+
+static inline const char *kobject_name(const struct kobject *kobj)
+{
+	return kobj->name;
+}
+
+/**
+ * struct kset - a set of kobjects of a specific type, belonging to a specific subsystem.
+ *
+ * A kset defines a group of kobjects.  They can be individually
+ * different "types" but overall these kobjects all want to be grouped
+ * together and operated on in the same manner.  ksets are used to
+ * define the attribute callbacks and other common events that happen to
+ * a kobject.
+ *
+ * @list: the list of all kobjects for this kset
+ * @list_lock: a lock for iterating over the kobjects
+ * @kobj: the embedded kobject for this kset (recursion, isn't it fun...)
+ * @uevent_ops: the set of uevent operations for this kset.  These are
+ * called whenever a kobject has something happen to it so that the kset
+ * can add new environment variables, or filter out the uevents if so
+ * desired.
+ */
+struct kset {
+	struct list_head list;
+	spinlock_t list_lock;
+	struct kobject kobj;
+	const struct kset_uevent_ops *uevent_ops;
+} __randomize_layout;
+
+#endif /* _KOBJECT_TYPES_H_ */
diff --git a/include/linux/module.h b/include/linux/module.h
index fd3c85e4d95f..426d3bdf83bb 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -18,7 +18,7 @@
 #include <linux/init.h>
 #include <linux/elf.h>
 #include <linux/stringify.h>
-#include <linux/kobject.h>
+#include <linux/kobject_types.h>
 #include <linux/moduleparam.h>
 #include <linux/jump_label.h>
 #include <linux/export.h>
diff --git a/include/linux/padata.h b/include/linux/padata.h
index d00a89e41518..2eeadb6b0bb3 100644
--- a/include/linux/padata.h
+++ b/include/linux/padata.h
@@ -17,7 +17,7 @@
 #include <linux/workqueue_types.h>
 #include <linux/spinlock_types.h>
 #include <linux/list.h>
-#include <linux/kobject.h>
+#include <linux/kobject_types.h>
 
 #define PADATA_CPU_SERIAL   0x01
 #define PADATA_CPU_PARALLEL 0x02
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 7ab0d13672da..74330cc2b261 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -32,7 +32,7 @@
 #include <linux/list.h>
 #include <linux/compiler.h>
 #include <linux/errno.h>
-#include <linux/kobject.h>
+#include <linux/kobject_types.h>
 #include <linux/atomic.h>
 #include <linux/device.h>
 #include <linux/interrupt.h>
diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
index aa1716fb0e53..4841ec031857 100644
--- a/include/net/netdev_rx_queue.h
+++ b/include/net/netdev_rx_queue.h
@@ -2,7 +2,7 @@
 #ifndef _LINUX_NETDEV_RX_QUEUE_H
 #define _LINUX_NETDEV_RX_QUEUE_H
 
-#include <linux/kobject.h>
+#include <linux/kobject_types.h>
 #include <linux/netdevice.h>
 #include <linux/sysfs.h>
 #include <net/xdp.h>
diff --git a/include/video/omapfb_dss.h b/include/video/omapfb_dss.h
index e8eaac2cb7b8..9c082ab4ed62 100644
--- a/include/video/omapfb_dss.h
+++ b/include/video/omapfb_dss.h
@@ -7,7 +7,7 @@
 #define __OMAPFB_DSS_H
 
 #include <linux/list.h>
-#include <linux/kobject.h>
+#include <linux/kobject_types.h>
 #include <linux/device.h>
 #include <linux/interrupt.h>
 #include <linux/platform_data/omapdss.h>
diff --git a/init/initramfs.c b/init/initramfs.c
index 70cdefa0911b..5cbb6f6a7492 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -18,6 +18,7 @@
 #include <linux/init_syscalls.h>
 #include <linux/task_work.h>
 #include <linux/umh.h>
+#include <linux/kobject.h> // for firmware_kobj
 
 static __initdata bool csum_present;
 static __initdata u32 io_csum;
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index a66c088c851c..0b44e03df12f 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -35,6 +35,7 @@
 #include <linux/errno.h>
 #include <linux/init_task.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/magic.h>
 #include <linux/mutex.h>
 #include <linux/mount.h>
diff --git a/kernel/exit.c b/kernel/exit.c
index 9b4f638322b0..1f53c60fc7db 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -71,6 +71,8 @@
 #include <linux/user_events.h>
 #include <linux/uaccess.h>
 #include <linux/hrtimer.h>
+#include <linux/sysfs.h>
+#include <linux/kobject.h>
 
 #include <uapi/linux/wait.h>
 
diff --git a/kernel/module/main.c b/kernel/module/main.c
index a9a4a4885102..f8ae27b19012 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -18,6 +18,7 @@
 #include <linux/fs.h>
 #include <linux/kernel.h>
 #include <linux/kernel_read_file.h>
+#include <linux/kobject.h>
 #include <linux/kstrtox.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
diff --git a/kernel/module/sysfs.c b/kernel/module/sysfs.c
index d964167c6658..706aa34d3f50 100644
--- a/kernel/module/sysfs.c
+++ b/kernel/module/sysfs.c
@@ -7,6 +7,7 @@
 
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/fs.h>
 #include <linux/sysfs.h>
 #include <linux/slab.h>
diff --git a/kernel/padata.c b/kernel/padata.c
index 9d051ab75dad..409795156ff6 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -17,6 +17,7 @@
 #include <linux/err.h>
 #include <linux/cpu.h>
 #include <linux/padata.h>
+#include <linux/kobject.h>
 #include <linux/mutex.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
diff --git a/kernel/panic.c b/kernel/panic.c
index 29b49d03b73e..730729561afb 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -23,6 +23,7 @@
 #include <linux/reboot.h>
 #include <linux/delay.h>
 #include <linux/kexec.h>
+#include <linux/kobject.h>
 #include <linux/panic_notifier.h>
 #include <linux/sched.h>
 #include <linux/string_helpers.h>
diff --git a/kernel/params.c b/kernel/params.c
index 2e447f8ae183..0153e4f0a5dc 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -8,6 +8,7 @@
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
diff --git a/kernel/reboot.c b/kernel/reboot.c
index ec96587c78cd..564a018c34f6 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -19,6 +19,7 @@
 #include <linux/syscalls.h>
 #include <linux/syscore_ops.h>
 #include <linux/uaccess.h>
+#include <linux/kobject.h>
 
 /*
  * this indicates whether you can reboot with ctrl-alt-del: the default is yes
diff --git a/mm/damon/sysfs-common.c b/mm/damon/sysfs-common.c
index 9217de9eb813..b1610af8dd6c 100644
--- a/mm/damon/sysfs-common.c
+++ b/mm/damon/sysfs-common.c
@@ -5,6 +5,7 @@
  * Author: SeongJae Park <sj@kernel.org>
  */
 
+#include <linux/kobject.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 
diff --git a/mm/damon/sysfs-common.h b/mm/damon/sysfs-common.h
index 4c37a166eb81..75db8ca6ad64 100644
--- a/mm/damon/sysfs-common.h
+++ b/mm/damon/sysfs-common.h
@@ -6,7 +6,7 @@
  */
 
 #include <linux/damon.h>
-#include <linux/kobject.h>
+#include <linux/kobject_types.h>
 
 extern struct mutex damon_sysfs_lock;
 
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 17dfd8cf7a36..8eb49e2f0baa 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2022 SeongJae Park <sj@kernel.org>
  */
 
+#include <linux/kobject.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 05962d593810..bbc86b069592 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2022 SeongJae Park <sj@kernel.org>
  */
 
+#include <linux/kobject.h>
 #include <linux/pid.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 016e20bd813e..f524aef031dc 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -21,6 +21,7 @@
 #include <linux/backing-dev.h>
 #include <linux/dax.h>
 #include <linux/khugepaged.h>
+#include <linux/kobject.h>
 #include <linux/freezer.h>
 #include <linux/pfn_t.h>
 #include <linux/mman.h>
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9d996fe4ecd9..77322e407219 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -36,6 +36,7 @@
 #include <linux/memory.h>
 #include <linux/mm_inline.h>
 #include <linux/padata.h>
+#include <linux/kobject.h>
 
 #include <asm/page.h>
 #include <asm/pgalloc.h>
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index d61fcca99c02..84d1d9ab90fc 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -12,6 +12,7 @@
 #include <linux/mm_inline.h>
 #include <linux/kthread.h>
 #include <linux/khugepaged.h>
+#include <linux/kobject.h>
 #include <linux/freezer.h>
 #include <linux/mman.h>
 #include <linux/hashtable.h>
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 2bfa7f1dd9a3..3888a7ff0f78 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -110,6 +110,7 @@
 #include <linux/mmu_notifier.h>
 #include <linux/printk.h>
 #include <linux/swapops.h>
+#include <linux/kobject.h>
 
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>
diff --git a/mm/shmem.c b/mm/shmem.c
index d7c84ff62186..ee634869fad0 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -24,6 +24,7 @@
 #include <linux/fs.h>
 #include <linux/init.h>
 #include <linux/vfs.h>
+#include <linux/kobject.h>
 #include <linux/mount.h>
 #include <linux/ramfs.h>
 #include <linux/pagemap.h>
diff --git a/mm/swap_state.c b/mm/swap_state.c
index e671266ad772..637144196f61 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -10,6 +10,7 @@
 #include <linux/mm.h>
 #include <linux/gfp.h>
 #include <linux/kernel_stat.h>
+#include <linux/kobject.h>
 #include <linux/mempolicy.h>
 #include <linux/swap.h>
 #include <linux/swapops.h>
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 895f03e2d932..c3d9ee010123 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/gfp.h>
 #include <linux/kernel_stat.h>
+#include <linux/kobject.h>
 #include <linux/swap.h>
 #include <linux/pagemap.h>
 #include <linux/init.h>
diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index e305071eb7b8..d8f119b4a122 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -19,6 +19,7 @@
 #include <linux/ipv6.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/un.h>
 #include <linux/uaccess.h>
 #include <linux/inet.h>
diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
index ea733542244c..06d35083f67d 100644
--- a/net/bridge/br_sysfs_br.c
+++ b/net/bridge/br_sysfs_br.c
@@ -9,6 +9,7 @@
 
 #include <linux/capability.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/if_bridge.h>
diff --git a/net/rfkill/core.c b/net/rfkill/core.c
index c3feb4f49d09..406aafcf7237 100644
--- a/net/rfkill/core.c
+++ b/net/rfkill/core.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/workqueue.h>
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 2741b626919a..76746e04bdcf 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -55,6 +55,7 @@
 #include <linux/nl80211.h>
 #include <linux/platform_device.h>
 #include <linux/verification.h>
+#include <linux/kobject.h>
 #include <linux/moduleparam.h>
 #include <linux/firmware.h>
 #include <net/cfg80211.h>
diff --git a/sound/core/init.c b/sound/core/init.c
index 22c0d217b860..804dd1f9ab5a 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -16,6 +16,7 @@
 #include <linux/debugfs.h>
 #include <linux/completion.h>
 #include <linux/interrupt.h>
+#include <linux/kobject.h>
 
 #include <sound/core.h>
 #include <sound/control.h>
diff --git a/sound/hda/hda_bus_type.c b/sound/hda/hda_bus_type.c
index cce2c30511a2..cece361bf8e7 100644
--- a/sound/hda/hda_bus_type.c
+++ b/sound/hda/hda_bus_type.c
@@ -4,6 +4,7 @@
  */
 #include <linux/init.h>
 #include <linux/device.h>
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/export.h>
diff --git a/sound/hda/hdac_sysfs.c b/sound/hda/hdac_sysfs.c
index 60b0a70428d5..728ba0c1bf56 100644
--- a/sound/hda/hdac_sysfs.c
+++ b/sound/hda/hdac_sysfs.c
@@ -6,6 +6,7 @@
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/device.h>
+#include <linux/kobject.h>
 #include <sound/core.h>
 #include <sound/hdaudio.h>
 #include "local.h"
-- 
2.39.2


