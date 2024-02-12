Return-Path: <linux-kernel+bounces-61470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B018512C0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 145BD1C2208F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1695C3AC10;
	Mon, 12 Feb 2024 11:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="G8KSDEK+"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9A739AD6
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 11:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707738927; cv=none; b=cYdmvaH4vvx9Y8OyUrlWC03ir0rYcTOQxTSLaLtfsP4cE6H/xia2j5OhZKQn0hqAVJbxknc5r9h61oqDWCvlCPRnoU1kRG4ywKj+G9GTYp5LBU0o3+/ZwjFwOo8cVPW9kNaJudgN5uxKv/2Kvsyf/d7kecxVnRXM5xcbnyv/VC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707738927; c=relaxed/simple;
	bh=mgUQKlQeth5brHjLKvJ/w1xuiNbvp7Mba0AmPHBzNGA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sq1aPeWVXn8pGS9sCh2hZqftYr2qCnYFUnJzVzgT5J3WGXIDHqoJAoX1xBdoLAOdnbNcJkBQDwo2V49NfiSbVyZMnLKG6gTsZD5ejXj7B8RRYu/8ypiRS4nrg4B5kjraxwDEtd+t68NP8T+Te2aabT5CpOnzAh8xrJZrs9iTdaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=G8KSDEK+; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3c1a6c10bbso204453766b.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 03:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707738919; x=1708343719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLX4jd5fgM8KkSszVyQg0egiIz/5mMVgYv0j1UoBiN8=;
        b=G8KSDEK+i1gLXnpw+lBU3TvfTKj0NT09gCNbGAP8SU83GGhZdnWtpUNMEdIaqx75R4
         TE0aCPWkSbeBjAEN2XnpYICBtFS+lLEB/iKo8AtwoNU87oi6VuSZ/ui9icJRCxSSfPzn
         1gTq8T4nxVA75t+AsXJ3rXsBHgDnnwP1rCH+cEN6Ok8na+z6ZwGoZc7dth8MOIGj2NtR
         /45kEVoGfc05CZfGTqZJMFhJ/0Gnb6QJYe2BpNxw7SAwQ4XFLqFT6RKqUzApY2FByzep
         x5MUi/mmzae14Nq7ggxPDzpjpAnM9oYiSW290X1iqrj8VFjupEocb6NqbnDP60CWDtG1
         d7Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707738919; x=1708343719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YLX4jd5fgM8KkSszVyQg0egiIz/5mMVgYv0j1UoBiN8=;
        b=YlDXZ9OdCsqM0IntF5rqI/Pv1p91E04qRELVGCsOqedTUp8zViNmorrBPwgTEZf0aR
         AooII+yeSI7ZQesACt0IOrj5gQKvsZGAt257jBuG9Uvj/crWokuztB4UVeGgceA0Qqst
         RMC7NbqvAXm8JfQfEsMLk9eqGefSqIIs1ulK1Z/Jy1sPVooREx6tSU+J65283amz5xaS
         7KXwYE+Xq7PHURabuOb8qgYIisd/ryySoto56MMY/xs+bHOEchJkRTuua9jufldm6GwH
         NLzLRsEdsg32GFko43aHXT73qM8I2E4AcFsGB9qOcDaGBoeHnHTaBrSoyNa7LLbugHPz
         YO+Q==
X-Gm-Message-State: AOJu0Yy7dK1WDd3uCHflt+R/+Mmxdj+aLcWPTcbeXn45fw9PXaxkY5xi
	+RqkROy5gucdzkkEJf9tuXLi81VTVeeXCvpDG6utu5J/IR97l/cECo2hS7/cqGIq9+x9RBTt9CT
	7
X-Google-Smtp-Source: AGHT+IFVeVgeEkOoRxTVeR1/wtPCh2gbGlclThEgSh7hGH6UzgqKuNK6U4YHqGxnHKA/FeMtbEra4Q==
X-Received: by 2002:a17:907:208e:b0:a37:e35b:9a3e with SMTP id pv14-20020a170907208e00b00a37e35b9a3emr4682674ejb.40.1707738917923;
        Mon, 12 Feb 2024 03:55:17 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id m1-20020a17090607c100b00a36c3e2e52dsm139203ejc.61.2024.02.12.03.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 03:55:17 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v5 06/35] kobject.h: move declarations to kobject_types.h
