Return-Path: <linux-kernel+bounces-49330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9251F8468BC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49D41292C6B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5941447F4A;
	Fri,  2 Feb 2024 06:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWApjrEh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7769342A8C;
	Fri,  2 Feb 2024 06:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856993; cv=none; b=EMjy/K6BU+4ySmZL564kcr7nW1gpGZQqTtGWF5OIyn+8mwOoRI9iYOMWhTlMPYJ2u5H79I369WDQdzru+JtflzLQPmaSds95qwCgZGUVNWSW9eE9XhCvQc4cckjVnKxVT3luLz0ohQZhGYQGPp5QJmmgmewnj7DWVISjUSnvyUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856993; c=relaxed/simple;
	bh=2KcL2ijyRKHlKaD+KC9TeZ0POGrQVYsHbeWSN8pgPQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Am2AyS4mE8KaBdc5SC7FC2AS/ERqv551FZglKxBhWG4CSp/27v11Idik/Au6Pyhu3FWKTu6Z0vGDJNgdFJ2hG+PRmIYQQxGYS5k3ruFwB9e0AWViC0OOPuzKHbsA2FSKp9GetOpZkm/rRO7gbN+GUg69sTvP8LpNBQfiJn3Rq2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tWApjrEh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0772CC433F1;
	Fri,  2 Feb 2024 06:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706856993;
	bh=2KcL2ijyRKHlKaD+KC9TeZ0POGrQVYsHbeWSN8pgPQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tWApjrEhNdAFoMhUQ5jOlLTZ8nZVO9Hnwzqy/IQfCJ+ZJvbHHypYV67Q9q5KS20PL
	 XcmGX1GFlKt7VsJCVjgW5S4lLSZWIGhz+Bn3j9U5WwJMqRU9kNZuJd6PgBzkHU9SiU
	 Gh+FS+BO5iOuP5Oz9tCOa/SBVkIfau2NCLpGi5YNh3KsY5okVcEv0n/dWoLFdh13JU
	 MvT/nDLGUOrm5VjuyE8MZgRvCj3TtFQ5UQOyIVQrHAcZz7letqa2cqG0iss7xZWnL7
	 sNzMPybXhLrqVrgCQWS2J5pjtsSEsR6rqSETPrmhYhrheE++c4e4FC9SetN1YuR4gj
	 4K7sksHHxAffg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 14/22] tty: vt: move CSI ECMA handling to a separate function
Date: Fri,  2 Feb 2024 07:56:00 +0100
Message-ID: <20240202065608.14019-15-jirislaby@kernel.org>
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

Similar to previous moves, move also "CSI ..." (i.e. vc_priv == EPecma)
handling to a separate function.

This is the last large move of code out of do_con_trol(). And despite it
is still 151 lines of code (down from 407!), it is now quite easy to
folllow the transitions of the state machine in there. ESnonstd and
ESpalette handling still can be moved away, but it won't improve that
much.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 269 +++++++++++++++++++++++---------------------
 1 file changed, 139 insertions(+), 130 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 7cdd0eb1e423..1c832d04c0dc 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2375,6 +2375,143 @@ static void csi_DEC(struct tty_struct *tty, struct vc_data *vc, u8 c)
 	}
 }
 
