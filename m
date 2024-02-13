Return-Path: <linux-kernel+bounces-63285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB12852D42
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDDBF285A8F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8B63A1B5;
	Tue, 13 Feb 2024 09:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLGi7my8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE2439FCD;
	Tue, 13 Feb 2024 09:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707818246; cv=none; b=QFvBACG0ytqkLr3Bn/1HMHbW/wvJy5Nd0o2rLAwOKstFEaurMZMUUroWVMtPfPqU2QJqfyON+Cmf0qHr1ONX0DFskEQpFMZOBZ4lJPQV7SFnsLiEFTRzfHOcv30Lfhv97p2AalAK/Pasodlpo5yLf0MeIy5z3ZAtLXltpmg1seI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707818246; c=relaxed/simple;
	bh=kvqVpaVk50IzPZXU0zbw6srWa1WNF8IF4uR3vDkrvns=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UEHulaq3ELRNpN+k7Lb8i3jcY/favOL9J7NQbw1OS1ZTJ/c/ckE9hzmjcmlzPZz60rWXJVkOUYL6YIjb+uQMvgQXQnKgynBWL581w+RxHPenUDkRwnZCg0oAMPHTXaWHAh+7u7c6fDLxqMz+Wb2xpcEZei4U+ncFzV8yckNTORk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLGi7my8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55E0C433F1;
	Tue, 13 Feb 2024 09:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707818246;
	bh=kvqVpaVk50IzPZXU0zbw6srWa1WNF8IF4uR3vDkrvns=;
	h=From:To:Cc:Subject:Date:From;
	b=HLGi7my8bug6KjC9594j1s1zjeyGPS67H4uIlBCSZTwYYt3hKHFOep4cu2crIbocS
	 8ZDjbcKKRvREI+oWMYpbd1R092rAAR2t7MuXElt/XsMzg4YKA1bFykJ3vvtZvixfav
	 B4aJ7bTn9pp6AOe5GiZxTQxjkCgLEulvISVc+0KAnMzVLOtrDw9ajDmptCpR1W6mhb
	 6yjEoJqSQqeuK62ts3lf8wIxGoPNDYTYcEozb6i8+2nMyBDcIxqkqtURhUdtWOBuR7
	 0OkXKuzvXnmbofOY7tQoAe57fFV4+WU3C1vzBgFIG8asp/w9Sx8BabAPFGgar5KoWU
	 Mw0bqGOnWx4sw==
From: Arnd Bergmann <arnd@kernel.org>
To: Lucas De Marchi <lucas.demarchi@intel.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] drm/xe: avoid function cast warnings
Date: Tue, 13 Feb 2024 10:56:48 +0100
Message-Id: <20240213095719.454865-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

clang-16 warns about a cast between incompatible function types:

drivers/gpu/drm/xe/xe_range_fence.c:155:10: error: cast from 'void (*)(const void *)' to 'void (*)(struct xe_range_fence *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
  155 |         .free = (void (*)(struct xe_range_fence *rfence)) kfree,
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Avoid this with a trivial helper function that calls kfree() here.

Fixes: 845f64bdbfc9 ("drm/xe: Introduce a range-fence utility")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/xe/xe_range_fence.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_range_fence.c b/drivers/gpu/drm/xe/xe_range_fence.c
index d35d9ec58e86..8510be4466eb 100644
--- a/drivers/gpu/drm/xe/xe_range_fence.c
+++ b/drivers/gpu/drm/xe/xe_range_fence.c
@@ -151,6 +151,11 @@ xe_range_fence_tree_next(struct xe_range_fence *rfence, u64 start, u64 last)
 	return xe_range_fence_tree_iter_next(rfence, start, last);
 }
 
+static void xe_range_fence_free(struct xe_range_fence * rfence)
+{
+	kfree(rfence);
+}
+
 const struct xe_range_fence_ops xe_range_fence_kfree_ops = {
-	.free = (void (*)(struct xe_range_fence *rfence)) kfree,
+	.free = xe_range_fence_free,
 };
-- 
2.39.2


