Return-Path: <linux-kernel+bounces-33554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 256A8836B39
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1613283AE8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5174714FCF7;
	Mon, 22 Jan 2024 15:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQY+T4sF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AD114FCE7;
	Mon, 22 Jan 2024 15:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936717; cv=none; b=PD0ERWHx1iNlQO0Iw5qc1qxo1ZHY47svKubDPHgfx9Qm/0FVV4t+3pY5Z8zYpCm8fl2FMOrzdW4clt6P7XC65X7xN2TAlr0XmBr7EyoRN94NnQcGuuArWuzVzJ+VKoSITRC8ZnfWwB3ZM00GY0ygbvjnh3DUoj63kLfq7+G0eW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936717; c=relaxed/simple;
	bh=Up+CEAGveMQX9WJ+5QixvdyK40PpYl0GjFlS8VIKIs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uv57Qrlvl7FAYEPPjJU4NTOByGZBGwJziR5jBwBRs6iOXoxDC3xaI+lO5u93Ic1/IwBQ/+QiaoWwWj3oJfUmNqF609uzDTrt/YQsnwo8n3+NkW6GTnYcDatMNugNZ+eOGOtiNswXLYTPb81v9qOaJeyA/HfPK7OIYcoRDiv5AwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQY+T4sF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA749C433F1;
	Mon, 22 Jan 2024 15:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936717;
	bh=Up+CEAGveMQX9WJ+5QixvdyK40PpYl0GjFlS8VIKIs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZQY+T4sFUw7v3o9Wl6EqvcvlJV+Xl1NQzfAZA0yWGmTSjthWF+jdrjuncPTKvfW9c
	 2fSot3GWqHX9POeghqzlhVTion0HJFJz4K/iZxcN5lVJ+lnAzwxOxVjutgF3F/PYkN
	 LZs1zDW/mC06ONlS6MkZeQ992S5v0aW4I+d4H8SrKVDCY63BEp/AsC/1my0uFvaraF
	 cp1FGsjojPPL//9dws+Imf5KlLyZHOW381W0SwjGvMl05/tbsd72HJwo82jdEAqMJJ
	 vInIjEFkxqdB3CdQW0QGDv1FhDoKH6dHIlW7qetFZDaXUYDHs6iRFrYJFq65qH6AVC
	 E3+9VJT4oJcTQ==
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
Subject: [PATCH AUTOSEL 4.19 06/23] drm/drm_file: fix use of uninitialized variable
Date: Mon, 22 Jan 2024 10:17:46 -0500
Message-ID: <20240122151823.997644-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151823.997644-1-sashal@kernel.org>
References: <20240122151823.997644-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.305
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
index 334addaca9c5..06cdae6f598c 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -299,7 +299,7 @@ int drm_open(struct inode *inode, struct file *filp)
 {
 	struct drm_device *dev;
 	struct drm_minor *minor;
-	int retcode;
+	int retcode = 0;
 	int need_setup = 0;
 
 	minor = drm_minor_acquire(iminor(inode));
-- 
2.43.0


