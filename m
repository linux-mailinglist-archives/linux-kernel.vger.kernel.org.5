Return-Path: <linux-kernel+bounces-49328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E398468B7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99E03B21021
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B143FE46;
	Fri,  2 Feb 2024 06:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmAdHWvh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88353FB14;
	Fri,  2 Feb 2024 06:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856990; cv=none; b=rFcZ0fem9FpWC85WQjPnrYPY8bCNDTVTCxR9LYbMKpUr6g995lYB0B6jEPl7jJNpiRBcoVF26G7UXOSA81U+zdp/71WO+paKFYBwEhrqlb8aDRvDvnUKQyQvR3iCmrNqPCYiWKKKeJjSCCujqCur3QN1qTEokxULvlVdU6t54n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856990; c=relaxed/simple;
	bh=dwhJ8tMD7utmbBdUx26kvWGDI4UoU+Gd4+oVhddQzgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O3O2oojnJ9h89H6YExhM1VSgHJybXxs9QJUbFbTjxTPpLI+nW24Ocb4tOorRDot/Ubyc3B2lAO6YOb3z8rVvAtXMFz9ok9zHsgapU2AtWiLB9LDloPBTvIjUof+3z9Wm1c6IXpJRluXya8kSA0GfSI0XcUtQQtpPD/WhpCUnT3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmAdHWvh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05814C43394;
	Fri,  2 Feb 2024 06:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706856990;
	bh=dwhJ8tMD7utmbBdUx26kvWGDI4UoU+Gd4+oVhddQzgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mmAdHWvhdhtg/J5rP85q53ofa/qN9bxxDAO2wfkpsuY2rWfapAMMM7o7mj6bZ8f2l
	 DOtQ7ozjMU7hkPT/nz4H2OpIB6zE8d604cgJIDyL3hVK9KPJXdrCeG+C+OUVWmIxUU
	 t9emzr1wV5Qo+7DezY0b9Jzu2nR5xu0iHIw2Qgmvfkk4FTB10VdmeiDotVF11ZfPPW
	 5B/GTowEvG22ZXeu0NlWAhqrAlcKIT2OJkbucTXgbmhUp/hUMBbsNBGNMhLwhCasL2
	 a8ZkM0nCYVWho1EsJarmzx45NtRZLEVNsVaAxXoPxsn1V9FTOdW+1HYwetHuxZnxTG
	 E7XN0m5o5rvzQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 12/22] tty: vt: separate ESesc state handling into handle_esc()
Date: Fri,  2 Feb 2024 07:55:58 +0100
Message-ID: <20240202065608.14019-13-jirislaby@kernel.org>
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

Similar to the ASCII handling, the ESC handling can be easily moved away
from do_con_trol(). So create a new handle_esc() for that.

And add a comment with an example.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 134 ++++++++++++++++++++++++--------------------
 1 file changed, 72 insertions(+), 62 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 7cda1a958c5e..3dddb7128234 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2267,6 +2267,77 @@ static bool handle_ascii(struct tty_struct *tty, struct vc_data *vc, u8 c)
 	return false;
 }
 
+/*
+ * Handle a character (@c) following an ESC (when @vc is in the ESesc state).
+ * E.g. previous ESC with @c == '[' here yields the ESsquare state (that is:
+ * CSI).
+ */
+static void handle_esc(struct tty_struct *tty, struct vc_data *vc, u8 c)
+{
+	vc->vc_state = ESnormal;
+	switch (c) {
+	case '[':
+		vc->vc_state = ESsquare;
+		break;
+	case ']':
+		vc->vc_state = ESnonstd;
+		break;
+	case '_':
+		vc->vc_state = ESapc;
+		break;
+	case '^':
+		vc->vc_state = ESpm;
+		break;
+	case '%':
+		vc->vc_state = ESpercent;
+		break;
+	case 'E':
+		cr(vc);
+		lf(vc);
+		break;
+	case 'M':
+		ri(vc);
+		break;
+	case 'D':
+		lf(vc);
+		break;
+	case 'H':
+		if (vc->state.x < VC_TABSTOPS_COUNT)
+			set_bit(vc->state.x, vc->vc_tab_stop);
+		break;
+	case 'P':
+		vc->vc_state = ESdcs;
+		break;
+	case 'Z':
+		respond_ID(tty);
+		break;
+	case '7':
+		save_cur(vc);
+		break;
+	case '8':
+		restore_cur(vc);
+		break;
+	case '(':
+		vc->vc_state = ESsetG0;
+		break;
+	case ')':
+		vc->vc_state = ESsetG1;
+		break;
+	case '#':
+		vc->vc_state = EShash;
+		break;
+	case 'c':
+		reset_terminal(vc, 1);
+		break;
+	case '>':  /* Numeric keypad */
+		clr_kbd(vc, kbdapplic);
+		break;
+	case '=':  /* Appl. keypad */
+		set_kbd(vc, kbdapplic);
+		break;
+	}
+}
+
 /* console_lock is held */
 static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, u8 c)
 {
@@ -2283,68 +2354,7 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, u8 c)
 
 	switch(vc->vc_state) {
 	case ESesc:
-		vc->vc_state = ESnormal;
-		switch (c) {
-		case '[':
-			vc->vc_state = ESsquare;
-			return;
-		case ']':
-			vc->vc_state = ESnonstd;
-			return;
-		case '_':
-			vc->vc_state = ESapc;
-			return;
-		case '^':
-			vc->vc_state = ESpm;
-			return;
-		case '%':
-			vc->vc_state = ESpercent;
-			return;
-		case 'E':
-			cr(vc);
-			lf(vc);
-			return;
-		case 'M':
-			ri(vc);
-			return;
-		case 'D':
-			lf(vc);
-			return;
-		case 'H':
-			if (vc->state.x < VC_TABSTOPS_COUNT)
-				set_bit(vc->state.x, vc->vc_tab_stop);
-			return;
-		case 'P':
-			vc->vc_state = ESdcs;
-			return;
-		case 'Z':
-			respond_ID(tty);
-			return;
-		case '7':
-			save_cur(vc);
-			return;
-		case '8':
-			restore_cur(vc);
-			return;
-		case '(':
-			vc->vc_state = ESsetG0;
-			return;
-		case ')':
-			vc->vc_state = ESsetG1;
-			return;
-		case '#':
-			vc->vc_state = EShash;
-			return;
-		case 'c':
-			reset_terminal(vc, 1);
-			return;
-		case '>':  /* Numeric keypad */
-			clr_kbd(vc, kbdapplic);
-			return;
-		case '=':  /* Appl. keypad */
-			set_kbd(vc, kbdapplic);
-			return;
-		}
+		handle_esc(tty, vc, c);
 		return;
 	case ESnonstd:
 		if (c=='P') {   /* palette escape sequence */
-- 
2.43.0


