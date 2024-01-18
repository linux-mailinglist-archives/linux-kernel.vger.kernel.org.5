Return-Path: <linux-kernel+bounces-29803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2870A8313CD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8836FB257C1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA84428E0D;
	Thu, 18 Jan 2024 07:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZmt5D9d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C5A28DDB;
	Thu, 18 Jan 2024 07:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705564712; cv=none; b=f3y4KByAecWQpdc4aHqjiEuYyOd3MnoS/ne16/370Tb6udwbesDVfGK1paS1vUiL1yL0lcCwXG6+IB5b63mAf6/0gxvuPF/KH220vHigLCn0BUvKF6+VK8jT9u/xRpd6QSLSGohOJEMY4qQGGbu+JlRzDGHrh0RZpwrk9NI8jOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705564712; c=relaxed/simple;
	bh=jneHPzOwrZgSk7jv5sxyALGkZSuZbXyrgWxzBqQrqFs=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=VLT8dA5NXuxRdWYy9iQhRsOfd/CFA6mu1Y2SWSw/reo18Tolm9MoSQgHbrAIKR0eGSvi1pbNcJo+p8s5voMMTWMYPksK6kZu7Dh8HvDsMa7sc86as1wCj2eD8ynttPjZpVf8YdD/6gEUpLFlxQMi9fQdrMZCMXZbmK5NgQtJvE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZmt5D9d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36EEC433B2;
	Thu, 18 Jan 2024 07:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705564712;
	bh=jneHPzOwrZgSk7jv5sxyALGkZSuZbXyrgWxzBqQrqFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dZmt5D9dYiMPCcxEvRJlvZyH7BZTZiz2MoMTQyYP/zx2lWrHO4PiGrXjBvjg9lsTG
	 Zz+QrXWeSJ2mNDZBF/OFwjiFPTCTEJohwzKA6yTywBjt5piVWYgx0XI5U628E4iUU6
	 ZniAl8ewU2H0kON+ozczmPw65HfC/t2XlYlzWzcnsmL3F7To2eSX+etCtTSU4c9iyZ
	 UsMS1rHHrywT2plq9hwYt17Gh4Rk23O2Tk9b7PVg0p0Q+QUtymlJgZJls7nKUJ/Noc
	 A1mVilOiNvnF3cyqGfrrTbfKSSrCGxvqrhdBj1v1+8Bj1Be+gLDdREDw3Ief5C3I/b
	 vqzU3pPVb53Aw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 16/45] tty: vt: define an enum for ascii characters
Date: Thu, 18 Jan 2024 08:57:27 +0100
Message-ID: <20240118075756.10541-17-jirislaby@kernel.org>
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

I didn't find definitions for ascii in the kernel yet, so define it for
non-printable characters used here.

Note we use ' ' instead of 32 on one line too.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 62 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 44 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 4b514187ef15..7006889c920d 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2157,6 +2157,28 @@ static bool ansi_control_string(unsigned int state)
 	return false;
 }
 
