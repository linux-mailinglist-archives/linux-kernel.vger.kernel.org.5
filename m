Return-Path: <linux-kernel+bounces-29809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F128313E3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B97F91C22325
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5B32C84E;
	Thu, 18 Jan 2024 07:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="miPuuFj5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177CB2C6BF;
	Thu, 18 Jan 2024 07:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705564727; cv=none; b=aRaLoc5kGReqUF3Rf/IW4ZCgNPDb0Hu6N44CcEc7dXCeVof4/HSz/2zbJETqFXPlEqsr75wyre+cJndHcxW31gWdlodtCWjDNE2dokgQ0If5KgvAmr3x+MPaCvNPVHxGh6P9N3kqCaQXXf0HkrNOhQHFRafa/+5VK12cwOjOxqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705564727; c=relaxed/simple;
	bh=YRzFj4BN6f8YNzJ8WuOrgNl97sICo/Ly8ow9YGu8iDo=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=ENUzimpuHQNewtPjtDhCdRK7zeGvPPtNvuLjEvHBPPDMCUH3lGiReZG/dmcKZv2VtRIDBpBeIY/CxLloXRJqix2hgiUSK/zFDl7Yx1IkTzeQrrhL9svoWclEqbs2YhgKglM2WpzSPm8CcU5WahakQdP/+QQeLLvqGwuyJdT5gAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=miPuuFj5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DBACC433F1;
	Thu, 18 Jan 2024 07:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705564726;
	bh=YRzFj4BN6f8YNzJ8WuOrgNl97sICo/Ly8ow9YGu8iDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=miPuuFj5etJVAcz9yJUXZ4WE9Q52BwEXzyJTluO6MtFeXv7WULwc+Du2fVhcYNF4T
	 wDG8j944GJmjlV1PiFDf4gfbwkDoOEB9HnBwV8mZBTM4smbIlMdmkTIb4TUCHcLSyb
	 DxWSTnpXlxvIFQ9v8XW8bJTOyLCtsv2d8+B7wAojkwt8Ubk9PXUxjKZFE8Y6d0NIhr
	 RJGeljdzI0rUpvI1x4LxD7L7J8K5aHGRv4sgb8DmqbrTrXIjWDfiCd8TnkMeANnUow
	 ZTKmf+Sesp/tLL1GsA90sj/8he8+OryJ43lgjYmLtBQHoZIu5GTOGxeohGpb5Wo+6b
	 xcOBVUsd+g8MQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 22/45] tty: vt: add con_putc() helper
Date: Thu, 18 Jan 2024 08:57:33 +0100
Message-ID: <20240118075756.10541-23-jirislaby@kernel.org>
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

And let it call consw::con_putc() if it exists, otherwise
consw::con_putcs(). This is similar to tty_put_char().

It supports dropping unneeded duplication of code like sticon_putc() is
(see the next patch).

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index a4ee983824d5..73e48a53dc31 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -300,6 +300,14 @@ static inline unsigned short *screenpos(const struct vc_data *vc, int offset,
 	return p;
 }
 
+static void con_putc(struct vc_data *vc, u16 ca, unsigned int y, unsigned int x)
+{
+	if (vc->vc_sw->con_putc)
+		vc->vc_sw->con_putc(vc, ca, y, x);
+	else
+		vc->vc_sw->con_putcs(vc, &ca, 1, y, x);
+}
+
 /* Called  from the keyboard irq path.. */
 static inline void scrolldelta(int lines)
 {
@@ -762,7 +770,7 @@ void complement_pos(struct vc_data *vc, int offset)
 	    old_offset < vc->vc_screenbuf_size) {
 		scr_writew(old, screenpos(vc, old_offset, true));
 		if (con_should_update(vc))
-			vc->vc_sw->con_putc(vc, old, oldy, oldx);
+			con_putc(vc, old, oldy, oldx);
 		notify_update(vc);
 	}
 
@@ -779,7 +787,7 @@ void complement_pos(struct vc_data *vc, int offset)
 		if (con_should_update(vc)) {
 			oldx = (offset >> 1) % vc->vc_cols;
 			oldy = (offset >> 1) / vc->vc_cols;
-			vc->vc_sw->con_putc(vc, new, oldy, oldx);
+			con_putc(vc, new, oldy, oldx);
 		}
 		notify_update(vc);
 	}
@@ -833,7 +841,7 @@ static void add_softcursor(struct vc_data *vc)
 		i ^= CUR_FG;
 	scr_writew(i, (u16 *)vc->vc_pos);
 	if (con_should_update(vc))
-		vc->vc_sw->con_putc(vc, i, vc->state.y, vc->state.x);
+		con_putc(vc, i, vc->state.y, vc->state.x);
 }
 
 static void hide_softcursor(struct vc_data *vc)
@@ -841,8 +849,8 @@ static void hide_softcursor(struct vc_data *vc)
 	if (softcursor_original != -1) {
 		scr_writew(softcursor_original, (u16 *)vc->vc_pos);
 		if (con_should_update(vc))
-			vc->vc_sw->con_putc(vc, softcursor_original,
-					vc->state.y, vc->state.x);
+			con_putc(vc, softcursor_original, vc->state.y,
+				 vc->state.x);
 		softcursor_original = -1;
 	}
 }
-- 
2.43.0