Date: Mon, 12 Feb 2024 12:54:31 +0100
Message-Id: <20240212115500.2078463-7-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212115500.2078463-1-max.kellermann@ionos.com>
References: <20240212115500.2078463-1-max.kellermann@ionos.com>
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
 drivers/bus/mhi/ep/main.c                     |  1 +
 drivers/char/virtio_console.c                 |  1 +
 drivers/char/xillybus/xillybus_class.c        |  1 +
 drivers/comedi/comedi_fops.c                  |  1 +
 drivers/dax/bus.c                             |  1 +
 drivers/dma/qcom/hidma_mgmt_sys.c             |  1 +
 drivers/firmware/arm_ffa/bus.c                |  1 +
 drivers/firmware/dmi-id.c                     |  1 +
 drivers/firmware/dmi_scan.c                   |  1 +
 drivers/firmware/memmap.c                     |  1 +
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
 .../fbdev/omap2/omapfb/dss/display-sysfs.c    |  1 +
 .../fbdev/omap2/omapfb/dss/manager-sysfs.c    |  1 +
 drivers/virt/vmgenid.c                        |  1 +
 drivers/xen/xenbus/xenbus_probe_backend.c     |  1 +
 drivers/xen/xenbus/xenbus_probe_frontend.c    |  1 +
 fs/9p/v9fs.c                                  |  1 +
 fs/configfs/mount.c                           |  1 +
 fs/ecryptfs/main.c                            |  1 +
 fs/ext4/sysfs.c                               |  1 +
 fs/fuse/cuse.c                                |  1 +
 fs/fuse/inode.c                               |  1 +
 fs/namespace.c                                |  1 +
 fs/nfs/client.c                               |  1 +
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
 172 files changed, 267 insertions(+), 87 deletions(-)
 create mode 100644 include/linux/kobject_types.h

diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 2e9e1420e582..63f9d7fd747a 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -18,6 +18,7 @@
 #include <linux/elf.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/personality.h>
 #include <linux/preempt.h>
 #include <linux/printk.h>
diff --git a/block/bdev.c b/block/bdev.c
index 5454c6ef4e7b..2d42c6a65700 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -10,6 +10,7 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/kmod.h>
+#include <linux/kobject.h>
 #include <linux/major.h>
 #include <linux/device_cgroup.h>
 #include <linux/blkdev.h>
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 3a978409659e..2366e7de7766 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -117,6 +117,7 @@
 #include <linux/slab.h>
 #include <linux/blkdev.h>
 #include <linux/cgroup.h>
+#include <linux/kobject.h>
 #include <linux/kstrtox.h>
 #include <linux/ktime.h>
 #include <linux/rbtree.h>
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
index 0ab9601b7afe..0e6d11441b04 100644
--- a/block/blk-ia-ranges.c
+++ b/block/blk-ia-ranges.c
@@ -10,6 +10,7 @@
 #include <linux/sprintf.h>
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
index 62e648b1ceb0..8b0c5fb2cebe 100644
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
index fab5c970cd83..7176d9afb375 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -13,6 +13,7 @@
 #include <linux/blk-integrity.h>
 #include <linux/completion.h>
 #include <linux/kmemleak.h>
+#include <linux/kobject.h>
 #include <linux/mm.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 74c22563008b..01d4e66335a8 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -11,6 +11,7 @@
 #include <linux/backing-dev.h>
 #include <linux/blktrace_api.h>
 #include <linux/debugfs.h>
+#include <linux/kobject.h>
 #include <linux/sprintf.h>
 
 #include "blk.h"
diff --git a/block/disk-events.c b/block/disk-events.c
index e26081d267db..f9ec09799906 100644
--- a/block/disk-events.c
+++ b/block/disk-events.c
@@ -5,6 +5,7 @@
 #include <linux/export.h>
 #include <linux/moduleparam.h>
 #include <linux/blkdev.h>
+#include <linux/kobject.h>
 #include "blk.h"
 #include <linux/sprintf.h>
 
diff --git a/block/elevator.c b/block/elevator.c
index 9e44402f8c27..10d40e7cb821 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -36,6 +36,7 @@
 #include <linux/sprintf.h>
 #include <linux/uaccess.h>
 #include <linux/pm_runtime.h>
+#include <linux/kobject.h>
 
 #include <trace/events/block.h>
 
diff --git a/block/genhd.c b/block/genhd.c
index 3e0d4c4ed18d..3e1003514a21 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -11,6 +11,7 @@
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
index 05f1b437e5a7..64ef543e569e 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -8,6 +8,7 @@
 
 #include <linux/kernel.h>
 #include <linux/blkdev.h>
+#include <linux/kobject.h>
 #include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/sbitmap.h>
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 7643472912ab..2a810a9cdbbb 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -9,6 +9,7 @@
 #include <linux/fs.h>
 #include <linux/blkdev.h>
 #include <linux/bio.h>
+#include <linux/kobject.h>
 #include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/slab.h>
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 8917707963f3..b56add574054 100644
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
index 6af5437e7421..fdee6a2f6710 100644
--- a/drivers/acpi/acpi_fpdt.c
+++ b/drivers/acpi/acpi_fpdt.c
@@ -9,6 +9,7 @@
 #define pr_fmt(fmt) "ACPI FPDT: " fmt
 
 #include <linux/acpi.h>
+#include <linux/kobject.h>
 #include <linux/sprintf.h>
 
 /*
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
index aa3b65ae546d..6fa41f2ab75c 100644
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
index 3e9e562ba823..b1c830c6e0a4 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -15,6 +15,7 @@
 #include <linux/completion.h>
 #include <linux/device.h>
 #include <linux/export.h>
+#include <linux/kobject.h>
 #include <linux/nls.h>
 #include <linux/sprintf.h>
 
diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index ff14596e2b52..dde6dcc40ecf 100644
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
index c513758e8ad3..44c3dcc55a73 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -9,6 +9,7 @@
 #include <linux/bitmap.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/kstrtox.h>
 #include <linux/moduleparam.h>
 #include <linux/sprintf.h>
diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index dcab7503a1b6..ccdf1b38ffc2 100644
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
index 8767542733d4..264b563e73f1 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -6,6 +6,7 @@
  * Author: Johannes Berg <johannes@sipsolutions.net>
  */
 #include <linux/module.h>
