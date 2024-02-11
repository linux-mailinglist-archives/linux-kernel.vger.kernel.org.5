Return-Path: <linux-kernel+bounces-60731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A03338508FF
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 481532816EE
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F265B670;
	Sun, 11 Feb 2024 12:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="We2UQJue"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9788853368
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 12:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707654621; cv=none; b=DxWHDraJrV3VksZ5tBOn8FFxwAJyoCUTmLIAD/80sFwkGrs9Baotamp4rvWbs5HIRTkVsepmSgMrCdWQSM65vfG3yzD5crzmfnp6EqqC4ULjZzAZMczsXuyWRehMe+DETINnV4BvE0T5Kha7eF5sbDn3vvBKJe+H70pwqUA0hwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707654621; c=relaxed/simple;
	bh=Oj/Sc799EYOeafhpR1FrkrBtmCYkPlAz/EoBkpGYuZs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JCgPw2Ihbo6Zrq22Xxnl/Xabpyx7kANmAUB22L3IaJH1O234CSgK64q6bnXhpAgOsVkz5P1Zd20mJlryBRrpD6Y8xatnGKb2l7eF1xpN6icijiUDRU4eCIPSnbusjyuvb+VYSWc9B+xvjGo9Gm7eLRlMxYbYf0A/eE193hsURUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=We2UQJue; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55fe4534e9bso3019297a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 04:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707654612; x=1708259412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Chmz2d81B5ktJTwSj+Bw5JcMJXbPq5H0gPIAaWeBEOQ=;
        b=We2UQJuexWziX48uqgJ4inWSlE2v6vf1htlGJnk9tQVt31xaKQzMOmnoDFyFzCbQxF
         p2Mtf9OsIoTH6/n08u8jSyiyZEgJe6saKDKQOF7JXnJC6IdxjCPHXEOK5v9qlGxCccpw
         yGBC7AwrzAzoz3aeuCoSgzIAnt0P6tM+mQsM50t3dHE6Jer+8hZlo82qR7aDEP0wZ1fd
         TkfiU9dT6GtKnylHIFDDVQ6Hm1AngilazCR1OUalpKYO14fBrrtBQaGaDag3DsjALpxc
         x7od83H093UrNPTzeesF9ploeUCJm5aAdfJTSZQoLpp6m9UQL8FnQUF+qp9UngCPRpmh
         p1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707654612; x=1708259412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Chmz2d81B5ktJTwSj+Bw5JcMJXbPq5H0gPIAaWeBEOQ=;
        b=tb1iJPf+Mbzk6MvV0StN0bJoXFugB4WEQuBvaxn5yhg7wEr/zXZc8AtCI7ZmAV1yxu
         lVU1xvykkezNoir5Wj+fzT2v+byo9Kjf4f5pRn8CY8KrX4bplKf9tbngcc4sXrv1Z8ac
         cwkDVp7BJ0Cd5Hnu4z1CMOlGjF9bu8nrZ9N5Pxq7k+jz5jLsYRRIxzDFSPLZTryPvZ07
         BazY4le82/ZdrURF5XeZ2unqxIzuLm0s7yOAJvSPg+x/OMahfsbBj16ac5iM0aYEPsrh
         3wcqOm0gk4NMCmlSSqQHHYr9JgiOTklG5kI8oe1GsphcOpMBs/EPnjBcQq+J7I39+7Mm
         VP5w==
X-Gm-Message-State: AOJu0YyHChmyqS5r9SlqxABND0Dx3QbagTAqCKNF2DGKVe6DH5N5ICAB
	tL946SUgxvMZqCwY6nigLwZ5bU+Jl32rsKJJ21D3hIBbDwc0JIpZhwEiEpCplUd+nUrzDmbpXIF
	J
X-Google-Smtp-Source: AGHT+IH6Go6ZTnIAPazBL4ki7kwtVYS3HVtYRNkDKXPejVLclv8UiRGp7gpPejF6kfpflGZ0ByVr1w==
X-Received: by 2002:aa7:d68e:0:b0:55f:d9d1:6de1 with SMTP id d14-20020aa7d68e000000b0055fd9d16de1mr2408974edr.16.1707654611841;
        Sun, 11 Feb 2024 04:30:11 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id fj18-20020a0564022b9200b0056187ca4120sm1024611edb.10.2024.02.11.04.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 04:30:11 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 02/35] include: remove unnecessary #include directives
Date: Sun, 11 Feb 2024 13:29:27 +0100
Message-Id: <20240211123000.3359365-3-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240211123000.3359365-1-max.kellermann@ionos.com>
References: <20240211123000.3359365-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reduce header dependencies by removing `#include` directives that are
completely unnecessary (or obsolete) or eliminate them by using
forward declarations.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/crypto/drbg.h                       | 1 -
 include/crypto/if_alg.h                     | 1 -
 include/drm/drm_auth.h                      | 1 -
 include/drm/drm_debugfs.h                   | 2 ++
 include/drm/drm_file.h                      | 2 +-
 include/drm/drm_gem_shmem_helper.h          | 1 -
 include/drm/drm_mm.h                        | 1 -
 include/drm/drm_print.h                     | 2 ++
 include/drm/drm_util.h                      | 1 -
 include/drm/drm_vma_manager.h               | 1 -
 include/drm/ttm/ttm_device.h                | 1 -
 include/drm/ttm/ttm_resource.h              | 1 -
 include/keys/asymmetric-subtype.h           | 1 +
 include/kunit/test.h                        | 1 -
 include/linux/acpi_amd_wbrf.h               | 7 +++++--
 include/linux/acpi_dma.h                    | 3 ++-
 include/linux/async_tx.h                    | 1 -
 include/linux/atmdev.h                      | 2 --
 include/linux/backing-dev-defs.h            | 1 -
 include/linux/blkdev.h                      | 4 +---
 include/linux/blktrace_api.h                | 2 --
 include/linux/bpf-netns.h                   | 1 -
 include/linux/bpf.h                         | 1 -
 include/linux/cacheinfo.h                   | 1 -
 include/linux/cdev.h                        | 2 +-
 include/linux/ceph/libceph.h                | 1 -
 include/linux/ceph/messenger.h              | 1 -
 include/linux/cgroup.h                      | 1 -
 include/linux/clocksource.h                 | 1 -
 include/linux/connector.h                   | 1 -
 include/linux/cpuidle.h                     | 1 -
 include/linux/dax.h                         | 1 -
 include/linux/dccp.h                        | 1 -
 include/linux/debugfs.h                     | 1 +
 include/linux/debugobjects.h                | 1 -
 include/linux/device.h                      | 2 --
 include/linux/device/bus.h                  | 3 ++-
 include/linux/device/class.h                | 3 +--
 include/linux/device/driver.h               | 2 --
 include/linux/dma-fence.h                   | 1 -
 include/linux/dma-resv.h                    | 1 -
 include/linux/dmi.h                         | 1 -
 include/linux/dpll.h                        | 1 -
 include/linux/energy_model.h                | 4 ++--
 include/linux/eventfd.h                     | 2 --
 include/linux/extcon.h                      | 5 ++++-
 include/linux/fb.h                          | 3 +--
 include/linux/filter.h                      | 1 -
 include/linux/firewire.h                    | 1 -
 include/linux/fprobe.h                      | 3 ++-
 include/linux/freezer.h                     | 1 -
 include/linux/fs.h                          | 6 ++----
 include/linux/ftrace.h                      | 1 -
 include/linux/greybus/connection.h          | 1 -
 include/linux/group_cpus.h                  | 4 ++--
 include/linux/hrtimer.h                     | 1 -
 include/linux/hyperv.h                      | 1 -
 include/linux/i2c-smbus.h                   | 2 --
 include/linux/i3c/master.h                  | 1 -
 include/linux/iio/buffer.h                  | 2 +-
 include/linux/init_task.h                   | 2 --
 include/linux/interconnect.h                | 1 -
 include/linux/interrupt.h                   | 1 -
 include/linux/io_uring.h                    | 1 -
 include/linux/iommu.h                       | 2 +-
 include/linux/ism.h                         | 2 --
 include/linux/kernel_stat.h                 | 1 -
 include/linux/kernfs.h                      | 5 -----
 include/linux/kgdb.h                        | 2 ++
 include/linux/kobj_map.h                    | 4 +++-
 include/linux/kobject.h                     | 2 --
 include/linux/kprobes.h                     | 2 --
 include/linux/kvm_host.h                    | 1 -
 include/linux/lapb.h                        | 1 -
 include/linux/libnvdimm.h                   | 3 ++-
 include/linux/lru_cache.h                   | 1 -
 include/linux/lsm_audit.h                   | 1 -
 include/linux/mISDNif.h                     | 3 ++-
 include/linux/mailbox_client.h              | 4 ++--
 include/linux/mailbox_controller.h          | 4 ++--
 include/linux/mdio-mux.h                    | 6 ++++--
 include/linux/mdio/mdio-mscc-miim.h         | 8 +++++---
 include/linux/memcontrol.h                  | 2 +-
 include/linux/mempolicy.h                   | 1 -
 include/linux/mfd/altera-a10sr.h            | 1 -
 include/linux/mfd/max8907.h                 | 1 -
 include/linux/mfd/wm831x/core.h             | 1 -
 include/linux/mfd/wm8350/supply.h           | 1 -
 include/linux/mfd/wm8400-private.h          | 1 -
 include/linux/mfd/wm8994/core.h             | 1 -
 include/linux/mm.h                          | 2 --
 include/linux/mm_types.h                    | 1 -
 include/linux/mmu_notifier.h                | 1 -
 include/linux/mtd/blktrans.h                | 1 -
 include/linux/mtd/qinfo.h                   | 2 --
 include/linux/netdevice.h                   | 1 -
 include/linux/netfilter.h                   | 1 -
 include/linux/nfs_fs.h                      | 1 -
 include/linux/nfs_page.h                    | 1 -
 include/linux/nodemask.h                    | 3 +++
 include/linux/nsproxy.h                     | 1 -
 include/linux/percpu_counter.h              | 1 -
 include/linux/perf/arm_pmu.h                | 1 -
 include/linux/phy.h                         | 2 --
 include/linux/phy/phy.h                     | 2 +-
 include/linux/phylink.h                     | 2 --
 include/linux/pid_namespace.h               | 1 -
 include/linux/pktcdvd.h                     | 3 ---
 include/linux/platform_data/asoc-ti-mcbsp.h | 1 -
 include/linux/pm.h                          | 1 -
 include/linux/pm_domain.h                   | 2 +-
 include/linux/posix-timers.h                | 1 -
 include/linux/pps_kernel.h                  | 3 ++-
 include/linux/psi_types.h                   | 1 -
 include/linux/pwm.h                         | 4 ++--
 include/linux/quota.h                       | 1 -
 include/linux/random.h                      | 1 -
 include/linux/regmap.h                      | 1 -
 include/linux/relay.h                       | 1 -
 include/linux/remoteproc.h                  | 1 -
 include/linux/rfkill.h                      | 2 --
 include/linux/ring_buffer.h                 | 1 -
 include/linux/rtc/ds1685.h                  | 1 -
 include/linux/rtnetlink.h                   | 2 --
 include/linux/sbitmap.h                     | 1 -
 include/linux/sched/clock.h                 | 2 +-
 include/linux/sched/signal.h                | 3 ++-
 include/linux/security.h                    | 2 +-
 include/linux/seq_file.h                    | 1 -
 include/linux/sh_clk.h                      | 1 -
 include/linux/slab.h                        | 1 -
 include/linux/slimbus.h                     | 3 ++-
 include/linux/soc/apple/rtkit.h             | 3 ++-
 include/linux/soc/apple/sart.h              | 2 +-
 include/linux/soc/mediatek/mtk-cmdq.h       | 1 -
 include/linux/soc/qcom/qcom_aoss.h          | 2 +-
 include/linux/spi/spi_bitbang.h             | 1 -
 include/linux/srcu.h                        | 2 --
 include/linux/stm.h                         | 4 +++-
 include/linux/sunrpc/auth.h                 | 1 -
 include/linux/sunrpc/metrics.h              | 3 ++-
 include/linux/sunrpc/rpc_pipe_fs.h          | 1 -
 include/linux/sunrpc/sched.h                | 1 -
 include/linux/sunrpc/svc.h                  | 1 -
 include/linux/sunrpc/svc_rdma.h             | 1 -
 include/linux/sunrpc/svcauth.h              | 1 -
 include/linux/swait.h                       | 2 +-
 include/linux/swapops.h                     | 1 -
 include/linux/sync_file.h                   | 1 -
 include/linux/sys_soc.h                     | 3 ++-
 include/linux/syscalls.h                    | 1 -
 include/linux/sysfs.h                       | 5 -----
 include/linux/thermal.h                     | 1 -
 include/linux/torture.h                     | 4 ----
 include/linux/tracefs.h                     | 1 -
 include/linux/transport_class.h             | 3 ++-
 include/linux/tty_driver.h                  | 1 +
 include/linux/tty_ldisc.h                   | 2 --
 include/linux/u64_stats_sync.h              | 3 +++
 include/linux/uprobes.h                     | 2 --
 include/linux/usb/hcd.h                     | 1 -
 include/linux/usb/role.h                    | 5 ++++-
 include/linux/user_namespace.h              | 1 -
 include/linux/vfio_pci_core.h               | 1 -
 include/linux/vmalloc.h                     | 1 -
 include/linux/vt_kern.h                     | 1 -
 include/linux/writeback.h                   | 1 -
 include/media/cec.h                         | 1 -
 include/media/dmxdev.h                      | 1 -
 include/media/dvb_demux.h                   | 1 -
 include/media/rc-core.h                     | 1 -
 include/media/v4l2-async.h                  | 1 -
 include/media/v4l2-event.h                  | 1 -
 include/media/v4l2-ioctl.h                  | 1 -
 include/net/ax25.h                          | 1 -
 include/net/bluetooth/bluetooth.h           | 3 ++-
 include/net/bonding.h                       | 1 -
 include/net/bpf_sk_storage.h                | 4 ----
 include/net/caif/cfcnfg.h                   | 1 -
 include/net/caif/cfsrvl.h                   | 1 -
 include/net/devlink.h                       | 3 +--
 include/net/dsa.h                           | 2 --
 include/net/dsa_stubs.h                     | 1 -
 include/net/inet_hashtables.h               | 1 -
 include/net/inet_timewait_sock.h            | 1 -
 include/net/inetpeer.h                      | 1 -
 include/net/ip_fib.h                        | 1 -
 include/net/lib80211.h                      | 3 ++-
 include/net/neighbour.h                     | 3 ++-
 include/net/net_namespace.h                 | 1 -
 include/net/net_ratelimit.h                 | 2 --
 include/net/netns/conntrack.h               | 1 -
 include/net/netns/xfrm.h                    | 1 -
 include/net/netrom.h                        | 1 -
 include/net/pkt_cls.h                       | 3 ++-
 include/net/sch_generic.h                   | 1 -
 include/net/smc.h                           | 2 +-
 include/net/snmp.h                          | 1 -
 include/net/tcp.h                           | 4 ++--
 include/net/udp.h                           | 3 ++-
 include/net/xfrm.h                          | 1 -
 include/rdma/ib_umem.h                      | 1 -
 include/rdma/restrack.h                     | 1 -
 include/scsi/scsi_cmnd.h                    | 1 -
 include/scsi/scsi_host.h                    | 1 +
 include/sound/core.h                        | 1 -
 include/video/atmel_lcdc.h                  | 2 --
 include/xen/interface/memory.h              | 2 --
 include/xen/xenbus.h                        | 1 -
 209 files changed, 109 insertions(+), 257 deletions(-)

