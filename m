Return-Path: <linux-kernel+bounces-114440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15005888FF5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C352C290C71
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0091791F5;
	Sun, 24 Mar 2024 23:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMGpntWr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDEB140E5C;
	Sun, 24 Mar 2024 23:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321859; cv=none; b=lwCXbdFenJQhRAM6bMQKizyGGqr/1z7v1JfguO0j0MZSL1hvccSTBLIRIt2geIq8JAujVQIxuF0e43Iag3veFUXh+HpzaRR0/sDElAFzAeBTyu4LFsD+RqJZkBCnie7GxywuqyDzJAqG/uAudWkGYNft5UcDs37MuRYX0UqLGck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321859; c=relaxed/simple;
	bh=OwtCJvgFm1joD9dGpHgZjvWy/3NSqXfs5fo7EoGkYmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nKJqjjYYDb1ua9iuJDi1oRVneJq3iOQBhzZfCcroNVVxFIzFeAU5yOJRj+GEje4U5n7eb5xg21mPRJvMrfM0LxFqYGn0ldRQztiU6ebCK5yWTwEk2kJzRCYsc3stpAiqtjcy3l+23lUuuTlxppaS/MtXA7yGEBEkseLD8HuxmuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMGpntWr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D5B1C43399;
	Sun, 24 Mar 2024 23:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321857;
	bh=OwtCJvgFm1joD9dGpHgZjvWy/3NSqXfs5fo7EoGkYmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IMGpntWr0Fgviocm4W8IAWav7vB0guJN/wj4UYFeNNvy74MsdmH0xbWFWJTL3vKcY
	 cet/iWLROfL6MpNAxTkFUCGtcdlzwZ8wR/cAR4769Nh9WYXfZ3LRai78MxHlFbQpKI
	 S5j2+B0Ys8M9eduPSkk4q2M5Ls02dkHB87HNLuzsCEUTUcSC8gdAqaCGAc6+/Yxbg9
	 /ScJGBPKpFbQw2fs5mcFiWMORB6Z4gBvlLaBAKwG/Ioy6b1WP9e7RGJ4jZmUzjH2DM
	 +CMjvIzQOXoeTEL+9y5C5msBtPA6qTXutjZd/3ZjnPvRk2O/snHEA2KTW9OIThyJpr
	 rmyUjd7bI6Lfg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 586/638] soc: fsl: dpio: fix kcalloc() argument order
Date: Sun, 24 Mar 2024 19:00:23 -0400
Message-ID: <20240324230116.1348576-587-sashal@kernel.org>
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

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 72ebb41b88f9d7c10c5e159e0507074af0a22fe2 ]

A previous bugfix added a call to kcalloc(), which starting in gcc-14
causes a harmless warning about the argument order:

drivers/soc/fsl/dpio/dpio-service.c: In function 'dpaa2_io_service_enqueue_multiple_desc_fq':
drivers/soc/fsl/dpio/dpio-service.c:526:29: error: 'kcalloc' sizes specified with 'sizeof' in the earlier argument and not in the later argument [-Werror=calloc-transposed-args]
  526 |         ed = kcalloc(sizeof(struct qbman_eq_desc), 32, GFP_KERNEL);
      |                             ^~~~~~
drivers/soc/fsl/dpio/dpio-service.c:526:29: note: earlier argument should specify number of elements, later size of each element

Since the two are only multiplied, the order does not change the
behavior, so just fix it now to shut up the compiler warning.

Dmity independently came up with the same fix.

Fixes: 5c4a5999b245 ("soc: fsl: dpio: avoid stack usage warning")
Reported-by: Dmitry Antipov <dmantipov@yandex.ru>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/fsl/dpio/dpio-service.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/dpio/dpio-service.c b/drivers/soc/fsl/dpio/dpio-service.c
index 1d2b27e3ea63f..b811446e0fa55 100644
--- a/drivers/soc/fsl/dpio/dpio-service.c
+++ b/drivers/soc/fsl/dpio/dpio-service.c
@@ -523,7 +523,7 @@ int dpaa2_io_service_enqueue_multiple_desc_fq(struct dpaa2_io *d,
 	struct qbman_eq_desc *ed;
 	int i, ret;
 
-	ed = kcalloc(sizeof(struct qbman_eq_desc), 32, GFP_KERNEL);
+	ed = kcalloc(32, sizeof(struct qbman_eq_desc), GFP_KERNEL);
 	if (!ed)
 		return -ENOMEM;
 
-- 
2.43.0


