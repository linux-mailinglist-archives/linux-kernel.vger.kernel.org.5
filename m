Return-Path: <linux-kernel+bounces-59632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 856C384F9D2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D8AA2881D3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617878288C;
	Fri,  9 Feb 2024 16:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="W3koV7BC"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454AE7B3EE
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707496864; cv=none; b=sRBkWSHcjbhvY1/gLOnxocloE27IIwStIe8wWjzg/Y9/JDYd+6ehzY/T7L6IFrz4s0y2h/v7RGi94NHXxe8eBmpEGxlhJEozAZcqEiTf1JiuvuS6AQDv9ku6jJ6umZlNp2ASojxUu43QjUa2Q1W2eR0D6WJLiT+gN359S27OCuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707496864; c=relaxed/simple;
	bh=JQYxptJhqO5awjGqkfmWG6XGmLeDv7O1QFbH3PdEe64=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RUJER+ZqQMeEwrBumcAHGZMogfdgAEodsSuFI/PnnXbAiyul+lV4JvRtYnN2IKEdF9VeBDr7nXJys8luZMx63xN7r4KMTAVmiXSYsg3Q/G6etMNEDLntpM/aSfmheC8yXPsFAByFxzO66XhohhLWDvVFPSQPWDsHkDQBOy6m/Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=W3koV7BC; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a28a6cef709so155446066b.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 08:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707496858; x=1708101658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OTJVQKhBTkCCcRGvhQiMHvkmUke5OhffbI8haRgPHik=;
        b=W3koV7BClEpctznytVD5eLFFi0XzkIU/h0QRPYSl1mo2XaORPuYYmFlMbP+oAPFERl
         odLoMCrS6DzvpfACJprPc7ehFI9xd0eUfbGcO2g5ZEn0LhU7cYC55tUlErpjunL4e1XW
         upbc3pQCj8rcgXJWkYp88khchFUq6EtBKS11fHfhL/Yhbi7Nhvtqp4G5tnU+k/qSfn0O
         CTo4Pynb7BLMwCZCiY8CMbTnKkPdFy+hqEMNBBeWxliPOrckoxL7II7FvJFlKV1qcEJ5
         NAAJqCJZoOVEwkz4SyysDOU0OXCCfVVvwz+Mtl/reAzLxMYR6t3GVIuAazL2vja0OQGs
         SUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707496858; x=1708101658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OTJVQKhBTkCCcRGvhQiMHvkmUke5OhffbI8haRgPHik=;
        b=b1bfGXMppDhKJtQ7Ay+Arwm8HfUS3+RLCZ/Tk2ubvl4I5/wKYExi2OhAYiE84NeRIz
         IQXQmoXR2c14gYLQdFQ/5pyyUD8newkvr5mZPotl7fqytulpoOzbPf9e8bDRzhy+BVNR
         Bl0wHNCYXyotifjPixYjCxoU2I9pNKJYgETM86DtMeJIGSYMreQFCV1pV/he+AExZCkH
         OkR3J/cQK8QpaBSfCvu41t//fBFKoZcnX4qqP88YgNZFKA9M3wzLjrS7df3fj38vo5vJ
         Raov7YRmeMypZXlNCk3ZFy9YORaEUWzIbGHBtV4bpeYGzDmbZ8bh/HG8av2NHxoQnqEp
         1XcA==
X-Gm-Message-State: AOJu0YxFNwqyh/AUS2wcaEPgnH5/w/8n9BOM3kawL7BF2/++PfcoOPAi
	B6rSuL/R+PR/aAzD7cAeQ3gKxJ5UDmvb8brbqJg0KU/AwopSuqzY9HwSe5NcXLg55bXj/uKZUFB
	H
X-Google-Smtp-Source: AGHT+IFqH9Hh0BIB0HIxDv1FHAjGPgijjvWkqtj4HwPtZgT1FGGKB/OKJGMqlsqbCwSOILkzZUobkA==
X-Received: by 2002:a17:907:76b0:b0:a38:a6a0:3c43 with SMTP id jw16-20020a17090776b000b00a38a6a03c43mr1753715ejc.50.1707496857790;
        Fri, 09 Feb 2024 08:40:57 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id tl27-20020a170907c31b00b00a3bfe97fe27sm477724ejc.218.2024.02.09.08.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 08:40:56 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 13/35] wait.h: move declarations to wait_types.h
