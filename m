Return-Path: <linux-kernel+bounces-115017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E51BC888C88
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4D8A28CD07
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05761C1397;
	Mon, 25 Mar 2024 00:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmSL00rl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD53B28452B;
	Sun, 24 Mar 2024 23:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323785; cv=none; b=skAI6R/ek4naf0nsWXkf8aETN6vpcm9HiieBqCtLIHrR4IoZRJX3QoBZ3tS/XI68VNiZwfcEizMxrFO/x3JuQCnEEqEOriJTnz/qOV8iv4SBzt3mCbxWj4QqlivdZWEv2Hsbnd8phT28SeA8fk0+C8fuDiUMNW1+q2csV4Vu+1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323785; c=relaxed/simple;
	bh=Ahjw586ptN4sdwzK489e5WfNo6aZ+MPOLgqVLZPcfa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PjBQmEjUTJhITcRu5lEV/DXPaoQdhqKAzhTupaejtG7AFp0PN1NUUXAlyb8BePJTyZYPKUm75bRNYSxGE7gdYk5wRMXk3ridX0PZ+jGdLydMYI4XNTNQU9RleC0k71KR3uE3AiwL3YN3u/cJ1VHnckWpDUFq7fy0Ni03v2mGiSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pmSL00rl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19BD3C433C7;
	Sun, 24 Mar 2024 23:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323785;
	bh=Ahjw586ptN4sdwzK489e5WfNo6aZ+MPOLgqVLZPcfa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pmSL00rlO9e8s7kBynQrlJ8UHI1Ar/gMgRHoUNNXjemrZMNQGhQse4kTEezW/dDJs
	 rTdEfjpK3QzZkzmIY58avGyuesPq5H3P3IOfOJRPSr1Y91Rv+ag5T1hqi9yjg3IrUR
	 CoAj1cAHvi7DYWQz2ELPQVlv3KnjDZvGoNqggdOvqOl17/v5cH1Z1rX8+z3B6eJ2O0
	 SMf8IVNDlgIuvJoFBiBQihP29Bmic9pq79RbDSRbnW0lp5nGqg3zbTfK+wcAW0Tt1M
	 2fi1hMieN+TaRq47cBqPV5lvV3rZ8LEV/0dymMhi1k3QHU8pUi0mNxD0Wk7RPMkeT7
	 2RfNAgA1z1Ztw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 162/238] drm/tegra: put drm_gem_object ref on error in tegra_fb_create
Date: Sun, 24 Mar 2024 19:39:10 -0400
Message-ID: <20240324234027.1354210-163-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index 01939c57fc74d..2040dbfed7e21 100644
--- a/drivers/gpu/drm/tegra/fb.c
+++ b/drivers/gpu/drm/tegra/fb.c
@@ -155,6 +155,7 @@ struct drm_framebuffer *tegra_fb_create(struct drm_device *drm,
 
 		if (gem->size < size) {
 			err = -EINVAL;
+			drm_gem_object_put(gem);
 			goto unreference;
 		}
 
-- 
2.43.0


