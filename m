Return-Path: <linux-kernel+bounces-49327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6008468B4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AC3C292579
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13143B786;
	Fri,  2 Feb 2024 06:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cIadmm3N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FC539AD5;
	Fri,  2 Feb 2024 06:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856989; cv=none; b=IRA3erbRAZX2XSvS+ngaKrdPLsFiwKH/ppiPEGzxWcRVe2AYoWd45+KMfxcgRh3hke1Lrez+rgBtvRBUiUQXENnrR8U5Zb6paIyWuUKkZDRirJUvsCsmegp9qirD/nUhKl2yXY6Lg2Qpo1+ZokF3cHrbCyguId6ulFl7Qmm2epI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856989; c=relaxed/simple;
	bh=jqH2OL/S99n3SsvoefaaNMtSDFKpEggQ4kdfbyZSD9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W2iZ9RbardKLoS6/npTHk5lkGoDOEwp7MHTXZQe0qoaVOXrA/wH/8w/nMbTG2tTLYCqY/61bi5zvk1ar/mxxmzaJG5/CF8eOykG5APyipTbN4sicOglmZBcIaV0ciLuRLI7vVIPEIAcbqDqpXS9Oj7dU5136IKo42SMfqPPUjW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cIadmm3N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB43C433F1;
	Fri,  2 Feb 2024 06:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706856988;
	bh=jqH2OL/S99n3SsvoefaaNMtSDFKpEggQ4kdfbyZSD9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cIadmm3N1wg15B4yH/C2pNXeJG3c/5pfwMefBRntw6Noq+gR75j7qUqafLLaBcqxX
	 JmwfTIPPD5rTkCfngAwWDKaR1htYYgvz7QisqbrSPqY7iiWlosySh+SNbzHY3elMbh
	 iWFlBe0m6E7MbuFtWi0wAsEqUYM0J1du3/RNb7w+gJpqeVR+q4KMX+IvvdowEUTGQL
	 /zOQy8Rr/vM5JRJzYzID8iz7PxAhmcfrw1+frEIVB8tfpILGAbirZmawfONAPIjviP
	 C0xTJ16GId0eFnxVfmyX6CsROsdseS9vOmS0kgz+NB/zSe+fQ5JI+1b5sUDA0vZ4D+
	 gLE69DNNJr4Dg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 11/22] tty: vt: extract ascii handling to handle_ascii()
Date: Fri,  2 Feb 2024 07:55:57 +0100
Message-ID: <20240202065608.14019-12-jirislaby@kernel.org>
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

To make the do_con_trol() a bit more understandable, extract the ASCII
handling (the switch-case) to a separate function.

Other nested switch-cases will follow in the next patches.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 58 +++++++++++++++++++++++++++++----------------
 1 file changed, 37 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 451a852ed234..7cda1a958c5e 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2197,28 +2197,26 @@ enum {
 	ASCII_EXT_CSI		= 128 + ASCII_ESCAPE,
 };
 
-/* console_lock is held */
-static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, u8 c)
+/*
+ * Handle ascii characters in control sequences and change states accordingly.
+ * E.g. ESC sets the state of vc to ESesc.
+ *
+ * Returns: true if @c handled.
+ */
+static bool handle_ascii(struct tty_struct *tty, struct vc_data *vc, u8 c)
 {
-	/*
-	 *  Control characters can be used in the _middle_
-	 *  of an escape sequence, aside from ANSI control strings.
-	 */
-	if (ansi_control_string(vc->vc_state) && c >= ASCII_IGNORE_FIRST &&
-	    c <= ASCII_IGNORE_LAST)
-		return;
 	switch (c) {
 	case ASCII_NULL:
-		return;
+		return true;
 	case ASCII_BELL:
 		if (ansi_control_string(vc->vc_state))
 			vc->vc_state = ESnormal;
 		else if (vc->vc_bell_duration)
 			kd_mksound(vc->vc_bell_pitch, vc->vc_bell_duration);
-		return;
+		return true;
 	case ASCII_BACKSPACE:
 		bs(vc);
-		return;
+		return true;
 	case ASCII_HTAB:
 		vc->vc_pos -= (vc->state.x << 1);
 
@@ -2230,41 +2228,59 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, u8 c)
 
 		vc->vc_pos += (vc->state.x << 1);
 		notify_write(vc, '\t');
-		return;
+		return true;
 	case ASCII_LINEFEED:
 	case ASCII_VTAB:
 	case ASCII_FORMFEED:
 		lf(vc);
 		if (!is_kbd(vc, lnm))
-			return;
+			return true;
 		fallthrough;
 	case ASCII_CAR_RET:
 		cr(vc);
-		return;
+		return true;
 	case ASCII_SHIFTOUT:
 		vc->state.charset = 1;
 		vc->vc_translate = set_translate(vc->state.Gx_charset[1], vc);
 		vc->vc_disp_ctrl = 1;
-		return;
+		return true;
 	case ASCII_SHIFTIN:
 		vc->state.charset = 0;
 		vc->vc_translate = set_translate(vc->state.Gx_charset[0], vc);
 		vc->vc_disp_ctrl = 0;
-		return;
+		return true;
 	case ASCII_CANCEL:
 	case ASCII_SUBSTITUTE:
 		vc->vc_state = ESnormal;
-		return;
+		return true;
 	case ASCII_ESCAPE:
 		vc->vc_state = ESesc;
-		return;
+		return true;
 	case ASCII_DEL:
 		del(vc);
-		return;
+		return true;
 	case ASCII_EXT_CSI:
 		vc->vc_state = ESsquare;
-		return;
+		return true;
 	}
+
+	return false;
+}
+
+/* console_lock is held */
+static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, u8 c)
+{
+	/*
+	 *  Control characters can be used in the _middle_
+	 *  of an escape sequence, aside from ANSI control strings.
+	 */
+	if (ansi_control_string(vc->vc_state) && c >= ASCII_IGNORE_FIRST &&
+	    c <= ASCII_IGNORE_LAST)
+		return;
+
+	if (handle_ascii(tty, vc, c))
+		return;
+
 	switch(vc->vc_state) {
 	case ESesc:
 		vc->vc_state = ESnormal;
-- 
2.43.0