diff --git a/include/crypto/drbg.h b/include/crypto/drbg.h
index af5ad51d3eef..e78a671a9e76 100644
--- a/include/crypto/drbg.h
+++ b/include/crypto/drbg.h
@@ -52,7 +52,6 @@
 #include <linux/fips.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
-#include <linux/workqueue.h>
 
 /*
  * Concatenation Helper and string operation helper
diff --git a/include/crypto/if_alg.h b/include/crypto/if_alg.h
index 78ecaf5db04c..6e532e2a6e6b 100644
--- a/include/crypto/if_alg.h
+++ b/include/crypto/if_alg.h
@@ -9,7 +9,6 @@
 #define _CRYPTO_IF_ALG_H
 
 #include <linux/compiler.h>
-#include <linux/completion.h>
 #include <linux/if_alg.h>
 #include <linux/scatterlist.h>
 #include <linux/types.h>
diff --git a/include/drm/drm_auth.h b/include/drm/drm_auth.h
index 50131383ed81..cb7377d5f5c3 100644
--- a/include/drm/drm_auth.h
+++ b/include/drm/drm_auth.h
@@ -30,7 +30,6 @@
 
 #include <linux/idr.h>
 #include <linux/kref.h>
-#include <linux/wait.h>
 
 struct drm_file;
 
diff --git a/include/drm/drm_debugfs.h b/include/drm/drm_debugfs.h
index cf06cee4343f..ebf0973aaa8a 100644
--- a/include/drm/drm_debugfs.h
+++ b/include/drm/drm_debugfs.h
@@ -37,6 +37,8 @@
 
 #include <drm/drm_gpuvm.h>
 
+struct seq_file;
+
 /**
  * DRM_DEBUGFS_GPUVA_INFO - &drm_info_list entry to dump a GPU VA space
  * @show: the &drm_info_list's show callback
diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
index ab230d3af138..5d97a20cf80f 100644
--- a/include/drm/drm_file.h
+++ b/include/drm/drm_file.h
@@ -31,13 +31,13 @@
 #define _DRM_FILE_H_
 
 #include <linux/types.h>
-#include <linux/completion.h>
 #include <linux/idr.h>
 
 #include <uapi/drm/drm.h>
 
 #include <drm/drm_prime.h>
 
+struct completion;
 struct dma_fence;
 struct drm_file;
 struct drm_device;
diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
index bf0c31aa8fbe..dd74ffd10252 100644
--- a/include/drm/drm_gem_shmem_helper.h
+++ b/include/drm/drm_gem_shmem_helper.h
@@ -5,7 +5,6 @@
 
 #include <linux/fs.h>
 #include <linux/mm.h>
-#include <linux/mutex.h>
 
 #include <drm/drm_file.h>
 #include <drm/drm_gem.h>
diff --git a/include/drm/drm_mm.h b/include/drm/drm_mm.h
index ac33ba1b18bc..abc1d1d48142 100644
--- a/include/drm/drm_mm.h
+++ b/include/drm/drm_mm.h
@@ -42,7 +42,6 @@
 #include <linux/limits.h>
 #include <linux/mm_types.h>
 #include <linux/list.h>
-#include <linux/spinlock.h>
 #ifdef CONFIG_DRM_DEBUG_MM
 #include <linux/stackdepot.h>
 #endif
diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index 5ed26a702e3e..36b0d14be87e 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -35,6 +35,8 @@
 
 #include <drm/drm.h>
 
+struct seq_file;
+
 /* Do *not* use outside of drm_print.[ch]! */
 extern unsigned long __drm_debug;
 
diff --git a/include/drm/drm_util.h b/include/drm/drm_util.h
index 79952d8c4bba..15fd591f3e1d 100644
--- a/include/drm/drm_util.h
+++ b/include/drm/drm_util.h
@@ -35,7 +35,6 @@
 #include <linux/interrupt.h>
 #include <linux/kgdb.h>
 #include <linux/preempt.h>
-#include <linux/smp.h>
 
 /*
  * Use EXPORT_SYMBOL_FOR_TESTS_ONLY() for functions that shall
diff --git a/include/drm/drm_vma_manager.h b/include/drm/drm_vma_manager.h
index 6c2a2f21dbf0..b0efaeeb4cf0 100644
--- a/include/drm/drm_vma_manager.h
+++ b/include/drm/drm_vma_manager.h
@@ -26,7 +26,6 @@
 #include <drm/drm_mm.h>
 #include <linux/mm.h>
 #include <linux/rbtree.h>
-#include <linux/spinlock.h>
 #include <linux/types.h>
 
 /* We make up offsets for buffer objects so we can recognize them at
diff --git a/include/drm/ttm/ttm_device.h b/include/drm/ttm/ttm_device.h
index c22f30535c84..122f1455a2df 100644
--- a/include/drm/ttm/ttm_device.h
+++ b/include/drm/ttm/ttm_device.h
@@ -26,7 +26,6 @@
 #define _TTM_DEVICE_H_
 
 #include <linux/types.h>
-#include <linux/workqueue.h>
 #include <drm/ttm/ttm_resource.h>
 #include <drm/ttm/ttm_pool.h>
 
diff --git a/include/drm/ttm/ttm_resource.h b/include/drm/ttm/ttm_resource.h
index 1afa13f0c22b..886c8c7970b5 100644
--- a/include/drm/ttm/ttm_resource.h
+++ b/include/drm/ttm/ttm_resource.h
@@ -27,7 +27,6 @@
 
 #include <linux/types.h>
 #include <linux/list.h>
-#include <linux/mutex.h>
 #include <linux/iosys-map.h>
 #include <linux/dma-fence.h>
 
diff --git a/include/keys/asymmetric-subtype.h b/include/keys/asymmetric-subtype.h
index d55171f640a0..ea7d4ca9e315 100644
--- a/include/keys/asymmetric-subtype.h
+++ b/include/keys/asymmetric-subtype.h
@@ -13,6 +13,7 @@
 #include <linux/seq_file.h>
 #include <keys/asymmetric-type.h>
 
+struct seq_file;
 struct kernel_pkey_query;
 struct kernel_pkey_params;
 struct public_key_signature;
diff --git a/include/kunit/test.h b/include/kunit/test.h
index a512bfd92294..a82e025df09e 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -19,7 +19,6 @@
 #include <linux/init.h>
 #include <linux/jump_label.h>
 #include <linux/kconfig.h>
-#include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/slab.h>
diff --git a/include/linux/acpi_amd_wbrf.h b/include/linux/acpi_amd_wbrf.h
index 898f31d536d4..8b83cc9f6f7b 100644
--- a/include/linux/acpi_amd_wbrf.h
+++ b/include/linux/acpi_amd_wbrf.h
@@ -7,8 +7,11 @@
 #ifndef _ACPI_AMD_WBRF_H
 #define _ACPI_AMD_WBRF_H
 
-#include <linux/device.h>
-#include <linux/notifier.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+
+struct device;
+struct notifier_block;
 
 /* The maximum number of frequency band ranges */
 #define MAX_NUM_OF_WBRF_RANGES		11
diff --git a/include/linux/acpi_dma.h b/include/linux/acpi_dma.h
index 72cedb916a9c..40d99e88ddd2 100644
--- a/include/linux/acpi_dma.h
+++ b/include/linux/acpi_dma.h
@@ -12,10 +12,11 @@
 #define __LINUX_ACPI_DMA_H
 
 #include <linux/list.h>
-#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/dmaengine.h>
 
+struct device;
+
 /**
  * struct acpi_dma_spec - slave device DMA resources
  * @chan_id:	channel unique id
diff --git a/include/linux/async_tx.h b/include/linux/async_tx.h
index 5cc73d7e5b52..9ba1dd21e4de 100644
--- a/include/linux/async_tx.h
+++ b/include/linux/async_tx.h
@@ -5,7 +5,6 @@
 #ifndef _ASYNC_TX_H_
 #define _ASYNC_TX_H_
 #include <linux/dmaengine.h>
-#include <linux/spinlock.h>
 #include <linux/interrupt.h>
 
 /* on architectures without dma-mapping capabilities we need to ensure
diff --git a/include/linux/atmdev.h b/include/linux/atmdev.h
index 9b02961d65ee..4f9117f83d39 100644
--- a/include/linux/atmdev.h
+++ b/include/linux/atmdev.h
@@ -3,8 +3,6 @@
 #ifndef LINUX_ATMDEV_H
 #define LINUX_ATMDEV_H
 
-
-#include <linux/wait.h> /* wait_queue_head_t */
 #include <linux/time.h> /* struct timeval */
 #include <linux/net.h>
 #include <linux/bug.h>
diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index 721659b4edd7..7bf50450cd69 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -13,7 +13,6 @@
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <linux/kref.h>
-#include <linux/refcount.h>
 
 #ifdef CONFIG_CGROUP_WRITEBACK
 #include <linux/rwsem.h>
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 7514e2a70601..94d7d5f51202 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -10,7 +10,6 @@
 #include <linux/blk_types.h>
 #include <linux/device.h>
 #include <linux/list.h>
-#include <linux/llist.h>
 #include <linux/minmax.h>
 #include <linux/timer.h>
 #include <linux/workqueue.h>
@@ -22,11 +21,9 @@
 #include <linux/percpu-refcount.h>
 #include <linux/blkzoned.h>
 #include <linux/sched.h>
-#include <linux/sbitmap.h>
 #include <linux/uio.h> // for iov_iter_is_aligned()
 #include <linux/uuid.h>
 #include <linux/xarray.h>
-#include <linux/file.h>
 
 struct module;
 struct request_queue;
@@ -42,6 +39,7 @@ struct rq_qos;
 struct blk_queue_stats;
 struct blk_stat_callback;
 struct blk_crypto_profile;
+struct file;
 
 extern const struct device_type disk_type;
 extern const struct device_type part_type;
diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
index 122c62e561fc..c9e0ecae5fa0 100644
--- a/include/linux/blktrace_api.h
+++ b/include/linux/blktrace_api.h
@@ -11,8 +11,6 @@
 
 #if defined(CONFIG_BLK_DEV_IO_TRACE)
 
