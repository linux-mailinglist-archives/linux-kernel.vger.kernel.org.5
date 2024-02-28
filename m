Return-Path: <linux-kernel+bounces-85017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D69486AF2F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03ADA1F259C4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C163BBDB;
	Wed, 28 Feb 2024 12:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KB3pClLY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADAF3BBCF
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 12:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709123276; cv=none; b=YXNTXaUvmhJJ8SHuJmAp9c88FUm03ru0JoE0o6i8dnbMSAjR8Fg2OtKWp//QDlvEkyk0jH+II3mMXW/3LEL0EcYgYGh222xyS41bWsqSk6qfMkdsNMs9UxYajavENgmn6JJzIHfVt9BshrmaXqb2Hax9V1lOgIDDWfhJXLEimHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709123276; c=relaxed/simple;
	bh=zJkyW1REgGcoo5I8xkc1mIm72bDArJYrzYMZkYH4CyE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H2X6gxkOZQ5sIgsjzOE5oWpe8k0ED7wmtqtK/VNfuFClMGS0r8gRZU2Q+v/qqgRK5+o+HxLI9IZ/07cQwVU+WKnUWh/G6K4E+sxFIaQN6W/PZYkvoWJUXdfTY6pQ4VMIWMfNUL4oswteLi4YmZ7AgMs6SryGZapDlq1wqXqPPXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KB3pClLY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9966DC433F1;
	Wed, 28 Feb 2024 12:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709123276;
	bh=zJkyW1REgGcoo5I8xkc1mIm72bDArJYrzYMZkYH4CyE=;
	h=From:To:Cc:Subject:Date:From;
	b=KB3pClLY5dKCrRpGkbtavnPw1utKoKmS/kX8Uohz+oFYrGvdIXg7tvVk9Lo3h4EPc
	 o4WcwGJbOcn6pnyqzT8vd426E4eA4utqcx7B8E0ROL0jzRyCFio6LBB0NIz0D7P6eu
	 viaQgw14TQFfcg1FWjm6Y9dJ5SRqTIxPBpRKoHbEvPaHmfyUkAEIc705MRY75IygYF
	 dMoM0tMEA9lvhHulq+bxGtvhC4FTBru8fhQdvr+AfJfTZLQUHqmQKLSwoKHCJ9i+gl
	 H5zL9urT2k/1YO97uS8YF4FSObxmPm4j8S7Vp0IP+wgfm3c730fy93NH5l4IaDS+V+
	 n0L4ar7Z6GNyw==
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
	Matt Roper <matthew.d.roper@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Michal Wajdeczko <michal.wajdeczko@intel.com>,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] xe: avoid using writeq() on 32-bit
Date: Wed, 28 Feb 2024 13:27:33 +0100
Message-Id: <20240228122746.3091608-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

32-bit kernels do not provide a writeq(), failing the build:

drivers/gpu/drm/xe/xe_ggtt.c:78:2: error: use of undeclared identifier 'writeq'
   78 |         writeq(pte, &ggtt->gsm[addr >> XE_PTE_SHIFT]);

Using lo_hi_writeq() instead will write the lower 32 bits to the address
before writing the upper 32 bits to the following word, which is likely
the correct replacement to do on 32-bit targets.

Include the linux/io-64-nonatomic-lo-hi.h header to automatically pick
the regular writeq() on 64-bit machines but fall back to lo_hi_writeq()
on 32-bit ones.

Fixes: 237412e45390 ("drm/xe: Enable 32bits build")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/xe/xe_ggtt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/xe/xe_ggtt.c b/drivers/gpu/drm/xe/xe_ggtt.c
index 5d46958e3144..1ffcc63ca86d 100644
--- a/drivers/gpu/drm/xe/xe_ggtt.c
+++ b/drivers/gpu/drm/xe/xe_ggtt.c
@@ -6,6 +6,7 @@
 #include "xe_ggtt.h"
 
 #include <linux/sizes.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 
 #include <drm/drm_managed.h>
 #include <drm/i915_drm.h>
-- 
2.39.2


