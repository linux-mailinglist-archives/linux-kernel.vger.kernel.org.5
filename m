Return-Path: <linux-kernel+bounces-32820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F25438360B6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C18CB2C299
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB263D3BE;
	Mon, 22 Jan 2024 11:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZnToi4H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D5A3D3A8;
	Mon, 22 Jan 2024 11:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921467; cv=none; b=u986BUkjPszcmTLPf6sCRA80VywHCySolk51mEHUFO2b0LZq51WKtFchiGFeD9Z9dOFBQAZjX/O9CyvL0U4RSiFZ+FX4J6mTN9TCFKAyMfruj5RUB8sGBYfrq7efLiVJWhoHqo/WrBbyFETTZkR+xumCsz3biaVm/+EedBu1Xts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921467; c=relaxed/simple;
	bh=TBBlxYWmexNLrfwekstgpyN0s4/BkIknxdIp9jt04/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKVNqDPxProlQS8gmjio5SqG4x+lsKt7A6DQrx+kMXGu7HEfCxD785aLpK3xADjRxRFHrUqBbCNkweZnNcazZUJaJJF3Y5KPYNY7TRDf/N/WkDAWbfnQBElPW77VRtDyn45tSv+Ftm2chFLTIKfD+tIv1CS6IYvGzgF3R9vvt9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZnToi4H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84F0C433B1;
	Mon, 22 Jan 2024 11:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705921467;
	bh=TBBlxYWmexNLrfwekstgpyN0s4/BkIknxdIp9jt04/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iZnToi4HRKSwbuTjeHmOnUHyYG4Z9pOh5cUKM4dp44RahMOfwtxR9cl7Yu3x2xP1t
	 Cgi1/xrFkLeeGH+stRKHWrpZRPQW4KuMgl221Km4gtno/6ZmOtbadPcjE4Y9N027DT
	 0N3jy6u1DRmChsPawvgEpunuDp4emSnj6vdzVCWT0eVXGPZrvyHT5ZsiSAVgMYjBQb
	 ricXm65S5vOfMTtjPJA9aMor6J5d57yxxGA91f6y/pwMsNNzHQ3ir2W3Vif3klnJWM
	 x05OpbiD+SYfzT7k3r6mLe0JDuYfRKAfAHuxDbbxvhOZcUgbagd1XTctRddGR54PEi
	 2l37z2nx1LIQw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 11/47] tty: vt: define an enum for CSI+J codes
Date: Mon, 22 Jan 2024 12:03:25 +0100
Message-ID: <20240122110401.7289-12-jirislaby@kernel.org>
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

Decrypt the constant values by proper enum names. This time in csi_J().

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---

Notes:
    [v2] use the new names also in csi_J() callers and the enum as the param
         type

 drivers/tty/vt/vt.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 66ebc90a9fe9..85e89fb9b207 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1498,13 +1498,20 @@ static inline void del(struct vc_data *vc)
 	/* ignored */
 }
 
-static void csi_J(struct vc_data *vc, int vpar)
+enum CSI_J {
+	CSI_J_CURSOR_TO_END	= 0,
+	CSI_J_START_TO_CURSOR	= 1,
+	CSI_J_VISIBLE		= 2,
+	CSI_J_FULL		= 3,
+};
+
+static void csi_J(struct vc_data *vc, enum CSI_J vpar)
 {
 	unsigned int count;
 	unsigned short * start;
 
 	switch (vpar) {
-		case 0:	/* erase from cursor to end of display */
+		case CSI_J_CURSOR_TO_END:
 			vc_uniscr_clear_line(vc, vc->state.x,
 					     vc->vc_cols - vc->state.x);
 			vc_uniscr_clear_lines(vc, vc->state.y + 1,
@@ -1512,16 +1519,16 @@ static void csi_J(struct vc_data *vc, int vpar)
 			count = (vc->vc_scr_end - vc->vc_pos) >> 1;
 			start = (unsigned short *)vc->vc_pos;
 			break;
-		case 1:	/* erase from start to cursor */
+		case CSI_J_START_TO_CURSOR:
 			vc_uniscr_clear_line(vc, 0, vc->state.x + 1);
 			vc_uniscr_clear_lines(vc, 0, vc->state.y);
 			count = ((vc->vc_pos - vc->vc_origin) >> 1) + 1;
 			start = (unsigned short *)vc->vc_origin;
 			break;
-		case 3: /* include scrollback */
+		case CSI_J_FULL:
 			flush_scrollback(vc);
 			fallthrough;
-		case 2: /* erase whole display */
+		case CSI_J_VISIBLE:
 			vc_uniscr_clear_lines(vc, 0, vc->vc_rows);
 			count = vc->vc_cols * vc->vc_rows;
 			start = (unsigned short *)vc->vc_origin;
@@ -2110,7 +2117,7 @@ static void reset_terminal(struct vc_data *vc, int do_clear)
 	gotoxy(vc, 0, 0);
 	save_cur(vc);
 	if (do_clear)
-	    csi_J(vc, 2);
+	    csi_J(vc, CSI_J_VISIBLE);
 }
 
 static void vc_setGx(struct vc_data *vc, unsigned int which, int c)
@@ -2526,7 +2533,7 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 			/* DEC screen alignment test. kludge :-) */
 			vc->vc_video_erase_char =
 				(vc->vc_video_erase_char & 0xff00) | 'E';
-			csi_J(vc, 2);
+			csi_J(vc, CSI_J_VISIBLE);
 			vc->vc_video_erase_char =
 				(vc->vc_video_erase_char & 0xff00) | ' ';
 			do_update_region(vc, vc->vc_origin, vc->vc_screenbuf_size / 2);
@@ -3498,7 +3505,7 @@ static int __init con_init(void)
 	set_origin(vc);
 	save_screen(vc);
 	gotoxy(vc, vc->state.x, vc->state.y);
-	csi_J(vc, 0);
+	csi_J(vc, CSI_J_CURSOR_TO_END);
 	update_screen(vc);
 	pr_info("Console: %s %s %dx%d\n",
 		vc->vc_can_do_color ? "colour" : "mono",
-- 
2.43.0


