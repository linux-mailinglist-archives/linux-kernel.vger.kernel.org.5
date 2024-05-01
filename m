Return-Path: <linux-kernel+bounces-164979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDB98B85CB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 08:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8E301F22E6B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 06:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8547A4E1DA;
	Wed,  1 May 2024 06:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="shC5Vw2f"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E384CDEC;
	Wed,  1 May 2024 06:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714546622; cv=none; b=ce8JC2cwYWyxiSlv37ooKtAs7jms/jZXCaWp4FnqDnL8PrBPNgFi3iDjWmJhWn+L8vzOX4zx4axHMda20gp+uEa1REcu5DD7NdxBp6MBIr0zMucuZm7EdQ/ekFlebkq/a8ai/WEWUWcW9uhucdBBOCCeNe0WSMshBprRn09ynBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714546622; c=relaxed/simple;
	bh=ukkgFqr7kd/xxXpDV8+eo6AgFXA9F66NcJ7LrIizHhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=khifqRj1EqcoHj66yEAuOCTa9iZdpBdI/lduyiYjcASOOuJBJLsSxZ5NVIo6dnSNl9NhJ7xJ9n5/6elTdv08EWNO8xnbjrszMZld2/yLnoIbYEBm+yzmLFtMT6VXPjr5qjw6J95yMvPB5cQFGINsRKZBAsX/PuYQfAyRxfOkvPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=shC5Vw2f; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714546619;
	bh=ukkgFqr7kd/xxXpDV8+eo6AgFXA9F66NcJ7LrIizHhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=shC5Vw2fvwzdtpBhsMxO4K3ScFhrjk5bLn15g5Nmmhn/NDP1XFd3k+6m/NQWkyLY0
	 GWFEyGw93nG9ga7lHShbcfTDcy1DLrEXC2SOlxT0nPvHUT0t3twi09rLvWUtE7AXhn
	 mZFbPWLFPzsxCL2J7rgOxzDnwVl5h63t1NUWUoH7Hh4d/5j0WfxK9lPdsgHkuwZhS7
	 AegulK7GQbWEZSRh5j1n9EbYJtml57lBuB21Mu6B2PzoBMXnJt8O/ze/1at+RBH9ac
	 pEx+mIetasKpidIc1WC+9hW30KRi5j8PlAm3f9Fv8jTvLgQH8tV2NPn0GKLPs2jZVV
	 jP+ZtgavsUH6Q==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: alarumbe)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 738F337820FB;
	Wed,  1 May 2024 06:56:58 +0000 (UTC)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: Qiang Yu <yuq825@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian Koenig= <christian.koenig@amd.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Zack Rusin <zack.rusin@broadcom.com>
Cc: kernel@collabora.com,
	Adrian Larumbe <adrian.larumbe@collabora.com>,
	dri-devel@lists.freedesktop.org,
	lima@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org
Subject: [PATCH v3 2/2] drm/gem-shmem: Add import attachment warning to locked pin function
Date: Wed,  1 May 2024 07:56:00 +0100
Message-ID: <20240501065650.2809530-3-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240501065650.2809530-1-adrian.larumbe@collabora.com>
References: <20240501065650.2809530-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit ec144244a43f ("drm/gem-shmem: Acquire reservation lock in GEM
pin/unpin callbacks") moved locking DRM object's dma reservation to
drm_gem_shmem_object_pin, and made drm_gem_shmem_pin_locked public, so we
need to make sure the non-NULL check warning is also added to the latter.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 177773bcdbfd..ad5d9f704e15 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -233,6 +233,8 @@ int drm_gem_shmem_pin_locked(struct drm_gem_shmem_object *shmem)
 
 	dma_resv_assert_held(shmem->base.resv);
 
+	drm_WARN_ON(shmem->base.dev, shmem->base.import_attach);
+
 	ret = drm_gem_shmem_get_pages(shmem);
 
 	return ret;
-- 
2.44.0


