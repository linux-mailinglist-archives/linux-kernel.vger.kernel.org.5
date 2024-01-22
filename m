Return-Path: <linux-kernel+bounces-32832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FBD8360AC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBECE1C20D8A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FDF3F8FD;
	Mon, 22 Jan 2024 11:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onhVpjAx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5700D3F8E2;
	Mon, 22 Jan 2024 11:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921490; cv=none; b=QmCNVvoPK0gQ0T32UExHGgnrtg4w8QKDtphzeo/jlk37k5rXE1uRQIDN5X/FIK0VWe5PBi3IDCv3HYxhxm80NvUXenDS2tyiQ4WJ64C5jqAWthCjz9IkekKeXhjPHIqjRrp0jHv05Ti+ggS140l0PM8s75bV8GdlPw4GFNg2L/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921490; c=relaxed/simple;
	bh=+0JYp8fleAI4TMmDNOgjDGB1wBxRfMOMfgS9dM3MHeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6zohg1wKc/eGBxnt9QoCb4bxEFVxvwE5b1K7MHP83CeW4fFskgT72562s3PglFEILNnpMMTVpjrBMkdrRzfXmUvACuez09RwWhgzK1dljQ94AhbM/1lhOdLtQAp7yxRRNf8CNswqi5zN5pV06ekX1nFx6nlJ4HwFq25InPdY1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onhVpjAx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A2EC43609;
	Mon, 22 Jan 2024 11:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705921490;
	bh=+0JYp8fleAI4TMmDNOgjDGB1wBxRfMOMfgS9dM3MHeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=onhVpjAxihK17dsdcc9mvDAb+u/7v7l/O/gaQz0FdcSmFFXgkCWn0ER9L43uOKKRZ
	 BKBlsCjKQFZfjDKwPJVJO/RNZizG3gAbJYfiQldu5vBZxHx8CKUVIiwxG9HlsBWrtn
	 /XaRn5wC3QeRN1p1LaIoM5aX3CaIjgD2VPDx390J2CZR/Rw8CRvJjgRg11dZD/NaLr
	 k/v8/pCOwzPorOxRpEKQ0UxF9G6fwyv8iCOTlgMgYs3wlPwxljBR46Drqo+j1tYTay
	 5VNivMU4cD03x0S+lxZ+4kXVEShrq/cIUTs+nQVvpXNT4TgNCK9iCGUO1qUqPbRl5n
	 iZglDHJ2uQrBA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 23/47] tty: vt: add con_putc() helper
Date: Mon, 22 Jan 2024 12:03:37 +0100
Message-ID: <20240122110401.7289-24-jirislaby@kernel.org>
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

And let it call consw::con_putc() if it exists, otherwise
consw::con_putcs(). This is similar to tty_put_char().

It supports dropping unneeded duplication of code like sticon_putc() is
(see the next patch).

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index b6f1449421bc..6091ffcf93d8 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -300,6 +300,14 @@ static inline unsigned short *screenpos(const struct vc_data *vc, int offset,
 	return p;
 }
 
+static void con_putc(struct vc_data *vc, u16 ca, unsigned int y, unsigned int x)
+{
+	if (vc->vc_sw->con_putc)
+		vc->vc_sw->con_putc(vc, ca, y, x);
+	else
+		vc->vc_sw->con_putcs(vc, &ca, 1, y, x);
+}
+
 /* Called  from the keyboard irq path.. */
 static inline void scrolldelta(int lines)
 {
@@ -762,7 +770,7 @@ void complement_pos(struct vc_data *vc, int offset)
 	    old_offset < vc->vc_screenbuf_size) {
 		scr_writew(old, screenpos(vc, old_offset, true));
 		if (con_should_update(vc))
-			vc->vc_sw->con_putc(vc, old, oldy, oldx);
+			con_putc(vc, old, oldy, oldx);
 		notify_update(vc);
 	}
 
@@ -779,7 +787,7 @@ void complement_pos(struct vc_data *vc, int offset)
 		if (con_should_update(vc)) {
 			oldx = (offset >> 1) % vc->vc_cols;
 			oldy = (offset >> 1) / vc->vc_cols;
-			vc->vc_sw->con_putc(vc, new, oldy, oldx);
+			con_putc(vc, new, oldy, oldx);
 		}
 		notify_update(vc);
 	}
@@ -833,7 +841,7 @@ static void add_softcursor(struct vc_data *vc)
 		i ^= CUR_FG;
 	scr_writew(i, (u16 *)vc->vc_pos);
 	if (con_should_update(vc))
-		vc->vc_sw->con_putc(vc, i, vc->state.y, vc->state.x);
+		con_putc(vc, i, vc->state.y, vc->state.x);
 }
 
 static void hide_softcursor(struct vc_data *vc)
@@ -841,8 +849,8 @@ static void hide_softcursor(struct vc_data *vc)
 	if (softcursor_original != -1) {
 		scr_writew(softcursor_original, (u16 *)vc->vc_pos);
 		if (con_should_update(vc))
-			vc->vc_sw->con_putc(vc, softcursor_original,
-					vc->state.y, vc->state.x);
+			con_putc(vc, softcursor_original, vc->state.y,
+				 vc->state.x);
 		softcursor_original = -1;
 	}
 }
-- 
2.43.0


