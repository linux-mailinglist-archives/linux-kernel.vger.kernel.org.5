Return-Path: <linux-kernel+bounces-113255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9068882AE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 373982876A7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E20E187E75;
	Sun, 24 Mar 2024 22:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6r9Cwkx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555791869EA;
	Sun, 24 Mar 2024 22:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320055; cv=none; b=CvJjZbZu19BcZRONtDiVeep0tjlbM7vUeXPPMmI1e9PkmP+NH5uCXkHRS+Y4bePh8S3xHeCvzNy8J2Km5oLgmWCiRDPmz55QiuPqZcGnyDyhnK8ryAzjCAhUvyZ2Ng50hFln3QnFKKIe7Uv0J5XsEUu8ybF7+0rjy7OHWnOk0ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320055; c=relaxed/simple;
	bh=XU6/lcTte6ODVuLBpwKzor3DKbsMmnjicRqB6FkGGXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZWUTCyJKnH5dp+S4kGK59adUqNY+0JoPnfG8yL5JoDBM8c+wvjc+Gn5Bsg2psiYAZW3df3DYLD9uKiklaEEvwcBw7OhvwMDyihfXnetXcf4Uy2Kb+X2lOiCgahns958gRPzQk+BUl6sr/W3q04lcQIjGDcuGkOA3P2AbKaZbk4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6r9Cwkx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49854C43394;
	Sun, 24 Mar 2024 22:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320054;
	bh=XU6/lcTte6ODVuLBpwKzor3DKbsMmnjicRqB6FkGGXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B6r9CwkxvmnjqNMK2IKdoAF0itjo8EfOMEDKHJHqgeAQKSfHTLzaj25pTYXJlF1II
	 sN00Gy/dTNJyCs0UkXe7xHYPtfkWwwxAZ6znwfPC6pPPWBeeXbmSzBS2IriDeRXcY0
	 wxNtiQ/eCXTx6y4NEy+bmLQvWbp72Vvtwa7VNZjWfIYCfZ9+YUOcwjXBYaEynccznb
	 30G1NsOwbvFJL1NTVeoHBqtIbMbC6p7/ErAVKdHh6mijj49vhHLoXkeJdr63c7rx94
	 lykm3HHjdItQov5SQE57p/RJ+Ofyk5UhC9AJo4GSbHIQgywolnkexNXhs6stt2oMrr
	 idTKElqlVyUiQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hsin-Yi Wang <hsinyi@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 364/715] drm/panel-edp: use put_sync in unprepare
Date: Sun, 24 Mar 2024 18:29:03 -0400
Message-ID: <20240324223455.1342824-365-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index a0b6f69b916f9..e5e3f0b9ca61d 100644
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