-#include <linux/sysfs.h>
-
 struct blk_trace {
 	int trace_state;
 	struct rchan *rchan;
diff --git a/include/linux/bpf-netns.h b/include/linux/bpf-netns.h
index 413cfa5e4b07..c5bcf01d712e 100644
--- a/include/linux/bpf-netns.h
+++ b/include/linux/bpf-netns.h
@@ -2,7 +2,6 @@
 #ifndef _BPF_NETNS_H
 #define _BPF_NETNS_H
 
-#include <linux/mutex.h>
 #include <net/netns/bpf.h>
 #include <uapi/linux/bpf.h>
 
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 71cf43fbdc24..34b065a064c9 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -14,7 +14,6 @@
 #include <linux/rbtree_latch.h>
 #include <linux/numa.h>
 #include <linux/mm_types.h>
-#include <linux/wait.h>
 #include <linux/refcount.h>
 #include <linux/mutex.h>
 #include <linux/module.h>
diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index d504eb4b49ab..9e422f4fdc38 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -4,7 +4,6 @@
 
 #include <linux/bitops.h>
 #include <linux/cpumask.h>
-#include <linux/smp.h>
 
 struct device_node;
 struct attribute;
diff --git a/include/linux/cdev.h b/include/linux/cdev.h
index 0e8cd6293deb..6f4892ff3a40 100644
--- a/include/linux/cdev.h
+++ b/include/linux/cdev.h
@@ -5,8 +5,8 @@
 #include <linux/kobject.h>
 #include <linux/kdev_t.h>
 #include <linux/list.h>
-#include <linux/device.h>
 
+struct device;
 struct file_operations;
 struct inode;
 struct module;
diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
index 4497d0a6772c..b86a567e9493 100644
--- a/include/linux/ceph/libceph.h
+++ b/include/linux/ceph/libceph.h
@@ -6,7 +6,6 @@
 
 #include <asm/unaligned.h>
 #include <linux/backing-dev.h>
-#include <linux/completion.h>
 #include <linux/exportfs.h>
 #include <linux/bug.h>
 #include <linux/fs.h>
diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 1717cc57cdac..730a9cf017dd 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -7,7 +7,6 @@
 #include <linux/kref.h>
 #include <linux/mutex.h>
 #include <linux/net.h>
-#include <linux/radix-tree.h>
 #include <linux/uio.h>
 #include <linux/workqueue.h>
 #include <net/net_namespace.h>
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 34aaf0e87def..24dcff53bd05 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -11,7 +11,6 @@
 
 #include <linux/sched.h>
 #include <linux/cpumask.h>
-#include <linux/nodemask.h>
 #include <linux/rculist.h>
 #include <linux/cgroupstats.h>
 #include <linux/fs.h>
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 1d42d4b17327..4cfdc7068baa 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -14,7 +14,6 @@
 #include <linux/time.h>
 #include <linux/list.h>
 #include <linux/cache.h>
-#include <linux/timer.h>
 #include <linux/init.h>
 #include <linux/of.h>
 #include <linux/clocksource_ids.h>
diff --git a/include/linux/connector.h b/include/linux/connector.h
index 70bc1160f3d8..c85ddfc2094e 100644
--- a/include/linux/connector.h
+++ b/include/linux/connector.h
@@ -12,7 +12,6 @@
 #include <linux/refcount.h>
 
 #include <linux/list.h>
-#include <linux/workqueue.h>
 
 #include <net/sock.h>
 #include <uapi/linux/connector.h>
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 3183aeb7f5b4..188003e46c29 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -13,7 +13,6 @@
 
 #include <linux/percpu.h>
 #include <linux/list.h>
-#include <linux/hrtimer.h>
 #include <linux/context_tracking.h>
 
 #define CPUIDLE_STATE_MAX	10
diff --git a/include/linux/dax.h b/include/linux/dax.h
index b463502b16e1..50f1e1ea2a47 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -4,7 +4,6 @@
 
 #include <linux/fs.h>
 #include <linux/mm.h>
-#include <linux/radix-tree.h>
 
 typedef unsigned long dax_entry_t;
 
diff --git a/include/linux/dccp.h b/include/linux/dccp.h
index 325af611909f..743f1abd20fb 100644
--- a/include/linux/dccp.h
+++ b/include/linux/dccp.h
@@ -8,7 +8,6 @@
 #include <linux/ktime.h>
 #include <linux/list.h>
 #include <linux/uio.h>
-#include <linux/workqueue.h>
 
 #include <net/inet_connection_sock.h>
 #include <net/inet_sock.h>
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index c9c65b132c0f..ef158781a580 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -20,6 +20,7 @@
 
 struct device;
 struct file_operations;
+struct seq_file;
 
 struct debugfs_blob_wrapper {
 	void *data;
diff --git a/include/linux/debugobjects.h b/include/linux/debugobjects.h
index 32444686b6ff..3c689461781f 100644
--- a/include/linux/debugobjects.h
+++ b/include/linux/debugobjects.h
@@ -3,7 +3,6 @@
 #define _LINUX_DEBUGOBJECTS_H
 
 #include <linux/list.h>
-#include <linux/spinlock.h>
 
 enum debug_obj_state {
 	ODEBUG_STATE_NONE,
diff --git a/include/linux/device.h b/include/linux/device.h
index ddba2d30c541..5e47c9b5d0fa 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -22,8 +22,6 @@
 #include <linux/compiler.h>
 #include <linux/types.h>
 #include <linux/mutex.h>
-#include <linux/pm.h>
-#include <linux/atomic.h>
 #include <linux/uidgid.h>
 #include <linux/gfp.h>
 #include <linux/overflow.h>
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index 76826d165298..bdd8ac64f629 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -14,13 +14,14 @@
 #ifndef _DEVICE_BUS_H_
 #define _DEVICE_BUS_H_
 
-#include <linux/kobject.h>
 #include <linux/klist.h>
 #include <linux/pm.h>
 #include <linux/sysfs.h> // for struct attribute
 
 struct device_driver;
+struct device_node;
 struct fwnode_handle;
+struct kobj_uevent_env;
 
 /**
  * struct bus_type - The bus type of the device
diff --git a/include/linux/device/class.h b/include/linux/device/class.h
index 6b1cebe43f8e..cf140c3e61f2 100644
--- a/include/linux/device/class.h
+++ b/include/linux/device/class.h
@@ -14,14 +14,13 @@
 #ifndef _DEVICE_CLASS_H_
 #define _DEVICE_CLASS_H_
 
-#include <linux/kobject.h>
 #include <linux/klist.h>
-#include <linux/pm.h>
 #include <linux/uidgid_types.h>
 #include <linux/device/bus.h>
 
 struct device;
 struct fwnode_handle;
+struct kobj_uevent_env;
 
 /**
  * struct class - device classes
diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index 7738f458995f..a3b51f5bd0e9 100644
--- a/include/linux/device/driver.h
+++ b/include/linux/device/driver.h
@@ -14,9 +14,7 @@
 #ifndef _DEVICE_DRIVER_H_
 #define _DEVICE_DRIVER_H_
 
-#include <linux/kobject.h>
 #include <linux/klist.h>
-#include <linux/pm.h>
 #include <linux/device/bus.h>
 #include <linux/module.h>
 
diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index 73358704c8a0..3081ff146d41 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -14,7 +14,6 @@
 #define __LINUX_DMA_FENCE_H
 
 #include <linux/err.h>
-#include <linux/wait.h>
 #include <linux/list.h>
 #include <linux/bitops.h>
 #include <linux/kernel.h> // for lower_32_bits()
diff --git a/include/linux/dma-resv.h b/include/linux/dma-resv.h
index 8d0e34dad446..4aae9e4cc592 100644
--- a/include/linux/dma-resv.h
+++ b/include/linux/dma-resv.h
@@ -42,7 +42,6 @@
 #include <linux/ww_mutex.h>
 #include <linux/dma-fence.h>
 #include <linux/slab.h>
-#include <linux/seqlock.h>
 #include <linux/rcupdate.h>
 
 extern struct ww_class reservation_ww_class;
diff --git a/include/linux/dmi.h b/include/linux/dmi.h
index 927f8a8b7a1d..bb0d945e4163 100644
--- a/include/linux/dmi.h
+++ b/include/linux/dmi.h
@@ -3,7 +3,6 @@
 #define __DMI_H__
 
 #include <linux/list.h>
-#include <linux/kobject.h>
 #include <linux/mod_devicetable.h>
 
 /* enum dmi_field is in mod_devicetable.h */
diff --git a/include/linux/dpll.h b/include/linux/dpll.h
index 9cb02ad73d51..ac8f8ab00e8f 100644
--- a/include/linux/dpll.h
+++ b/include/linux/dpll.h
@@ -8,7 +8,6 @@
 #define __DPLL_H__
 
 #include <uapi/linux/dpll.h>
-#include <linux/device.h>
 #include <linux/netlink.h>
 
 struct dpll_device;
diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 88d91e087471..a1212432e447 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -2,14 +2,14 @@
 #ifndef _LINUX_ENERGY_MODEL_H
 #define _LINUX_ENERGY_MODEL_H
 #include <linux/cpumask.h>
-#include <linux/device.h>
 #include <linux/jump_label.h>
-#include <linux/kobject.h>
 #include <linux/rcupdate.h>
 #include <linux/sched/cpufreq.h>
 #include <linux/sched/topology.h>
 #include <linux/types.h>
 
+struct device;
+
 /**
  * struct em_perf_state - Performance state of a performance domain
  * @frequency:	The frequency in KHz, for consistency with CPUFreq
diff --git a/include/linux/eventfd.h b/include/linux/eventfd.h
index e32bee4345fb..7199c5039561 100644
--- a/include/linux/eventfd.h
+++ b/include/linux/eventfd.h
@@ -11,8 +11,6 @@
 
 #include <linux/wait.h>
 #include <linux/err.h>
-#include <linux/percpu-defs.h>
-#include <linux/percpu.h>
 #include <linux/sched.h>
 #include <uapi/linux/eventfd.h>
 
diff --git a/include/linux/extcon.h b/include/linux/extcon.h
index 0fd2ca917549..72a2c4028b2d 100644
--- a/include/linux/extcon.h
+++ b/include/linux/extcon.h
@@ -18,11 +18,14 @@
 #ifndef __LINUX_EXTCON_H__
 #define __LINUX_EXTCON_H__
 
-#include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/notifier.h>
 #include <linux/types.h>
 
+struct device;
+struct device_node;
+struct notifier_block;
+
 /*
  * Define the type of supported external connectors
  */
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 2ce2f5c2fca9..b75ee97c2977 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -3,7 +3,6 @@
 #define _LINUX_FB_H
 
 #include <linux/refcount.h>
-#include <linux/kgdb.h>
 #include <uapi/linux/fb.h>
 
 #define FBIO_CURSOR            _IOWR('F', 0x08, struct fb_cursor_user)
@@ -13,7 +12,6 @@
 #include <linux/workqueue.h>
 #include <linux/notifier.h>
 #include <linux/list.h>
-#include <linux/backlight.h>
 #include <linux/slab.h>
 
 #include <asm/fb.h>
@@ -24,6 +22,7 @@ struct device;
 struct file;
 struct videomode;
 struct device_node;
+struct backlight_device;
 
 /* Definitions below are used in the parsed monitor specs */
 #define FB_DPMS_ACTIVE_OFF	1
diff --git a/include/linux/filter.h b/include/linux/filter.h
index fee070b9826e..60c8371badec 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -12,7 +12,6 @@
 #include <linux/skbuff.h>
 #include <linux/linkage.h>
 #include <linux/printk.h>
-#include <linux/workqueue.h>
 #include <linux/sched.h>
 #include <linux/sched/clock.h>
 #include <linux/capability.h>
diff --git a/include/linux/firewire.h b/include/linux/firewire.h
index dd9f2d765e68..c325e3523f93 100644
--- a/include/linux/firewire.h
+++ b/include/linux/firewire.h
@@ -10,7 +10,6 @@
 #include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
-#include <linux/sysfs.h>
 #include <linux/timer.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
diff --git a/include/linux/fprobe.h b/include/linux/fprobe.h
index 3e03758151f4..bd7f85743e8a 100644
--- a/include/linux/fprobe.h
+++ b/include/linux/fprobe.h
@@ -5,7 +5,8 @@
 
 #include <linux/compiler.h>
 #include <linux/ftrace.h>
-#include <linux/rethook.h>
+
+struct rethook;
 
 /**
  * struct fprobe - ftrace based probe.
diff --git a/include/linux/freezer.h b/include/linux/freezer.h
index b303472255be..5eb2a34ad7eb 100644
--- a/include/linux/freezer.h
+++ b/include/linux/freezer.h
@@ -6,7 +6,6 @@
 
 #include <linux/debug_locks.h>
 #include <linux/sched.h>
-#include <linux/wait.h>
 #include <linux/atomic.h>
 #include <linux/jump_label.h>
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 66c476e9f2cd..e403548e13e4 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -12,11 +12,9 @@
 #include <linux/list.h>
 #include <linux/list_lru.h>
 #include <linux/llist.h>
-#include <linux/radix-tree.h>
 #include <linux/xarray.h>
 #include <linux/rbtree.h>
 #include <linux/init.h>
-#include <linux/pid.h>
 #include <linux/bug.h>
 #include <linux/mutex.h>
 #include <linux/rwsem.h>
@@ -26,7 +24,6 @@
 #include <linux/fcntl.h>
 #include <linux/rculist_bl.h>
 #include <linux/atomic.h>
-#include <linux/shrinker.h>
 #include <linux/migrate_mode.h>
 #include <linux/uidgid.h>
 #include <linux/lockdep.h>
@@ -40,7 +37,6 @@
 #include <linux/build_bug.h>
 #include <linux/stddef.h>
 #include <linux/mount.h>
-#include <linux/cred.h>
 #include <linux/mnt_idmapping.h>
 #include <linux/slab.h>
 
@@ -75,6 +71,8 @@ struct fs_context;
 struct fs_parameter_spec;
 struct fileattr;
 struct iomap_ops;
+struct shrinker;
+struct shrink_control;
 
 extern void __init inode_init(void);
 extern void __init inode_init_early(void);
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index e8921871ef9a..c8693c9337a2 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -10,7 +10,6 @@
 #include <linux/trace_recursion.h>
 #include <linux/trace_clock.h>
 #include <linux/jump_label.h>
-#include <linux/kallsyms.h>
 #include <linux/linkage.h>
 #include <linux/bitops.h>
 #include <linux/ptrace.h>
diff --git a/include/linux/greybus/connection.h b/include/linux/greybus/connection.h
index d59b7fc1de3e..d8926e864937 100644
--- a/include/linux/greybus/connection.h
+++ b/include/linux/greybus/connection.h
@@ -13,7 +13,6 @@
 #include <linux/list.h>
 #include <linux/kfifo.h>
 #include <linux/kref.h>
-#include <linux/workqueue.h>
 
 #define GB_CONNECTION_FLAG_CSD		BIT(0)
 #define GB_CONNECTION_FLAG_NO_FLOWCTRL	BIT(1)
diff --git a/include/linux/group_cpus.h b/include/linux/group_cpus.h
index e42807ec61f6..9e6c7c09cafd 100644
--- a/include/linux/group_cpus.h
+++ b/include/linux/group_cpus.h
@@ -6,8 +6,8 @@
 
 #ifndef __LINUX_GROUP_CPUS_H
 #define __LINUX_GROUP_CPUS_H
-#include <linux/kernel.h>
-#include <linux/cpu.h>
+
+struct cpumask;
 
 struct cpumask *group_cpus_evenly(unsigned int numgrps);
 
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 87e2b6933d02..b6ab7b3d63bf 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -17,7 +17,6 @@
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/percpu-defs.h>
-#include <linux/rbtree.h>
 #include <linux/seqlock.h>
 #include <linux/timer.h>
 #include <asm/percpu.h>  // for PER_CPU_BASE_SECTION needed by DECLARE_PER_CPU()
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 2b00faf98017..249c4eb67f38 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -18,7 +18,6 @@
 #include <linux/types.h>
 #include <linux/scatterlist.h>
 #include <linux/list.h>
-#include <linux/timer.h>
 #include <linux/completion.h>
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
diff --git a/include/linux/i2c-smbus.h b/include/linux/i2c-smbus.h
index ced1c6ead52a..7d6a3235ddf4 100644
--- a/include/linux/i2c-smbus.h
+++ b/include/linux/i2c-smbus.h
@@ -9,8 +9,6 @@
 #define _LINUX_I2C_SMBUS_H
 
 #include <linux/i2c.h>
-#include <linux/spinlock.h>
-#include <linux/workqueue.h>
 
 
 /**
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 0ca27dd86956..7fc1e0bb4122 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -15,7 +15,6 @@
 #include <linux/i3c/ccc.h>
 #include <linux/i3c/device.h>
 #include <linux/rwsem.h>
-#include <linux/spinlock.h>
 #include <linux/workqueue.h>
 
 #define I3C_HOT_JOIN_ADDR		0x2
diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
index 418b1307d3f2..70c06c5b4e5d 100644
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -6,7 +6,7 @@
 
 #ifndef _IIO_BUFFER_GENERIC_H_
 #define _IIO_BUFFER_GENERIC_H_
-#include <linux/sysfs.h>
+
 #include <linux/iio/iio.h>
 
 struct iio_buffer;
diff --git a/include/linux/init_task.h b/include/linux/init_task.h
index bccb3f1f6262..0f4ce5661d6d 100644
--- a/include/linux/init_task.h
+++ b/include/linux/init_task.h
@@ -11,8 +11,6 @@
 #include <linux/pid_namespace.h>
 #include <linux/user_namespace.h>
 #include <linux/securebits.h>
-#include <linux/seqlock.h>
-#include <linux/rbtree.h>
 #include <linux/refcount.h>
 #include <linux/sched/autogroup.h>
 #include <net/net_namespace.h>
diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
index 97ac253df62c..1763a7956b87 100644
--- a/include/linux/interconnect.h
+++ b/include/linux/interconnect.h
@@ -7,7 +7,6 @@
 #ifndef __LINUX_INTERCONNECT_H
 #define __LINUX_INTERCONNECT_H
 
-#include <linux/mutex.h>
 #include <linux/types.h>
 
 /* macros for converting to icc units */
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 76121c2bb4f8..6322804d7534 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -10,7 +10,6 @@
 #include <linux/irqnr.h>
 #include <linux/hardirq.h>
 #include <linux/irqflags.h>
-#include <linux/hrtimer.h>
 #include <linux/kref.h>
 #include <linux/workqueue.h>
 #include <linux/jump_label.h>
diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
index 68ed6697fece..d4142d3b7d10 100644
--- a/include/linux/io_uring.h
+++ b/include/linux/io_uring.h
@@ -3,7 +3,6 @@
 #define _LINUX_IO_URING_H
 
 #include <linux/sched.h>
-#include <linux/xarray.h>
 #include <uapi/linux/io_uring.h>
 
 #if defined(CONFIG_IO_URING)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 1ea2a820e1eb..cc25f4832d80 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -12,7 +12,6 @@
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/err.h>
-#include <linux/of.h>
 #include <linux/iova_bitmap.h>
 #include <uapi/linux/iommu.h>
 
@@ -32,6 +31,7 @@
  */
 #define IOMMU_PRIV	(1 << 5)
 
+struct of_phandle_args;
 struct iommu_ops;
 struct iommu_group;
 struct bus_type;
diff --git a/include/linux/ism.h b/include/linux/ism.h
index 5428edd90982..48e4dbaae342 100644
--- a/include/linux/ism.h
+++ b/include/linux/ism.h
@@ -9,8 +9,6 @@
 #ifndef _ISM_H
 #define _ISM_H
 
-#include <linux/workqueue.h>
-
 struct ism_dmb {
 	u64 dmb_tok;
 	u64 rgid;
diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 9935f7ecbfb9..b7747a80e4c7 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -2,7 +2,6 @@
 #ifndef _LINUX_KERNEL_STAT_H
 #define _LINUX_KERNEL_STAT_H
 
-#include <linux/smp.h>
 #include <linux/threads.h>
 #include <linux/percpu.h>
 #include <linux/cpumask.h>
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index a0d7c67d0056..21c617cfa32d 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -9,16 +9,11 @@
 #include <linux/err.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
-#include <linux/idr.h>
 #include <linux/lockdep.h>
 #include <linux/rbtree.h>
-#include <linux/atomic.h>
 #include <linux/bug.h>
 #include <linux/types.h>
 #include <linux/uidgid.h>
-#include <linux/wait.h>
-#include <linux/rwsem.h>
-#include <linux/cache.h>
 
 struct file;
 struct dentry;
diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
index 76e891ee9e37..0ed3f9774c78 100644
--- a/include/linux/kgdb.h
+++ b/include/linux/kgdb.h
@@ -16,7 +16,9 @@
 #include <linux/linkage.h>
 #include <linux/init.h>
 #include <linux/atomic.h>
+#ifdef CONFIG_KGDB_HONOUR_BLOCKLIST
 #include <linux/kprobes.h>
+#endif
 #ifdef CONFIG_HAVE_ARCH_KGDB
 #include <asm/kgdb.h>
 #endif
diff --git a/include/linux/kobj_map.h b/include/linux/kobj_map.h
index c9919f8b2293..5078a587b70c 100644
--- a/include/linux/kobj_map.h
+++ b/include/linux/kobj_map.h
@@ -6,7 +6,9 @@
 #ifndef _KOBJ_MAP_H_
 #define _KOBJ_MAP_H_
 
-#include <linux/mutex.h>
+#include <linux/types.h> // for dev_t
+
+struct mutex;
 
 typedef struct kobject *kobj_probe_t(dev_t, int *, void *);
 struct kobj_map;
diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index db51be6d4815..36ea8c2714bc 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -24,8 +24,6 @@
 #include <linux/stdarg.h> // for va_list
 #include <linux/kref.h>
 #include <linux/kobject_ns.h>
-#include <linux/wait.h>
-#include <linux/atomic.h>
 #include <linux/workqueue.h>
 #include <linux/uidgid.h>
 
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 0ff44d6633e3..b0511d1090ed 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -19,10 +19,8 @@
 #include <linux/linkage.h>
 #include <linux/list.h>
 #include <linux/notifier.h>
-#include <linux/smp.h>
 #include <linux/bug.h>
 #include <linux/percpu.h>
-#include <linux/spinlock.h>
 #include <linux/rcupdate.h>
 #include <linux/mutex.h>
 #include <linux/ftrace.h>
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index bbfefd7e612f..dca36005f1c4 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -20,7 +20,6 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/rcupdate.h>
-#include <linux/ratelimit.h>
 #include <linux/err.h>
 #include <linux/irqflags.h>
 #include <linux/context_tracking.h>
diff --git a/include/linux/lapb.h b/include/linux/lapb.h
index b5333f9413dc..7d4c5073aad4 100644
--- a/include/linux/lapb.h
+++ b/include/linux/lapb.h
@@ -7,7 +7,6 @@
 #define	LAPB_KERNEL_H
 
 #include <linux/skbuff.h>
-#include <linux/timer.h>
 
 struct net_device;
 
diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
index e772aae71843..f8ab7da9cc28 100644
--- a/include/linux/libnvdimm.h
+++ b/include/linux/libnvdimm.h
@@ -11,7 +11,8 @@
 #include <linux/types.h>
 #include <linux/uuid.h>
 #include <linux/spinlock.h>
-#include <linux/bio.h>
+
+struct bio;
 
 struct badrange_entry {
 	u64 start;
diff --git a/include/linux/lru_cache.h b/include/linux/lru_cache.h
index c9afcdd9324c..03d2cda724ea 100644
--- a/include/linux/lru_cache.h
+++ b/include/linux/lru_cache.h
@@ -17,7 +17,6 @@
 #include <linux/list.h>
 #include <linux/slab.h>
 #include <linux/bitops.h>
-#include <linux/string.h> /* for memset */
 #include <linux/seq_file.h>
 
 /*
diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
index 97a8b21eb033..bd1ae08af2aa 100644
--- a/include/linux/lsm_audit.h
+++ b/include/linux/lsm_audit.h
@@ -15,7 +15,6 @@
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/kdev_t.h>
-#include <linux/spinlock.h>
 #include <linux/init.h>
 #include <linux/audit.h>
 #include <linux/in6.h>
diff --git a/include/linux/mISDNif.h b/include/linux/mISDNif.h
index 7aab4a769736..25f1be21aee3 100644
--- a/include/linux/mISDNif.h
+++ b/include/linux/mISDNif.h
@@ -412,7 +412,8 @@ struct mISDN_ctrl_req {
 #include <linux/skbuff.h>
 #include <linux/net.h>
 #include <net/sock.h>
-#include <linux/completion.h>
+
+struct completion;
 
 #define DEBUG_CORE		0x000000ff
 #define DEBUG_CORE_FUNC		0x00000002
diff --git a/include/linux/mailbox_client.h b/include/linux/mailbox_client.h
index 734694912ef7..bfe772c91edc 100644
--- a/include/linux/mailbox_client.h
+++ b/include/linux/mailbox_client.h
@@ -7,9 +7,9 @@
 #ifndef __MAILBOX_CLIENT_H
 #define __MAILBOX_CLIENT_H
 
-#include <linux/of.h>
-#include <linux/device.h>
+#include <linux/types.h>
 
+struct device;
 struct mbox_chan;
 
 /**
diff --git a/include/linux/mailbox_controller.h b/include/linux/mailbox_controller.h
index 6fee33cb52f5..ab7ab835a2f5 100644
--- a/include/linux/mailbox_controller.h
+++ b/include/linux/mailbox_controller.h
@@ -3,12 +3,12 @@
 #ifndef __MAILBOX_CONTROLLER_H
 #define __MAILBOX_CONTROLLER_H
 
-#include <linux/of.h>
 #include <linux/types.h>
 #include <linux/hrtimer.h>
-#include <linux/device.h>
 #include <linux/completion.h>
 
+struct device;
+struct of_phandle_args;
 struct mbox_chan;
 
 /**
diff --git a/include/linux/mdio-mux.h b/include/linux/mdio-mux.h
index a5d58f221939..88d6cf303bbf 100644
--- a/include/linux/mdio-mux.h
+++ b/include/linux/mdio-mux.h
@@ -9,8 +9,10 @@
  */
 #ifndef __LINUX_MDIO_MUX_H
 #define __LINUX_MDIO_MUX_H
-#include <linux/device.h>
-#include <linux/phy.h>
+
+struct device;
+struct device_node;
+struct mii_bus;
 
 /* mdio_mux_init() - Initialize a MDIO mux
  * @dev		The device owning the MDIO mux
diff --git a/include/linux/mdio/mdio-mscc-miim.h b/include/linux/mdio/mdio-mscc-miim.h
index 1ce699740af6..3051d4acdde5 100644
--- a/include/linux/mdio/mdio-mscc-miim.h
+++ b/include/linux/mdio/mdio-mscc-miim.h
@@ -8,9 +8,11 @@
 #ifndef MDIO_MSCC_MIIM_H
 #define MDIO_MSCC_MIIM_H
 
-#include <linux/device.h>
-#include <linux/phy.h>
-#include <linux/regmap.h>
+#include <linux/types.h>
+
+struct device;
+struct mii_bus;
+struct regmap;
 
 int mscc_miim_setup(struct device *device, struct mii_bus **bus,
 		    const char *name, struct regmap *mii_regmap,
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 4e4caeaea404..566566b0ae64 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -22,13 +22,13 @@
 #include <linux/vmstat.h>
 #include <linux/writeback.h>
 #include <linux/page-flags.h>
-#include <linux/shrinker.h>
 
 struct mem_cgroup;
 struct obj_cgroup;
 struct page;
 struct mm_struct;
 struct kmem_cache;
+struct shrinker_info;
 
 /* Cgroup-specific page state, on top of universal node page state */
 enum memcg_stat_item {
diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 931b118336f4..85c9ae0281e4 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -10,7 +10,6 @@
 #include <linux/mmzone.h>
 #include <linux/slab.h>
 #include <linux/rbtree.h>
-#include <linux/spinlock.h>
 #include <linux/nodemask.h>
 #include <linux/pagemap.h>
 #include <uapi/linux/mempolicy.h>
diff --git a/include/linux/mfd/altera-a10sr.h b/include/linux/mfd/altera-a10sr.h
index d616da4b3c4c..06a18c707d3f 100644
--- a/include/linux/mfd/altera-a10sr.h
+++ b/include/linux/mfd/altera-a10sr.h
@@ -10,7 +10,6 @@
 #ifndef __MFD_ALTERA_A10SR_H
 #define __MFD_ALTERA_A10SR_H
 
-#include <linux/completion.h>
 #include <linux/list.h>
 #include <linux/mfd/core.h>
 #include <linux/regmap.h>
diff --git a/include/linux/mfd/max8907.h b/include/linux/mfd/max8907.h
index 4be3c2370e2a..db4de95d3b9e 100644
--- a/include/linux/mfd/max8907.h
+++ b/include/linux/mfd/max8907.h
@@ -10,7 +10,6 @@
 #define __LINUX_MFD_MAX8907_H
 
 #include <linux/mutex.h>
-#include <linux/pm.h>
 
 #define MAX8907_GEN_I2C_ADDR		(0x78 >> 1)
 #define MAX8907_ADC_I2C_ADDR		(0x8e >> 1)
diff --git a/include/linux/mfd/wm831x/core.h b/include/linux/mfd/wm831x/core.h
index 511bcad876f0..1eb4e6a56183 100644
--- a/include/linux/mfd/wm831x/core.h
+++ b/include/linux/mfd/wm831x/core.h
@@ -10,7 +10,6 @@
 #ifndef __MFD_WM831X_CORE_H__
 #define __MFD_WM831X_CORE_H__
 
-#include <linux/completion.h>
 #include <linux/interrupt.h>
 #include <linux/irqdomain.h>
 #include <linux/list.h>
diff --git a/include/linux/mfd/wm8350/supply.h b/include/linux/mfd/wm8350/supply.h
index d7a91e26177c..797a78c53d32 100644
--- a/include/linux/mfd/wm8350/supply.h
+++ b/include/linux/mfd/wm8350/supply.h
@@ -8,7 +8,6 @@
 #ifndef __LINUX_MFD_WM8350_SUPPLY_H_
 #define __LINUX_MFD_WM8350_SUPPLY_H_
 
-#include <linux/mutex.h>
 #include <linux/power_supply.h>
 
 /*
diff --git a/include/linux/mfd/wm8400-private.h b/include/linux/mfd/wm8400-private.h
index bc8c2ca6dc70..ba5cf8e0c3e4 100644
--- a/include/linux/mfd/wm8400-private.h
+++ b/include/linux/mfd/wm8400-private.h
@@ -9,7 +9,6 @@
 #define __LINUX_MFD_WM8400_PRIV_H
 
 #include <linux/mfd/wm8400.h>
-#include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
diff --git a/include/linux/mfd/wm8994/core.h b/include/linux/mfd/wm8994/core.h
index e8b093522ffd..a4780ac19d0f 100644
--- a/include/linux/mfd/wm8994/core.h
+++ b/include/linux/mfd/wm8994/core.h
@@ -10,7 +10,6 @@
 #ifndef __MFD_WM8994_CORE_H__
 #define __MFD_WM8994_CORE_H__
 
-#include <linux/mutex.h>
 #include <linux/interrupt.h>
 #include <linux/regmap.h>
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index a2b9223a5736..60512fa4bb04 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -15,9 +15,7 @@
 #include <linux/mmap_lock.h>
 #include <linux/range.h>
 #include <linux/pfn.h>
-#include <linux/percpu-refcount.h>
 #include <linux/bit_spinlock.h>
-#include <linux/shrinker.h>
 #include <linux/resource.h>
 #include <linux/page_ext.h>
 #include <linux/err.h>
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index a3e6319aaf25..bcb853d8c17a 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -13,7 +13,6 @@
 #include <linux/rbtree.h>
 #include <linux/maple_tree.h>
 #include <linux/rwsem.h>
-#include <linux/completion.h>
 #include <linux/cpumask.h>
 #include <linux/uprobes.h>
 #include <linux/rcupdate.h>
diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index f349e08a9dfe..6aa17677254b 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -3,7 +3,6 @@
 #define _LINUX_MMU_NOTIFIER_H
 
 #include <linux/list.h>
-#include <linux/spinlock.h>
 #include <linux/mm_types.h>
 #include <linux/mmap_lock.h>
 #include <linux/srcu.h>
diff --git a/include/linux/mtd/blktrans.h b/include/linux/mtd/blktrans.h
index 92a7c94777b7..0aa2f072d2a1 100644
--- a/include/linux/mtd/blktrans.h
+++ b/include/linux/mtd/blktrans.h
@@ -9,7 +9,6 @@
 #include <linux/mutex.h>
 #include <linux/kref.h>
 #include <linux/list.h>
-#include <linux/sysfs.h>
 
 struct hd_geometry;
 struct mtd_info;
diff --git a/include/linux/mtd/qinfo.h b/include/linux/mtd/qinfo.h
index 0421f12156b5..63ae23b911b1 100644
--- a/include/linux/mtd/qinfo.h
+++ b/include/linux/mtd/qinfo.h
@@ -3,8 +3,6 @@
 #define __LINUX_MTD_QINFO_H
 
 #include <linux/mtd/map.h>
-#include <linux/wait.h>
-#include <linux/spinlock.h>
 #include <linux/delay.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/flashchip.h>
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 07cefa32eafa..58f5dc3a2f5b 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -32,7 +32,6 @@
 
 #include <linux/percpu.h>
 #include <linux/rculist.h>
-#include <linux/workqueue.h>
 #include <linux/dynamic_queue_limits.h>
 
 #include <net/net_namespace.h>
diff --git a/include/linux/netfilter.h b/include/linux/netfilter.h
index 80900d910992..a75bb2286eee 100644
--- a/include/linux/netfilter.h
+++ b/include/linux/netfilter.h
@@ -8,7 +8,6 @@
 #include <linux/if.h>
 #include <linux/in.h>
 #include <linux/in6.h>
-#include <linux/wait.h>
 #include <linux/list.h>
 #include <linux/static_key.h>
 #include <linux/module.h>
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index f5ce7b101146..a832e18f6347 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -25,7 +25,6 @@
 #include <linux/rbtree.h>
 #include <linux/refcount.h>
 #include <linux/rwsem.h>
-#include <linux/wait.h>
 
 #include <linux/sunrpc/debug.h>
 #include <linux/sunrpc/auth.h>
diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
index 1c315f854ea8..13411baa80c6 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -13,7 +13,6 @@
 
 #include <linux/list.h>
 #include <linux/pagemap.h>
-#include <linux/wait.h>
 #include <linux/sunrpc/auth.h>
 #include <linux/nfs_xdr.h>
 
diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index b61438313a73..0fd787033bb4 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -95,7 +95,10 @@
 #include <linux/minmax.h>
 #include <linux/nodemask_types.h>
 #include <linux/numa.h>
+
+#if defined(CONFIG_NUMA) && (MAX_NUMNODES > 1)
 #include <linux/random.h>
+#endif
 
 extern nodemask_t _unused_nodemask_arg_;
 
diff --git a/include/linux/nsproxy.h b/include/linux/nsproxy.h
index 5601d14e2886..aaf4abab1051 100644
--- a/include/linux/nsproxy.h
+++ b/include/linux/nsproxy.h
@@ -3,7 +3,6 @@
 #define _LINUX_NSPROXY_H
 
 #include <linux/refcount.h>
-#include <linux/spinlock.h>
 #include <linux/sched.h>
 
 struct mnt_namespace;
diff --git a/include/linux/percpu_counter.h b/include/linux/percpu_counter.h
index 3a44dd1e33d2..231e75ec1d83 100644
--- a/include/linux/percpu_counter.h
+++ b/include/linux/percpu_counter.h
@@ -8,7 +8,6 @@
  */
 
 #include <linux/spinlock.h>
-#include <linux/smp.h>
 #include <linux/list.h>
 #include <linux/threads.h>
 #include <linux/percpu.h>
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index b3b34f6670cf..9cde5226e133 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -11,7 +11,6 @@
 #include <linux/interrupt.h>
 #include <linux/perf_event.h>
 #include <linux/platform_device.h>
-#include <linux/sysfs.h>
 #include <asm/cputype.h>
 
 #ifdef CONFIG_ARM_PMU
diff --git a/include/linux/phy.h b/include/linux/phy.h
index fd8dbea9b4d9..34bc9fb37494 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -12,7 +12,6 @@
 #define __PHY_H
 
 #include <linux/compiler.h>
-#include <linux/spinlock.h>
 #include <linux/ethtool.h>
 #include <linux/leds.h>
 #include <linux/linkmode.h>
@@ -21,7 +20,6 @@
 #include <linux/mii.h>
 #include <linux/mii_timestamper.h>
 #include <linux/module.h>
-#include <linux/timer.h>
 #include <linux/workqueue.h>
 #include <linux/mod_devicetable.h>
 #include <linux/u64_stats_sync.h>
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index aa76609ba258..13dd8a749689 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -11,7 +11,6 @@
 #define __DRIVERS_PHY_H
 
 #include <linux/err.h>
-#include <linux/of.h>
 #include <linux/device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
@@ -20,6 +19,7 @@
 #include <linux/phy/phy-lvds.h>
 #include <linux/phy/phy-mipi-dphy.h>
 
+struct of_phandle_args;
 struct phy;
 
 enum phy_mode {
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 6ba411732a0d..90242c81b3cb 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -2,8 +2,6 @@
 #define NETDEV_PCS_H
 
 #include <linux/phy.h>
-#include <linux/spinlock.h>
-#include <linux/workqueue.h>
 
 struct device_node;
 struct ethtool_cmd;
diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
index f9f9931e02d6..c6f8e2e4cd03 100644
--- a/include/linux/pid_namespace.h
+++ b/include/linux/pid_namespace.h
@@ -5,7 +5,6 @@
 #include <linux/sched.h>
 #include <linux/bug.h>
 #include <linux/mm.h>
-#include <linux/workqueue.h>
 #include <linux/threads.h>
 #include <linux/nsproxy.h>
 #include <linux/ns_common.h>
diff --git a/include/linux/pktcdvd.h b/include/linux/pktcdvd.h
index 2f1b952d596a..077a3e870128 100644
--- a/include/linux/pktcdvd.h
+++ b/include/linux/pktcdvd.h
@@ -13,10 +13,7 @@
 #define __PKTCDVD_H
 
 #include <linux/blkdev.h>
-#include <linux/completion.h>
 #include <linux/cdrom.h>
-#include <linux/kobject.h>
-#include <linux/sysfs.h>
 #include <linux/mempool.h>
 #include <uapi/linux/pktcdvd.h>
 
diff --git a/include/linux/platform_data/asoc-ti-mcbsp.h b/include/linux/platform_data/asoc-ti-mcbsp.h
index cc8197760015..115796e3af5f 100644
--- a/include/linux/platform_data/asoc-ti-mcbsp.h
+++ b/include/linux/platform_data/asoc-ti-mcbsp.h
@@ -8,7 +8,6 @@
 #ifndef __ASOC_TI_MCBSP_H
 #define __ASOC_TI_MCBSP_H
 
-#include <linux/spinlock.h>
 #include <linux/clk.h>
 
 /* Platform specific configuration */
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 41a0e0f7afbc..43251723b210 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -14,7 +14,6 @@
 #include <linux/workqueue.h>
 #include <linux/spinlock.h>
 #include <linux/wait.h>
-#include <linux/timer.h>
 #include <linux/hrtimer.h>
 #include <linux/completion.h>
 
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index fb91770ba4ba..bb6003d78d19 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -13,7 +13,6 @@
 #include <linux/mutex.h>
 #include <linux/pm.h>
 #include <linux/err.h>
-#include <linux/of.h>
 #include <linux/notifier.h>
 #include <linux/spinlock.h>
 #include <linux/cpumask.h>
@@ -348,6 +347,7 @@ static inline void dev_pm_genpd_resume(struct device *dev) {}
 
 /* OF PM domain providers */
 struct of_device_id;
+struct of_phandle_args;
 
 typedef struct generic_pm_domain *(*genpd_xlate_t)(struct of_phandle_args *args,
 						   void *data);
diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index dc7b738de299..c88ceca7cb6e 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -4,7 +4,6 @@
 
 #include <linux/alarmtimer.h>
 #include <linux/list.h>
-#include <linux/mutex.h>
 #include <linux/posix-timers_types.h>
 #include <linux/spinlock.h>
 #include <linux/timerqueue.h>
diff --git a/include/linux/pps_kernel.h b/include/linux/pps_kernel.h
index 78c8ac4951b5..10e210ff86d0 100644
--- a/include/linux/pps_kernel.h
+++ b/include/linux/pps_kernel.h
@@ -10,9 +10,10 @@
 
 #include <linux/pps.h>
 #include <linux/cdev.h>
-#include <linux/device.h>
 #include <linux/time.h>
 
+struct device;
+
 /*
  * Global defines
  */
diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index f1fd3a8044e0..7b1c9167f756 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -5,7 +5,6 @@
 #include <linux/kthread.h>
 #include <linux/seqlock.h>
 #include <linux/types.h>
-#include <linux/kref.h>
 #include <linux/wait.h>
 
 #ifdef CONFIG_PSI
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 111db0b6a0a2..4eef97d74366 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -4,9 +4,9 @@
 
 #include <linux/err.h>
 #include <linux/math.h> // for DIV_ROUND_CLOSEST_ULL()
-#include <linux/mutex.h>
-#include <linux/of.h>
 
+struct of_phandle_args;
+struct fwnode_handle;
 struct pwm_chip;
 
 /**
diff --git a/include/linux/quota.h b/include/linux/quota.h
index 07071e64abf3..72a2efc77fb5 100644
--- a/include/linux/quota.h
+++ b/include/linux/quota.h
@@ -36,7 +36,6 @@
 #include <linux/mutex.h>
 #include <linux/rwsem.h>
 #include <linux/spinlock.h>
-#include <linux/wait.h>
 #include <linux/percpu_counter.h>
 
 #include <linux/dqblk_xfs.h>
diff --git a/include/linux/random.h b/include/linux/random.h
index b0a940af4fff..70e5250f3bc4 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -5,7 +5,6 @@
 
 #include <linux/bug.h>
 #include <linux/kernel.h>
-#include <linux/list.h>
 
 #include <uapi/linux/random.h>
 
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index b743241cfb7c..8f3390b7c4dc 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -11,7 +11,6 @@
  */
 
 #include <linux/list.h>
-#include <linux/rbtree.h>
 #include <linux/ktime.h>
 #include <linux/delay.h>
 #include <linux/err.h>
diff --git a/include/linux/relay.h b/include/linux/relay.h
index 72b876dd5cb8..50ac01f8d6d1 100644
--- a/include/linux/relay.h
+++ b/include/linux/relay.h
@@ -13,7 +13,6 @@
 
 #include <linux/types.h>
 #include <linux/sched.h>
-#include <linux/timer.h>
 #include <linux/wait.h>
 #include <linux/list.h>
 #include <linux/irq_work.h>
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index b4795698d8c2..a924a7d5b44a 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -39,7 +39,6 @@
 #include <linux/mutex.h>
 #include <linux/virtio.h>
 #include <linux/cdev.h>
-#include <linux/completion.h>
 #include <linux/idr.h>
 #include <linux/of.h>
 
diff --git a/include/linux/rfkill.h b/include/linux/rfkill.h
index 373003ace639..0e8d11410f9f 100644
--- a/include/linux/rfkill.h
+++ b/include/linux/rfkill.h
@@ -31,8 +31,6 @@ enum rfkill_user_states {
 #undef RFKILL_STATE_HARD_BLOCKED
 
 #include <linux/kernel.h>
-#include <linux/list.h>
-#include <linux/mutex.h>
 #include <linux/leds.h>
 #include <linux/err.h>
 
diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index fa802db216f9..a4553db80912 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -3,7 +3,6 @@
 #define _LINUX_RING_BUFFER_H
 
 #include <linux/mm.h>
-#include <linux/seq_file.h>
 #include <linux/poll.h>
 
 struct trace_buffer;
diff --git a/include/linux/rtc/ds1685.h b/include/linux/rtc/ds1685.h
index 5a41c3bbcbe3..1bda17f878bb 100644
--- a/include/linux/rtc/ds1685.h
+++ b/include/linux/rtc/ds1685.h
@@ -23,7 +23,6 @@
 
 #include <linux/rtc.h>
 #include <linux/platform_device.h>
-#include <linux/workqueue.h>
 
 /**
  * struct ds1685_priv - DS1685 private data structure.
diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index 21780608cf47..d1c42219429c 100644
--- a/include/linux/rtnetlink.h
+++ b/include/linux/rtnetlink.h
@@ -2,8 +2,6 @@
 #ifndef __LINUX_RTNETLINK_H
 #define __LINUX_RTNETLINK_H
 
-
-#include <linux/mutex.h>
 #include <linux/netdevice.h>
 #include <linux/wait.h>
 #include <linux/refcount.h>
diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index d662cf136021..d7d3fba174f8 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -17,7 +17,6 @@
 #include <linux/minmax.h>
 #include <linux/percpu.h>
 #include <linux/slab.h>
-#include <linux/smp.h>
 #include <linux/types.h>
 #include <linux/wait.h>
 
diff --git a/include/linux/sched/clock.h b/include/linux/sched/clock.h
index 196f0ca351a2..bb5aaf98bf87 100644
--- a/include/linux/sched/clock.h
+++ b/include/linux/sched/clock.h
@@ -2,7 +2,7 @@
 #ifndef _LINUX_SCHED_CLOCK_H
 #define _LINUX_SCHED_CLOCK_H
 
-#include <linux/smp.h>
+#include <linux/types.h>
 
 /*
  * Do not use outside of architecture code which knows its limitations.
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 5ba7828f3d3e..03ca838ed3ec 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -8,13 +8,14 @@
 #include <linux/sched/jobctl.h>
 #include <linux/sched/task.h>
 #include <linux/completion.h>
-#include <linux/cred.h>
 #include <linux/refcount.h>
 #include <linux/pid.h>
 #include <linux/posix-timers.h>
 #include <linux/mm_types.h>
 #include <asm/ptrace.h>
 
+struct cred;
+
 /*
  * Types defining task->signal and task->sighand and APIs using them:
  */
diff --git a/include/linux/security.h b/include/linux/security.h
index 15804af54f37..710f525cfb82 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -32,7 +32,7 @@
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/sockptr.h>
-#include <linux/bpf.h>
+#include <uapi/linux/bpf.h>
 #include <uapi/linux/lsm.h>
 
 struct linux_binprm;
diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
index 234bcdb1fba4..96d595cd7659 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -8,7 +8,6 @@
 #include <linux/bug.h>
 #include <linux/mutex.h>
 #include <linux/cpumask.h>
-#include <linux/nodemask.h>
 #include <linux/fs.h>
 #include <linux/cred.h>
 
diff --git a/include/linux/sh_clk.h b/include/linux/sh_clk.h
index 7bed5be886c6..3b2d8de6e7d8 100644
--- a/include/linux/sh_clk.h
+++ b/include/linux/sh_clk.h
@@ -3,7 +3,6 @@
 #define __SH_CLOCK_H
 
 #include <linux/list.h>
-#include <linux/seq_file.h>
 #include <linux/cpufreq.h>
 #include <linux/types.h>
 #include <linux/kref.h>
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 49ea49ac627e..4536ecda102d 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -17,7 +17,6 @@
 #include <linux/log2.h>
 #include <linux/overflow.h>
 #include <linux/types.h>
-#include <linux/workqueue.h>
 #include <linux/percpu-refcount.h>
 #include <linux/cleanup.h>
 #include <linux/hash.h>
diff --git a/include/linux/slimbus.h b/include/linux/slimbus.h
index 12c9719b2a55..e29958e5e96d 100644
--- a/include/linux/slimbus.h
+++ b/include/linux/slimbus.h
@@ -7,9 +7,10 @@
 #define _LINUX_SLIMBUS_H
 #include <linux/device.h>
 #include <linux/module.h>
-#include <linux/completion.h>
 #include <linux/mod_devicetable.h>
 
+struct completion;
+
 extern struct bus_type slimbus_bus;
 
 /**
diff --git a/include/linux/soc/apple/rtkit.h b/include/linux/soc/apple/rtkit.h
index 8c9ca857ccf6..64a4059249f6 100644
--- a/include/linux/soc/apple/rtkit.h
+++ b/include/linux/soc/apple/rtkit.h
@@ -10,10 +10,11 @@
 #ifndef _LINUX_APPLE_RTKIT_H_
 #define _LINUX_APPLE_RTKIT_H_
 
-#include <linux/device.h>
 #include <linux/types.h>
 #include <linux/mailbox_client.h>
 
+struct device;
+
 /*
  * Struct to represent implementation-specific RTKit operations.
  *
diff --git a/include/linux/soc/apple/sart.h b/include/linux/soc/apple/sart.h
index 2249bf6cde09..f5d5dd678471 100644
--- a/include/linux/soc/apple/sart.h
+++ b/include/linux/soc/apple/sart.h
@@ -12,10 +12,10 @@
 #ifndef _LINUX_SOC_APPLE_SART_H_
 #define _LINUX_SOC_APPLE_SART_H_
 
-#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/types.h>
 
+struct device;
 struct apple_sart;
 
 /*
diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
index 649955d2cf5c..64411659966a 100644
--- a/include/linux/soc/mediatek/mtk-cmdq.h
+++ b/include/linux/soc/mediatek/mtk-cmdq.h
@@ -9,7 +9,6 @@
 
 #include <linux/mailbox_client.h>
 #include <linux/mailbox/mtk-cmdq-mailbox.h>
-#include <linux/timer.h>
 
 #define CMDQ_ADDR_HIGH(addr)	((u32)(((addr) >> 16) & GENMASK(31, 0)))
 #define CMDQ_ADDR_LOW(addr)	((u16)(addr) | BIT(1))
diff --git a/include/linux/soc/qcom/qcom_aoss.h b/include/linux/soc/qcom/qcom_aoss.h
index 7361ca028752..21d345a7e9c5 100644
--- a/include/linux/soc/qcom/qcom_aoss.h
+++ b/include/linux/soc/qcom/qcom_aoss.h
@@ -7,8 +7,8 @@
 #define __QCOM_AOSS_H__
 
 #include <linux/err.h>
-#include <linux/device.h>
 
+struct device;
 struct qmp;
 
 #if IS_ENABLED(CONFIG_QCOM_AOSS_QMP)
diff --git a/include/linux/spi/spi_bitbang.h b/include/linux/spi/spi_bitbang.h
index dbebdf1f2cdd..b9b2623faa22 100644
--- a/include/linux/spi/spi_bitbang.h
+++ b/include/linux/spi/spi_bitbang.h
@@ -4,7 +4,6 @@
 
 #include <linux/mutex.h>
 #include <linux/types.h>
-#include <linux/workqueue.h>
 
 struct spi_bitbang {
 	struct mutex		lock;
diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 236610e4a8fa..b86233c200e1 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -16,9 +16,7 @@
 #ifndef _LINUX_SRCU_H
 #define _LINUX_SRCU_H
 
-#include <linux/mutex.h>
 #include <linux/rcupdate.h>
-#include <linux/workqueue.h>
 #include <linux/rcu_segcblist.h>
 
 struct srcu_struct;
diff --git a/include/linux/stm.h b/include/linux/stm.h
index 3b22689512be..c61f3841712c 100644
--- a/include/linux/stm.h
+++ b/include/linux/stm.h
@@ -7,7 +7,9 @@
 #ifndef _STM_H_
 #define _STM_H_
 
-#include <linux/device.h>
+#include <linux/types.h>
+
+struct device;
 
 /**
  * enum stp_packet_type - STP packets that an STM driver sends
diff --git a/include/linux/sunrpc/auth.h b/include/linux/sunrpc/auth.h
index 61e58327b1aa..45be9d7e5976 100644
--- a/include/linux/sunrpc/auth.h
+++ b/include/linux/sunrpc/auth.h
@@ -16,7 +16,6 @@
 
 #include <linux/atomic.h>
 #include <linux/rcupdate.h>
-#include <linux/uidgid.h>
 #include <linux/utsname.h>
 
 /*
diff --git a/include/linux/sunrpc/metrics.h b/include/linux/sunrpc/metrics.h
index 0ee3f7052846..6bfed383ed63 100644
--- a/include/linux/sunrpc/metrics.h
+++ b/include/linux/sunrpc/metrics.h
@@ -26,12 +26,13 @@
 #ifndef _LINUX_SUNRPC_METRICS_H
 #define _LINUX_SUNRPC_METRICS_H
 
-#include <linux/seq_file.h>
 #include <linux/ktime.h>
 #include <linux/spinlock.h>
 
 #define RPC_IOSTATS_VERS	"1.1"
 
+struct seq_file;
+
 struct rpc_iostats {
 	spinlock_t		om_lock;
 
diff --git a/include/linux/sunrpc/rpc_pipe_fs.h b/include/linux/sunrpc/rpc_pipe_fs.h
index 5438de45300d..c26733d8fde7 100644
--- a/include/linux/sunrpc/rpc_pipe_fs.h
+++ b/include/linux/sunrpc/rpc_pipe_fs.h
@@ -5,7 +5,6 @@
 #include <linux/list.h>
 #include <linux/spinlock_types.h>
 #include <linux/wait.h>
-#include <linux/workqueue.h>
 
 struct rpc_pipe_dir_head {
 	struct list_head pdh_entries;
diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
index 2d61987b3545..b568e439c6cf 100644
--- a/include/linux/sunrpc/sched.h
+++ b/include/linux/sunrpc/sched.h
@@ -10,7 +10,6 @@
 #ifndef _LINUX_SUNRPC_SCHED_H_
 #define _LINUX_SUNRPC_SCHED_H_
 
-#include <linux/timer.h>
 #include <linux/ktime.h>
 #include <linux/sunrpc/types.h>
 #include <linux/spinlock.h>
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 23617da0e565..4cb592e892bc 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -18,7 +18,6 @@
 #include <linux/sunrpc/auth.h>
 #include <linux/sunrpc/svcauth.h>
 #include <linux/lwq.h>
-#include <linux/wait.h>
 #include <linux/mm.h>
 #include <linux/pagevec.h>
 
diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 24cd199dd6f3..52b6059041db 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -49,7 +49,6 @@
 #include <linux/sunrpc/rpc_rdma_cid.h>
 #include <linux/sunrpc/svc_rdma_pcl.h>
 
-#include <linux/percpu_counter.h>
 #include <rdma/ib_verbs.h>
 #include <rdma/rdma_cm.h>
 
diff --git a/include/linux/sunrpc/svcauth.h b/include/linux/sunrpc/svcauth.h
index 61c455f1e1f5..59e1d15827ec 100644
--- a/include/linux/sunrpc/svcauth.h
+++ b/include/linux/sunrpc/svcauth.h
@@ -16,7 +16,6 @@
 #include <linux/sunrpc/gss_api.h>
 #include <linux/hash.h>
 #include <linux/stringhash.h>
-#include <linux/cred.h>
 
 struct svc_cred {
 	kuid_t			cr_uid;
diff --git a/include/linux/swait.h b/include/linux/swait.h
index d324419482a0..1d630ebf561d 100644
--- a/include/linux/swait.h
+++ b/include/linux/swait.h
@@ -5,7 +5,7 @@
 #include <linux/list.h>
 #include <linux/stddef.h>
 #include <linux/spinlock.h>
-#include <linux/wait.h>
+#include <linux/wait.h> // for ___wait_is_interruptible()
 #include <asm/current.h>
 
 /*
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 48b700ba1d18..1fe14636d51e 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -2,7 +2,6 @@
 #ifndef _LINUX_SWAPOPS_H
 #define _LINUX_SWAPOPS_H
 
-#include <linux/radix-tree.h>
 #include <linux/bug.h>
 #include <linux/mm_types.h>
 
diff --git a/include/linux/sync_file.h b/include/linux/sync_file.h
index 790ca021203a..2aa71bff4d4c 100644
--- a/include/linux/sync_file.h
+++ b/include/linux/sync_file.h
@@ -16,7 +16,6 @@
 #include <linux/types.h>
 #include <linux/ktime.h>
 #include <linux/list.h>
-#include <linux/spinlock.h>
 #include <linux/dma-fence.h>
 #include <linux/dma-fence-array.h>
 
diff --git a/include/linux/sys_soc.h b/include/linux/sys_soc.h
index d9b3cf0f410c..09d4b53af192 100644
--- a/include/linux/sys_soc.h
+++ b/include/linux/sys_soc.h
@@ -6,7 +6,8 @@
 #ifndef __SOC_BUS_H
 #define __SOC_BUS_H
 
-#include <linux/device.h>
+struct device;
+struct soc_device;
 
 struct soc_device_attribute {
 	const char *machine;
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 77eb9b0e7685..a7366e5ee88f 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -84,7 +84,6 @@ struct mnt_id_req;
 #include <linux/signal.h>
 #include <linux/list.h>
 #include <linux/bug.h>
-#include <linux/sem.h>
 #include <asm/siginfo.h>
 #include <linux/unistd.h>
 #include <linux/quota.h>
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 0a4ff6d54943..b280468411ab 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -16,17 +16,12 @@
 #include <linux/kernfs.h>
 #include <linux/kernel.h> // for VERIFY_OCTAL_PERMISSIONS()
 #include <linux/compiler.h>
-#include <linux/errno.h>
 #include <linux/list.h>
 #include <linux/lockdep.h>
-#include <linux/kobject_ns.h>
-#include <linux/stat.h>
-#include <linux/atomic.h>
 
 struct kobject;
 struct module;
 struct bin_attribute;
-enum kobj_ns_type;
 
 struct attribute {
 	const char		*name;
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 65d8f92a9a0d..32c35685b693 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -10,7 +10,6 @@
 #ifndef __THERMAL_H__
 #define __THERMAL_H__
 
-#include <linux/of.h>
 #include <linux/idr.h>
 #include <linux/device.h>
 #include <linux/sysfs.h>
diff --git a/include/linux/torture.h b/include/linux/torture.h
index 1541454da03e..f7a91dc7b063 100644
--- a/include/linux/torture.h
+++ b/include/linux/torture.h
@@ -12,12 +12,8 @@
 
 #include <linux/types.h>
 #include <linux/cache.h>
-#include <linux/spinlock.h>
 #include <linux/threads.h>
 #include <linux/cpumask.h>
-#include <linux/seqlock.h>
-#include <linux/lockdep.h>
-#include <linux/completion.h>
 #include <linux/debugobjects.h>
 #include <linux/bug.h>
 #include <linux/compiler.h>
diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
index 7a5fe17b6bf9..bd5cc895f537 100644
--- a/include/linux/tracefs.h
+++ b/include/linux/tracefs.h
@@ -13,7 +13,6 @@
 #define _TRACEFS_H_
 
 #include <linux/fs.h>
-#include <linux/seq_file.h>
 
 #include <linux/types.h>
 
diff --git a/include/linux/transport_class.h b/include/linux/transport_class.h
index 2efc271a96fa..b7d25a62b4d8 100644
--- a/include/linux/transport_class.h
+++ b/include/linux/transport_class.h
@@ -8,10 +8,11 @@
 #ifndef _TRANSPORT_CLASS_H_
 #define _TRANSPORT_CLASS_H_
 
-#include <linux/device.h>
+#include <linux/device/class.h>
 #include <linux/bug.h>
 #include <linux/attribute_container.h>
 
+struct device;
 struct transport_container;
 
 struct transport_class {
diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
index 7372124fbf90..a9fd888f4cd3 100644
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -11,6 +11,7 @@
 #include <linux/termios.h>
 #include <linux/seq_file.h>
 
+struct attribute_group;
 struct tty_struct;
 struct tty_driver;
 struct serial_icounter_struct;
diff --git a/include/linux/tty_ldisc.h b/include/linux/tty_ldisc.h
index af01e89074b2..3a6f70f2f41e 100644
--- a/include/linux/tty_ldisc.h
+++ b/include/linux/tty_ldisc.h
@@ -5,11 +5,9 @@
 struct tty_struct;
 
 #include <linux/fs.h>
-#include <linux/wait.h>
 #include <linux/atomic.h>
 #include <linux/list.h>
 #include <linux/lockdep.h>
-#include <linux/seq_file.h>
 
 /*
  * the semaphore definition
diff --git a/include/linux/u64_stats_sync.h b/include/linux/u64_stats_sync.h
index cf4b090e799a..477055938ab7 100644
--- a/include/linux/u64_stats_sync.h
+++ b/include/linux/u64_stats_sync.h
@@ -61,7 +61,10 @@
  */
 
 #include <asm/bitsperlong.h>
+
+#if BITS_PER_LONG == 32
 #include <linux/seqlock.h>
+#endif
 
 struct u64_stats_sync {
 #if BITS_PER_LONG == 32
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index f46e0ca0169c..a76155cf8ceb 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -12,9 +12,7 @@
  */
 
 #include <linux/errno.h>
-#include <linux/rbtree.h>
 #include <linux/types.h>
-#include <linux/wait.h>
 
 struct vm_area_struct;
 struct mm_struct;
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index cd77fc6095a1..65f3a953d2c2 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -8,7 +8,6 @@
 
 #ifdef __KERNEL__
 
-#include <linux/rwsem.h>
 #include <linux/interrupt.h>
 #include <linux/idr.h>
 
diff --git a/include/linux/usb/role.h b/include/linux/usb/role.h
index b5deafd91f67..1fd9878daa01 100644
--- a/include/linux/usb/role.h
+++ b/include/linux/usb/role.h
@@ -3,8 +3,11 @@
 #ifndef __LINUX_USB_ROLE_H
 #define __LINUX_USB_ROLE_H
 
-#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/types.h>
 
+struct device;
+struct fwnode_handle;
 struct usb_role_switch;
 
 enum usb_role {
diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 6030a8235617..a9cee5a7b8af 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -2,7 +2,6 @@
 #ifndef _LINUX_USER_NAMESPACE_H
 #define _LINUX_USER_NAMESPACE_H
 
-#include <linux/kref.h>
 #include <linux/nsproxy.h>
 #include <linux/ns_common.h>
 #include <linux/sched.h>
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 85e84b92751b..a3075d00675a 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -13,7 +13,6 @@
 #include <linux/vfio.h>
 #include <linux/irqbypass.h>
 #include <linux/types.h>
-#include <linux/uuid.h>
 #include <linux/notifier.h>
 
 #ifndef VFIO_PCI_CORE_H
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 91810b4e9510..77054ddd7eac 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -2,7 +2,6 @@
 #ifndef _LINUX_VMALLOC_H
 #define _LINUX_VMALLOC_H
 
-#include <linux/spinlock.h>
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/llist.h>
diff --git a/include/linux/vt_kern.h b/include/linux/vt_kern.h
index d008c3d0a9bb..28cd6b859fea 100644
--- a/include/linux/vt_kern.h
+++ b/include/linux/vt_kern.h
@@ -10,7 +10,6 @@
 #include <linux/vt.h>
 #include <linux/kd.h>
 #include <linux/tty.h>
-#include <linux/mutex.h>
 #include <linux/console_struct.h>
 #include <linux/mm.h>
 #include <linux/consolemap.h>
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 9a7a3d2b543f..9f5d9ac072c3 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -6,7 +6,6 @@
 #define WRITEBACK_H
 
 #include <linux/sched.h>
-#include <linux/workqueue.h>
 #include <linux/fs.h>
 #include <linux/flex_proportions.h>
 #include <linux/backing-dev-defs.h>
diff --git a/include/media/cec.h b/include/media/cec.h
index 10c9cf6058b7..4c9daa53ae34 100644
--- a/include/media/cec.h
+++ b/include/media/cec.h
@@ -14,7 +14,6 @@
 #include <linux/device.h>
 #include <linux/cdev.h>
 #include <linux/kthread.h>
-#include <linux/timer.h>
 #include <linux/cec-funcs.h>
 #include <media/rc-core.h>
 
diff --git a/include/media/dmxdev.h b/include/media/dmxdev.h
index 63219a699370..4f48ed5ceda7 100644
--- a/include/media/dmxdev.h
+++ b/include/media/dmxdev.h
@@ -23,7 +23,6 @@
 #include <linux/spinlock.h>
 #include <linux/time.h>
 #include <linux/timer.h>
-#include <linux/wait.h>
 #include <linux/fs.h>
 #include <linux/string.h>
 #include <linux/mutex.h>
diff --git a/include/media/dvb_demux.h b/include/media/dvb_demux.h
index 3b6aeca7a49e..8f90330274d5 100644
--- a/include/media/dvb_demux.h
+++ b/include/media/dvb_demux.h
@@ -20,7 +20,6 @@
 #define _DVB_DEMUX_H_
 
 #include <linux/time.h>
-#include <linux/timer.h>
 #include <linux/spinlock.h>
 #include <linux/mutex.h>
 
diff --git a/include/media/rc-core.h b/include/media/rc-core.h
index 803349599c27..eabb19016fec 100644
--- a/include/media/rc-core.h
+++ b/include/media/rc-core.h
@@ -12,7 +12,6 @@
 #include <linux/cdev.h>
 #include <linux/kfifo.h>
 #include <linux/time.h>
-#include <linux/timer.h>
 #include <media/rc-map.h>
 
 /**
diff --git a/include/media/v4l2-async.h b/include/media/v4l2-async.h
index 9bd326d31181..95abe99a26b8 100644
--- a/include/media/v4l2-async.h
+++ b/include/media/v4l2-async.h
@@ -9,7 +9,6 @@
 #define V4L2_ASYNC_H
 
 #include <linux/list.h>
-#include <linux/mutex.h>
 
 struct dentry;
 struct device;
diff --git a/include/media/v4l2-event.h b/include/media/v4l2-event.h
index 3a0e2588361c..2d08ef0752df 100644
--- a/include/media/v4l2-event.h
+++ b/include/media/v4l2-event.h
@@ -14,7 +14,6 @@
 
 #include <linux/types.h>
 #include <linux/videodev2.h>
-#include <linux/wait.h>
 
 struct v4l2_fh;
 struct v4l2_subdev;
diff --git a/include/media/v4l2-ioctl.h b/include/media/v4l2-ioctl.h
index edb733f21604..d95461c2102d 100644
--- a/include/media/v4l2-ioctl.h
+++ b/include/media/v4l2-ioctl.h
@@ -12,7 +12,6 @@
 
 #include <linux/poll.h>
 #include <linux/fs.h>
-#include <linux/mutex.h>
 #include <linux/sched/signal.h>
 #include <linux/compiler.h> /* need __user */
 #include <linux/videodev2.h>
diff --git a/include/net/ax25.h b/include/net/ax25.h
index 0d939e5aee4e..8c5d4698cf29 100644
--- a/include/net/ax25.h
+++ b/include/net/ax25.h
@@ -15,7 +15,6 @@
 #include <linux/refcount.h>
 #include <net/neighbour.h>
 #include <net/sock.h>
-#include <linux/seq_file.h>
 
 #define	AX25_T1CLAMPLO  		1
 #define	AX25_T1CLAMPHI 			(30 * HZ)
diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 7ffa8c192c3f..b8f8c8fc52d3 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -28,7 +28,8 @@
 
 #include <linux/poll.h>
 #include <net/sock.h>
-#include <linux/seq_file.h>
+
+struct seq_file;
 
 #define BT_SUBSYS_VERSION	2
 #define BT_SUBSYS_REVISION	22
diff --git a/include/net/bonding.h b/include/net/bonding.h
index b61fb1aa3a56..49a940bc11e9 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -13,7 +13,6 @@
 #ifndef _NET_BONDING_H
 #define _NET_BONDING_H
 
-#include <linux/timer.h>
 #include <linux/proc_fs.h>
 #include <linux/if_bonding.h>
 #include <linux/cpumask.h>
diff --git a/include/net/bpf_sk_storage.h b/include/net/bpf_sk_storage.h
index 2926f1f00d65..0e49c3602953 100644
--- a/include/net/bpf_sk_storage.h
+++ b/include/net/bpf_sk_storage.h
@@ -3,11 +3,7 @@
 #ifndef _BPF_SK_STORAGE_H
 #define _BPF_SK_STORAGE_H
 
-#include <linux/rculist.h>
-#include <linux/list.h>
-#include <linux/hash.h>
 #include <linux/types.h>
-#include <linux/spinlock.h>
 #include <linux/bpf.h>
 #include <net/sock.h>
 #include <uapi/linux/sock_diag.h>
diff --git a/include/net/caif/cfcnfg.h b/include/net/caif/cfcnfg.h
index 8819ff4db35a..730aa6c0ebef 100644
--- a/include/net/caif/cfcnfg.h
+++ b/include/net/caif/cfcnfg.h
@@ -6,7 +6,6 @@
 
 #ifndef CFCNFG_H_
 #define CFCNFG_H_
-#include <linux/spinlock.h>
 #include <linux/netdevice.h>
 #include <net/caif/caif_layer.h>
 #include <net/caif/cfctrl.h>
diff --git a/include/net/caif/cfsrvl.h b/include/net/caif/cfsrvl.h
index 5ee7b322e18b..6bec9852c6fe 100644
--- a/include/net/caif/cfsrvl.h
+++ b/include/net/caif/cfsrvl.h
@@ -9,7 +9,6 @@
 #include <linux/list.h>
 #include <linux/stddef.h>
 #include <linux/types.h>
-#include <linux/kref.h>
 #include <linux/rculist.h>
 
 struct cfsrvl {
diff --git a/include/net/devlink.h b/include/net/devlink.h
index 9ac394bdfbe4..7905d55ed0d4 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -7,7 +7,6 @@
 #ifndef _NET_DEVLINK_H_
 #define _NET_DEVLINK_H_
 
-#include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/gfp.h>
 #include <linux/list.h>
@@ -18,9 +17,9 @@
 #include <net/net_namespace.h>
 #include <net/flow_offload.h>
 #include <uapi/linux/devlink.h>
-#include <linux/xarray.h>
 #include <linux/firmware.h>
 
+struct device;
 struct devlink;
 struct devlink_linecard;
 
diff --git a/include/net/dsa.h b/include/net/dsa.h
index 7c0da9effe4e..1f1fb28c6af0 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -11,8 +11,6 @@
 #include <linux/if_ether.h>
 #include <linux/list.h>
 #include <linux/notifier.h>
-#include <linux/timer.h>
-#include <linux/workqueue.h>
 #include <linux/of.h>
 #include <linux/ethtool.h>
 #include <linux/net_tstamp.h>
diff --git a/include/net/dsa_stubs.h b/include/net/dsa_stubs.h
index 6f384897f287..1490c36ea9c4 100644
--- a/include/net/dsa_stubs.h
+++ b/include/net/dsa_stubs.h
@@ -3,7 +3,6 @@
  * include/net/dsa_stubs.h - Stubs for the Distributed Switch Architecture framework
  */
 
-#include <linux/mutex.h>
 #include <linux/netdevice.h>
 #include <linux/net_tstamp.h>
 #include <net/dsa.h>
diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index 7f1b38458743..5c69fcd3e80e 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -19,7 +19,6 @@
 #include <linux/socket.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
-#include <linux/wait.h>
 
 #include <net/inet_connection_sock.h>
 #include <net/inet_sock.h>
diff --git a/include/net/inet_timewait_sock.h b/include/net/inet_timewait_sock.h
index f28da08a37b4..b7f313b277ea 100644
--- a/include/net/inet_timewait_sock.h
+++ b/include/net/inet_timewait_sock.h
@@ -14,7 +14,6 @@
 #include <linux/list.h>
 #include <linux/timer.h>
 #include <linux/types.h>
-#include <linux/workqueue.h>
 
 #include <net/inet_sock.h>
 #include <net/sock.h>
diff --git a/include/net/inetpeer.h b/include/net/inetpeer.h
index 74ff688568a0..de3536f280cc 100644
--- a/include/net/inetpeer.h
+++ b/include/net/inetpeer.h
@@ -11,7 +11,6 @@
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/jiffies.h>
-#include <linux/spinlock.h>
 #include <linux/rtnetlink.h>
 #include <net/ipv6.h>
 #include <linux/atomic.h>
diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
index d4667b7797e3..0d80e9a10019 100644
--- a/include/net/ip_fib.h
+++ b/include/net/ip_fib.h
@@ -13,7 +13,6 @@
 #define _NET_IP_FIB_H
 
 #include <net/flow.h>
-#include <linux/seq_file.h>
 #include <linux/rcupdate.h>
 #include <net/fib_notifier.h>
 #include <net/fib_rules.h>
diff --git a/include/net/lib80211.h b/include/net/lib80211.h
index 8b47d3a51cf8..973049cb0453 100644
--- a/include/net/lib80211.h
+++ b/include/net/lib80211.h
@@ -31,7 +31,8 @@
 #include <linux/skbuff.h>
 #include <linux/ieee80211.h>
 #include <linux/timer.h>
-#include <linux/seq_file.h>
+
+struct seq_file;
 
 #define NUM_WEP_KEYS	4
 
diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 0d28172193fa..1197433b3315 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -22,7 +22,6 @@
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
 #include <linux/rcupdate.h>
-#include <linux/seq_file.h>
 #include <linux/bitmap.h>
 
 #include <linux/err.h>
@@ -30,6 +29,8 @@
 #include <linux/workqueue.h>
 #include <net/rtnetlink.h>
 
+struct seq_file;
+
 /*
  * NUD stands for "neighbor unreachability detection"
  */
diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 20c34bd7a077..7a92421640be 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -7,7 +7,6 @@
 
 #include <linux/atomic.h>
 #include <linux/refcount.h>
-#include <linux/workqueue.h>
 #include <linux/list.h>
 #include <linux/sysctl.h>
 #include <linux/uidgid.h>
diff --git a/include/net/net_ratelimit.h b/include/net/net_ratelimit.h
index 93c1bd5133c2..8bc1c31cce8a 100644
--- a/include/net/net_ratelimit.h
+++ b/include/net/net_ratelimit.h
@@ -2,8 +2,6 @@
 #ifndef _LINUX_NET_RATELIMIT_H
 #define _LINUX_NET_RATELIMIT_H
 
-#include <linux/ratelimit.h>
-
 extern struct ratelimit_state net_ratelimit_state;
 
 #endif	/* _LINUX_NET_RATELIMIT_H */
diff --git a/include/net/netns/conntrack.h b/include/net/netns/conntrack.h
index bae914815aa3..e2caf55de629 100644
--- a/include/net/netns/conntrack.h
+++ b/include/net/netns/conntrack.h
@@ -5,7 +5,6 @@
 #include <linux/list.h>
 #include <linux/list_nulls.h>
 #include <linux/atomic.h>
-#include <linux/workqueue.h>
 #include <linux/netfilter/nf_conntrack_tcp.h>
 #ifdef CONFIG_NF_CT_PROTO_DCCP
 #include <linux/netfilter/nf_conntrack_dccp.h>
diff --git a/include/net/netns/xfrm.h b/include/net/netns/xfrm.h
index 423b52eca908..79d382d72ede 100644
--- a/include/net/netns/xfrm.h
+++ b/include/net/netns/xfrm.h
@@ -3,7 +3,6 @@
 #define __NETNS_XFRM_H
 
 #include <linux/list.h>
-#include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <linux/rhashtable-types.h>
 #include <linux/xfrm.h>
diff --git a/include/net/netrom.h b/include/net/netrom.h
index f0565a5987d1..f6fe4a6e307d 100644
--- a/include/net/netrom.h
+++ b/include/net/netrom.h
@@ -13,7 +13,6 @@
 #include <linux/slab.h>
 #include <net/sock.h>
 #include <linux/refcount.h>
-#include <linux/seq_file.h>
 #include <net/ax25.h>
 
 #define	NR_NETWORK_LEN			15
diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index a4ee43f493bb..45df4f0bb91d 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -3,11 +3,12 @@
 #define __NET_PKT_CLS_H
 
 #include <linux/pkt_cls.h>
-#include <linux/workqueue.h>
 #include <net/sch_generic.h>
 #include <net/act_api.h>
 #include <net/net_namespace.h>
 
+struct rcu_work;
+
 /* TC action not accessible from user space */
 #define TC_ACT_CONSUMED		(TC_ACT_VALUE_MAX + 1)
 
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 934fdb977551..da96e966c807 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -11,7 +11,6 @@
 #include <linux/dynamic_queue_limits.h>
 #include <linux/list.h>
 #include <linux/refcount.h>
-#include <linux/workqueue.h>
 #include <linux/mutex.h>
 #include <linux/rwsem.h>
 #include <linux/atomic.h>
diff --git a/include/net/smc.h b/include/net/smc.h
index c9dcb30e3fd9..da590f95811e 100644
--- a/include/net/smc.h
+++ b/include/net/smc.h
@@ -11,12 +11,12 @@
 #ifndef _SMC_H
 #define _SMC_H
 
-#include <linux/device.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
 #include <linux/wait.h>
 #include "linux/ism.h"
 
+struct device;
 struct sock;
 
 #define SMC_MAX_PNETID_LEN	16	/* Max. length of PNET id */
diff --git a/include/net/snmp.h b/include/net/snmp.h
index 468a67836e2f..93ada92299fc 100644
--- a/include/net/snmp.h
+++ b/include/net/snmp.h
@@ -16,7 +16,6 @@
 
 #include <linux/cache.h>
 #include <linux/snmp.h>
-#include <linux/smp.h>
 
 /*
  * Mibs are stored in array of unsigned long.
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 140e012260a8..36ce457e35ce 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -23,7 +23,6 @@
 #include <linux/cache.h>
 #include <linux/percpu.h>
 #include <linux/skbuff.h>
-#include <linux/kref.h>
 #include <linux/ktime.h>
 #include <linux/indirect_call_wrapper.h>
 #include <linux/hrtimer.h> // for hrtimer_try_to_cancel()
@@ -43,11 +42,12 @@
 #include <net/dst.h>
 #include <net/mptcp.h>
 
-#include <linux/seq_file.h>
 #include <linux/memcontrol.h>
 #include <linux/bpf-cgroup.h>
 #include <linux/siphash.h>
 
+struct seq_file;
+
 extern struct inet_hashinfo tcp_hashinfo;
 
 DECLARE_PER_CPU(unsigned int, tcp_orphan_count);
diff --git a/include/net/udp.h b/include/net/udp.h
index 488a6d2babcc..60388bea893d 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -26,10 +26,11 @@
 #include <net/snmp.h>
 #include <net/ip.h>
 #include <linux/ipv6.h>
-#include <linux/seq_file.h>
 #include <linux/poll.h>
 #include <linux/indirect_call_wrapper.h>
 
+struct seq_file;
+
 /**
  *	struct udp_skb_cb  -  UDP(-Lite) private variables
  *
diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 57c743b7e4fe..b96927bae974 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -11,7 +11,6 @@
 #include <linux/pfkeyv2.h>
 #include <linux/ipsec.h>
 #include <linux/in6.h>
-#include <linux/mutex.h>
 #include <linux/audit.h>
 #include <linux/slab.h>
 #include <linux/refcount.h>
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index 565a85044541..9ce4d1a88cad 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -9,7 +9,6 @@
 
 #include <linux/list.h>
 #include <linux/scatterlist.h>
-#include <linux/workqueue.h>
 #include <rdma/ib_verbs.h>
 
 struct ib_ucontext;
diff --git a/include/rdma/restrack.h b/include/rdma/restrack.h
index 8b7c46daeb07..11e487bdf61c 100644
--- a/include/rdma/restrack.h
+++ b/include/rdma/restrack.h
@@ -12,7 +12,6 @@
 #include <linux/completion.h>
 #include <linux/sched/task.h>
 #include <uapi/rdma/rdma_netlink.h>
-#include <linux/xarray.h>
 
 struct ib_device;
 struct sk_buff;
diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index 526def14e7fb..b1569693da53 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -7,7 +7,6 @@
 #include <linux/t10-pi.h>
 #include <linux/list.h>
 #include <linux/types.h>
-#include <linux/timer.h>
 #include <linux/scatterlist.h>
 #include <scsi/scsi_device.h>
 
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index b259d42a1e1a..2e6aaee6042d 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -11,6 +11,7 @@
 #include <linux/blk-mq.h>
 #include <scsi/scsi.h>
 
+struct seq_file;
 struct block_device;
 struct completion;
 struct module;
diff --git a/include/sound/core.h b/include/sound/core.h
index eaae6da1e0b0..a4d06410638b 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -11,7 +11,6 @@
 #include <linux/sched.h>		/* wake_up() */
 #include <linux/mutex.h>		/* struct mutex */
 #include <linux/rwsem.h>		/* struct rw_semaphore */
-#include <linux/pm.h>			/* pm_message_t */
 #include <linux/stringify.h>
 #include <linux/printk.h>
 #include <linux/wait.h>
diff --git a/include/video/atmel_lcdc.h b/include/video/atmel_lcdc.h
index 43e497cdeb60..282193d8e10f 100644
--- a/include/video/atmel_lcdc.h
+++ b/include/video/atmel_lcdc.h
@@ -9,8 +9,6 @@
 #ifndef __ATMEL_LCDC_H__
 #define __ATMEL_LCDC_H__
 
-#include <linux/workqueue.h>
-
 /* Way LCD wires are connected to the chip:
  * Some Atmel chips use BGR color mode (instead of standard RGB)
  * A swapped wiring onboard can bring to RGB mode.
diff --git a/include/xen/interface/memory.h b/include/xen/interface/memory.h
index 1a371a825c55..aa61456091cc 100644
--- a/include/xen/interface/memory.h
+++ b/include/xen/interface/memory.h
@@ -10,8 +10,6 @@
 #ifndef __XEN_PUBLIC_MEMORY_H__
 #define __XEN_PUBLIC_MEMORY_H__
 
-#include <linux/spinlock.h>
-
 /*
  * Increase or decrease the specified domain's memory reservation. Returns a
  * -ve errcode on failure, or the # extents successfully allocated or freed.
diff --git a/include/xen/xenbus.h b/include/xen/xenbus.h
index ac22cf08c09f..d0f2e0a134be 100644
--- a/include/xen/xenbus.h
+++ b/include/xen/xenbus.h
@@ -36,7 +36,6 @@
 
 #include <linux/device.h>
 #include <linux/notifier.h>
-#include <linux/mutex.h>
 #include <linux/export.h>
 #include <linux/fs.h>
 #include <linux/completion.h>
-- 
2.39.2


