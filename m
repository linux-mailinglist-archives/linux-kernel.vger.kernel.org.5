Return-Path: <linux-kernel+bounces-154282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA4A8ADA3F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CAF3B2894F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CD216E888;
	Mon, 22 Apr 2024 23:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICIJlkTZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EC716DEDD;
	Mon, 22 Apr 2024 23:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830219; cv=none; b=TfqszKTETnG7MvjmS87zHqz2dIgScT9LhKbtHzXS5Nc5xnlnAd9oa5dPAdEp82UKA8a0uXdv+GvGzAf2ua4cNcypkcB6AQ9eyG5tk1l62TyPHv/gwGdJeX/PNodPN8MGQsz/iTKO1xSbQzEyoSuPHvp1wMoXCxcg2EYrzsKbO1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830219; c=relaxed/simple;
	bh=EXCJ+V8SmdEPBMqU6mG4n8sBBWp3gDKxqrjHcoHQGeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GFjmIWP5Wrfl+iMeYCW1305rdVnlr19CranKvbxDslVPw8ZAw6zFJ3w4jfyy2eQv/xYzPMGoliWRISTzEXKnZzS2BfBTZW/TiSxpa5OB8DpjYgfyqcQpo+oMHSp7iT/t5nRr/6LebDEqGHmqfU143zkjboCQOj9mYVQhXMp6Zrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICIJlkTZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5585C3277B;
	Mon, 22 Apr 2024 23:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830219;
	bh=EXCJ+V8SmdEPBMqU6mG4n8sBBWp3gDKxqrjHcoHQGeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ICIJlkTZAHiaFlIf7jJNeVExAnK/V7O8x8NBOblaXt9RAehnYdjBB7jcFQMK1lVJ1
	 NnqMInHkUCxVxviUlMX/Z7pJzLBqXRgKaxFLnN0jbZLWQ74LY0Jx7az6gbw2LtBguX
	 DN/3cfZnY7sCNdvnlQSaPRUKDZ1su14OnZ+FX4JjO50XvKHfWjAxDtsxiiSmGer7ex
	 tGLfFM0Y3osEGZ81nBN5zGsT1lAt1eRzLedtgEPwFCuvZbgQw+3UomEWsDnu1Iv8gu
	 OAkWD5WLOQWj4fnvQsy/BuDpJEXJpk5PBOr0bDWG/EtculgiQ2+k74PIwBwq6RbiAt
	 j64AEotj+knVQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhigang Luo <Zhigang.Luo@amd.com>,
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
Subject: [PATCH AUTOSEL 6.6 21/29] amd/amdkfd: sync all devices to wait all processes being evicted
Date: Mon, 22 Apr 2024 19:17:02 -0400
Message-ID: <20240422231730.1601976-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231730.1601976-1-sashal@kernel.org>
References: <20240422231730.1601976-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.28
Content-Transfer-Encoding: 8bit

From: Zhigang Luo <Zhigang.Luo@amd.com>

[ Upstream commit d06af584be5a769d124b7302b32a033e9559761d ]

If there are more than one device doing reset in parallel, the first
device will call kfd_suspend_all_processes() to evict all processes
on all devices, this call takes time to finish. other device will
start reset and recover without waiting. if the process has not been
evicted before doing recover, it will be restored, then caused page
fault.

Signed-off-by: Zhigang Luo <Zhigang.Luo@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 93ce181eb3baa..913c70a0ef44f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -935,7 +935,6 @@ void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
 {
 	struct kfd_node *node;
 	int i;
-	int count;
 
 	if (!kfd->init_complete)
 		return;
@@ -943,12 +942,10 @@ void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
 	/* for runtime suspend, skip locking kfd */
 	if (!run_pm) {
 		mutex_lock(&kfd_processes_mutex);
-		count = ++kfd_locked;
-		mutex_unlock(&kfd_processes_mutex);
-
 		/* For first KFD device suspend all the KFD processes */
-		if (count == 1)
+		if (++kfd_locked == 1)
 			kfd_suspend_all_processes();
+		mutex_unlock(&kfd_processes_mutex);
 	}
 
 	for (i = 0; i < kfd->num_nodes; i++) {
@@ -959,7 +956,7 @@ void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
 
 int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
 {
-	int ret, count, i;
+	int ret, i;
 
 	if (!kfd->init_complete)
 		return 0;
@@ -973,12 +970,10 @@ int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
 	/* for runtime resume, skip unlocking kfd */
 	if (!run_pm) {
 		mutex_lock(&kfd_processes_mutex);
-		count = --kfd_locked;
-		mutex_unlock(&kfd_processes_mutex);
-
-		WARN_ONCE(count < 0, "KFD suspend / resume ref. error");
-		if (count == 0)
+		if (--kfd_locked == 0)
 			ret = kfd_resume_all_processes();
+		WARN_ONCE(kfd_locked < 0, "KFD suspend / resume ref. error");
+		mutex_unlock(&kfd_processes_mutex);
 	}
 
 	return ret;
-- 
2.43.0


