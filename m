Return-Path: <linux-kernel+bounces-32841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D328360C7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59A08282A21
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EECC41757;
	Mon, 22 Jan 2024 11:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iw3O6aWP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D1941742;
	Mon, 22 Jan 2024 11:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921501; cv=none; b=p95+SFrUwXOhK35E6GJ4Sy2LI+TpRKyIl6qWFw1W42xrLQTnxSKrGUVeZGboAxEJRzxI3oIWXB1pCJpmG/LNvtQzOIZVbZRCYn0Tv+fZtgQNwTJLKKHn8ZADy7/aJe40sNCQTQZmWnBL4lQPkdjDKyzpWsNX+pQfDQplpcRLzI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921501; c=relaxed/simple;
	bh=6xvbnww7JlLBYTWi11QyGdS/O6ZiCkP8ssfXGVVStMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZWyEasNFK1d/G1nRfIr9y0SKTLmkwOybwbqmaWHZD83+/qjuKWcy4hF2WuP8pLD3UCp7hySx1UI2lZLghzaqo5GegxKfy4xppb0u+MbPNKer8lWVY66Fo+g3znY6nOvDkWOiUm42xOuFTJpG2BBs5EF/mkI3fvaPzVi3oYsduf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iw3O6aWP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441FCC433C7;
	Mon, 22 Jan 2024 11:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705921501;
	bh=6xvbnww7JlLBYTWi11QyGdS/O6ZiCkP8ssfXGVVStMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Iw3O6aWPvhy9GIEKKDrzmNgcJj/uA8/+BQWIb9xQ9NDjnOUO2iEgpgfNt+JbbBWAL
	 7fgFxiB/NCes1NiW5GNZJwdy8wCXTcvuWfuRLJ28EF8D/uBeoJOv8jlfEFeLb70AtZ
	 MTBet8I4ji4zv01H/aRKE8BMyJMzLOW/r+ObiklW4+N+VdTmB+DWdjPwiAzpF9Ep3G
	 HgYeA4RbVsdKMz4o3op6pEDyxJhkU+dayQ4ZTheeb138j9D5Y1Es+eF4R2/K8crdzN
	 1VZIeanuz28tEuUGtMkLDj0Xna2EaTpUgZmyN7IpWQU3I19sF+p6tjffa+y+tGJREm
	 fP0WH2ZIpHYZQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2 28/47] fbdev/core: simplify cursor_state setting in fbcon_ops::cursor()
Date: Mon, 22 Jan 2024 12:03:42 +0100
Message-ID: <20240122110401.7289-29-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122110401.7289-1-jirislaby@kernel.org>
References: <20240122110401.7289-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a switch decicing if cursor should be drawn or not. The whole
switch can be simplified to one line. Do this cleanup as a preparatory
work for the next patch. There, all the CM_* constants are removed.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
---
 drivers/video/fbdev/core/bitblit.c   | 11 +----------
 drivers/video/fbdev/core/fbcon_ccw.c | 11 +----------
 drivers/video/fbdev/core/fbcon_cw.c  | 11 +----------
 drivers/video/fbdev/core/fbcon_ud.c  | 11 +----------
 4 files changed, 4 insertions(+), 40 deletions(-)

diff --git a/drivers/video/fbdev/core/bitblit.c b/drivers/video/fbdev/core/bitblit.c
index 8587c9da0670..daff152f4c22 100644
--- a/drivers/video/fbdev/core/bitblit.c
+++ b/drivers/video/fbdev/core/bitblit.c
@@ -348,16 +348,7 @@ static void bit_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 			mask[i++] = msk;
 	}
 
-	switch (mode) {
-	case CM_ERASE:
-		ops->cursor_state.enable = 0;
-		break;
-	case CM_DRAW:
-	case CM_MOVE:
-	default:
-		ops->cursor_state.enable = (use_sw) ? 0 : 1;
-		break;
-	}
+	ops->cursor_state.enable = (mode != CM_ERASE) && !use_sw;
 
 	cursor.image.data = src;
 	cursor.image.fg_color = ops->cursor_state.image.fg_color;
diff --git a/drivers/video/fbdev/core/fbcon_ccw.c b/drivers/video/fbdev/core/fbcon_ccw.c
index 2789ace79634..889423d580bc 100644
--- a/drivers/video/fbdev/core/fbcon_ccw.c
+++ b/drivers/video/fbdev/core/fbcon_ccw.c
@@ -349,16 +349,7 @@ static void ccw_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 		kfree(tmp);
 	}
 
-	switch (mode) {
-	case CM_ERASE:
-		ops->cursor_state.enable = 0;
-		break;
-	case CM_DRAW:
-	case CM_MOVE:
-	default:
-		ops->cursor_state.enable = (use_sw) ? 0 : 1;
-		break;
-	}
+	ops->cursor_state.enable = (mode != CM_ERASE) && !use_sw;
 
 	cursor.image.data = src;
 	cursor.image.fg_color = ops->cursor_state.image.fg_color;
diff --git a/drivers/video/fbdev/core/fbcon_cw.c b/drivers/video/fbdev/core/fbcon_cw.c
index 86a254c1b2b7..a306ca5802e8 100644
--- a/drivers/video/fbdev/core/fbcon_cw.c
+++ b/drivers/video/fbdev/core/fbcon_cw.c
@@ -332,16 +332,7 @@ static void cw_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 		kfree(tmp);
 	}
 
-	switch (mode) {
-	case CM_ERASE:
-		ops->cursor_state.enable = 0;
-		break;
-	case CM_DRAW:
-	case CM_MOVE:
-	default:
-		ops->cursor_state.enable = (use_sw) ? 0 : 1;
-		break;
-	}
+	ops->cursor_state.enable = (mode != CM_ERASE) && !use_sw;
 
 	cursor.image.data = src;
 	cursor.image.fg_color = ops->cursor_state.image.fg_color;
diff --git a/drivers/video/fbdev/core/fbcon_ud.c b/drivers/video/fbdev/core/fbcon_ud.c
index 23bc045769d0..f6fc458b46c7 100644
--- a/drivers/video/fbdev/core/fbcon_ud.c
+++ b/drivers/video/fbdev/core/fbcon_ud.c
@@ -372,16 +372,7 @@ static void ud_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 			mask[i++] = ~msk;
 	}
 
-	switch (mode) {
-	case CM_ERASE:
-		ops->cursor_state.enable = 0;
-		break;
-	case CM_DRAW:
-	case CM_MOVE:
-	default:
-		ops->cursor_state.enable = (use_sw) ? 0 : 1;
-		break;
-	}
+	ops->cursor_state.enable = (mode != CM_ERASE) && !use_sw;
 
 	cursor.image.data = src;
 	cursor.image.fg_color = ops->cursor_state.image.fg_color;
-- 
2.43.0


