Return-Path: <linux-kernel+bounces-81406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4B5867588
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 107821F2551D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E6E7F7DB;
	Mon, 26 Feb 2024 12:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bq8V8bu+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA89EC7;
	Mon, 26 Feb 2024 12:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708951700; cv=none; b=tcu0ilXoIQ2jLg6I0LOsTXOaehD9yAEeQMRen/JzVOgdVfMuek1Djvi9QqNkkxvddE6hNPtmjGhrnmFHpiB3uomZtHVFM3Q0ODgaKHG2tukDiUrcpSm8JPA8Tfpl/FHmDDoCbEjQfTK0n4aoSS7gr247tHpbRFs/eNYhIvQX9o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708951700; c=relaxed/simple;
	bh=nwHarD6e/noK0RLpyMyg49ecLqGeQ0DNCXP39VJcJnU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VMpDgaGtCjOt6YmNCOE1b4ur/Q/TS9SEKDsUFSojHU5+2yETA2EA92wGQVbsufu+oepad+JbbdqWm18lSnVFXyd7I5Osf/9oJzHCTVhaxTjgtxrNYtuWFTVCOH8tHtodHfa7Swo0p/kl/4SzkjtQcf6Qr/lkiDtB4GOSBm66BeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bq8V8bu+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87566C433F1;
	Mon, 26 Feb 2024 12:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708951699;
	bh=nwHarD6e/noK0RLpyMyg49ecLqGeQ0DNCXP39VJcJnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bq8V8bu+AnNPQ618fedRUM7MYXae1yTLy649cK81/fffiV4+DdQr+B6CwBXjv1QA/
	 9XwitYZerkPdzT5oQ/BMnkEy4pIshL73oouNzyIJoPfQp9+cQuhHNB3RpERuh9m4fH
	 E9M8scMGqCESeLu8Ph8VEitEHpGBWF+T8lMDqXAWow9kDmXkSJ2EMmuDiOL61oW5ak
	 8GXdCtwNHiGHcJIJA6zt7gf/AdcrTa9iQtsvwNLiQU3QsjS7Nq5smBFZwrq9/k7ZvA
	 uB0u6Yts0KZNO9gSsCmBl/IqxfViSV3BHGkV+4r+G1t7huI2eVrHUs+49XbtkKfIzY
	 CjL4rZQN+bcqg==
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
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 2/3] [v2] drm/xe/mmio: fix build warning for BAR resize on 32-bit
Date: Mon, 26 Feb 2024 13:46:37 +0100
Message-Id: <20240226124736.1272949-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240226124736.1272949-1-arnd@kernel.org>
References: <20240226124736.1272949-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

clang complains about a nonsensical test on builds with a 32-bit phys_addr_t,
which means resizing will always fail:

drivers/gpu/drm/xe/xe_mmio.c:109:23: error: result of comparison of constant 4294967296 with expression of type 'resource_size_t' (aka 'unsigned int') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
  109 |                     root_res->start > 0x100000000ull)
      |                     ~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~

Previously, BAR resize was always disallowed on 32-bit kernels, but
this apparently changed recently. Since 32-bit machines can in theory
support PAE/LPAE for large address spaces, this may end up useful,
so change the driver to shut up the warning but still work when
phys_addr_t/resource_size_t is 64 bit wide.

Fixes: 9a6e6c14bfde ("drm/xe/mmio: Use non-atomic writeq/readq variant for 32b")
Fixes: 237412e45390 ("drm/xe: Enable 32bits build")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: use correct Fixes tag
---
 drivers/gpu/drm/xe/xe_mmio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_mmio.c b/drivers/gpu/drm/xe/xe_mmio.c
index e3db3a178760..7ba2477452d7 100644
--- a/drivers/gpu/drm/xe/xe_mmio.c
+++ b/drivers/gpu/drm/xe/xe_mmio.c
@@ -106,7 +106,7 @@ static void xe_resize_vram_bar(struct xe_device *xe)
 
 	pci_bus_for_each_resource(root, root_res, i) {
 		if (root_res && root_res->flags & (IORESOURCE_MEM | IORESOURCE_MEM_64) &&
-		    root_res->start > 0x100000000ull)
+		    (u64)root_res->start > 0x100000000ul)
 			break;
 	}
 
-- 
2.39.2


