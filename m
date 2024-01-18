Return-Path: <linux-kernel+bounces-29826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B82383141E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ECAE1C21B19
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCEE328AD;
	Thu, 18 Jan 2024 07:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ra20Y7g1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55BE321B5;
	Thu, 18 Jan 2024 07:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705564769; cv=none; b=ZYqA7syIhf2HHvSTAGMMx/fkqPjmLpo63QZ8dwXFd+UZT0GEM5p0Knxmcs73eYn9+CdvC53oTUljHHk/WKpzSLjXaGbASdsWrdKOdXHbikWM9fk1/Nh9y/MkmQVmieMjoIyGGWLXr3UdL2S3eR8h98xQNKcKWjFwlhvaA22eEBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705564769; c=relaxed/simple;
	bh=23taMT4+1oTMyrJp90CFddN2xRCEJnbtzQNugverJ2M=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=fQQttoa5hRz/LEpkeX5bRr4565+YnCMgb2kZf4xjtQUWsk0BxXRejJXg8jrNicSsYOVtmtybT82bAGXBwdNqt4Qlenh7m9t8iFDhIQAXZtFL/rtS763RR4Q2cTxYIvttSz2bYZ7mR+BuKws6izSfE4AMqJ0kxAiny5Q8ZLA66Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ra20Y7g1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E277C43399;
	Thu, 18 Jan 2024 07:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705564768;
	bh=23taMT4+1oTMyrJp90CFddN2xRCEJnbtzQNugverJ2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ra20Y7g1Ek/3qxHoB4wK4zo3QN6kt/TguuwGOdD4HwCUyqqTYYRpZQLBvDM5oxdf6
	 vvpxLzFbl9hFdFq+0LtiOCtgFX5nyhQdSxTz7fc1Qawk4WKS+tTt4Vdv1xr8xJzF3c
	 ZZ9w8zsdrLR1ArEajGYzkA91zf2YNAz7A9H2uSfW6zNDzQuXmuBzCefxOb7GRwjILi
	 e3kYzfrymTH92VQAToNCT5piNyqTNTexGXC90gvUN15iQ9i5fcKuOr/1PjBz5QxMuM
	 3C9aEIqjb93pA4xj5kID/Z7jdS7d+o15zVyP3KUsPxBbJbRgsitfCMfZ423pPTEO1n
	 KW+RnYXUCxlmQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 39/45] tty: vt: make types of screenpos() more consistent
Date: Thu, 18 Jan 2024 08:57:50 +0100
Message-ID: <20240118075756.10541-40-jirislaby@kernel.org>
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

* parameter offset: it is expected to be non-negative, so switch to
  unsigned
* return type: switch from ushort to explicit u16. This is expected on
  most places. And fix the remaining two places too.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index b41ecf3a5fc7..69d85a030ebc 100644
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


