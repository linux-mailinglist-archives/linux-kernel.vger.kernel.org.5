Return-Path: <linux-kernel+bounces-18253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3973E825AA0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 19:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ECFB1C23611
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CFE39870;
	Fri,  5 Jan 2024 18:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HYfbKWsO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73C438FAF
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 18:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704480428;
	bh=tpJP8aUfkvakUPIRIDPJWRInC6tt5GQtcS8InGkdO1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HYfbKWsOORxwVSeGsBruwzoIrfH9HktyzFNW0jMXbWXqEQkTjCbpZsndScMrWW09M
	 T7gQhPY8U51XeIxeWj+GRsVQSCh8ogIg4SQuEERDKXAOLNs78Yi1454KAIox07MShF
	 rlk4BYMQ+lOapPf7Dvp9+56o8g6rLI63w9CFh/5MYVtXkGk/uvIKW9R7ErUKWzWer0
	 4+GaUiAy34d4w5iPNh4HQX1u6JiWMFNgAP5y5ixbzfo1gaKdQNoxf3w8qCHPkWD+Q6
	 u/bK8sl5peQRSfn1ZzL4Lr1OADocg2OFUcLkCZR9t1INpZ9aZoXbUhSCCiHiQt/hM8
	 nyqubNWPN4X0A==
Received: from workpc.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 37097378203D;
	Fri,  5 Jan 2024 18:47:07 +0000 (UTC)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: David Airlie <airlied@gmail.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Qiang Yu <yuq825@gmail.com>,
	Steven Price <steven.price@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Emma Anholt <emma@anholt.net>,
	Melissa Wen <mwen@igalia.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v19 15/30] drm/shmem-helper: Avoid lockdep warning when pages are released
Date: Fri,  5 Jan 2024 21:46:09 +0300
Message-ID: <20240105184624.508603-16-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
References: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All drivers will be moved to get/put pages explicitly and then the last
put_pages() will be invoked during gem_free() time by some drivers.
We can't touch reservation lock when GEM is freed because that will cause
a spurious warning from lockdep when shrinker support will be added.
Lockdep doesn't know that fs_reclaim isn't functioning for a freed object,
and thus, can't deadlock. Release pages directly without taking reservation
lock if GEM is freed and its refcount is zero.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index f5ed64f78648..c7357110ca76 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -242,6 +242,22 @@ void drm_gem_shmem_put_pages(struct drm_gem_shmem_object *shmem)
 	if (refcount_dec_not_one(&shmem->pages_use_count))
 		return;
 
+	/*
+	 * Destroying the object is a special case because acquiring
+	 * the obj lock can cause a locking order inversion between
+	 * reservation_ww_class_mutex and fs_reclaim.
+	 *
+	 * This deadlock is not actually possible, because no one should
+	 * be already holding the lock when GEM is released.  Unfortunately
+	 * lockdep is not aware of this detail.  So when the refcount drops
+	 * to zero, we pretend it is already locked.
+	 */
+	if (!kref_read(&shmem->base.refcount)) {
+		if (refcount_dec_and_test(&shmem->pages_use_count))
+			drm_gem_shmem_free_pages(shmem);
+		return;
+	}
+
 	dma_resv_lock(shmem->base.resv, NULL);
 	drm_gem_shmem_put_pages_locked(shmem);
 	dma_resv_unlock(shmem->base.resv);
-- 
2.43.0


