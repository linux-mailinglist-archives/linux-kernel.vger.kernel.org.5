Return-Path: <linux-kernel+bounces-66554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD37855E69
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28F95B23C5C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC98317745;
	Thu, 15 Feb 2024 09:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Sck4AG5c"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF1B1755E
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 09:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989820; cv=none; b=Un3/HSm2HtJ/gNfKvC44T8F2bf+LXJob8CMWwNJ0FjQVoG1UbVGZbDCdluGUxISXtO15AFrRM2qnav2eDf5SmKUEzaS4lVbluyqVNn6qhNICqH/kf087Lgx9F+juihbpKxFGelj/JELzazJx6t5Oo1MPHFa/G9KTDSeDnnG+wTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989820; c=relaxed/simple;
	bh=2rROApjeULcWm5YZtvXRyCJkPvF/dmaTKpH9lduEtuM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oMCQKCjpfMSC3NyoidXyK2wn8o8AIzBwnb4npsRXnFm0u3JtwredeowAzfEWa8r4vAVh9X1j6HuiGLCfBZwB3uQ3sO8ucergygsjyt/r9bYJDVooOs6D6fj8zXxMRAel50Ls4FYISZ16oyLgUwRqX0YK7mafJFrL8Cq1i0F9dns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Sck4AG5c; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a26f73732c5so80765266b.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 01:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707989815; x=1708594615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4mhB0ezCOBSXBZ2GLWIr8E8PDduAjFjCZEKH4zIQhuc=;
        b=Sck4AG5cK8Rypc0jG6Xh8q9gXtMgZDTLTPzyEOAoPX0LYo7FLwhOgMk0W+CZaVKD9T
         6Mj7femXkrA/4EvGBvNvzAAP5nN8NhCWwaY96UPnaS+hQj67xE8vgJlDAE45LqvahW/U
         TaDRTpJFylHOANUTe8Lte/idmEGz2mRruIvsVroVAUG/LPT9aLgWpfAl52a9n3OgGk9f
         1OygQjiPxeYI07FreQbTOzAk06MwL7yrKPNQ01oPClQHFnnXnocKfJ8i+CLIORsmrSq5
         2z6ktMHm7MCWS/oGo+tZgpLTeAe8fo4NmoeEZHHfcmIjZQGc5sIgF85vSqG62tcsL28N
         AwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707989815; x=1708594615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4mhB0ezCOBSXBZ2GLWIr8E8PDduAjFjCZEKH4zIQhuc=;
        b=YYNXFLVWOHXmiXGjogG32d7wjGBPCG1NHUUxYqYbIQoVqSIqYAYbIZJV11C88n2C24
         EXkwOH/RTXivZXBWSnwOs/fRxXwk2dqVhVO7VMcV9g0koH45dhc6b+8BTfPoWiNNW+tU
         sXvFpb5wGWX7F37DVhseJV4DxQ1fxopy2IavppeClFyqwl4WjuNq/EEMwwSgOHYGZiU6
         WoNri3Lx2MlaGXrDo8OIJRc/eLEcOYGdrrWzf1cBVeN6LtNJXbN3slKAbc7oBwP2Deis
         xDnasWlSACgu0SJacbZtsQQc8EN8IcrgJHGYzV16sKmbHfNa3WuNxzF7ZBHAhARRTcfh
         Zgfg==
X-Gm-Message-State: AOJu0YywpXDz+jryf8BJQGukdZVcZsd4lBkpZiwdvb4/vsToCi7j+YVr
	tmrZ1D9+rrGueF2fGffOApho7x7CcQQ70MBQ5mAtQrFDoYyOio3Y00gfkRi+wjMBkG8HxQ5kVOu
	0
X-Google-Smtp-Source: AGHT+IElyxp0WqitR5EToNjrVTh8K9nBVJxo7w7ff05naiPfgRzUrXLnerr98VUEir4Gypl0TVHBpQ==
X-Received: by 2002:a17:906:e246:b0:a38:89df:6142 with SMTP id gq6-20020a170906e24600b00a3889df6142mr850617ejb.24.1707989815123;
        Thu, 15 Feb 2024 01:36:55 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id rg14-20020a1709076b8e00b00a3d09d09e90sm362059ejc.59.2024.02.15.01.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 01:36:54 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v1 0/8] Fast kernel headers: split linux/kernel.h
Date: Thu, 15 Feb 2024 10:36:38 +0100
Message-Id: <20240215093646.3265823-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set aims to clean up the linux/kernel.h header and reduce
dependencies on it by moving parts out.

