Return-Path: <linux-kernel+bounces-33328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED83783686F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D7091F2138B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024013D982;
	Mon, 22 Jan 2024 15:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtcL7bwm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AB460EC1;
	Mon, 22 Jan 2024 15:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935903; cv=none; b=WV3tDkMGch5nvKEAp9hKLa/sfEJuNJFBruFDNfn6LtUeaJayujAeWxWVEwA9ByLufvJfnxDtjzfFZi8pFOFLaPn8Dt+zsxfXW7JyD0i988ZB0g15hsob6AdCZXM2bBK0vanrtbJuFuPKLfOwNGFSEpDIPbUOMv5KNOUyvFQN3po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935903; c=relaxed/simple;
	bh=iaT24gQu/lVRaUWt2L5gkzTasQU7clUVTSvmMWdxIu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D78eK94B8wIXx/jo4+T+In5EzF6hKK84SHc4n/a0WSS8bksFEL7eJ+UXj1fM9dZl7WnfHQfZgm1avprWepetd4AkDbSXdhTrz2yNAiAPIN0r+zXtwRq6bJWenb3mXsrbQyC/OuZqLYcZ40e6gGCM9CGp7TdMXL2ijKsglOMknmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtcL7bwm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D17AC433A6;
	Mon, 22 Jan 2024 15:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935903;
	bh=iaT24gQu/lVRaUWt2L5gkzTasQU7clUVTSvmMWdxIu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XtcL7bwma4gmgpQlgENtJnDlTdPdr8JuBEnFTjm1N9yynOR/c3E2JMY9RGnt9w1EG
	 8bQgpeZqBrRCB9xZUjU5ErodZoPRnG6K5nTsSYlUaxFKz8YKOhVNViptXerZ6bOg40
	 nCv70zFGay9UMxnyA83uzfEP8SKmemcZttgseVq1gyXQxKmkqE9xBlWLXADzcJP4Je
	 QD1iv8wSSeTST0BrQE91DG98caAQF1MsnM9WaYjvNRzukXoTfX2oUN5I2j6BAkZv6r
	 ueAc1MLWnICCABOWxyCuMGYcUQeKVdWcvmkwlYcDVdMgXqO3hothv0xp+V/ctIxYPB
	 eFNwtXtQErsBQ==
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
Subject: [PATCH AUTOSEL 6.6 11/73] drm/amd/display: Fix tiled display misalignment
Date: Mon, 22 Jan 2024 10:01:25 -0500
Message-ID: <20240122150432.992458-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150432.992458-1-sashal@kernel.org>
References: <20240122150432.992458-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.13
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
index a1be93f6385c..39b414774a1f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1948,6 +1948,10 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 		wait_for_no_pipes_pending(dc, context);
 		/* pplib is notified if disp_num changed */
 		dc->hwss.optimize_bandwidth(dc, context);
+		/* Need to do otg sync again as otg could be out of sync due to otg
+		 * workaround applied during clock update
+		 */
+		dc_trigger_sync(dc, context);
 	}
 
 	if (dc->hwss.update_dsc_pg)
-- 
2.43.0