+/*
+ * Handle Control Sequence Introducer control characters. That is
+ * "ESC [ parameters char". Parameters are in @vc->vc_par and the char is in
+ * @c here.
+ */
+static void csi_ECMA(struct tty_struct *tty, struct vc_data *vc, u8 c)
+{
+	switch (c) {
+	case 'G':
+	case '`':
+		if (vc->vc_par[0])
+			vc->vc_par[0]--;
+		gotoxy(vc, vc->vc_par[0], vc->state.y);
+		break;
+	case 'A':
+		if (!vc->vc_par[0])
+			vc->vc_par[0]++;
+		gotoxy(vc, vc->state.x, vc->state.y - vc->vc_par[0]);
+		break;
+	case 'B':
+	case 'e':
+		if (!vc->vc_par[0])
+			vc->vc_par[0]++;
+		gotoxy(vc, vc->state.x, vc->state.y + vc->vc_par[0]);
+		break;
+	case 'C':
+	case 'a':
+		if (!vc->vc_par[0])
+			vc->vc_par[0]++;
+		gotoxy(vc, vc->state.x + vc->vc_par[0], vc->state.y);
+		break;
+	case 'D':
+		if (!vc->vc_par[0])
+			vc->vc_par[0]++;
+		gotoxy(vc, vc->state.x - vc->vc_par[0], vc->state.y);
+		break;
+	case 'E':
+		if (!vc->vc_par[0])
+			vc->vc_par[0]++;
+		gotoxy(vc, 0, vc->state.y + vc->vc_par[0]);
+		break;
+	case 'F':
+		if (!vc->vc_par[0])
+			vc->vc_par[0]++;
+		gotoxy(vc, 0, vc->state.y - vc->vc_par[0]);
+		break;
+	case 'd':
+		if (vc->vc_par[0])
+			vc->vc_par[0]--;
+		gotoxay(vc, vc->state.x ,vc->vc_par[0]);
+		break;
+	case 'H':
+	case 'f':
+		if (vc->vc_par[0])
+			vc->vc_par[0]--;
+		if (vc->vc_par[1])
+			vc->vc_par[1]--;
+		gotoxay(vc, vc->vc_par[1], vc->vc_par[0]);
+		break;
+	case 'J':
+		csi_J(vc, vc->vc_par[0]);
+		break;
+	case 'K':
+		csi_K(vc);
+		break;
+	case 'L':
+		csi_L(vc);
+		break;
+	case 'M':
+		csi_M(vc);
+		break;
+	case 'P':
+		csi_P(vc);
+		break;
+	case 'c':
+		if (!vc->vc_par[0])
+			respond_ID(tty);
+		break;
+	case 'g':
+		if (!vc->vc_par[0] && vc->state.x < VC_TABSTOPS_COUNT)
+			set_bit(vc->state.x, vc->vc_tab_stop);
+		else if (vc->vc_par[0] == 3)
+			bitmap_zero(vc->vc_tab_stop, VC_TABSTOPS_COUNT);
+		break;
+	case 'h':
+		csi_hl(vc, true);
+		break;
+	case 'l':
+		csi_hl(vc, false);
+		break;
+	case 'm':
+		csi_m(vc);
+		break;
+	case 'n':
+		if (vc->vc_par[0] == 5)
+			status_report(tty);
+		else if (vc->vc_par[0] == 6)
+			cursor_report(vc, tty);
+		break;
+	case 'q': /* DECLL - but only 3 leds */
+		/* map 0,1,2,3 to 0,1,2,4 */
+		if (vc->vc_par[0] < 4)
+			vt_set_led_state(vc->vc_num,
+				    (vc->vc_par[0] < 3) ? vc->vc_par[0] : 4);
+		break;
+	case 'r':
+		if (!vc->vc_par[0])
+			vc->vc_par[0]++;
+		if (!vc->vc_par[1])
+			vc->vc_par[1] = vc->vc_rows;
+		/* Minimum allowed region is 2 lines */
+		if (vc->vc_par[0] < vc->vc_par[1] &&
+		    vc->vc_par[1] <= vc->vc_rows) {
+			vc->vc_top = vc->vc_par[0] - 1;
+			vc->vc_bottom = vc->vc_par[1];
+			gotoxay(vc, 0, 0);
+		}
+		break;
+	case 's':
+		save_cur(vc);
+		break;
+	case 'u':
+		restore_cur(vc);
+		break;
+	case 'X':
+		csi_X(vc);
+		break;
+	case '@':
+		csi_at(vc, vc->vc_par[0]);
+		break;
+	case ']':
+		csi_RSB(vc);
+		break;
+	}
+
+}
+
 /* console_lock is held */
 static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, u8 c)
 {
@@ -2470,139 +2607,11 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, u8 c)
 			csi_DEC(tty, vc, c);
 			return;
 		case EPecma:
