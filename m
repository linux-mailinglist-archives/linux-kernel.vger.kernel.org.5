Return-Path: <linux-kernel+bounces-29805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C8D8313D3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 689FB1C22892
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3309D29437;
	Thu, 18 Jan 2024 07:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uF6c4QLy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C9F29429;
	Thu, 18 Jan 2024 07:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705564716; cv=none; b=FnhwBxEVFqOHmlQLRgWS2P3W9XLw2zXEKebt4t4dBC0FznSVw96Fe0WCrc3dspDovcy1qSep81WAh7s9+An7UGGEdORUIY3ML4zKREZ7K0gC0/uYbPTdXfjeXOas9ePsUqe+dVIF02FOSuV4Tjc4KioWXReXKJi/Mp8v7sfOD1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705564716; c=relaxed/simple;
	bh=GJfteWjzTxl1GHc/MnJTrogtTSYg1Ifld3S8+ciqzdU=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=gbsPcZL8gFyfyOv2FjCzlyIs1SoQVYFzN3TYOcwD0nXIuHFiJPGkbEH0v5tiZrZfomd3nowb0t3zjc5I5DWMM3MIh6QOlUvqt2G9F/ZKE4+Idw8MLUS0s+NQOHNR1ecEX4H8OOcNTaWG3rfMaQY3PA7SzlNQC9IqeaWyYxaFOGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uF6c4QLy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED95C433C7;
	Thu, 18 Jan 2024 07:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705564716;
	bh=GJfteWjzTxl1GHc/MnJTrogtTSYg1Ifld3S8+ciqzdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uF6c4QLy8e2Q+pq51ouFyq1TAWfULUPNKgdDuPJnZiSkDAlbyPJtqCczsOtTQIcWq
	 Xwk23Q0H/G1yH3+rwV8jMDK324IwSmeAkwDNcnLnBXup8smQfjYCczenoIBvyS5ug/
	 opWyJB9SjEBWNgvb91KtU8zUErt6hrCDklP/3u6jUy/pGqwDuzAbr/NL1Z3kksxQ9h
	 0mCqIvBdCLJyyQKrhZ8BtvlsVnBh56B2qm8M5VcRcPuTL57t3WqbEnU5+e52foE23C
	 ZjvXANOinKIjQWZjZcLx1dQpPuVkk1HCs7XpsauJSFdEchxLcjtZ20IkI3cng4UpSO
	 zhnUetiiNW6bg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 18/45] tty: vt: make consw::con_debug_*() return void
Date: Thu, 18 Jan 2024 08:57:29 +0100
Message-ID: <20240118075756.10541-19-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118075756.10541-1-jirislaby@kernel.org>
References: <20240118075756.10541-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The return value of con_debug_enter() and con_debug_leave() is ignored
on many fronts. So just don't propagate errors (the current
implementations return 0 anyway) and make the return type a void.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
---
 drivers/tty/vt/vt.c              | 21 ++++-----------------
 drivers/video/fbdev/core/fbcon.c |  6 ++----
 include/linux/console.h          | 18 ++++++------------
 3 files changed, 12 insertions(+), 33 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 7006889c920d..a953c3f262a5 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -4026,15 +4026,9 @@ EXPORT_SYMBOL(con_is_visible);
  * Called when the console is taken over by the kernel debugger, this
  * function needs to save the current console state, then put the console
  * into a state suitable for the kernel debugger.
- *
- * RETURNS:
- * Zero on success, nonzero if a failure occurred when trying to prepare
- * the console for the debugger.
  */
-int con_debug_enter(struct vc_data *vc)
+void con_debug_enter(struct vc_data *vc)
 {
-	int ret = 0;
-
 	saved_fg_console = fg_console;
 	saved_last_console = last_console;
 	saved_want_console = want_console;
@@ -4043,7 +4037,7 @@ int con_debug_enter(struct vc_data *vc)
 	vc->vc_mode = KD_TEXT;
 	console_blanked = 0;
 	if (vc->vc_sw->con_debug_enter)
-		ret = vc->vc_sw->con_debug_enter(vc);
+		vc->vc_sw->con_debug_enter(vc);
 #ifdef CONFIG_KGDB_KDB
 	/* Set the initial LINES variable if it is not already set */
 	if (vc->vc_rows < 999) {
@@ -4073,7 +4067,6 @@ int con_debug_enter(struct vc_data *vc)
 		}
 	}
 #endif /* CONFIG_KGDB_KDB */
