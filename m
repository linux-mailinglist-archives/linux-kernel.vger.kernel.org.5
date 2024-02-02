Return-Path: <linux-kernel+bounces-49331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5250E8468BF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84A691C20CC3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BC647F79;
	Fri,  2 Feb 2024 06:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C67wQcD3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B849C47F52;
	Fri,  2 Feb 2024 06:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856994; cv=none; b=Odlp6DGbVnwIfHRhqrSosQ3fTBdMfNRgpJaEduzt0kUjN6vjIaTtcI8WwlPsxAfh/u6hLMOgdRQyl5ItBb6G4tOVbiZuqQ7vypFqHmEb2kYI45hTs41EW55vqbqUjbyOTgAdQIof6aHDlaxApFkicCsa0l9VrAkZmwRJTJbuWV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856994; c=relaxed/simple;
	bh=0GUh1LaUgkZ77YCZj6fr2MXPqpNXX+mysOC2Cm9UfMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IP+mJK3JHvVHno7Z10FNNGRBYPklhBPLjQURxs+X009VQszZF831s7GMtcQIPmcqg888oWlvqzgADEVEhuwYotwu02JzgabOMJN9sIJX4tq+H8kXFSwU9RM0A6spBgqKA6xOfdJpoqAPV2plcUO+f5NznI5KJMRlsq2VF0/G5qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C67wQcD3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82468C43390;
	Fri,  2 Feb 2024 06:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706856994;
	bh=0GUh1LaUgkZ77YCZj6fr2MXPqpNXX+mysOC2Cm9UfMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C67wQcD3tTtHSj1IE0ZwxgJ3G+xAwGt3zmD19kECsceqpUtYDDPTYZDiHJ2hYTJSb
	 50bgErCPc9aKBxLPuzz4NFcEKjPTkcqdGUFi8lIoePVh65km7SE5hnPS0MLC/q943h
	 31VctLSPyF5rhEWPFoAu2oAhO1qC6TmD1ADeWDx95QW0epS186MudRCdT7O2h5Ao8q
	 uqdlbfmnQ0vDxhd185jQPSyGbaEUeJ/uw62KekPiviNYTLWFOYMqgTP/S5Wjb+sT4Z
	 8Bb+9Fyv/CbPNWnDJCPQUEuZIxmBaIousgOWjTyVgMwnGeSSpiyAk4xCsTBJOeLkWU
	 FW7ckznyZq4Sw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 15/22] tty: vt: name, reflow and document enum vc_ctl_state
Date: Fri,  2 Feb 2024 07:56:01 +0100
Message-ID: <20240202065608.14019-16-jirislaby@kernel.org>
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

The enum for states is currently compact and undocumented. Put each
definition on a separate line and document them all using kernel-doc.

Document the same on the use sites.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 72 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 55 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 1c832d04c0dc..6d08290fdfdf 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2091,9 +2091,44 @@ static void restore_cur(struct vc_data *vc)
 	vc->vc_need_wrap = 0;
 }
 
-enum { ESnormal, ESesc, ESsquare, ESgetpars, ESfunckey,
-	EShash, ESsetG0, ESsetG1, ESpercent, EScsiignore, ESnonstd,
-	ESpalette, ESosc, ESapc, ESpm, ESdcs };
+/**
+ * enum vc_ctl_state - control characters state of a vt
+ *
+ * @ESnormal:		initial state, no control characters parsed
+ * @ESesc:		ESC parsed
+ * @ESsquare:		CSI parsed -- modifiers/parameters/ctrl chars expected
+ * @ESgetpars:		CSI parsed -- parameters/ctrl chars expected
+ * @ESfunckey:		CSI [ parsed
+ * @EShash:		ESC # parsed
+ * @ESsetG0:		ESC ( parsed
+ * @ESsetG1:		ESC ) parsed
+ * @ESpercent:		ESC % parsed
+ * @EScsiignore:	CSI [0x20-0x3f] parsed
+ * @ESnonstd:		OSC parsed
+ * @ESpalette:		OSC P parsed
+ * @ESosc:		OSC [0-9] parsed
+ * @ESapc:		ESC _ parsed
+ * @ESpm:		ESC ^ parsed
+ * @ESdcs:		ESC P parsed
+ */
+enum vc_ctl_state {
+	ESnormal,
+	ESesc,
+	ESsquare,
+	ESgetpars,
+	ESfunckey,
+	EShash,
+	ESsetG0,
+	ESsetG1,
+	ESpercent,
+	EScsiignore,
+	ESnonstd,
+	ESpalette,
+	ESosc,
+	ESapc,
+	ESpm,
+	ESdcs,
+};
 
 /* console_lock is held (except via vc_init()) */
 static void reset_terminal(struct vc_data *vc, int do_clear)
