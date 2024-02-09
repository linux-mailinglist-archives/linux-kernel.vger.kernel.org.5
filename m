Return-Path: <linux-kernel+bounces-59623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A73D584F9D3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 571422881F4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0564D8175C;
	Fri,  9 Feb 2024 16:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="d7LQQDVC"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B657B3D4
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707496856; cv=none; b=Lqpu9lAjG5wvSBzf2vJ1zsI4zJ+R9ZtpZtpI54yIaaAOYTb4MlbhEqejWCTLNoAcyMXyhOEVkYt/rmuklPcxSp3p2qnh6IHlPSFypx6b5KYSM52pP8ZfUoZG4F1PJcMzZ0ErRuxnoWB89Tyej/1RASY4RqaZ0oDqPN2JVJ86xn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707496856; c=relaxed/simple;
	bh=Dhs2mryK6cjxcDEq3cmas8fOBOA4lHx6v+C0m71m3Ps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tgxznILCAJrF0nz7ZVdejKrUgz6Pj0Qcy8CSv0uXVcgRwlhxSjW0Rv/XsX1cgV5rjBzLRT3o7JlZypY+L+l5fCPhla7cJ2F0rD+PGoWbbdlHWCa1g4pq3DxrXKcklOJlRQG4C9BALGtMAsCZmz+3CciNMlhZlrDQOEAMllTw084=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=d7LQQDVC; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d073b54359so15048391fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 08:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707496845; x=1708101645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+5/xFpwJe8P4woTgG6Er9CpKudFsvlzPLgw6cSgIo8=;
        b=d7LQQDVCFZt6q4vCWBv/oMJ3nRKBpmSPQZ4ypQgGT/FS/Ip6oAREQJ4soEHjlqPX/w
         McmI1gooaYUU4Zomnf6XDcnSHei9stSs/bBAgPHPkzd4iQ8y7zU4/lT52vxhgVQSStg9
         bMFt5gayFIBlYo1KWWaTfLH65yqLymXR4vZ+v9MxlMHj+IBaDIWsN1CDFF9d4prs+0Kq
         e5ajeTWWXqh5DN/ETSa4H5BGmZBGtoFntlDNjvDGT8thrOjMFTi/GELjWvbgEimaQiBC
         VrX4dj3jNyP+eAS/0DGm+Duxgs3q0Wh67PDzwIm9Cgxwmrc+cNwMWyf30SGs74xC+oNv
         kilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707496845; x=1708101645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+5/xFpwJe8P4woTgG6Er9CpKudFsvlzPLgw6cSgIo8=;
        b=eELSn/0nPkxVpyFMCZ2EjFLD3z5vnooC/LzKOJ/w68rhhYIFbQRQtoObcyK++9C3Do
         THEudePr7XZ47Rj7OyS1X4cVD5wnR1A7I8DDFYCdtyeOsq9HqNiindOT5fFXwqyN2BHZ
         +mgaq8qc2c+s/NBcS5RMJ3GzlVrgGPcYdbARJ1oss0y5uZrXtwpy2sXG5EBFdw2Lp/sc
         3Ef/4unjkvcLT8WilUlqIuW/SOXzLAVLHDFrhyR+7HZ214sgczH4YejZotHJQ2BbXARH
         /p5eHjf6uWAMed6QSX3Hz3L+3sUJW7bvKnEnkYESr5KPGFaIWcgKCgaD/xEcBPgB0xar
         Heqg==
X-Gm-Message-State: AOJu0YwmO2C/Ny1eij28rJE+4d4g4pk9fSiZnpgZjHuuU327G9Uig7yS
	M/Vu96faRN3M/wv557/S35603OGnBd7rgkkBreBrZE6Zo8An/XM9N8aA/uav7H72u2krvVmpJFl
	j
X-Google-Smtp-Source: AGHT+IHj7/rC6+MgPdzUycrVdPOtmwehbAMEt+DhXt5ZjZ8tjcZzwRPVTx4p0go2USwA0CJ8kepgkg==
X-Received: by 2002:a05:651c:506:b0:2d0:d40c:e83b with SMTP id o6-20020a05651c050600b002d0d40ce83bmr1863520ljp.30.1707496843931;
        Fri, 09 Feb 2024 08:40:43 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id tl27-20020a170907c31b00b00a3bfe97fe27sm477724ejc.218.2024.02.09.08.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 08:40:43 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 03/35] include: reduce header dependencies by using "*_types.h"
Date: Fri,  9 Feb 2024 17:39:55 +0100
Message-Id: <20240209164027.2582906-4-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240209164027.2582906-1-max.kellermann@ionos.com>
References: <20240209164027.2582906-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These headers are lighter because they only contain declarations and
do not include many other headers.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/fs_struct.c                                  |  1 +
 include/clocksource/samsung_pwm.h               |  2 +-
 include/crypto/algapi.h                         |  2 +-
 include/crypto/drbg.h                           |  2 +-
 include/crypto/internal/geniv.h                 |  2 +-
 include/drm/drm_bridge.h                        |  2 +-
 include/drm/drm_client.h                        |  2 +-
 include/drm/drm_crtc.h                          |  2 +-
 include/drm/drm_device.h                        |  2 +-
 include/drm/drm_flip_work.h                     |  4 ++--
 include/drm/drm_gem.h                           |  2 +-
 include/drm/drm_gpuvm.h                         |  2 +-
 include/drm/drm_managed.h                       |  2 +-
 include/drm/drm_mipi_dbi.h                      |  2 +-
 include/drm/drm_mm.h                            |  2 +-
 include/drm/drm_mode_config.h                   |  4 ++--
 include/drm/drm_panel.h                         |  2 +-
 include/drm/drm_prime.h                         |  4 ++--
 include/drm/drm_privacy_screen_driver.h         |  2 +-
 include/drm/drm_vblank.h                        |  2 +-
 include/drm/drm_writeback.h                     |  2 +-
 include/drm/gpu_scheduler.h                     |  2 +-
 include/drm/i915_hdcp_interface.h               |  2 +-
 include/drm/i915_pxp_tee_interface.h            |  2 +-
 include/drm/ttm/ttm_pool.h                      |  2 +-
 include/kunit/test.h                            |  2 +-
 include/kvm/arm_arch_timer.h                    |  2 +-
 include/kvm/arm_vgic.h                          |  4 ++--
 include/linux/acpi.h                            |  2 +-
 include/linux/agpgart.h                         |  2 +-
 include/linux/alarmtimer.h                      |  2 +-
 include/linux/backing-dev-defs.h                |  8 ++++----
 include/linux/badblocks.h                       |  2 +-
 include/linux/balloon_compaction.h              |  2 +-
 include/linux/bcm47xx_wdt.h                     |  2 +-
 include/linux/blk-crypto.h                      |  2 +-
 include/linux/blk-mq.h                          |  2 +-
 include/linux/blkdev.h                          |  6 +++---
 include/linux/bpf-cgroup-defs.h                 |  2 +-
 include/linux/bpf-cgroup.h                      |  2 +-
 include/linux/bpf.h                             |  4 ++--
 include/linux/bpf_mem_alloc.h                   |  2 +-
 include/linux/bsg-lib.h                         |  2 +-
 include/linux/capability.h                      |  2 +-
 include/linux/cb710.h                           |  2 +-
 include/linux/ccp.h                             |  2 +-
 include/linux/ceph/libceph.h                    |  2 +-
 include/linux/ceph/messenger.h                  |  4 ++--
 include/linux/ceph/mon_client.h                 |  2 +-
 include/linux/ceph/osd_client.h                 |  4 ++--
 include/linux/ceph/osdmap.h                     |  2 +-
 include/linux/ceph/pagelist.h                   |  2 +-
 include/linux/ceph/string_table.h               |  2 +-
 include/linux/cgroup-defs.h                     |  4 ++--
 include/linux/clk/zynq.h                        |  2 +-
 include/linux/comedi/comedidev.h                |  2 +-
 include/linux/configfs.h                        |  2 +-
 include/linux/connector.h                       |  2 +-
 include/linux/console_struct.h                  |  2 +-
 include/linux/counter.h                         |  2 +-
 include/linux/cpu_rmap.h                        |  2 +-
 include/linux/cpufreq.h                         |  2 +-
 include/linux/cpuset.h                          |  2 +-
 include/linux/cred.h                            |  2 +-
 include/linux/crush/crush.h                     |  2 +-
 include/linux/crypto.h                          |  2 +-
 include/linux/damon.h                           |  2 +-
 include/linux/dcache.h                          |  2 +-
 include/linux/dev_printk.h                      |  2 +-
 include/linux/device-mapper.h                   |  1 -
 include/linux/device.h                          |  4 ++--
 include/linux/dim.h                             |  2 +-
 include/linux/dm-bufio.h                        |  2 +-
 include/linux/edac.h                            |  2 +-
 include/linux/fault-inject.h                    |  2 +-
 include/linux/fb.h                              |  4 ++--
 include/linux/fdtable.h                         |  2 +-
 include/linux/firewire.h                        |  8 ++++----
 include/linux/firmware.h                        |  2 +-
 include/linux/flex_proportions.h                |  6 +++---
 include/linux/fpga/fpga-mgr.h                   |  2 +-
 include/linux/framer/framer.h                   |  4 ++--
 include/linux/fs.h                              |  6 +++---
 include/linux/fs_context.h                      |  4 ++--
 include/linux/fs_struct.h                       |  2 +-
 include/linux/fsl/bestcomm/bestcomm_priv.h      |  2 +-
 include/linux/fsl/bestcomm/sram.h               |  2 +-
 include/linux/gameport.h                        |  2 +-
 include/linux/gfp_api.h                         |  2 +-
 include/linux/gnss.h                            |  2 +-
 include/linux/gpio/driver.h                     |  2 +-
 include/linux/greybus/operation.h               |  4 ++--
 include/linux/hid.h                             |  5 ++---
 include/linux/hp_sdc.h                          |  2 +-
 include/linux/hrtimer.h                         |  4 ++--
 include/linux/hsi/hsi.h                         |  2 +-
 include/linux/hugetlb.h                         |  2 +-
 include/linux/i2c.h                             |  2 +-
 include/linux/i3c/master.h                      |  2 +-
 include/linux/i8253.h                           |  2 +-
 include/linux/idr.h                             |  2 +-
 include/linux/if_eql.h                          |  4 ++--
 include/linux/if_pppox.h                        |  2 +-
 include/linux/igmp.h                            |  4 ++--
 include/linux/iio/buffer-dma.h                  |  4 ++--
 include/linux/inetdevice.h                      |  2 +-
 include/linux/input.h                           |  2 +-
 include/linux/interrupt.h                       |  2 +-
 include/linux/interval_tree.h                   |  3 ++-
 include/linux/iocontext.h                       |  2 +-
 include/linux/iomap.h                           |  2 +-
 include/linux/iova.h                            |  2 +-
 include/linux/ipc.h                             |  4 ++--
 include/linux/irqdesc.h                         |  2 +-
 include/linux/irqdomain.h                       |  2 +-
 include/linux/jbd2.h                            |  4 ++--
 include/linux/journal-head.h                    |  2 +-
 include/linux/kernfs.h                          |  4 ++--
 include/linux/key.h                             |  5 +++--
 include/linux/klist.h                           |  2 +-
 include/linux/kmod.h                            |  2 +-
 include/linux/kmsan.h                           |  2 +-
 include/linux/kobject.h                         |  4 ++--
 include/linux/kprobes.h                         |  2 +-
 include/linux/kref.h                            |  1 -
 include/linux/kvm_host.h                        |  4 ++--
 include/linux/kvm_types.h                       |  2 +-
 include/linux/leds-pca9532.h                    |  2 +-
 include/linux/leds.h                            |  6 +++---
 include/linux/libata.h                          |  2 +-
 include/linux/libnvdimm.h                       |  2 +-
 include/linux/libps2.h                          |  2 +-
 include/linux/lockd/lockd.h                     |  2 +-
 include/linux/lockref.h                         |  2 +-
 include/linux/lp.h                              |  2 +-
 include/linux/mISDNhw.h                         |  2 +-
 include/linux/mailbox_controller.h              |  2 +-
 include/linux/mc146818rtc.h                     |  2 +-
 include/linux/mdio/mdio-xgene.h                 |  2 +-
 include/linux/memory-tiers.h                    |  2 +-
 include/linux/memory.h                          |  2 +-
 include/linux/mempolicy.h                       |  4 ++--
 include/linux/memstick.h                        |  2 +-
 include/linux/mfd/abx500/ab8500.h               |  2 +-
 include/linux/mfd/cs42l43.h                     |  4 ++--
 include/linux/mfd/ipaq-micro.h                  |  2 +-
 include/linux/mfd/lochnagar.h                   |  2 +-
 include/linux/mfd/madera/core.h                 |  2 +-
 include/linux/mfd/max8907.h                     |  2 +-
 include/linux/mfd/mt6397/core.h                 |  2 +-
 include/linux/mfd/mt6397/rtc.h                  |  2 +-
 include/linux/mfd/pcf50633/core.h               |  3 +--
 include/linux/mfd/rc5t583.h                     |  2 +-
 include/linux/mfd/stmpe.h                       |  2 +-
 include/linux/mfd/ucb1x00.h                     |  2 +-
 include/linux/mfd/wm8350/core.h                 |  2 +-
 include/linux/mhi.h                             |  6 +++---
 include/linux/mlx5/driver.h                     |  6 +++---
 include/linux/mm.h                              |  2 +-
 include/linux/mm_types.h                        |  8 ++++----
 include/linux/mmzone.h                          |  7 +++++--
 include/linux/moxtet.h                          |  2 +-
 include/linux/mroute_base.h                     |  2 +-
 include/linux/msi.h                             |  2 +-
 include/linux/mtd/blktrans.h                    |  2 +-
 include/linux/mtd/doc2000.h                     |  2 +-
 include/linux/mtd/flashchip.h                   |  4 ++--
 include/linux/mtd/onenand.h                     |  2 +-
 include/linux/mtd/spinand.h                     |  2 +-
 include/linux/mutex.h                           |  2 +-
 include/linux/netdevice.h                       |  4 ++--
 include/linux/netfs.h                           |  2 +-
 include/linux/netpoll.h                         |  2 +-
 include/linux/nfs4.h                            |  2 +-
 include/linux/nfs_fs.h                          |  4 ++--
 include/linux/nfs_fs_sb.h                       |  2 +-
 include/linux/ns_common.h                       |  2 +-
 include/linux/objpool.h                         |  2 +-
 include/linux/oom.h                             |  2 +-
 include/linux/padata.h                          |  6 +++---
 include/linux/pagemap.h                         |  2 +-
 include/linux/parport.h                         |  2 +-
 include/linux/part_stat.h                       |  2 +-
 include/linux/peci.h                            |  2 +-
 include/linux/percpu-refcount.h                 |  2 +-
 include/linux/percpu_counter.h                  |  2 +-
 include/linux/perf_event.h                      | 10 +++++-----
 include/linux/phy.h                             |  4 ++--
 include/linux/pktcdvd.h                         |  2 +-
 include/linux/platform_data/cros_ec_proto.h     |  2 +-
 include/linux/platform_data/cros_ec_sensorhub.h |  2 +-
 include/linux/platform_data/wilco-ec.h          |  2 +-
 include/linux/platform_data/xilinx-ll-temac.h   |  2 +-
 include/linux/pm.h                              |  6 +++---
 include/linux/pm_domain.h                       |  4 ++--
 include/linux/posix-timers.h                    |  2 +-
 include/linux/power_supply.h                    |  4 ++--
 include/linux/pruss_driver.h                    |  2 +-
 include/linux/psi_types.h                       |  2 +-
 include/linux/pstore.h                          |  4 ++--
 include/linux/qed/qede_rdma.h                   |  2 +-
 include/linux/quota.h                           |  6 +++---
 include/linux/radix-tree.h                      |  1 -
 include/linux/raid/pq.h                         |  2 +-
 include/linux/regmap.h                          |  2 +-
 include/linux/remoteproc.h                      |  2 +-
 include/linux/resctrl.h                         |  5 ++++-
 include/linux/reset/reset-simple.h              |  2 +-
 include/linux/rhashtable-types.h                |  2 +-
 include/linux/rpmsg.h                           |  2 +-
 include/linux/rslib.h                           |  2 +-
 include/linux/rtc.h                             |  2 +-
 include/linux/sched/signal.h                    |  2 +-
 include/linux/sched/user.h                      |  4 ++--
 include/linux/scs.h                             |  2 +-
 include/linux/seq_file.h                        |  2 +-
 include/linux/serial_core.h                     |  1 -
 include/linux/serio.h                           |  2 +-
 include/linux/slab.h                            |  2 +-
 include/linux/soc/qcom/apr.h                    |  2 +-
 include/linux/soc/qcom/qmi.h                    |  2 +-
 include/linux/ssb/ssb.h                         |  2 +-
 include/linux/ssb/ssb_driver_gige.h             |  2 +-
 include/linux/stackdepot.h                      |  2 +-
 include/linux/stat.h                            |  2 +-
 include/linux/sunrpc/auth_gss.h                 |  2 +-
 include/linux/sunrpc/clnt.h                     |  2 +-
 include/linux/sunrpc/metrics.h                  |  2 +-
 include/linux/sunrpc/sched.h                    |  4 ++--
 include/linux/sunrpc/types.h                    |  4 ++--
 include/linux/swait.h                           |  2 +-
 include/linux/swap.h                            |  2 +-
 include/linux/swap_slots.h                      |  4 ++--
 include/linux/swiotlb.h                         |  4 ++--
 include/linux/sysctl.h                          |  4 ++--
 include/linux/sysfs.h                           |  2 +-
 include/linux/thermal.h                         |  2 +-
 include/linux/thunderbolt.h                     |  2 +-
 include/linux/tifm.h                            |  4 ++--
 include/linux/tty.h                             |  4 ++--
 include/linux/tty_buffer.h                      |  4 ++--
 include/linux/tty_ldisc.h                       |  2 +-
 include/linux/tty_port.h                        |  2 +-
 include/linux/umh.h                             |  4 ++--
 include/linux/usb.h                             |  2 +-
 include/linux/usb/gadget.h                      |  2 +-
 include/linux/usb/ljca.h                        |  2 +-
 include/linux/usb/otg-fsm.h                     |  2 +-
 include/linux/usb/serial.h                      |  2 +-
 include/linux/user_namespace.h                  |  2 +-
 include/linux/vfio.h                            |  2 +-
 include/linux/vfio_pci_core.h                   |  2 +-
 include/linux/via-core.h                        |  2 +-
 include/linux/virtio.h                          |  4 ++--
 include/linux/vmalloc.h                         |  2 +-
 include/linux/vmpressure.h                      |  6 +++---
 include/linux/vmw_vmci_api.h                    |  2 +-
 include/linux/xarray.h                          |  2 +-
 include/media/dmxdev.h                          |  6 +++---
 include/media/drv-intf/saa7146.h                |  2 +-
 include/media/dvb_demux.h                       |  4 ++--
 include/media/dvb_frontend.h                    |  2 +-
 include/media/dvb_ringbuffer.h                  |  2 +-
 include/media/dvb_vb2.h                         |  2 +-
 include/media/i2c/adp1653.h                     |  2 +-
 include/media/media-device.h                    |  2 +-
 include/media/rc-core.h                         |  2 +-
 include/media/v4l2-dev.h                        |  2 +-
 include/media/videobuf2-core.h                  |  2 +-
 include/net/af_unix.h                           |  4 ++--
 include/net/af_vsock.h                          |  2 +-
 include/net/atmclip.h                           |  2 +-
 include/net/ax25.h                              |  4 ++--
 include/net/cfg802154.h                         |  2 +-
 include/net/devlink.h                           |  8 ++++----
 include/net/dst.h                               |  2 +-
 include/net/flow.h                              |  2 +-
 include/net/fq.h                                |  2 +-
 include/net/hwbm.h                              |  2 +-
 include/net/inet_connection_sock.h              |  2 +-
 include/net/inet_hashtables.h                   |  2 +-
 include/net/inet_timewait_sock.h                |  2 +-
 include/net/ip6_fib.h                           |  2 +-
 include/net/ip_vs.h                             |  6 +++---
 include/net/lib80211.h                          |  2 +-
 include/net/llc.h                               |  2 +-
 include/net/llc_conn.h                          |  2 +-
 include/net/neighbour.h                         |  2 +-
 include/net/netfilter/nf_conntrack_count.h      |  2 +-
 include/net/netns/can.h                         |  4 ++--
 include/net/netns/conntrack.h                   |  1 -
 include/net/netns/ipv4.h                        |  4 ++--
 include/net/netns/mctp.h                        |  2 +-
 include/net/netns/nexthop.h                     |  2 +-
 include/net/netns/packet.h                      |  2 +-
 include/net/netns/sctp.h                        |  2 +-
 include/net/netns/smc.h                         |  2 +-
 include/net/netns/unix.h                        |  2 +-
 include/net/netns/xdp.h                         |  2 +-
 include/net/netns/xfrm.h                        |  2 +-
 include/net/phonet/pn_dev.h                     |  2 +-
 include/net/sch_generic.h                       |  2 +-
 include/net/sctp/sctp.h                         |  2 +-
 include/net/sctp/structs.h                      |  2 +-
 include/net/smc.h                               |  2 +-
 include/net/sock.h                              |  4 ++--
 include/net/sock_reuseport.h                    |  2 +-
 include/net/tls.h                               |  2 +-
 include/net/xdp_sock.h                          |  6 +++---
 include/net/xfrm.h                              |  2 +-
 include/pcmcia/ss.h                             |  2 +-
 include/rdma/ib_verbs.h                         |  2 +-
 include/rdma/rdma_counter.h                     |  2 +-
 include/rdma/rdma_vt.h                          |  2 +-
 include/scsi/libfc.h                            |  2 +-
 include/scsi/libfcoe.h                          |  2 +-
 include/scsi/libiscsi.h                         |  6 +++---
 include/scsi/libsas.h                           |  2 +-
 include/scsi/scsi_cmnd.h                        |  2 +-
 include/scsi/scsi_device.h                      |  4 ++--
 include/scsi/scsi_host.h                        |  4 ++--
 include/scsi/scsi_tcq.h                         |  2 +-
 include/scsi/scsi_transport.h                   |  2 +-
 include/scsi/scsi_transport_iscsi.h             |  2 +-
 include/scsi/scsi_transport_sas.h               |  2 +-
 include/scsi/scsi_transport_spi.h               |  2 +-
 include/scsi/scsi_transport_srp.h               |  2 +-
 include/soc/fsl/qe/qe.h                         |  2 +-
 include/sound/ac97_codec.h                      |  2 +-
 include/sound/core.h                            |  2 +-
 include/sound/emu10k1.h                         |  2 +-
 include/sound/rawmidi.h                         |  6 +++---
 include/sound/util_mem.h                        |  2 +-
 include/target/iscsi/iscsi_target_stat.h        |  2 +-
 include/trace/events/block.h                    |  2 +-
 include/trace/events/kyber.h                    |  2 +-
 include/trace/events/lock.h                     |  2 +-
 include/trace/events/mmc.h                      |  2 +-
 include/trace/events/workqueue.h                |  2 +-
 339 files changed, 441 insertions(+), 439 deletions(-)

