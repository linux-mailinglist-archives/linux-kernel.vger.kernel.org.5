Return-Path: <linux-kernel+bounces-29822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F39831414
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBC711F222C6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDB72E84A;
	Thu, 18 Jan 2024 07:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aO86wFPu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D7A2E83E;
	Thu, 18 Jan 2024 07:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705564761; cv=none; b=Z3T5rHlQv3qLSiBvo7URsTUJTi+SLvCZumHV1YSM/LBcmiRjsCiNkBoc0RF/tqYE+2qfgFftqd8Lrb+Q3tJWAeSAGQZ3FioED1RaA6yPpPlHYELxjZKmGL4/GvMSQZUHDtlom1FurTLuRj56H5xP8eLGzV1V0Fu3bKle5CYIqq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705564761; c=relaxed/simple;
	bh=Im8qOCVaj+4w2v1mizWr2yWT3oRa0+WvQVJnYj7lSCk=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=MkwuoaIbMNC6NjWxr3Od6+23Pz84yvmcHiTMEe9LTJZnG3b1HufAjeraPLyfwmKbo4RQJdCOw53tzF/dl0qOCpcLL8cCc5s/65jv7HuxL/9CaRddDidWGYJvApqFrbtlWRg5vylsPNVUefUV9gnt9ept6bhHUbz/0EAMO0dZBc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aO86wFPu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC2EC43390;
	Thu, 18 Jan 2024 07:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705564760;
	bh=Im8qOCVaj+4w2v1mizWr2yWT3oRa0+WvQVJnYj7lSCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aO86wFPuU7xm+mwlp1yIceaoXtHHKEu5EHeM6NBsV8s1KhFQbtH/hVlTMhHU/e4rm
	 M29VfvbYs/tvDnTBQn1+T5RJu2fnX5UlSR0IzX0UnWItZNluI0nl1mi3QqVd6iQGrX
	 iGSFFwaY5gjSxP9q/+MsBvmSEKiIvrmxezqUk9dmkS4vylIWL90dS55IyO+1oF4sjQ
	 L6aa++wDmsiB+fKeQAWxFFBV75OsdPP7ktL0oZubljkFgLoHwWw7GtGgIr405z524m
	 uEGAHbeR3I4fgjDtXCPyjamZnuzTaj6mqeAO/73YBXgNnU6IqSJLifcx/elfKsoEZT
	 1C/fqcdr/T+sQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-parisc@vger.kernel.org
Subject: [PATCH 35/45] tty: vt: make consw::con_font_default()'s name const
Date: Thu, 18 Jan 2024 08:57:46 +0100
Message-ID: <20240118075756.10541-36-jirislaby@kernel.org>
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

It's a name after all and that is not supposed to be changed. So make it
const to make this obvious.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-parisc@vger.kernel.org
---
 drivers/video/console/newport_con.c | 3 ++-
 drivers/video/console/sticon.c      | 3 ++-
 drivers/video/fbdev/core/fbcon.c    | 3 ++-
 include/linux/console.h             | 2 +-
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index 4203bd5fd0a1..a51cfc1d560e 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -564,7 +564,8 @@ static int newport_set_def_font(int unit, struct console_font *op)
 	return 0;
 }
 
-static int newport_font_default(struct vc_data *vc, struct console_font *op, char *name)
+static int newport_font_default(struct vc_data *vc, struct console_font *op,
+				const char *name)
 {
 	return newport_set_def_font(vc->vc_num, op);
 }
diff --git a/drivers/video/console/sticon.c b/drivers/video/console/sticon.c
index 710201fb8ce4..4c7b4959a1aa 100644
--- a/drivers/video/console/sticon.c
+++ b/drivers/video/console/sticon.c
@@ -246,7 +246,8 @@ static int sticon_set_font(struct vc_data *vc, const struct console_font *op,
 	return 0;
 }
 
-static int sticon_font_default(struct vc_data *vc, struct console_font *op, char *name)
+static int sticon_font_default(struct vc_data *vc, struct console_font *op,
+			       const char *name)
 {
 	sticon_set_def_font(vc->vc_num);
 
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 62474630c4d4..657160eec0a5 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2533,7 +2533,8 @@ static int fbcon_set_font(struct vc_data *vc, const struct console_font *font,
 	return fbcon_do_set_font(vc, font->width, font->height, charcount, new_data, 1);
 }
 
-static int fbcon_set_def_font(struct vc_data *vc, struct console_font *font, char *name)
+static int fbcon_set_def_font(struct vc_data *vc, struct console_font *font,
+			      const char *name)
 {
 	struct fb_info *info = fbcon_info_from_console(vc->vc_num);
 	const struct font_desc *f;
diff --git a/include/linux/console.h b/include/linux/console.h
index a500caadbad0..543de22a3f23 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -89,7 +89,7 @@ struct consw {
 	int	(*con_font_get)(struct vc_data *vc, struct console_font *font,
 			unsigned int vpitch);
 	int	(*con_font_default)(struct vc_data *vc,
-			struct console_font *font, char *name);
+			struct console_font *font, const char *name);
 	int     (*con_resize)(struct vc_data *vc, unsigned int width,
 			      unsigned int height, bool from_user);
 	void	(*con_set_palette)(struct vc_data *vc,
-- 
2.43.0


