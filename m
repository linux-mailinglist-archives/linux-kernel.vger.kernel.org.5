Return-Path: <linux-kernel+bounces-113552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB13C88853D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 826D92843D3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24F41C42E7;
	Sun, 24 Mar 2024 22:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABi1Tlvj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB3E1C42CD;
	Sun, 24 Mar 2024 22:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320355; cv=none; b=mqQPUtCr5JPH2RdOen7LkqO55DkIhFawgH7HFs2aevlq5GoqMfQhcsEiHWIERLfiQsTQt6kpIu89gNrQ/9Fmp5CYvCX0eMaQlyvg0Q7/g0UO/uN5+5bCQOP0kJdvOrfkbHa7yB/8QhV9AKsTYfn4mEq1Sf9DEfaaxLDJtv7OL5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320355; c=relaxed/simple;
	bh=4Q5VSj8UVNpxlhvvNrZRTDDSe/QJXv1nABEHoGyUDxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rvS4ZB0aemE4JD9stJz7ZHaPyNSDT8zqM1nvbwC90GUOvJYCSSq/rdEpGp4dvjG8CbJaKDISyQWXsFJ6cVSvyBctRM/rQpkAZNxzFS3VxjIgxd7A3XRzCF4/Qh9s63w7rW3ZZE6Ue8sVhuL+4YMD5s1q9QV19sF8tnAEA+z9XRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABi1Tlvj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1936C433F1;
	Sun, 24 Mar 2024 22:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320354;
	bh=4Q5VSj8UVNpxlhvvNrZRTDDSe/QJXv1nABEHoGyUDxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ABi1TlvjDEEM5c2XT2KXn8F5XRNWS2M/U6NqTxJ9nIJrtH02SCTJszS4z/2C6xhhQ
	 sqaOh7R4MnDk/qkpUjLUdqrHRvWyP/vlThX6WVRyQde/nAJllCmpEs+bBKvDrRMh2+
	 SsFufh98crmTaOA8Rkn+ewOwW09Jo5r0JGq+CeU8R1yFtJbnHCTX9++I4f9aq9z6rs
	 WcjCuhDxgemMGYsp4/2PSgvnPYoXlMTvO0rk5TUq9HE7bUyfMVmTy55d1s+7uBWEJN
	 eH27sBg+A6rM43fWQAYcJjTuPPQ3wXvLxcnKvYbKhAaGvlWlUox9U1Nw2q3sSeCJC5
	 GB0ysButTPKEQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 661/715] drm/xe: Invalidate userptr VMA on page pin fault
Date: Sun, 24 Mar 2024 18:34:00 -0400
Message-ID: <20240324223455.1342824-662-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Matthew Brost <matthew.brost@intel.com>

[ Upstream commit 386021394394eccef248dc5eb9c9370240821a8c ]

Rather than return an error to the user or ban the VM when userptr VMA
page pin fails with -EFAULT, invalidate VMA mappings. This supports the
UMD use case of freeing userptr while still having bindings.

Now that non-faulting VMs can invalidate VMAs, drop the usm prefix for
the tile_invalidated member.

v2:
 - Fix build error (CI)
v3:
 - Don't invalidate VMA if in fault mode, rather kill VM (Thomas)
 - Update commit message with tile_invalidated name chagne (Thomas)
 - Wait VM bookkeep slots with VM resv lock (Thomas)
v4:
 - Move list_del_init(&userptr.repin_link) after error check (Thomas)
 - Assert not in fault mode (Matthew)

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240312183907.933835-1-matthew.brost@intel.com
(cherry picked from commit 521db22a1d70dbc596a07544a738416025b1b63c)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_gt_pagefault.c |  4 ++--
 drivers/gpu/drm/xe/xe_trace.h        |  2 +-
 drivers/gpu/drm/xe/xe_vm.c           | 32 +++++++++++++++++++++-------
 drivers/gpu/drm/xe/xe_vm_types.h     |  7 ++----
 4 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_gt_pagefault.c b/drivers/gpu/drm/xe/xe_gt_pagefault.c
index e2cf1759527c6..ab8536c4fd580 100644
--- a/drivers/gpu/drm/xe/xe_gt_pagefault.c
+++ b/drivers/gpu/drm/xe/xe_gt_pagefault.c
@@ -69,7 +69,7 @@ static bool access_is_atomic(enum access_type access_type)
 static bool vma_is_valid(struct xe_tile *tile, struct xe_vma *vma)
 {
 	return BIT(tile->id) & vma->tile_present &&
-		!(BIT(tile->id) & vma->usm.tile_invalidated);
+		!(BIT(tile->id) & vma->tile_invalidated);
 }
 
 static bool vma_matches(struct xe_vma *vma, u64 page_addr)
@@ -226,7 +226,7 @@ static int handle_pagefault(struct xe_gt *gt, struct pagefault *pf)
 
 	if (xe_vma_is_userptr(vma))
 		ret = xe_vma_userptr_check_repin(to_userptr_vma(vma));