@@ -2527,10 +2562,10 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, u8 c)
 		return;
 
 	switch(vc->vc_state) {
-	case ESesc:
+	case ESesc:	/* ESC */
 		handle_esc(tty, vc, c);
 		return;
-	case ESnonstd:
+	case ESnonstd:	/* ESC ] aka OSC */
 		if (c=='P') {   /* palette escape sequence */
 			for (vc->vc_npar = 0; vc->vc_npar < NPAR; vc->vc_npar++)
 				vc->vc_par[vc->vc_npar] = 0;
@@ -2545,7 +2580,7 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, u8 c)
 		else
 			vc->vc_state = ESnormal;
 		return;
-	case ESpalette:
+	case ESpalette:	/* ESC ] P aka OSC P */
 		if (isxdigit(c)) {
 			vc->vc_par[vc->vc_npar++] = hex_to_bin(c);
 			if (vc->vc_npar == 7) {
@@ -2562,7 +2597,7 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, u8 c)
 		} else
 			vc->vc_state = ESnormal;
 		return;
-	case ESsquare:
+	case ESsquare:	/* ESC [ aka CSI, parameters or modifiers expected */
 		for (vc->vc_npar = 0; vc->vc_npar < NPAR; vc->vc_npar++)
 			vc->vc_par[vc->vc_npar] = 0;
 		vc->vc_npar = 0;
@@ -2587,7 +2622,7 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, u8 c)
 		}
 		vc->vc_priv = EPecma;
 		fallthrough;
-	case ESgetpars:
+	case ESgetpars: /* ESC [ aka CSI, parameters expected */
 		if (c == ';' && vc->vc_npar < NPAR - 1) {
 			vc->vc_npar++;
 			return;
@@ -2600,6 +2635,9 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, u8 c)
 			vc->vc_state = EScsiignore;
 			return;
 		}
+
+		/* parameters done, handle the control char @c */
+
 		vc->vc_state = ESnormal;
 
 		switch (vc->vc_priv) {
@@ -2617,7 +2655,7 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, u8 c)
 			return;
 		vc->vc_state = ESnormal;
 		return;
-	case ESpercent:
+	case ESpercent:	/* ESC % */
 		vc->vc_state = ESnormal;
 		switch (c) {
 		case '@':  /* defined in ISO 2022 */
@@ -2629,10 +2667,10 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, u8 c)
 			return;
 		}
 		return;
-	case ESfunckey:
+	case ESfunckey:	/* ESC [ [ aka CSI [ */
 		vc->vc_state = ESnormal;
 		return;
-	case EShash:
+	case EShash:	/* ESC # */
 		vc->vc_state = ESnormal;
 		if (c == '8') {
 			/* DEC screen alignment test. kludge :-) */
@@ -2644,21 +2682,21 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, u8 c)
 			do_update_region(vc, vc->vc_origin, vc->vc_screenbuf_size / 2);
 		}
 		return;
-	case ESsetG0:
+	case ESsetG0:	/* ESC ( */
 		vc_setGx(vc, 0, c);
 		vc->vc_state = ESnormal;
 		return;
-	case ESsetG1:
+	case ESsetG1:	/* ESC ) */
 		vc_setGx(vc, 1, c);
 		vc->vc_state = ESnormal;
 		return;
-	case ESapc:
+	case ESapc:	/* ESC _ */
 		return;
-	case ESosc:
+	case ESosc:	/* ESC ] [0-9] aka OSC [0-9] */
 		return;
-	case ESpm:
+	case ESpm:	/* ESC ^ */
 		return;
-	case ESdcs:
+	case ESdcs:	/* ESC P */
 		return;
 	default:
 		vc->vc_state = ESnormal;
-- 
2.43.0