(These patches were part of my previous "fast kernel headers" pull
request which was found hard to review due to its huge size.  I'm now
trying to resend smaller chunks of it, hoping they are easier to
review.)

Max Kellermann (8):
  include/linux/goldfish.h: include linux/wordpart.h instead of
    linux/kernel.h
  include/drm/drm_fixed.h: include linux/wordpart.h instead of
    linux/kernel.h
  include linux/wordpart.h in various sources that need it
  linux/random.h: reduce dependencies on linux/kernel.h
  linux/kernel.h: move might_sleep(), ... to sched/debug_atomic_sleep.h
  linux/kernel.h: move READ and WRITE to direction.h
  linux/kernel.h: move VERIFY_OCTAL_PERMISSIONS() to octal_permissions.h
  linux/kernel.h: move PTR_IF() to ptr_util.h

 arch/arc/kernel/perf_event.c             |   1 +
 arch/arm64/include/asm/syscall.h         |   1 +
 arch/arm64/kvm/handle_exit.c             |   1 +
 drivers/bus/uniphier-system-bus.c        |   1 +
 drivers/edac/thunderx_edac.c             |   1 +
 drivers/gpio/gpio-sim.c                  |   1 +
 drivers/gpu/drm/i915/i915_driver.c       |   1 +
 drivers/hwmon/occ/common.c               |   1 +
 drivers/input/misc/iqs7222.c             |   1 +
 drivers/irqchip/irq-gic-v3-its.c         |   1 +
 drivers/media/platform/amphion/vpu_dbg.c |   1 +
 drivers/memstick/core/memstick.c         |   1 +
 drivers/memstick/host/jmb38x_ms.c        |   1 +
 drivers/memstick/host/r592.c             |   1 +
 drivers/memstick/host/rtsx_pci_ms.c      |   1 +
 drivers/memstick/host/rtsx_usb_ms.c      |   1 +
 drivers/memstick/host/tifm_ms.c          |   1 +
 drivers/pinctrl/pinctrl-ingenic.c        |   1 +
 drivers/soc/aspeed/aspeed-uart-routing.c |   1 +
 drivers/spi/spi-pci1xxxx.c               |   1 +
 fs/ext4/super.c                          |   1 +
 fs/hfs/hfs_fs.h                          |   1 +
 fs/hfsplus/hfsplus_fs.h                  |   1 +
 fs/notify/fanotify/fanotify_user.c       |   1 +
 fs/open.c                                |   1 +
 fs/overlayfs/copy_up.c                   |   1 +
 fs/ufs/util.h                            |   1 +
 fs/xfs/xfs_error.c                       |   1 +
 include/drm/drm_fixed.h                  |   2 +-
 include/linux/clk.h                      |   1 +
 include/linux/direction.h                |   9 ++
 include/linux/dma-fence.h                |   1 +
 include/linux/goldfish.h                 |   2 +-
 include/linux/gpio/consumer.h            |   2 +-
 include/linux/kernel.h                   | 125 -----------------------
 include/linux/mmu_notifier.h             |   1 +
 include/linux/moduleparam.h              |   2 +-
 include/linux/nd.h                       |   1 +
 include/linux/octal_permissions.h        |  20 ++++
 include/linux/pm.h                       |   1 +
 include/linux/ptr_util.h                 |   7 ++
 include/linux/pwm.h                      |   2 +
 include/linux/qed/common_hsi.h           |   1 +
 include/linux/random.h                   |   4 +-
 include/linux/rcutiny.h                  |   1 +
 include/linux/sched.h                    |   1 +
 include/linux/sched/debug_atomic_sleep.h | 114 +++++++++++++++++++++
 include/linux/sched/mm.h                 |   2 +-
 include/linux/sysfs.h                    |   1 +
 include/linux/uaccess.h                  |   1 +
 include/linux/uio.h                      |   2 +-
 include/linux/wait.h                     |   1 +
 include/linux/wait_bit.h                 |   1 +
 include/rdma/uverbs_ioctl.h              |   3 +-
 include/soc/fsl/bman.h                   |   2 +
 include/soc/fsl/qman.h                   |   1 +
 security/landlock/object.c               |   1 +
 security/landlock/ruleset.c              |   1 +
 58 files changed, 207 insertions(+), 134 deletions(-)
 create mode 100644 include/linux/direction.h
 create mode 100644 include/linux/octal_permissions.h
 create mode 100644 include/linux/ptr_util.h
 create mode 100644 include/linux/sched/debug_atomic_sleep.h

-- 
2.39.2