+#include <linux/kobject.h>
 #include <linux/device.h>
 #include <linux/devcoredump.h>
 #include <linux/kstrtox.h>
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
index 06ee2f8d9774..cf09c6b5be8f 100644
--- a/drivers/base/firmware_loader/sysfs.c
+++ b/drivers/base/firmware_loader/sysfs.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/highmem.h>
+#include <linux/kobject.h>
 #include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/security.h>
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 8df214c005e1..40fd9255e075 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -28,6 +28,7 @@
 #include <asm/unaligned.h>
 #include <linux/drbd_limits.h>
 #include <linux/kthread.h>
+#include <linux/kobject.h>
 #include <linux/sprintf.h>
 
 #include <net/genetlink.h>
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 24af3801ffd6..b0a34ff75fab 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -4,6 +4,7 @@
  */
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/kobject.h>
 #include <linux/sched.h>
 #include <linux/fs.h>
 #include <linux/kstrtox.h>
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 594e1ed9701e..ef1bb6da8612 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -39,6 +39,7 @@
 #include <linux/types.h>
 #include <linux/debugfs.h>
 #include <linux/blk-mq.h>
+#include <linux/kobject.h>
 
 #include <linux/uaccess.h>
 #include <asm/types.h>
diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnbd-clt-sysfs.c
index f627d0d7b43a..cf3f489865d7 100644
--- a/drivers/block/rnbd/rnbd-clt-sysfs.c
+++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
@@ -20,6 +20,7 @@
 #include <linux/sprintf.h>
 #include <linux/uaccess.h>
 #include <linux/device.h>
+#include <linux/kobject.h>
 #include <rdma/ib.h>
 #include <rdma/rdma_cm.h>
 
diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 802c50784a67..7026b7a80faf 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/blkdev.h>
 #include <linux/hdreg.h>
+#include <linux/kobject.h>
 #include <linux/scatterlist.h>
 #include <linux/idr.h>
 #include <linux/sprintf.h>
diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index e1b63a76968d..e7b6ff2a9bf9 100644
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
diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index fb84811ef91e..8514743f0535 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -28,6 +28,7 @@
 #include <linux/workqueue.h>
 #include <linux/module.h>
 #include <linux/dma-mapping.h>
+#include <linux/kobject.h>
 #include "../tty/hvc/hvc_console.h"
 
 #define is_rproc_enabled IS_ENABLED(CONFIG_REMOTEPROC)
diff --git a/drivers/char/xillybus/xillybus_class.c b/drivers/char/xillybus/xillybus_class.c
index 9f84261e735a..29ebf1d614e2 100644
--- a/drivers/char/xillybus/xillybus_class.c
+++ b/drivers/char/xillybus/xillybus_class.c
@@ -11,6 +11,7 @@
 #include <linux/fs.h>
 #include <linux/cdev.h>
 #include <linux/slab.h>
+#include <linux/kobject.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/sprintf.h>
diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
index 859df6db3d9d..f6dfbe31e43e 100644
--- a/drivers/comedi/comedi_fops.c
+++ b/drivers/comedi/comedi_fops.c
@@ -26,6 +26,7 @@
 #include <linux/fs.h>
 #include <linux/comedi/comedidev.h>
 #include <linux/cdev.h>
+#include <linux/kobject.h>
 #include <linux/kref.h>
 
 #include <linux/io.h>
diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 679d232a207e..9c57742bef1d 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -8,6 +8,7 @@
 #include <linux/slab.h>
 #include <linux/dax.h>
 #include <linux/io.h>
+#include <linux/kobject.h>
 #include <linux/kref.h>
 #include "dax-private.h"
 #include "bus.h"
diff --git a/drivers/dma/qcom/hidma_mgmt_sys.c b/drivers/dma/qcom/hidma_mgmt_sys.c
index c64d019b4445..d33cbadb6983 100644
--- a/drivers/dma/qcom/hidma_mgmt_sys.c
+++ b/drivers/dma/qcom/hidma_mgmt_sys.c
@@ -7,6 +7,7 @@
 
 #include <linux/sysfs.h>
 #include <linux/platform_device.h>
+#include <linux/kobject.h>
 #include <linux/sprintf.h>
 #include <linux/kstrtox.h>
 
diff --git a/drivers/firmware/arm_ffa/bus.c b/drivers/firmware/arm_ffa/bus.c
index cc75cd6ced67..bc1d2f3d064d 100644
--- a/drivers/firmware/arm_ffa/bus.c
+++ b/drivers/firmware/arm_ffa/bus.c
@@ -10,6 +10,7 @@
 #include <linux/fs.h>
 #include <linux/idr.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/sprintf.h>
diff --git a/drivers/firmware/dmi-id.c b/drivers/firmware/dmi-id.c
index 6a59b70d42df..ca303d9de2a2 100644
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
index ea33543f578a..333406f5043b 100644
--- a/drivers/firmware/dmi_scan.c
+++ b/drivers/firmware/dmi_scan.c
@@ -2,6 +2,7 @@
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/init.h>
+#include <linux/kobject.h>
 #include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/ctype.h>
