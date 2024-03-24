Return-Path: <linux-kernel+bounces-113553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B9388853F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F23F284A0E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15171C42CF;
	Sun, 24 Mar 2024 22:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbHmVXw1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1149B1C42EA;
	Sun, 24 Mar 2024 22:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320356; cv=none; b=dgNa6PyRdwSyQ56JHYY8ctH+Hi1ugwDJNePDQC9Gl1Hs1mQqqKNS0TbPrrPxKo0nl5RiteOnimxT63arPEWcQlPhDoki6CRPK53pHZ3fGGhwU8Q5+sj/sAIeccGBDGzxr1QqCnHiXC4mShEBduiFV1HHbifrPv0qxcESbTJec9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320356; c=relaxed/simple;
	bh=MUD/L+E4Go/mAWKJhDeIwLthUhEDDbSwGLdfwXkCbZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EjCSzsU5O58yOmUGkuCbo6KmJQe72S6EkK6RwbKLtyToY+zhYaaibDsZlQZ6WWRtvFWAvt3AmSrWdCBNybsc/eBlM22zMLpuKjwFMaWW4azVq7UiHdWUGvQVgnORGj9WNuCjKJGAUkCkaMnt8ZSzBnocPfHraHXgjQ7EMiuIIMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbHmVXw1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBAAAC433B1;
	Sun, 24 Mar 2024 22:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320355;
	bh=MUD/L+E4Go/mAWKJhDeIwLthUhEDDbSwGLdfwXkCbZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hbHmVXw1i6L7NzVt8MFF7/6NltC9IcJ5JY/3gGXkJ5WmAUzzgv2lhCPFlEi1pTJcf
	 y6KmRaboLeEBLT0MfXSV1jXJwcaQtGnG1Xg2WOAnwfj2B0MgRfwRFTJSU/Y/5Eaa17
	 CGfx87t4HN2qRGNpSgnwxu2OU4dFJ8CGi0t5heISWkGpoYOR+1/DyEps2Xr8r76bvZ
	 YtdF8RNeSaNlAINa2UVA5zja7C/n8X3e+JDKg1BdoQoGxqPndqEaab2gb4zLHqZ04+
	 nj1+NIjIcXoOucFgfxM0Ocrbl+MHq3HBs47mIYtpfDPONTbeXn9JFapZnNMOD6x/ke
	 /mxj3dDIYM3aw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
	Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 662/715] drm/xe: Skip VMAs pin when requesting signal to the last XE_EXEC
Date: Sun, 24 Mar 2024 18:34:01 -0400
Message-ID: <20240324223455.1342824-663-sashal@kernel.org>
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

From: José Roberto de Souza <jose.souza@intel.com>

[ Upstream commit dd8a07f06dfd946e0eea1a3323d52e7c28a6ed80 ]

Doing a XE_EXEC with num_batch_buffer == 0 makes signals passed as
argument to be signaled when the last real XE_EXEC is completed.
But to do that it was first pinning all VMAs in drm_gpuvm_exec_lock(),
this patch remove this pinning as it is not required.

This change also help Mesa implementing memory over-commiting recovery
as it needs to unbind not needed VMAs when the whole VM can't fit
in GPU memory but it can only do the unbiding when the last XE_EXEC
is completed.
So with this change Mesa can get the signal it want without getting
out-of-memory errors.

Fixes: eb9702ad2986 ("drm/xe: Allow num_batch_buffer / num_binds == 0 in IOCTLs")
Cc: Thomas Hellstrom <thomas.hellstrom@linux.intel.com>
Co-developed-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: José Roberto de Souza <jose.souza@intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240313171318.121066-1-jose.souza@intel.com
(cherry picked from commit 58480c1c912ff8146d067301a0d04cca318b4a66)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_exec.c | 41 ++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_exec.c b/drivers/gpu/drm/xe/xe_exec.c
index 17f26952e6656..222209b0d6904 100644
--- a/drivers/gpu/drm/xe/xe_exec.c
+++ b/drivers/gpu/drm/xe/xe_exec.c
@@ -196,6 +196,29 @@ int xe_exec_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
 			goto err_unlock_list;
 	}
 
+	if (!args->num_batch_buffer) {
+		err = xe_vm_lock(vm, true);
+		if (err)
+			goto err_unlock_list;
+
+		if (!xe_vm_in_lr_mode(vm)) {
+			struct dma_fence *fence;
+
+			fence = xe_sync_in_fence_get(syncs, num_syncs, q, vm);
+			if (IS_ERR(fence)) {
+				err = PTR_ERR(fence);
+				goto err_unlock_list;
+			}
+			for (i = 0; i < num_syncs; i++)
+				xe_sync_entry_signal(&syncs[i], NULL, fence);
+			xe_exec_queue_last_fence_set(q, vm, fence);
+			dma_fence_put(fence);
+		}
+
+		xe_vm_unlock(vm);
+		goto err_unlock_list;
+	}
+
 	vm_exec.vm = &vm->gpuvm;
 	vm_exec.num_fences = 1 + vm->xe->info.tile_count;
 	vm_exec.flags = DRM_EXEC_INTERRUPTIBLE_WAIT;
@@ -216,24 +239,6 @@ int xe_exec_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
 		goto err_exec;
 	}
 
-	if (!args->num_batch_buffer) {
-		if (!xe_vm_in_lr_mode(vm)) {
-			struct dma_fence *fence;
-
-			fence = xe_sync_in_fence_get(syncs, num_syncs, q, vm);
-			if (IS_ERR(fence)) {
-				err = PTR_ERR(fence);
-				goto err_exec;
-			}
-			for (i = 0; i < num_syncs; i++)
-				xe_sync_entry_signal(&syncs[i], NULL, fence);
-			xe_exec_queue_last_fence_set(q, vm, fence);
-			dma_fence_put(fence);
-		}
-
-		goto err_exec;
-	}
-
 	if (xe_exec_queue_is_lr(q) && xe_exec_queue_ring_full(q)) {
 		err = -EWOULDBLOCK;	/* Aliased to -EAGAIN */
 		skip_retry = true;
-- 
2.43.0