diff --git a/fs/fs_struct.c b/fs/fs_struct.c
index 64c2d0814ed6..42f5072413c0 100644
--- a/fs/fs_struct.c
+++ b/fs/fs_struct.c
@@ -4,6 +4,7 @@
 #include <linux/sched/task.h>
 #include <linux/fs.h>
 #include <linux/path.h>
+#include <linux/seqlock.h>
 #include <linux/slab.h>
 #include <linux/fs_struct.h>
 #include "internal.h"
diff --git a/include/clocksource/samsung_pwm.h b/include/clocksource/samsung_pwm.h
index 9b435caa95fe..a33c84f9bf32 100644
--- a/include/clocksource/samsung_pwm.h
+++ b/include/clocksource/samsung_pwm.h
@@ -5,7 +5,7 @@
 #ifndef __CLOCKSOURCE_SAMSUNG_PWM_H
 #define __CLOCKSOURCE_SAMSUNG_PWM_H
 
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 
 #define SAMSUNG_PWM_NUM		5
 
diff --git a/include/crypto/algapi.h b/include/crypto/algapi.h
index 7a4a71af653f..6898af8cf182 100644
--- a/include/crypto/algapi.h
+++ b/include/crypto/algapi.h
@@ -12,7 +12,7 @@
 #include <linux/cache.h>
 #include <linux/crypto.h>
 #include <linux/types.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 
 /*
  * Maximum values for blocksize and alignmask, used to allocate
diff --git a/include/crypto/drbg.h b/include/crypto/drbg.h
index e78a671a9e76..35dd65e37c8d 100644
--- a/include/crypto/drbg.h
+++ b/include/crypto/drbg.h
@@ -50,7 +50,7 @@
 #include <crypto/internal/rng.h>
 #include <crypto/rng.h>
 #include <linux/fips.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/list.h>
 
 /*
diff --git a/include/crypto/internal/geniv.h b/include/crypto/internal/geniv.h
index 7fd7126f593a..3228b4a34c52 100644
--- a/include/crypto/internal/geniv.h
+++ b/include/crypto/internal/geniv.h
@@ -9,7 +9,7 @@
 #define _CRYPTO_INTERNAL_GENIV_H
 
 #include <crypto/internal/aead.h>
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <linux/types.h>
 
 struct aead_geniv_ctx {
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index ee12f829aaf7..dfb6debd996a 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -25,7 +25,7 @@
 
 #include <linux/ctype.h>
 #include <linux/list.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_encoder.h>
diff --git a/include/drm/drm_client.h b/include/drm/drm_client.h
index d47458ecdac4..2af71d481957 100644
--- a/include/drm/drm_client.h
+++ b/include/drm/drm_client.h
@@ -5,7 +5,7 @@
 
 #include <linux/iosys-map.h>
 #include <linux/lockdep.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/types.h>
 
 #include <drm/drm_connector.h>
diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index 8b48a1974da3..a73d94b1c2fd 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -25,7 +25,7 @@
 #ifndef __DRM_CRTC_H__
 #define __DRM_CRTC_H__
 
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <linux/types.h>
 #include <drm/drm_modeset_lock.h>
 #include <drm/drm_mode_object.h>
diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h
index 63767cf24371..6a1bbdd515cd 100644
--- a/include/drm/drm_device.h
+++ b/include/drm/drm_device.h
@@ -3,7 +3,7 @@
 
 #include <linux/list.h>
 #include <linux/kref.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/idr.h>
 
 #include <drm/drm_mode_config.h>
diff --git a/include/drm/drm_flip_work.h b/include/drm/drm_flip_work.h
index 1eef3283a109..380720e0963e 100644
--- a/include/drm/drm_flip_work.h
+++ b/include/drm/drm_flip_work.h
@@ -25,8 +25,8 @@
 #define DRM_FLIP_WORK_H
 
 #include <linux/kfifo.h>
-#include <linux/spinlock.h>
-#include <linux/workqueue.h>
+#include <linux/spinlock_types.h>
+#include <linux/workqueue_types.h>
 
 /**
  * DOC: flip utils
diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index 369505447acd..e2257ca92bec 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -37,7 +37,7 @@
 #include <linux/kref.h>
 #include <linux/dma-resv.h>
 #include <linux/list.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 
 #include <drm/drm_vma_manager.h>
 
diff --git a/include/drm/drm_gpuvm.h b/include/drm/drm_gpuvm.h
index 00d4e43b76b6..5a179fe991cc 100644
--- a/include/drm/drm_gpuvm.h
+++ b/include/drm/drm_gpuvm.h
@@ -27,7 +27,7 @@
 
 #include <linux/dma-resv.h>
 #include <linux/list.h>
-#include <linux/rbtree.h>
+#include <linux/rbtree_types.h>
 #include <linux/types.h>
 
 #include <drm/drm_device.h>
diff --git a/include/drm/drm_managed.h b/include/drm/drm_managed.h
index f547b09ca023..7ab32e172353 100644
--- a/include/drm/drm_managed.h
+++ b/include/drm/drm_managed.h
@@ -3,7 +3,7 @@
 #ifndef _DRM_MANAGED_H_
 #define _DRM_MANAGED_H_
 
-#include <linux/gfp.h>
+#include <linux/gfp_types.h>
 #include <linux/overflow.h>
 #include <linux/types.h>
 
diff --git a/include/drm/drm_mipi_dbi.h b/include/drm/drm_mipi_dbi.h
index e8e0f8d39f3a..4cbc82e23320 100644
--- a/include/drm/drm_mipi_dbi.h
+++ b/include/drm/drm_mipi_dbi.h
@@ -8,7 +8,7 @@
 #ifndef __LINUX_MIPI_DBI_H
 #define __LINUX_MIPI_DBI_H
 
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <drm/drm_device.h>
 #include <drm/drm_simple_kms_helper.h>
 
diff --git a/include/drm/drm_mm.h b/include/drm/drm_mm.h
index abc1d1d48142..963656c94507 100644
--- a/include/drm/drm_mm.h
+++ b/include/drm/drm_mm.h
@@ -38,7 +38,7 @@
  * Generic range manager structs
  */
 #include <linux/bug.h>
-#include <linux/rbtree.h>
+#include <linux/rbtree_types.h>
 #include <linux/limits.h>
 #include <linux/mm_types.h>
 #include <linux/list.h>
diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
index 973119a9176b..526c57657fb6 100644
--- a/include/drm/drm_mode_config.h
+++ b/include/drm/drm_mode_config.h
@@ -23,10 +23,10 @@
 #ifndef __DRM_MODE_CONFIG_H__
 #define __DRM_MODE_CONFIG_H__
 
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/types.h>
 #include <linux/idr.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 #include <linux/llist.h>
 
 #include <drm/drm_modeset_lock.h>
diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
index 10015891b056..23d3b88a50e3 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -27,7 +27,7 @@
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/list.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 
 struct backlight_device;
 struct dentry;
diff --git a/include/drm/drm_prime.h b/include/drm/drm_prime.h
index 2a1d01e5b56b..057491baf262 100644
--- a/include/drm/drm_prime.h
+++ b/include/drm/drm_prime.h
@@ -32,8 +32,8 @@
 #ifndef __DRM_PRIME_H__
 #define __DRM_PRIME_H__
 
-#include <linux/mutex.h>
-#include <linux/rbtree.h>
+#include <linux/mutex_types.h>
+#include <linux/rbtree_types.h>
 #include <linux/scatterlist.h>
 
 /**
diff --git a/include/drm/drm_privacy_screen_driver.h b/include/drm/drm_privacy_screen_driver.h
index 4ef246d5706f..88097a1d7b99 100644
--- a/include/drm/drm_privacy_screen_driver.h
+++ b/include/drm/drm_privacy_screen_driver.h
@@ -11,7 +11,7 @@
 
 #include <linux/device.h>
 #include <linux/list.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <drm/drm_connector.h>
 
 struct drm_privacy_screen;
diff --git a/include/drm/drm_vblank.h b/include/drm/drm_vblank.h
index 7f3957943dd1..1a031507c128 100644
--- a/include/drm/drm_vblank.h
+++ b/include/drm/drm_vblank.h
@@ -24,7 +24,7 @@
 #ifndef _DRM_VBLANK_H_
 #define _DRM_VBLANK_H_
 
-#include <linux/seqlock.h>
+#include <linux/seqlock_types.h>
 #include <linux/idr.h>
 #include <linux/poll.h>
 #include <linux/kthread.h>
diff --git a/include/drm/drm_writeback.h b/include/drm/drm_writeback.h
index 17e576c80169..826b348e2c95 100644
--- a/include/drm/drm_writeback.h
+++ b/include/drm/drm_writeback.h
@@ -13,7 +13,7 @@
 #define __DRM_WRITEBACK_H__
 #include <drm/drm_connector.h>
 #include <drm/drm_encoder.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 
 /**
  * struct drm_writeback_connector - DRM writeback connector
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 4c598cfc2af3..4edd7ac64b62 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -29,7 +29,7 @@
 #include <linux/completion.h>
 #include <linux/xarray.h>
 #include <linux/wait.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 
 #define MAX_WAIT_SCHED_ENTITY_Q_EMPTY msecs_to_jiffies(1000)
 
diff --git a/include/drm/i915_hdcp_interface.h b/include/drm/i915_hdcp_interface.h
index 4c9c8167c2d5..a8237d271ad8 100644
--- a/include/drm/i915_hdcp_interface.h
+++ b/include/drm/i915_hdcp_interface.h
@@ -9,7 +9,7 @@
 #ifndef _I915_HDCP_INTERFACE_H_
 #define _I915_HDCP_INTERFACE_H_
 
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/device.h>
 #include <drm/display/drm_hdcp.h>
 
diff --git a/include/drm/i915_pxp_tee_interface.h b/include/drm/i915_pxp_tee_interface.h
index 7d96985f2d05..4639d9fba19a 100644
--- a/include/drm/i915_pxp_tee_interface.h
+++ b/include/drm/i915_pxp_tee_interface.h
@@ -6,7 +6,7 @@
 #ifndef _I915_PXP_TEE_INTERFACE_H_
 #define _I915_PXP_TEE_INTERFACE_H_
 
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/device.h>
 struct scatterlist;
 
diff --git a/include/drm/ttm/ttm_pool.h b/include/drm/ttm/ttm_pool.h
index 4490d43c63e3..b5038049062a 100644
--- a/include/drm/ttm/ttm_pool.h
+++ b/include/drm/ttm/ttm_pool.h
@@ -28,7 +28,7 @@
 
 #include <linux/mmzone.h>
 #include <linux/llist.h>
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <drm/ttm/ttm_caching.h>
 
 struct device;
diff --git a/include/kunit/test.h b/include/kunit/test.h
index a82e025df09e..d26732aa03f5 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -22,7 +22,7 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/slab.h>
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <linux/sprintf.h>
 #include <linux/string.h>
 #include <linux/types.h>
diff --git a/include/kvm/arm_arch_timer.h b/include/kvm/arm_arch_timer.h
index c819c5d16613..c271865175b0 100644
--- a/include/kvm/arm_arch_timer.h
+++ b/include/kvm/arm_arch_timer.h
@@ -8,7 +8,7 @@
 #define __ASM_ARM_KVM_ARCH_TIMER_H
 
 #include <linux/clocksource.h>
-#include <linux/hrtimer.h>
+#include <linux/hrtimer_types.h>
 
 enum kvm_arch_timers {
 	TIMER_PTIMER,
diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index 8cc38e836f54..c1c4a6266b58 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -9,8 +9,8 @@
 #include <linux/kvm.h>
 #include <linux/irqreturn.h>
 #include <linux/kref.h>
-#include <linux/mutex.h>
-#include <linux/spinlock.h>
+#include <linux/mutex_types.h>
+#include <linux/spinlock_types.h>
 #include <linux/static_key.h>
 #include <linux/types.h>
 #include <kvm/iodev.h>
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index b7165e52b3c6..3beab76d31d4 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -30,7 +30,7 @@ struct irq_domain_ops;
 #include <linux/list.h>
 #include <linux/dynamic_debug.h>
 #include <linux/module.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/fw_table.h>
 
 #include <acpi/acpi_bus.h>
diff --git a/include/linux/agpgart.h b/include/linux/agpgart.h
index 21b34a96cfd8..56d8db3784c1 100644
--- a/include/linux/agpgart.h
+++ b/include/linux/agpgart.h
@@ -26,7 +26,7 @@
 #ifndef _AGP_H
 #define _AGP_H 1
 
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/agp_backend.h>
 #include <uapi/linux/agpgart.h>
 
diff --git a/include/linux/alarmtimer.h b/include/linux/alarmtimer.h
index 05e758b8b894..92d10358e2f0 100644
--- a/include/linux/alarmtimer.h
+++ b/include/linux/alarmtimer.h
@@ -3,7 +3,7 @@
 #define _LINUX_ALARMTIMER_H
 
 #include <linux/time.h>
-#include <linux/hrtimer.h>
+#include <linux/hrtimer_types.h>
 #include <linux/timerqueue.h>
 
 struct rtc_device;
diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index 7bf50450cd69..977f0323383d 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -4,14 +4,14 @@
 
 #include <linux/list.h>
 #include <linux/radix-tree.h>
-#include <linux/rbtree.h>
-#include <linux/spinlock.h>
+#include <linux/rbtree_types.h>
+#include <linux/spinlock_types.h>
 #include <linux/percpu_counter.h>
 #include <linux/percpu-refcount.h>
 #include <linux/flex_proportions.h>
-#include <linux/timer.h>
+#include <linux/timer_types.h>
 #include <linux/wait.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 #include <linux/kref.h>
 
 #ifdef CONFIG_CGROUP_WRITEBACK
diff --git a/include/linux/badblocks.h b/include/linux/badblocks.h
index 670f2dae692f..bd14c9de160a 100644
--- a/include/linux/badblocks.h
+++ b/include/linux/badblocks.h
@@ -2,7 +2,7 @@
 #ifndef _LINUX_BADBLOCKS_H
 #define _LINUX_BADBLOCKS_H
 
-#include <linux/seqlock.h>
+#include <linux/seqlock_types.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/stddef.h>
diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index 5ca2d5699620..6538ca2674a9 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -39,7 +39,7 @@
 #include <linux/pagemap.h>
 #include <linux/page-flags.h>
 #include <linux/migrate.h>
-#include <linux/gfp.h>
+#include <linux/gfp_types.h>
 #include <linux/err.h>
 #include <linux/fs.h>
 #include <linux/list.h>
diff --git a/include/linux/bcm47xx_wdt.h b/include/linux/bcm47xx_wdt.h
index fc9dcdb4b979..4198a11e2077 100644
--- a/include/linux/bcm47xx_wdt.h
+++ b/include/linux/bcm47xx_wdt.h
@@ -2,7 +2,7 @@
 #ifndef LINUX_BCM47XX_WDT_H_
 #define LINUX_BCM47XX_WDT_H_
 
-#include <linux/timer.h>
+#include <linux/timer_types.h>
 #include <linux/types.h>
 #include <linux/watchdog.h>
 
diff --git a/include/linux/blk-crypto.h b/include/linux/blk-crypto.h
index 5e5822c18ee4..c1463dcedc84 100644
--- a/include/linux/blk-crypto.h
+++ b/include/linux/blk-crypto.h
@@ -70,7 +70,7 @@ struct bio_crypt_ctx {
 };
 
 #include <linux/blk_types.h>
-#include <linux/blkdev.h>
+#include <linux/blk_types.h>
 
 #ifdef CONFIG_BLK_INLINE_ENCRYPTION
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index d3e9e69aaa3c..ed3760b04baa 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -5,7 +5,7 @@
 #include <linux/bio.h>
 #include <linux/blkdev.h>
 #include <linux/sbitmap.h>
-#include <linux/lockdep.h>
+#include <linux/lockdep_types.h>
 #include <linux/scatterlist.h>
 #include <linux/prefetch.h>
 #include <linux/srcu.h>
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 94d7d5f51202..26344147adec 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -11,11 +11,11 @@
 #include <linux/device.h>
 #include <linux/list.h>
 #include <linux/minmax.h>
-#include <linux/timer.h>
-#include <linux/workqueue.h>
+#include <linux/timer_types.h>
+#include <linux/workqueue_types.h>
 #include <linux/wait.h>
 #include <linux/bio.h>
-#include <linux/gfp.h>
+#include <linux/gfp_types.h>
 #include <linux/kdev_t.h>
 #include <linux/rcupdate.h>
 #include <linux/percpu-refcount.h>
diff --git a/include/linux/bpf-cgroup-defs.h b/include/linux/bpf-cgroup-defs.h
index 0985221d5478..f3b400858129 100644
--- a/include/linux/bpf-cgroup-defs.h
+++ b/include/linux/bpf-cgroup-defs.h
@@ -6,7 +6,7 @@
 
 #include <linux/list.h>
 #include <linux/percpu-refcount.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 
 struct bpf_prog_array;
 
diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index a789266feac3..4b214fa7da47 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -7,7 +7,7 @@
 #include <linux/errno.h>
 #include <linux/jump_label.h>
 #include <linux/percpu.h>
-#include <linux/rbtree.h>
+#include <linux/rbtree_types.h>
 #include <net/sock.h>
 #include <uapi/linux/bpf.h>
 
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 34b065a064c9..c5c435d04460 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -7,14 +7,14 @@
 #include <uapi/linux/bpf.h>
 #include <uapi/linux/filter.h>
 
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 #include <linux/file.h>
 #include <linux/percpu.h>
 #include <linux/err.h>
 #include <linux/rbtree_latch.h>
 #include <linux/numa.h>
 #include <linux/mm_types.h>
-#include <linux/refcount.h>
+#include <linux/refcount_types.h>
 #include <linux/mutex.h>
 #include <linux/module.h>
 #include <linux/kallsyms.h> // for KSYM_NAME_LEN
diff --git a/include/linux/bpf_mem_alloc.h b/include/linux/bpf_mem_alloc.h
index aaf004d94322..7512e136ad5f 100644
--- a/include/linux/bpf_mem_alloc.h
+++ b/include/linux/bpf_mem_alloc.h
@@ -3,7 +3,7 @@
 #ifndef _BPF_MEM_ALLOC_H
 #define _BPF_MEM_ALLOC_H
 #include <linux/compiler_types.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 
 struct bpf_mem_cache;
 struct bpf_mem_caches;
diff --git a/include/linux/bsg-lib.h b/include/linux/bsg-lib.h
index 9e97ced2896d..2f7a68344e42 100644
--- a/include/linux/bsg-lib.h
+++ b/include/linux/bsg-lib.h
@@ -9,7 +9,7 @@
 #ifndef _BLK_BSG_
 #define _BLK_BSG_
 
-#include <linux/blkdev.h>
+#include <linux/blk_types.h>
 
 struct bsg_job;
 struct request;
diff --git a/include/linux/capability.h b/include/linux/capability.h
index 0c356a517991..da2aa81391f6 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -14,7 +14,7 @@
 #define _LINUX_CAPABILITY_H
 
 #include <uapi/linux/capability.h>
-#include <linux/uidgid.h>
+#include <linux/uidgid_types.h>
 #include <linux/bits.h>
 
 #define _KERNEL_CAPABILITY_VERSION _LINUX_CAPABILITY_VERSION_3
diff --git a/include/linux/cb710.h b/include/linux/cb710.h
index 405657a9a0d5..6ad1ccf3b79c 100644
--- a/include/linux/cb710.h
+++ b/include/linux/cb710.h
@@ -9,7 +9,7 @@
 
 #include <linux/io.h>
 #include <linux/interrupt.h>
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/mmc/host.h>
diff --git a/include/linux/ccp.h b/include/linux/ccp.h
index 868924dec5a1..d3635efdbdef 100644
--- a/include/linux/ccp.h
+++ b/include/linux/ccp.h
@@ -12,7 +12,7 @@
 #define __CCP_H__
 
 #include <linux/scatterlist.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 #include <linux/list.h>
 #include <crypto/aes.h>
 #include <crypto/sha1.h>
diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
index b86a567e9493..d01be9103e56 100644
--- a/include/linux/ceph/libceph.h
+++ b/include/linux/ceph/libceph.h
@@ -14,7 +14,7 @@
 #include <linux/wait.h>
 #include <linux/writeback.h>
 #include <linux/slab.h>
-#include <linux/refcount.h>
+#include <linux/refcount_types.h>
 
 #include <linux/ceph/types.h>
 #include <linux/ceph/messenger.h>
diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 730a9cf017dd..577de5f3ef17 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -5,10 +5,10 @@
 #include <linux/bvec.h>
 #include <linux/crypto.h>
 #include <linux/kref.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/net.h>
 #include <linux/uio.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 #include <net/net_namespace.h>
 
 #include <linux/ceph/types.h>
diff --git a/include/linux/ceph/mon_client.h b/include/linux/ceph/mon_client.h
index 7a9a40163c0f..8226ea42fc78 100644
--- a/include/linux/ceph/mon_client.h
+++ b/include/linux/ceph/mon_client.h
@@ -4,7 +4,7 @@
 
 #include <linux/completion.h>
 #include <linux/kref.h>
-#include <linux/rbtree.h>
+#include <linux/rbtree_types.h>
 
 #include <linux/ceph/messenger.h>
 
diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index f66f6aac74f6..baa9629186ec 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -6,8 +6,8 @@
 #include <linux/completion.h>
 #include <linux/kref.h>
 #include <linux/mempool.h>
-#include <linux/rbtree.h>
-#include <linux/refcount.h>
+#include <linux/rbtree_types.h>
+#include <linux/refcount_types.h>
 #include <linux/ktime.h>
 
 #include <linux/ceph/types.h>
diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.h
index 5553019c3f07..44ba159f56e7 100644
--- a/include/linux/ceph/osdmap.h
+++ b/include/linux/ceph/osdmap.h
@@ -2,7 +2,7 @@
 #ifndef _FS_CEPH_OSDMAP_H
 #define _FS_CEPH_OSDMAP_H
 
-#include <linux/rbtree.h>
+#include <linux/rbtree_types.h>
 #include <linux/ceph/types.h>
 #include <linux/ceph/decode.h>
 #include <linux/crush/crush.h>
diff --git a/include/linux/ceph/pagelist.h b/include/linux/ceph/pagelist.h
index 5dead8486fd8..2eaa150695d7 100644
--- a/include/linux/ceph/pagelist.h
+++ b/include/linux/ceph/pagelist.h
@@ -3,7 +3,7 @@
 #define __FS_CEPH_PAGELIST_H
 
 #include <asm/byteorder.h>
-#include <linux/refcount.h>
+#include <linux/refcount_types.h>
 #include <linux/list.h>
 #include <linux/types.h>
 
diff --git a/include/linux/ceph/string_table.h b/include/linux/ceph/string_table.h
index a4a9962d1e14..c016ca326f35 100644
--- a/include/linux/ceph/string_table.h
+++ b/include/linux/ceph/string_table.h
@@ -4,7 +4,7 @@
 
 #include <linux/types.h>
 #include <linux/kref.h>
-#include <linux/rbtree.h>
+#include <linux/rbtree_types.h>
 #include <linux/rcupdate.h>
 
 struct ceph_string {
diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index ea48c861cd36..380a59b31624 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -12,9 +12,9 @@
 #include <linux/list.h>
 #include <linux/idr.h>
 #include <linux/wait.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/rcupdate.h>
-#include <linux/refcount.h>
+#include <linux/refcount_types.h>
 #include <linux/percpu-refcount.h>
 #include <linux/percpu-rwsem.h>
 #include <linux/u64_stats_sync.h>
diff --git a/include/linux/clk/zynq.h b/include/linux/clk/zynq.h
index a198dd9255a4..c8feff296da2 100644
--- a/include/linux/clk/zynq.h
+++ b/include/linux/clk/zynq.h
@@ -7,7 +7,7 @@
 #ifndef __LINUX_CLK_ZYNQ_H_
 #define __LINUX_CLK_ZYNQ_H_
 
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 
 void zynq_clock_init(void);
 
diff --git a/include/linux/comedi/comedidev.h b/include/linux/comedi/comedidev.h
index c08416a7364b..bde0255d4406 100644
--- a/include/linux/comedi/comedidev.h
+++ b/include/linux/comedi/comedidev.h
@@ -11,7 +11,7 @@
 #define _COMEDIDEV_H
 
 #include <linux/dma-mapping.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/spinlock_types.h>
 #include <linux/rwsem.h>
 #include <linux/kref.h>
diff --git a/include/linux/configfs.h b/include/linux/configfs.h
index 2606711adb18..4a8326e7342b 100644
--- a/include/linux/configfs.h
+++ b/include/linux/configfs.h
@@ -23,7 +23,7 @@
 #include <linux/types.h>  /* ssize_t */
 #include <linux/list.h>   /* struct list_head */
 #include <linux/kref.h>   /* struct kref */
