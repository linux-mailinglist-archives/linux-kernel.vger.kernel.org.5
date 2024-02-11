Return-Path: <linux-kernel+bounces-61017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9415B850C4F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 00:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EA62280D9F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 23:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A683B782;
	Sun, 11 Feb 2024 23:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="jJBUeGE5"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2332439843
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 23:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707693373; cv=none; b=W8NussvCKXhwszy+uWIfJHOPUQCc7qQphEzoVvsu2LUamPQICNuwZPflw2Xv/md3z6L3iyyaqAaVrtOl+FQ8EvNCNat7hHu3ZNsZq1tDhUGoHOd1jkN7mVc2XcveVuS0FJbLUpScEhWprcTEcagf2B1C49k368O+4jApmhCLxxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707693373; c=relaxed/simple;
	bh=DOs/1CT7Q9lpsib1nJw3jvympuQfSrmsd//C5vY6qKY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pwPne2VCNM8qSnJnd/DD8c7B+jj04ZnVCI3LYE2aaZ2wjznAXmUeklCZ5W0Y4vuas82p+ZktdJj1JALQHNbGJZ8FNM9tVTEWsfZGDS+zgU9OhdX4+eBunxIA7oeVr3oYsxrUfAqQSg7inchpVGo7MtRUbw8GInWw6LY7kX3QB1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=jJBUeGE5; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51165a488baso3512603e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 15:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707693365; x=1708298165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ny55Id8/NqdjgmE7ajAns4TZAdiMo58DOz6DyfWMXq0=;
        b=jJBUeGE54sskfzs7Wr+h3/FFSzLV5X+3Zu89i/6v2F1R3VbKv/ozvN8VbtkjPoy9YX
         Wdy1zFV9wwuy0yARl7yog/GfoX6ATWfIfWqEja14Q1b7fybFlMCwRDXJTY6e7lF0CET7
         /Ey1ufPkhhHFidSANqKXk/z2FMs6ZP71xKJAJ3RYisMWn1YKBC2WBgACokBBwooQTq6J
         oxJMcTi66O3zloO0PishYMtOx1+eXs2nm3/WpSuzznizITeKkUZvwfaCjSBy+tCmAP2m
         NbAHxdFxZmSqiQLpO4+i4SLpsizug7GuQ5eAOGFru+aEbIX0DCj3h7KB0inBgIPaU/rD
         bvgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707693365; x=1708298165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ny55Id8/NqdjgmE7ajAns4TZAdiMo58DOz6DyfWMXq0=;
        b=s9in+aFZyz3Q/Cbg2qjO2lksyXM4yx1xdmQ8KLoKiZqODXMa3J6hRLnukVF0b6fLK2
         9yu7S4/h3YzI26HxNzXgeCONMTZLPIbNxshPX5RY+eWT7A7MB250h7CdfPUbO4B/GnKp
         dckfuWaYRt4j66zFIR4RWXDnVvAfzRuy3brmArvMY0TIgUccEP2tKAnSilEE9gPFoIeH
         KVKpEz98Q5idC8bQ2hZgD/YLQzrGL8lWAb4Z3WmghTW6RbzTWhSZ4Hernfi3eqZXIXX2
         2h+U7xnQhjERXkJ3WFXKEkcjlbq9iGw06B6TPSPMz2LTeXXtsj0G/t9nK7FyhmGeGNKF
         HeJQ==
X-Gm-Message-State: AOJu0Yz5nhKBJaG4us3T0LJBUmvhPzOvPuo2oWt+MKH/NpI4aIgI1NJR
	ESJaDqt8fj7ZPEfAbCRj4E4HAmnddMoL+rPZif03EvUZniKjVHKqmNtCSD29NIXtg9krJkGljY6
	s
X-Google-Smtp-Source: AGHT+IHL7J6AsQGDZNd4fJ9ODa8ixj4p3+pzKbYDnUlwlqbwZmHqq0e/RTM1qsPug4hvg6t0C98WEg==
X-Received: by 2002:ac2:5f49:0:b0:511:45ec:a17f with SMTP id 9-20020ac25f49000000b0051145eca17fmr2745663lfz.40.1707693365491;
        Sun, 11 Feb 2024 15:16:05 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id et13-20020a056402378d00b0055d19c9daf2sm2170180edb.15.2024.02.11.15.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 15:16:05 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v4 35/35] include: remove lots of unnecessary <linux/kernel.h> includes
