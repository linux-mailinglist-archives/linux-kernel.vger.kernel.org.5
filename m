Return-Path: <linux-kernel+bounces-68967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D05CB8582AF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ABE0281214
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4719130ACA;
	Fri, 16 Feb 2024 16:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fhk33EVh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD4E130AC8
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 16:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708101349; cv=none; b=jpDKOFPZOB6ERRxdi/DNINGutLx46EEqOm4CheVKmnoluAeb4ydaXzQvATtyr4VdTAlbRbnBi49FImveCAq2R4LZN9umgdIOKz2UlxpElxBCZVOTcYWrnJmt53O9NeABulprCVERsWDybej6BCB03ZZGypf0AgWAZj2DVthVCck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708101349; c=relaxed/simple;
	bh=raZvY0y+94L/NA9J1FyQdvorJ7LyjIGL527Ml81HsW0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cvjX2gxG/UV/D8NvtzGJbKXUcvR8//iWxySmHRwawI7Am7MZxTMI5gqPNWmsGsqivKyjhmXxe/0LYkxyCAn1pV6B2t/08depgUjh5t6pQ/6vQLsYs0/u6lYbXp2wAgVqzlC4Wx5PW137AQVf27dA9ie8UUoZdHK+5pe9Ra9/yA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fhk33EVh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8667BC433F1;
	Fri, 16 Feb 2024 16:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708101348;
	bh=raZvY0y+94L/NA9J1FyQdvorJ7LyjIGL527Ml81HsW0=;
	h=From:To:Cc:Subject:Date:From;
	b=Fhk33EVhnTbEtIAGR46HODhGb0Tkg9fP9bDxNBKTnshqywJDQR4JqCvhJmLNkBmFo
	 GdzUzSpj/Y0is26wYNyB5vatu24z7YBMx9N7UOEbE1d+jMrGkYaZSnsjZjOG5p/ws3
	 3E/P/iaBNKXiLayIcjEWah2XyWOjbveqVvbrK/sinJlFSjgVc1e/v08nrg1skgH+pC
	 kul8E4ppMuq+AIEdF10hImaQoSvNOAh4uozGAm2Rv5z6HTdsUdkp16zlcy+/oEtsjR
	 AETU7AJsMc9MSXH6GDoriXdlFUullFz046AjJbEQAg9cO3jvbhlrF7RVL1cghCLBHN
	 sUSI6KGoXPH7A==
From: Arnd Bergmann <arnd@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] irq_work: allow building non-SMP again
Date: Fri, 16 Feb 2024 17:35:07 +0100
Message-Id: <20240216163535.1997122-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

A lot of important features rely on CONFIG_IRQ_WORK but can be enabled
for non-SMP kernels, which now causes a Kconfig warning:

WARNING: unmet direct dependencies detected for IRQ_WORK
  Depends on [n]: SMP [=n]
  Selected by [y]:
  - PRINTK [=y]
  - IRQ_SIM [=y]
  - BPF_SYSCALL [=y]
  - TASKS_RCU [=y]
  - TASKS_RUDE_RCU [=y]
  - TASKS_TRACE_RCU [=y]
  - PERF_EVENTS [=y] && HAVE_PERF_EVENTS [=y]
  - CPU_FREQ_GOV_COMMON [=y] && CPU_FREQ [=y]
  - DMA_SHARED_BUFFER [=y]
  - ATLAS_PH_SENSOR [=y] && IIO [=y] && I2C [=y]
  - GP2AP020A00F [=y] && IIO [=y] && I2C [=y]
  - IIO_SYSFS_TRIGGER [=y] && IIO [=y] && IIO_TRIGGER [=y] && SYSFS [=y]
  - RING_BUFFER [=y]

Change it so that IRQ_WORK remains default-enabled for SMP kernels
and disabled for UP but can still be selected by other subsystems.

Fixes: 9d6efa8d0dd0 ("workqueue, irq_work: Build fix for !CONFIG_IRQ_WORK")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I assume this has already been reported by others, but I didn't immediately
see another patch for it.
---
 init/Kconfig | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 694891231bd6..68024f5e8f02 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -115,9 +115,7 @@ config CONSTRUCTORS
 	bool
 
 config IRQ_WORK
-	bool
-	depends on SMP
-	default y
+	def_bool SMP
 
 config BUILDTIME_TABLE_SORT
 	bool
-- 
2.39.2


