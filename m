Return-Path: <linux-kernel+bounces-33242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE63836716
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4078A1C226EE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCAA4E1CD;
	Mon, 22 Jan 2024 14:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iBi83o0r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34484D596;
	Mon, 22 Jan 2024 14:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935478; cv=none; b=UC6XhacSsXWSchibm0ZkuHr1ktZ3BTggerKR/WJtOtuISjvBk0VZm+twON05LIF/SXB9EfQ2DEPThA2FdqRJ/j1r2ZfZPklroNy9c6PBJl6L6FbnIvWNaR/wmBelRvjU2WxrXzhmSGoUbt1rGUlHK5en+sD4zobUZJH9mUhllyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935478; c=relaxed/simple;
	bh=I32G/hUKa6KyI2BniBMuFm3YI0BHeflPK5hT6eizRBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WMuMMMQnPkZ4/fZXW8rqkmA9njFK3neVhHsfIyJw1p24uHqg6eli2RG1rI5bSl8eutOg78hvuAv3Go/RruL+p8Eh7zGESnkOAJRqGH5pGwKSXU0JpKWwf6P0NAaNsUeHakKpTPl2YlkrhJXfhSe4bgrLIMZUEUnFHJZ2YEFKYuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iBi83o0r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C10FC43399;
	Mon, 22 Jan 2024 14:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935477;
	bh=I32G/hUKa6KyI2BniBMuFm3YI0BHeflPK5hT6eizRBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iBi83o0rYTEEVl+gzRnGQY0VTm9tgJHYzUVAFBfqa5UQUt8Br4PpYTNEKOCUFr7X0
	 McUfPxh9PHyIwTl52jwq6GWxHR/LMdKLUCD23Vve61DAG3Mb79yzdf/e6h2Jy6t4r1
	 +7Nafpu9BlZeG+rgSbqG7zeXqWOKeST78GP3wBjr0M6Otwmb7u7bBJW+TzG29W70QZ
	 YRZ1gOpoA8g5n6se2jYMYjul9zRbxJ4EZgB1736wwmiPwM3yQx4bxdh+6FMGYeEwYU
	 LVQNgJUZvTjV7VLALC8mKhj2m47AB4Lefzl34K5LYWzovfUzPywYjjxlR9r3zFvyxj
	 R5nFk5I+fUSpw==
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
Subject: [PATCH AUTOSEL 6.7 24/88] drm/drm_file: fix use of uninitialized variable
Date: Mon, 22 Jan 2024 09:50:57 -0500
Message-ID: <20240122145608.990137-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122145608.990137-1-sashal@kernel.org>
References: <20240122145608.990137-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
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
index 446458aca8e9..54a7103c1c0f 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -958,7 +958,7 @@ void drm_show_memory_stats(struct drm_printer *p, struct drm_file *file)
 {
 	struct drm_gem_object *obj;
 	struct drm_memory_stats status = {};
-	enum drm_gem_object_status supported_status;
+	enum drm_gem_object_status supported_status = 0;
 	int id;
 
 	spin_lock(&file->table_lock);
-- 
2.43.0


