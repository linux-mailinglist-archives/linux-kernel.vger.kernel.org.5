Return-Path: <linux-kernel+bounces-113349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8518988839D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2CC9280DAD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54EB199E95;
	Sun, 24 Mar 2024 22:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1Hd5Cyl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAB5198B75;
	Sun, 24 Mar 2024 22:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320150; cv=none; b=NjAT0M13iTautpzJanwgl+JUt44uC1d/YKiFL1GcCEKaLL/sqXcFEsq+jTy69nQFkYer461sXh+6Pk2I8iMPw2JcFd2FhOVnUUytT0l3060Zv+290PsFo+VLcvM4KlROHTKLBWxc9Cvqm3l/g4inEnQoQUjrc2KUZIJPWf5FE3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320150; c=relaxed/simple;
	bh=1csZ9x4MyVNb8NfT0+Ah6w2V60OsIm+IajesknxVD8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kr1HpMhteQxF7wYee487pMwdmVPs6nV+hrtYa/knL8P9+B0MCd0ZMZCa+n7o78Uu/D8uc1QyDCzghTvTGPK4Ui3J4+LTvr/CRVDt4oHz3axh6f/wZulZ53K4RQpFysPgo09W/KS0IfdIZ3orWpqe5W1PIfP8JnGJV02JLU5lEQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1Hd5Cyl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335C0C43394;
	Sun, 24 Mar 2024 22:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320149;
	bh=1csZ9x4MyVNb8NfT0+Ah6w2V60OsIm+IajesknxVD8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b1Hd5CylH6jdeTwtHIEibNMBoljLlZGVHzuZVqqsfOEb3fLF2CWxoOupfvsmyqYI3
	 gk/hatObXj+9Vl2BJv+D/nSC2xkeIkrBfGoVrqEBh7T9eZgBzPdNgnisWVxlo9ZOIu
	 c0vkm3GydZEEJ3j5cF6g33ieZE85E157bhb71l23ghfC/JeB2r2fgOtrfzoD1nrylF
	 vboJkOkfiB0a9gnYXCtmGmzkVBUhyCQ/ZT0HbQ6e70zlesXuuHbejV7nI5OZi1aKcb
	 e76GhkGVSmDWvXcp/DvXoSuxO+kDf6bfMcEOasW7wvUc4+oqi8VyLqzyI5Yjtypp/J
	 6uMoCDSjuJP2w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 458/715] drm/tegra: put drm_gem_object ref on error in tegra_fb_create
Date: Sun, 24 Mar 2024 18:30:37 -0400
Message-ID: <20240324223455.1342824-459-sashal@kernel.org>
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

From: Fedor Pchelkin <pchelkin@ispras.ru>

[ Upstream commit 32e5a120a5105bce01561978ee55aee8e40ac0dc ]

Inside tegra_fb_create(), drm_gem_object_lookup() increments ref count of
the found object. But if the following size check fails then the last
found object's ref count should be put there as the unreferencing loop
can't detect this situation.

Found by Linux Verification Center (linuxtesting.org).

Fixes: de2ba664c30f ("gpu: host1x: drm: Add memory manager and fb")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231215093356.12067-1-pchelkin@ispras.ru
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tegra/fb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/tegra/fb.c b/drivers/gpu/drm/tegra/fb.c
index a719af1dc9a57..46170753699dc 100644
--- a/drivers/gpu/drm/tegra/fb.c
+++ b/drivers/gpu/drm/tegra/fb.c
@@ -159,6 +159,7 @@ struct drm_framebuffer *tegra_fb_create(struct drm_device *drm,
 
 		if (gem->size < size) {
 			err = -EINVAL;
+			drm_gem_object_put(gem);
 			goto unreference;
 		}
 
-- 
2.43.0