Date: Fri,  9 Feb 2024 17:40:05 +0100
Message-Id: <20240209164027.2582906-14-max.kellermann@ionos.com>
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

By providing declarations in a lean header, we can reduce header
dependencies.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h |  2 +-
 include/drm/gpu_scheduler.h            |  2 +-
 include/linux/backing-dev-defs.h       |  2 +-
 include/linux/blkdev.h                 |  2 +-
 include/linux/buffer_head.h            |  2 +-
 include/linux/ceph/libceph.h           |  2 +-
 include/linux/cgroup-defs.h            |  2 +-
 include/linux/console_struct.h         |  2 +-
 include/linux/counter.h                |  2 +-
 include/linux/dcache.h                 |  2 +-
 include/linux/dma-buf.h                |  2 +-
 include/linux/eventfd.h                |  2 +-
 include/linux/gnss.h                   |  2 +-
 include/linux/libps2.h                 |  2 +-
 include/linux/lp.h                     |  2 +-
 include/linux/mempool.h                |  2 +-
 include/linux/mhi.h                    |  2 +-
 include/linux/mmzone.h                 |  2 +-
 include/linux/net.h                    |  2 +-
 include/linux/nfs_fs_sb.h              |  2 +-
 include/linux/parport.h                |  2 +-
 include/linux/pid.h                    |  2 +-
 include/linux/pm.h                     |  2 +-
 include/linux/poll.h                   |  2 +-
 include/linux/psi_types.h              |  2 +-
 include/linux/relay.h                  |  2 +-
 include/linux/rtnetlink.h              |  2 +-
 include/linux/sbitmap.h                |  2 +-
 include/linux/sunrpc/rpc_pipe_fs.h     |  2 +-
 include/linux/syslog.h                 |  2 +-
 include/linux/tty_port.h               |  2 +-
 include/linux/wait.h                   | 23 +------------------
 include/linux/wait_bit.h               |  2 +-
 include/linux/wait_types.h             | 31 ++++++++++++++++++++++++++
 include/media/dvb_ringbuffer.h         |  2 +-
 include/net/smc.h                      |  2 +-
 include/net/sock.h                     |  2 +-
 include/scsi/libiscsi.h                |  2 +-
 include/sound/control.h                |  2 +-
 include/sound/rawmidi.h                |  2 +-
 40 files changed, 70 insertions(+), 60 deletions(-)
 create mode 100644 include/linux/wait_types.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
index 59a5bc9b1120..6e01527b2be5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
@@ -25,7 +25,7 @@
 #define __AMDGPU_IH_H__
 
 #include <linux/types.h>
-#include <linux/wait.h>
+#include <linux/wait_types.h>
 
 /* Maximum number of IVs processed at once */
 #define AMDGPU_IH_MAX_NUM_IVS	32
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 4edd7ac64b62..05591cc987c2 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -28,7 +28,7 @@
 #include <linux/dma-fence.h>
 #include <linux/completion.h>
 #include <linux/xarray.h>
-#include <linux/wait.h>
+#include <linux/wait_types.h>
 #include <linux/workqueue_types.h>
 
 #define MAX_WAIT_SCHED_ENTITY_Q_EMPTY msecs_to_jiffies(1000)
diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index 720a88bb3513..ffdd82f2f3e6 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -10,7 +10,7 @@
 #include <linux/percpu-refcount.h>
 #include <linux/flex_proportions.h>
 #include <linux/timer_types.h>
-#include <linux/wait.h>
+#include <linux/wait_types.h>
 #include <linux/workqueue_types.h>
 #include <linux/kref_types.h>
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 26344147adec..2a8df9c0e87b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -13,7 +13,7 @@
 #include <linux/minmax.h>
 #include <linux/timer_types.h>
 #include <linux/workqueue_types.h>
-#include <linux/wait.h>
+#include <linux/wait_types.h>
 #include <linux/bio.h>
 #include <linux/gfp_types.h>
 #include <linux/kdev_t.h>
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index d78454a4dd1f..15dffb5374fb 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -13,7 +13,7 @@
 #include <linux/fs.h>
 #include <linux/linkage.h>
 #include <linux/pagemap.h>