-	vma->usm.tile_invalidated &= ~BIT(tile->id);
+	vma->tile_invalidated &= ~BIT(tile->id);
 
 unlock_dma_resv:
 	drm_exec_fini(&exec);
diff --git a/drivers/gpu/drm/xe/xe_trace.h b/drivers/gpu/drm/xe/xe_trace.h
index 4ddc55527f9ab..846f14507d5ff 100644
--- a/drivers/gpu/drm/xe/xe_trace.h
+++ b/drivers/gpu/drm/xe/xe_trace.h
@@ -468,7 +468,7 @@ DEFINE_EVENT(xe_vma, xe_vma_userptr_invalidate,
 	     TP_ARGS(vma)
 );
 
-DEFINE_EVENT(xe_vma, xe_vma_usm_invalidate,
+DEFINE_EVENT(xe_vma, xe_vma_invalidate,
 	     TP_PROTO(struct xe_vma *vma),
 	     TP_ARGS(vma)
 );
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 3b21afe5b4883..a2397f232efc6 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -706,6 +706,7 @@ int xe_vm_userptr_pin(struct xe_vm *vm)
 	int err = 0;
 	LIST_HEAD(tmp_evict);
 
+	xe_assert(vm->xe, !xe_vm_in_fault_mode(vm));
 	lockdep_assert_held_write(&vm->lock);
 
 	/* Collect invalidated userptrs */
@@ -722,11 +723,27 @@ int xe_vm_userptr_pin(struct xe_vm *vm)
 	list_for_each_entry_safe(uvma, next, &vm->userptr.repin_list,
 				 userptr.repin_link) {
 		err = xe_vma_userptr_pin_pages(uvma);
-		if (err < 0)
-			return err;
+		if (err == -EFAULT) {
+			list_del_init(&uvma->userptr.repin_link);
 
-		list_del_init(&uvma->userptr.repin_link);
-		list_move_tail(&uvma->vma.combined_links.rebind, &vm->rebind_list);
+			/* Wait for pending binds */
+			xe_vm_lock(vm, false);
+			dma_resv_wait_timeout(xe_vm_resv(vm),
+					      DMA_RESV_USAGE_BOOKKEEP,
+					      false, MAX_SCHEDULE_TIMEOUT);
+
+			err = xe_vm_invalidate_vma(&uvma->vma);
+			xe_vm_unlock(vm);
+			if (err)
+				return err;
+		} else {
+			if (err < 0)
+				return err;
+
+			list_del_init(&uvma->userptr.repin_link);
+			list_move_tail(&uvma->vma.combined_links.rebind,
+				       &vm->rebind_list);
+		}
 	}
 
 	return 0;
@@ -2010,7 +2027,7 @@ static int xe_vm_prefetch(struct xe_vm *vm, struct xe_vma *vma,
 			return err;
 	}
 
-	if (vma->tile_mask != (vma->tile_present & ~vma->usm.tile_invalidated)) {
+	if (vma->tile_mask != (vma->tile_present & ~vma->tile_invalidated)) {
 		return xe_vm_bind(vm, vma, q, xe_vma_bo(vma), syncs, num_syncs,
 				  true, first_op, last_op);
 	} else {
@@ -3184,9 +3201,8 @@ int xe_vm_invalidate_vma(struct xe_vma *vma)
 	u8 id;
 	int ret;
 
-	xe_assert(xe, xe_vm_in_fault_mode(xe_vma_vm(vma)));
 	xe_assert(xe, !xe_vma_is_null(vma));
-	trace_xe_vma_usm_invalidate(vma);
+	trace_xe_vma_invalidate(vma);
 
 	/* Check that we don't race with page-table updates */
 	if (IS_ENABLED(CONFIG_PROVE_LOCKING)) {
@@ -3224,7 +3240,7 @@ int xe_vm_invalidate_vma(struct xe_vma *vma)
 		}
 	}
 
-	vma->usm.tile_invalidated = vma->tile_mask;
+	vma->tile_invalidated = vma->tile_mask;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/xe/xe_vm_types.h b/drivers/gpu/drm/xe/xe_vm_types.h
index 7300eea5394ba..5b96549479504 100644
--- a/drivers/gpu/drm/xe/xe_vm_types.h
+++ b/drivers/gpu/drm/xe/xe_vm_types.h
@@ -83,11 +83,8 @@ struct xe_vma {
 		struct work_struct destroy_work;
 	};
 
-	/** @usm: unified shared memory state */
-	struct {
-		/** @tile_invalidated: VMA has been invalidated */
-		u8 tile_invalidated;
-	} usm;
+	/** @tile_invalidated: VMA has been invalidated */
+	u8 tile_invalidated;
 
 	/** @tile_mask: Tile mask of where to create binding for this VMA */
 	u8 tile_mask;
-- 
2.43.0


