Return-Path: <linux-kernel+bounces-63722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A1C8533A1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B174EB23B2C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F300F5A7B3;
	Tue, 13 Feb 2024 14:53:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC5B3613A;
	Tue, 13 Feb 2024 14:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836009; cv=none; b=Id/pqY2XkJkrBaJYkjwaQGPNE1iG5GepegAU+mFAf/enGi8ZclVS6a3av1RzxquxkCRRe757mNFtvq/M/yp0TEZtXSPuoSNpI1Xw6hFHNXfowU9quV8YZ39CnRgwGWzROa+EkG7oeWw2sAiCCjGF12ITfgeJd2O76fo67YHTej0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836009; c=relaxed/simple;
	bh=t+C0wHRdPYUeT/g+3p7OkdvqqXBfXGLMN3mjtPjhcZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UABxHfb03+I6+Qm7l0CvBZ7G9cVFfUfmt53ZzOnk1QkwM1pLED7SrZxA2qU2MAzX5ZG+5eqZsoy845Jj9Urmp3091pSTY/6Obi4o9fXV72naS3b0CdQoGnejEsTboh9np4aeM+vV/N1v0kZi2Gj70sCN7yNDZolrdBlkD0Igtr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DC40DA7;
	Tue, 13 Feb 2024 06:54:07 -0800 (PST)
Received: from mango.localdomain (TVHN20WD9G.budapest.arm.com [10.45.25.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 999893F7B4;
	Tue, 13 Feb 2024 06:53:24 -0800 (PST)
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
	gyorgy.szing@arm.com
Subject: [PATCH 0/3] TEE driver for Trusted Services
Date: Tue, 13 Feb 2024 15:52:36 +0100
Message-Id: <20240213145239.379875-1-balint.dobszay@arm.com>
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
RFC[4] -> v1:
  - Add patch for moving pool_op helper functions to the TEE subsystem,
    as suggested by Jens
  - Address comments from Sumit, add patch for documentation

[1] https://www.trustedfirmware.org/projects/trusted-services/
[2] https://developer.arm.com/documentation/den0077/
[3] https://www.arm.com/architecture/security-features/platform-security
[4] https://lore.kernel.org/linux-arm-kernel/20230927152145.111777-1-balint.dobszay@arm.com/


Balint Dobszay (3):
  tee: optee: Move pool_op helper functions
  tee: tstee: Add Trusted Services TEE driver
  Documentation: tee: Add TS-TEE driver

 Documentation/tee/index.rst       |   1 +
 Documentation/tee/ts-tee.rst      |  70 +++++
 drivers/tee/Kconfig               |   1 +
 drivers/tee/Makefile              |   1 +
 drivers/tee/optee/core.c          |  64 ----
 drivers/tee/optee/ffa_abi.c       |   6 +-
 drivers/tee/optee/optee_private.h |  12 -
 drivers/tee/optee/smc_abi.c       |  10 +-
 drivers/tee/tee_shm.c             |  65 ++++
 drivers/tee/tstee/Kconfig         |  11 +
 drivers/tee/tstee/Makefile        |   3 +
 drivers/tee/tstee/core.c          | 501 ++++++++++++++++++++++++++++++
 drivers/tee/tstee/tstee_private.h |  92 ++++++
 include/linux/tee_drv.h           |  11 +
 include/uapi/linux/tee.h          |   1 +
 15 files changed, 765 insertions(+), 84 deletions(-)
 create mode 100644 Documentation/tee/ts-tee.rst
 create mode 100644 drivers/tee/tstee/Kconfig
 create mode 100644 drivers/tee/tstee/Makefile
 create mode 100644 drivers/tee/tstee/core.c
 create mode 100644 drivers/tee/tstee/tstee_private.h

-- 
2.34.1