diff --git a/drivers/firmware/memmap.c b/drivers/firmware/memmap.c
index 0ca8c54c6673..4cf473815372 100644
--- a/drivers/firmware/memmap.c
+++ b/drivers/firmware/memmap.c
@@ -8,6 +8,7 @@
 #include <linux/string.h>
 #include <linux/firmware-map.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/sprintf.h>
 #include <linux/types.h>
diff --git a/drivers/gnss/core.c b/drivers/gnss/core.c
index 9635feeb9a8e..eb2a75cabff1 100644
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
index 9d5611a74890..a8f60bd45eb1 100644
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
index 5f0c62847150..4a05e9b24496 100644
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
index 35bcd621590c..a29b6676ccad 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -6,6 +6,7 @@
 #include "wacom_wac.h"
 #include "wacom.h"
 #include <linux/input/mt.h>
+#include <linux/kobject.h>
 #include <linux/kref.h>
 #include <linux/kstrtox.h>
 #include <linux/sprintf.h>
diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index 2d63e99ace2b..b947845ffe05 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -20,6 +20,7 @@
 #include <linux/time.h>
 #include <linux/err.h>
 #include <linux/acpi.h>
+#include <linux/kobject.h>
 
 #define ACPI_POWER_METER_NAME		"power_meter"
 #define ACPI_POWER_METER_DEVICE_NAME	"Power Meter"
diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index d9abe66d85f4..50d9610b905f 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -11,6 +11,7 @@
 #include <linux/sprintf.h>
 #include <linux/uaccess.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/compat.h>
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index f2ab1a5e432e..cd1a0e04606e 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -36,6 +36,7 @@
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/kref.h>
 #include <linux/slab.h>
 #include <linux/init.h>
diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index 1d6dc7254ebb..b060885e6ce2 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -41,6 +41,7 @@
 #include <linux/string.h>
 #include <linux/netdevice.h>
 #include <linux/ethtool.h>
+#include <linux/kobject.h>
 
 #include <rdma/ib_mad.h>
 #include <rdma/ib_pma.h>
diff --git a/drivers/infiniband/hw/mlx4/sysfs.c b/drivers/infiniband/hw/mlx4/sysfs.c
index 72a0189db951..e213653bd665 100644
--- a/drivers/infiniband/hw/mlx4/sysfs.c
+++ b/drivers/infiniband/hw/mlx4/sysfs.c
@@ -32,6 +32,7 @@
 
 /*#include "core_priv.h"*/
 #include "mlx4_ib.h"
+#include <linux/kobject.h>
 #include <linux/slab.h>
 #include <linux/sprintf.h>
 #include <linux/string.h>
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
index f9c61397e40b..4cd40229c13a 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
@@ -14,6 +14,8 @@
 #include "rtrs-log.h"
 #include <linux/kstrtox.h>
 
+#include <linux/kobject.h>
+
 #define MIN_MAX_RECONN_ATT -1
 #define MAX_MAX_RECONN_ATT 9999
 
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 6d4b687cb05b..725f63436ff6 100644
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
index 6a30817e31a1..f757c5b5b30f 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -10,6 +10,7 @@
 #undef pr_fmt
 #define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt
 
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/completion.h>
 
diff --git a/drivers/input/input.c b/drivers/input/input.c
index c5f41f30ad76..5436d64ac56f 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -24,6 +24,7 @@
 #include <linux/pm.h>
 #include <linux/poll.h>
 #include <linux/device.h>
+#include <linux/kobject.h>
 #include <linux/kstrtox.h>
 #include <linux/mutex.h>
 #include <linux/rcupdate.h>
diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
index 982950c85b51..e64a43a21fd9 100644
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
index 94e109da5d3c..c4f282bc4eae 100644
--- a/drivers/ipack/ipack.c
+++ b/drivers/ipack/ipack.c
@@ -11,6 +11,7 @@
 #include <linux/idr.h>
 #include <linux/io.h>
 #include <linux/ipack.h>
+#include <linux/kobject.h>
 #include <linux/sprintf.h>
 
 #define to_ipack_dev(device) container_of(device, struct ipack_device, dev)
diff --git a/drivers/isdn/mISDN/core.c b/drivers/isdn/mISDN/core.c
index c5f5a9f53c17..19cc77fc6068 100644
--- a/drivers/isdn/mISDN/core.c
+++ b/drivers/isdn/mISDN/core.c
@@ -7,6 +7,7 @@
 #include <linux/sprintf.h>
 #include <linux/types.h>
 #include <linux/stddef.h>
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/spinlock.h>
 #include <linux/mISDNif.h>
diff --git a/drivers/leds/led-triggers.c b/drivers/leds/led-triggers.c
index f1d787f8e214..9b336f6c64f9 100644
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
index 7bbf828d73a9..00d5dfdf0eb4 100644
--- a/drivers/mcb/mcb-core.c
+++ b/drivers/mcb/mcb-core.c
@@ -6,6 +6,7 @@
  * Author: Johannes Thumshirn <johannes.thumshirn@men.de>
  */
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/sprintf.h>
diff --git a/drivers/media/cec/core/cec-core.c b/drivers/media/cec/core/cec-core.c
index 5d2765b37df0..da34886594e3 100644
--- a/drivers/media/cec/core/cec-core.c
+++ b/drivers/media/cec/core/cec-core.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/kmod.h>
+#include <linux/kobject.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
 #include <linux/sprintf.h>