-#include <linux/mutex.h>  /* struct mutex */
+#include <linux/mutex_types.h> /* struct mutex */
 
 #define CONFIGFS_ITEM_NAME_LEN	20
 
diff --git a/include/linux/connector.h b/include/linux/connector.h
index c85ddfc2094e..34fc5023782c 100644
--- a/include/linux/connector.h
+++ b/include/linux/connector.h
@@ -9,7 +9,7 @@
 #define __CONNECTOR_H
 
 
-#include <linux/refcount.h>
+#include <linux/refcount_types.h>
 
 #include <linux/list.h>
 
diff --git a/include/linux/console_struct.h b/include/linux/console_struct.h
index 20f564e98552..a0142b93eaf9 100644
--- a/include/linux/console_struct.h
+++ b/include/linux/console_struct.h
@@ -15,7 +15,7 @@
 
 #include <linux/wait.h>
 #include <linux/vt.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 
 struct uni_pagedict;
 
diff --git a/include/linux/counter.h b/include/linux/counter.h
index b767b5c821f5..846b94517c5b 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -10,7 +10,7 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/kfifo.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/spinlock_types.h>
 #include <linux/types.h>
 #include <linux/wait.h>
diff --git a/include/linux/cpu_rmap.h b/include/linux/cpu_rmap.h
index cae324d10965..effe8bef0a3a 100644
--- a/include/linux/cpu_rmap.h
+++ b/include/linux/cpu_rmap.h
@@ -8,7 +8,7 @@
  */
 
 #include <linux/cpumask.h>
-#include <linux/gfp.h>
+#include <linux/gfp_types.h>
 #include <linux/slab.h>
 #include <linux/kref.h>
 
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index a57fc74a83d0..fe1c13de0df4 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -17,7 +17,7 @@
 #include <linux/of.h>
 #include <linux/pm_opp.h>
 #include <linux/pm_qos.h>
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <linux/sysfs.h>
 #include <linux/minmax.h>
 
diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 875d12598bd2..38370bd20f2f 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -13,7 +13,7 @@
 #include <linux/sched/topology.h>
 #include <linux/sched/task.h>
 #include <linux/cpumask.h>
-#include <linux/nodemask.h>
+#include <linux/nodemask_types.h>
 #include <linux/mm.h>
 #include <linux/mmu_context.h>
 #include <linux/jump_label.h>
diff --git a/include/linux/cred.h b/include/linux/cred.h
index 2976f534a7a3..0c35c0e3084e 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -13,7 +13,7 @@
 #include <linux/key.h>
 #include <linux/atomic.h>
 #include <linux/refcount.h>
-#include <linux/uidgid.h>
+#include <linux/uidgid_types.h>
 #include <linux/sched.h>
 #include <linux/sched/user.h>
 
diff --git a/include/linux/crush/crush.h b/include/linux/crush/crush.h
index 30dba392b730..e32c10fb647a 100644
--- a/include/linux/crush/crush.h
+++ b/include/linux/crush/crush.h
@@ -3,7 +3,7 @@
 #define CEPH_CRUSH_CRUSH_H
 
 #ifdef __KERNEL__
-# include <linux/rbtree.h>
+# include <linux/rbtree_types.h>
 # include <linux/types.h>
 #else
 # include "crush_compat.h"
diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index b164da5e129e..5c82ca3ab80d 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -13,7 +13,7 @@
 #define _LINUX_CRYPTO_H
 
 #include <linux/completion.h>
-#include <linux/refcount.h>
+#include <linux/refcount_types.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 
diff --git a/include/linux/damon.h b/include/linux/damon.h
index 5881e4ac30be..584cbafda006 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -9,7 +9,7 @@
 #define _DAMON_H_
 
 #include <linux/memcontrol.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/time64.h>
 #include <linux/types.h>
 #include <linux/random.h>
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index bf53e3894aae..04ab9e67046c 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -8,7 +8,7 @@
 #include <linux/rculist.h>
 #include <linux/rculist_bl.h>
 #include <linux/spinlock.h>
-#include <linux/seqlock.h>
+#include <linux/seqlock_types.h>
 #include <linux/cache.h>
 #include <linux/rcupdate.h>
 #include <linux/lockref.h>
diff --git a/include/linux/dev_printk.h b/include/linux/dev_printk.h
index 828afbf8b045..0d9fc87e7f09 100644
--- a/include/linux/dev_printk.h
+++ b/include/linux/dev_printk.h
@@ -14,7 +14,7 @@
 #include <linux/compiler.h>
 #include <linux/stdarg.h>
 #include <linux/types.h>
-#include <linux/ratelimit.h>
+#include <linux/ratelimit_types.h>
 
 #ifndef dev_fmt
 #define dev_fmt(fmt) fmt
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 43260a6f6b79..109117fe0ffd 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -13,7 +13,6 @@
 #include <linux/blkdev.h>
 #include <linux/dm-ioctl.h>
 #include <linux/math64.h>
-#include <linux/ratelimit.h>
 #include <linux/sprintf.h> // for scnprintf()
 
 struct dm_dev;
diff --git a/include/linux/device.h b/include/linux/device.h
index 5e47c9b5d0fa..235c780b5b65 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -22,8 +22,8 @@
 #include <linux/compiler.h>
 #include <linux/types.h>
 #include <linux/mutex.h>
-#include <linux/uidgid.h>
-#include <linux/gfp.h>
+#include <linux/uidgid_types.h>
+#include <linux/gfp_types.h>
 #include <linux/overflow.h>
 #include <linux/device/bus.h>
 #include <linux/device/class.h>
diff --git a/include/linux/dim.h b/include/linux/dim.h
index f343bc9aa2ec..e4ff5829963f 100644
--- a/include/linux/dim.h
+++ b/include/linux/dim.h
@@ -8,7 +8,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/types.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 
 /*
  * Number of events between DIM iterations.
diff --git a/include/linux/dm-bufio.h b/include/linux/dm-bufio.h
index d1503b815a78..f2b6d9a5fa97 100644
--- a/include/linux/dm-bufio.h
+++ b/include/linux/dm-bufio.h
@@ -10,7 +10,7 @@
 #ifndef _LINUX_DM_BUFIO_H
 #define _LINUX_DM_BUFIO_H
 
-#include <linux/blkdev.h>
+#include <linux/blk_types.h>
 #include <linux/types.h>
 
 /*----------------------------------------------------------------*/
diff --git a/include/linux/edac.h b/include/linux/edac.h
index b4ee8961e623..f939d5fad491 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -15,7 +15,7 @@
 #include <linux/atomic.h>
 #include <linux/device.h>
 #include <linux/completion.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 #include <linux/debugfs.h>
 #include <linux/numa.h>
 
diff --git a/include/linux/fault-inject.h b/include/linux/fault-inject.h
index 6d5edef09d45..04992b2732f1 100644
--- a/include/linux/fault-inject.h
+++ b/include/linux/fault-inject.h
@@ -7,7 +7,7 @@
 #include <linux/types.h>
 #include <linux/debugfs.h>
 #include <linux/configfs.h>
-#include <linux/ratelimit.h>
+#include <linux/ratelimit_types.h>
 #include <linux/atomic.h>
 
 /*
diff --git a/include/linux/fb.h b/include/linux/fb.h
index b75ee97c2977..f16cd2eddb85 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -2,14 +2,14 @@
 #ifndef _LINUX_FB_H
 #define _LINUX_FB_H
 
-#include <linux/refcount.h>
+#include <linux/refcount_types.h>
 #include <uapi/linux/fb.h>
 
 #define FBIO_CURSOR            _IOWR('F', 0x08, struct fb_cursor_user)
 
 #include <linux/fs.h>
 #include <linux/init.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 #include <linux/notifier.h>
 #include <linux/list.h>
 #include <linux/slab.h>
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index 78c8326d74ae..2d37e4d071e9 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -8,7 +8,7 @@
 
 #include <linux/posix_types.h>
 #include <linux/compiler.h>
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <linux/rcupdate.h>
 #include <linux/nospec.h>
 #include <linux/types.h>
diff --git a/include/linux/firewire.h b/include/linux/firewire.h
index c325e3523f93..feef7e09b60a 100644
--- a/include/linux/firewire.h
+++ b/include/linux/firewire.h
@@ -8,11 +8,11 @@
 #include <linux/kernel.h>
 #include <linux/kref.h>
 #include <linux/list.h>
-#include <linux/mutex.h>
-#include <linux/spinlock.h>
-#include <linux/timer.h>
+#include <linux/mutex_types.h>
+#include <linux/spinlock_types.h>
+#include <linux/timer_types.h>
 #include <linux/types.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 
 #include <linux/atomic.h>
 #include <asm/byteorder.h>
diff --git a/include/linux/firmware.h b/include/linux/firmware.h
index d45acd8c1e84..ee745b260b7e 100644
--- a/include/linux/firmware.h
+++ b/include/linux/firmware.h
@@ -5,7 +5,7 @@
 #include <linux/err.h>
 #include <linux/types.h>
 #include <linux/compiler.h>
-#include <linux/gfp.h>
+#include <linux/gfp_types.h>
 
 #define FW_ACTION_NOUEVENT 0
 #define FW_ACTION_UEVENT 1
diff --git a/include/linux/flex_proportions.h b/include/linux/flex_proportions.h
index b5d8c1a1b2a9..35204b64addf 100644
--- a/include/linux/flex_proportions.h
+++ b/include/linux/flex_proportions.h
@@ -9,9 +9,9 @@
 #define _LINUX_FLEX_PROPORTIONS_H
 
 #include <linux/percpu_counter.h>
-#include <linux/spinlock.h>
-#include <linux/seqlock.h>
-#include <linux/gfp.h>
+#include <linux/spinlock_types.h>
+#include <linux/seqlock_types.h>
+#include <linux/gfp_types.h>
 #include <linux/irqflags.h> // for local_irq_save()
 
 /*
diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 844dded7a530..8188b8565391 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -8,7 +8,7 @@
 #ifndef _LINUX_FPGA_MGR_H
 #define _LINUX_FPGA_MGR_H
 
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/platform_device.h>
 
 struct fpga_manager;
diff --git a/include/linux/framer/framer.h b/include/linux/framer/framer.h
index 9a9b88962c29..2352a52d7d0f 100644
--- a/include/linux/framer/framer.h
+++ b/include/linux/framer/framer.h
@@ -11,11 +11,11 @@
 #define __DRIVERS_FRAMER_H
 
 #include <linux/err.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/notifier.h>
 #include <linux/of.h>
 #include <linux/device.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 
 /**
  * enum framer_iface - Framer interface
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e403548e13e4..5862fe2c82d5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -16,7 +16,7 @@
 #include <linux/rbtree.h>
 #include <linux/init.h>
 #include <linux/bug.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/rwsem.h>
 #include <linux/mm_types.h>
 #include <linux/capability.h>
@@ -25,10 +25,10 @@
 #include <linux/rculist_bl.h>
 #include <linux/atomic.h>
 #include <linux/migrate_mode.h>
-#include <linux/uidgid.h>
+#include <linux/uidgid_types.h>
 #include <linux/lockdep.h>
 #include <linux/percpu-rwsem.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 #include <linux/delayed_call.h>
 #include <linux/uuid.h>
 #include <linux/errseq.h>
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index c13e99cbbf81..34ad2597640e 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -9,10 +9,10 @@
 #define _LINUX_FS_CONTEXT_H
 
 #include <linux/kernel.h>
-#include <linux/refcount.h>
+#include <linux/refcount_types.h>
 #include <linux/errno.h>
 #include <linux/security.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 
 struct cred;
 struct dentry;
diff --git a/include/linux/fs_struct.h b/include/linux/fs_struct.h
index 783b48dedb72..dd4d675cfe04 100644
--- a/include/linux/fs_struct.h
+++ b/include/linux/fs_struct.h
@@ -4,7 +4,7 @@
 
 #include <linux/path.h>
 #include <linux/spinlock.h>
-#include <linux/seqlock.h>
+#include <linux/seqlock_types.h>
 
 struct fs_struct {
 	int users;
diff --git a/include/linux/fsl/bestcomm/bestcomm_priv.h b/include/linux/fsl/bestcomm/bestcomm_priv.h
index 3b52f3ffbdf8..e544c26f842e 100644
--- a/include/linux/fsl/bestcomm/bestcomm_priv.h
+++ b/include/linux/fsl/bestcomm/bestcomm_priv.h
@@ -19,7 +19,7 @@
 #ifndef __BESTCOMM_PRIV_H__
 #define __BESTCOMM_PRIV_H__
 
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <linux/of.h>
 #include <asm/io.h>
 #include <asm/mpc52xx.h>
diff --git a/include/linux/fsl/bestcomm/sram.h b/include/linux/fsl/bestcomm/sram.h
index b6d668963cce..557c62706bd5 100644
--- a/include/linux/fsl/bestcomm/sram.h
+++ b/include/linux/fsl/bestcomm/sram.h
@@ -14,7 +14,7 @@
 
 #include <asm/rheap.h>
 #include <asm/mmu.h>
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 
 
 /* Structure used internally */
diff --git a/include/linux/gameport.h b/include/linux/gameport.h
index 07e370113b2b..2d2dbf29c775 100644
--- a/include/linux/gameport.h
+++ b/include/linux/gameport.h
@@ -9,7 +9,7 @@
 #include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/device.h>
-#include <linux/timer.h>
+#include <linux/timer_types.h>
 #include <linux/slab.h>
 #include <uapi/linux/gameport.h>
 
diff --git a/include/linux/gfp_api.h b/include/linux/gfp_api.h
index 5a05a2764a86..d4ea4f638050 100644
--- a/include/linux/gfp_api.h
+++ b/include/linux/gfp_api.h
@@ -1 +1 @@
-#include <linux/gfp.h>
+#include <linux/gfp_types.h>
diff --git a/include/linux/gnss.h b/include/linux/gnss.h
index 36968a0f33e8..8fc4bdd38dc6 100644
--- a/include/linux/gnss.h
+++ b/include/linux/gnss.h
@@ -11,7 +11,7 @@
 #include <linux/cdev.h>
 #include <linux/device.h>
 #include <linux/kfifo.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/rwsem.h>
 #include <linux/types.h>
 #include <linux/wait.h>
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 3a37d058cfcf..801357469a3d 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -8,7 +8,7 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/irqhandler.h>
-#include <linux/lockdep.h>
+#include <linux/lockdep_types.h>
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/property.h>
diff --git a/include/linux/greybus/operation.h b/include/linux/greybus/operation.h
index cb8e4ef45222..ba5f09816035 100644
--- a/include/linux/greybus/operation.h
+++ b/include/linux/greybus/operation.h
@@ -11,9 +11,9 @@
 
 #include <linux/completion.h>
 #include <linux/kref.h>
-#include <linux/timer.h>
+#include <linux/timer_types.h>
 #include <linux/types.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 
 struct gb_host_device;
 struct gb_operation;
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 7c26db874ff0..68a160859e3e 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -19,11 +19,10 @@
 #include <linux/slab.h>
 #include <linux/list.h>
 #include <linux/mod_devicetable.h> /* hid_device_id */
-#include <linux/timer.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 #include <linux/input.h>
 #include <linux/semaphore.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/power_supply.h>
 #include <uapi/linux/hid.h>
 #include <linux/hid_bpf.h>
diff --git a/include/linux/hp_sdc.h b/include/linux/hp_sdc.h
index 9be8704e2d38..63e74e315a85 100644
--- a/include/linux/hp_sdc.h
+++ b/include/linux/hp_sdc.h
@@ -41,7 +41,7 @@
 #include <linux/interrupt.h>
 #include <linux/types.h>
 #include <linux/time.h>
-#include <linux/timer.h>
+#include <linux/timer_types.h>
 #if defined(__hppa__)
 #include <asm/hardware.h>
 #endif
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index b6ab7b3d63bf..33ae363e38b8 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -17,8 +17,8 @@
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/percpu-defs.h>
-#include <linux/seqlock.h>
-#include <linux/timer.h>
+#include <linux/seqlock_types.h>
+#include <linux/timerqueue_types.h>
 #include <asm/percpu.h>  // for PER_CPU_BASE_SECTION needed by DECLARE_PER_CPU()
 #include <asm/processor.h>  /* for cpu_relax() */
 
