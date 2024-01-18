Return-Path: <linux-kernel+bounces-29798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF2B8313C3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03D521F21C6B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B58F25602;
	Thu, 18 Jan 2024 07:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUcyj+aZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEE924B36;
	Thu, 18 Jan 2024 07:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705564703; cv=none; b=LqUx7IhPAA3/lcxSceqEKKZmTeT1aSuyf8Db6Cw+do9VxHCMJL9aYgxWgKYWAMqm0PsLtBvPP5wVVNSHMtmJPzjOeq565XhB5OdmikaUBw7xddxoJva0uX84/T0FFbD+IrPXXQMZigmvw9+RofZj7vXT19nkN3RbBgw1h5bj4n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705564703; c=relaxed/simple;
	bh=inEZdPNYb4mBWCDk6mN9TwUiu3T0fjhmaqQyXC/6bwA=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=q8i94Izr926xTBi+iYl956VX2tlCrpjkdqNxxaopJmFrOki8RBUHXe6+OtalKN348WDlcSLYZZk+WqYfPlwLWGBvaWPHU5Hdtip+ZL0LVyXhiV6i7AUD5YBm0QbU1KWPZtibTIXjC4+3JuUmYsvh24CSJuy+Hg2GFXy9rJ+tliI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUcyj+aZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66358C43399;
	Thu, 18 Jan 2024 07:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705564703;
	bh=inEZdPNYb4mBWCDk6mN9TwUiu3T0fjhmaqQyXC/6bwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RUcyj+aZugJbjQqqpmDfarOXYhfqXPPLZOTIKDk1c4kC4a09L67sHqpZHzUozJT7D
	 TY1LAcOSAe8aH8SkMyVhWLlvOpeGi79OqJkpKi+qKukDLoM0bpd+EbZ90YzeBvHjYJ
	 jB3Eitw65/6GfDO2PstZ+2WSYL5QfYx9UuCfEPxSJVdXXn872Z2PW4L3wE0TxlnHeS
	 ysFf7oiFDiuXJP4CPzB7FiWb1Xk0PCu/DbdaYdmTFyyAQh4tYb3V1fnatervM+VYJf
	 6THLq4fdSstdzhKqbILjZVBCrf9eorAv0eo3D1u09vR4qlKTgdk8xdQXRVJEKtQPdS
	 fFbwrqbQJyFNA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 11/45] tty: vt: define an enum for CSI+J codes
Date: Thu, 18 Jan 2024 08:57:22 +0100
Message-ID: <20240118075756.10541-12-jirislaby@kernel.org>
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

Decrypt the constant values by proper enum names. This time in csi_J().

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 66ebc90a9fe9..4f7831f81db6 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1498,13 +1498,20 @@ static inline void del(struct vc_data *vc)
 	/* ignored */
 }
 
+enum {
+	CSI_J_CURSOR_TO_END	= 0,
+	CSI_J_START_TO_CURSOR	= 1,
+	CSI_J_VISIBLE		= 2,
+	CSI_J_FULL		= 3,
+};
+
 static void csi_J(struct vc_data *vc, int vpar)
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
-- 
2.43.0


