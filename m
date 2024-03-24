Return-Path: <linux-kernel+bounces-113811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA028886BA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3E8EB23603
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C770A14EC74;
	Sun, 24 Mar 2024 23:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lw2LP5oU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E0A1E6202;
	Sun, 24 Mar 2024 22:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320839; cv=none; b=GkHtD0YLA2ZiZGlyxkdrAsA4lCtpnDTie0LQ3xn8xr8AhMsQVwygMV4Xa+oQ903bYUm0c+70scRdfvB5a88WCn4A4nqG6hBG8HSRC2aqdd7fIfnpMaty5+2XZ3W6DCWF8akOzuWaUHDZdcOKJ1+f2HIeqqXImKtCBdyTIUyRW+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320839; c=relaxed/simple;
	bh=O945Y65RtR8IS6CkelHaCAjziwhmZ9c1i9x5V/q+Yf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XmZsa1Fvt42xtgvoud/0+0hfqrnJFm2vJFgOkj5OfRHJMzk2/jkhrQXVXTGXqWLdmwnQCF8Q5zcUFY7NzZemtAa9nuKa5ofB43rpaimycREFAAuHQ/Kymg1mqUjGpfyBP//2BGpUctQ4LHiikl+MtotfwObWJSccYMosBb/sGRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lw2LP5oU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42351C43399;
	Sun, 24 Mar 2024 22:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320837;
	bh=O945Y65RtR8IS6CkelHaCAjziwhmZ9c1i9x5V/q+Yf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lw2LP5oUACyVvilbBXRuQkB0Xk4dQodpsSv84uUe9IHFJSHoCt+kEJYhqI5s6xEYn
	 88tNcq2AO6SCQ83zUGQiRVm4t/UM3F4CZO4xDez1MX8S3B+hGJ61dQnz6EewaP+TXI
	 /Ac48PJ+SWiUSc5I36LDZuXN0o5loHRp7xyX/Yie5gx0aoGsRkh3AP3TuAF0Z50/M9
	 gf9ZgaVJ0V6ArIzcMc8UYihdrhVAXFqkuC96lR3a9YMpukkTRGj5P2l5KulOSAS/ul
	 0BWARI9zkZn2eUIgVx26DIYLeDXpuEsrX7OQfY/M6TQgFyB2a2FrVWLj9UIQI2/jQj
	 CHLJNZ9EYgbxw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hsin-Yi Wang <hsinyi@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 403/713] drm/panel-edp: use put_sync in unprepare
Date: Sun, 24 Mar 2024 18:42:09 -0400
Message-ID: <20240324224720.1345309-404-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index cba5a93e60822..70feee7876114 100644
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


