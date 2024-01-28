Return-Path: <linux-kernel+bounces-41772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D1383F788
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EB371F243AD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44498002D;
	Sun, 28 Jan 2024 16:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tzxQyVmE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3232A4C624;
	Sun, 28 Jan 2024 16:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458495; cv=none; b=OcE/q9ki5MB/hhXWZ/qL4w0tlOxAYrW7q6/VysLAYr6sPhbnsk1kz+8Ietp1mj/NOu+DGIBbWSAsqnIm0fItmDAsS32yXZWrNbrv/vN9BKCo4eOOOfRrkRoNr5g2lcSmAeRRpd1wmvrOWBnJ7ioUtxE+gP4W0jXwUsPxRScqrbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458495; c=relaxed/simple;
	bh=xE/tker7J4yb4Hlmm1LNsVPMDTDiBWLvOQTZ6bAiT7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDE/MGpNntpg/X5d9VyvTNgOsIhNYgVw6JL84l8kVgzTokKIWBp30VVgTAaO3dswFv4XFaoXvaMxhZxtIjtHV82hhIvZQpUoS55LX3S4r+56KNI+R2yrYGHucSxR3t7n/47KYyfhZG3vCgsggCDhn4lTGeKPPNXRIzeg2i+zNbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tzxQyVmE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71E1C43390;
	Sun, 28 Jan 2024 16:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458495;
	bh=xE/tker7J4yb4Hlmm1LNsVPMDTDiBWLvOQTZ6bAiT7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tzxQyVmEJeoo9MFmUvWmYeuntt87o/jmOzgeJmexuS3vwz4cNE/MklD9t7IH6TzjT
	 ygmxBsrlSmRAPDZU78Ok4cIR6EZHjEvTJEO5alWbguv0eHfQCBAJOVs4qzk9RKa63F
	 deaKw34hL+qI3yqmwI6s2uaedFVwGoxBYZ7YOSFDyGzIOCPlfuGb5v3CfngI9RX3+D
	 cG1Vxy09ssYgND01xBEmij/WLo8LThPc4IcHnGXrCAZMuy9v5i4O8AqSeK9qWRn6pJ
	 u71cQvK6+1/11zIkVjrd+Mu23KwNwEZLVjfMt3686fIMvCDA5mTHeQ9O21dqkJu+zr
	 +wMw3fC+IXc/w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Philip Yang <Philip.Yang@amd.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Felix.Kuehling@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 17/27] drm/amdkfd: Fix lock dependency warning with srcu
Date: Sun, 28 Jan 2024 11:14:02 -0500
Message-ID: <20240128161424.203600-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161424.203600-1-sashal@kernel.org>
References: <20240128161424.203600-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.75
Content-Transfer-Encoding: 8bit

From: Philip Yang <Philip.Yang@amd.com>

[ Upstream commit 2a9de42e8d3c82c6990d226198602be44f43f340 ]

======================================================
WARNING: possible circular locking dependency detected
6.5.0-kfd-yangp #2289 Not tainted
------------------------------------------------------
kworker/0:2/996 is trying to acquire lock:
        (srcu){.+.+}-{0:0}, at: __synchronize_srcu+0x5/0x1a0

but task is already holding lock:
        ((work_completion)(&svms->deferred_list_work)){+.+.}-{0:0}, at:
	process_one_work+0x211/0x560

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #3 ((work_completion)(&svms->deferred_list_work)){+.+.}-{0:0}:
        __flush_work+0x88/0x4f0
        svm_range_list_lock_and_flush_work+0x3d/0x110 [amdgpu]
        svm_range_set_attr+0xd6/0x14c0 [amdgpu]
        kfd_ioctl+0x1d1/0x630 [amdgpu]
        __x64_sys_ioctl+0x88/0xc0

-> #2 (&info->lock#2){+.+.}-{3:3}:
        __mutex_lock+0x99/0xc70
        amdgpu_amdkfd_gpuvm_restore_process_bos+0x54/0x740 [amdgpu]
        restore_process_helper+0x22/0x80 [amdgpu]
        restore_process_worker+0x2d/0xa0 [amdgpu]
        process_one_work+0x29b/0x560
        worker_thread+0x3d/0x3d0

-> #1 ((work_completion)(&(&process->restore_work)->work)){+.+.}-{0:0}:
        __flush_work+0x88/0x4f0
        __cancel_work_timer+0x12c/0x1c0
        kfd_process_notifier_release_internal+0x37/0x1f0 [amdgpu]
        __mmu_notifier_release+0xad/0x240
        exit_mmap+0x6a/0x3a0
        mmput+0x6a/0x120
        do_exit+0x322/0xb90
        do_group_exit+0x37/0xa0
        __x64_sys_exit_group+0x18/0x20
        do_syscall_64+0x38/0x80

-> #0 (srcu){.+.+}-{0:0}:
        __lock_acquire+0x1521/0x2510
        lock_sync+0x5f/0x90
        __synchronize_srcu+0x4f/0x1a0
        __mmu_notifier_release+0x128/0x240
        exit_mmap+0x6a/0x3a0
        mmput+0x6a/0x120
        svm_range_deferred_list_work+0x19f/0x350 [amdgpu]
        process_one_work+0x29b/0x560
        worker_thread+0x3d/0x3d0

other info that might help us debug this:
Chain exists of:
  srcu --> &info->lock#2 --> (work_completion)(&svms->deferred_list_work)

Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
        lock((work_completion)(&svms->deferred_list_work));
                        lock(&info->lock#2);
			lock((work_completion)(&svms->deferred_list_work));
        sync(srcu);

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 4ecc4be1a910..5188c4d2e7c0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2241,8 +2241,10 @@ static void svm_range_deferred_list_work(struct work_struct *work)
 		mutex_unlock(&svms->lock);
 		mmap_write_unlock(mm);
 
-		/* Pairs with mmget in svm_range_add_list_work */
-		mmput(mm);
+		/* Pairs with mmget in svm_range_add_list_work. If dropping the
+		 * last mm refcount, schedule release work to avoid circular locking
+		 */
+		mmput_async(mm);
 
 		spin_lock(&svms->deferred_list_lock);
 	}
-- 
2.43.0


