Return-Path: <linux-kernel+bounces-49319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 090688468A0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BDA71C239CC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A7B18054;
	Fri,  2 Feb 2024 06:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RASuBlnz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905AD18036;
	Fri,  2 Feb 2024 06:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856978; cv=none; b=FEabLS1bxAPVfC71/S7wGeQAItpBaNyK2JeGRXcsLWtDcQbMUQ+2WXVNBJzfZdvYZzHLGoZTEkU5lb7bNkePXfTWJQp0CyCLXDrvxBK4GI9zUNBaiDkq1wOedc3dqsk+aup46H1KyJOdqGZafoSDqkiAqwerlkHS2C8itOeR/sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856978; c=relaxed/simple;
	bh=miH8BEvG/hsFaXFdQjVxX6ykS62LQxmbGXrx1onhjCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p4WxYzeupey9TVm7qIumQB06SfmujKT3I/0PPajS23U6KvHPbWpzx7qdw2W7a9h5jdVPSPm33gOt2eayvU0jtgXTLJGIjfOsUYE/vAajNqbY4gpUh41zoOLy0C7B1WRVwZcMZyDhl7/W+4KhpveRxkd2eWQdiI76ghjeWL1NikA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RASuBlnz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE841C433C7;
	Fri,  2 Feb 2024 06:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706856978;
	bh=miH8BEvG/hsFaXFdQjVxX6ykS62LQxmbGXrx1onhjCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RASuBlnzt4kzH4bqRksl37SOd8Mpr2gElneWbxC6iEeW5Tn7GTLbGe3kS11DD2XWW
	 U/aZ6bCHc/HDD/cpIj2Ji1r1+KLsUigWKqF80hF9Qq2ikc/GE5QF/DJCBu7JCniEFA
	 TBVr9CGOh4/rTR6zyR7DjMypg71e0ZPy/GVe4AfP/K+YJf9+AW6KMmsJw5Jgi5d0JN
	 b1gkZflbUN8N+HlLns9vwALQ7Jo9SNBPAaTe1BjakhbbFp8zYam/ReYR7ygcQfRvkr
	 QQzGBHFxP0j/iYfeCpGd6b22wsAauN2lKAWs5hzKV+OUQ8InoSSUswN3KJgqG+GIIp
	 +cGJYBatY5VaQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 04/22] tty: vt: split DEC CSI+h/l handling into csi_DEC_hl()
Date: Fri,  2 Feb 2024 07:55:50 +0100
Message-ID: <20240202065608.14019-5-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202065608.14019-1-jirislaby@kernel.org>
References: <20240202065608.14019-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DEC and ECMA handling of CSI+h/l is needlessly complicated. Split
these two, so that DEC is handled when the state is EPdec ('CSI ?' was
seen) and ECMA is handled in the EPecma state (no '?').

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 144 +++++++++++++++++++++++---------------------
 1 file changed, 77 insertions(+), 67 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index ae333f49790a..d04dbafc0517 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1874,6 +1874,59 @@ enum {
 	CSI_DEC_hl_MOUSE_VT200	= 1000,
 };
 
