Return-Path: <linux-kernel+bounces-32840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A33D38360C5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 230271F22C0B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA5341222;
	Mon, 22 Jan 2024 11:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VB8M2U7u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3657E41210;
	Mon, 22 Jan 2024 11:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921499; cv=none; b=B+YjMHqaYH1+d+/vITwDdwGV1wGA0RPdUduVivAY8SADC7EnRnnzNIuRaXAREJV7utsGExs/+CurruzRaidkhQ62S7TW6mIS/8GGXroHDn+SRH4QQeaXOlkqTRjV+osSbRl0Iz+VAAAdJgmIOqgDS/2ASwL75h/TTQWKQihdILY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921499; c=relaxed/simple;
	bh=hodsiss2mfg9U0y8pa9F8/ETqHl8RGY45rKju+KRcEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TZ4Tz3RmiTBKB8MmyKbbzRAqTFd7p3ORbz0aE3RdxxFbAyZWbI5D3ogKeGg0PLIYqrC0FMiAl5+Yslo1c4JJlIxdaLLf55pn3xvCZ85rKdLakHBkhHsgPqGwZ17NptkkGd5rAkykC/pGNNntKp61BbA3xtAOmektS/Dbuwn6p+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VB8M2U7u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB84C433F1;
	Mon, 22 Jan 2024 11:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705921498;
	bh=hodsiss2mfg9U0y8pa9F8/ETqHl8RGY45rKju+KRcEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VB8M2U7uJLE8CpgfTcZ8Jms/TclXLPSWzKd3y5NTvJiI17nhJ3QAtxd7VF1fKTv5Y
	 XzuqRA+XEdq19ibARo3Xzx4xLbKzg7sI8HOQl5Jrzi+H251EyAnYkiAnmRUKSCnhBU
	 MQSchj+m4uG73RexbpvYargbPw1+ZJXAOEdZaozv+apTb49pryPpIV8S7iO3qseM6f
	 u3J114Ff+w3ZvRFfAZdyUmaoJ5Sid0Ezm6VUbGaMQsHTY0eRUC/L2ACGeQmOghzI0Y
	 76hXV+ZJ6XIB3Ym+wMshxo9cvM2iSjwx/t7zuPce0PoVyvTp2hHLNqaTkoxtESmIsO
	 SJexQtBTtWmaA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2 27/47] consoles: use if instead of switch-case in consw::con_cursor()
Date: Mon, 22 Jan 2024 12:03:41 +0100
Message-ID: <20240122110401.7289-28-jirislaby@kernel.org>
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

This is only a preparation for the following cleanup patch to make it
easier. Provided CM_ERASE is the only different, use 'if' instead of
'switch+case' in all those.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
---
 drivers/video/console/newport_con.c | 26 +++++-------
 drivers/video/console/sticon.c      | 27 ++++++------
 drivers/video/console/vgacon.c      | 66 +++++++++++++----------------
 3 files changed, 53 insertions(+), 66 deletions(-)

diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index 5e65ee0b7c07..f852717b88f0 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -443,24 +443,20 @@ static void newport_cursor(struct vc_data *vc, int mode)
 	unsigned short treg;
 	int xcurs, ycurs;
 
-	switch (mode) {
-	case CM_ERASE:
-		treg = newport_vc2_get(npregs, VC2_IREG_CONTROL);
-		newport_vc2_set(npregs, VC2_IREG_CONTROL,
-				(treg & ~(VC2_CTRL_ECDISP)));
-		break;
+	treg = newport_vc2_get(npregs, VC2_IREG_CONTROL);
 
-	case CM_MOVE:
-	case CM_DRAW:
-		treg = newport_vc2_get(npregs, VC2_IREG_CONTROL);
+	if (mode == CM_ERASE) {
 		newport_vc2_set(npregs, VC2_IREG_CONTROL,
-				(treg | VC2_CTRL_ECDISP));
-		xcurs = (vc->vc_pos - vc->vc_visible_origin) / 2;
-		ycurs = ((xcurs / vc->vc_cols) << 4) + 31;
-		xcurs = ((xcurs % vc->vc_cols) << 3) + xcurs_correction;
-		newport_vc2_set(npregs, VC2_IREG_CURSX, xcurs);
-		newport_vc2_set(npregs, VC2_IREG_CURSY, ycurs);
+				(treg & ~(VC2_CTRL_ECDISP)));
+		return;
 	}
+
+	newport_vc2_set(npregs, VC2_IREG_CONTROL, (treg | VC2_CTRL_ECDISP));
+	xcurs = (vc->vc_pos - vc->vc_visible_origin) / 2;
+	ycurs = ((xcurs / vc->vc_cols) << 4) + 31;
+	xcurs = ((xcurs % vc->vc_cols) << 3) + xcurs_correction;
+	newport_vc2_set(npregs, VC2_IREG_CURSX, xcurs);
+	newport_vc2_set(npregs, VC2_IREG_CURSY, ycurs);
 }
 
 static int newport_switch(struct vc_data *vc)