Date: Mon, 12 Feb 2024 00:15:18 +0100
Message-Id: <20240211231518.349442-36-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240211231518.349442-1-max.kellermann@ionos.com>
References: <20240211231518.349442-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 arch/arm64/include/asm/cpufeature.h      | 1 -
 arch/arm64/include/asm/fixmap.h          | 1 -
 include/acpi/platform/aclinux.h          | 1 -
 include/linux/backing-dev.h              | 1 -
 include/linux/badblocks.h                | 1 -
 include/linux/bcm47xx_nvram.h            | 1 -
 include/linux/bcm47xx_sprom.h            | 1 -
 include/linux/bit_spinlock.h             | 1 -
 include/linux/bootconfig.h               | 1 -
 include/linux/btree.h                    | 1 -
 include/linux/clk.h                      | 1 -
 include/linux/counter.h                  | 1 -
 include/linux/cpu_pm.h                   | 1 -
 include/linux/cpumask.h                  | 1 -
 include/linux/decompress/mm.h            | 1 -
 include/linux/dim.h                      | 1 -
 include/linux/firewire.h                 | 1 -
 include/linux/fs_context.h               | 1 -
 include/linux/gpio.h                     | 2 --
 include/linux/gpio/consumer.h            | 1 -
 include/linux/greybus.h                  | 1 -
 include/linux/hashtable.h                | 1 -
 include/linux/highmem.h                  | 1 -
 include/linux/interrupt.h                | 1 -
 include/linux/iova.h                     | 1 -
 include/linux/isa.h                      | 1 -
 include/linux/isdn/capilli.h             | 1 -
 include/linux/kallsyms.h                 | 1 -
 include/linux/kasan.h                    | 1 -
 include/linux/kfifo.h                    | 1 -
 include/linux/libnvdimm.h                | 2 +-
 include/linux/lsm_audit.h                | 1 -
 include/linux/maple_tree.h               | 1 -
 include/linux/memcontrol.h               | 1 -
 include/linux/mfd/davinci_voicecodec.h   | 1 -
 include/linux/mfd/madera/pdata.h         | 1 -
 include/linux/mfd/wm8350/core.h          | 1 -
 include/linux/mlx5/driver.h              | 1 -
 include/linux/mtd/map.h                  | 1 -
 include/linux/namei.h                    | 1 -
 include/linux/net/intel/iidc.h           | 1 -
 include/linux/pci-ecam.h                 | 1 -
 include/linux/peci.h                     | 1 -
 include/linux/profile.h                  | 1 -
 include/linux/qed/qed_chain.h            | 1 -
 include/linux/qed/qed_if.h               | 1 -
 include/linux/qed/qed_ll2_if.h           | 1 -
 include/linux/randomize_kstack.h         | 1 -
 include/linux/regulator/coupler.h        | 1 -
 include/linux/resctrl.h                  | 1 -
 include/linux/rfkill.h                   | 1 -
 include/linux/rmi.h                      | 1 -
 include/linux/sed-opal-key.h             | 2 +-
 include/linux/siphash.h                  | 1 -
 include/linux/skbuff.h                   | 1 -
 include/linux/soc/amlogic/meson-canvas.h | 2 +-
 include/linux/soc/ixp4xx/npe.h           | 1 -
 include/linux/soc/ixp4xx/qmgr.h          | 1 -
 include/linux/soc/mediatek/mtk_wed.h     | 1 -
 include/linux/sysfb.h                    | 1 -
 include/linux/textsearch.h               | 1 -
 include/linux/usb/pd.h                   | 1 -
 include/linux/vdpa.h                     | 1 -
 include/linux/videodev2.h                | 1 -
 include/linux/watchdog.h                 | 1 -
 include/linux/xarray.h                   | 1 -
 include/linux/zutil.h                    | 1 -
 include/net/af_vsock.h                   | 1 -
 include/net/caif/caif_device.h           | 1 -
 include/net/flow_offload.h               | 1 -
 include/net/ieee80211_radiotap.h         | 1 -
 include/net/inet_connection_sock.h       | 1 -
 include/net/ipv6_frag.h                  | 1 -
 include/net/mac80211.h                   | 1 -
 include/net/sock.h                       | 1 -
 include/rdma/iba.h                       | 1 -
 include/rdma/uverbs_types.h              | 1 -
 include/scsi/scsi.h                      | 1 -
 include/sound/soc.h                      | 1 -
 include/xen/grant_table.h                | 1 -
 include/xen/xen-front-pgdir-shbuf.h      | 2 --
 81 files changed, 3 insertions(+), 83 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index a98d95f3492b..b4cf83ec8c93 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -22,7 +22,6 @@
 
 #include <linux/bug.h>
 #include <linux/jump_label.h>
-#include <linux/kernel.h>
 #include <linux/cpumask.h>
 
 /*
diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
index 58c294a96676..5d127e0fe919 100644
--- a/arch/arm64/include/asm/fixmap.h
+++ b/arch/arm64/include/asm/fixmap.h
@@ -16,7 +16,6 @@
 #define _ASM_ARM64_FIXMAP_H
 
 #ifndef __ASSEMBLY__
-#include <linux/kernel.h>
 #include <linux/math.h>
 #include <linux/sizes.h>
 #include <asm/boot.h>
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 9d88b028f6b0..a26dbc7f66b2 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -50,7 +50,6 @@
 #endif
 
 #include <linux/string.h>
-#include <linux/kernel.h>
 #include <linux/ctype.h>
 #include <linux/sched.h>
 #include <linux/atomic.h>
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 3c39a171c073..38ac4bf4c26f 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -9,7 +9,6 @@
 #ifndef _LINUX_BACKING_DEV_H
 #define _LINUX_BACKING_DEV_H
 
-#include <linux/kernel.h>
 #include <linux/fs.h>
 #include <linux/sched.h>
 #include <linux/device.h>
diff --git a/include/linux/badblocks.h b/include/linux/badblocks.h
index bd14c9de160a..345b04610a60 100644
--- a/include/linux/badblocks.h
+++ b/include/linux/badblocks.h
@@ -4,7 +4,6 @@
 
 #include <linux/seqlock_types.h>
 #include <linux/device.h>
-#include <linux/kernel.h>
 #include <linux/stddef.h>
 #include <linux/types.h>
 
diff --git a/include/linux/bcm47xx_nvram.h b/include/linux/bcm47xx_nvram.h
index 7615f8d7b1ed..e4b6ce953ddb 100644
--- a/include/linux/bcm47xx_nvram.h
+++ b/include/linux/bcm47xx_nvram.h
@@ -7,7 +7,6 @@
 
 #include <linux/errno.h>
 #include <linux/types.h>
-#include <linux/kernel.h>
 #include <linux/vmalloc.h>
 
 #ifdef CONFIG_BCM47XX_NVRAM
diff --git a/include/linux/bcm47xx_sprom.h b/include/linux/bcm47xx_sprom.h
index f8254fd53e15..bb2b58dffa98 100644
--- a/include/linux/bcm47xx_sprom.h
+++ b/include/linux/bcm47xx_sprom.h
@@ -6,7 +6,6 @@
 #define __BCM47XX_SPROM_H
 
 #include <linux/types.h>
-#include <linux/kernel.h>
 #include <linux/vmalloc.h>
 
 struct ssb_sprom;
diff --git a/include/linux/bit_spinlock.h b/include/linux/bit_spinlock.h
index bbc4730a6505..9bb56222346c 100644
--- a/include/linux/bit_spinlock.h
+++ b/include/linux/bit_spinlock.h
@@ -2,7 +2,6 @@
 #ifndef __LINUX_BIT_SPINLOCK_H
 #define __LINUX_BIT_SPINLOCK_H
 
-#include <linux/kernel.h>
 #include <linux/preempt.h>
 #include <linux/atomic.h>
 #include <linux/bug.h>
diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index 81f3738d453c..7187ce3d1a2f 100644
--- a/include/linux/bootconfig.h
+++ b/include/linux/bootconfig.h
@@ -8,7 +8,6 @@
  */
 
 #ifdef __KERNEL__
