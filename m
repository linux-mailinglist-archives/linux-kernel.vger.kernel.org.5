Return-Path: <linux-kernel+bounces-81785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0295C867A16
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 346A11C21AC9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EE112BF03;
	Mon, 26 Feb 2024 15:21:38 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D33A128368
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 15:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708960897; cv=none; b=f45cIzuLETPsOCr+gkirWNPbFY/Tbmriyi36Q6915WP8cslvjxq9KXpZGT0Gv09juo1MTBSFsp4RU9mJKlOk8YMogJ4z8LiBHZwiu5Pl5Q4VfYcY51zOJYznCu0YfRBMeDUd6PCcLlhpD1k29ORfcRu16HHRlduUeACRxzpPduQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708960897; c=relaxed/simple;
	bh=y3ktYAlWGlGh0UnsX6kzOaJ18fiNnqB5N6XWTMa6ZYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q+oRc58eBSP1I0qpqC665Mtkc7o8YKUmRVY92oF5/SEz/YDFR3OC4ujmba6MzsuCv4nyAbcvt+8kNXJdL5Wzc5moYNnYeIm4dcA44f9jL4FKevW0dl2gj9lp5OQCqlsaAFbSaYWqzdF0x32Ku3yQLvINvWEaqy2qHYxEP00M704=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-hUFdyclRNYa7u9Dzspq9HQ-1; Mon, 26 Feb 2024 10:21:27 -0500
X-MC-Unique: hUFdyclRNYa7u9Dzspq9HQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AC846185A781;
	Mon, 26 Feb 2024 15:21:26 +0000 (UTC)
Received: from gentoo.redhat.com (unknown [10.45.224.64])
	by smtp.corp.redhat.com (Postfix) with ESMTP id ED5D3492BE2;
	Mon, 26 Feb 2024 15:21:25 +0000 (UTC)
From: Alexey Gladkov <legion@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-api@vger.kernel.org
Subject: [RFC PATCH v2 5/5] fbcon: Allow to get max font width and height
Date: Mon, 26 Feb 2024 16:21:14 +0100
Message-ID: <ab4ce129aef39b81cd27f10d49142a1c64f87a37.1708960303.git.legion@kernel.org>
In-Reply-To: <cover.1708960303.git.legion@kernel.org>
References: <cover.1708011391.git.legion@kernel.org> <cover.1708960303.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 drivers/video/fbdev/core/fbcon.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 1183e7a871f8..055d0d01243c 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -101,6 +101,9 @@ enum {
 	FBCON_LOGO_DONTSHOW	= -3	/* do not show the logo */
 };
 
+#define FBCON_MAX_FONT_WIDTH 32
+#define FBCON_MAX_FONT_HEIGHT 32
+
 static struct fbcon_display fb_display[MAX_NR_CONSOLES];
 
 static struct fb_info *fbcon_registered_fb[FB_MAX];
@@ -2458,6 +2461,21 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	return ret;
 }
 
+
+static int fbcon_font_info(struct vc_data *vc, struct console_font_info *info)
+{
+	info->min_width = 0;
+	info->min_height = 0;
+
+	info->max_width = FBCON_MAX_FONT_WIDTH;
+	info->max_height = FBCON_MAX_FONT_HEIGHT;
+
+	info->flags = KD_FONT_INFO_FLAG_LOW_SIZE | KD_FONT_INFO_FLAG_HIGH_SIZE;
+
+	return 0;
+}
+
+
 /*
  *  User asked to set font; we are guaranteed that charcount does not exceed 512
  *  but lets not assume that, since charcount of 512 is small for unicode support.
@@ -2485,7 +2503,8 @@ static int fbcon_set_font(struct vc_data *vc, struct console_font *font,
 	    h > FBCON_SWAP(info->var.rotate, info->var.yres, info->var.xres))
 		return -EINVAL;
 
-	if (font->width > 32 || font->height > 32)
+	if (font->width > FBCON_MAX_FONT_WIDTH ||
+	    font->height > FBCON_MAX_FONT_HEIGHT)
 		return -EINVAL;
 
 	/* Make sure drawing engine can handle the font */
@@ -3160,6 +3179,7 @@ static const struct consw fb_con = {
 	.con_scroll 		= fbcon_scroll,
 	.con_switch 		= fbcon_switch,
 	.con_blank 		= fbcon_blank,
+	.con_font_info 		= fbcon_font_info,
 	.con_font_set 		= fbcon_set_font,
 	.con_font_get 		= fbcon_get_font,
 	.con_font_default	= fbcon_set_def_font,
-- 
2.44.0


