Return-Path: <linux-kernel+bounces-81405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6552867586
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E79431C23715
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A427F7CA;
	Mon, 26 Feb 2024 12:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYqHb7pj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C468604D4
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 12:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708951664; cv=none; b=mI+EZq0Iko+mkndVDSoZQVJP5ioUeKyrTav+rnXAHZ+XC+i/xdSXwgn7nE9ka7gAgbu9h76QZQG6nCYOyUQny3LqO/jOLRboUwTWEPuVWeisJsQi0hK/uBSjHMuAtkv4ZOknbxNyQSllRMz5Lm6SyhX1JIaamqScgbwnPyMhV5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708951664; c=relaxed/simple;
	bh=vPnudlAxEBtSwaSh16NplVrq2SvEXPSzaOEsHkk1YQc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mWotCCamXp9X8CXrHWneJfGbSQAjMLcAKs0RFBSQUApGyLvugdZDmuJyeA4DSHTeDMtDbrl322ygSwXRdN6CWsyqhTJpr4oqQ9YUFfyOXblT/6i/QX0mTbtRykefO77PooZt7eSa5B1XiKOZlGUFh6jDS/SzJb8cAKnhEqJJ2AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYqHb7pj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7236EC433C7;
	Mon, 26 Feb 2024 12:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708951663;
	bh=vPnudlAxEBtSwaSh16NplVrq2SvEXPSzaOEsHkk1YQc=;
	h=From:To:Cc:Subject:Date:From;
	b=FYqHb7pjQYLZRQcpUsUksBUteFXpvb15TA3fQeT3qftscQBkT/quRXHxaBoDeIZK/
	 OHn7d7D0euJdnIYvpn8QsSgcGMOgThM0dfJKN1CsdkG9G0bzYJkpNraiDWziCSkgaW
	 zGh4Kx1eVSqy2ZXI0YrpKu3sXdtn2lfpfixfieFK/MZWgDYZT+dMfAdA9m1yi1UOiW
	 fXbq3nlo9J+G7J81H5P8n2Yy/+Kxbym8cwD//m2h3qFI7C3hcgky8XB6ZN02yY7b4i
	 Wd9aKoGJYKdN729IMDTUYV65OV2Mdp0SYGBNZ9ggOKbyptFCiY7OViVw4HJe7M+aO8
	 Lo7b2hwIQuOMw==
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
	Jani Nikula <jani.nikula@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] [v2] drm/xe/kunit: fix link failure with built-in xe
Date: Mon, 26 Feb 2024 13:46:36 +0100
Message-Id: <20240226124736.1272949-1-arnd@kernel.org>
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

Fixes: 5095d13d758b ("drm/xe/kunit: Define helper functions to allocate fake xe device")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: don't remove KUNIT dependency
---
 drivers/gpu/drm/xe/Kconfig       | 1 +
 drivers/gpu/drm/xe/Kconfig.debug | 1 -
 drivers/gpu/drm/xe/Makefile      | 6 ++++--
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
index 6d4428b19a4c..c3a3b204ae5b 100644
--- a/drivers/gpu/drm/xe/Kconfig
+++ b/drivers/gpu/drm/xe/Kconfig
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


