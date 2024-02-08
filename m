Return-Path: <linux-kernel+bounces-57983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FB884DFF3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE1E8B28065
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802F96F095;
	Thu,  8 Feb 2024 11:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTMkDEc+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AF41DFCE;
	Thu,  8 Feb 2024 11:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707392655; cv=none; b=LWOuUkfSJFkAGB0vI8kQos0v47tqXaw72mbOm4FjzFa4J1/c6RSwBmdd7shBVx+w+8FknijKIYoRiujkfLHmKYOtOG0Kocbb3Gg8eeR4jUxmSJh8Mq2rfTU+LaCOBSXq91GOF+Ctbf7ZAoRN+i9m8mITSHWplmNahngfHZGpOZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707392655; c=relaxed/simple;
	bh=yTjseaYVw0yF5zP6CGXqUmZUSPFs3w8SZduU+tXhSIk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=glz3/WeAaL2fyN0Av1DQEoT+AXYZhKKeG3sI3uPK7tyuk0gAfTY8mu8/Zjrx9F6LYzDlgtrtsSO+Loh1y27+Xet/ceLRKGBpWGG9guVx8+uMuiVBuPAZyU+jMtjJGgPD8FWvVN/U9Zhxwf4MhNLQh9/vfRqARYkR8NmPmH42cvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTMkDEc+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC644C433C7;
	Thu,  8 Feb 2024 11:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707392655;
	bh=yTjseaYVw0yF5zP6CGXqUmZUSPFs3w8SZduU+tXhSIk=;
	h=From:To:Cc:Subject:Date:From;
	b=jTMkDEc+AVCeQA5FQ+dvJWvaP7Ooj+9838vMpKbAYHqtrgXszANRMAkhPuTWyGAVT
	 2e9yPGMJHM9foZw40JzjPDDKd7pB0haqtDgMbDihQNWr939v1yabMEaXSaiEaA2ziF
	 kjkBztORC/swU8+kRjv+AMIsF94HLF4KvU9F29Jp0/OyiBELf5C+zOoGM5Nv/uIlaw
	 EhHHmPYTeHn5jKUnd9Kk5Qk54tjPwKMbFjH5LIcoDUgI0dD8w+wGyGgRQQuqI/CemB
	 4m9neYEUnaRWDQ3gLAdT19t80Jh+K6P+2mYcJ2yhhJ0KCgcHapjUJP15KH/pRio3/6
	 mRd6E6TQwSJbg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: daniel@ffwll.ch
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Ubisectech Sirius <bugreport@ubisectech.com>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH] fbcon: always restore the old font data in fbcon_do_set_font()
Date: Thu,  8 Feb 2024 12:44:11 +0100
Message-ID: <20240208114411.14604-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit a5a923038d70 (fbdev: fbcon: Properly revert changes when
vc_resize() failed) started restoring old font data upon failure (of
vc_resize()). But it performs so only for user fonts. It means that the
"system"/internal fonts are not restored at all. So in result, the very
first call to fbcon_do_set_font() performs no restore at all upon
failing vc_resize().

This can be reproduced by Syzkaller to crash the system on the next
invocation of font_get(). It's rather hard to hit the allocation failure
in vc_resize() on the first font_set(), but not impossible. Esp. if
fault injection is used to aid the execution/failure. It was
demonstrated by Sirius:
  BUG: unable to handle page fault for address: fffffffffffffff8
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD cb7b067 P4D cb7b067 PUD cb7d067 PMD 0
  Oops: 0000 [#1] PREEMPT SMP KASAN
  CPU: 1 PID: 8007 Comm: poc Not tainted 6.7.0-g9d1694dc91ce #20
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
  RIP: 0010:fbcon_get_font+0x229/0x800 drivers/video/fbdev/core/fbcon.c:2286
  Call Trace:
   <TASK>
   con_font_get drivers/tty/vt/vt.c:4558 [inline]
   con_font_op+0x1fc/0xf20 drivers/tty/vt/vt.c:4673
   vt_k_ioctl drivers/tty/vt/vt_ioctl.c:474 [inline]
   vt_ioctl+0x632/0x2ec0 drivers/tty/vt/vt_ioctl.c:752
   tty_ioctl+0x6f8/0x1570 drivers/tty/tty_io.c:2803
   vfs_ioctl fs/ioctl.c:51 [inline]
  ...

So restore the font data in any case, not only for user fonts. Note the
later 'if' is now protected by 'old_userfont' and not 'old_data' as the
latter is always set now. (And it is supposed to be non-NULL. Otherwise
we would see the bug above again.)

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Fixes: a5a923038d70 ("fbdev: fbcon: Properly revert changes when vc_resize() failed")
Cc: Ubisectech Sirius <bugreport@ubisectech.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
---
 drivers/video/fbdev/core/fbcon.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 17a9fc80b4e4..98d0e2dbcd2f 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2395,11 +2395,9 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	struct fbcon_ops *ops = info->fbcon_par;
 	struct fbcon_display *p = &fb_display[vc->vc_num];
 	int resize, ret, old_userfont, old_width, old_height, old_charcount;
-	char *old_data = NULL;
+	u8 *old_data = vc->vc_font.data;
 
 	resize = (w != vc->vc_font.width) || (h != vc->vc_font.height);
-	if (p->userfont)
-		old_data = vc->vc_font.data;
 	vc->vc_font.data = (void *)(p->fontdata = data);
 	old_userfont = p->userfont;
 	if ((p->userfont = userfont))
@@ -2433,13 +2431,13 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 		update_screen(vc);
 	}
 
-	if (old_data && (--REFCOUNT(old_data) == 0))
+	if (old_userfont && (--REFCOUNT(old_data) == 0))
 		kfree(old_data - FONT_EXTRA_WORDS * sizeof(int));
 	return 0;
 
 err_out:
 	p->fontdata = old_data;
-	vc->vc_font.data = (void *)old_data;
+	vc->vc_font.data = old_data;
 
 	if (userfont) {
 		p->userfont = old_userfont;
-- 
2.43.0