diff --git a/include/linux/hsi/hsi.h b/include/linux/hsi/hsi.h
index 6ca92bff02c6..42c18904c480 100644
--- a/include/linux/hsi/hsi.h
+++ b/include/linux/hsi/hsi.h
@@ -11,7 +11,7 @@
 #define __LINUX_HSI_H__
 
 #include <linux/device.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/scatterlist.h>
 #include <linux/list.h>
 #include <linux/module.h>
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 77b30a8c6076..444d509c2647 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -12,7 +12,7 @@
 #include <linux/list.h>
 #include <linux/kref.h>
 #include <linux/pgtable.h>
-#include <linux/gfp.h>
+#include <linux/gfp_types.h>
 #include <linux/userfaultfd_k.h>
 
 struct ctl_table;
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 652ecb7abeda..4c868e8d5bec 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -15,7 +15,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/device.h>	/* for struct device */
 #include <linux/sched.h>	/* for completion */
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/regulator/consumer.h>
 #include <linux/rtmutex.h>
 #include <linux/irqdomain.h>		/* for Host Notify IRQ */
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 7fc1e0bb4122..16cc81e55b12 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -15,7 +15,7 @@
 #include <linux/i3c/ccc.h>
 #include <linux/i3c/device.h>
 #include <linux/rwsem.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 
 #define I3C_HOT_JOIN_ADDR		0x2
 #define I3C_BROADCAST_ADDR		0x7e
diff --git a/include/linux/i8253.h b/include/linux/i8253.h
index 8336b2f6f834..3be75bc72626 100644
--- a/include/linux/i8253.h
+++ b/include/linux/i8253.h
@@ -10,7 +10,7 @@
 #define __LINUX_I8253_H
 
 #include <linux/param.h>
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <linux/timex.h>
 
 /* i8253A PIT registers */
diff --git a/include/linux/idr.h b/include/linux/idr.h
index da5f5fa4a3a6..066fd41aaab7 100644
--- a/include/linux/idr.h
+++ b/include/linux/idr.h
@@ -13,7 +13,7 @@
 #define __IDR_H__
 
 #include <linux/radix-tree.h>
