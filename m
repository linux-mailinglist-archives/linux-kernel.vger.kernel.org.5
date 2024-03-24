Return-Path: <linux-kernel+bounces-115686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4EE88970D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FB611C30967
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278A120C7E9;
	Mon, 25 Mar 2024 02:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gaZIOW0F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C405C20C031;
	Sun, 24 Mar 2024 23:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321627; cv=none; b=qV0QGHD7YWVAjdKnFjlwx3prCz1nbpXJsxmpkts6lUv9JqWugb2y7DlWelGcoYUUuspWpUXujOsQ3m8LuOPezB4VIiaJ9W1o4SvcosriGPaC5y3Eca5xlGnxw7c7oG6eCjEEdMxlKVdOW7xMOk7dA54qB6vy/y1yRxLCLvsgZK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321627; c=relaxed/simple;
	bh=O945Y65RtR8IS6CkelHaCAjziwhmZ9c1i9x5V/q+Yf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uDUx73LjB2wLmElmjfzn2YoMxePkLxrya4XhpwKxzFj8n4uPY3E7GxkfAGdoSLYNGyKFlNzNXFsokSCOTDtIVm7XKKRtxEfcE9AuXKD0JF/aiC4t+8KmSioiLoW8ZGHus8Y0vSCIe9oVaY9HoP6xVV8FnvCv2z6BMt/GnpYyfLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gaZIOW0F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1111CC433F1;
	Sun, 24 Mar 2024 23:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321626;
	bh=O945Y65RtR8IS6CkelHaCAjziwhmZ9c1i9x5V/q+Yf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gaZIOW0FJc/oNrfCqK0ldN3RiJGXmvNCMYimad5ltKqKbYoYrbAepg7L+wJGVNEkQ
	 y5pUZ80DTtIkmzz52RX28PbiA0dSWjN/nEPf5T2wcQnYmNb0GTKTsjN8nKJUrHtfON
	 AtKumhYGD0VAB802qGp8nvsiEcL4UmggfX78cp0JIIvL4u7zqF+hozE3SKLSWbt/z2
	 OpuDsgwoNe1wiaawDeWDnH6txOG5Jj9+dXSrG6ktWxkokmutcwO3QUD4SFZXabAC8i
	 ZfStxXVjGHSDs5dHRbV3QKywJDW510YXb00TL+Kn5Ji4Gt5iC7VpN1gqmWgLvNUH9E
	 qSQYDY2befhkw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hsin-Yi Wang <hsinyi@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 357/638] drm/panel-edp: use put_sync in unprepare
Date: Sun, 24 Mar 2024 18:56:34 -0400
Message-ID: <20240324230116.1348576-358-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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


