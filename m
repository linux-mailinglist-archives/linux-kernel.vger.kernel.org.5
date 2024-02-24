Return-Path: <linux-kernel+bounces-79633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3CA8624EC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A70B1C20C1A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 12:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D7F3E48E;
	Sat, 24 Feb 2024 12:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRUsTOnO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EF63DB89
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 12:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708776936; cv=none; b=ZtWEOka4gr4AH4O6qFAe+CjTmrXIZVtheQLo2dLDFZ9AupllDxlLRkD28kfV/LwtiABwVrgVLMUTrvp1FUZO6UHSjg2mOi59pWZh1rldQHDJLu33VrZLygrsk2UG6KFagCCh8uu0md8oLdcOPNPD/4jTn1+TXyRZ9E3lUx1R5us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708776936; c=relaxed/simple;
	bh=GNq+evKLQVdJDM94sIz8nN00faZ597yvTUdvqvR4sM0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z8dhgxW38MH27yNzvqLpHLMJs2WZ6CZ7NoqCbJmSxeBe0Z5tbtamLOBrpqxFSqq1kDnFbm+GxTRJVgCzsrpdloLjcXbv97rpSSy8NUcBsQUFIhzNVhd+e+pj/OPd5dNuDqO84Qu3NxgeYFAtqmz2THsqO6w8Ob5sMmrM7V6Si+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRUsTOnO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 468BBC433C7;
	Sat, 24 Feb 2024 12:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708776935;
	bh=GNq+evKLQVdJDM94sIz8nN00faZ597yvTUdvqvR4sM0=;
	h=From:To:Cc:Subject:Date:From;
	b=PRUsTOnOixxCx6+PhkNqgR6u7CrHGxeKdMmu0HhuiPwo8HX6cv+nHUn/nK/5AgwWZ
	 qGWygkErblxxAjS9Znim/qclXfJGMDBUc8aQ0CNojOT6m/bU6Q2wonJlaCoD73YFOS
	 u3l3ZiBiGeyCHT8imaBNwhyNW2oXV04YhilqCkZkfhfmNYpRIjrnveq/k53sKT7yu7
	 RHBRCafGsQQUcAkDy1BQY4Sm4tbyoqF1fD8XQBHXktLZoII/pogUvICy0mdH5y9jyw
	 LKYX+yMqZeeyU1ksrLEeOBN4rBk6Rb87rM+upgv+WgowiHWxe03rKJs585KZt9iDdj
	 WWUKYA7ZA4cWg==
From: Arnd Bergmann <arnd@kernel.org>
To: Lucas De Marchi <lucas.demarchi@intel.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Francois Dugast <francois.dugast@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Tejas Upadhyay <tejas.upadhyay@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] drm/xe/kunit: fix link failure with built-in xe
Date: Sat, 24 Feb 2024 13:14:59 +0100
Message-Id: <20240224121528.1972719-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When the driver is built-in but the tests are in loadable modules,
the helpers don't actually get put into the driver:

ERROR: modpost: "xe_kunit_helper_alloc_xe_device" [drivers/gpu/drm/xe/tests/xe_test.ko] undefined!

Change the Makefile to ensure they are always part of the driver
even when the rest of the kunit tests are in loadable modules.

The tests/xe_kunit_helpers.c file depends on DRM_KUNIT_TEST_HELPERS,
so this has to always be selected by the main XE module now, rather
than the actual tests. In turn, the "depends on (m || (y && KUNIT=y))"
doesn't really do what it tried and can just be removed.

Fixes: 5095d13d758b ("drm/xe/kunit: Define helper functions to allocate fake xe device")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/xe/Kconfig       | 3 ++-
 drivers/gpu/drm/xe/Kconfig.debug | 1 -
 drivers/gpu/drm/xe/Makefile      | 6 ++++--
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
index 6d4428b19a4c..2948650680e1 100644
--- a/drivers/gpu/drm/xe/Kconfig
+++ b/drivers/gpu/drm/xe/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config DRM_XE
 	tristate "Intel Xe Graphics"
-	depends on DRM && PCI && MMU && (m || (y && KUNIT=y))
+	depends on DRM && PCI && MMU
 	depends on ACPI_VIDEO || !ACPI
 	select INTERVAL_TREE
 	# we need shmfs for the swappable backing store, and in particular
@@ -11,6 +11,7 @@ config DRM_XE
 	select DRM_BUDDY
 	select DRM_EXEC
 	select DRM_KMS_HELPER
+	select DRM_KUNIT_TEST_HELPERS if DRM_XE_KUNIT_TEST != n
 	select DRM_PANEL
 	select DRM_SUBALLOC_HELPER
 	select DRM_DISPLAY_DP_HELPER
diff --git a/drivers/gpu/drm/xe/Kconfig.debug b/drivers/gpu/drm/xe/Kconfig.debug
index 549065f57a78..df02e5d17d26 100644
--- a/drivers/gpu/drm/xe/Kconfig.debug
+++ b/drivers/gpu/drm/xe/Kconfig.debug
@@ -76,7 +76,6 @@ config DRM_XE_KUNIT_TEST
 	depends on DRM_XE && KUNIT && DEBUG_FS
 	default KUNIT_ALL_TESTS
 	select DRM_EXPORT_FOR_TESTS if m
-	select DRM_KUNIT_TEST_HELPERS
 	help
 	  Choose this option to allow the driver to perform selftests under
 	  the kunit framework
diff --git a/drivers/gpu/drm/xe/Makefile b/drivers/gpu/drm/xe/Makefile
index 4c6ffe4b2172..b596e4482a9b 100644
--- a/drivers/gpu/drm/xe/Makefile
+++ b/drivers/gpu/drm/xe/Makefile
@@ -158,8 +158,10 @@ xe-$(CONFIG_PCI_IOV) += \
 	xe_lmtt_2l.o \
 	xe_lmtt_ml.o
 
-xe-$(CONFIG_DRM_XE_KUNIT_TEST) += \
-	tests/xe_kunit_helpers.o
+# include helpers for tests even when XE is built-in
+ifdef CONFIG_DRM_XE_KUNIT_TEST
+xe-y += tests/xe_kunit_helpers.o
+endif
 
 # i915 Display compat #defines and #includes
 subdir-ccflags-$(CONFIG_DRM_XE_DISPLAY) += \
-- 
2.39.2


