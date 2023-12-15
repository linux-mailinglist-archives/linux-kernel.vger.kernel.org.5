Return-Path: <linux-kernel+bounces-697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 546FE8144CB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FD95282BA3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D97B18654;
	Fri, 15 Dec 2023 09:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="JfA8lXMP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C7618029;
	Fri, 15 Dec 2023 09:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost.localdomain (unknown [46.242.8.170])
	by mail.ispras.ru (Postfix) with ESMTPSA id 6598540F1DC5;
	Fri, 15 Dec 2023 09:34:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 6598540F1DC5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1702632851;
	bh=ccZp27R6c7ZeC11LFGMLzR031473jv38nkI+1DlG12s=;
	h=From:To:Cc:Subject:Date:From;
	b=JfA8lXMPcs09R7jTJgYkxAHZzWmAGdt7d5I+s5lhruo3caq4xyvs64vuUx0iCks+8
	 9oG9jWmNemVAgjdODNZjkiSCklUag4h9oKtkvK9G+kE/UPQBBT9q6TICKEhcplpKdJ
	 VW7vFwzrpmYyBVD25+EeUcU0Xg6SJ57aHsXDc95M=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Arto Merilainen <amerilainen@nvidia.com>,
	Terje Bergstrom <tbergstrom@nvidia.com>,
	dri-devel@lists.freedesktop.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: [PATCH] drm/tegra: put drm_gem_object ref on error in tegra_fb_create
Date: Fri, 15 Dec 2023 12:33:55 +0300
Message-ID: <20231215093356.12067-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Inside tegra_fb_create(), drm_gem_object_lookup() increments ref count of
the found object. But if the following size check fails then the last
found object's ref count should be put there as the unreferencing loop
can't detect this situation.

Found by Linux Verification Center (linuxtesting.org).

Fixes: de2ba664c30f ("gpu: host1x: drm: Add memory manager and fb")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 drivers/gpu/drm/tegra/fb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/tegra/fb.c b/drivers/gpu/drm/tegra/fb.c
index a719af1dc9a5..46170753699d 100644
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


