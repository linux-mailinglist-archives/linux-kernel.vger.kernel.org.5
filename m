Return-Path: <linux-kernel+bounces-50366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAF2847812
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2882F28A564
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A2785927;
	Fri,  2 Feb 2024 18:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4+nrOQ3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD72129670;
	Fri,  2 Feb 2024 18:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899204; cv=none; b=m9R8042H75pC9JeRQmqA5XOjWmJ0a4XEQ9etgQ3bzwmmE6j+Lf7v7t5Dlg65H6Viol53Wk7dnWnFjh1QNy74D72V5Fcd2j9CYdG0ZWKOutK83OsEC7QAQ4S3eA+5y4tWYhbtcgZIQDgBjw0iP6Xl9/lmShCcb8yDLw1sQVAy90Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899204; c=relaxed/simple;
	bh=Xno+js/pInSv3K86aU9j/XKbnVZ3diw6jDM62hITqXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ikOg6ZRBQ6ImKU0Yk5n4nROUxqw8yhOmXcNWx+BAUl/mL7+PDmCZjBfACdbJmBm8p3ffjgCQnz82KrKn2iQkm8neAYwKlARJA7EXUM0Hg3mHs/ZLuJnrFvFbk1M7rS/XnWQzYd+w/4ysC+kd3yQLZNUqrKKrg+/FfypiTodd9Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4+nrOQ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51898C433F1;
	Fri,  2 Feb 2024 18:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899204;
	bh=Xno+js/pInSv3K86aU9j/XKbnVZ3diw6jDM62hITqXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z4+nrOQ3AphSkBfw7qQ5D5P49IiQ4KwONjhN89aANe+qmWdf8/LodzNv/85prPCbK
	 CaX7E4JrFGUEhSJx5pocBtGHvVRAOh6sFnjtc26zH0SLJ1ADQpaLr52eOI2KQ7/NsO
	 RCFX5YDyZgrGmwyJGFjeed6gz1amUX6SHxYhJjwJZZYr7o4hNWUIOhZV5XZvNytT+S
	 LzLnCyrIbTiLDOYeQFW0XWqorZM+jrGVFiakxOAYmJ0jw2BirNbD/QrDLhSToHuaXI
	 pdgJQGtOAsv/KSrxdmyRQB5QdC7zW+N6/wg4bW/lzHM+C3C+u1I3LV4UZF5csdevUp
	 fBcb0hhmIHcGQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Roman Li <Roman.Li@amd.com>,
	Mark Broadworth <mark.broadworth@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	alex.hung@amd.com,
	srinivasan.shanmugam@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.7 21/23] drm/amd/display: Disable ips before dc interrupt setting
Date: Fri,  2 Feb 2024 13:39:17 -0500
Message-ID: <20240202183926.540467-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202183926.540467-1-sashal@kernel.org>
References: <20240202183926.540467-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.3
Content-Transfer-Encoding: 8bit

From: Roman Li <Roman.Li@amd.com>

[ Upstream commit 8894b9283afd35b8d22ae07a0c118eb5f7d2e78b ]

[Why]
While in IPS2 an access to dcn registers is not allowed.
If interrupt results in dc call, we should disable IPS.

[How]
Safeguard register access in IPS2 by disabling idle optimization
before calling dc interrupt setting api.

Signed-off-by: Roman Li <Roman.Li@amd.com>
Tested-by: Mark Broadworth <mark.broadworth@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index 51467f132c26..d595030c3359 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -711,7 +711,7 @@ static inline int dm_irq_state(struct amdgpu_device *adev,
 {
 	bool st;
 	enum dc_irq_source irq_source;
-
+	struct dc *dc = adev->dm.dc;
 	struct amdgpu_crtc *acrtc = adev->mode_info.crtcs[crtc_id];
 
 	if (!acrtc) {
@@ -729,6 +729,9 @@ static inline int dm_irq_state(struct amdgpu_device *adev,
 
 	st = (state == AMDGPU_IRQ_STATE_ENABLE);
 
+	if (dc && dc->caps.ips_support && dc->idle_optimizations_allowed)
+		dc_allow_idle_optimizations(dc, false);
+
 	dc_interrupt_set(adev->dm.dc, irq_source, st);
 	return 0;
 }
-- 
2.43.0


