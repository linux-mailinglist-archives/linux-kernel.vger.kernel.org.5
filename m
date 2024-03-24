Return-Path: <linux-kernel+bounces-115131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB46889440
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0FAEB2C7F3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84A11C6AD8;
	Mon, 25 Mar 2024 01:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jiJf0NDU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC481FB093;
	Sun, 24 Mar 2024 23:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324128; cv=none; b=VJ7YLShyJs1wRlZt6H6fcY78i+/z5TK95mPTtDBrynqwIg0ac/vCmhRJYwHrQgwuaZMvWabB8DBbXxXVVNTJDmbd1jpUTNRX6P0UACXNRYOLvIadY3EtO0z89Vi9hbMutnzalo/bj8QsUAIev+tRTqmQAcWDrHc5btT4+pKCt80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324128; c=relaxed/simple;
	bh=7zVaDgT2dMSkrpsp3xzqYvEZpVYt/GwYB4YhIWzsABs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HF8+wygbkqM9a7SCag2WeUQ6HIf3WwkKyDrg2bML4fj1KX8epkb19m6mUu/1Z9mFfi3Sspae1wXF3TfpUYeufogcJ0UWDY6a5GxNSqzb1YKGvW4D01GjxyKaIM0vtfKnVhle9cbGTDWlooH7GxW7vw145wKreuAWh6ZoZwfuVwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jiJf0NDU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183C7C43390;
	Sun, 24 Mar 2024 23:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324127;
	bh=7zVaDgT2dMSkrpsp3xzqYvEZpVYt/GwYB4YhIWzsABs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jiJf0NDUc7DjBlORm63rE193IlUw8dVcl4yc+m/a7p/vhlLeYz4XkoH0mlPAK0O/X
	 t6NKl5yaxRulv55WaCb/RzpAQRJAvuHNjSrWr1dso1EEnEwia0bYx8PN5ieAC3YV9o
	 ckhspUHv7une2FUIGujrhQvHaFbcnGZ1pzft5BM0GGSzi5POSs0yl2H0cUKgjfrAfO
	 HSzKrOwuuSNYxX2XCpWuMCf93CzpPVCzwUqQv0lT+cpMPPxNTpalSjGNv+j4MGFWx3
	 Or2c0m5AOcCnWnsCfbEUwN5bIkiTmEty+NqK+L1ZvFiDjsf0WoBV2WNDHFjI6ewyYg
	 ZUJPoakBrVOtw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 125/183] drm/tegra: put drm_gem_object ref on error in tegra_fb_create
Date: Sun, 24 Mar 2024 19:45:38 -0400
Message-ID: <20240324234638.1355609-126-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index e34325c83d28e..361e67e4cd984 100644
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


