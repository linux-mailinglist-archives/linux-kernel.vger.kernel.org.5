Return-Path: <linux-kernel+bounces-78080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F0E860EA9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 046021F22453
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E39F5C915;
	Fri, 23 Feb 2024 09:52:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36CA1F93F;
	Fri, 23 Feb 2024 09:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708681951; cv=none; b=FS+77r7npYeegW4j0foHW99obEJRpforVnrKoYjPP0lD2lO36b6KXdqW60AT4iMR6o/elwnzJt7kdPMM9MXVGmA2fox/xeIKSQAxLjdLjVchIlL9Ex7XUDHBcsq2+GN4iGD6PIFoa9WOwOLkM07OHN6yBCOCRfLm506qX5q/O7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708681951; c=relaxed/simple;
	bh=/a4IF1mvehIzwAfoaXx+/1nzzp1x5R6nqY3E1jjYZGE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mBru/Se2w3BiDcNrXMH9iciyQJYwhymoIw1E3m4/hZyWweg6r2Mc3JcfUeekKgeo+TWCDpkXpykFWb1vd2dMnMrzsi5W8kLIC+/2/W+i/g4GLO26ar4pL6bjFYaeDhoLGjndY3BtMQE0A9coF9LGP/KfEbHUTTy11Xw9KlA5Dxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A380C1596;
	Fri, 23 Feb 2024 01:53:07 -0800 (PST)
Received: from mango.localdomain (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 271023F766;
	Fri, 23 Feb 2024 01:52:27 -0800 (PST)
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
Subject: [PATCH v2 0/3] TEE driver for Trusted Services
Date: Fri, 23 Feb 2024 10:51:30 +0100
Message-Id: <20240223095133.109046-1-balint.dobszay@arm.com>
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


Balint Dobszay (3):
  tee: optee: Move pool_op helper functions
  tee: tstee: Add Trusted Services TEE driver
  Documentation: tee: Add TS-TEE driver

 Documentation/tee/index.rst       |   1 +
 Documentation/tee/ts-tee.rst      |  71 +++++
 drivers/tee/Kconfig               |   1 +
 drivers/tee/Makefile              |   1 +
 drivers/tee/optee/core.c          |  64 ----
 drivers/tee/optee/ffa_abi.c       |   6 +-
 drivers/tee/optee/optee_private.h |  12 -
 drivers/tee/optee/smc_abi.c       |  11 +-
 drivers/tee/tee_shm.c             |  65 ++++
 drivers/tee/tstee/Kconfig         |  11 +
 drivers/tee/tstee/Makefile        |   3 +
 drivers/tee/tstee/core.c          | 490 ++++++++++++++++++++++++++++++
 drivers/tee/tstee/tstee_private.h |  94 ++++++
 include/linux/tee_drv.h           |  11 +
 include/uapi/linux/tee.h          |   1 +
 15 files changed, 758 insertions(+), 84 deletions(-)
 create mode 100644 Documentation/tee/ts-tee.rst
 create mode 100644 drivers/tee/tstee/Kconfig
 create mode 100644 drivers/tee/tstee/Makefile
 create mode 100644 drivers/tee/tstee/core.c
 create mode 100644 drivers/tee/tstee/tstee_private.h

-- 
2.34.1