-	return ret;
 }
 EXPORT_SYMBOL_GPL(con_debug_enter);
 
@@ -4082,15 +4075,10 @@ EXPORT_SYMBOL_GPL(con_debug_enter);
  *
  * Restore the console state to what it was before the kernel debugger
  * was invoked.
- *
- * RETURNS:
- * Zero on success, nonzero if a failure occurred when trying to restore
- * the console.
  */
-int con_debug_leave(void)
+void con_debug_leave(void)
 {
 	struct vc_data *vc;
-	int ret = 0;
 
 	fg_console = saved_fg_console;
 	last_console = saved_last_console;
@@ -4100,8 +4088,7 @@ int con_debug_leave(void)
 
 	vc = vc_cons[fg_console].d;
 	if (vc->vc_sw->con_debug_leave)
-		ret = vc->vc_sw->con_debug_leave(vc);
-	return ret;
+		vc->vc_sw->con_debug_leave(vc);
 }
 EXPORT_SYMBOL_GPL(con_debug_leave);
 
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index dd2f4617485c..d3fb98084eda 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2243,7 +2243,7 @@ static int fbcon_blank(struct vc_data *vc, int blank, int mode_switch)
 	return 0;
 }
 
-static int fbcon_debug_enter(struct vc_data *vc)
+static void fbcon_debug_enter(struct vc_data *vc)
 {
 	struct fb_info *info = fbcon_info_from_console(vc->vc_num);
 	struct fbcon_ops *ops = info->fbcon_par;
@@ -2253,10 +2253,9 @@ static int fbcon_debug_enter(struct vc_data *vc)
 	if (info->fbops->fb_debug_enter)
 		info->fbops->fb_debug_enter(info);
 	fbcon_set_palette(vc, color_table);
-	return 0;
 }
 
-static int fbcon_debug_leave(struct vc_data *vc)
+static void fbcon_debug_leave(struct vc_data *vc)
 {
 	struct fb_info *info = fbcon_info_from_console(vc->vc_num);
 	struct fbcon_ops *ops = info->fbcon_par;
@@ -2264,7 +2263,6 @@ static int fbcon_debug_leave(struct vc_data *vc)
 	ops->graphics = ops->save_graphics;
 	if (info->fbops->fb_debug_leave)
 		info->fbops->fb_debug_leave(info);
-	return 0;
 }
 
 static int fbcon_get_font(struct vc_data *vc, struct console_font *font, unsigned int vpitch)
diff --git a/include/linux/console.h b/include/linux/console.h
index 38b379d6c624..93a1db5bf3b5 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -88,11 +88,11 @@ struct consw {
 	 * limited to, unblanking the console, loading an appropriate
 	 * palette, and allowing debugger generated output.
 	 */
-	int	(*con_debug_enter)(struct vc_data *vc);
+	void	(*con_debug_enter)(struct vc_data *vc);
 	/*
 	 * Restore the console to its pre-debug state as closely as possible.
 	 */
-	int	(*con_debug_leave)(struct vc_data *vc);
+	void	(*con_debug_leave)(struct vc_data *vc);
 };
 
 extern const struct consw *conswitchp;
@@ -113,17 +113,11 @@ int do_unregister_con_driver(const struct consw *csw);
 int do_take_over_console(const struct consw *sw, int first, int last, int deflt);
 void give_up_console(const struct consw *sw);
 #ifdef CONFIG_HW_CONSOLE
-int con_debug_enter(struct vc_data *vc);
-int con_debug_leave(void);
+void con_debug_enter(struct vc_data *vc);
+void con_debug_leave(void);
 #else
-static inline int con_debug_enter(struct vc_data *vc)
-{
-	return 0;
-}
-static inline int con_debug_leave(void)
-{
-	return 0;
-}
+static inline void con_debug_enter(struct vc_data *vc) { }
+static inline void con_debug_leave(void) { }
 #endif
 
 /* cursor */
-- 
2.43.0