-			break;
-		default:
-			return;
-		}
-
-		switch(c) {
-		case 'G':
-		case '`':
-			if (vc->vc_par[0])
-				vc->vc_par[0]--;
-			gotoxy(vc, vc->vc_par[0], vc->state.y);
-			return;
-		case 'A':
-			if (!vc->vc_par[0])
-				vc->vc_par[0]++;
-			gotoxy(vc, vc->state.x, vc->state.y - vc->vc_par[0]);
-			return;
-		case 'B':
-		case 'e':
-			if (!vc->vc_par[0])
-				vc->vc_par[0]++;
-			gotoxy(vc, vc->state.x, vc->state.y + vc->vc_par[0]);
-			return;
-		case 'C':
-		case 'a':
-			if (!vc->vc_par[0])
-				vc->vc_par[0]++;
-			gotoxy(vc, vc->state.x + vc->vc_par[0], vc->state.y);
-			return;
-		case 'D':
-			if (!vc->vc_par[0])
-				vc->vc_par[0]++;
-			gotoxy(vc, vc->state.x - vc->vc_par[0], vc->state.y);
-			return;
-		case 'E':
-			if (!vc->vc_par[0])
-				vc->vc_par[0]++;
-			gotoxy(vc, 0, vc->state.y + vc->vc_par[0]);
+			csi_ECMA(tty, vc, c);
 			return;
-		case 'F':
-			if (!vc->vc_par[0])
-				vc->vc_par[0]++;
-			gotoxy(vc, 0, vc->state.y - vc->vc_par[0]);
-			return;
-		case 'd':
-			if (vc->vc_par[0])
-				vc->vc_par[0]--;
-			gotoxay(vc, vc->state.x ,vc->vc_par[0]);
-			return;
-		case 'H':
-		case 'f':
-			if (vc->vc_par[0])
-				vc->vc_par[0]--;
-			if (vc->vc_par[1])
-				vc->vc_par[1]--;
-			gotoxay(vc, vc->vc_par[1], vc->vc_par[0]);
-			return;
-		case 'J':
-			csi_J(vc, vc->vc_par[0]);
-			return;
-		case 'K':
-			csi_K(vc);
-			return;
-		case 'L':
-			csi_L(vc);
-			return;
-		case 'M':
-			csi_M(vc);
-			return;
-		case 'P':
-			csi_P(vc);
-			return;
-		case 'c':
-			if (!vc->vc_par[0])
-				respond_ID(tty);
-			return;
-		case 'g':
-			if (!vc->vc_par[0] && vc->state.x < VC_TABSTOPS_COUNT)
-				set_bit(vc->state.x, vc->vc_tab_stop);
-			else if (vc->vc_par[0] == 3)
-				bitmap_zero(vc->vc_tab_stop, VC_TABSTOPS_COUNT);
-			return;
-		case 'h':
-			csi_hl(vc, true);
-			return;
-		case 'l':
-			csi_hl(vc, false);
-			return;
-		case 'm':
-			csi_m(vc);
-			return;
-		case 'n':
-			if (vc->vc_par[0] == 5)
-				status_report(tty);
-			else if (vc->vc_par[0] == 6)
-				cursor_report(vc, tty);
-			return;
-		case 'q': /* DECLL - but only 3 leds */
-			/* map 0,1,2,3 to 0,1,2,4 */
-			if (vc->vc_par[0] < 4)
-				vt_set_led_state(vc->vc_num,
-					    (vc->vc_par[0] < 3) ? vc->vc_par[0] : 4);
-			return;
-		case 'r':
-			if (!vc->vc_par[0])
-				vc->vc_par[0]++;
-			if (!vc->vc_par[1])
-				vc->vc_par[1] = vc->vc_rows;
-			/* Minimum allowed region is 2 lines */
-			if (vc->vc_par[0] < vc->vc_par[1] &&
-			    vc->vc_par[1] <= vc->vc_rows) {
-				vc->vc_top = vc->vc_par[0] - 1;
-				vc->vc_bottom = vc->vc_par[1];
-				gotoxay(vc, 0, 0);
-			}
-			return;
-		case 's':
-			save_cur(vc);
-			return;
-		case 'u':
-			restore_cur(vc);
-			return;
-		case 'X':
-			csi_X(vc);
-			return;
-		case '@':
-			csi_at(vc, vc->vc_par[0]);
-			return;
-		case ']':
-			csi_RSB(vc);
+		default:
 			return;
 		}
-		return;
 	case EScsiignore:
 		if (c >= ASCII_CSI_IGNORE_FIRST && c <= ASCII_CSI_IGNORE_LAST)
 			return;
-- 
2.43.0


