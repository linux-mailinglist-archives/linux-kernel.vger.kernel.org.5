Return-Path: <linux-kernel+bounces-33503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC25C836A6A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 043AF1C23BA5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEB35579C;
	Mon, 22 Jan 2024 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwOUdquX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1164613BEA4;
	Mon, 22 Jan 2024 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936549; cv=none; b=NylrUSvICz1eT+gTnnsDkqf0i5Ek90h0sTdUE6UMQut6pT8IZE+TbqUCzynY7HQEk8QrrW7Bcjo7H3/+xjemDaJbOrzgTWBuQWAmV4x/sc/9fXfcWy5DfQnsaxuJ5I0MSDRexRW8//w17PwRVRSieC3aTR1DBJDiRM6UrV9W6sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936549; c=relaxed/simple;
	bh=fmNhLQmCfNnrEsba61EX41AiW53/0yH/dBbjhogA3oM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TGpeLZDpEciOWFv/bxEsjBYJ7wlNqS/3fxgev2OnipHPSjYsVWUR5Hs8+dFOg7dtzft3XwHhdW51WjF4aRWyRuYVZ30CJzLSKGg2g7RPQPwXvBaClVauktSc/IfE7oqnSu20OllPY7BnNelp/Iz6WvIQkonXoEVQbD51awTHnEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwOUdquX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B893C433F1;
	Mon, 22 Jan 2024 15:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936548;
	bh=fmNhLQmCfNnrEsba61EX41AiW53/0yH/dBbjhogA3oM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YwOUdquXoL3xfEuijiN6qcVd2x/jraPk10j3TkDICYAS6SXXUyWn7jjK73hiKBcfb
	 3GYgUgiX4ns2fVX313Nktn3tE1tR3/UWTk85jSRp2gyev74DTbVBO+rdizli+/Qoga
	 m29qRUOG3n25VZb+63T0YslcGy3tAhpNF7axUzno/1VHHomkz59pLUAq7PVhAP9tp7
	 kIwDTExj1mzb1TK4Zc5/J2m76MZoQ9s/dMBh6HYsJZwx1DddwOlzSWWl5Bh0OlMrfO
	 FhhFgdAIMMWY8F83Pi41MVWka5sITjSY+op3Dh7CWNCs6VpUQg71zma1hfr38mzk9u
	 D4WcFyBuP+nOg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Maxime Ripard <mripard@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.10 10/28] drm/drm_file: fix use of uninitialized variable
Date: Mon, 22 Jan 2024 10:14:36 -0500
Message-ID: <20240122151521.996443-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151521.996443-1-sashal@kernel.org>
References: <20240122151521.996443-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
Content-Transfer-Encoding: 8bit

From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

[ Upstream commit 1d3062fad9c7313fff9970a88e0538a24480ffb8 ]

smatch reports:

drivers/gpu/drm/drm_file.c:967 drm_show_memory_stats() error: uninitialized symbol 'supported_status'.

'supported_status' is only set in one code path. I'm not familiar with
the code to say if that path will always be ran in real life, but
whether that is the case or not, I think it is good to initialize
'supported_status' to 0 to silence the warning (and possibly fix a bug).

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231103-uninit-fixes-v2-1-c22b2444f5f5@ideasonboard.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index 537e7de8e9c3..93da7b5d785b 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -411,7 +411,7 @@ int drm_open(struct inode *inode, struct file *filp)
 {
 	struct drm_device *dev;
 	struct drm_minor *minor;
-	int retcode;
+	int retcode = 0;
 	int need_setup = 0;
 
 	minor = drm_minor_acquire(iminor(inode));
-- 
2.43.0