diff --git a/drivers/media/mc/mc-devnode.c b/drivers/media/mc/mc-devnode.c
index 7f67825c8757..4e33c12442ba 100644
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
index 9006eea48037..44cbe616620d 100644
--- a/drivers/media/rc/rc-main.c
+++ b/drivers/media/rc/rc-main.c
@@ -16,6 +16,7 @@
 #include <linux/idr.h>
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/kobject.h>
 #include "rc-core-priv.h"
 #include <linux/sprintf.h>
 
diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
index 723835d1323d..7afc0132f512 100644
--- a/drivers/memstick/core/memstick.c
+++ b/drivers/memstick/core/memstick.c
@@ -13,6 +13,7 @@
 #include <linux/fs.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/completion.h>
diff --git a/drivers/misc/ti-st/st_kim.c b/drivers/misc/ti-st/st_kim.c
index 0a23292fb773..fa6e93718bec 100644
--- a/drivers/misc/ti-st/st_kim.c
+++ b/drivers/misc/ti-st/st_kim.c
@@ -21,6 +21,7 @@
 #include <linux/sysfs.h>
 #include <linux/tty.h>
 #include <linux/completion.h>
+#include <linux/kobject.h>
 
 #include <linux/skbuff.h>
 #include <linux/ti_wilink_st.h>
diff --git a/drivers/misc/tifm_core.c b/drivers/misc/tifm_core.c
index 810bf6290ab8..d9e9587609d7 100644
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
index 5204e41504e6..339448b7d0fa 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -33,6 +33,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/sprintf.h>
 #include <linux/types.h>
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_minidump.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_minidump.c
index 6312395ad893..80fc6c9e77cb 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_minidump.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_minidump.c
@@ -12,6 +12,8 @@
 #include "qlcnic_83xx_hw.h"
 #include "qlcnic_hw.h"
 
+#include <linux/kobject.h>
+
 #define QLC_83XX_MINIDUMP_FLASH		0x520000
 #define QLC_83XX_OCM_INDEX			3
 #define QLC_83XX_PCI_INDEX			0
diff --git a/drivers/net/wireless/ath/wil6210/interrupt.c b/drivers/net/wireless/ath/wil6210/interrupt.c
index c91d1139af26..10a3f116924e 100644
--- a/drivers/net/wireless/ath/wil6210/interrupt.c
+++ b/drivers/net/wireless/ath/wil6210/interrupt.c
@@ -6,6 +6,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/completion.h>
+#include <linux/kobject.h>
 
 #include "wil6210.h"
 #include "trace.h"
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index e2fe9fb84878..af1a6982fefe 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -13,6 +13,7 @@
 #include <linux/gfp.h>
 #include <linux/sprintf.h>
 #include <linux/vmalloc.h>
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/wait.h>
 #include <linux/seq_file.h>
diff --git a/drivers/net/xen-netback/xenbus.c b/drivers/net/xen-netback/xenbus.c
index 888389c66c30..c60fd12b32c8 100644
--- a/drivers/net/xen-netback/xenbus.c
+++ b/drivers/net/xen-netback/xenbus.c
@@ -11,6 +11,7 @@
 #include <linux/sprintf.h>
 #include <linux/vmalloc.h>
 #include <linux/rtnetlink.h>
+#include <linux/kobject.h>
 
 static int connect_data_rings(struct backend_info *be,
 			      struct xenvif_queue *queue);
diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 67c47e6a6006..a45bd302b002 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -20,6 +20,7 @@
 #include <linux/io.h>
 #include <linux/mm.h>
 #include <linux/nd.h>
+#include <linux/kobject.h>
 #include "nd-core.h"
 #include "nd.h"
 #include "pfn.h"
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 546e7bacc4f0..b254227e5f20 100644
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
index 1d2471a0a91b..4450201eed28 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -9,6 +9,7 @@
 
 #include <linux/pci.h>
 #include <linux/slab.h>
+#include <linux/kobject.h>
 #include <linux/export.h>
 #include <linux/kstrtox.h>
 #include <linux/sprintf.h>
diff --git a/drivers/pcmcia/cs.c b/drivers/pcmcia/cs.c
index 8acf86b21653..838d2f485dc9 100644
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
index 6fcd124c8d2c..4a4782aac49d 100644
--- a/drivers/pcmcia/ds.c
+++ b/drivers/pcmcia/ds.c
@@ -20,6 +20,7 @@
 #include <linux/workqueue.h>
 #include <linux/crc32.h>
 #include <linux/firmware.h>
+#include <linux/kobject.h>
 #include <linux/kref.h>
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
diff --git a/drivers/platform/surface/aggregator/bus.c b/drivers/platform/surface/aggregator/bus.c
index 326a34be9c0f..ec692ab2f10d 100644
--- a/drivers/platform/surface/aggregator/bus.c
+++ b/drivers/platform/surface/aggregator/bus.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/device.h>
+#include <linux/kobject.h>
 #include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/sprintf.h>
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index d1bf02650029..03c3d6bbfc62 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -13,6 +13,7 @@
 #include <linux/ctype.h>
 #include <linux/device.h>
 #include <linux/gfp.h> // for get_zeroed_page()
