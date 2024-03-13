Return-Path: <linux-kernel+bounces-101979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1298E87AD49
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4131F1C22136
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A516C146E71;
	Wed, 13 Mar 2024 16:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAYePT2F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CB114600D;
	Wed, 13 Mar 2024 16:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348189; cv=none; b=T4zub0F0Uu7TJ0NCfhrFvaMoFSm1B3fIjHnCv1USeOs4xjcXAJpRJtwiVt1oU+su8PgmZbVYHLkH+E2yA5WScUfPZoihnz0qk1skzmxjP7tVogq0fz5b/VqB3JeVjekFSBzYSR3tSr5UCHcxjwU8bXlLZWKr5d9EM7R96t6Sn1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348189; c=relaxed/simple;
	bh=MmP7YXHxW0FUCck29DRUrd4GsX2NbUzPP9VMeEKAEII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XrPN0Ce+IIfs9G9fpzAOvNUfVdM9zKdKEDZzjjOJbHMTFsTH9Eom0BxQcIidobvsZ/d5UhkDLHgB5+bkGgLFti/6vTvwI1OktGFEeOeO8ZYqKr51qHflsohn0Cp6f5s309/SBjmzsFMKQEHQ/gVOeDSeMFtAtkmufMpzbl5hTWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAYePT2F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73421C433C7;
	Wed, 13 Mar 2024 16:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348188;
	bh=MmP7YXHxW0FUCck29DRUrd4GsX2NbUzPP9VMeEKAEII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LAYePT2Fd37oNGIJDTX+YeRWFYv8j1W4QFdpN283FbtiWEWzU3D59kmVOyP+5+KN2
	 xVvkuSSD+aH1NEhK3j6pHKCx8nAEieUaNoVaSKjBUxl8PptmFCkiDpIQZd0PnVwQRT
	 NU56wtkvOlDW6b4YgB7shSmu/DleiSQe8grCnw5UKyrVT6tr7alAcfkRXUZeQ33s0O
	 pmTsKQF0UuG61AMUwQLkBPzif1RCIA1ua2+fIxOd6Zq8TJNc7umZuj10i1Ute0o0wF
	 hbIOSSVBI39Sq9FSDeLEg9IxWwfdR105gYKkbL7t5q+u2WjJsyKCZ780LX9gUUrqtC
	 3BJNkJdVwtIrg==
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
Subject: [PATCH 5.15 39/76] drm/amd/display: Fix uninitialized variable usage in core_link_ 'read_dpcd() & write_dpcd()' functions
Date: Wed, 13 Mar 2024 12:41:46 -0400
Message-ID: <20240313164223.615640-40-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164223.615640-1-sashal@kernel.org>
References: <20240313164223.615640-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.152-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.152-rc1
X-KernelTest-Deadline: 2024-03-15T16:42+00:00
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
index 72970e49800a6..3978cd5ea08a7 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpcd.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpcd.c
@@ -199,7 +199,7 @@ enum dc_status core_link_read_dpcd(
 	uint32_t extended_size;
 	/* size of the remaining partitioned address space */
 	uint32_t size_left_to_read;
-	enum dc_status status;
+	enum dc_status status = DC_ERROR_UNEXPECTED;
 	/* size of the next partition to be read from */
 	uint32_t partition_size;
 	uint32_t data_index = 0;
@@ -228,7 +228,7 @@ enum dc_status core_link_write_dpcd(
 {
 	uint32_t partition_size;
 	uint32_t data_index = 0;
-	enum dc_status status;
+	enum dc_status status = DC_ERROR_UNEXPECTED;
 
 	while (size) {
 		partition_size = dpcd_get_next_partition_size(address, size);
-- 
2.43.0