-#include <linux/kernel.h>
 #include <linux/init.h> // for __init
 #include <linux/types.h>
 #else /* !__KERNEL__ */
diff --git a/include/linux/btree.h b/include/linux/btree.h
index 243ee544397a..f88a19413419 100644
--- a/include/linux/btree.h
+++ b/include/linux/btree.h
@@ -2,7 +2,6 @@
 #ifndef BTREE_H
 #define BTREE_H
 
-#include <linux/kernel.h>
 #include <linux/mempool.h>
 
 /**
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 2fcae620703b..f285683f40d8 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -10,7 +10,6 @@
 #define __LINUX_CLK_H
 
 #include <linux/err.h>
-#include <linux/kernel.h>
 #include <linux/notifier.h>
 #include <linux/sched/debug_atomic_sleep.h> // for might_sleep()
 
diff --git a/include/linux/counter.h b/include/linux/counter.h
index 95e8067f4b78..bc66c23e1bc6 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -8,7 +8,6 @@
 
 #include <linux/cdev.h>
 #include <linux/device_types.h>
-#include <linux/kernel.h>
 #include <linux/kfifo.h>
 #include <linux/mutex_types.h>
 #include <linux/spinlock_types.h>
diff --git a/include/linux/cpu_pm.h b/include/linux/cpu_pm.h
index 552b8f9ea05e..947e0f0faebe 100644
--- a/include/linux/cpu_pm.h
+++ b/include/linux/cpu_pm.h
@@ -9,7 +9,6 @@
 #ifndef _LINUX_CPU_PM_H
 #define _LINUX_CPU_PM_H
 
-#include <linux/kernel.h>
 #include <linux/notifier.h>
 
 /*
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 2b601a7eb148..fbb5e29aac3b 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -8,7 +8,6 @@
  * only nr_cpu_ids (<= NR_CPUS) bits are valid.
  */
 #include <linux/cleanup.h>
-#include <linux/kernel.h>
 #include <linux/threads.h>
 #include <linux/bitmap.h>
 #include <linux/atomic.h>
diff --git a/include/linux/decompress/mm.h b/include/linux/decompress/mm.h
index ac862422df15..3fa9bbe24272 100644
--- a/include/linux/decompress/mm.h
+++ b/include/linux/decompress/mm.h
@@ -76,7 +76,6 @@ MALLOC_VISIBLE void free(void *where)
 
 /* Code active when compiled standalone for use when loading ramdisk: */
 
-#include <linux/kernel.h>
 #include <linux/fs.h>
 #include <linux/string.h>
 #include <linux/slab.h>
diff --git a/include/linux/dim.h b/include/linux/dim.h
index e4ff5829963f..56b0aca7abf0 100644
--- a/include/linux/dim.h
+++ b/include/linux/dim.h
@@ -5,7 +5,6 @@
 #define DIM_H
 
 #include <linux/bits.h>
-#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/workqueue_types.h>
diff --git a/include/linux/firewire.h b/include/linux/firewire.h
index a81e31472530..a4ded9ad3a71 100644
--- a/include/linux/firewire.h
+++ b/include/linux/firewire.h
@@ -5,7 +5,6 @@
 #include <linux/completion_types.h>
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
-#include <linux/kernel.h>
 #include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/mutex_types.h>
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index 34ad2597640e..2ffc7c992d59 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -8,7 +8,6 @@
 #ifndef _LINUX_FS_CONTEXT_H
 #define _LINUX_FS_CONTEXT_H
 
-#include <linux/kernel.h>
 #include <linux/refcount_types.h>
 #include <linux/errno.h>
 #include <linux/security.h>
