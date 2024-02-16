Return-Path: <linux-kernel+bounces-69292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2688586AF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E8DCB20EDD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEE013956D;
	Fri, 16 Feb 2024 20:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o4pyvA3u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12E1136640
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 20:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708115089; cv=none; b=HlheUhWppoRGYkwUjI84Ja4dhB+KWJ0F6F6PjPTkc7YagaB1VniBk7VsNl+ewXNJ2WtTlPx/UFcZT/oYQg75ADQ4OpcKRIHbrYc66Vq98mYZj0yngoq5gC2JEzYauN0vDU1NhpeaQZtv3nooHDxayoV1Yo0wgXD3PmLZXu3sM4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708115089; c=relaxed/simple;
	bh=O3Vq/9iekbJvfivB8fPNqfc/VdUr6NW92uCL9/WplH8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xj7viJO8uTO6QjPE3KJmZyOQokA2y4b0sA7TXia8gJ5zAf7vrGcvjiQmEvIaLSME85pWj9QgD43Lzzg4aBXDhffiZSrmm7/wcaAvTnJX3KYkdAb8a+HsQY+wQ543tBd0ngYClo/Y07qcjud23UGuYmUBXx0MSoH2CSjnUgZO16Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o4pyvA3u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 918C0C433F1;
	Fri, 16 Feb 2024 20:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708115088;
	bh=O3Vq/9iekbJvfivB8fPNqfc/VdUr6NW92uCL9/WplH8=;
	h=From:To:Cc:Subject:Date:From;
	b=o4pyvA3urDBZ5absWA/kHxTMsUxqDiraqvUHzCvCZsa7S0GmRjiXDAtU2otgYDGdq
	 rFd7s2UI/6YOfwxfkRxyCzlxvmo9OxpsJT94IKgMtTq2yv3aMJlJUp7xbmbUym6AAx
	 R2AVyJN9VY+gL9kRUqn9IeL+UdYV+I99jKHPtrKm2GnBCmSvhTaxKMD6/rminmP/9s
	 Yg53Bk7R26epRSUPyl6s/TZWVFmjKU80plf8NXxpnBjeteQXHD05VIxUBo7/ZqgGAW
	 j7t48iqo3h3QX6HuTT6gyPHYao49ciSc9jw0I/VRd8BbE121S1BGrTbjAt5zxKO4Fv
	 w39jyPvupSZaQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Gow <davidgow@google.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Matthew Auld <matthew.auld@intel.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/tests/drm_buddy: avoid 64-bit calculation
Date: Fri, 16 Feb 2024 21:24:30 +0100
Message-Id: <20240216202442.2493031-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The newly added drm_test_buddy_alloc_contiguous() test fails to link on
32-bit targets because of inadvertent 64-bit calculations:

ERROR: modpost: "__aeabi_uldivmod" [drivers/gpu/drm/tests/drm_buddy_test.ko] undefined!
ERROR: modpost: "__aeabi_ldivmod" [drivers/gpu/drm/tests/drm_buddy_test.ko] undefined!

From what I can tell, the numbers cannot possibly overflow a 32-bit size,
so use different types for these.

I noticed that the function has another possible flaw in that is mixes
what it calls pages with 4KB units. This is a big confusing at best,
or possibly broken when built on machines with larger pages.

Fixes: a64056bb5a32 ("drm/tests/drm_buddy: add alloc_contiguous test")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/tests/drm_buddy_test.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_buddy_test.c b/drivers/gpu/drm/tests/drm_buddy_test.c
index fee6bec757d1..50a5f98cd5bd 100644
--- a/drivers/gpu/drm/tests/drm_buddy_test.c
+++ b/drivers/gpu/drm/tests/drm_buddy_test.c
@@ -21,7 +21,8 @@ static inline u64 get_size(int order, u64 chunk_size)
 
 static void drm_test_buddy_alloc_contiguous(struct kunit *test)
 {
-	u64 mm_size, ps = SZ_4K, i, n_pages, total;
+	u64 mm_size, total;
+	u32 i, ps = SZ_4K, n_pages;
 	struct drm_buddy_block *block;
 	struct drm_buddy mm;
 	LIST_HEAD(left);
@@ -29,7 +30,8 @@ static void drm_test_buddy_alloc_contiguous(struct kunit *test)
 	LIST_HEAD(right);
 	LIST_HEAD(allocated);
 
-	mm_size = 16 * 3 * SZ_4K;
+	n_pages = 16 * 3;
+	mm_size = n_pages * SZ_4K;
 
 	KUNIT_EXPECT_FALSE(test, drm_buddy_init(&mm, mm_size, ps));
 
@@ -42,7 +44,6 @@ static void drm_test_buddy_alloc_contiguous(struct kunit *test)
 	 */
 
 	i = 0;
-	n_pages = mm_size / ps;
 	do {
 		struct list_head *list;
 		int slot = i % 3;
-- 
2.39.2


