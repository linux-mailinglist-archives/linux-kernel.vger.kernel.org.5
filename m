Return-Path: <linux-kernel+bounces-32854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3018360F8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBF2628BB61
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F924481AD;
	Mon, 22 Jan 2024 11:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFjOtUAx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7728447F7B;
	Mon, 22 Jan 2024 11:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921532; cv=none; b=qH9qET9udFGZXNGjfReWVBIRUTTGJ7rLXiMMz3sFV1qS4BopJ0PXMI5VaIIkQa/BE5S+uPd0s9qLeW+Vf8kttAzuaOVIwv2+H5hKlRjw1N1R/n9X0dWCJtCfGc2mLma380dfSBoI8PP2+m+xL408oF5jZV9eojhiSbCsZC0Ta+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921532; c=relaxed/simple;
	bh=zD5yC++Deas+2dKKgpnZzRCfsxfjAnWJ+terllmOKSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o9yy7gjhn14JhdBrqett3NNWuTRkMn8K0BHbLiLZs1+qXBSaOoqnr+QDNoRk2ZFAq1glXV9ra3B+FdXjMcMZnDTgAym3cFNIRqS3Xmn7ut9uL8+lnGYeS7nm0ny4NshNgKK0JwblwQO1gv84G2gO+ZSVZ1y27ZiD/j89GuEYRsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFjOtUAx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00A4C43390;
	Mon, 22 Jan 2024 11:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705921532;
	bh=zD5yC++Deas+2dKKgpnZzRCfsxfjAnWJ+terllmOKSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JFjOtUAxR1QkTNVJT/4qIzZ38cHJO1PPb6obE2SJrwvoM8I17+xK3G93dmNrzuAJB
	 CDtCR0NEyuqgT5OquAmzN0gSoyAuv8k/ollCGPoioOlQ+UCFnK0UKFVfQoWBt4Pzir
	 EfBbeNGnqiTDAynRnDEha572xnTi/8L9SPyzkxuwDrIw46tpccUXPTux29JhFfvBEz
	 W5+d6GNoP56stDH6EG5Sg5CLvC5n3ORhCoP9boh8mILvphh2pFiRY+c4izgWZQYVbO
	 ZE32ZXsgQdgjCSS08TWdYgPaIT8+bUTkfqxPa+sY/Ie5gr5zn46H4c3ujqJR7zMjvG
	 AFn3M49lFoXyQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 41/47] tty: vt: make types of screenpos() more consistent
Date: Mon, 22 Jan 2024 12:03:55 +0100
Message-ID: <20240122110401.7289-42-jirislaby@kernel.org>
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

* parameter offset: it is expected to be non-negative, so switch to
  unsigned
* return type: switch from ushort to explicit u16. This is expected on
  most places. And fix the remaining two places too.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 4e9d689143e0..f6fa76c0eb5b 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -286,12 +286,12 @@ static inline bool con_should_update(const struct vc_data *vc)
 	return con_is_visible(vc) && !console_blanked;
 }
 
-static inline unsigned short *screenpos(const struct vc_data *vc, int offset,
-		bool viewed)
+static inline u16 *screenpos(const struct vc_data *vc, unsigned int offset,
+			     bool viewed)
 {
 	unsigned long origin = viewed ? vc->vc_visible_origin : vc->vc_origin;
 
-	return (unsigned short *)(origin + offset);
+	return (u16 *)(origin + offset);
 }
 
 static void con_putc(struct vc_data *vc, u16 ca, unsigned int y, unsigned int x)
@@ -705,7 +705,7 @@ static void update_attr(struct vc_data *vc)
 /* Note: inverting the screen twice should revert to the original state */
 void invert_screen(struct vc_data *vc, int offset, int count, bool viewed)
 {
-	unsigned short *p;
+	u16 *p;
 
 	WARN_CONSOLE_UNLOCKED();
 
@@ -773,8 +773,7 @@ void complement_pos(struct vc_data *vc, int offset)
 	if (offset != -1 && offset >= 0 &&
 	    offset < vc->vc_screenbuf_size) {
 		unsigned short new;
-		unsigned short *p;
-		p = screenpos(vc, offset, true);
+		u16 *p = screenpos(vc, offset, true);
 		old = scr_readw(p);
 		new = old ^ vc->vc_complement_mask;
 		scr_writew(new, p);
-- 
2.43.0


