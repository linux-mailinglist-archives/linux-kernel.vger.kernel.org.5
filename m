Return-Path: <linux-kernel+bounces-131444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D058987EF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CE421C2101F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC08D12D769;
	Thu,  4 Apr 2024 12:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCNY2xJS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0828F82C7E;
	Thu,  4 Apr 2024 12:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712234081; cv=none; b=I3te3nqVRevbxngnFHxA8hrO5/wSCsDrBaGyrEuVxh8UqTBgPEIGnG0+rYRiOv/P7Esc9ArKcM8MhNroPxwPpORinc2SW7Fel/xIgRAWiAkJBY2MPTV1zW7mlPP3Vus2EpjKWRC5E4F3hdgTbEp/yZyoQM9LcNjgcyy34Xd2l4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712234081; c=relaxed/simple;
	bh=qRL6MwLDG8IPLhfSjCuwK6KP5RYuL8xbctvnKfUT7mM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZGl+UL+oAN55f4dIWbIA8jfSFoRE5Sd7fixrbAK3rKXLffbwT83KxrNqde713qXBbRS8yi4tOWJtG2Wh5yjxin3KZKYD2lbD1sfu9y4CZPTPFHtMjeDK7mdsDXXLERLrRfbeM+iUwvHMK3tgb9N0FHYKD8TFaaN56Tr/WQKATiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCNY2xJS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1D0C433F1;
	Thu,  4 Apr 2024 12:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712234080;
	bh=qRL6MwLDG8IPLhfSjCuwK6KP5RYuL8xbctvnKfUT7mM=;
	h=From:To:Cc:Subject:Date:From;
	b=OCNY2xJS84pGPBlxbcPSDeueeEIqS4uSPHhZQj4tbWIQpJdN2laGMBmLTeamMzlkE
	 mD5mIZQZOzesu+AfwDx9IE7M6ngJcIt6pDRksGtLnNs9VFzaBIfrrL9x2Cr6CVFT9S
	 LDsmXcDrdLFws7CtMI70MafQesKtsYS/rVC7Wz83MatI5CZY8cATZXcXnKPNaEAG58
	 QRVSYtGO/vA9k7pD08APhMzAVYnSmKG1uOih2zhyUG0VeMZqecnx/0fLwZjR0fkD2Y
	 y4Fao/dyRFeK4Opb2jHq80KB0Vm9pFnP930lsKYCGjitdh2gAtthrAcg1k2KpfIJIp
	 J19nyl1Es9bgA==
From: Arnd Bergmann <arnd@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Armin Wolf <W_Armin@gmx.de>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Henning Schild <henning.schild@siemens.com>,
	SungHwan Jung <onenowy@gmail.com>,
	Ai Chao <aichao@kylinos.cn>,
	Robert Joslyn <robert.joslyn@redrectangle.org>,
	Henry Shi <henryshi2018@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: quickstart: fix Kconfig selects
Date: Thu,  4 Apr 2024 14:34:30 +0200
Message-Id: <20240404123435.2684819-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The new driver Kconfig entry has a typo that causes a link failure
when CONFIG_INPUT_SPARSEKMAP is disabled:

x86_64-linux-ld: drivers/platform/x86/quickstart.o: in function `quickstart_notify':
quickstart.c:(.text+0x96): undefined reference to `sparse_keymap_report_event'
x86_64-linux-ld: drivers/platform/x86/quickstart.o: in function `quickstart_probe':
quickstart.c:(.text+0x1da): undefined reference to `sparse_keymap_setup'

Select this symbol instead of the incorrect INPUT_SPARSE_KEYMAP.

Fixes: afd66f2a739e ("platform/x86: Add ACPI quickstart button (PNP0C32) driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/platform/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index ba88a7f259f1..21a37f1b73ab 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -647,7 +647,7 @@ config ACPI_QUICKSTART
 	tristate "ACPI Quickstart button driver"
 	depends on ACPI
 	depends on INPUT
-	select INPUT_SPARSE_KEYMAP
+	select INPUT_SPARSEKMAP
 	help
 	  This driver adds support for ACPI quickstart button (PNP0C32) devices.
 	  The button emits a manufacturer-specific key value when pressed, so
-- 
2.39.2