+enum {
+	ASCII_NULL		= 0,
+	ASCII_BELL		= 7,
+	ASCII_BACKSPACE		= 8,
+	ASCII_IGNORE_FIRST	= ASCII_BACKSPACE,
+	ASCII_HTAB		= 9,
+	ASCII_LINEFEED		= 10,
+	ASCII_VTAB		= 11,
+	ASCII_FORMFEED		= 12,
+	ASCII_CAR_RET		= 13,
+	ASCII_IGNORE_LAST	= ASCII_CAR_RET,
+	ASCII_SHIFTOUT		= 14,
+	ASCII_SHIFTIN		= 15,
+	ASCII_CANCEL		= 24,
+	ASCII_SUBSTITUTE	= 26,
+	ASCII_ESCAPE		= 27,
+	ASCII_CSI_IGNORE_FIRST	= ' ', /* 0x2x, 0x3a and 0x3c - 0x3f */
+	ASCII_CSI_IGNORE_LAST	= '?',
+	ASCII_DEL		= 127,
+	ASCII_EXT_CSI		= 128 + ASCII_ESCAPE,
+};
+
 /* console_lock is held */
 static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 {
@@ -2164,21 +2186,22 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 	 *  Control characters can be used in the _middle_
 	 *  of an escape sequence, aside from ANSI control strings.
 	 */
-	if (ansi_control_string(vc->vc_state) && c >= 8 && c <= 13)
+	if (ansi_control_string(vc->vc_state) && c >= ASCII_IGNORE_FIRST &&
+	    c <= ASCII_IGNORE_LAST)
 		return;
 	switch (c) {
-	case 0:
+	case ASCII_NULL:
 		return;
-	case 7:
+	case ASCII_BELL:
 		if (ansi_control_string(vc->vc_state))
 			vc->vc_state = ESnormal;
 		else if (vc->vc_bell_duration)
 			kd_mksound(vc->vc_bell_pitch, vc->vc_bell_duration);
 		return;
-	case 8:
+	case ASCII_BACKSPACE:
 		bs(vc);
 		return;
-	case 9:
+	case ASCII_HTAB:
 		vc->vc_pos -= (vc->state.x << 1);
 
 		vc->state.x = find_next_bit(vc->vc_tab_stop,
@@ -2190,34 +2213,37 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 		vc->vc_pos += (vc->state.x << 1);
 		notify_write(vc, '\t');
 		return;
-	case 10: case 11: case 12:
+	case ASCII_LINEFEED:
+	case ASCII_VTAB:
+	case ASCII_FORMFEED:
 		lf(vc);
 		if (!is_kbd(vc, lnm))
 			return;
 		fallthrough;
-	case 13:
+	case ASCII_CAR_RET:
 		cr(vc);
 		return;
-	case 14:
+	case ASCII_SHIFTOUT:
 		vc->state.charset = 1;
 		vc->vc_translate = set_translate(vc->state.Gx_charset[1], vc);
 		vc->vc_disp_ctrl = 1;
 		return;
-	case 15:
+	case ASCII_SHIFTIN:
 		vc->state.charset = 0;
 		vc->vc_translate = set_translate(vc->state.Gx_charset[0], vc);
 		vc->vc_disp_ctrl = 0;
 		return;
-	case 24: case 26:
+	case ASCII_CANCEL:
+	case ASCII_SUBSTITUTE:
 		vc->vc_state = ESnormal;
 		return;
-	case 27:
+	case ASCII_ESCAPE:
 		vc->vc_state = ESesc;
 		return;
-	case 127:
+	case ASCII_DEL:
 		del(vc);
 		return;
-	case 128+27:
+	case ASCII_EXT_CSI:
 		vc->vc_state = ESsquare;
 		return;
 	}
@@ -2352,7 +2378,7 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 			vc->vc_par[vc->vc_npar] += c - '0';
 			return;
 		}
-		if (c >= 0x20 && c <= 0x3f) { /* 0x2x, 0x3a and 0x3c - 0x3f */
+		if (c >= ASCII_CSI_IGNORE_FIRST && c <= ASCII_CSI_IGNORE_LAST) {
 			vc->vc_state = EScsiignore;
 			return;
 		}
@@ -2514,7 +2540,7 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 		}
 		return;
 	case EScsiignore:
-		if (c >= 0x20 && c <= 0x3f)
+		if (c >= ASCII_CSI_IGNORE_FIRST && c <= ASCII_CSI_IGNORE_LAST)
 			return;
 		vc->vc_state = ESnormal;
 		return;
@@ -2775,17 +2801,17 @@ static bool vc_is_control(struct vc_data *vc, int tc, int c)
 	 * useless without them; to display an arbitrary font position use the
 	 * direct-to-font zone in UTF-8 mode.
 	 */
-	if (c < 32) {
+	if (c < ' ') {
 		if (vc->vc_disp_ctrl)
 			return CTRL_ALWAYS & BIT(c);
 		else
 			return vc->vc_utf || (CTRL_ACTION & BIT(c));
 	}
 
-	if (c == 127 && !vc->vc_disp_ctrl)
+	if (c == ASCII_DEL && !vc->vc_disp_ctrl)
 		return true;
 
-	if (c == 128 + 27)
+	if (c == ASCII_EXT_CSI)
 		return true;
 
 	return false;
-- 
2.43.0


