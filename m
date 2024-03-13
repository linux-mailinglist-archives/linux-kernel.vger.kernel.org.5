Return-Path: <linux-kernel+bounces-101902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 674F887AC93
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2451028A4C1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9BB81731;
	Wed, 13 Mar 2024 16:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIF92ouT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEEF81219;
	Wed, 13 Mar 2024 16:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348039; cv=none; b=oFCXUx8k2uUa/WebAC69H7y8HNfam2MKT+uuymElAdPgOJVNCxR9bfSzF2I/9f+6R9S/p1zJ7W6IQh7kzK0fD7bytXb9scz0l7OClZSfYXPEMGb7tz3EHlSBqa/HCFMntdIQZr2cGuuXfzXrpj1UQHiDXG4t09KFsa6bllp0PV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348039; c=relaxed/simple;
	bh=a6IhWdWXdOwczKFyKIuSC60sB+c8ssghEzrNz4Ee4UM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=URzWRDM7FhhcdS/SBbHli8uIn8OswzJzSzYOQeLu6sFpw76XZa0IC1LnN72OhhNv6bmkw/yAXFYT8XDyuOlszy5LuXYY7TLLiI8xkWqRPed2wWtXWkltB2PQDfXAGmlsatO/sQubNp0T0vUQsSIbtuQNflG+5Rj5Un7LQsXjFFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIF92ouT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F392C433A6;
	Wed, 13 Mar 2024 16:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348039;
	bh=a6IhWdWXdOwczKFyKIuSC60sB+c8ssghEzrNz4Ee4UM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hIF92ouT9ND30z8+QINzYEm3UFzJ7/cg7/+vpVqpAG1oKXMsXOtDNAUc6fyizy15S
	 jIsBBPlXh21a07fTGGJuje06+2db+xLfpSZ1aVeYyyriPpdtefejI5O0cHq9RLKldq
	 n1W6+1QDEtzSASajSopJasMwbdJu/9zenq8VuLpslgNSl/wf9YWmLivAZnC3BqDeLS
	 noxMeKV6P4Sp4f+FZc0EsC6sH6Phin716n/orz+Y15g0D/a88PBehFsGg+x/MqbU7Y
	 u59CQJ0XVWi7IKmvwUhGV1R52jYVcV/V5kZWRGQnoVCR9vv/QTbJ9sRjsyQ90v8ZIs
	 Z6fOHstMdRRcQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Jerry Zuo <jerry.zuo@amd.com>,
	Jun Lei <Jun.Lei@amd.com>,
	Wayne Lin <Wayne.Lin@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 34/71] drm/amd/display: Fix uninitialized variable usage in core_link_ 'read_dpcd() & write_dpcd()' functions
Date: Wed, 13 Mar 2024 12:39:20 -0400
Message-ID: <20240313163957.615276-35-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163957.615276-1-sashal@kernel.org>
References: <20240313163957.615276-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.82-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.82-rc1
X-KernelTest-Deadline: 2024-03-15T16:39+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit a58371d632ebab9ea63f10893a6b6731196b6f8d ]

The 'status' variable in 'core_link_read_dpcd()' &
'core_link_write_dpcd()' was uninitialized.

Thus, initializing 'status' variable to 'DC_ERROR_UNEXPECTED' by default.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dpcd.c:226 core_link_read_dpcd() error: uninitialized symbol 'status'.
drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dpcd.c:248 core_link_write_dpcd() error: uninitialized symbol 'status'.

Cc: stable@vger.kernel.org
Cc: Jerry Zuo <jerry.zuo@amd.com>
Cc: Jun Lei <Jun.Lei@amd.com>
Cc: Wayne Lin <Wayne.Lin@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dpcd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpcd.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpcd.c
index af110bf9470fa..aefca9756dbe8 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpcd.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpcd.c
@@ -202,7 +202,7 @@ enum dc_status core_link_read_dpcd(
 	uint32_t extended_size;
 	/* size of the remaining partitioned address space */
 	uint32_t size_left_to_read;
-	enum dc_status status;
+	enum dc_status status = DC_ERROR_UNEXPECTED;
 	/* size of the next partition to be read from */
 	uint32_t partition_size;
 	uint32_t data_index = 0;
@@ -231,7 +231,7 @@ enum dc_status core_link_write_dpcd(
 {
 	uint32_t partition_size;
 	uint32_t data_index = 0;
-	enum dc_status status;
+	enum dc_status status = DC_ERROR_UNEXPECTED;
 
 	while (size) {
 		partition_size = dpcd_get_next_partition_size(address, size);
-- 
2.43.0


