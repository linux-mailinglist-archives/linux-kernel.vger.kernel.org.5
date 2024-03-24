Return-Path: <linux-kernel+bounces-114871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEC5889278
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0B821F2F29B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F982CA45C;
	Mon, 25 Mar 2024 00:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwcWexz6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08097177A8B;
	Sun, 24 Mar 2024 23:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323514; cv=none; b=DlGTxT57s2hM5kv853Gz1lQtNhUVgVOngSozH9VG2q3qDpVnoIOpoPKH0ULqC9B8grU6fdjNYVGKCfRduOyhifcNHL4PEyfd8M1DKBZzxvM2uBD8GfqFnvXz7yHpADv/xwLMxwcuk/kDnPNX5Oii8wGAMRvMz9vm2r3hh1zDJm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323514; c=relaxed/simple;
	bh=+7+48+cUDSwonUDB2uW8//TEeC+7Ah5z8bAa9KDm8yU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ksAiyd0Hqx7ZU4NwdJ4JqFQNXQ1t1ilryKuAZGjXoW5+1zk0Sxow1St48YvqJgBs5+S2u8GuFHHfKuUuJnN7Gh3fa/HvOm8MzbYadiNix899MGY2cfMJw+Np2SGyR0e5V6bOkmAs8dimpRKPhO3/NYNiDl1zCOUHGYjo5uLdhQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwcWexz6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D9BC43394;
	Sun, 24 Mar 2024 23:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323512;
	bh=+7+48+cUDSwonUDB2uW8//TEeC+7Ah5z8bAa9KDm8yU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MwcWexz6NhKP78gj6OBMxyZ0bz0V6sE0t7MApqcrjS+LU7TtR7to/eTzAXIKM7Bel
	 gfD7nLAtj2l5tzTmf3zJ9SHPHDmvYUwywLPujg/L6BjPaEpP3lgpjfMb3ybvyDMlM5
	 1zxjfWroEWKvi7h1De7vmH1UQ5lipt1Hdx1kMZDXp+GLQAARDjQnWdQRsl+oh3PW1I
	 1m4ewAXvuNlpxdH7Dlol29N2Gy8PPAywMoGF0tcDIyjf38fst0/at0Gkr97wtFdzQT
	 WFo1yzZTvBzfxUyxJw7KFYmsGMqjp6IvnJoDQvICCze/RprHuDh6yMs2Ek/c5Ramf+
	 7Q9kwWCAZjiIw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 219/317] drm/tegra: put drm_gem_object ref on error in tegra_fb_create
Date: Sun, 24 Mar 2024 19:33:19 -0400
Message-ID: <20240324233458.1352854-220-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index cae8b8cbe9dd0..6e35c7951dfb2 100644
--- a/drivers/gpu/drm/tegra/fb.c
+++ b/drivers/gpu/drm/tegra/fb.c
@@ -165,6 +165,7 @@ struct drm_framebuffer *tegra_fb_create(struct drm_device *drm,
 
 		if (gem->size < size) {
 			err = -EINVAL;
+			drm_gem_object_put(gem);
 			goto unreference;
 		}
 
-- 
2.43.0


