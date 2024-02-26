Return-Path: <linux-kernel+bounces-81409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E74068675FC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EED02B2B950
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA6980037;
	Mon, 26 Feb 2024 12:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5gwv/oL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F06EC7
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 12:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708951734; cv=none; b=FXiyO5tFg5b/LQTLiphCILcsByvTta7ETIoBbcdWohEbkxg9AzMlylkxqpG/ZL6oMrHHITyvegmOx3ofbdlfIz5WuqlPkqP2NS7m3YQ5bZTOwRhAJjZNrTnciwgLwWOiErmoiZK3iQh7PUkI9hrqHdVj0rus92+fvevrUE6mkDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708951734; c=relaxed/simple;
	bh=Q3NH181a85YRTFivknWhvRlGzUVX6ut6yEVQtESkJik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=omZEzyZRPO5y37Q3VlK2MIqXk7bypSvwVOXjfLmOsRIztJajxcFO6RcnJEcoYNiD6BNDFDJqPJ08CP/ChaiT3NPJBIqXfcMy2CDU2LSMslp4mYEQW91NjfMsIMGXomAui+o0LGzzN4mLDK8t5NilNbeuE8JpupvAidA020yzUyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5gwv/oL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD553C43390;
	Mon, 26 Feb 2024 12:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708951734;
	bh=Q3NH181a85YRTFivknWhvRlGzUVX6ut6yEVQtESkJik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j5gwv/oLxGBvshYM4XJsakKQspn+4PiYoY+JB8H+VNY+uM3lMbovSewvvS7qT4pPq
	 NSpcoaLyasTfkJ9GZE0Ekv0zTg4XXDqtbcUNwIa2GVPeWQe70PVIrWjdD6hzUaCMKg
	 hG24PwowVape7egBViKaXaknYe26QfBheDfrpqGdB6IE4W81shxhUm6pSrLgtDMM9C
	 +RDgNYsJh8GwsjSI8kboes7lAMcB+jJH7zl70rs8XL+f6J+pgewKs/puDY8dj2mX3U
	 5h1Khj5tIT8dSvdkzBje5gz/b6PPaTcopUTRzqdEVRU6BHxqN8SfcOcS0G42nq+oWN
	 54jKq5HRKHgiw==
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
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] [v2] drm/xe/xe2: fix 64-bit division in pte_update_size
Date: Mon, 26 Feb 2024 13:46:38 +0100
Message-Id: <20240226124736.1272949-3-arnd@kernel.org>
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

This function does not build on 32-bit targets when the compiler
fails to reduce DIV_ROUND_UP() into a shift:

ld.lld: error: undefined symbol: __aeabi_uldivmod
>>> referenced by xe_migrate.c
>>>               drivers/gpu/drm/xe/xe_migrate.o:(pte_update_size) in archive vmlinux.a

There are two instances in this function. Change the first to
use an open-coded shift with the same behavior, and the second
one to a 32-bit calculation, which is sufficient here as the size
is never more than 2^32 pages (16TB).

Fixes: 237412e45390 ("drm/xe: Enable 32bits build")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: use correct Fixes tag
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


