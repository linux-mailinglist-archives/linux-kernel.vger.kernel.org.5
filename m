Return-Path: <linux-kernel+bounces-29829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E36B831426
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27E142829E3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8799634555;
	Thu, 18 Jan 2024 07:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLwZ4F05"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04B8339A8;
	Thu, 18 Jan 2024 07:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705564774; cv=none; b=mVNo9IdWeNNkI2Gm9Aickaboi1xGZGia4N8bibMELhRZZAT7XVCpDz10TED4Xw9hJ1wvdvNueAPnEPDZ5Het7NCnaCNI0ZloAR69bHVrA8U2Pj2uUKvXT/cSeaftJhciwiFNHULTVtokECdX56melTxTZWOumahAAw/T4tM7PmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705564774; c=relaxed/simple;
	bh=RC22BQx0kbG70JjJvH62n7U8+Gh474y8m3MFwF6L5Vs=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=HE6KRKuKa9AkHHvHvUgYQuU94x1XOK5KgPg1lX3IzJePP6LiEdofIeX8srlfJ/vVI7SvCKV53OBG/12o80F+KPX8js8Ed0GKAsDGxFGGqNI1d1B+tUc3855bLs7ceujOts+Ty9vO08pkFw95lQWIzIABc4Stc/5uyYVHxnXR2Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sLwZ4F05; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76835C433A6;
	Thu, 18 Jan 2024 07:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705564774;
	bh=RC22BQx0kbG70JjJvH62n7U8+Gh474y8m3MFwF6L5Vs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sLwZ4F05MrYEF54KC/+C3qaXPotuwtG5E4/LIWqd42k0DIVfjhyMWHuy5iR4b3pnP
	 B0vgYo+YNOnimfSCP+beBBIqfzDWsrz1XbOnQAPV1YgT+66P4FIobRWhTgvdT3xJMt
	 lYSEjuJSR7B6/wnwWpUwlfbqDdnwCs6TnuDydwIggaBZE6NPZN+nziOyENdGrUa+L7
	 zfKfct2SexL9ymi++7ojdRfEgiJmhmDLcrTsQZWUH6N5QQJ7U1FkPzi+at9D0EASM2
	 heblFF/nqaaMjlc7c4wHRzDdO+ufo6c1+MT4rVPMV9Zh69MVluZ8yNsFGc///B/WHC
	 93PwawjfuRlWg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 42/45] tty: vt: remove unused consw::con_flush_scrollback()
Date: Thu, 18 Jan 2024 08:57:53 +0100
Message-ID: <20240118075756.10541-43-jirislaby@kernel.org>
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

consw::con_flush_scrollback() is unused since commit 973c096f6a85
(vgacon: remove software scrollback support). Drop it.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c     | 27 ++++++++++++---------------
 include/linux/console.h |  4 ----
 2 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 539b30e198a9..35d303017653 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -888,21 +888,18 @@ static void flush_scrollback(struct vc_data *vc)
 	WARN_CONSOLE_UNLOCKED();
 
 	set_origin(vc);
-	if (vc->vc_sw->con_flush_scrollback) {
-		vc->vc_sw->con_flush_scrollback(vc);
-	} else if (con_is_visible(vc)) {
-		/*
-		 * When no con_flush_scrollback method is provided then the
-		 * legacy way for flushing the scrollback buffer is to use
-		 * a side effect of the con_switch method. We do it only on
-		 * the foreground console as background consoles have no
-		 * scrollback buffers in that case and we obviously don't
-		 * want to switch to them.
-		 */
-		hide_cursor(vc);
-		vc->vc_sw->con_switch(vc);
-		set_cursor(vc);
-	}
+	if (!con_is_visible(vc))
+		return;
+
+	/*
+	 * The legacy way for flushing the scrollback buffer is to use a side
+	 * effect of the con_switch method. We do it only on the foreground
+	 * console as background consoles have no scrollback buffers in that
+	 * case and we obviously don't want to switch to them.
+	 */
+	hide_cursor(vc);
+	vc->vc_sw->con_switch(vc);
+	set_cursor(vc);
 }
 
 /*
diff --git a/include/linux/console.h b/include/linux/console.h
index c0525ccc54d9..698a2f7576b0 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -104,10 +104,6 @@ struct consw {
 			enum vc_intensity intensity,
 			bool blink, bool underline, bool reverse, bool italic);
 	void	(*con_invert_region)(struct vc_data *vc, u16 *p, int count);
-	/*
-	 * Flush the video console driver's scrollback buffer
-	 */
-	void	(*con_flush_scrollback)(struct vc_data *vc);
 	/*
 	 * Prepare the console for the debugger.  This includes, but is not
 	 * limited to, unblanking the console, loading an appropriate
-- 
2.43.0


