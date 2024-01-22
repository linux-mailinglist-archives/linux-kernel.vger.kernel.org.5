Return-Path: <linux-kernel+bounces-32826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA71983609A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 601D61F227B0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0568A3A8F8;
	Mon, 22 Jan 2024 11:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+XxE8t7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356463D96E;
	Mon, 22 Jan 2024 11:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921477; cv=none; b=e7lnSA9XuUdHReuG0W/a3Xbat/o0rRClbanTIoowOmcz7SOqJvev6BSR2eCmOrev7A6nfTM3loD9TXrzoHEvpmByP3cFjtVVolVzAnBQ5g0GUO5YNi4YBKUU0ZD9zbXhjOPd+c3G581+e+EgvBrHf1cbDElRGcqZrX4jRqBMTwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921477; c=relaxed/simple;
	bh=Uu87mm2M+m6Hd05cPkak7Z4o+qrJBfuAGdCq0mnOoYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hAqeoKei4QE8wg2Nfo18sUfE9F2owOSpiYm2ftESZ4mU+0MEFRUoRMsgAqjjICe7mPIGsw1Dt8rEUXqgiJF476t6EWdj32n9HTEEX6HMIPu89Lrl7pIym3JG6xb9LomBoonIBciVf0eS575hgpFmUdGMiieInJcS4WTUhzaPKBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+XxE8t7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65632C433A6;
	Mon, 22 Jan 2024 11:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705921476;
	bh=Uu87mm2M+m6Hd05cPkak7Z4o+qrJBfuAGdCq0mnOoYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R+XxE8t7wIgEddHDk1cx4Bp2mRpRzfSHaNtNx+0Hal5oNmLitIwbOv8KaeRpoH7eH
	 oQvZKHg6dBGBo4W0vlS831m414hqrAlVmk0VNXKum81j9X4V4Mk1c7iRAvCv3+o6HE
	 FrYCMyQ58RU+YnFp5TfEtyzWLT4ie4GHo553L6ILXVtFns3+VXYcj2k3yBU6aoIEsz
	 99rgM/a1zBMlKz9InNyrgAEuWMmKWz2Ej4/KCiL+Fd3n2XVaJrBJDJZEn7n0akNckh
	 hB2pNKgeI3MjSIysgGAvFGF7uTwXar8JyWbR3AJ2zNpY7MpRcsD0dJsWISdaVtivP2
	 306lO2T8a5R7A==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 17/47] tty: vt: define an enum for ascii characters
Date: Mon, 22 Jan 2024 12:03:31 +0100
Message-ID: <20240122110401.7289-18-jirislaby@kernel.org>
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

I didn't find definitions for ascii in the kernel yet, so define it for
non-printable characters used here.

Note we use ' ' instead of 32 on one line too.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 62 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 44 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 8d868aa33733..51a2787415db 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2143,6 +2143,28 @@ static bool ansi_control_string(unsigned int state)
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
@@ -2150,21 +2172,22 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
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
@@ -2176,34 +2199,37 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
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
@@ -2338,7 +2364,7 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 			vc->vc_par[vc->vc_npar] += c - '0';
 			return;
 		}
-		if (c >= 0x20 && c <= 0x3f) { /* 0x2x, 0x3a and 0x3c - 0x3f */
+		if (c >= ASCII_CSI_IGNORE_FIRST && c <= ASCII_CSI_IGNORE_LAST) {
 			vc->vc_state = EScsiignore;
 			return;
 		}
@@ -2500,7 +2526,7 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 		}
 		return;
 	case EScsiignore:
-		if (c >= 0x20 && c <= 0x3f)
+		if (c >= ASCII_CSI_IGNORE_FIRST && c <= ASCII_CSI_IGNORE_LAST)
 			return;
 		vc->vc_state = ESnormal;
 		return;
@@ -2761,17 +2787,17 @@ static bool vc_is_control(struct vc_data *vc, int tc, int c)
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


