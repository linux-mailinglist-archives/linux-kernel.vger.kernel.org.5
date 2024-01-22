Return-Path: <linux-kernel+bounces-33463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D8B8369FC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F007284E69
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA171130E20;
	Mon, 22 Jan 2024 15:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="moUXfeY5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9F050A84;
	Mon, 22 Jan 2024 15:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936403; cv=none; b=K860s4J4aJ9n9HHQMxHl4qnPhrEvWiTESvlCpKYzv5GB5oVbLHXDe4xY+zbQqlzmLRSBygVd69cZOLTCViHJb6CX0rMD7S7jEKM2SjoNvPaJ7HA1llz+FeaGD1Wj7NyTYZbqrccCtIWQwuWTHDy0cmpvya28VLS2lgVNLN+b+YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936403; c=relaxed/simple;
	bh=/VKhsWulm0iDGOxBxlboOPAiE34LfqITMZRgXC+HFaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Frtma2QFScSbm9sZ1XhjM8EqtxTc6Nnho5+rrG4w3yiDdvLD7a0c8DDZLtR2Ozvz8ZVfW8Ygk/5X5xnpLkhn0UqbeYqzC+TpLCsBUPsPskrD3Ms6mwxK2xZ9BL2RVnFd9bgG4YtQhe8DcQ8BcSf23SqKkNo6ZAKP5WSGlVnsKZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=moUXfeY5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67224C43601;
	Mon, 22 Jan 2024 15:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936402;
	bh=/VKhsWulm0iDGOxBxlboOPAiE34LfqITMZRgXC+HFaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=moUXfeY5pnusRyjhDZstBr00iq+1pxV0StIE54rW+qXT7iDd9HK8celw63JfhD94u
	 ICIXBg05lGSRIMTC0i3J2H2ENNnh2z9nMx16MPckMsRrG9wr58BYMTsE+aLa39AP1M
	 jQqqWMRMozQZOUlN6fqBgXErvITZH7vm0U78GO0rgfbP3KhVeo7UHqH9/iEGGHongW
	 cSaaWN7JBJooDVqicUjYIAaum2Tdg3Bz6iqZdTIJ2eIVoYc1VSb3ncAmcIyEfZ9irM
	 vAH5egPaKvhZ0d4g1EaSKM3juuHtrRVJspnZwkUSGuMQQQJjBwAwdwu1Ys9gu6kRG8
	 LtLx9FJAM9eLg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
	Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	jun.lei@amd.com,
	Qingqing.Zhuo@amd.com,
	wenjing.liu@amd.com,
	alvin.lee2@amd.com,
	samson.tam@amd.com,
	aric.cyr@amd.com,
	dillon.varone@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 07/35] drm/amd/display: Fix tiled display misalignment
Date: Mon, 22 Jan 2024 10:12:04 -0500
Message-ID: <20240122151302.995456-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151302.995456-1-sashal@kernel.org>
References: <20240122151302.995456-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
Content-Transfer-Encoding: 8bit

From: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>

[ Upstream commit c4b8394e76adba4f50a3c2696c75b214a291e24a ]

[Why]
When otg workaround is applied during clock update, otgs of
tiled display went out of sync.

[How]
To call dc_trigger_sync() after clock update to sync otgs again.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 3919e75fec16..ef151a1bc31c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1680,6 +1680,10 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 		wait_for_no_pipes_pending(dc, context);
 		/* pplib is notified if disp_num changed */
 		dc->hwss.optimize_bandwidth(dc, context);
+		/* Need to do otg sync again as otg could be out of sync due to otg
+		 * workaround applied during clock update
+		 */
+		dc_trigger_sync(dc, context);
 	}
 
 	if (dc->ctx->dce_version >= DCE_VERSION_MAX)
-- 
2.43.0