+/* console_lock is held */
+static void csi_DEC_hl(struct vc_data *vc, bool on_off)
+{
+	unsigned int i;
+
+	for (i = 0; i <= vc->vc_npar; i++)
+		switch (vc->vc_par[i]) {
+		case CSI_DEC_hl_CURSOR_KEYS:
+			if (on_off)
+				set_kbd(vc, decckm);
+			else
+				clr_kbd(vc, decckm);
+			break;
+		case CSI_DEC_hl_132_COLUMNS:	/* unimplemented */
+#if 0
+			vc_resize(deccolm ? 132 : 80, vc->vc_rows);
+			/* this alone does not suffice; some user mode
+			   utility has to change the hardware regs */
+#endif
+			break;
+		case CSI_DEC_hl_REVERSE_VIDEO:
+			if (vc->vc_decscnm != on_off) {
+				vc->vc_decscnm = on_off;
+				invert_screen(vc, 0, vc->vc_screenbuf_size,
+					      false);
+				update_attr(vc);
+			}
+			break;
+		case CSI_DEC_hl_ORIGIN_MODE:
+			vc->vc_decom = on_off;
+			gotoxay(vc, 0, 0);
+			break;
+		case CSI_DEC_hl_AUTOWRAP:
+			vc->vc_decawm = on_off;
+			break;
+		case CSI_DEC_hl_AUTOREPEAT:
+			if (on_off)
+				set_kbd(vc, decarm);
+			else
+				clr_kbd(vc, decarm);
+			break;
+		case CSI_DEC_hl_MOUSE_X10:
+			vc->vc_report_mouse = on_off ? 1 : 0;
+			break;
+		case CSI_DEC_hl_SHOW_CURSOR:
+			vc->vc_deccm = on_off;
+			break;
+		case CSI_DEC_hl_MOUSE_VT200:
+			vc->vc_report_mouse = on_off ? 2 : 0;
+			break;
+		}
+}
+
 enum {
 	CSI_hl_DISPLAY_CTRL	= 3,	/* handle ansi control chars */
 	CSI_hl_INSERT		= 4,	/* IRM: insert/replace */
@@ -1883,71 +1936,22 @@ enum {
 /* console_lock is held */
 static void csi_hl(struct vc_data *vc, bool on_off)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i <= vc->vc_npar; i++)
-		if (vc->vc_priv == EPdec) {
-			switch(vc->vc_par[i]) {	/* DEC private modes set/reset */
-			case CSI_DEC_hl_CURSOR_KEYS:
-				if (on_off)
-					set_kbd(vc, decckm);
-				else
-					clr_kbd(vc, decckm);
-				break;
-			case CSI_DEC_hl_132_COLUMNS:	/* unimplemented */
-#if 0
-				vc_resize(deccolm ? 132 : 80, vc->vc_rows);
-				/* this alone does not suffice; some user mode
-				   utility has to change the hardware regs */
-#endif
-				break;
-			case CSI_DEC_hl_REVERSE_VIDEO:
-				if (vc->vc_decscnm != on_off) {
-					vc->vc_decscnm = on_off;
-					invert_screen(vc, 0,
-							vc->vc_screenbuf_size,
-							false);
-					update_attr(vc);
-				}
-				break;
-			case CSI_DEC_hl_ORIGIN_MODE:
-				vc->vc_decom = on_off;
-				gotoxay(vc, 0, 0);
-				break;
-			case CSI_DEC_hl_AUTOWRAP:
-				vc->vc_decawm = on_off;
-				break;
-			case CSI_DEC_hl_AUTOREPEAT:
-				if (on_off)
-					set_kbd(vc, decarm);
-				else
-					clr_kbd(vc, decarm);
-				break;
-			case CSI_DEC_hl_MOUSE_X10:
-				vc->vc_report_mouse = on_off ? 1 : 0;
-				break;
-			case CSI_DEC_hl_SHOW_CURSOR:
-				vc->vc_deccm = on_off;
-				break;
-			case CSI_DEC_hl_MOUSE_VT200:
-				vc->vc_report_mouse = on_off ? 2 : 0;
-				break;
-			}
-		} else {
-			switch(vc->vc_par[i]) {	/* ANSI modes set/reset */
-			case CSI_hl_DISPLAY_CTRL:
-				vc->vc_disp_ctrl = on_off;
-				break;
-			case CSI_hl_INSERT:
-				vc->vc_decim = on_off;
-				break;
-			case CSI_hl_AUTO_NL:
-				if (on_off)
-					set_kbd(vc, lnm);
-				else
-					clr_kbd(vc, lnm);
-				break;
-			}
+		switch (vc->vc_par[i]) {	/* ANSI modes set/reset */
+		case CSI_hl_DISPLAY_CTRL:
+			vc->vc_disp_ctrl = on_off;
+			break;
+		case CSI_hl_INSERT:
+			vc->vc_decim = on_off;
+			break;
+		case CSI_hl_AUTO_NL:
+			if (on_off)
+				set_kbd(vc, lnm);
+			else
+				clr_kbd(vc, lnm);
+			break;
 		}
 }
 
@@ -2379,12 +2383,12 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 		vc->vc_state = ESnormal;
 		switch(c) {
 		case 'h':
-			if (vc->vc_priv <= EPdec)
-				csi_hl(vc, true);
+			if (vc->vc_priv == EPdec)
+				csi_DEC_hl(vc, true);
 			return;
 		case 'l':
-			if (vc->vc_priv <= EPdec)
-				csi_hl(vc, false);
+			if (vc->vc_priv == EPdec)
+				csi_DEC_hl(vc, false);
 			return;
 		case 'c':
 			if (vc->vc_priv == EPdec) {
@@ -2494,6 +2498,12 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 			else if (vc->vc_par[0] == 3)
 				bitmap_zero(vc->vc_tab_stop, VC_TABSTOPS_COUNT);
 			return;
+		case 'h':
+			csi_hl(vc, true);
+			return;
+		case 'l':
+			csi_hl(vc, false);
+			return;
 		case 'm':
 			csi_m(vc);
 			return;
-- 
2.43.0