-#include <linux/wait.h>
+#include <linux/wait_types.h>
 #include <linux/atomic.h>
 
 enum bh_state_bits {
diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
index d01be9103e56..12eb9c9f6620 100644
--- a/include/linux/ceph/libceph.h
+++ b/include/linux/ceph/libceph.h
@@ -11,7 +11,7 @@
 #include <linux/fs.h>
 #include <linux/mempool.h>
 #include <linux/pagemap.h>
-#include <linux/wait.h>
+#include <linux/wait_types.h>
 #include <linux/writeback.h>
 #include <linux/slab.h>
 #include <linux/refcount_types.h>
diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 380a59b31624..99e24f3034df 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -11,7 +11,7 @@
 #include <linux/limits.h>
 #include <linux/list.h>
 #include <linux/idr.h>
-#include <linux/wait.h>
+#include <linux/wait_types.h>
 #include <linux/mutex_types.h>
 #include <linux/rcupdate.h>
 #include <linux/refcount_types.h>
diff --git a/include/linux/console_struct.h b/include/linux/console_struct.h
index a0142b93eaf9..8babdd50a4ca 100644
--- a/include/linux/console_struct.h
+++ b/include/linux/console_struct.h
@@ -13,7 +13,7 @@
 #ifndef _LINUX_CONSOLE_STRUCT_H
 #define _LINUX_CONSOLE_STRUCT_H
 
-#include <linux/wait.h>
+#include <linux/wait_types.h>
 #include <linux/vt.h>
 #include <linux/workqueue_types.h>
 
diff --git a/include/linux/counter.h b/include/linux/counter.h
index 846b94517c5b..638ebb5b4d27 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -13,7 +13,7 @@
 #include <linux/mutex_types.h>
 #include <linux/spinlock_types.h>
 #include <linux/types.h>
-#include <linux/wait.h>
+#include <linux/wait_types.h>
 #include <uapi/linux/counter.h>
 
 struct counter_device;
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 04ab9e67046c..560ca5e16f1e 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -13,7 +13,7 @@
 #include <linux/rcupdate.h>
 #include <linux/lockref.h>
 #include <linux/stringhash.h>
-#include <linux/wait.h>
+#include <linux/wait_types.h>
 
 struct path;
 struct file;
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index 8ff4add71f88..ab67e5a4b0ec 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -21,7 +21,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/fs.h>
 #include <linux/dma-fence.h>
-#include <linux/wait.h>
+#include <linux/wait_types.h>
 
 struct device;
 struct dma_buf;
diff --git a/include/linux/eventfd.h b/include/linux/eventfd.h
index 7199c5039561..5f41551db2f1 100644
--- a/include/linux/eventfd.h
+++ b/include/linux/eventfd.h
@@ -9,7 +9,7 @@
 #ifndef _LINUX_EVENTFD_H
 #define _LINUX_EVENTFD_H
 
-#include <linux/wait.h>
+#include <linux/wait_types.h>
 #include <linux/err.h>
 #include <linux/sched.h>
 #include <uapi/linux/eventfd.h>
diff --git a/include/linux/gnss.h b/include/linux/gnss.h
index 9f38ff948d78..3c24e934b732 100644
--- a/include/linux/gnss.h
+++ b/include/linux/gnss.h
@@ -14,7 +14,7 @@
 #include <linux/mutex_types.h>
 #include <linux/rwsem_types.h>
 #include <linux/types.h>
-#include <linux/wait.h>
+#include <linux/wait_types.h>
 
 struct gnss_device;
 
diff --git a/include/linux/libps2.h b/include/linux/libps2.h
index 006c38667e75..c2f438730ae1 100644
--- a/include/linux/libps2.h
+++ b/include/linux/libps2.h
@@ -11,7 +11,7 @@
 #include <linux/interrupt.h>
 #include <linux/mutex_types.h>
 #include <linux/types.h>
-#include <linux/wait.h>
+#include <linux/wait_types.h>
 
 struct ps2dev;
 
diff --git a/include/linux/lp.h b/include/linux/lp.h
index 337573412852..d700bf3255b1 100644
--- a/include/linux/lp.h
+++ b/include/linux/lp.h
@@ -9,7 +9,7 @@
 #define _LINUX_LP_H
 
 
-#include <linux/wait.h>
+#include <linux/wait_types.h>
 #include <linux/mutex_types.h>
 #include <uapi/linux/lp.h>
 
diff --git a/include/linux/mempool.h b/include/linux/mempool.h
index 16c5cc807ff6..d3df002ac3b7 100644
--- a/include/linux/mempool.h
+++ b/include/linux/mempool.h
@@ -5,7 +5,7 @@
 #ifndef _LINUX_MEMPOOL_H
 #define _LINUX_MEMPOOL_H
 
-#include <linux/wait.h>
+#include <linux/wait_types.h>
 #include <linux/compiler.h>
 
 struct kmem_cache;
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index bd99f47726dc..243bfae1a94c 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -12,7 +12,7 @@
 #include <linux/skbuff.h>
 #include <linux/slab.h>
 #include <linux/spinlock_types.h>
-#include <linux/wait.h>
+#include <linux/wait_types.h>
 #include <linux/workqueue_types.h>
 
 #define MHI_MAX_OEM_PK_HASH_SEGMENTS 16
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index ce11c2dab2bc..fa41c34f16da 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -8,7 +8,7 @@
 #include <linux/spinlock_types.h>
 #include <linux/list.h>
 #include <linux/list_nulls.h>
-#include <linux/wait.h>
+#include <linux/wait_types.h>
 #include <linux/bitops.h>
 #include <linux/cache.h>
 #include <linux/threads.h>
diff --git a/include/linux/net.h b/include/linux/net.h
index c9b4a63791a4..139a936fb772 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -16,7 +16,7 @@
 
 #include <linux/stringify.h>
 #include <linux/random.h>
-#include <linux/wait.h>
+#include <linux/wait_types.h>
 #include <linux/fcntl.h>	/* For O_CLOEXEC and O_NONBLOCK */
 #include <linux/rcupdate.h>
 #include <linux/once.h>
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 08860ceda787..1c9a1e28b13e 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -5,7 +5,7 @@
 #include <linux/list.h>
 #include <linux/backing-dev.h>
 #include <linux/idr.h>
-#include <linux/wait.h>
+#include <linux/wait_types.h>
 #include <linux/nfs_xdr.h>
 #include <linux/sunrpc/xprt.h>
 
diff --git a/include/linux/parport.h b/include/linux/parport.h
index c8e3b71a3b49..783835d05d9b 100644
--- a/include/linux/parport.h
+++ b/include/linux/parport.h
@@ -10,7 +10,7 @@
 #include <linux/jiffies.h>
 #include <linux/proc_fs.h>
 #include <linux/spinlock_types.h>
-#include <linux/wait.h>
+#include <linux/wait_types.h>
 #include <linux/irqreturn.h>
 #include <linux/semaphore.h>
 #include <linux/device.h>
diff --git a/include/linux/pid.h b/include/linux/pid.h
index 8124d57752b9..fd9d9c054585 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -7,7 +7,7 @@
 #include <linux/rcupdate.h>
 #include <linux/refcount.h>
 #include <linux/sched.h>
-#include <linux/wait.h>
+#include <linux/wait_types.h>
 
 /*
  * What is struct pid?
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 303a143c4e04..c1533ce86893 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -13,7 +13,7 @@
 #include <linux/list.h>
 #include <linux/workqueue_types.h>
 #include <linux/spinlock_types.h>
-#include <linux/wait.h>
+#include <linux/wait_types.h>
 #include <linux/hrtimer_types.h>
 #include <linux/completion.h>
 
diff --git a/include/linux/poll.h b/include/linux/poll.h
index a9e0e1c2d1f2..043aa684b09c 100644
--- a/include/linux/poll.h
+++ b/include/linux/poll.h
@@ -5,7 +5,7 @@
 
 #include <linux/compiler.h>
 #include <linux/ktime.h>
-#include <linux/wait.h>
+#include <linux/wait_types.h>
 #include <linux/string.h>
 #include <linux/fs.h>
 #include <linux/uaccess.h>
diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index 8af6452b36e2..de72dcc6e0bf 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -5,7 +5,7 @@
 #include <linux/kthread.h>
 #include <linux/seqlock_types.h>
 #include <linux/types.h>
-#include <linux/wait.h>
+#include <linux/wait_types.h>
 
 #ifdef CONFIG_PSI
 
diff --git a/include/linux/relay.h b/include/linux/relay.h
index d33735edc3cb..79ecc446ed48 100644
--- a/include/linux/relay.h
+++ b/include/linux/relay.h
@@ -13,7 +13,7 @@
 
 #include <linux/types.h>
 #include <linux/sched.h>
-#include <linux/wait.h>
+#include <linux/wait_types.h>
 #include <linux/list.h>
 #include <linux/irq_work.h>
 #include <linux/bug.h>
diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index d1c42219429c..4b1f01916825 100644
--- a/include/linux/rtnetlink.h
+++ b/include/linux/rtnetlink.h
@@ -3,7 +3,7 @@
 #define __LINUX_RTNETLINK_H
 
 #include <linux/netdevice.h>
-#include <linux/wait.h>
+#include <linux/wait_types.h>
 #include <linux/refcount.h>
 #include <uapi/linux/rtnetlink.h>
 
diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index d7d3fba174f8..f7279f7632fe 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -18,7 +18,7 @@
 #include <linux/percpu.h>
 #include <linux/slab.h>
 #include <linux/types.h>
-#include <linux/wait.h>
+#include <linux/wait_types.h>
 
 struct seq_file;
 
diff --git a/include/linux/sunrpc/rpc_pipe_fs.h b/include/linux/sunrpc/rpc_pipe_fs.h
index c26733d8fde7..3f4d6fc0a8a3 100644
--- a/include/linux/sunrpc/rpc_pipe_fs.h
+++ b/include/linux/sunrpc/rpc_pipe_fs.h
@@ -4,7 +4,7 @@
 
 #include <linux/list.h>
 #include <linux/spinlock_types.h>
-#include <linux/wait.h>
+#include <linux/wait_types.h>
 
 struct rpc_pipe_dir_head {
 	struct list_head pdh_entries;
diff --git a/include/linux/syslog.h b/include/linux/syslog.h
index 955f80e34d4f..2a4c9199d718 100644
--- a/include/linux/syslog.h
+++ b/include/linux/syslog.h
@@ -8,7 +8,7 @@
 #ifndef _LINUX_SYSLOG_H
 #define _LINUX_SYSLOG_H
 
-#include <linux/wait.h>
+#include <linux/wait_types.h>
 
 /* Close the log.  Currently a NOP. */
 #define SYSLOG_ACTION_CLOSE          0
diff --git a/include/linux/tty_port.h b/include/linux/tty_port.h
index a76a5b6a5cf2..8622638452cb 100644
--- a/include/linux/tty_port.h
+++ b/include/linux/tty_port.h
@@ -6,7 +6,7 @@
 #include <linux/kref.h>
 #include <linux/mutex_types.h>
 #include <linux/tty_buffer.h>
-#include <linux/wait.h>
+#include <linux/wait_types.h>
 
 struct attribute_group;
 struct tty_driver;
diff --git a/include/linux/wait.h b/include/linux/wait.h
index 8aa3372f21a0..b36000bb012c 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -4,17 +4,12 @@
 /*
  * Linux wait queue related types and methods
  */
-#include <linux/list.h>
+#include <linux/wait_types.h>
 #include <linux/stddef.h>
 #include <linux/spinlock.h>
 
 #include <asm/current.h>
 
-typedef struct wait_queue_entry wait_queue_entry_t;
-
-typedef int (*wait_queue_func_t)(struct wait_queue_entry *wq_entry, unsigned mode, int flags, void *key);
-int default_wake_function(struct wait_queue_entry *wq_entry, unsigned mode, int flags, void *key);
-
 /* wait_queue_entry::flags */
 #define WQ_FLAG_EXCLUSIVE	0x01
 #define WQ_FLAG_WOKEN		0x02
@@ -22,22 +17,6 @@ int default_wake_function(struct wait_queue_entry *wq_entry, unsigned mode, int
 #define WQ_FLAG_DONE		0x08
 #define WQ_FLAG_PRIORITY	0x10
 
-/*
- * A single wait-queue entry structure:
- */
-struct wait_queue_entry {
-	unsigned int		flags;
-	void			*private;
-	wait_queue_func_t	func;
-	struct list_head	entry;
-};
-
-struct wait_queue_head {
-	spinlock_t		lock;
-	struct list_head	head;
-};
-typedef struct wait_queue_head wait_queue_head_t;
-
 struct task_struct;
 
 /*
diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
index 96c90fbcf652..514f68eff79d 100644
--- a/include/linux/wait_bit.h
+++ b/include/linux/wait_bit.h
@@ -8,7 +8,7 @@
 #include <linux/bitops.h>
 #include <linux/init.h> // for __init
 #include <linux/kernel.h> // for might_sleep()
-#include <linux/wait.h>
+#include <linux/wait_types.h>
 
 struct wait_bit_key {
 	void			*flags;
diff --git a/include/linux/wait_types.h b/include/linux/wait_types.h
new file mode 100644
index 000000000000..4b43e7bc6dac
--- /dev/null
+++ b/include/linux/wait_types.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_WAIT_TYPES_H
+#define _LINUX_WAIT_TYPES_H
+/*
+ * Linux wait queue related types and methods
+ */
+#include <linux/list.h>
+#include <linux/spinlock_types.h>
+
+typedef struct wait_queue_entry wait_queue_entry_t;
+
+typedef int (*wait_queue_func_t)(struct wait_queue_entry *wq_entry, unsigned mode, int flags, void *key);
+int default_wake_function(struct wait_queue_entry *wq_entry, unsigned mode, int flags, void *key);
+
+/*
+ * A single wait-queue entry structure:
+ */
+struct wait_queue_entry {
+	unsigned int		flags;
+	void			*private;
+	wait_queue_func_t	func;
+	struct list_head	entry;
+};
+
+struct wait_queue_head {
+	spinlock_t		lock;
+	struct list_head	head;
+};
+typedef struct wait_queue_head wait_queue_head_t;
+
+#endif /* _LINUX_WAIT_TYPES_H */
diff --git a/include/media/dvb_ringbuffer.h b/include/media/dvb_ringbuffer.h
index 131997d1f131..22da81bff624 100644
--- a/include/media/dvb_ringbuffer.h
+++ b/include/media/dvb_ringbuffer.h
@@ -24,7 +24,7 @@
 #define _DVB_RINGBUFFER_H_
 
 #include <linux/spinlock_types.h>
-#include <linux/wait.h>
+#include <linux/wait_types.h>
 
 /**
  * struct dvb_ringbuffer - Describes a ring buffer used at DVB framework
diff --git a/include/net/smc.h b/include/net/smc.h
index 44a01bd3da10..92611a9cf0e9 100644
--- a/include/net/smc.h
+++ b/include/net/smc.h
@@ -13,7 +13,7 @@
 
 #include <linux/spinlock_types.h>
 #include <linux/types.h>
-#include <linux/wait.h>
+#include <linux/wait_types.h>
 #include "linux/ism.h"
 
 struct device;
diff --git a/include/net/sock.h b/include/net/sock.h
index bebdc45cf622..008a6c5a3bfc 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -53,7 +53,7 @@
 #include <linux/memcontrol.h>
 #include <linux/static_key.h>
 #include <linux/sched.h>
-#include <linux/wait.h>
+#include <linux/wait_types.h>
 #include <linux/cgroup-defs.h>
 #include <linux/rbtree_types.h>
 #include <linux/rculist_nulls.h>
diff --git a/include/scsi/libiscsi.h b/include/scsi/libiscsi.h
index 01f13729ad24..d30e65c5f137 100644
--- a/include/scsi/libiscsi.h
+++ b/include/scsi/libiscsi.h
@@ -11,7 +11,7 @@
 #define LIBISCSI_H
 
 #include <linux/types.h>
-#include <linux/wait.h>
+#include <linux/wait_types.h>
 #include <linux/mutex_types.h>
 #include <linux/timer_types.h>
 #include <linux/workqueue_types.h>
diff --git a/include/sound/control.h b/include/sound/control.h
index 9a4f4f7138da..b921cdb94082 100644
--- a/include/sound/control.h
+++ b/include/sound/control.h
@@ -7,7 +7,7 @@
  *  Copyright (c) by Jaroslav Kysela <perex@perex.cz>
  */
 
-#include <linux/wait.h>
+#include <linux/wait_types.h>
 #include <linux/nospec.h>
 #include <sound/asound.h>
 
diff --git a/include/sound/rawmidi.h b/include/sound/rawmidi.h
index 46678a38dbb9..6c380196bff4 100644
--- a/include/sound/rawmidi.h
+++ b/include/sound/rawmidi.h
@@ -10,7 +10,7 @@
 #include <sound/asound.h>
 #include <linux/interrupt.h>
 #include <linux/spinlock_types.h>
-#include <linux/wait.h>
+#include <linux/wait_types.h>
 #include <linux/mutex_types.h>
 #include <linux/workqueue_types.h>
 #include <linux/device.h>
-- 
2.39.2


