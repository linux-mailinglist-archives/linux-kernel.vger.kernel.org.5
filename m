Return-Path: <linux-kernel+bounces-3659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEC3816F35
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF98C286665
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43148352A;
	Mon, 18 Dec 2023 12:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOmOiPfq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAD883506;
	Mon, 18 Dec 2023 12:47:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A207C433C7;
	Mon, 18 Dec 2023 12:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702903622;
	bh=t+KHn+44ovdVq25CC0aFqqHbf+EASmZbq8XDH9VYYxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fOmOiPfqsKgIVxB9nQL128YKxMCoPKKXYQjO12/zjrT6fj9qyXJjy/drlUsIRjMhM
	 9Uy45S30hPyip4jaUuqPdbqAG04pl3++zNHTdnCo31zd0fGNYec6gFpiVW0OanwDO6
	 KGo+mVQeYZ/Ql791o9k2/fJO24ye/zkQb6r4gRrvJRM6aSxg1VjrHR2o2KO3W2iYr/
	 6Ro5SQWPY1b7Z/1oT3rClJATdZwGa36cGYWkPxMql4shZmwAAuLjh9GCgc1DEwtQFE
	 /LACGtXBUqAobVaulnB0v5Z4TQu8uxkWV+2UkajptrzGP19ial2iRdEW9NQwnyCaMJ
	 scOR2r8Cl7Gfw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ziqi Zhao <astrajoan@yahoo.com>,
	syzbot+4fad2e57beb6397ab2fc@syzkaller.appspotmail.com,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Maxime Ripard <mripard@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 3/7] drm/crtc: Fix uninit-value bug in drm_mode_setcrtc
Date: Mon, 18 Dec 2023 07:46:48 -0500
Message-ID: <20231218124656.1381949-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218124656.1381949-1-sashal@kernel.org>
References: <20231218124656.1381949-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.264
Content-Transfer-Encoding: 8bit

From: Ziqi Zhao <astrajoan@yahoo.com>

[ Upstream commit 3823119b9c2b5f9e9b760336f75bc989b805cde6 ]

The connector_set contains uninitialized values when allocated with
kmalloc_array. However, in the "out" branch, the logic assumes that any
element in connector_set would be equal to NULL if failed to
initialize, which causes the bug reported by Syzbot. The fix is to use
an extra variable to keep track of how many connectors are initialized
indeed, and use that variable to decrease any refcounts in the "out"
branch.

Reported-by: syzbot+4fad2e57beb6397ab2fc@syzkaller.appspotmail.com
Signed-off-by: Ziqi Zhao <astrajoan@yahoo.com>
Reported-and-tested-by: syzbot+4fad2e57beb6397ab2fc@syzkaller.appspotmail.com
Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Link: https://lore.kernel.org/r/20230721161446.8602-1-astrajoan@yahoo.com
Signed-off-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_crtc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
index 4936e1080e417..38ce608648b0d 100644
--- a/drivers/gpu/drm/drm_crtc.c
+++ b/drivers/gpu/drm/drm_crtc.c
@@ -535,8 +535,7 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
 	struct drm_mode_set set;
 	uint32_t __user *set_connectors_ptr;
 	struct drm_modeset_acquire_ctx ctx;
-	int ret;
-	int i;
+	int ret, i, num_connectors;
 
 	if (!drm_core_check_feature(dev, DRIVER_MODESET))
 		return -EOPNOTSUPP;
@@ -674,6 +673,7 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
 			goto out;
 		}
 
+		num_connectors = 0;
 		for (i = 0; i < crtc_req->count_connectors; i++) {
 			connector_set[i] = NULL;
 			set_connectors_ptr = (uint32_t __user *)(unsigned long)crtc_req->set_connectors_ptr;
@@ -694,6 +694,7 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
 					connector->name);
 
 			connector_set[i] = connector;
+			num_connectors++;
 		}
 	}
 
@@ -702,7 +703,7 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
 	set.y = crtc_req->y;
 	set.mode = mode;
 	set.connectors = connector_set;
-	set.num_connectors = crtc_req->count_connectors;
+	set.num_connectors = num_connectors;
 	set.fb = fb;
 
 	if (drm_drv_uses_atomic_modeset(dev))
@@ -715,7 +716,7 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
 		drm_framebuffer_put(fb);
 
 	if (connector_set) {
-		for (i = 0; i < crtc_req->count_connectors; i++) {
+		for (i = 0; i < num_connectors; i++) {
 			if (connector_set[i])
 				drm_connector_put(connector_set[i]);
 		}
-- 
2.43.0


