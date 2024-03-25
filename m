Return-Path: <linux-kernel+bounces-117335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE8F88AA21
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 744552E45BF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F6C12E1E4;
	Mon, 25 Mar 2024 15:11:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636C31862F;
	Mon, 25 Mar 2024 15:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711379496; cv=none; b=a31PTBinPE6ekckPowpOM26zyenD/oSSnjZow223JEF9/9xdtqKdq8p9uuMsLOECVIc47w0SrbfwETqK5Jm3/AmCxGdPl2BQtdVa3qV2sKcbw/GgBsPXYNfxKZo6O47PW3Dt5LkHr79i0adwD1mPeozX+gqKZqQU4AeCYSFf2vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711379496; c=relaxed/simple;
	bh=fr2x0BAMneq+tJXva7/PG/No5Nob24fkfZAHKEqAKF4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s7cPfY3gHueHMS+w2ZR2oZLdkuqW5I0KO3QKsu8Ojpi3aQEnwzGcBrReFGmD+XazXkdNa7iihzq8dIy3B1BTXvf2uoXkRUr3Dz65rCwWFSHvdeYqjSw2JS+lMtkGTPgEgBmMb+mmMglyeiFiuiNqHvIm9zDKguukAbNawwgRyKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 619CF2F4;
	Mon, 25 Mar 2024 08:12:07 -0700 (PDT)
Received: from mango.localdomain (unknown [10.57.15.164])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 961A33F64C;
	Mon, 25 Mar 2024 08:11:31 -0700 (PDT)
From: Balint Dobszay <balint.dobszay@arm.com>
To: op-tee@lists.trustedfirmware.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: jens.wiklander@linaro.org,
	sumit.garg@linaro.org,
	corbet@lwn.net,
	balint.dobszay@arm.com,
	sudeep.holla@arm.com,
	rdunlap@infradead.org,
	krzk@kernel.org,
	gyorgy.szing@arm.com
Subject: [PATCH v4 0/5] TEE driver for Trusted Services
Date: Mon, 25 Mar 2024 16:11:00 +0100
Message-Id: <20240325151105.135667-1-balint.dobszay@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces a TEE driver for Trusted Services [1].

Trusted Services is a TrustedFirmware.org project that provides a
framework for developing and deploying device Root of Trust services in
FF-A [2] Secure Partitions. The project hosts the reference
implementation of Arm Platform Security Architecture [3] for Arm
A-profile devices.

The FF-A Secure Partitions are accessible through the FF-A driver in
Linux. However, the FF-A driver doesn't have a user space interface so
user space clients currently cannot access Trusted Services. The goal of
this TEE driver is to bridge this gap and make Trusted Services
functionality accessible from user space.

Changelog:
v3[7] -> v4:
  - Remove unnecessary callbacks from tstee_ops
  - Add maintainers entry for the new driver

v2[6] -> v3:
  - Add patch "tee: Refactor TEE subsystem header files" from Sumit
  - Remove unnecessary includes from core.c
  - Remove the mutex from "struct ts_context_data" since the same
    mechanism could be implemented by reusing the XArray's internal lock
  - Rename tee_shm_pool_op_*_helper functions as suggested by Sumit
  - Replace pr_* with dev_* as previously suggested by Krzysztof

v1[5] -> v2:
  - Refactor session handling to use XArray instead of IDR and linked
    list (the linked list was redundant as pointed out by Jens, and IDR
    is now deprecated in favor of XArray)
  - Refactor tstee_probe() to not call tee_device_unregister() before
    calling tee_device_register()
  - Address comments from Krzysztof and Jens
  - Address documentation comments from Randy
  - Use module_ffa_driver() macro instead of separate module init / exit
    functions
  - Reformat max line length 100 -> 80

RFC[4] -> v1:
  - Add patch for moving pool_op helper functions to the TEE subsystem,
    as suggested by Jens
  - Address comments from Sumit, add patch for documentation

[1] https://www.trustedfirmware.org/projects/trusted-services/
[2] https://developer.arm.com/documentation/den0077/
[3] https://www.arm.com/architecture/security-features/platform-security
[4] https://lore.kernel.org/linux-arm-kernel/20230927152145.111777-1-balint.dobszay@arm.com/
[5] https://lore.kernel.org/lkml/20240213145239.379875-1-balint.dobszay@arm.com/
[6] https://lore.kernel.org/lkml/20240223095133.109046-1-balint.dobszay@arm.com/
[7] https://lore.kernel.org/lkml/20240305101745.213933-1-balint.dobszay@arm.com/


Balint Dobszay (4):
  tee: optee: Move pool_op helper functions
  tee: tstee: Add Trusted Services TEE driver
  Documentation: tee: Add TS-TEE driver
  MAINTAINERS: tee: tstee: Add entry

Sumit Garg (1):
  tee: Refactor TEE subsystem header files

 Documentation/tee/index.rst         |   1 +
 Documentation/tee/ts-tee.rst        |  71 ++++
 MAINTAINERS                         |  10 +
 drivers/tee/Kconfig                 |   1 +
 drivers/tee/Makefile                |   1 +
 drivers/tee/amdtee/amdtee_private.h |   2 +-
 drivers/tee/amdtee/call.c           |   2 +-
 drivers/tee/amdtee/core.c           |   3 +-
 drivers/tee/amdtee/shm_pool.c       |   2 +-
 drivers/tee/optee/call.c            |   2 +-
 drivers/tee/optee/core.c            |  66 +---
 drivers/tee/optee/device.c          |   2 +-
 drivers/tee/optee/ffa_abi.c         |   8 +-
 drivers/tee/optee/notif.c           |   2 +-
 drivers/tee/optee/optee_private.h   |  14 +-
 drivers/tee/optee/rpc.c             |   2 +-
 drivers/tee/optee/smc_abi.c         |  11 +-
 drivers/tee/tee_core.c              |   2 +-
 drivers/tee/tee_private.h           |  35 --
 drivers/tee/tee_shm.c               |  66 +++-
 drivers/tee/tee_shm_pool.c          |   2 +-
 drivers/tee/tstee/Kconfig           |  11 +
 drivers/tee/tstee/Makefile          |   3 +
 drivers/tee/tstee/core.c            | 480 ++++++++++++++++++++++++++++
 drivers/tee/tstee/tstee_private.h   |  92 ++++++
 include/linux/tee_core.h            | 306 ++++++++++++++++++
 include/linux/tee_drv.h             | 285 ++---------------
 include/uapi/linux/tee.h            |   1 +
 28 files changed, 1094 insertions(+), 389 deletions(-)
 create mode 100644 Documentation/tee/ts-tee.rst
 create mode 100644 drivers/tee/tstee/Kconfig
 create mode 100644 drivers/tee/tstee/Makefile
 create mode 100644 drivers/tee/tstee/core.c
 create mode 100644 drivers/tee/tstee/tstee_private.h
 create mode 100644 include/linux/tee_core.h

-- 
2.34.1


