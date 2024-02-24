Return-Path: <linux-kernel+bounces-79635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D59158624F0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12C2E1C20BCD
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 12:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90823E480;
	Sat, 24 Feb 2024 12:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XjL/ME58"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0B73D988
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 12:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708776972; cv=none; b=u053Gdx03//Pn+CAwXaD/8As7D5f8RbJhi9V6uZWDxMdF/llzqTgPeQaEk8b1VhF84nwvGk5XbM2OEsntGuZCONqfc1x+v274HW6V49X2/4sKY+8dimIM+zf2ORlLZnc8z3mMw0DTxaC4vOOjFmIyA/O2rxE+TN+VS12AmSJDMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708776972; c=relaxed/simple;
	bh=FVqwkjBGiGZ+FrnuOmvhnP6hzKLmcnGCY/w4xZTohpY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sPS4YZx5U3/C4eZezkzkXOzPNXZZxGuYqulaUwEbB//1N8OdY088lDtCqqGKKt0MvE3qYjv4bsmK+QeTCyQDrSeAhdyURXEM5KevY4rCIc1ioW5HJqfetPuV0Mqz1AOeHQQGg4iBuCXEj5Wkf/Lekegz2RxpP0TWnfqNwS9aI1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XjL/ME58; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6462C433F1;
	Sat, 24 Feb 2024 12:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708776971;
	bh=FVqwkjBGiGZ+FrnuOmvhnP6hzKLmcnGCY/w4xZTohpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XjL/ME582gBj+PnpaYTcAJdRjWCltO0ujLpFGlmYasM9RQuSkdzve0IpVw+2qvHrb
	 4oqTU1S+Iep91HOzIAgIb+hHbKAhsa9/b3uTFbcowMuARdI3FpC4SAwzG/DR+zo3CV
	 aPrwkUhUDsQrdBsTyE5lAkwd3Rp5jpwNDIcIfx1X7WaWscenCVj97SVKk16zJe3L5U
	 KF8z9/nNbY+1dQFiuJEnfp/+cJnxufDun68bUW1FNO2I8JVGO3cbkJ12p3x1s3Az1S
	 IjrNd3LUfFkHv4PjvnnH+cDfNE5fHimeCIxJu5w8by24eFIaNEYMXmosPgkoyqsmSS
	 MrYuj+UrUAwKQ==
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
	Matthew Brost <matthew.brost@intel.com>,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	Francois Dugast <francois.dugast@intel.com>,
	Dave Airlie <airlied@redhat.com>,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] drm/xe/xe2: fix 64-bit division in pte_update_size
Date: Sat, 24 Feb 2024 13:15:01 +0100
Message-Id: <20240224121528.1972719-3-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240224121528.1972719-1-arnd@kernel.org>
References: <20240224121528.1972719-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

This function does not build on 32-bit targets when the compiler
fails to reduce DIV_ROUND_UP() into a shift:

ld.lld: error: undefined symbol: __aeabi_uldivmod
>>> referenced by xe_migrate.c
>>>               drivers/gpu/drm/xe/xe_migrate.o:(pte_update_size) in archive vmlinux.a

There are two instances in this function. Change the first to
use an open-coded shift with the same behavior, and the second
one to a 32-bit calculation, which is sufficient here as the size
is never more than 2^32 pages (16TB).

Fixes: ea97a66a2218 ("drm/xe: Disable 32bits build")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/xe/xe_migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_migrate.c b/drivers/gpu/drm/xe/xe_migrate.c
index a66fdf2d2991..ee1bb938c493 100644
--- a/drivers/gpu/drm/xe/xe_migrate.c
+++ b/drivers/gpu/drm/xe/xe_migrate.c
@@ -462,7 +462,7 @@ static u32 pte_update_size(struct xe_migrate *m,
 	} else {
 		/* Clip L0 to available size */
 		u64 size = min(*L0, (u64)avail_pts * SZ_2M);
-		u64 num_4k_pages = DIV_ROUND_UP(size, XE_PAGE_SIZE);
+		u32 num_4k_pages = (size + XE_PAGE_SIZE - 1) >> XE_PTE_SHIFT;
 
 		*L0 = size;
 		*L0_ofs = xe_migrate_vm_addr(pt_ofs, 0);
-- 
2.39.2