+#include <linux/kobject.h>
 #include <linux/kstrtox.h>
 #include <linux/power_supply.h>
 #include <linux/slab.h>
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
index 3d86e63abfbf..c0ecc32c1b4e 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -47,6 +47,7 @@
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/ioport.h>
diff --git a/drivers/scsi/iscsi_boot_sysfs.c b/drivers/scsi/iscsi_boot_sysfs.c
index 78d26a564d3d..ce5691bc992c 100644
--- a/drivers/scsi/iscsi_boot_sysfs.c
+++ b/drivers/scsi/iscsi_boot_sysfs.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/kobject.h>
 #include <linux/sprintf.h>
 #include <linux/string.h>
 #include <linux/slab.h>
diff --git a/drivers/scsi/qedf/qedf_dbg.c b/drivers/scsi/qedf/qedf_dbg.c
index 5eb1a433f966..03626dcb73f5 100644
--- a/drivers/scsi/qedf/qedf_dbg.c
+++ b/drivers/scsi/qedf/qedf_dbg.c
@@ -4,6 +4,7 @@
  *  Copyright (c) 2016-2018 Cavium Inc.
  */
 #include "qedf_dbg.h"
+#include <linux/kobject.h>
 #include <linux/sprintf.h>
 #include <linux/vmalloc.h>
 
diff --git a/drivers/scsi/qla4xxx/ql4_nx.c b/drivers/scsi/qla4xxx/ql4_nx.c
index b8dcdbff10c6..0404c8291f8a 100644
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
index 3cf51656ed6d..9c1e5684e409 100644
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
index 0bbae4ae759c..4c19409e0bae 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -16,6 +16,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/bsg.h>
 #include <linux/sprintf.h>
+#include <linux/kobject.h>
 #include <linux/kref.h>
 
 #include <scsi/scsi.h>
diff --git a/drivers/scsi/ses.c b/drivers/scsi/ses.c
index 4e873eb05d18..3638081ea59b 100644
--- a/drivers/scsi/ses.c
+++ b/drivers/scsi/ses.c
@@ -8,6 +8,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/enclosure.h>
 #include <asm/unaligned.h>
 #include <linux/sprintf.h>
diff --git a/drivers/staging/fieldbus/dev_core.c b/drivers/staging/fieldbus/dev_core.c
index b872aedc8bc6..a3018821e6b0 100644
--- a/drivers/staging/fieldbus/dev_core.c
+++ b/drivers/staging/fieldbus/dev_core.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/idr.h>
+#include <linux/kobject.h>
 #include <linux/fs.h>
 #include <linux/kstrtox.h>
 #include <linux/slab.h>
diff --git a/drivers/staging/greybus/gbphy.c b/drivers/staging/greybus/gbphy.c
index 832e1b35015a..5e4bbedc3dab 100644
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
index 6f1691d708f5..6e681ee16d25 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -10,6 +10,7 @@
 #include <linux/cred.h>
 #include <linux/fs.h>
 #include <linux/idr.h>
+#include <linux/kobject.h>
 #include <linux/kernel.h> // for u64_to_user_ptr()
 #include <linux/module.h>
 #include <linux/slab.h>
diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
index f061c3e19009..5b46cab07430 100644
--- a/drivers/thunderbolt/domain.c
+++ b/drivers/thunderbolt/domain.c
@@ -8,6 +8,7 @@
 
 #include <linux/device.h>
 #include <linux/idr.h>
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
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
index 9af93101f89e..b7997e8043d1 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -11,6 +11,7 @@
 #include <linux/delay.h>
 #include <linux/kernel.h> // for upper_32_bits(), lower_32_bits()
 #include <linux/kmod.h>
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/prandom.h>
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 9c7b021ce32c..50ed1a33022b 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -85,6 +85,7 @@
 #include <linux/timer.h>
 #include <linux/ctype.h>
 #include <linux/kd.h>
+#include <linux/kobject.h>
 #include <linux/mm.h>
 #include <linux/string.h>
 #include <linux/slab.h>
diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index 2d1e90c51ac1..33284623126e 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -32,6 +32,7 @@
 #include <linux/usb.h>
 #include <linux/usb/quirks.h>
 #include <linux/usb/hcd.h>
+#include <linux/kobject.h>
 
 #include "usb.h"
 
diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index b7c391891c44..03ea459886ce 100644
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
index cc46570e8c90..01daa23e2894 100644
--- a/drivers/usb/roles/class.c
+++ b/drivers/usb/roles/class.c
@@ -10,6 +10,7 @@
 #include <linux/usb/role.h>
 #include <linux/property.h>
 #include <linux/device.h>
+#include <linux/kobject.h>
 #include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
