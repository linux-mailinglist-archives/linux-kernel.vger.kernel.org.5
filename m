Return-Path: <linux-kernel+bounces-114539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE012888AF5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CB921F2716E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A408F292291;
	Sun, 24 Mar 2024 23:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rqwh4oRO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BA422BBFD;
	Sun, 24 Mar 2024 23:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322171; cv=none; b=d7cdYFcH7sx47Z+Blrd+t1G1GyrJMQivg0ZoCf/HLbvOee/c6ZpkY4R5fk8UalUE6UU2QWYe5/gq66tCsS/PI1cKKuQI4LK58i+bAZHuLRd8oXoi7dnbfpdrbR7X/FsluSh9TfSfcWN3gX2rLXG6/VKgY8E+GKv9MDQnTRf4byE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322171; c=relaxed/simple;
	bh=913GoMK36PT+jGJN6eA4lIn3nEjpZjuN7+RaXAOia38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Um5Qowg2w4SXuHKpcZbb45ug8dPSWobnv+R9Ng3GdRI8k7DJ/atR8c2GUGAUgYkXEFcigu738BxpLKN48U7NZIlZ1O5Y2zYWBqKph/92zt6EVRMbMv+TznTCPU2UssqDd7Vmw2Q0/nghBVpHxjfXn3I6lleJP76Fjkz3bXaAiFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rqwh4oRO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BA5C43394;
	Sun, 24 Mar 2024 23:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322170;
	bh=913GoMK36PT+jGJN6eA4lIn3nEjpZjuN7+RaXAOia38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rqwh4oROV+OI1CfRseyJ0NVlEngV6Rp8umyMC6WlEA7HwmGimP3UEBFXiF8e7EzgJ
	 lDZGV+10HtNAsZDirSUu9ErVD4x/MFonRT+SAYV0JNGCBLLSTo5Rcqz+3clx5ruti+
	 aVG6NUxTJd1vJMpQNdFrpuxUFtJd3mP5cKLvgLPDydGGdNmlDjuE4jpsEGZRyr5mzR
	 e+ztgSSCqq22Y82Jx+dQm3IIHJ1qZNZwTf+3p5/wcTcVfNn2mFP5pFZhaDZl4rML7L
	 oiRbsAO5f3DkXfjkAbMZdnop8cPZVWLRh31WiCDPkrwFmMffh3AgtCJebkV+upV15K
	 6vKUY1YyrBrtA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hsin-Yi Wang <hsinyi@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 249/451] drm/panel-edp: use put_sync in unprepare
Date: Sun, 24 Mar 2024 19:08:45 -0400
Message-ID: <20240324231207.1351418-250-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Hsin-Yi Wang <hsinyi@chromium.org>

[ Upstream commit 49ddab089611ae5ddd0201ddbbf633da75bfcc25 ]

Some edp panel requires T10 (Delay from end of valid video data transmitted
by the Source device to power-off) less than 500ms. Using autosuspend with
delay set as 1000 violates this requirement.

Use put_sync_suspend in unprepare to meet the spec. For other cases (such
as getting EDID), it still uses autosuspend.

Suggested-by: Douglas Anderson <dianders@chromium.org>
Fixes: 3235b0f20a0a ("drm/panel: panel-simple: Use runtime pm to avoid excessive unprepare / prepare")
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20231220221418.2610185-1-hsinyi@chromium.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-edp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 42584d8a9aeb6..bfcddd4aa9322 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -413,8 +413,7 @@ static int panel_edp_unprepare(struct drm_panel *panel)
 	if (!p->prepared)
 		return 0;
 
-	pm_runtime_mark_last_busy(panel->dev);
-	ret = pm_runtime_put_autosuspend(panel->dev);
+	ret = pm_runtime_put_sync_suspend(panel->dev);
 	if (ret < 0)
 		return ret;
 	p->prepared = false;
-- 
2.43.0


