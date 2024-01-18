Return-Path: <linux-kernel+bounces-29799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C58AC8313C5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CC8E2847EC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD0224B36;
	Thu, 18 Jan 2024 07:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DH/8RpQ6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EDC2575C;
	Thu, 18 Jan 2024 07:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705564706; cv=none; b=PxMzHGTDraHOxoO/aT98VIGzppZLS0kLj8X76yidIBCCrflUw+H3etXz8hYYa+LKDfzmsbWdSqvy93JwuBiZC4x/TcGtZ/fD5oKQXCN1rIOWBBc6FXEVpKDD7VryuX/9B6U6nZnkVTnFrOuhdBPRlh86s3LbjltuC2u85UJY/1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705564706; c=relaxed/simple;
	bh=QRYobT/Ntnc2Q+TR1Sf0nMM7PfTjMjX2jtpPvm5til4=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=WV5iQu5SfyXaYKEIj4fhTz+5Jsv7+GPsrgXauEtsMX5sYFM3wVba5yh3VRGIDZJiviLcpcG/a3IcU69IWfhfx7ZfY9om2uMTHtEF0HnYpNm6itFJ6l0vMflZkY+5yTHORieiJiJ42ywc1JSsu98LACu6Ok0PjlYPHBkDhpJZBxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DH/8RpQ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD15C433F1;
	Thu, 18 Jan 2024 07:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705564705;
	bh=QRYobT/Ntnc2Q+TR1Sf0nMM7PfTjMjX2jtpPvm5til4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DH/8RpQ6P0bni7Ix6C1TZiX9PgzPgAEm5EGhjBJMYmAEfnEUUotzqq3BuXc6vRvSZ
	 8Jlu5hG5+gvnJ57EkVddMW/UprITM1++eFvATQ2MpKU02LB/LyWf7uSmZwOUaMQ0Tf
	 3IDRogfHAHUr8sB7jR3wdlPmFyspdwIwN/oM4VEz6du1oHKwQnyz8QMkSN6DprcmzA
	 sWuSuNga1Qy2BI/TOOKmh92OAvZkde4XiTTEvs2r0d4EvLr1T57GV4PNEcu/+1Vl6T
	 dgKfyKqTXrEDYEevmf8CFAdWj7yRfvakDEHLJtZpeFsPIKQleDjZWR+teKsH0QRtbm
	 gpYgiMv7a/fWw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 12/45] tty: vt: reflow csi_J()
Date: Thu, 18 Jan 2024 08:57:23 +0100
Message-ID: <20240118075756.10541-13-jirislaby@kernel.org>
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

Push cases one level left, according to coding style. And reorder local
variables.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 50 ++++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 4f7831f81db6..22ef7366c155 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1507,34 +1507,34 @@ enum {
 
 static void csi_J(struct vc_data *vc, int vpar)
 {
+	unsigned short *start;
 	unsigned int count;
-	unsigned short * start;
 
 	switch (vpar) {
-		case CSI_J_CURSOR_TO_END:
-			vc_uniscr_clear_line(vc, vc->state.x,
-					     vc->vc_cols - vc->state.x);
-			vc_uniscr_clear_lines(vc, vc->state.y + 1,
-					      vc->vc_rows - vc->state.y - 1);
-			count = (vc->vc_scr_end - vc->vc_pos) >> 1;
-			start = (unsigned short *)vc->vc_pos;
-			break;
-		case CSI_J_START_TO_CURSOR:
-			vc_uniscr_clear_line(vc, 0, vc->state.x + 1);
-			vc_uniscr_clear_lines(vc, 0, vc->state.y);
-			count = ((vc->vc_pos - vc->vc_origin) >> 1) + 1;
-			start = (unsigned short *)vc->vc_origin;
-			break;
-		case CSI_J_FULL:
-			flush_scrollback(vc);
-			fallthrough;
-		case CSI_J_VISIBLE:
-			vc_uniscr_clear_lines(vc, 0, vc->vc_rows);
-			count = vc->vc_cols * vc->vc_rows;
-			start = (unsigned short *)vc->vc_origin;
-			break;
-		default:
-			return;
+	case CSI_J_CURSOR_TO_END:
+		vc_uniscr_clear_line(vc, vc->state.x,
+				     vc->vc_cols - vc->state.x);
+		vc_uniscr_clear_lines(vc, vc->state.y + 1,
+				      vc->vc_rows - vc->state.y - 1);
+		count = (vc->vc_scr_end - vc->vc_pos) >> 1;
+		start = (unsigned short *)vc->vc_pos;
+		break;
+	case CSI_J_START_TO_CURSOR:
+		vc_uniscr_clear_line(vc, 0, vc->state.x + 1);
+		vc_uniscr_clear_lines(vc, 0, vc->state.y);
+		count = ((vc->vc_pos - vc->vc_origin) >> 1) + 1;
+		start = (unsigned short *)vc->vc_origin;
+		break;
+	case CSI_J_FULL:
+		flush_scrollback(vc);
+		fallthrough;
+	case CSI_J_VISIBLE:
+		vc_uniscr_clear_lines(vc, 0, vc->vc_rows);
+		count = vc->vc_cols * vc->vc_rows;
+		start = (unsigned short *)vc->vc_origin;
+		break;
+	default:
+		return;
 	}
 	scr_memsetw(start, vc->vc_video_erase_char, 2 * count);
 	if (con_should_update(vc))
-- 
2.43.0


