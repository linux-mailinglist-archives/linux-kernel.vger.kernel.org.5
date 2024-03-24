Return-Path: <linux-kernel+bounces-114320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCDD888FA0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BABFD290085
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990EF16EBFB;
	Sun, 24 Mar 2024 23:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vdtr7kTW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F102114AF;
	Sun, 24 Mar 2024 23:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321709; cv=none; b=L9RtCccy5nO2zx+q0s3Mm0PME4aKdc7/RZBzTmfV0Xw/n6tcqBgp3ho0YvuyXFPQjD/rD/s2YGZ/hm3yBTXTxiCYmiN5MqxieqrVhHNL5ShtwjVy0woi3h0lGtfwsAD+5Vyzw1opIi9NMwZhPzKiLDxe35IYeso05NyTol+LqPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321709; c=relaxed/simple;
	bh=1csZ9x4MyVNb8NfT0+Ah6w2V60OsIm+IajesknxVD8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WRBEc331rSoqC4cVLu00ZJ+DfV5B595A/3cv0o4I0F02oiN7IeS89qY8UqvdViwwxTLIGQIur9/vsgaLbAk9n6UKih+IluwZYcIQVQRpxZl110JuAr4RZIDfkgDvFmIib/iBxUVu0uzbagraodEMZDAoKf4xv+soScJDWGklEOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vdtr7kTW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04A9C433C7;
	Sun, 24 Mar 2024 23:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321709;
	bh=1csZ9x4MyVNb8NfT0+Ah6w2V60OsIm+IajesknxVD8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vdtr7kTW93/LbiAGHMbzdW2j5FhKFkANWpBodOKetIgCBjCfkDCf6ZK/Ik5nzRCnF
	 Xj01aGpAW3SHbgZobXwC7/hhjzKrckZUcTpXrpoXEtQg/0GMXS/+yzuoiwasgeFLKT
	 Rh/0SJo2fAWt0SIo/6+0f9Xf7QnNfPH9KTlfBAKeHMu7tKrLKzP61rUDhP7Xycs0qI
	 1cS3y8Zwar2eueXUwq0/nQeOtc+GNnWVqtMRZ1GL+f+AWxyl07Y3k/rieIs36BQd5k
	 P11GpUBjj/T0OuF46eF/chn8admmxtRGXy874uxtqW/PhkQKYOlsnI82Sqn7Z/ndoM
	 IZuJ6cVG/UPJw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 438/638] drm/tegra: put drm_gem_object ref on error in tegra_fb_create
Date: Sun, 24 Mar 2024 18:57:55 -0400
Message-ID: <20240324230116.1348576-439-sashal@kernel.org>
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