diff --git a/drivers/video/console/sticon.c b/drivers/video/console/sticon.c
index 906da1fde7c8..42480874db00 100644
--- a/drivers/video/console/sticon.c
+++ b/drivers/video/console/sticon.c
@@ -95,23 +95,20 @@ static void sticon_cursor(struct vc_data *conp, int mode)
 	return;
 
     car1 = conp->vc_screenbuf[conp->state.x + conp->state.y * conp->vc_cols];
-    switch (mode) {
-    case CM_ERASE:
+    if (mode == CM_ERASE) {
 	sti_putc(sticon_sti, car1, conp->state.y, conp->state.x,
 		 font_data[conp->vc_num]);
-	break;
-    case CM_MOVE:
-    case CM_DRAW:
-	switch (CUR_SIZE(conp->vc_cursor_type)) {
-	case CUR_UNDERLINE:
-	case CUR_LOWER_THIRD:
-	case CUR_LOWER_HALF:
-	case CUR_TWO_THIRDS:
-	case CUR_BLOCK:
-	    sti_putc(sticon_sti, (car1 & 255) + (0 << 8) + (7 << 11),
-		     conp->state.y, conp->state.x, font_data[conp->vc_num]);
-	    break;
-	}
+	return;
+    }
+
+    switch (CUR_SIZE(conp->vc_cursor_type)) {
+    case CUR_UNDERLINE:
+    case CUR_LOWER_THIRD:
+    case CUR_LOWER_HALF:
+    case CUR_TWO_THIRDS:
+    case CUR_BLOCK:
+	sti_putc(sticon_sti, (car1 & 255) + (0 << 8) + (7 << 11),
+		 conp->state.y, conp->state.x, font_data[conp->vc_num]);
 	break;
     }
 }
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index aa0589085847..82d01a9ccd6d 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -514,47 +514,41 @@ static void vgacon_cursor(struct vc_data *c, int mode)
 
 	c_height = c->vc_cell_height;
 
-	switch (mode) {
-	case CM_ERASE:
-		write_vga(14, (c->vc_pos - vga_vram_base) / 2);
+	write_vga(14, (c->vc_pos - vga_vram_base) / 2);
+
+	if (mode == CM_ERASE) {
 	        if (vga_video_type >= VIDEO_TYPE_VGAC)
 			vgacon_set_cursor_size(31, 30);
 		else
 			vgacon_set_cursor_size(31, 31);
-		break;
+		return;
+	}
 
-	case CM_MOVE:
-	case CM_DRAW:
-		write_vga(14, (c->vc_pos - vga_vram_base) / 2);
-		switch (CUR_SIZE(c->vc_cursor_type)) {
-		case CUR_UNDERLINE:
-			vgacon_set_cursor_size(c_height -
-					       (c_height < 10 ? 2 : 3),
-					       c_height -
-					       (c_height < 10 ? 1 : 2));
-			break;
-		case CUR_TWO_THIRDS:
-			vgacon_set_cursor_size(c_height / 3, c_height -
-					       (c_height < 10 ? 1 : 2));
-			break;
-		case CUR_LOWER_THIRD:
-			vgacon_set_cursor_size(c_height * 2 / 3, c_height -
-					       (c_height < 10 ? 1 : 2));
-			break;
-		case CUR_LOWER_HALF:
-			vgacon_set_cursor_size(c_height / 2, c_height -
-					       (c_height < 10 ? 1 : 2));
-			break;
-		case CUR_NONE:
-			if (vga_video_type >= VIDEO_TYPE_VGAC)
-				vgacon_set_cursor_size(31, 30);
-			else
-				vgacon_set_cursor_size(31, 31);
-			break;
-		default:
-			vgacon_set_cursor_size(1, c_height);
-			break;
-		}
+	switch (CUR_SIZE(c->vc_cursor_type)) {
+	case CUR_UNDERLINE:
+		vgacon_set_cursor_size(c_height - (c_height < 10 ? 2 : 3),
+				       c_height - (c_height < 10 ? 1 : 2));
+		break;
+	case CUR_TWO_THIRDS:
+		vgacon_set_cursor_size(c_height / 3,
+				       c_height - (c_height < 10 ? 1 : 2));
+		break;
+	case CUR_LOWER_THIRD:
+		vgacon_set_cursor_size(c_height * 2 / 3,
+				       c_height - (c_height < 10 ? 1 : 2));
+		break;
+	case CUR_LOWER_HALF:
+		vgacon_set_cursor_size(c_height / 2,
+				       c_height - (c_height < 10 ? 1 : 2));
+		break;
+	case CUR_NONE:
+		if (vga_video_type >= VIDEO_TYPE_VGAC)
+			vgacon_set_cursor_size(31, 30);
+		else
+			vgacon_set_cursor_size(31, 31);
+		break;
+	default:
+		vgacon_set_cursor_size(1, c_height);
 		break;
 	}
 }
-- 
2.43.0