diff --git a/drivers/usb/typec/bus.c b/drivers/usb/typec/bus.c
index 6e0b1d3428a3..219df434e112 100644
--- a/drivers/usb/typec/bus.c
+++ b/drivers/usb/typec/bus.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/usb/pd_vdo.h>
+#include <linux/kobject.h>
 #include <linux/sprintf.h>
 
 #include "bus.h"
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index eff36bd3ac91..ff359b109021 100644
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
index d56f27ec2412..36f4fce33e89 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -25,6 +25,7 @@
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
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c b/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c
index 8d05c9adae9d..1a25cfef3c06 100644
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
index 16a8c3fb7a51..e1bb5b0a102c 100644
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
index f996ba5d3368..cfa48d71fb37 100644
--- a/drivers/xen/xenbus/xenbus_probe_backend.c
+++ b/drivers/xen/xenbus/xenbus_probe_backend.c
@@ -44,6 +44,7 @@
 #include <linux/ctype.h>
 #include <linux/fcntl.h>
 #include <linux/mm.h>
+#include <linux/kobject.h>
 #include <linux/notifier.h>
 #include <linux/export.h>
 #include <linux/semaphore.h>
diff --git a/drivers/xen/xenbus/xenbus_probe_frontend.c b/drivers/xen/xenbus/xenbus_probe_frontend.c
index 120d01449bb0..bb59d216165e 100644
--- a/drivers/xen/xenbus/xenbus_probe_frontend.c
+++ b/drivers/xen/xenbus/xenbus_probe_frontend.c
@@ -14,6 +14,7 @@
 #include <linux/mm.h>
 #include <linux/proc_fs.h>
 #include <linux/notifier.h>
+#include <linux/kobject.h>
 #include <linux/kthread.h>
 #include <linux/mutex.h>
 #include <linux/io.h>
diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 3ea562c1bca7..18a2196ecd7f 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
+#include <linux/kobject.h>
 #include <linux/kstrtox.h>
 #include <linux/sched.h>
 #include <linux/cred.h>
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
index ba8f5ae7e04d..f354f6e4cebd 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -19,6 +19,7 @@
 #include <linux/mount.h>
 #include <linux/pagemap.h>
 #include <linux/key.h>
+#include <linux/kobject.h>
 #include <linux/parser.h>
 #include <linux/fs_stack.h>
 #include <linux/slab.h>
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index 490ce27ff668..ffff272d569a 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -10,6 +10,7 @@
 
 #include <linux/time.h>
 #include <linux/fs.h>
+#include <linux/kobject.h>
 #include <linux/kstrtox.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index b956b9dd41fa..87f82f804c90 100644
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
index 8fc61618b514..643fdc127b9d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -35,6 +35,7 @@
 #include <linux/sysfs.h>
 #include <linux/mnt_idmapping.h>
 #include <linux/nospec.h>
+#include <linux/kobject.h>
 
 #include "pnode.h"
 #include "internal.h"
diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 417b29ac2d03..ed1bbcee7634 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -12,6 +12,7 @@
 #include <linux/sprintf.h>
 #include <linux/time.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/mm.h>
 #include <linux/string.h>
 #include <linux/stat.h>
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
index fe1c13de0df4..a56eae4b0787 100644
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
index da97815b97fb..cd29809a05e4 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -15,6 +15,7 @@
 #ifndef _KOBJECT_H_
 #define _KOBJECT_H_
 
+#include <linux/kobject_types.h>
 #include <linux/types.h>
 #include <linux/list.h>
 #include <linux/sysfs.h>