-#include <linux/gfp.h>
+#include <linux/gfp_types.h>
 #include <linux/percpu.h>
 
 struct idr {
diff --git a/include/linux/if_eql.h b/include/linux/if_eql.h
index 07f9b660b741..eb34161956a7 100644
--- a/include/linux/if_eql.h
+++ b/include/linux/if_eql.h
@@ -19,8 +19,8 @@
 #define _LINUX_IF_EQL_H
 
 
-#include <linux/timer.h>
-#include <linux/spinlock.h>
+#include <linux/timer_types.h>
+#include <linux/spinlock_types.h>
 #include <net/net_trackers.h>
 #include <uapi/linux/if_eql.h>
 
diff --git a/include/linux/if_pppox.h b/include/linux/if_pppox.h
index ff3beda1312c..c0dd367ca9b0 100644
--- a/include/linux/if_pppox.h
+++ b/include/linux/if_pppox.h
@@ -13,7 +13,7 @@
 #include <linux/netdevice.h>
 #include <linux/ppp_channel.h>
 #include <linux/skbuff.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 #include <uapi/linux/if_pppox.h>
 
 static inline struct pppoe_hdr *pppoe_hdr(const struct sk_buff *skb)
diff --git a/include/linux/igmp.h b/include/linux/igmp.h
index 5171231f70a8..283716e25e6c 100644
--- a/include/linux/igmp.h
+++ b/include/linux/igmp.h
@@ -11,10 +11,10 @@
 #define _LINUX_IGMP_H
 
 #include <linux/skbuff.h>
-#include <linux/timer.h>
+#include <linux/timer_types.h>
 #include <linux/in.h>
 #include <linux/ip.h>
-#include <linux/refcount.h>
+#include <linux/refcount_types.h>
 #include <linux/sockptr.h>
 #include <uapi/linux/igmp.h>
 
diff --git a/include/linux/iio/buffer-dma.h b/include/linux/iio/buffer-dma.h
index 18d3702fa95d..395762ed9bf1 100644
--- a/include/linux/iio/buffer-dma.h
+++ b/include/linux/iio/buffer-dma.h
@@ -9,8 +9,8 @@
 
 #include <linux/list.h>
 #include <linux/kref.h>
-#include <linux/spinlock.h>
-#include <linux/mutex.h>
+#include <linux/spinlock_types.h>
+#include <linux/mutex_types.h>
 #include <linux/iio/buffer_impl.h>
 
 struct iio_dma_buffer_queue;
diff --git a/include/linux/inetdevice.h b/include/linux/inetdevice.h
index ddb27fc0ee8c..17f92f8b77c1 100644
--- a/include/linux/inetdevice.h
+++ b/include/linux/inetdevice.h
@@ -9,7 +9,7 @@
 #include <linux/ip.h>
 #include <linux/netdevice.h>
 #include <linux/rcupdate.h>
-#include <linux/timer.h>
+#include <linux/timer_types.h>
 #include <linux/sysctl.h>
 #include <linux/rtnetlink.h>
 #include <linux/refcount.h>
diff --git a/include/linux/input.h b/include/linux/input.h
index de6503c0edb8..735b32eee9b4 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -18,7 +18,7 @@
 
 #include <linux/device.h>
 #include <linux/fs.h>
-#include <linux/timer.h>
+#include <linux/timer_types.h>
 #include <linux/mod_devicetable.h>
 
 struct input_dev_poller;
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 6322804d7534..2ac9e5f9af3d 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -11,7 +11,7 @@
 #include <linux/hardirq.h>
 #include <linux/irqflags.h>
 #include <linux/kref.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 #include <linux/jump_label.h>
 
 #include <linux/atomic.h>
diff --git a/include/linux/interval_tree.h b/include/linux/interval_tree.h
index 2b8026a39906..684f713d962f 100644
--- a/include/linux/interval_tree.h
+++ b/include/linux/interval_tree.h
@@ -2,7 +2,8 @@
 #ifndef _LINUX_INTERVAL_TREE_H
 #define _LINUX_INTERVAL_TREE_H
 
-#include <linux/rbtree.h>
+#include <linux/rbtree_types.h>
+#include <linux/types.h>
 
 struct interval_tree_node {
 	struct rb_node rb;
diff --git a/include/linux/iocontext.h b/include/linux/iocontext.h
index 14f7eaf1b443..a05d8a45cce5 100644
--- a/include/linux/iocontext.h
+++ b/include/linux/iocontext.h
@@ -4,7 +4,7 @@
 
 #include <linux/radix-tree.h>
 #include <linux/rcupdate.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 
 enum {
 	ICQ_EXITED		= 1 << 2,
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 6fc1c858013d..7dc7611cd6a0 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -8,7 +8,7 @@
 #include <linux/mm.h>
 #include <linux/types.h>
 #include <linux/mm_types.h>
-#include <linux/blkdev.h>
+#include <linux/blk_types.h>
 
 struct address_space;
 struct fiemap_extent_info;
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 83c00fac2acb..ee656a0490ed 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -11,7 +11,7 @@
 
 #include <linux/types.h>
 #include <linux/kernel.h>
-#include <linux/rbtree.h>
+#include <linux/rbtree_types.h>
 #include <linux/dma-mapping.h>
 
 /* iova structure */
diff --git a/include/linux/ipc.h b/include/linux/ipc.h
index 12f6839fad5b..4c024fcdea56 100644
--- a/include/linux/ipc.h
+++ b/include/linux/ipc.h
@@ -3,10 +3,10 @@
 #define _LINUX_IPC_H
 
 #include <linux/spinlock_types.h>
-#include <linux/uidgid.h>
+#include <linux/uidgid_types.h>
 #include <linux/rhashtable-types.h>
 #include <uapi/linux/ipc.h>
-#include <linux/refcount.h>
+#include <linux/refcount_types.h>
 #include <linux/cache.h> // for ____cacheline_aligned_in_smp
 #include <linux/compiler_types.h> // for __randomize_layout
 
diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index d9451d456a73..1f2c9b81baae 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -4,7 +4,7 @@
 
 #include <linux/rcupdate.h>
 #include <linux/kobject.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 
 /*
  * Core internal functions to deal with irq descriptors
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index ee0a82c60508..0503bd4ea55b 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -34,7 +34,7 @@
 #include <linux/irqdomain_defs.h>
 #include <linux/irqhandler.h>
 #include <linux/of.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/radix-tree.h>
 
 struct device_node;
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 971f3e826e15..498a7dabe4cf 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -23,8 +23,8 @@
 #include <linux/buffer_head.h>
 #include <linux/journal-head.h>
 #include <linux/stddef.h>
-#include <linux/mutex.h>
-#include <linux/timer.h>
+#include <linux/mutex_types.h>
+#include <linux/timer_types.h>
 #include <linux/slab.h>
 #include <linux/bit_spinlock.h>
 #include <linux/blkdev.h>
diff --git a/include/linux/journal-head.h b/include/linux/journal-head.h
index 75bc56109031..427a57eee5eb 100644
--- a/include/linux/journal-head.h
+++ b/include/linux/journal-head.h
@@ -11,7 +11,7 @@
 #ifndef JOURNAL_HEAD_H_INCLUDED
 #define JOURNAL_HEAD_H_INCLUDED
 
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 
 typedef unsigned int		tid_t;		/* Unique transaction ID */
 typedef struct transaction_s	transaction_t;	/* Compound transaction type */
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 21c617cfa32d..fdb010fda28c 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -8,8 +8,8 @@
 
 #include <linux/err.h>
 #include <linux/list.h>
-#include <linux/mutex.h>
-#include <linux/lockdep.h>
+#include <linux/mutex_types.h>
+#include <linux/lockdep_types.h>
 #include <linux/rbtree.h>
 #include <linux/bug.h>
 #include <linux/types.h>
diff --git a/include/linux/key.h b/include/linux/key.h
index 943a432da3ae..10649fec6004 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -12,7 +12,7 @@
 
 #include <linux/types.h>
 #include <linux/list.h>
-#include <linux/rbtree.h>
+#include <linux/rbtree_types.h>
 #include <linux/rcupdate.h>
 #include <linux/sysctl.h>
 #include <linux/rwsem.h>
@@ -22,7 +22,7 @@
 #include <linux/time64.h>
 
 #ifdef __KERNEL__
-#include <linux/uidgid.h>
+#include <linux/uidgid_types.h>
 
 /* key handle serial number */
 typedef int32_t key_serial_t;
@@ -32,6 +32,7 @@ typedef uint32_t key_perm_t;
 
 struct key;
 struct net;
+struct user_namespace;
 
 #ifdef CONFIG_KEYS
 
diff --git a/include/linux/klist.h b/include/linux/klist.h
index b0f238f20dbb..632ae9c720ac 100644
--- a/include/linux/klist.h
+++ b/include/linux/klist.h
@@ -10,7 +10,7 @@
 #ifndef _LINUX_KLIST_H
 #define _LINUX_KLIST_H
 
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <linux/kref.h>
 #include <linux/list.h>
 
diff --git a/include/linux/kmod.h b/include/linux/kmod.h
index 68f69362d427..c46c65b5fb25 100644
--- a/include/linux/kmod.h
+++ b/include/linux/kmod.h
@@ -7,7 +7,7 @@
  */
 
 #include <linux/umh.h>
-#include <linux/gfp.h>
+#include <linux/gfp_types.h>
 #include <linux/stddef.h>
 #include <linux/errno.h>
 #include <linux/compiler.h>
diff --git a/include/linux/kmsan.h b/include/linux/kmsan.h
index e0c23a32cdf0..2217a29a8d02 100644
--- a/include/linux/kmsan.h
+++ b/include/linux/kmsan.h
@@ -10,7 +10,7 @@
 #define _LINUX_KMSAN_H
 
 #include <linux/dma-direction.h>
-#include <linux/gfp.h>
+#include <linux/gfp_types.h>
 #include <linux/kmsan-checks.h>
 #include <linux/types.h>
 
diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index 36ea8c2714bc..da714992ab38 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -20,12 +20,12 @@
 #include <linux/sysfs.h>
 #include <linux/compiler.h>
 #include <linux/container_of.h>
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <linux/stdarg.h> // for va_list
 #include <linux/kref.h>
 #include <linux/kobject_ns.h>
 #include <linux/workqueue.h>
-#include <linux/uidgid.h>
+#include <linux/uidgid_types.h>
 
 #define UEVENT_HELPER_PATH_LEN		256
 #define UEVENT_NUM_ENVP			64	/* number of env pointers */
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index b0511d1090ed..63b981edcffa 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -22,7 +22,7 @@
 #include <linux/bug.h>
 #include <linux/percpu.h>
 #include <linux/rcupdate.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/ftrace.h>
 #include <linux/objpool.h>
 #include <linux/rethook.h>
diff --git a/include/linux/kref.h b/include/linux/kref.h
index d32e21a2538c..536ada1a1bc4 100644
--- a/include/linux/kref.h
+++ b/include/linux/kref.h
@@ -13,7 +13,6 @@
 #ifndef _KREF_H_
 #define _KREF_H_
 
-#include <linux/spinlock.h>
 #include <linux/refcount.h>
 
 struct kref {
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index dca36005f1c4..37c7d7de5635 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -6,8 +6,8 @@
 #include <linux/types.h>
 #include <linux/hardirq.h>
 #include <linux/list.h>
-#include <linux/mutex.h>
-#include <linux/spinlock.h>
+#include <linux/mutex_types.h>
+#include <linux/spinlock_types.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
 #include <linux/sched/stat.h>
diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
index 9d1f7835d8c1..267616d24ac3 100644
--- a/include/linux/kvm_types.h
+++ b/include/linux/kvm_types.h
@@ -20,7 +20,7 @@ struct kvm_memslots;
 enum kvm_mr_change;
 
 #include <linux/bits.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/types.h>
 #include <linux/spinlock_types.h>
 
diff --git a/include/linux/leds-pca9532.h b/include/linux/leds-pca9532.h
index f4796d333974..07b1a4d6c071 100644
--- a/include/linux/leds-pca9532.h
+++ b/include/linux/leds-pca9532.h
@@ -11,7 +11,7 @@
 #define __LINUX_PCA9532_H
 
 #include <linux/leds.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 #include <dt-bindings/leds/leds-pca9532.h>
 
 enum pca9532_state {
diff --git a/include/linux/leds.h b/include/linux/leds.h
index 7598d472903a..bec1c2fa5b26 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -10,10 +10,10 @@
 
 #include <dt-bindings/leds/common.h>
 #include <linux/device.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/rwsem.h>
-#include <linux/spinlock.h>
-#include <linux/timer.h>
+#include <linux/spinlock_types.h>
+#include <linux/timer_types.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 26d68115afb8..7d8a0afbac63 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -17,7 +17,7 @@
 #include <linux/scatterlist.h>
 #include <linux/io.h>
 #include <linux/ata.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 #include <scsi/scsi_host.h>
 #include <linux/acpi.h>
 #include <linux/cdrom.h>
diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
index f8ab7da9cc28..04be45d6a9ab 100644
--- a/include/linux/libnvdimm.h
+++ b/include/linux/libnvdimm.h
@@ -10,7 +10,7 @@
 #include <linux/sizes.h>
 #include <linux/types.h>
 #include <linux/uuid.h>
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 
 struct bio;
 
diff --git a/include/linux/libps2.h b/include/linux/libps2.h
index 9ca9ce4e6e64..006c38667e75 100644
--- a/include/linux/libps2.h
+++ b/include/linux/libps2.h
@@ -9,7 +9,7 @@
 
 #include <linux/bitops.h>
 #include <linux/interrupt.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/types.h>
 #include <linux/wait.h>
 
diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
index 1b95fe31051f..72a5538f35af 100644
--- a/include/linux/lockd/lockd.h
+++ b/include/linux/lockd/lockd.h
@@ -17,7 +17,7 @@
 #include <net/ipv6.h>
 #include <linux/fs.h>
 #include <linux/kref.h>
-#include <linux/refcount.h>
+#include <linux/refcount_types.h>
 #include <linux/utsname.h>
 #include <linux/lockd/bind.h>
 #include <linux/lockd/xdr.h>
diff --git a/include/linux/lockref.h b/include/linux/lockref.h
index c3a1f78bc884..79c8402c7079 100644
--- a/include/linux/lockref.h
+++ b/include/linux/lockref.h
@@ -15,7 +15,7 @@
  * example).
  */
 
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <generated/bounds.h>
 
 #define USE_CMPXCHG_LOCKREF \
diff --git a/include/linux/lp.h b/include/linux/lp.h
index be8a07eb2083..337573412852 100644
--- a/include/linux/lp.h
+++ b/include/linux/lp.h
@@ -10,7 +10,7 @@
 
 
 #include <linux/wait.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <uapi/linux/lp.h>
 
 /* Magic numbers for defining port-device mappings */
diff --git a/include/linux/mISDNhw.h b/include/linux/mISDNhw.h
index ef4f8eb02eac..9d65caceebc8 100644
--- a/include/linux/mISDNhw.h
+++ b/include/linux/mISDNhw.h
@@ -11,7 +11,7 @@
 #ifndef MISDNHW_H
 #define MISDNHW_H
 #include <linux/mISDNif.h>
-#include <linux/timer.h>
+#include <linux/timer_types.h>
 
 /*
  * HW DEBUG 0xHHHHGGGG
diff --git a/include/linux/mailbox_controller.h b/include/linux/mailbox_controller.h
index ab7ab835a2f5..2006897fdaf9 100644
--- a/include/linux/mailbox_controller.h
+++ b/include/linux/mailbox_controller.h
@@ -4,7 +4,7 @@
 #define __MAILBOX_CONTROLLER_H
 
 #include <linux/types.h>
-#include <linux/hrtimer.h>
+#include <linux/hrtimer_types.h>
 #include <linux/completion.h>
 
 struct device;
diff --git a/include/linux/mc146818rtc.h b/include/linux/mc146818rtc.h
index 34dfcc77f505..000edef612e1 100644
--- a/include/linux/mc146818rtc.h
+++ b/include/linux/mc146818rtc.h
@@ -19,7 +19,7 @@
 #include <linux/pm-trace.h>
 
 #ifdef __KERNEL__
-#include <linux/spinlock.h>		/* spinlock_t */
+#include <linux/spinlock_types.h>	/* spinlock_t */
 extern spinlock_t rtc_lock;		/* serialize CMOS RAM access */
 
 /* Some RTCs extend the mc146818 register set to support alarms of more
diff --git a/include/linux/mdio/mdio-xgene.h b/include/linux/mdio/mdio-xgene.h
index 9e588965dc83..90e8b780de96 100644
--- a/include/linux/mdio/mdio-xgene.h
+++ b/include/linux/mdio/mdio-xgene.h
@@ -9,7 +9,7 @@
 #define __MDIO_XGENE_H__
 
 #include <linux/bits.h>
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <linux/types.h>
 
 #define BLOCK_XG_MDIO_CSR_OFFSET	0x5000
diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index 69e781900082..f3f91280d20b 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -3,7 +3,7 @@
 #define _LINUX_MEMORY_TIERS_H
 
 #include <linux/types.h>
-#include <linux/nodemask.h>
+#include <linux/nodemask_types.h>
 #include <linux/kref.h>
 #include <linux/mmzone.h>
 #include <linux/notifier.h>
diff --git a/include/linux/memory.h b/include/linux/memory.h
index 939a16bd5cea..3979b05e7979 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -18,7 +18,7 @@
 
 #include <linux/node.h>
 #include <linux/compiler.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 
 #define MIN_MEMORY_BLOCK_SIZE     (1UL << SECTION_SIZE_BITS)
 
diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 85c9ae0281e4..cc375edd15d9 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -9,8 +9,8 @@
 #include <linux/sched.h>
 #include <linux/mmzone.h>
 #include <linux/slab.h>
-#include <linux/rbtree.h>
-#include <linux/nodemask.h>
+#include <linux/rbtree_types.h>
+#include <linux/nodemask_types.h>
 #include <linux/pagemap.h>
 #include <uapi/linux/mempolicy.h>
 
diff --git a/include/linux/memstick.h b/include/linux/memstick.h
index ebf73d4ee969..8e1c7daa7c3b 100644
--- a/include/linux/memstick.h
+++ b/include/linux/memstick.h
@@ -8,7 +8,7 @@
 #ifndef _MEMSTICK_H
 #define _MEMSTICK_H
 
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 #include <linux/scatterlist.h>
 #include <linux/device.h>
 
diff --git a/include/linux/mfd/abx500/ab8500.h b/include/linux/mfd/abx500/ab8500.h
index 76d326ea8eba..7542f6692de2 100644
--- a/include/linux/mfd/abx500/ab8500.h
+++ b/include/linux/mfd/abx500/ab8500.h
@@ -8,7 +8,7 @@
 #define MFD_AB8500_H
 
 #include <linux/atomic.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/irqdomain.h>
 
 struct device;
diff --git a/include/linux/mfd/cs42l43.h b/include/linux/mfd/cs42l43.h
index 2239d8585e78..00e074b8c41f 100644
--- a/include/linux/mfd/cs42l43.h
+++ b/include/linux/mfd/cs42l43.h
@@ -10,10 +10,10 @@
 #define CS42L43_CORE_EXT_H
 
 #include <linux/completion.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 
 #define CS42L43_N_SUPPLIES		3
 
diff --git a/include/linux/mfd/ipaq-micro.h b/include/linux/mfd/ipaq-micro.h
index d5caa4c86ecc..b40311799346 100644
--- a/include/linux/mfd/ipaq-micro.h
+++ b/include/linux/mfd/ipaq-micro.h
@@ -6,7 +6,7 @@
 #ifndef _MFD_IPAQ_MICRO_H_
 #define _MFD_IPAQ_MICRO_H_
 
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <linux/completion.h>
 #include <linux/list.h>
 
diff --git a/include/linux/mfd/lochnagar.h b/include/linux/mfd/lochnagar.h
index ff9e64cfc9fb..056f1f9dc2bd 100644
--- a/include/linux/mfd/lochnagar.h
+++ b/include/linux/mfd/lochnagar.h
@@ -9,7 +9,7 @@
  */
 
 #include <linux/device.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/regmap.h>
 
 #ifndef CIRRUS_LOCHNAGAR_H
diff --git a/include/linux/mfd/madera/core.h b/include/linux/mfd/madera/core.h
index 03a8a788424a..a62b13a954b8 100644
--- a/include/linux/mfd/madera/core.h
+++ b/include/linux/mfd/madera/core.h
@@ -12,7 +12,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/mfd/madera/pdata.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/notifier.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
diff --git a/include/linux/mfd/max8907.h b/include/linux/mfd/max8907.h
index db4de95d3b9e..38600988cc89 100644
--- a/include/linux/mfd/max8907.h
+++ b/include/linux/mfd/max8907.h
@@ -9,7 +9,7 @@
 #ifndef __LINUX_MFD_MAX8907_H
 #define __LINUX_MFD_MAX8907_H
 
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 
 #define MAX8907_GEN_I2C_ADDR		(0x78 >> 1)
 #define MAX8907_ADC_I2C_ADDR		(0x8e >> 1)
diff --git a/include/linux/mfd/mt6397/core.h b/include/linux/mfd/mt6397/core.h
index 627487e26287..30fa2a63f3a0 100644
--- a/include/linux/mfd/mt6397/core.h
+++ b/include/linux/mfd/mt6397/core.h
@@ -7,7 +7,7 @@
 #ifndef __MFD_MT6397_CORE_H__
 #define __MFD_MT6397_CORE_H__
 
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/notifier.h>
 
 enum chip_id {
diff --git a/include/linux/mfd/mt6397/rtc.h b/include/linux/mfd/mt6397/rtc.h
index 068ae1c0f0e8..763f38cdc6af 100644
--- a/include/linux/mfd/mt6397/rtc.h
+++ b/include/linux/mfd/mt6397/rtc.h
@@ -10,7 +10,7 @@
 #define _LINUX_MFD_MT6397_RTC_H_
 
 #include <linux/jiffies.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/regmap.h>
 #include <linux/rtc.h>
 
diff --git a/include/linux/mfd/pcf50633/core.h b/include/linux/mfd/pcf50633/core.h
index 539f27f8bd89..b088002b27a0 100644
--- a/include/linux/mfd/pcf50633/core.h
+++ b/include/linux/mfd/pcf50633/core.h
@@ -10,10 +10,9 @@
 #define __LINUX_MFD_PCF50633_CORE_H
 
 #include <linux/i2c.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
-#include <linux/pm.h>
 #include <linux/power_supply.h>
 #include <linux/mfd/pcf50633/backlight.h>
 
diff --git a/include/linux/mfd/rc5t583.h b/include/linux/mfd/rc5t583.h
index 4f220146cc02..485668f64dc8 100644
--- a/include/linux/mfd/rc5t583.h
+++ b/include/linux/mfd/rc5t583.h
@@ -12,7 +12,7 @@
 #ifndef __LINUX_MFD_RC5T583_H
 #define __LINUX_MFD_RC5T583_H
 
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/types.h>
 #include <linux/regmap.h>
 
diff --git a/include/linux/mfd/stmpe.h b/include/linux/mfd/stmpe.h
index 87e29d561e22..3f184efc0d5b 100644
--- a/include/linux/mfd/stmpe.h
+++ b/include/linux/mfd/stmpe.h
@@ -8,7 +8,7 @@
 #ifndef __LINUX_MFD_STMPE_H
 #define __LINUX_MFD_STMPE_H
 
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 
 #define STMPE_SAMPLE_TIME(x)	((x & 0xf) << 4)
 #define STMPE_MOD_12B(x)	((x & 0x1) << 3)
diff --git a/include/linux/mfd/ucb1x00.h b/include/linux/mfd/ucb1x00.h
index ede237384723..52fea8405c81 100644
--- a/include/linux/mfd/ucb1x00.h
+++ b/include/linux/mfd/ucb1x00.h
@@ -11,7 +11,7 @@
 #include <linux/mfd/mcp.h>
 #include <linux/gpio.h>
 #include <linux/gpio/driver.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 
 #define UCB_IO_DATA	0x00
 #define UCB_IO_DIR	0x01
diff --git a/include/linux/mfd/wm8350/core.h b/include/linux/mfd/wm8350/core.h
index a3241e4d7548..dc6ff85cb5b0 100644
--- a/include/linux/mfd/wm8350/core.h
+++ b/include/linux/mfd/wm8350/core.h
@@ -9,7 +9,7 @@
 #define __LINUX_MFD_WM8350_CORE_H_
 
 #include <linux/kernel.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/interrupt.h>
 #include <linux/completion.h>
 #include <linux/regmap.h>
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index 474d32cb0520..bd99f47726dc 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -8,12 +8,12 @@
 
 #include <linux/device.h>
 #include <linux/dma-direction.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/skbuff.h>
 #include <linux/slab.h>
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <linux/wait.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 
 #define MHI_MAX_OEM_PK_HASH_SEGMENTS 16
 
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 41f03b352401..7d47499ce75a 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -42,14 +42,14 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/xarray.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 #include <linux/mempool.h>
 #include <linux/interrupt.h>
 #include <linux/idr.h>
 #include <linux/notifier.h>
-#include <linux/refcount.h>
+#include <linux/refcount_types.h>
 #include <linux/auxiliary_bus.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 
 #include <linux/mlx5/device.h>
 #include <linux/mlx5/doorbell.h>
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 60512fa4bb04..95c29b8f573d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -8,7 +8,7 @@
 #include <linux/bug.h>
 #include <linux/list.h>
 #include <linux/mmzone.h>
-#include <linux/rbtree.h>
+#include <linux/rbtree_types.h>
 #include <linux/atomic.h>
 #include <linux/debug_locks.h>
 #include <linux/mm_types.h>
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index bcb853d8c17a..95f1539a05bc 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -9,16 +9,16 @@
 #include <linux/compiler_types.h> // for __randomize_layout
 #include <linux/kref.h>
 #include <linux/list.h>
-#include <linux/spinlock.h>
-#include <linux/rbtree.h>
+#include <linux/spinlock_types.h>
+#include <linux/rbtree_types.h>
 #include <linux/maple_tree.h>
 #include <linux/rwsem.h>
 #include <linux/cpumask.h>
 #include <linux/uprobes.h>
 #include <linux/rcupdate.h>
 #include <linux/page-flags-layout.h>
-#include <linux/workqueue.h>
-#include <linux/seqlock.h>
+#include <linux/workqueue_types.h>
+#include <linux/seqlock_types.h>
 #include <linux/percpu_counter.h>
 
 #include <asm/mmu.h>
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index a497f189d988..ce11c2dab2bc 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -5,7 +5,7 @@
 #ifndef __ASSEMBLY__
 #ifndef __GENERATING_BOUNDS_H
 
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <linux/list.h>
 #include <linux/list_nulls.h>
 #include <linux/wait.h>
@@ -14,7 +14,6 @@
 #include <linux/threads.h>
 #include <linux/numa.h>
 #include <linux/init.h>
-#include <linux/seqlock.h>
 #include <linux/nodemask.h>
 #include <linux/pageblock-flags.h>
 #include <linux/page-flags-layout.h>
@@ -25,6 +24,10 @@
 #include <linux/zswap.h>
 #include <asm/page.h>
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+#include <linux/seqlock_types.h>
+#endif
+
 /* Free memory management - zoned buddy allocator.  */
 #ifndef CONFIG_ARCH_FORCE_MAX_ORDER
 #define MAX_PAGE_ORDER 10
diff --git a/include/linux/moxtet.h b/include/linux/moxtet.h
index ac577699edfd..ab8112dc4bf9 100644
--- a/include/linux/moxtet.h
+++ b/include/linux/moxtet.h
@@ -11,7 +11,7 @@
 #include <linux/device.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 
 #define TURRIS_MOX_MAX_MODULES	10
 
diff --git a/include/linux/mroute_base.h b/include/linux/mroute_base.h
index 9dd4bf157255..f3dc964ae4e9 100644
--- a/include/linux/mroute_base.h
+++ b/include/linux/mroute_base.h
@@ -3,7 +3,7 @@
 
 #include <linux/netdevice.h>
 #include <linux/rhashtable-types.h>
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <net/net_namespace.h>
 #include <net/sock.h>
 #include <net/fib_notifier.h>
diff --git a/include/linux/msi.h b/include/linux/msi.h
index ddace8c34dcf..04fd2c856287 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -22,7 +22,7 @@
 #include <linux/cpumask.h>
 #include <linux/msi_api.h>
 #include <linux/xarray.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/list.h>
 #include <linux/irq.h>
 #include <linux/bits.h>
diff --git a/include/linux/mtd/blktrans.h b/include/linux/mtd/blktrans.h
index 0aa2f072d2a1..7be6117fad23 100644
--- a/include/linux/mtd/blktrans.h
+++ b/include/linux/mtd/blktrans.h
@@ -6,7 +6,7 @@
 #ifndef __MTD_TRANS_H__
 #define __MTD_TRANS_H__
 
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/kref.h>
 #include <linux/list.h>
 
diff --git a/include/linux/mtd/doc2000.h b/include/linux/mtd/doc2000.h
index 1b7b0ee070ca..0bd3fdacec09 100644
--- a/include/linux/mtd/doc2000.h
+++ b/include/linux/mtd/doc2000.h
@@ -12,7 +12,7 @@
 #define __MTD_DOC2000_H__
 
 #include <linux/mtd/mtd.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 
 #define DoC_Sig1 0
 #define DoC_Sig2 1
diff --git a/include/linux/mtd/flashchip.h b/include/linux/mtd/flashchip.h
index 9798c1a1d3b6..58ffb6515741 100644
--- a/include/linux/mtd/flashchip.h
+++ b/include/linux/mtd/flashchip.h
@@ -12,8 +12,8 @@
  * has asm/spinlock.h, or 2.4, which has linux/spinlock.h
  */
 #include <linux/sched.h>
-#include <linux/mutex.h>
-#include <linux/wait.h>
+#include <linux/mutex_types.h>
+#include <linux/wait_types.h>
 
 typedef enum {
 	FL_READY,
diff --git a/include/linux/mtd/onenand.h b/include/linux/mtd/onenand.h
index 1e517961d0ba..7ebd8180c617 100644
--- a/include/linux/mtd/onenand.h
+++ b/include/linux/mtd/onenand.h
@@ -9,7 +9,7 @@
 #ifndef __LINUX_MTD_ONENAND_H
 #define __LINUX_MTD_ONENAND_H
 
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <linux/completion.h>
 #include <linux/mtd/flashchip.h>
 #include <linux/mtd/onenand_regs.h>
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 5c19ead60499..2287e9923177 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -8,7 +8,7 @@
 #ifndef __LINUX_MTD_SPINAND_H
 #define __LINUX_MTD_SPINAND_H
 
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/mtd/mtd.h>
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 7e208d46ba5b..08aac9a432ea 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -14,7 +14,7 @@
 #include <asm/current.h>
 #include <linux/list.h>
 #include <linux/spinlock_types.h>
-#include <linux/lockdep.h>
+#include <linux/lockdep_types.h>
 #include <linux/atomic.h>
 #include <asm/processor.h>
 #include <linux/osq_lock.h>
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 58f5dc3a2f5b..d1144b176c3b 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -21,7 +21,7 @@
 #ifndef _LINUX_NETDEVICE_H
 #define _LINUX_NETDEVICE_H
 
-#include <linux/timer.h>
+#include <linux/timer_types.h>
 #include <linux/bug.h>
 #include <linux/delay.h>
 #include <linux/atomic.h>
@@ -47,7 +47,7 @@
 #include <uapi/linux/pkt_cls.h>
 #include <uapi/linux/netdev.h>
 #include <linux/hashtable.h>
-#include <linux/rbtree.h>
+#include <linux/rbtree_types.h>
 #include <net/net_trackers.h>
 #include <net/net_debug.h>
 #include <net/dropreason-core.h>
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 455ccfe8bffa..5b485a58f1a5 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -14,7 +14,7 @@
 #ifndef _LINUX_NETFS_H
 #define _LINUX_NETFS_H
 
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 #include <linux/fs.h>
 #include <linux/pagemap.h>
 #include <linux/uio.h>
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index bd19c4b91e31..488695d7480f 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -12,7 +12,7 @@
 #include <linux/interrupt.h>
 #include <linux/rcupdate.h>
 #include <linux/list.h>
-#include <linux/refcount.h>
+#include <linux/refcount_types.h>
 
 union inet_addr {
 	__u32		all[4];
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index ef8d2d618d5b..657d24529fde 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -14,7 +14,7 @@
 #define _LINUX_NFS4_H
 
 #include <linux/list.h>
-#include <linux/uidgid.h>
+#include <linux/uidgid_types.h>
 #include <uapi/linux/nfs4.h>
 #include <linux/sunrpc/msg_prot.h>
 
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index a832e18f6347..4511d8a50e15 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -22,8 +22,8 @@
 #include <linux/in.h>
 #include <linux/mm.h>
 #include <linux/pagemap.h>
-#include <linux/rbtree.h>
-#include <linux/refcount.h>
+#include <linux/rbtree_types.h>
+#include <linux/refcount_types.h>
 #include <linux/rwsem.h>
 
 #include <linux/sunrpc/debug.h>
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index cd797e00fe35..08860ceda787 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -10,7 +10,7 @@
 #include <linux/sunrpc/xprt.h>
 
 #include <linux/atomic.h>
-#include <linux/refcount.h>
+#include <linux/refcount_types.h>
 
 struct nfs4_session;
 struct nfs_iostats;
diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index 241cef0bfaed..9767df7d354b 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -3,7 +3,7 @@
 #define _LINUX_NS_COMMON_H
 
 #include <linux/atomic.h>
-#include <linux/refcount.h>
+#include <linux/refcount_types.h>
 
 struct proc_ns_operations;
 
diff --git a/include/linux/objpool.h b/include/linux/objpool.h
index 15aff4a17f0c..f0d5ce50753f 100644
--- a/include/linux/objpool.h
+++ b/include/linux/objpool.h
@@ -4,7 +4,7 @@
 #define _LINUX_OBJPOOL_H
 
 #include <linux/types.h>
-#include <linux/refcount.h>
+#include <linux/refcount_types.h>
 
 /*
  * objpool: ring-array based lockless MPMC queue
diff --git a/include/linux/oom.h b/include/linux/oom.h
index 7d0c9c48a0c5..66d20654c96c 100644
--- a/include/linux/oom.h
+++ b/include/linux/oom.h
@@ -5,7 +5,7 @@
 
 #include <linux/sched/signal.h>
 #include <linux/types.h>
-#include <linux/nodemask.h>
+#include <linux/nodemask_types.h>
 #include <uapi/linux/oom.h>
 #include <linux/sched/coredump.h> /* MMF_* */
 #include <linux/mm.h> /* VM_FAULT* */
diff --git a/include/linux/padata.h b/include/linux/padata.h
index 8f418711351b..d00a89e41518 100644
--- a/include/linux/padata.h
+++ b/include/linux/padata.h
@@ -12,10 +12,10 @@
 #ifndef PADATA_H
 #define PADATA_H
 
-#include <linux/refcount.h>
+#include <linux/refcount_types.h>
 #include <linux/compiler_types.h>
-#include <linux/workqueue.h>
-#include <linux/spinlock.h>
+#include <linux/workqueue_types.h>
+#include <linux/spinlock_types.h>
 #include <linux/list.h>
 #include <linux/kobject.h>
 
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 431b12a23299..186d5a9fb956 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -11,7 +11,7 @@
 #include <linux/highmem.h>
 #include <linux/compiler.h>
 #include <linux/uaccess.h>
-#include <linux/gfp.h>
+#include <linux/gfp_types.h>
 #include <linux/bitops.h>
 #include <linux/hardirq.h> /* for in_interrupt() */
 #include <linux/hugetlb_inline.h>
diff --git a/include/linux/parport.h b/include/linux/parport.h
index fff39bc30629..c8e3b71a3b49 100644
--- a/include/linux/parport.h
+++ b/include/linux/parport.h
@@ -9,7 +9,7 @@
 
 #include <linux/jiffies.h>
 #include <linux/proc_fs.h>
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <linux/wait.h>
 #include <linux/irqreturn.h>
 #include <linux/semaphore.h>
diff --git a/include/linux/part_stat.h b/include/linux/part_stat.h
index abeba356bc3f..d4697dc35b02 100644
--- a/include/linux/part_stat.h
+++ b/include/linux/part_stat.h
@@ -2,7 +2,7 @@
 #ifndef _LINUX_PART_STAT_H
 #define _LINUX_PART_STAT_H
 
-#include <linux/blkdev.h>
+#include <linux/blk_types.h>
 #include <asm/local.h>
 
 struct disk_stats {
diff --git a/include/linux/peci.h b/include/linux/peci.h
index 9b3d36aff431..ad3ea1371680 100644
--- a/include/linux/peci.h
+++ b/include/linux/peci.h
@@ -6,7 +6,7 @@
 
 #include <linux/device.h>
 #include <linux/kernel.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/types.h>
 
 /*
diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
index d73a1c08c3e3..dd2f19ea08bd 100644
--- a/include/linux/percpu-refcount.h
+++ b/include/linux/percpu-refcount.h
@@ -54,7 +54,7 @@
 #include <linux/percpu.h>
 #include <linux/rcupdate.h>
 #include <linux/types.h>
-#include <linux/gfp.h>
+#include <linux/gfp_types.h>
 
 struct percpu_ref;
 typedef void (percpu_ref_func_t)(struct percpu_ref *);
diff --git a/include/linux/percpu_counter.h b/include/linux/percpu_counter.h
index 231e75ec1d83..8d45785b3448 100644
--- a/include/linux/percpu_counter.h
+++ b/include/linux/percpu_counter.h
@@ -7,7 +7,7 @@
  * WARNING: these things are HUGE.  4 kbytes per counter on 32-way P4.
  */
 
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <linux/list.h>
 #include <linux/threads.h>
 #include <linux/percpu.h>
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index d2a15c0c6f8a..eaf5d5f76e0e 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -41,14 +41,14 @@ struct perf_guest_info_callbacks {
 #endif
 
 #include <linux/list.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
-#include <linux/spinlock.h>
-#include <linux/hrtimer.h>
+#include <linux/spinlock_types.h>
+#include <linux/hrtimer_types.h>
 #include <linux/fs.h>
 #include <linux/pid_namespace.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 #include <linux/ftrace.h>
 #include <linux/cpu.h>
 #include <linux/irq_work.h>
@@ -58,7 +58,7 @@ struct perf_guest_info_callbacks {
 #include <linux/sysfs.h>
 #include <linux/perf_regs.h>
 #include <linux/cgroup.h>
-#include <linux/refcount.h>
+#include <linux/refcount_types.h>
 #include <linux/security.h>
 #include <linux/static_call.h>
 #include <linux/lockdep.h>
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 34bc9fb37494..def0e2dd8305 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -20,12 +20,12 @@
 #include <linux/mii.h>
 #include <linux/mii_timestamper.h>
 #include <linux/module.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 #include <linux/mod_devicetable.h>
 #include <linux/u64_stats_sync.h>
 #include <linux/irqreturn.h>
 #include <linux/iopoll.h>
-#include <linux/refcount.h>
+#include <linux/refcount_types.h>
 
 #include <linux/atomic.h>
 
diff --git a/include/linux/pktcdvd.h b/include/linux/pktcdvd.h
index 077a3e870128..3ad4425ba3a0 100644
--- a/include/linux/pktcdvd.h
+++ b/include/linux/pktcdvd.h
@@ -12,7 +12,7 @@
 #ifndef __PKTCDVD_H
 #define __PKTCDVD_H
 
-#include <linux/blkdev.h>
+#include <linux/blk_types.h>
 #include <linux/cdrom.h>
 #include <linux/mempool.h>
 #include <uapi/linux/pktcdvd.h>
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index 8865e350c12a..dec873a7d38e 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -10,7 +10,7 @@
 
 #include <linux/device.h>
 #include <linux/lockdep_types.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/notifier.h>
 
 #include <linux/platform_data/cros_ec_commands.h>
diff --git a/include/linux/platform_data/cros_ec_sensorhub.h b/include/linux/platform_data/cros_ec_sensorhub.h
index 0ecce6aa69d5..693337bd4d27 100644
--- a/include/linux/platform_data/cros_ec_sensorhub.h
+++ b/include/linux/platform_data/cros_ec_sensorhub.h
@@ -9,7 +9,7 @@
 #define __LINUX_PLATFORM_DATA_CROS_EC_SENSORHUB_H
 
 #include <linux/ktime.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/notifier.h>
 #include <linux/platform_data/cros_ec_commands.h>
 
diff --git a/include/linux/platform_data/wilco-ec.h b/include/linux/platform_data/wilco-ec.h
index 3e268e636b5b..40651d9d099f 100644
--- a/include/linux/platform_data/wilco-ec.h
+++ b/include/linux/platform_data/wilco-ec.h
@@ -8,7 +8,7 @@
 #ifndef WILCO_EC_H
 #define WILCO_EC_H
 
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/types.h>
 
 /* Message flags for using the mailbox() interface */
diff --git a/include/linux/platform_data/xilinx-ll-temac.h b/include/linux/platform_data/xilinx-ll-temac.h
index f4a68136afa6..2ca6792821c7 100644
--- a/include/linux/platform_data/xilinx-ll-temac.h
+++ b/include/linux/platform_data/xilinx-ll-temac.h
@@ -4,7 +4,7 @@
 
 #include <linux/if_ether.h>
 #include <linux/phy.h>
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 
 struct ll_temac_platform_data {
 	bool txcsum;		/* Enable/disable TX checksum */
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 43251723b210..303a143c4e04 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -11,10 +11,10 @@
 #include <linux/export.h>
 #include <linux/kernel.h> // for PTR_IF()
 #include <linux/list.h>
-#include <linux/workqueue.h>
-#include <linux/spinlock.h>
+#include <linux/workqueue_types.h>
+#include <linux/spinlock_types.h>
 #include <linux/wait.h>
-#include <linux/hrtimer.h>
+#include <linux/hrtimer_types.h>
 #include <linux/completion.h>
 
 #ifdef CONFIG_PM_CLK
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index bb6003d78d19..5c90e059cdb7 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -10,11 +10,11 @@
 
 #include <linux/device.h>
 #include <linux/ktime.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/pm.h>
 #include <linux/err.h>
 #include <linux/notifier.h>
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <linux/cpumask.h>
 #include <linux/time64.h>
 
diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index c88ceca7cb6e..b6b0231ddf44 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -5,7 +5,7 @@
 #include <linux/alarmtimer.h>
 #include <linux/list.h>
 #include <linux/posix-timers_types.h>
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <linux/timerqueue.h>
 
 struct kernel_siginfo;
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index c0992a77feea..2bcf998da2a7 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -13,9 +13,9 @@
 #define __LINUX_POWER_SUPPLY_H__
 
 #include <linux/device.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 #include <linux/leds.h>
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <linux/notifier.h>
 
 /*
diff --git a/include/linux/pruss_driver.h b/include/linux/pruss_driver.h
index c9a31c567e85..954c713fbf44 100644
--- a/include/linux/pruss_driver.h
+++ b/include/linux/pruss_driver.h
@@ -9,7 +9,7 @@
 #ifndef _PRUSS_DRIVER_H_
 #define _PRUSS_DRIVER_H_
 
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/remoteproc/pruss.h>
 #include <linux/types.h>
 #include <linux/err.h>
diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index 7b1c9167f756..8af6452b36e2 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -3,7 +3,7 @@
 #define _LINUX_PSI_TYPES_H
 
 #include <linux/kthread.h>
-#include <linux/seqlock.h>
+#include <linux/seqlock_types.h>
 #include <linux/types.h>
 #include <linux/wait.h>
 
diff --git a/include/linux/pstore.h b/include/linux/pstore.h
index 638507a3c8ff..cc64b4df980f 100644
--- a/include/linux/pstore.h
+++ b/include/linux/pstore.h
@@ -13,8 +13,8 @@
 #include <linux/compiler.h>
 #include <linux/errno.h>
 #include <linux/kmsg_dump.h>
-#include <linux/mutex.h>
-#include <linux/spinlock.h>
+#include <linux/mutex_types.h>
+#include <linux/spinlock_types.h>
 #include <linux/time.h>
 #include <linux/types.h>
 
diff --git a/include/linux/qed/qede_rdma.h b/include/linux/qed/qede_rdma.h
index 0d5564a59a59..4daca0b20edc 100644
--- a/include/linux/qed/qede_rdma.h
+++ b/include/linux/qed/qede_rdma.h
@@ -10,7 +10,7 @@
 #include <linux/pci.h>
 #include <linux/netdevice.h>
 #include <linux/types.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 
 struct qedr_dev;
 struct qed_dev;
diff --git a/include/linux/quota.h b/include/linux/quota.h
index 72a2efc77fb5..bf16d9d2866c 100644
--- a/include/linux/quota.h
+++ b/include/linux/quota.h
@@ -33,9 +33,9 @@
 #define _LINUX_QUOTA_
 
 #include <linux/list.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/rwsem.h>
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <linux/percpu_counter.h>
 
 #include <linux/dqblk_xfs.h>
@@ -43,7 +43,7 @@
 #include <linux/dqblk_v2.h>
 
 #include <linux/atomic.h>
-#include <linux/uidgid.h>
+#include <linux/uidgid_types.h>
 #include <linux/projid.h>
 #include <uapi/linux/quota.h>
 
diff --git a/include/linux/radix-tree.h b/include/linux/radix-tree.h
index eae67015ce51..231c526ec9b8 100644
--- a/include/linux/radix-tree.h
+++ b/include/linux/radix-tree.h
@@ -16,7 +16,6 @@
 #include <linux/percpu.h>
 #include <linux/preempt.h>
 #include <linux/rcupdate.h>
-#include <linux/spinlock.h>
 #include <linux/types.h>
 #include <linux/xarray.h>
 #include <linux/local_lock.h>
diff --git a/include/linux/raid/pq.h b/include/linux/raid/pq.h
index afbabd3f91ab..c4f15014b3b4 100644
--- a/include/linux/raid/pq.h
+++ b/include/linux/raid/pq.h
@@ -10,7 +10,7 @@
 
 #ifdef __KERNEL__
 
-#include <linux/blkdev.h>
+#include <linux/blk_types.h>
 #include <asm/page.h> /* for PAGE_SIZE */
 
 extern const char raid6_empty_zero_page[PAGE_SIZE];
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 8f3390b7c4dc..5c2d2fb1f19a 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -15,7 +15,7 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/bug.h>
-#include <linux/lockdep.h>
+#include <linux/lockdep_types.h>
 #include <linux/iopoll.h>
 #include <linux/fwnode.h>
 
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index a924a7d5b44a..b9576d956584 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -36,7 +36,7 @@
 #define REMOTEPROC_H
 
 #include <linux/types.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/virtio.h>
 #include <linux/cdev.h>
 #include <linux/idr.h>
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 66942d7fba7f..c62f0be16fa2 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -4,10 +4,13 @@
 
 #include <linux/kernel.h>
 #include <linux/list.h>
-#include <linux/pid.h>
 
 #ifdef CONFIG_PROC_CPU_RESCTRL
 
+#include <linux/pid_types.h>
+
+struct pid;
+
 int proc_resctrl_show(struct seq_file *m,
 		      struct pid_namespace *ns,
 		      struct pid *pid,
diff --git a/include/linux/reset/reset-simple.h b/include/linux/reset/reset-simple.h
index c3e44f45b0f7..9524a673707a 100644
--- a/include/linux/reset/reset-simple.h
+++ b/include/linux/reset/reset-simple.h
@@ -14,7 +14,7 @@
 
 #include <linux/io.h>
 #include <linux/reset-controller.h>
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 
 /**
  * struct reset_simple_data - driver data for simple reset controllers
diff --git a/include/linux/rhashtable-types.h b/include/linux/rhashtable-types.h
index b6f3797277ff..154dfe4f0508 100644
--- a/include/linux/rhashtable-types.h
+++ b/include/linux/rhashtable-types.h
@@ -11,7 +11,7 @@
 
 #include <linux/atomic.h>
 #include <linux/compiler.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/workqueue_types.h>
 
 struct rhash_head {
diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
index 90d8e4475f80..cdc3574fd712 100644
--- a/include/linux/rpmsg.h
+++ b/include/linux/rpmsg.h
@@ -15,7 +15,7 @@
 #include <linux/err.h>
 #include <linux/mod_devicetable.h>
 #include <linux/kref.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/poll.h>
 #include <linux/rpmsg/byteorder.h>
 #include <uapi/linux/rpmsg.h>
diff --git a/include/linux/rslib.h b/include/linux/rslib.h
index a04dacbdc8ae..8278223e606f 100644
--- a/include/linux/rslib.h
+++ b/include/linux/rslib.h
@@ -11,7 +11,7 @@
 #define _RSLIB_H_
 
 #include <linux/types.h>	/* for gfp_t */
-#include <linux/gfp.h>		/* for GFP_KERNEL */
+#include <linux/gfp_types.h>	/* for GFP_KERNEL */
 
 /**
  * struct rs_codec - rs codec data
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 5f8e438a0312..98401e771e75 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -40,7 +40,7 @@ static inline time64_t rtc_tm_sub(struct rtc_time *lhs, struct rtc_time *rhs)
 #include <linux/poll.h>
 #include <linux/mutex.h>
 #include <linux/timerqueue.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 
 extern struct class *rtc_class;
 
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 03ca838ed3ec..17436f950ec2 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -10,7 +10,7 @@
 #include <linux/completion.h>
 #include <linux/refcount.h>
 #include <linux/pid.h>
-#include <linux/posix-timers.h>
+#include <linux/posix-timers_types.h>
 #include <linux/mm_types.h>
 #include <asm/ptrace.h>
 
diff --git a/include/linux/sched/user.h b/include/linux/sched/user.h
index 4cc52698e214..671ecee08d23 100644
--- a/include/linux/sched/user.h
+++ b/include/linux/sched/user.h
@@ -2,11 +2,11 @@
 #ifndef _LINUX_SCHED_USER_H
 #define _LINUX_SCHED_USER_H
 
-#include <linux/uidgid.h>
+#include <linux/uidgid_types.h>
 #include <linux/atomic.h>
 #include <linux/percpu_counter.h>
 #include <linux/refcount.h>
-#include <linux/ratelimit.h>
+#include <linux/ratelimit_types.h>
 
 /*
  * Some day this will be a full-fledged user tracking system..
diff --git a/include/linux/scs.h b/include/linux/scs.h
index 4ab5bdc898cf..3917d6919c99 100644
--- a/include/linux/scs.h
+++ b/include/linux/scs.h
@@ -8,7 +8,7 @@
 #ifndef _LINUX_SCS_H
 #define _LINUX_SCS_H
 
-#include <linux/gfp.h>
+#include <linux/gfp_types.h>
 #include <linux/poison.h>
 #include <linux/sched.h>
 #include <linux/sizes.h>
diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
index 96d595cd7659..9e2e0076327d 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -6,7 +6,7 @@
 #include <linux/string.h>
 #include <linux/string_helpers.h>
 #include <linux/bug.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/cpumask.h>
 #include <linux/fs.h>
 #include <linux/cred.h>
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 55b1f3ba48ac..fdfbcb04851a 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -15,7 +15,6 @@
 #include <linux/spinlock.h>
 #include <linux/sched.h>
 #include <linux/tty.h>
-#include <linux/mutex.h>
 #include <linux/sysrq.h>
 #include <uapi/linux/serial_core.h>
 
diff --git a/include/linux/serio.h b/include/linux/serio.h
index 6c27d413da92..c7b0bed2242e 100644
--- a/include/linux/serio.h
+++ b/include/linux/serio.h
@@ -10,7 +10,7 @@
 #include <linux/interrupt.h>
 #include <linux/list.h>
 #include <linux/spinlock.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
 #include <uapi/linux/serio.h>
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 4536ecda102d..a7ee429c0535 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -13,7 +13,7 @@
 #define	_LINUX_SLAB_H
 
 #include <linux/cache.h>
-#include <linux/gfp.h>
+#include <linux/gfp_types.h>
 #include <linux/log2.h>
 #include <linux/overflow.h>
 #include <linux/types.h>
diff --git a/include/linux/soc/qcom/apr.h b/include/linux/soc/qcom/apr.h
index be98aebcb3e1..5ca38308b088 100644
--- a/include/linux/soc/qcom/apr.h
+++ b/include/linux/soc/qcom/apr.h
@@ -3,7 +3,7 @@
 #ifndef __QCOM_APR_H_
 #define __QCOM_APR_H_
 
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
 #include <dt-bindings/soc/qcom,apr.h>
diff --git a/include/linux/soc/qcom/qmi.h b/include/linux/soc/qcom/qmi.h
index 469e02d2aa0d..900c4b3540cc 100644
--- a/include/linux/soc/qcom/qmi.h
+++ b/include/linux/soc/qcom/qmi.h
@@ -11,7 +11,7 @@
 #include <linux/list.h>
 #include <linux/qrtr.h>
 #include <linux/types.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 
 struct socket;
 
diff --git a/include/linux/ssb/ssb.h b/include/linux/ssb/ssb.h
index 1f326da289d3..0b68aeed6c7a 100644
--- a/include/linux/ssb/ssb.h
+++ b/include/linux/ssb/ssb.h
@@ -5,7 +5,7 @@
 #include <linux/device.h>
 #include <linux/list.h>
 #include <linux/types.h>
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <linux/pci.h>
 #include <linux/gpio/driver.h>
 #include <linux/mod_devicetable.h>
diff --git a/include/linux/ssb/ssb_driver_gige.h b/include/linux/ssb/ssb_driver_gige.h
index 28c145a51e57..a45d5ab789b8 100644
--- a/include/linux/ssb/ssb_driver_gige.h
+++ b/include/linux/ssb/ssb_driver_gige.h
@@ -5,7 +5,7 @@
 #include <linux/ssb/ssb.h>
 #include <linux/bug.h>
 #include <linux/pci.h>
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 
 
 #ifdef CONFIG_SSB_DRIVER_GIGE
diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
index a6aa21393755..13948903a8b1 100644
--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -20,7 +20,7 @@
 #ifndef _LINUX_STACKDEPOT_H
 #define _LINUX_STACKDEPOT_H
 
-#include <linux/gfp.h>
+#include <linux/gfp_types.h>
 #include <linux/init.h>
 
 typedef u32 depot_stack_handle_t;
diff --git a/include/linux/stat.h b/include/linux/stat.h
index 52150570d37a..a446d65f1082 100644
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -17,7 +17,7 @@
 
 #include <linux/types.h>
 #include <linux/time.h>
-#include <linux/uidgid.h>
+#include <linux/uidgid_types.h>
 
 struct kstat {
 	u32		result_mask;	/* What fields the user got */
diff --git a/include/linux/sunrpc/auth_gss.h b/include/linux/sunrpc/auth_gss.h
index 43e481aa347a..4cb7ccf9a622 100644
--- a/include/linux/sunrpc/auth_gss.h
+++ b/include/linux/sunrpc/auth_gss.h
@@ -13,7 +13,7 @@
 #ifndef _LINUX_SUNRPC_AUTH_GSS_H
 #define _LINUX_SUNRPC_AUTH_GSS_H
 
-#include <linux/refcount.h>
+#include <linux/refcount_types.h>
 #include <linux/sunrpc/auth.h>
 #include <linux/sunrpc/svc.h>
 #include <linux/sunrpc/gss_api.h>
diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index 5e9d1469c6fa..182fa9c4f805 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -14,7 +14,7 @@
 #include <linux/socket.h>
 #include <linux/in.h>
 #include <linux/in6.h>
-#include <linux/refcount.h>
+#include <linux/refcount_types.h>
 
 #include <linux/sunrpc/msg_prot.h>
 #include <linux/sunrpc/sched.h>
diff --git a/include/linux/sunrpc/metrics.h b/include/linux/sunrpc/metrics.h
index 6bfed383ed63..d4bc7fa5f5c1 100644
--- a/include/linux/sunrpc/metrics.h
+++ b/include/linux/sunrpc/metrics.h
@@ -27,7 +27,7 @@
 #define _LINUX_SUNRPC_METRICS_H
 
 #include <linux/ktime.h>
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 
 #define RPC_IOSTATS_VERS	"1.1"
 
diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
index b568e439c6cf..17ffc4e981ff 100644
--- a/include/linux/sunrpc/sched.h
+++ b/include/linux/sunrpc/sched.h
@@ -12,9 +12,9 @@
 
 #include <linux/ktime.h>
 #include <linux/sunrpc/types.h>
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <linux/wait_bit.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 #include <linux/sunrpc/xdr.h>
 
 /*
diff --git a/include/linux/sunrpc/types.h b/include/linux/sunrpc/types.h
index bd3c8e05632b..aedb29de774a 100644
--- a/include/linux/sunrpc/types.h
+++ b/include/linux/sunrpc/types.h
@@ -10,9 +10,9 @@
 #ifndef _LINUX_SUNRPC_TYPES_H_
 #define _LINUX_SUNRPC_TYPES_H_
 
-#include <linux/timer.h>
+#include <linux/timer_types.h>
 #include <linux/sched/signal.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 #include <linux/sunrpc/debug.h>
 #include <linux/list.h>
 
diff --git a/include/linux/swait.h b/include/linux/swait.h
index 1d630ebf561d..68c2e30edb1c 100644
--- a/include/linux/swait.h
+++ b/include/linux/swait.h
@@ -4,7 +4,7 @@
 
 #include <linux/list.h>
 #include <linux/stddef.h>
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <linux/wait.h> // for ___wait_is_interruptible()
 #include <asm/current.h>
 
diff --git a/include/linux/swap.h b/include/linux/swap.h
index b4c389b9e4e0..8d1963c9cd31 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -2,7 +2,7 @@
 #ifndef _LINUX_SWAP_H
 #define _LINUX_SWAP_H
 
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <linux/linkage.h>
 #include <linux/mmzone.h>
 #include <linux/list.h>
diff --git a/include/linux/swap_slots.h b/include/linux/swap_slots.h
index 15adfb8c813a..c17594871e29 100644
--- a/include/linux/swap_slots.h
+++ b/include/linux/swap_slots.h
@@ -3,8 +3,8 @@
 #define _LINUX_SWAP_SLOTS_H
 
 #include <linux/swap.h>
-#include <linux/spinlock.h>
-#include <linux/mutex.h>
+#include <linux/spinlock_types.h>
+#include <linux/mutex_types.h>
 
 #define SWAP_SLOTS_CACHE_SIZE			SWAP_BATCH
 #define THRESHOLD_ACTIVATE_SWAP_SLOTS_CACHE	(5*SWAP_SLOTS_CACHE_SIZE)
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index ecde0312dd52..c37473373649 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -7,8 +7,8 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/limits.h>
-#include <linux/spinlock.h>
-#include <linux/workqueue.h>
+#include <linux/spinlock_types.h>
+#include <linux/workqueue_types.h>
 
 struct device;
 struct page;
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index ee7d33b89e9e..4eb7751d485c 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -25,8 +25,8 @@
 #include <linux/list.h>
 #include <linux/rcupdate.h>
 #include <linux/wait.h>
-#include <linux/rbtree.h>
-#include <linux/uidgid.h>
+#include <linux/rbtree_types.h>
+#include <linux/uidgid_types.h>
 #include <uapi/linux/sysctl.h>
 
 /* For the /proc/sys support */
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index b280468411ab..6fed6884d2e6 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -17,7 +17,7 @@
 #include <linux/kernel.h> // for VERIFY_OCTAL_PERMISSIONS()
 #include <linux/compiler.h>
 #include <linux/list.h>
-#include <linux/lockdep.h>
+#include <linux/lockdep_types.h>
 
 struct kobject;
 struct module;
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 32c35685b693..e0bdda259a29 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -13,7 +13,7 @@
 #include <linux/idr.h>
 #include <linux/device.h>
 #include <linux/sysfs.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 #include <uapi/linux/thermal.h>
 
 /* invalid cooling state */
diff --git a/include/linux/thunderbolt.h b/include/linux/thunderbolt.h
index 2c835e5c41f6..a001233b9359 100644
--- a/include/linux/thunderbolt.h
+++ b/include/linux/thunderbolt.h
@@ -18,7 +18,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/pci.h>
 #include <linux/uuid.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 
 enum tb_cfg_pkg_type {
 	TB_CFG_PKG_READ = 1,
diff --git a/include/linux/tifm.h b/include/linux/tifm.h
index 44073d06710f..7679cef63b5a 100644
--- a/include/linux/tifm.h
+++ b/include/linux/tifm.h
@@ -8,11 +8,11 @@
 #ifndef _TIFM_H
 #define _TIFM_H
 
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/pci.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 
 /* Host registers (relative to pci base address): */
 enum {
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 8c76fd97d4ad..5a3815e7d73d 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -5,12 +5,12 @@
 #include <linux/fs.h>
 #include <linux/major.h>
 #include <linux/termios.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 #include <linux/tty_buffer.h>
 #include <linux/tty_driver.h>
 #include <linux/tty_ldisc.h>
 #include <linux/tty_port.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/tty_flags.h>
 #include <uapi/linux/tty.h>
 #include <linux/rwsem.h>
diff --git a/include/linux/tty_buffer.h b/include/linux/tty_buffer.h
index 31125e3be3c5..752bad9367b8 100644
--- a/include/linux/tty_buffer.h
+++ b/include/linux/tty_buffer.h
@@ -4,8 +4,8 @@
 
 #include <linux/atomic.h>
 #include <linux/llist.h>
-#include <linux/mutex.h>
-#include <linux/workqueue.h>
+#include <linux/mutex_types.h>
+#include <linux/workqueue_types.h>
 
 struct tty_buffer {
 	union {
diff --git a/include/linux/tty_ldisc.h b/include/linux/tty_ldisc.h
index 3a6f70f2f41e..df79a9433ddd 100644
--- a/include/linux/tty_ldisc.h
+++ b/include/linux/tty_ldisc.h
@@ -7,7 +7,7 @@ struct tty_struct;
 #include <linux/fs.h>
 #include <linux/atomic.h>
 #include <linux/list.h>
-#include <linux/lockdep.h>
+#include <linux/lockdep_types.h>
 
 /*
  * the semaphore definition
diff --git a/include/linux/tty_port.h b/include/linux/tty_port.h
index 1b861f2100b6..a76a5b6a5cf2 100644
--- a/include/linux/tty_port.h
+++ b/include/linux/tty_port.h
@@ -4,7 +4,7 @@
 
 #include <linux/kfifo.h>
 #include <linux/kref.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/tty_buffer.h>
 #include <linux/wait.h>
 
diff --git a/include/linux/umh.h b/include/linux/umh.h
index daa6a7048c11..d3693076b830 100644
--- a/include/linux/umh.h
+++ b/include/linux/umh.h
@@ -1,11 +1,11 @@
 #ifndef __LINUX_UMH_H__
 #define __LINUX_UMH_H__
 
-#include <linux/gfp.h>
+#include <linux/gfp_types.h>
 #include <linux/stddef.h>
 #include <linux/errno.h>
 #include <linux/compiler.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 #include <linux/sysctl.h>
 
 struct cred;
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 50685298187a..b72fc1da5d96 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -20,7 +20,7 @@
 #include <linux/fs.h>		/* for struct file_operations */
 #include <linux/completion.h>	/* for struct completion */
 #include <linux/sched.h>	/* for current && schedule_timeout */
-#include <linux/mutex.h>	/* for struct mutex */
+#include <linux/mutex_types.h>	/* for struct mutex */
 #include <linux/sprintf.h>
 #include <linux/pm_runtime.h>	/* for runtime PM */
 
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index a771ccc038ac..0d914c49fed3 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -23,7 +23,7 @@
 #include <linux/slab.h>
 #include <linux/scatterlist.h>
 #include <linux/types.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 #include <linux/usb/ch9.h>
 
 #define UDC_TRACE_STR_MAX	512
diff --git a/include/linux/usb/ljca.h b/include/linux/usb/ljca.h
index 47661feda96c..9e6b05962c95 100644
--- a/include/linux/usb/ljca.h
+++ b/include/linux/usb/ljca.h
@@ -7,7 +7,7 @@
 
 #include <linux/auxiliary_bus.h>
 #include <linux/list.h>
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <linux/types.h>
 
 #define LJCA_MAX_GPIO_NUM 64
diff --git a/include/linux/usb/otg-fsm.h b/include/linux/usb/otg-fsm.h
index 6135d076c53d..c4adc146d754 100644
--- a/include/linux/usb/otg-fsm.h
+++ b/include/linux/usb/otg-fsm.h
@@ -6,7 +6,7 @@
 #ifndef __LINUX_USB_OTG_FSM_H
 #define __LINUX_USB_OTG_FSM_H
 
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/errno.h>
 
 #define PROTO_UNDEF	(0)
diff --git a/include/linux/usb/serial.h b/include/linux/usb/serial.h
index 1a0a4dc87980..2d47c0ae9d64 100644
--- a/include/linux/usb/serial.h
+++ b/include/linux/usb/serial.h
@@ -10,7 +10,7 @@
 #define __LINUX_USB_SERIAL_H
 
 #include <linux/kref.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/serial.h>
 #include <linux/kfifo.h>
 
diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index a9cee5a7b8af..7d0e3418d497 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -5,7 +5,7 @@
 #include <linux/nsproxy.h>
 #include <linux/ns_common.h>
 #include <linux/sched.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 #include <linux/rwsem.h>
 #include <linux/sysctl.h>
 #include <linux/err.h>
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 89b265bc6ec3..e8959e50d44b 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -11,7 +11,7 @@
 
 #include <linux/iommu.h>
 #include <linux/mm.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 #include <linux/poll.h>
 #include <linux/cdev.h>
 #include <uapi/linux/vfio.h>
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index a3075d00675a..92b00a151e5c 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -8,7 +8,7 @@
  * Author: Tom Lyon, pugs@cisco.com
  */
 
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/pci.h>
 #include <linux/vfio.h>
 #include <linux/irqbypass.h>
diff --git a/include/linux/via-core.h b/include/linux/via-core.h
index 8737599b9148..0cb35d8f2527 100644
--- a/include/linux/via-core.h
+++ b/include/linux/via-core.h
@@ -10,7 +10,7 @@
 #define __VIA_CORE_H__
 #include <linux/types.h>
 #include <linux/io.h>
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <linux/pci.h>
 
 /*
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index b0201747a263..a677e86a6305 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -5,10 +5,10 @@
  * implementation. */
 #include <linux/types.h>
 #include <linux/scatterlist.h>
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
-#include <linux/gfp.h>
+#include <linux/gfp_types.h>
 #include <linux/dma-mapping.h>
 
 /**
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 77054ddd7eac..7a76c86cca60 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -6,7 +6,7 @@
 #include <linux/list.h>
 #include <linux/llist.h>
 #include <asm/page.h>		/* pgprot_t */
-#include <linux/rbtree.h>
+#include <linux/rbtree_types.h>
 #include <linux/overflow.h>
 
 #include <asm/vmalloc.h>
diff --git a/include/linux/vmpressure.h b/include/linux/vmpressure.h
index 6a2f51ebbfd3..62e144fcce72 100644
--- a/include/linux/vmpressure.h
+++ b/include/linux/vmpressure.h
@@ -2,10 +2,10 @@
 #ifndef __LINUX_VMPRESSURE_H
 #define __LINUX_VMPRESSURE_H
 
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/list.h>
-#include <linux/workqueue.h>
-#include <linux/gfp.h>
+#include <linux/workqueue_types.h>
+#include <linux/gfp_types.h>
 #include <linux/types.h>
 #include <linux/cgroup.h>
 #include <linux/eventfd.h>
diff --git a/include/linux/vmw_vmci_api.h b/include/linux/vmw_vmci_api.h
index f28907345c80..3a9112f68735 100644
--- a/include/linux/vmw_vmci_api.h
+++ b/include/linux/vmw_vmci_api.h
@@ -8,7 +8,7 @@
 #ifndef __VMW_VMCI_API_H__
 #define __VMW_VMCI_API_H__
 
-#include <linux/uidgid.h>
+#include <linux/uidgid_types.h>
 #include <linux/vmw_vmci_defs.h>
 
 #undef  VMCI_KERNEL_API_VERSION
diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index 65e3c861c22e..fd6ada66f6b5 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -12,7 +12,7 @@
 #include <linux/bitmap.h>
 #include <linux/bug.h>
 #include <linux/compiler.h>
-#include <linux/gfp.h>
+#include <linux/gfp_types.h>
 #include <linux/kconfig.h>
 #include <linux/kernel.h>
 #include <linux/math.h> // for DIV_ROUND_UP()
diff --git a/include/media/dmxdev.h b/include/media/dmxdev.h
index 4f48ed5ceda7..f64a4ecb48ed 100644
--- a/include/media/dmxdev.h
+++ b/include/media/dmxdev.h
@@ -20,12 +20,12 @@
 #define _DMXDEV_H_
 
 #include <linux/types.h>
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <linux/time.h>
-#include <linux/timer.h>
+#include <linux/timer_types.h>
 #include <linux/fs.h>
 #include <linux/string.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/slab.h>
 
 #include <linux/dvb/dmx.h>
diff --git a/include/media/drv-intf/saa7146.h b/include/media/drv-intf/saa7146.h
index 71ce63c99cb4..0e150676ec2e 100644
--- a/include/media/drv-intf/saa7146.h
+++ b/include/media/drv-intf/saa7146.h
@@ -11,7 +11,7 @@
 #include <linux/i2c.h>		/* for i2c subsystem */
 #include <asm/io.h>		/* for accessing devices */
 #include <linux/stringify.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/scatterlist.h>
 #include <media/v4l2-device.h>
 #include <media/v4l2-ctrls.h>
diff --git a/include/media/dvb_demux.h b/include/media/dvb_demux.h
index 8f90330274d5..c091699c70bc 100644
--- a/include/media/dvb_demux.h
+++ b/include/media/dvb_demux.h
@@ -20,8 +20,8 @@
 #define _DVB_DEMUX_H_
 
 #include <linux/time.h>
-#include <linux/spinlock.h>
-#include <linux/mutex.h>
+#include <linux/spinlock_types.h>
+#include <linux/mutex_types.h>
 
 #include <media/demux.h>
 
diff --git a/include/media/dvb_frontend.h b/include/media/dvb_frontend.h
index e7c44870f20d..5f03e0ad04b8 100644
--- a/include/media/dvb_frontend.h
+++ b/include/media/dvb_frontend.h
@@ -39,7 +39,7 @@
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/delay.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/slab.h>
 #include <linux/bitops.h>
 
diff --git a/include/media/dvb_ringbuffer.h b/include/media/dvb_ringbuffer.h
index 029c8b615e49..131997d1f131 100644
--- a/include/media/dvb_ringbuffer.h
+++ b/include/media/dvb_ringbuffer.h
@@ -23,7 +23,7 @@
 #ifndef _DVB_RINGBUFFER_H_
 #define _DVB_RINGBUFFER_H_
 
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <linux/wait.h>
 
 /**
diff --git a/include/media/dvb_vb2.h b/include/media/dvb_vb2.h
index 8cb88452cd6c..d9e6cf91521d 100644
--- a/include/media/dvb_vb2.h
+++ b/include/media/dvb_vb2.h
@@ -15,7 +15,7 @@
 #ifndef _DVB_VB2_H
 #define _DVB_VB2_H
 
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/poll.h>
 #include <linux/dvb/dmx.h>
 #include <media/videobuf2-core.h>
diff --git a/include/media/i2c/adp1653.h b/include/media/i2c/adp1653.h
index 096de9130da8..6b2542da4162 100644
--- a/include/media/i2c/adp1653.h
+++ b/include/media/i2c/adp1653.h
@@ -15,7 +15,7 @@
 #define ADP1653_H
 
 #include <linux/i2c.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/videodev2.h>
 #include <media/v4l2-ctrls.h>
 #include <media/v4l2-subdev.h>
diff --git a/include/media/media-device.h b/include/media/media-device.h
index 397a142c36c5..a7c7086507c9 100644
--- a/include/media/media-device.h
+++ b/include/media/media-device.h
@@ -13,7 +13,7 @@
 
 #include <linux/idr.h> // for struct ida
 #include <linux/list.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/sprintf.h>
diff --git a/include/media/rc-core.h b/include/media/rc-core.h
index eabb19016fec..106fe85ee777 100644
--- a/include/media/rc-core.h
+++ b/include/media/rc-core.h
@@ -8,7 +8,7 @@
 #ifndef _RC_CORE
 #define _RC_CORE
 
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <linux/cdev.h>
 #include <linux/kfifo.h>
 #include <linux/time.h>
diff --git a/include/media/v4l2-dev.h b/include/media/v4l2-dev.h
index d82dfdbf6e58..cd9f633bf351 100644
--- a/include/media/v4l2-dev.h
+++ b/include/media/v4l2-dev.h
@@ -14,7 +14,7 @@
 #include <linux/fs.h>
 #include <linux/device.h>
 #include <linux/cdev.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/videodev2.h>
 
 #include <media/media-entity.h>
diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
index d9c6b5d4e990..879fa8508cf4 100644
--- a/include/media/videobuf2-core.h
+++ b/include/media/videobuf2-core.h
@@ -13,7 +13,7 @@
 #define _MEDIA_VIDEOBUF2_CORE_H
 
 #include <linux/mm_types.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/poll.h>
 #include <linux/dma-buf.h>
 #include <linux/bitops.h>
diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 627ea8e2d915..52c5f73e8029 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -4,8 +4,8 @@
 
 #include <linux/socket.h>
 #include <linux/un.h>
-#include <linux/mutex.h>
-#include <linux/refcount.h>
+#include <linux/mutex_types.h>
+#include <linux/refcount_types.h>
 #include <net/sock.h>
 
 #if IS_ENABLED(CONFIG_UNIX)
diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 535701efc1e5..7eca98931e25 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -9,7 +9,7 @@
 #define __AF_VSOCK_H__
 
 #include <linux/kernel.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 #include <net/sock.h>
 #include <uapi/linux/vm_sockets.h>
 
diff --git a/include/net/atmclip.h b/include/net/atmclip.h
index 70e350e0db3d..e2549b61f707 100644
--- a/include/net/atmclip.h
+++ b/include/net/atmclip.h
@@ -11,7 +11,7 @@
 #include <linux/atm.h>
 #include <linux/atmdev.h>
 #include <linux/atmarp.h>
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <net/neighbour.h>
 
 
diff --git a/include/net/ax25.h b/include/net/ax25.h
index 8c5d4698cf29..a57271b1ba7b 100644
--- a/include/net/ax25.h
+++ b/include/net/ax25.h
@@ -8,8 +8,8 @@
 #define _AX25_H 
 
 #include <linux/ax25.h>
-#include <linux/spinlock.h>
-#include <linux/timer.h>
+#include <linux/spinlock_types.h>
+#include <linux/timer_types.h>
 #include <linux/list.h>
 #include <linux/slab.h>
 #include <linux/refcount.h>
diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index cd95711b12b8..7d5fb857ce96 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -11,7 +11,7 @@
 
 #include <linux/ieee802154.h>
 #include <linux/netdevice.h>
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <linux/bug.h>
 
 #include <net/nl802154.h>
diff --git a/include/net/devlink.h b/include/net/devlink.h
index 7905d55ed0d4..2a41f07cf84c 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -8,12 +8,12 @@
 #define _NET_DEVLINK_H_
 
 #include <linux/slab.h>
-#include <linux/gfp.h>
+#include <linux/gfp_types.h>
 #include <linux/list.h>
 #include <linux/netdevice.h>
-#include <linux/spinlock.h>
-#include <linux/workqueue.h>
-#include <linux/refcount.h>
+#include <linux/spinlock_types.h>
+#include <linux/workqueue_types.h>
+#include <linux/refcount_types.h>
 #include <net/net_namespace.h>
 #include <net/flow_offload.h>
 #include <uapi/linux/devlink.h>
diff --git a/include/net/dst.h b/include/net/dst.h
index 0aa331bd2fdb..6254b4a11a20 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -15,7 +15,7 @@
 #include <linux/rcupdate.h>
 #include <linux/bug.h>
 #include <linux/jiffies.h>
-#include <linux/refcount.h>
+#include <linux/refcount_types.h>
 #include <linux/rcuref.h>
 #include <net/neighbour.h>
 #include <asm/processor.h>
diff --git a/include/net/flow.h b/include/net/flow.h
index 335bbc52171c..836ef37c85de 100644
--- a/include/net/flow.h
+++ b/include/net/flow.h
@@ -11,7 +11,7 @@
 #include <linux/in6.h>
 #include <linux/atomic.h>
 #include <linux/container_of.h>
-#include <linux/uidgid.h>
+#include <linux/uidgid_types.h>
 
 struct flow_keys;
 
diff --git a/include/net/fq.h b/include/net/fq.h
index 99fbe4127b95..c8d44ae1cb65 100644
--- a/include/net/fq.h
+++ b/include/net/fq.h
@@ -8,7 +8,7 @@
 #define __NET_SCHED_FQ_H
 
 #include <linux/skbuff.h>
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <linux/types.h>
 
 struct fq_tin;
diff --git a/include/net/hwbm.h b/include/net/hwbm.h
index aa495decec35..7352b01c100d 100644
--- a/include/net/hwbm.h
+++ b/include/net/hwbm.h
@@ -2,7 +2,7 @@
 #ifndef _HWBM_H
 #define _HWBM_H
 
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 
 struct hwbm_pool {
 	/* Capacity of the pool */
diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index 9ab4bf704e86..4e62121e1cb6 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -13,7 +13,7 @@
 
 #include <linux/compiler.h>
 #include <linux/string.h>
-#include <linux/timer.h>
+#include <linux/timer_types.h>
 #include <linux/poll.h>
 #include <linux/kernel.h>
 #include <linux/sockptr.h>
diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index 5c69fcd3e80e..63fb7bcbda92 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -17,7 +17,7 @@
 #include <linux/list.h>
 #include <linux/slab.h>
 #include <linux/socket.h>
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <linux/types.h>
 
 #include <net/inet_connection_sock.h>
diff --git a/include/net/inet_timewait_sock.h b/include/net/inet_timewait_sock.h
index b7f313b277ea..b2fb3a0851c9 100644
--- a/include/net/inet_timewait_sock.h
+++ b/include/net/inet_timewait_sock.h
@@ -12,7 +12,7 @@
 #define _INET_TIMEWAIT_SOCK_
 
 #include <linux/list.h>
-#include <linux/timer.h>
+#include <linux/timer_types.h>
 #include <linux/types.h>
 
 #include <net/inet_sock.h>
diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
index 360b12e61850..c961bab02f02 100644
--- a/include/net/ip6_fib.h
+++ b/include/net/ip6_fib.h
@@ -11,7 +11,7 @@
 
 #include <linux/ipv6_route.h>
 #include <linux/rtnetlink.h>
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <linux/notifier.h>
 #include <net/dst.h>
 #include <net/flow.h>
diff --git a/include/net/ip_vs.h b/include/net/ip_vs.h
index ff406ef4fd4a..516586a7eeea 100644
--- a/include/net/ip_vs.h
+++ b/include/net/ip_vs.h
@@ -11,13 +11,13 @@
 #include <asm/types.h>                  /* for __uXX types */
 
 #include <linux/list.h>                 /* for struct list_head */
-#include <linux/spinlock.h>             /* for struct rwlock_t */
+#include <linux/spinlock_types.h>       /* for struct rwlock_t */
 #include <linux/atomic.h>               /* for struct atomic_t */
-#include <linux/refcount.h>             /* for struct refcount_t */
+#include <linux/refcount_types.h>       /* for struct refcount_t */
 #include <linux/workqueue.h>
 
 #include <linux/compiler.h>
-#include <linux/timer.h>
+#include <linux/timer_types.h>
 #include <linux/bug.h>
 
 #include <net/checksum.h>
diff --git a/include/net/lib80211.h b/include/net/lib80211.h
index 973049cb0453..308a352be51f 100644
--- a/include/net/lib80211.h
+++ b/include/net/lib80211.h
@@ -30,7 +30,7 @@
 #include <linux/if.h>
 #include <linux/skbuff.h>
 #include <linux/ieee80211.h>
-#include <linux/timer.h>
+#include <linux/timer_types.h>
 
 struct seq_file;
 
diff --git a/include/net/llc.h b/include/net/llc.h
index e250dca03963..3fc0c5ac053f 100644
--- a/include/net/llc.h
+++ b/include/net/llc.h
@@ -15,7 +15,7 @@
 #include <linux/if.h>
 #include <linux/if_ether.h>
 #include <linux/list.h>
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <linux/rculist_nulls.h>
 #include <linux/hash.h>
 #include <linux/jhash.h>
diff --git a/include/net/llc_conn.h b/include/net/llc_conn.h
index 374411b3066c..03843a4738bf 100644
--- a/include/net/llc_conn.h
+++ b/include/net/llc_conn.h
@@ -11,7 +11,7 @@
  *
  * See the GNU General Public License for more details.
  */
-#include <linux/timer.h>
+#include <linux/timer_types.h>
 #include <net/llc_if.h>
 #include <net/sock.h>
 #include <linux/llc.h>
diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 1197433b3315..2f712abacb09 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -26,7 +26,7 @@
 
 #include <linux/err.h>
 #include <linux/sysctl.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 #include <net/rtnetlink.h>
 
 struct seq_file;
diff --git a/include/net/netfilter/nf_conntrack_count.h b/include/net/netfilter/nf_conntrack_count.h
index e227d997fc71..5dab047e14b2 100644
--- a/include/net/netfilter/nf_conntrack_count.h
+++ b/include/net/netfilter/nf_conntrack_count.h
@@ -2,7 +2,7 @@
 #define _NF_CONNTRACK_COUNT_H
 
 #include <linux/list.h>
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <net/netfilter/nf_conntrack_tuple.h>
 #include <net/netfilter/nf_conntrack_zones.h>
 
diff --git a/include/net/netns/can.h b/include/net/netns/can.h
index 48b79f7e6236..f734fe7d5a1c 100644
--- a/include/net/netns/can.h
+++ b/include/net/netns/can.h
@@ -6,8 +6,8 @@
 #ifndef __NETNS_CAN_H__
 #define __NETNS_CAN_H__
 
-#include <linux/spinlock.h>
-#include <linux/timer.h>
+#include <linux/spinlock_types.h>
+#include <linux/timer_types.h>
 
 struct can_dev_rcv_lists;
 struct can_pkg_stats;
diff --git a/include/net/netns/conntrack.h b/include/net/netns/conntrack.h
index e2caf55de629..337381866371 100644
--- a/include/net/netns/conntrack.h
+++ b/include/net/netns/conntrack.h
@@ -12,7 +12,6 @@
 #ifdef CONFIG_NF_CT_PROTO_SCTP
 #include <linux/netfilter/nf_conntrack_sctp.h>
 #endif
-#include <linux/seqlock.h>
 
 struct ctl_table_header;
 struct nf_conntrack_ecache;
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index c356c458b340..1794406d0b84 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -6,10 +6,10 @@
 #ifndef __NETNS_IPV4_H__
 #define __NETNS_IPV4_H__
 
-#include <linux/uidgid.h>
+#include <linux/uidgid_types.h>
 #include <net/inet_frag.h>
 #include <linux/rcupdate.h>
-#include <linux/seqlock.h>
+#include <linux/seqlock_types.h>
 #include <linux/siphash.h>
 
 struct ctl_table_header;
diff --git a/include/net/netns/mctp.h b/include/net/netns/mctp.h
index 6c5039374021..553a610bc29d 100644
--- a/include/net/netns/mctp.h
+++ b/include/net/netns/mctp.h
@@ -7,7 +7,7 @@
 #define __NETNS_MCTP_H__
 
 #include <linux/list.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/types.h>
 
 struct netns_mctp {
diff --git a/include/net/netns/nexthop.h b/include/net/netns/nexthop.h
index 434239b37014..a1b4587af203 100644
--- a/include/net/netns/nexthop.h
+++ b/include/net/netns/nexthop.h
@@ -7,7 +7,7 @@
 #define __NETNS_NEXTHOP_H__
 
 #include <linux/notifier.h>
-#include <linux/rbtree.h>
+#include <linux/rbtree_types.h>
 
 struct netns_nexthop {
 	struct rb_root		rb_root;	/* tree of nexthops by id */
diff --git a/include/net/netns/packet.h b/include/net/netns/packet.h
index aae69bb43cde..babbcff61771 100644
--- a/include/net/netns/packet.h
+++ b/include/net/netns/packet.h
@@ -6,7 +6,7 @@
 #define __NETNS_PACKET_H__
 
 #include <linux/rculist.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 
 struct netns_packet {
 	struct mutex		sklist_lock;
diff --git a/include/net/netns/sctp.h b/include/net/netns/sctp.h
index 7eff3d981b89..5f23768e26e5 100644
--- a/include/net/netns/sctp.h
+++ b/include/net/netns/sctp.h
@@ -2,7 +2,7 @@
 #ifndef __NETNS_SCTP_H__
 #define __NETNS_SCTP_H__
 
-#include <linux/timer.h>
+#include <linux/timer_types.h>
 #include <net/snmp.h>
 
 struct sock;
diff --git a/include/net/netns/smc.h b/include/net/netns/smc.h
index fc752a50f91b..ef019b1c3b8b 100644
--- a/include/net/netns/smc.h
+++ b/include/net/netns/smc.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __NETNS_SMC_H__
 #define __NETNS_SMC_H__
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/percpu.h>
 
 struct smc_stats_rsn;
diff --git a/include/net/netns/unix.h b/include/net/netns/unix.h
index 9859d134d5a8..d5f85c9d7dc7 100644
--- a/include/net/netns/unix.h
+++ b/include/net/netns/unix.h
@@ -5,7 +5,7 @@
 #ifndef __NETNS_UNIX_H__
 #define __NETNS_UNIX_H__
 
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 
 struct unix_table {
 	spinlock_t		*locks;
diff --git a/include/net/netns/xdp.h b/include/net/netns/xdp.h
index 06d06cf2b966..412312dbb2fb 100644
--- a/include/net/netns/xdp.h
+++ b/include/net/netns/xdp.h
@@ -3,7 +3,7 @@
 #define __NETNS_XDP_H__
 
 #include <linux/list.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/types.h>
 
 struct netns_xdp {
diff --git a/include/net/netns/xfrm.h b/include/net/netns/xfrm.h
index 79d382d72ede..8229a19f678c 100644
--- a/include/net/netns/xfrm.h
+++ b/include/net/netns/xfrm.h
@@ -3,7 +3,7 @@
 #define __NETNS_XFRM_H
 
 #include <linux/list.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 #include <linux/rhashtable-types.h>
 #include <linux/xfrm.h>
 #include <net/dst_ops.h>
diff --git a/include/net/phonet/pn_dev.h b/include/net/phonet/pn_dev.h
index e9dc8dca5817..0539fe45207a 100644
--- a/include/net/phonet/pn_dev.h
+++ b/include/net/phonet/pn_dev.h
@@ -11,7 +11,7 @@
 #define PN_DEV_H
 
 #include <linux/list.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 
 struct net;
 
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index da96e966c807..bab44a435a62 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -11,7 +11,7 @@
 #include <linux/dynamic_queue_limits.h>
 #include <linux/list.h>
 #include <linux/refcount.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/rwsem.h>
 #include <linux/atomic.h>
 #include <linux/hashtable.h>
diff --git a/include/net/sctp/sctp.h b/include/net/sctp/sctp.h
index a2310fa995f6..fa4e4861ba8b 100644
--- a/include/net/sctp/sctp.h
+++ b/include/net/sctp/sctp.h
@@ -45,7 +45,7 @@
 #include <linux/in.h>
 #include <linux/tty.h>
 #include <linux/proc_fs.h>
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <linux/jiffies.h>
 #include <linux/idr.h>
 
diff --git a/include/net/sctp/structs.h b/include/net/sctp/structs.h
index f24a1bbcb3ef..6f97da9066ef 100644
--- a/include/net/sctp/structs.h
+++ b/include/net/sctp/structs.h
@@ -42,7 +42,7 @@
 #include <asm/param.h>		/* We get MAXHOSTNAMELEN.     */
 #include <linux/atomic.h>		/* This gets us atomic counters.  */
 #include <linux/skbuff.h>	/* We need sk_buff_head. */
-#include <linux/workqueue.h>	/* We need tq_struct.	 */
+#include <linux/workqueue_types.h>	/* We need tq_struct.	 */
 #include <linux/sctp.h>		/* We need sctp* header structs.  */
 #include <net/sctp/auth.h>	/* We need auth specific structs */
 #include <net/ip.h>		/* For inet_skb_parm */
diff --git a/include/net/smc.h b/include/net/smc.h
index da590f95811e..44a01bd3da10 100644
--- a/include/net/smc.h
+++ b/include/net/smc.h
@@ -11,7 +11,7 @@
 #ifndef _SMC_H
 #define _SMC_H
 
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <linux/types.h>
 #include <linux/wait.h>
 #include "linux/ism.h"
diff --git a/include/net/sock.h b/include/net/sock.h
index a9d99a9c583f..bebdc45cf622 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -39,7 +39,7 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/list_nulls.h>
-#include <linux/timer.h>
+#include <linux/timer_types.h>
 #include <linux/cache.h>
 #include <linux/bitops.h>
 #include <linux/lockdep.h>
@@ -55,7 +55,7 @@
 #include <linux/sched.h>
 #include <linux/wait.h>
 #include <linux/cgroup-defs.h>
-#include <linux/rbtree.h>
+#include <linux/rbtree_types.h>
 #include <linux/rculist_nulls.h>
 #include <linux/poll.h>
 #include <linux/sockptr.h>
diff --git a/include/net/sock_reuseport.h b/include/net/sock_reuseport.h
index 6ec140b0a61b..f7e324bdbb1b 100644
--- a/include/net/sock_reuseport.h
+++ b/include/net/sock_reuseport.h
@@ -5,7 +5,7 @@
 #include <linux/filter.h>
 #include <linux/skbuff.h>
 #include <linux/types.h>
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <net/sock.h>
 
 extern spinlock_t reuseport_lock;
diff --git a/include/net/tls.h b/include/net/tls.h
index 962f0c501111..816b9978bcdc 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -39,7 +39,7 @@
 #include <linux/crypto.h>
 #include <linux/socket.h>
 #include <linux/tcp.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/netdevice.h>
 #include <linux/rcupdate.h>
 
diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 3cb4dc9bd70e..cdb0fcce3b89 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -7,10 +7,10 @@
 #define _LINUX_XDP_SOCK_H
 
 #include <linux/bpf.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 #include <linux/if_xdp.h>
-#include <linux/mutex.h>
-#include <linux/spinlock.h>
+#include <linux/mutex_types.h>
+#include <linux/spinlock_types.h>
 #include <linux/mm.h>
 #include <net/sock.h>
 
diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index b96927bae974..5f9fa70a76bf 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -4,7 +4,7 @@
 
 #include <linux/compiler.h>
 #include <linux/xfrm.h>
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <linux/list.h>
 #include <linux/skbuff.h>
 #include <linux/socket.h>
diff --git a/include/pcmcia/ss.h b/include/pcmcia/ss.h
index 7cf7dbbfa131..694e5ae0f245 100644
--- a/include/pcmcia/ss.h
+++ b/include/pcmcia/ss.h
@@ -14,7 +14,7 @@
 
 #include <linux/device.h>
 #include <linux/sched.h>	/* task_struct, completion */
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 
 #ifdef CONFIG_CARDBUS
 #include <linux/pci.h>
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index b7b6b58dd348..3800bb8b9c14 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -19,7 +19,7 @@
 #include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/rwsem.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 #include <linux/irq_poll.h>
 #include <uapi/linux/if_ether.h>
 #include <net/ipv6.h>
diff --git a/include/rdma/rdma_counter.h b/include/rdma/rdma_counter.h
index 45d5481a7846..5da9a9918d62 100644
--- a/include/rdma/rdma_counter.h
+++ b/include/rdma/rdma_counter.h
@@ -6,7 +6,7 @@
 #ifndef _RDMA_COUNTER_H_
 #define _RDMA_COUNTER_H_
 
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/pid_namespace.h>
 
 #include <rdma/restrack.h>
diff --git a/include/rdma/rdma_vt.h b/include/rdma/rdma_vt.h
index c429d6ddb129..5f8ec8cafa90 100644
--- a/include/rdma/rdma_vt.h
+++ b/include/rdma/rdma_vt.h
@@ -11,7 +11,7 @@
  * rdmavt layer.
  */
 
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <linux/list.h>
 #include <linux/hash.h>
 #include <rdma/ib_verbs.h>
diff --git a/include/scsi/libfc.h b/include/scsi/libfc.h
index eca6fd42d7f7..f0ba69c853ee 100644
--- a/include/scsi/libfc.h
+++ b/include/scsi/libfc.h
@@ -8,7 +8,7 @@
 #ifndef _LIBFC_H_
 #define _LIBFC_H_
 
-#include <linux/timer.h>
+#include <linux/timer_types.h>
 #include <linux/if.h>
 #include <linux/percpu.h>
 #include <linux/refcount.h>
diff --git a/include/scsi/libfcoe.h b/include/scsi/libfcoe.h
index 8300ef1a982e..f62c686ab43c 100644
--- a/include/scsi/libfcoe.h
+++ b/include/scsi/libfcoe.h
@@ -13,7 +13,7 @@
 #include <linux/if_ether.h>
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 #include <linux/local_lock.h>
 #include <linux/random.h>
 #include <scsi/fc/fc_fcoe.h>
diff --git a/include/scsi/libiscsi.h b/include/scsi/libiscsi.h
index 7282555adfd5..01f13729ad24 100644
--- a/include/scsi/libiscsi.h
+++ b/include/scsi/libiscsi.h
@@ -12,9 +12,9 @@
 
 #include <linux/types.h>
 #include <linux/wait.h>
-#include <linux/mutex.h>
-#include <linux/timer.h>
-#include <linux/workqueue.h>
+#include <linux/mutex_types.h>
+#include <linux/timer_types.h>
+#include <linux/workqueue_types.h>
 #include <linux/kfifo.h>
 #include <linux/refcount.h>
 #include <scsi/iscsi_proto.h>
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index f5257103fdb6..943b850a5981 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -10,7 +10,7 @@
 #define _LIBSAS_H_
 
 
-#include <linux/timer.h>
+#include <linux/timer_types.h>
 #include <linux/pci.h>
 #include <scsi/sas.h>
 #include <linux/libata.h>
diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index b1569693da53..810bd80b4f2c 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -3,7 +3,7 @@
 #define _SCSI_SCSI_CMND_H
 
 #include <linux/dma-mapping.h>
-#include <linux/blkdev.h>
+#include <linux/blk_types.h>
 #include <linux/t10-pi.h>
 #include <linux/list.h>
 #include <linux/types.h>
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index 4dceabb9dbe1..c70aafd415b5 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -3,8 +3,8 @@
 #define _SCSI_SCSI_DEVICE_H
 
 #include <linux/list.h>
-#include <linux/spinlock.h>
-#include <linux/workqueue.h>
+#include <linux/spinlock_types.h>
+#include <linux/workqueue_types.h>
 #include <linux/blk-mq.h>
 #include <scsi/scsi.h>
 #include <linux/atomic.h>
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index 2e6aaee6042d..7a05536ea238 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -5,8 +5,8 @@
 #include <linux/device.h>
 #include <linux/list.h>
 #include <linux/types.h>
-#include <linux/workqueue.h>
-#include <linux/mutex.h>
+#include <linux/workqueue_types.h>
+#include <linux/mutex_types.h>
 #include <linux/seq_file.h>
 #include <linux/blk-mq.h>
 #include <scsi/scsi.h>
diff --git a/include/scsi/scsi_tcq.h b/include/scsi/scsi_tcq.h
index ea7848e74d25..ad7ba7fa465f 100644
--- a/include/scsi/scsi_tcq.h
+++ b/include/scsi/scsi_tcq.h
@@ -2,7 +2,7 @@
 #ifndef _SCSI_SCSI_TCQ_H
 #define _SCSI_SCSI_TCQ_H
 
-#include <linux/blkdev.h>
+#include <linux/blk_types.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_device.h>
 #include <scsi/scsi_host.h>
diff --git a/include/scsi/scsi_transport.h b/include/scsi/scsi_transport.h
index a0458bda3148..f417e402cfa7 100644
--- a/include/scsi/scsi_transport.h
+++ b/include/scsi/scsi_transport.h
@@ -8,7 +8,7 @@
 #define SCSI_TRANSPORT_H
 
 #include <linux/transport_class.h>
-#include <linux/blkdev.h>
+#include <linux/blk_types.h>
 #include <linux/bug.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_device.h>
diff --git a/include/scsi/scsi_transport_iscsi.h b/include/scsi/scsi_transport_iscsi.h
index fb3399e4cd29..ea2c9da4c05e 100644
--- a/include/scsi/scsi_transport_iscsi.h
+++ b/include/scsi/scsi_transport_iscsi.h
@@ -12,7 +12,7 @@
 
 #include <linux/device.h>
 #include <linux/list.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <scsi/iscsi_if.h>
 
 struct scsi_transport_template;
diff --git a/include/scsi/scsi_transport_sas.h b/include/scsi/scsi_transport_sas.h
index 0e75b9277c8c..32c73326d34b 100644
--- a/include/scsi/scsi_transport_sas.h
+++ b/include/scsi/scsi_transport_sas.h
@@ -4,7 +4,7 @@
 
 #include <linux/transport_class.h>
 #include <linux/types.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <scsi/sas.h>
 #include <linux/bsg-lib.h>
 
diff --git a/include/scsi/scsi_transport_spi.h b/include/scsi/scsi_transport_spi.h
index 78324502b1c9..a5689b9423e8 100644
--- a/include/scsi/scsi_transport_spi.h
+++ b/include/scsi/scsi_transport_spi.h
@@ -8,7 +8,7 @@
 #define SCSI_TRANSPORT_SPI_H
 
 #include <linux/transport_class.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 
 struct scsi_transport_template;
 struct scsi_target;
diff --git a/include/scsi/scsi_transport_srp.h b/include/scsi/scsi_transport_srp.h
index dfc78aa112ad..b3619dcb795b 100644
--- a/include/scsi/scsi_transport_srp.h
+++ b/include/scsi/scsi_transport_srp.h
@@ -4,7 +4,7 @@
 
 #include <linux/transport_class.h>
 #include <linux/types.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 
 #define SRP_RPORT_ROLE_INITIATOR 0
 #define SRP_RPORT_ROLE_TARGET 1
diff --git a/include/soc/fsl/qe/qe.h b/include/soc/fsl/qe/qe.h
index af793f2a0ec4..768caf98b023 100644
--- a/include/soc/fsl/qe/qe.h
+++ b/include/soc/fsl/qe/qe.h
@@ -14,7 +14,7 @@
 
 #include <linux/compiler.h>
 #include <linux/genalloc.h>
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <soc/fsl/cpm.h>
diff --git a/include/sound/ac97_codec.h b/include/sound/ac97_codec.h
index 4bd3be3a3192..9891d4ec33ee 100644
--- a/include/sound/ac97_codec.h
+++ b/include/sound/ac97_codec.h
@@ -12,7 +12,7 @@
 
 #include <linux/bitops.h>
 #include <linux/device.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 #include <sound/ac97/regs.h>
 #include <sound/pcm.h>
 #include <sound/control.h>
diff --git a/include/sound/core.h b/include/sound/core.h
index a4d06410638b..0c512acac050 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -9,7 +9,7 @@
 
 #include <linux/device.h>
 #include <linux/sched.h>		/* wake_up() */
-#include <linux/mutex.h>		/* struct mutex */
+#include <linux/mutex_types.h>		/* struct mutex */
 #include <linux/rwsem.h>		/* struct rw_semaphore */
 #include <linux/stringify.h>
 #include <linux/printk.h>
diff --git a/include/sound/emu10k1.h b/include/sound/emu10k1.h
index 1af9e6819392..96fb32cbeb7b 100644
--- a/include/sound/emu10k1.h
+++ b/include/sound/emu10k1.h
@@ -16,7 +16,7 @@
 #include <sound/pcm-indirect.h>
 #include <sound/timer.h>
 #include <linux/interrupt.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/firmware.h>
 #include <linux/io.h>
 
diff --git a/include/sound/rawmidi.h b/include/sound/rawmidi.h
index f31cabf0158c..46678a38dbb9 100644
--- a/include/sound/rawmidi.h
+++ b/include/sound/rawmidi.h
@@ -9,10 +9,10 @@
 
 #include <sound/asound.h>
 #include <linux/interrupt.h>
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <linux/wait.h>
-#include <linux/mutex.h>
-#include <linux/workqueue.h>
+#include <linux/mutex_types.h>
+#include <linux/workqueue_types.h>
 #include <linux/device.h>
 
 #if IS_ENABLED(CONFIG_SND_SEQUENCER)
diff --git a/include/sound/util_mem.h b/include/sound/util_mem.h
index 3403b8f4dc86..ad9858a16c0e 100644
--- a/include/sound/util_mem.h
+++ b/include/sound/util_mem.h
@@ -3,7 +3,7 @@
 #define __SOUND_UTIL_MEM_H
 
 #include <linux/list.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 /*
  *  Copyright (C) 2000 Takashi Iwai <tiwai@suse.de>
  *
diff --git a/include/target/iscsi/iscsi_target_stat.h b/include/target/iscsi/iscsi_target_stat.h
index ff6a47209313..007a0364281e 100644
--- a/include/target/iscsi/iscsi_target_stat.h
+++ b/include/target/iscsi/iscsi_target_stat.h
@@ -3,7 +3,7 @@
 #define ISCSI_TARGET_STAT_H
 
 #include <linux/types.h>
-#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
 #include <linux/socket.h>
 
 /*
diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 0e128ad51460..6d50561a8422 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -6,7 +6,7 @@
 #define _TRACE_BLOCK_H
 
 #include <linux/blktrace_api.h>
-#include <linux/blkdev.h>
+#include <linux/blk_types.h>
 #include <linux/buffer_head.h>
 #include <linux/tracepoint.h>
 
diff --git a/include/trace/events/kyber.h b/include/trace/events/kyber.h
index 9d44781efc1c..d5aca7d40514 100644
--- a/include/trace/events/kyber.h
+++ b/include/trace/events/kyber.h
@@ -5,7 +5,7 @@
 #if !defined(_TRACE_KYBER_H) || defined(TRACE_HEADER_MULTI_READ)
 #define _TRACE_KYBER_H
 
-#include <linux/blkdev.h>
+#include <linux/blk_types.h>
 #include <linux/tracepoint.h>
 
 #define DOMAIN_LEN		16
diff --git a/include/trace/events/lock.h b/include/trace/events/lock.h
index 9ebd081e057e..734c28f009a5 100644
--- a/include/trace/events/lock.h
+++ b/include/trace/events/lock.h
@@ -19,7 +19,7 @@
 
 #ifdef CONFIG_LOCKDEP
 
-#include <linux/lockdep.h>
+#include <linux/lockdep_types.h>
 
 TRACE_EVENT(lock_acquire,
 
diff --git a/include/trace/events/mmc.h b/include/trace/events/mmc.h
index 7b706ff21335..0bef571ed465 100644
--- a/include/trace/events/mmc.h
+++ b/include/trace/events/mmc.h
@@ -5,7 +5,7 @@
 #if !defined(_TRACE_MMC_H) || defined(TRACE_HEADER_MULTI_READ)
 #define _TRACE_MMC_H
 
-#include <linux/blkdev.h>
+#include <linux/blk_types.h>
 #include <linux/mmc/core.h>
 #include <linux/mmc/host.h>
 #include <linux/tracepoint.h>
diff --git a/include/trace/events/workqueue.h b/include/trace/events/workqueue.h
index 262d52021c23..39632ee71773 100644
--- a/include/trace/events/workqueue.h
+++ b/include/trace/events/workqueue.h
@@ -6,7 +6,7 @@
 #define _TRACE_WORKQUEUE_H
 
 #include <linux/tracepoint.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 
 struct pool_workqueue;
 
-- 
2.39.2


