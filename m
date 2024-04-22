Return-Path: <linux-kernel+bounces-154258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B89BC8AD9FC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F252B22CAF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5237415E202;
	Mon, 22 Apr 2024 23:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rdg2WDT+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AED15D5DF;
	Mon, 22 Apr 2024 23:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830140; cv=none; b=OfgPtAbg8Efy7QlgLTyE/bDc/Al+P6uIvnq/uwEUnhGl3/QDQBGkWWyd0etPurDmDp55UjoJaaBLPyIGFYfLEvI1EYjLPpyRRpLDkTCen3UxRCD79KeE0OT64u9933LQLyYuElqJTIRwZVBeffYTZCVGrtAWNj3++thWlYl/Loc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830140; c=relaxed/simple;
	bh=9m0rXRdGMqKho7pfIeai8tfeVTeCCClMqcN6ko1ovPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=akeQQuZeNEXmpFzgWjTfWCdsYLJZYjxLDSP6aDZkmCg7drMDWBAFd4owG+8qjKZ4qbkEWxYEJUL6Q1/+UFKa20ei4A5/s01nXo6R0laW/utSr69gaD7gucRGO8tAR0KTHviUkOSBqMzcgEMohQvZVTL8l+neSHN5luGBb+VUGfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rdg2WDT+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F63C32782;
	Mon, 22 Apr 2024 23:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830140;
	bh=9m0rXRdGMqKho7pfIeai8tfeVTeCCClMqcN6ko1ovPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rdg2WDT+4UDcJQmVo1gk+YTKchLUCkEQDBJlv3C8X9icLYiPtQ8Ogh/hRh6Y/nCEu
	 dGC6QIM57EJ6UJIQRzLZvcGQg2kKegeaDokRgFkxC7g4WngGOD56wypYHbseSRU3A0
	 tONYIfHua20NZ2Xjyhm3ovQ1ft8+XJq26TpGs4PUNTbebPyktQGFx8moPozqgQh95+
	 JIsn3HKqtZxqN2HQuAkQgPwoPMxS9+7fsvdU+D/gRKwu726F9o4SyLu3AbcbUdEkpD
	 SXP/vFT43hvLMomzK0OaKzXfSAHj+PUrq0hCZ7658RmxFtONepaCRqpB8xIGhE+82i
	 +U0h+bEhUbm2w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	ogabbay@kernel.org,
	thomas.hellstrom@linux.intel.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.8 40/43] drm/xe/xe_migrate: Cast to output precision before multiplying operands
Date: Mon, 22 Apr 2024 19:14:26 -0400
Message-ID: <20240422231521.1592991-40-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231521.1592991-1-sashal@kernel.org>
References: <20240422231521.1592991-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.7
Content-Transfer-Encoding: 8bit

From: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>

[ Upstream commit 9cb46b31f3d08ed3fce86349e8c12f96d7c88717 ]

Addressing potential overflow in result of  multiplication of two lower
precision (u32) operands before widening it to higher precision
(u64).

-v2
Fix commit message and description. (Rodrigo)

Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240401175300.3823653-1-himal.prasad.ghimiray@intel.com
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
(cherry picked from commit 34820967ae7b45411f8f4f737c2d63b0c608e0d7)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_migrate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_migrate.c b/drivers/gpu/drm/xe/xe_migrate.c
index 70480c3056021..7a6ad3469d748 100644
--- a/drivers/gpu/drm/xe/xe_migrate.c
+++ b/drivers/gpu/drm/xe/xe_migrate.c
@@ -216,7 +216,7 @@ static int xe_migrate_prepare_vm(struct xe_tile *tile, struct xe_migrate *m,
 		if (vm->flags & XE_VM_FLAG_64K && level == 1)
 			flags = XE_PDE_64K;
 
-		entry = vm->pt_ops->pde_encode_bo(bo, map_ofs + (level - 1) *
+		entry = vm->pt_ops->pde_encode_bo(bo, map_ofs + (u64)(level - 1) *
 						  XE_PAGE_SIZE, pat_index);
 		xe_map_wr(xe, &bo->vmap, map_ofs + XE_PAGE_SIZE * level, u64,
 			  entry | flags);
@@ -224,7 +224,7 @@ static int xe_migrate_prepare_vm(struct xe_tile *tile, struct xe_migrate *m,
 
 	/* Write PDE's that point to our BO. */
 	for (i = 0; i < num_entries - num_level; i++) {
-		entry = vm->pt_ops->pde_encode_bo(bo, i * XE_PAGE_SIZE,
+		entry = vm->pt_ops->pde_encode_bo(bo, (u64)i * XE_PAGE_SIZE,
 						  pat_index);
 
 		xe_map_wr(xe, &bo->vmap, map_ofs + XE_PAGE_SIZE +
@@ -280,7 +280,7 @@ static int xe_migrate_prepare_vm(struct xe_tile *tile, struct xe_migrate *m,
 #define VM_SA_UPDATE_UNIT_SIZE		(XE_PAGE_SIZE / NUM_VMUSA_UNIT_PER_PAGE)
 #define NUM_VMUSA_WRITES_PER_UNIT	(VM_SA_UPDATE_UNIT_SIZE / sizeof(u64))
 	drm_suballoc_manager_init(&m->vm_update_sa,
-				  (map_ofs / XE_PAGE_SIZE - NUM_KERNEL_PDE) *
+				  (size_t)(map_ofs / XE_PAGE_SIZE - NUM_KERNEL_PDE) *
 				  NUM_VMUSA_UNIT_PER_PAGE, 0);
 
 	m->pt_bo = bo;
@@ -479,7 +479,7 @@ static void emit_pte(struct xe_migrate *m,
 	struct xe_vm *vm = m->q->vm;
 	u16 pat_index;
 	u32 ptes;
-	u64 ofs = at_pt * XE_PAGE_SIZE;
+	u64 ofs = (u64)at_pt * XE_PAGE_SIZE;
 	u64 cur_ofs;
 
 	/* Indirect access needs compression enabled uncached PAT index */
-- 
2.43.0