diff --git a/include/linux/gpio.h b/include/linux/gpio.h
index 7ecc25c543ce..f735f9cb1a95 100644
--- a/include/linux/gpio.h
+++ b/include/linux/gpio.h
@@ -125,8 +125,6 @@ int devm_gpio_request_one(struct device *dev, unsigned gpio,
 
 #else /* ! CONFIG_GPIOLIB */
 
-#include <linux/kernel.h>
-
 #include <asm/bug.h>
 #include <asm/errno.h>
 
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index db2dfbae8edb..601b3558c3c0 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -184,7 +184,6 @@ struct gpio_desc *devm_fwnode_gpiod_get_index(struct device *dev,
 #else /* CONFIG_GPIOLIB */
 
 #include <linux/err.h>
-#include <linux/kernel.h>
 
 #include <asm/bug.h>
 
diff --git a/include/linux/greybus.h b/include/linux/greybus.h
index 18c0fb958b74..f73a7996c137 100644
--- a/include/linux/greybus.h
+++ b/include/linux/greybus.h
@@ -11,7 +11,6 @@
 
 #ifdef __KERNEL__
 
-#include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/list.h>
 #include <linux/slab.h>
diff --git a/include/linux/hashtable.h b/include/linux/hashtable.h
index f6c666730b8c..47fc50c72463 100644
--- a/include/linux/hashtable.h
+++ b/include/linux/hashtable.h
@@ -9,7 +9,6 @@
 
 #include <linux/list.h>
 #include <linux/types.h>
-#include <linux/kernel.h>
 #include <linux/hash.h>
 #include <linux/rculist.h>
 
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 00341b56d291..a63be916fe3b 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -3,7 +3,6 @@
 #define _LINUX_HIGHMEM_H
 
 #include <linux/fs.h>
-#include <linux/kernel.h>
 #include <linux/bug.h>
 #include <linux/cacheflush.h>
 #include <linux/kmsan.h>
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index e3a0f2c22a75..9883e30a6130 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -3,7 +3,6 @@
 #ifndef _LINUX_INTERRUPT_H
 #define _LINUX_INTERRUPT_H
 
-#include <linux/kernel.h>
 #include <linux/bitops.h>
 #include <linux/cpumask.h>
 #include <linux/irqreturn.h>
diff --git a/include/linux/iova.h b/include/linux/iova.h
index ee656a0490ed..efd0c192e8cc 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -10,7 +10,6 @@
 #define _IOVA_H_
 
 #include <linux/types.h>
-#include <linux/kernel.h>
 #include <linux/rbtree_types.h>
 #include <linux/dma-mapping.h>
 
diff --git a/include/linux/isa.h b/include/linux/isa.h
index 4fbbf5e36e08..7c61e9396e5b 100644
--- a/include/linux/isa.h
+++ b/include/linux/isa.h
@@ -8,7 +8,6 @@
 
 #include <linux/device.h>
 #include <linux/errno.h>
-#include <linux/kernel.h>
 
 struct isa_driver {
 	int (*match)(struct device *, unsigned int);
diff --git a/include/linux/isdn/capilli.h b/include/linux/isdn/capilli.h
index 12be09b6883b..758e01e6cfbf 100644
--- a/include/linux/isdn/capilli.h
+++ b/include/linux/isdn/capilli.h
@@ -12,7 +12,6 @@
 #ifndef __CAPILLI_H__
 #define __CAPILLI_H__
 
-#include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/capi.h>
 #include <linux/kernelcapi.h>
diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index c3f075e8f60c..0eafffc64a53 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -8,7 +8,6 @@
 
 #include <linux/errno.h>
 #include <linux/buildid.h>
-#include <linux/kernel.h>
 #include <linux/stddef.h>
 #include <linux/mm.h>
 #include <linux/module.h>
diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index dbb06d789e74..7d60e6c1d29c 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -5,7 +5,6 @@
 #include <linux/bug.h>
 #include <linux/kasan-enabled.h>
 #include <linux/kasan-tags.h>
-#include <linux/kernel.h>
 #include <linux/static_key.h>
 #include <linux/types.h>
 
diff --git a/include/linux/kfifo.h b/include/linux/kfifo.h
index 0b35a41440ff..17fea09984fe 100644
--- a/include/linux/kfifo.h
+++ b/include/linux/kfifo.h
@@ -36,7 +36,6 @@
  * to lock the reader.
  */
 
-#include <linux/kernel.h>
 #include <linux/spinlock.h>
 #include <linux/stddef.h>
 #include <linux/scatterlist.h>
diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
index 04be45d6a9ab..ff4ddab84495 100644
--- a/include/linux/libnvdimm.h
+++ b/include/linux/libnvdimm.h
@@ -6,7 +6,7 @@
  */
 #ifndef __LIBNVDIMM_H__
 #define __LIBNVDIMM_H__
-#include <linux/kernel.h>
+
 #include <linux/sizes.h>
 #include <linux/types.h>
 #include <linux/uuid.h>
diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
index bd1ae08af2aa..5b1e1ffaad77 100644
--- a/include/linux/lsm_audit.h
+++ b/include/linux/lsm_audit.h
@@ -13,7 +13,6 @@
 
 #include <linux/stddef.h>
 #include <linux/errno.h>
-#include <linux/kernel.h>
 #include <linux/kdev_t.h>
 #include <linux/init.h>
 #include <linux/audit.h>
diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index 7f5dd33f4b94..7e52ed3fd219 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -10,7 +10,6 @@
 
 #include <linux/maple_tree_types.h>
 
-#include <linux/kernel.h>
 #include <linux/rcupdate.h>
 #include <linux/spinlock.h>
 /* #define CONFIG_MAPLE_RCU_DISABLED */
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 566566b0ae64..c2d33150b093 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -14,7 +14,6 @@
 #include <linux/vm_event_item.h>
 #include <linux/hardirq.h>
 #include <linux/jump_label.h>
-#include <linux/kernel.h>
 #include <linux/page_counter.h>
 #include <linux/vmpressure.h>
 #include <linux/eventfd.h>
diff --git a/include/linux/mfd/davinci_voicecodec.h b/include/linux/mfd/davinci_voicecodec.h
index 556375b91316..725c8730f34a 100644
--- a/include/linux/mfd/davinci_voicecodec.h
+++ b/include/linux/mfd/davinci_voicecodec.h
@@ -10,7 +10,6 @@
 #ifndef __LINUX_MFD_DAVINCI_VOICECODEC_H_
 #define __LINUX_MFD_DAVINCI_VOICECODEC_H_
 
-#include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/mfd/core.h>
 #include <linux/platform_data/edma.h>
diff --git a/include/linux/mfd/madera/pdata.h b/include/linux/mfd/madera/pdata.h
index 32e3470708ed..7d7b216b2490 100644
--- a/include/linux/mfd/madera/pdata.h
+++ b/include/linux/mfd/madera/pdata.h
@@ -8,7 +8,6 @@
 #ifndef MADERA_PDATA_H
 #define MADERA_PDATA_H
 
-#include <linux/kernel.h>
 #include <linux/regulator/arizona-ldo1.h>
 #include <linux/regulator/arizona-micsupp.h>
 #include <linux/regulator/machine.h>
diff --git a/include/linux/mfd/wm8350/core.h b/include/linux/mfd/wm8350/core.h
index 25379c7f94c4..90002375b2cd 100644
--- a/include/linux/mfd/wm8350/core.h
+++ b/include/linux/mfd/wm8350/core.h
@@ -8,7 +8,6 @@
 #ifndef __LINUX_MFD_WM8350_CORE_H_
 #define __LINUX_MFD_WM8350_CORE_H_
 
-#include <linux/kernel.h>
 #include <linux/mutex_types.h>
 #include <linux/interrupt.h>
 #include <linux/completion_types.h>
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 07956bd2e55b..80f4fa5568d2 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -33,7 +33,6 @@
 #ifndef MLX5_DRIVER_H
 #define MLX5_DRIVER_H
 
-#include <linux/kernel.h>
 #include <linux/completion_types.h>
 #include <linux/pci.h>
 #include <linux/irq.h>
diff --git a/include/linux/mtd/map.h b/include/linux/mtd/map.h
index b4fa92a6e44b..97bd6007a6f8 100644
--- a/include/linux/mtd/map.h
+++ b/include/linux/mtd/map.h
@@ -12,7 +12,6 @@
 #include <linux/list.h>
 #include <linux/string.h>
 #include <linux/bug.h>
-#include <linux/kernel.h>
 #include <linux/io.h>
 
 #include <asm/unaligned.h>
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 74e0cc14ebf8..c4b71e99f414 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -3,7 +3,6 @@
 #define _LINUX_NAMEI_H
 
 #include <linux/fs.h>
-#include <linux/kernel.h>
 #include <linux/path.h>
 #include <linux/fcntl.h>
 #include <linux/errno.h>
diff --git a/include/linux/net/intel/iidc.h b/include/linux/net/intel/iidc.h
index 1c1332e4df26..5424c9069ed7 100644
--- a/include/linux/net/intel/iidc.h
+++ b/include/linux/net/intel/iidc.h
@@ -8,7 +8,6 @@
 #include <linux/dcbnl.h>
 #include <linux/device.h>
 #include <linux/if_ether.h>
-#include <linux/kernel.h>
 #include <linux/netdevice.h>
 
 enum iidc_event_type {
diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
index 3a4860bd2758..b987d0ba1262 100644
--- a/include/linux/pci-ecam.h
+++ b/include/linux/pci-ecam.h
@@ -6,7 +6,6 @@
 #define DRIVERS_PCI_ECAM_H
 
 #include <linux/pci.h>
-#include <linux/kernel.h>
 #include <linux/platform_device.h>
 
 /*
diff --git a/include/linux/peci.h b/include/linux/peci.h
index 39d455231e21..a750b9d65dba 100644
--- a/include/linux/peci.h
+++ b/include/linux/peci.h
@@ -5,7 +5,6 @@
 #define __LINUX_PECI_H
 
 #include <linux/device_types.h>
-#include <linux/kernel.h>
 #include <linux/mutex_types.h>
 #include <linux/types.h>
 
diff --git a/include/linux/profile.h b/include/linux/profile.h
index 11db1ec516e2..8b417675054e 100644
--- a/include/linux/profile.h
+++ b/include/linux/profile.h
@@ -2,7 +2,6 @@
 #ifndef _LINUX_PROFILE_H
 #define _LINUX_PROFILE_H
 
-#include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/cpumask.h>
 #include <linux/cache.h>
diff --git a/include/linux/qed/qed_chain.h b/include/linux/qed/qed_chain.h
index a84063492c71..40c168c83816 100644
--- a/include/linux/qed/qed_chain.h
+++ b/include/linux/qed/qed_chain.h
@@ -9,7 +9,6 @@
 
 #include <linux/types.h>
 #include <asm/byteorder.h>
-#include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
diff --git a/include/linux/qed/qed_if.h b/include/linux/qed/qed_if.h
index 6dc4943d8aec..be88819ec6ac 100644
--- a/include/linux/qed/qed_if.h
+++ b/include/linux/qed/qed_if.h
@@ -16,7 +16,6 @@
 #include <asm/byteorder.h>
 #include <linux/io.h>
 #include <linux/compiler.h>
-#include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/slab.h>
 #include <linux/qed/common_hsi.h>
diff --git a/include/linux/qed/qed_ll2_if.h b/include/linux/qed/qed_ll2_if.h
index 5b67cd03276e..fa53d7831240 100644
--- a/include/linux/qed/qed_ll2_if.h
+++ b/include/linux/qed/qed_ll2_if.h
@@ -12,7 +12,6 @@
 #include <linux/netdevice.h>
 #include <linux/pci.h>
 #include <linux/skbuff.h>
-#include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/qed/qed_if.h>
 
diff --git a/include/linux/randomize_kstack.h b/include/linux/randomize_kstack.h
index 5d868505a94e..154d30fdd392 100644
--- a/include/linux/randomize_kstack.h
+++ b/include/linux/randomize_kstack.h
@@ -3,7 +3,6 @@
 #define _LINUX_RANDOMIZE_KSTACK_H
 
 #ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
-#include <linux/kernel.h>
 #include <linux/jump_label.h>
 #include <linux/percpu-defs.h>
 
diff --git a/include/linux/regulator/coupler.h b/include/linux/regulator/coupler.h
index 7f37ce155330..cdc0833ed31d 100644
--- a/include/linux/regulator/coupler.h
+++ b/include/linux/regulator/coupler.h
@@ -9,7 +9,6 @@
 #define __LINUX_REGULATOR_COUPLER_H_
 
 #include <linux/errno.h>
-#include <linux/kernel.h>
 #include <linux/suspend.h>
 
 struct regulator_coupler;
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index c62f0be16fa2..32cd56aa1284 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -2,7 +2,6 @@
 #ifndef _RESCTRL_H
 #define _RESCTRL_H
 
-#include <linux/kernel.h>
 #include <linux/list.h>
 
 #ifdef CONFIG_PROC_CPU_RESCTRL
diff --git a/include/linux/rfkill.h b/include/linux/rfkill.h
index 0e8d11410f9f..61497bd04956 100644
--- a/include/linux/rfkill.h
+++ b/include/linux/rfkill.h
@@ -30,7 +30,6 @@ enum rfkill_user_states {
 #undef RFKILL_STATE_UNBLOCKED
 #undef RFKILL_STATE_HARD_BLOCKED
 
-#include <linux/kernel.h>
 #include <linux/leds.h>
 #include <linux/err.h>
 
diff --git a/include/linux/rmi.h b/include/linux/rmi.h
index ab7eea01ab42..9bd3aadad055 100644
--- a/include/linux/rmi.h
+++ b/include/linux/rmi.h
@@ -6,7 +6,6 @@
 
 #ifndef _RMI_H
 #define _RMI_H
-#include <linux/kernel.h>
 #include <linux/device.h>
 #include <linux/interrupt.h>
 #include <linux/input.h>
diff --git a/include/linux/sed-opal-key.h b/include/linux/sed-opal-key.h
index 0ca03054e8f6..00f6e5fbd659 100644
--- a/include/linux/sed-opal-key.h
+++ b/include/linux/sed-opal-key.h
@@ -9,7 +9,7 @@
  *
  */
 
-#include <linux/kernel.h>
+#include <linux/types.h>
 
 #ifdef CONFIG_PSERIES_PLPKS_SED
 int sed_read_key(char *keyname, char *key, u_int *keylen);
diff --git a/include/linux/siphash.h b/include/linux/siphash.h
index e516ddfc3daf..6b5e06a6fac4 100644
--- a/include/linux/siphash.h
+++ b/include/linux/siphash.h
@@ -14,7 +14,6 @@
 
 #include <linux/align.h>
 #include <linux/types.h>
-#include <linux/kernel.h>
 #include <uapi/asm/byteorder.h> // for le32_to_cpup(), le64_to_cpu()
 
 #define SIPHASH_ALIGNMENT __alignof__(u64)
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 8ee67e49699b..fc59f80eb169 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -10,7 +10,6 @@
 #ifndef _LINUX_SKBUFF_H
 #define _LINUX_SKBUFF_H
 
-#include <linux/kernel.h>
 #include <linux/compiler.h>
 #include <linux/time.h>
 #include <linux/bug.h>
diff --git a/include/linux/soc/amlogic/meson-canvas.h b/include/linux/soc/amlogic/meson-canvas.h
index 0cb2a6050d1f..eaa0f777ce3a 100644
--- a/include/linux/soc/amlogic/meson-canvas.h
+++ b/include/linux/soc/amlogic/meson-canvas.h
@@ -5,7 +5,7 @@
 #ifndef __SOC_MESON_CANVAS_H
 #define __SOC_MESON_CANVAS_H
 
-#include <linux/kernel.h>
+#include <linux/types.h>
 
 #define MESON_CANVAS_WRAP_NONE	0x00
 #define MESON_CANVAS_WRAP_X	0x01
diff --git a/include/linux/soc/ixp4xx/npe.h b/include/linux/soc/ixp4xx/npe.h
index 9efeac777da1..d734f06fe5ff 100644
--- a/include/linux/soc/ixp4xx/npe.h
+++ b/include/linux/soc/ixp4xx/npe.h
@@ -2,7 +2,6 @@
 #ifndef __IXP4XX_NPE_H
 #define __IXP4XX_NPE_H
 
-#include <linux/kernel.h>
 #include <linux/regmap.h>
 
 extern const char *npe_names[];
diff --git a/include/linux/soc/ixp4xx/qmgr.h b/include/linux/soc/ixp4xx/qmgr.h
index 2c0f433a3841..a51948a82eff 100644
--- a/include/linux/soc/ixp4xx/qmgr.h
+++ b/include/linux/soc/ixp4xx/qmgr.h
@@ -7,7 +7,6 @@
 #define IXP4XX_QMGR_H
 
 #include <linux/io.h>
-#include <linux/kernel.h>
 
 #define DEBUG_QMGR	0
 
diff --git a/include/linux/soc/mediatek/mtk_wed.h b/include/linux/soc/mediatek/mtk_wed.h
index a476648858a6..c8474a65e474 100644
--- a/include/linux/soc/mediatek/mtk_wed.h
+++ b/include/linux/soc/mediatek/mtk_wed.h
@@ -1,7 +1,6 @@
 #ifndef __MTK_WED_H
 #define __MTK_WED_H
 
-#include <linux/kernel.h>
 #include <linux/rcupdate.h>
 #include <linux/regmap.h>
 #include <linux/pci.h>
diff --git a/include/linux/sysfb.h b/include/linux/sysfb.h
index 19cb803dd5ec..c21885316349 100644
--- a/include/linux/sysfb.h
+++ b/include/linux/sysfb.h
@@ -7,7 +7,6 @@
  * Copyright (c) 2012-2013 David Herrmann <dh.herrmann@gmail.com>
  */
 
-#include <linux/kernel.h>
 #include <linux/platform_data/simplefb.h>
 
 struct screen_info;
diff --git a/include/linux/textsearch.h b/include/linux/textsearch.h
index 6673e4d4ac2e..b5f8fe9c9ac5 100644
--- a/include/linux/textsearch.h
+++ b/include/linux/textsearch.h
@@ -4,7 +4,6 @@
 
 #include <linux/types.h>
 #include <linux/list.h>
-#include <linux/kernel.h>
 #include <linux/err.h>
 #include <linux/slab.h>
 
diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
index 5fe5f786ad96..2f5ba98c2640 100644
--- a/include/linux/usb/pd.h
+++ b/include/linux/usb/pd.h
@@ -7,7 +7,6 @@
 #define __LINUX_USB_PD_H
 
 #include <uapi/asm/byteorder.h> // for __le16
-#include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/usb/typec.h>
 
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index db15ac07f8a6..ba3e6aae8bb7 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -2,7 +2,6 @@
 #ifndef _LINUX_VDPA_H
 #define _LINUX_VDPA_H
 
-#include <linux/kernel.h>
 #include <linux/device.h>
 #include <linux/interrupt.h>
 #include <linux/vhost_iotlb.h>
diff --git a/include/linux/videodev2.h b/include/linux/videodev2.h
index 219037f4c08d..16c0ed6c50a7 100644
--- a/include/linux/videodev2.h
+++ b/include/linux/videodev2.h
@@ -57,7 +57,6 @@
 #define __LINUX_VIDEODEV2_H
 
 #include <linux/time.h>     /* need struct timeval */
-#include <linux/kernel.h>
 #include <uapi/linux/videodev2.h>
 
 #endif /* __LINUX_VIDEODEV2_H */
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 99660197a36c..4aeb3704c348 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -13,7 +13,6 @@
 #include <linux/bitops.h>
 #include <linux/cdev.h>
 #include <linux/device.h>
-#include <linux/kernel.h>
 #include <linux/notifier.h>
 #include <uapi/linux/watchdog.h>
 
diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index ff1e63ec4865..2ecb2ee42cd4 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -14,7 +14,6 @@
 #include <linux/bug.h>
 #include <linux/compiler.h>
 #include <linux/kconfig.h>
-#include <linux/kernel.h>
 #include <linux/math.h> // for DIV_ROUND_UP()
 #include <linux/rcupdate.h>
 #include <linux/sched/mm.h>
diff --git a/include/linux/zutil.h b/include/linux/zutil.h
index 663689521759..a63c8eb8294d 100644
--- a/include/linux/zutil.h
+++ b/include/linux/zutil.h
@@ -15,7 +15,6 @@
 
 #include <linux/zlib.h>
 #include <linux/string.h>
-#include <linux/kernel.h>
 
 typedef unsigned char  uch;
 typedef unsigned short ush;
diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 7eca98931e25..2737d8fb7133 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -8,7 +8,6 @@
 #ifndef __AF_VSOCK_H__
 #define __AF_VSOCK_H__
 
-#include <linux/kernel.h>
 #include <linux/workqueue_types.h>
 #include <net/sock.h>
 #include <uapi/linux/vm_sockets.h>
diff --git a/include/net/caif/caif_device.h b/include/net/caif/caif_device.h
index 91d1fd5b44a4..f40be65cebae 100644
--- a/include/net/caif/caif_device.h
+++ b/include/net/caif/caif_device.h
@@ -6,7 +6,6 @@
 
 #ifndef CAIF_DEVICE_H_
 #define CAIF_DEVICE_H_
-#include <linux/kernel.h>
 #include <linux/net.h>
 #include <linux/netdevice.h>
 #include <linux/caif/caif_socket.h>
diff --git a/include/net/flow_offload.h b/include/net/flow_offload.h
index 314087a5e181..1e56da4fb2b4 100644
--- a/include/net/flow_offload.h
+++ b/include/net/flow_offload.h
@@ -1,7 +1,6 @@
 #ifndef _NET_FLOW_OFFLOAD_H
 #define _NET_FLOW_OFFLOAD_H
 
-#include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/netlink.h>
 #include <net/flow_dissector.h>
diff --git a/include/net/ieee80211_radiotap.h b/include/net/ieee80211_radiotap.h
index 925bac726a92..8b0a19ef2652 100644
--- a/include/net/ieee80211_radiotap.h
+++ b/include/net/ieee80211_radiotap.h
@@ -17,7 +17,6 @@
 #ifndef __RADIOTAP_H
 #define __RADIOTAP_H
 
-#include <linux/kernel.h>
 #include <asm/unaligned.h>
 
 /**
diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index 4e62121e1cb6..9568878dd6bc 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -15,7 +15,6 @@
 #include <linux/string.h>
 #include <linux/timer_types.h>
 #include <linux/poll.h>
-#include <linux/kernel.h>
 #include <linux/sockptr.h>
 
 #include <net/inet_sock.h>
diff --git a/include/net/ipv6_frag.h b/include/net/ipv6_frag.h
index 7321ffe3a108..a593919e9d83 100644
--- a/include/net/ipv6_frag.h
+++ b/include/net/ipv6_frag.h
@@ -2,7 +2,6 @@
 #ifndef _IPV6_FRAG_H
 #define _IPV6_FRAG_H
 #include <linux/icmpv6.h>
-#include <linux/kernel.h>
 #include <net/addrconf.h>
 #include <net/ipv6.h>
 #include <net/inet_frag.h>
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 45d905b17a65..8213a2a0afab 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -14,7 +14,6 @@
 #define MAC80211_H
 
 #include <linux/bug.h>
-#include <linux/kernel.h>
 #include <linux/if_ether.h>
 #include <linux/skbuff.h>
 #include <linux/ieee80211.h>
diff --git a/include/net/sock.h b/include/net/sock.h
index 008a6c5a3bfc..4377a8ebc251 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -36,7 +36,6 @@
 #define _SOCK_H
 
 #include <linux/hardirq.h>
-#include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/list_nulls.h>
 #include <linux/timer_types.h>
diff --git a/include/rdma/iba.h b/include/rdma/iba.h
index 6a1115b02a0d..bcea705a36ea 100644
--- a/include/rdma/iba.h
+++ b/include/rdma/iba.h
@@ -5,7 +5,6 @@
 #ifndef _IBA_DEFS_H_
 #define _IBA_DEFS_H_
 
-#include <linux/kernel.h>
 #include <linux/bitfield.h>
 #include <asm/unaligned.h>
 
diff --git a/include/rdma/uverbs_types.h b/include/rdma/uverbs_types.h
index 8744e75220a3..87566478032d 100644
--- a/include/rdma/uverbs_types.h
+++ b/include/rdma/uverbs_types.h
@@ -6,7 +6,6 @@
 #ifndef _UVERBS_TYPES_
 #define _UVERBS_TYPES_
 
-#include <linux/kernel.h>
 #include <linux/kref.h>
 #include <rdma/ib_verbs.h>
 
diff --git a/include/scsi/scsi.h b/include/scsi/scsi.h
index 4498f845b112..3eadcf14b7f7 100644
--- a/include/scsi/scsi.h
+++ b/include/scsi/scsi.h
@@ -8,7 +8,6 @@
 
 #include <linux/types.h>
 #include <linux/scatterlist.h>
-#include <linux/kernel.h>
 #include <scsi/scsi_common.h>
 #include <scsi/scsi_proto.h>
 #include <scsi/scsi_status.h>
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 0021d54625da..72f7b3372014 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -17,7 +17,6 @@
 #include <linux/notifier.h>
 #include <linux/workqueue_types.h>
 #include <linux/interrupt.h>
-#include <linux/kernel.h>
 #include <linux/regmap.h>
 #include <linux/log2.h>
 #include <sound/core.h>
diff --git a/include/xen/grant_table.h b/include/xen/grant_table.h
index e279be353e3f..b4e0506262e6 100644
--- a/include/xen/grant_table.h
+++ b/include/xen/grant_table.h
@@ -48,7 +48,6 @@
 #include <xen/page.h>
 #include <linux/mm_types.h>
 #include <linux/page-flags.h>
-#include <linux/kernel.h>
 
 /*
  * Technically there's no reliably invalid grant reference or grant handle,
diff --git a/include/xen/xen-front-pgdir-shbuf.h b/include/xen/xen-front-pgdir-shbuf.h
index 150ef7ec51ec..27ceb1c1920f 100644
--- a/include/xen/xen-front-pgdir-shbuf.h
+++ b/include/xen/xen-front-pgdir-shbuf.h
@@ -12,8 +12,6 @@
 #ifndef __XEN_FRONT_PGDIR_SHBUF_H_
 #define __XEN_FRONT_PGDIR_SHBUF_H_
 
-#include <linux/kernel.h>
-
 #include <xen/grant_table.h>
 
 struct xen_front_pgdir_shbuf_ops;
-- 
2.39.2