@@ -22,14 +23,9 @@
 #include <linux/container_of.h>
 #include <linux/spinlock_types.h>
 #include <linux/stdarg.h> // for va_list
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
@@ -42,55 +38,9 @@ extern char uevent_helper[];
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
@@ -148,32 +98,6 @@ struct kobj_attribute {
 
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
index dbe493427ea5..a0fee72c45a4 100644
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
index d7c02e701eec..4afe8dc6799a 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -18,6 +18,7 @@
 #include <linux/namei.h>
 #include <linux/init_syscalls.h>
 #include <linux/umh.h>
+#include <linux/kobject.h> // for firmware_kobj
 
 #include "do_mounts.h"
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index b5a5d70887d6..103591be3837 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -37,6 +37,7 @@
 #include <linux/errno.h>
 #include <linux/init_task.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/magic.h>
 #include <linux/mutex.h>
 #include <linux/mount.h>
diff --git a/kernel/exit.c b/kernel/exit.c
index cc7b7e7f1794..5b7af32614d6 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -72,6 +72,8 @@
 #include <linux/user_events.h>
 #include <linux/uaccess.h>
 #include <linux/hrtimer.h>
+#include <linux/sysfs.h>
+#include <linux/kobject.h>
 
 #include <uapi/linux/wait.h>
 
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 79962fd528a0..d6890f00238b 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -21,6 +21,7 @@
 #include <linux/fs.h>
 #include <linux/kernel.h>
 #include <linux/kernel_read_file.h>
+#include <linux/kobject.h>
 #include <linux/kstrtox.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
diff --git a/kernel/module/sysfs.c b/kernel/module/sysfs.c
index 4b87b8e9723c..cf3c378fbfd3 100644
--- a/kernel/module/sysfs.c
+++ b/kernel/module/sysfs.c
@@ -7,6 +7,7 @@
 
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/fs.h>
 #include <linux/sprintf.h>
 #include <linux/sysfs.h>
diff --git a/kernel/padata.c b/kernel/padata.c
index a6c1f94279f7..cab979eff16d 100644
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
index aaeea6f1d8c3..6dc157c84cae 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -26,6 +26,7 @@
 #include <linux/delay.h>
 #include <linux/kernel.h> // for bust_spinlocks(), tracing_off()
 #include <linux/kexec.h>
+#include <linux/kobject.h>
 #include <linux/panic_notifier.h>
 #include <linux/sched.h>
 #include <linux/sprintf.h>
diff --git a/kernel/params.c b/kernel/params.c
index 09c5d97d4ab0..37eb51f9b88b 100644
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
index 61b0461f0d17..111ecc3c9d48 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -22,6 +22,7 @@
 #include <linux/syscalls.h>
 #include <linux/syscore_ops.h>
 #include <linux/uaccess.h>
+#include <linux/kobject.h>
 
 /*
  * this indicates whether you can reboot with ctrl-alt-del: the default is yes
diff --git a/mm/damon/sysfs-common.c b/mm/damon/sysfs-common.c
index 0efd9f3f285f..bd835999645b 100644
--- a/mm/damon/sysfs-common.c
+++ b/mm/damon/sysfs-common.c
@@ -5,6 +5,7 @@
  * Author: SeongJae Park <sj@kernel.org>
  */
 
+#include <linux/kobject.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/kstrtox.h>
diff --git a/mm/damon/sysfs-common.h b/mm/damon/sysfs-common.h
index ec0703e1e90b..7f186c48ef43 100644
--- a/mm/damon/sysfs-common.h
+++ b/mm/damon/sysfs-common.h
@@ -6,7 +6,7 @@
  */
 
 #include <linux/damon.h>
-#include <linux/kobject.h>
+#include <linux/kobject_types.h>
 
 extern struct mutex damon_sysfs_lock;
 
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index b82610f510bb..9573ce905e0e 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2022 SeongJae Park <sj@kernel.org>
  */
 
+#include <linux/kobject.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/kstrtox.h>
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 08e54a8eb2e1..2903b7681d63 100644
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
index e538e106e659..4413b891d042 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -22,6 +22,7 @@
 #include <linux/backing-dev.h>
 #include <linux/dax.h>
 #include <linux/khugepaged.h>
+#include <linux/kobject.h>
 #include <linux/freezer.h>
 #include <linux/pfn_t.h>
 #include <linux/mman.h>
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1734fc708d27..dfba59cf7a63 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -39,6 +39,7 @@
 #include <linux/memory.h>
 #include <linux/mm_inline.h>
 #include <linux/padata.h>
+#include <linux/kobject.h>
 
 #include <asm/page.h>
 #include <asm/pgalloc.h>
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index c8e3200a2b0d..9835ea066bcc 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -13,6 +13,7 @@
 #include <linux/mm_inline.h>
 #include <linux/kthread.h>
 #include <linux/khugepaged.h>
+#include <linux/kobject.h>
 #include <linux/freezer.h>
 #include <linux/mman.h>
 #include <linux/hashtable.h>
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 5e81c3c92af6..ac44e7986598 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -111,6 +111,7 @@
 #include <linux/mmu_notifier.h>
 #include <linux/printk.h>
 #include <linux/swapops.h>
+#include <linux/kobject.h>
 
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>
diff --git a/mm/shmem.c b/mm/shmem.c
index 6284f0c6d91d..35373fedd79a 100644
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
index 6b7e13e8ab75..f635bac0284e 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -10,6 +10,7 @@
 #include <linux/mm.h>
 #include <linux/gfp.h>
 #include <linux/kernel_stat.h>
+#include <linux/kobject.h>
 #include <linux/kstrtox.h>
 #include <linux/mempolicy.h>
 #include <linux/swap.h>
diff --git a/mm/vmscan.c b/mm/vmscan.c
index cdf50f001a01..e658f69673ff 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -18,6 +18,7 @@
 #include <linux/gfp.h>
 #include <linux/kernel.h> // for system_state
 #include <linux/kernel_stat.h>
+#include <linux/kobject.h>
 #include <linux/kstrtox.h>
 #include <linux/swap.h>
 #include <linux/pagemap.h>
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
index 3cbd7120fce2..b672d4184518 100644
--- a/net/bridge/br_sysfs_br.c
+++ b/net/bridge/br_sysfs_br.c
@@ -9,6 +9,7 @@
 
 #include <linux/capability.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/kstrtox.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
diff --git a/net/rfkill/core.c b/net/rfkill/core.c
index d58c74c46d4f..5f3ee4b2a822 100644
--- a/net/rfkill/core.c
+++ b/net/rfkill/core.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/init.h>
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index fc7a69046d31..5a47f1fae2d7 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -56,6 +56,7 @@
 #include <linux/platform_device.h>
 #include <linux/sprintf.h>
 #include <linux/verification.h>
+#include <linux/kobject.h>
 #include <linux/moduleparam.h>
 #include <linux/firmware.h>
 #include <net/cfg80211.h>
diff --git a/sound/core/init.c b/sound/core/init.c
index 2f837b0d3007..f5f7f2b944b3 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -17,6 +17,7 @@
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
-- 
2.39.2


