Return-Path: <linux-kernel+bounces-67214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBC985680F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 533D31F2F1FB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBBB135A40;
	Thu, 15 Feb 2024 15:37:56 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1534613475C
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 15:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708011476; cv=none; b=mCYPfTsVPeMMI5HFC6QaeS5yc5runQif998JVcjG2PeA/pcJr8UGO72mr/5i6BZU+fJZvXt3biAZslkBr3aZB6RDpRErACSLIJfqRbC+MyEH4dCDdW0pO+OecYet19olaRqjrvqWgfouheze4dzOOioWx6Dpwk18faCT2f9xIvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708011476; c=relaxed/simple;
	bh=bMbVIOzi1rK1lP2i91pr+ZkS3sDA0uZVi6JPvb+dw5U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W+NgVxk45NSdr8FKl2RgV2nSMoNgbr+3W/lzuNqcq0RodlLJr6gXuX8R7tllT+1geJmckuG6bYWdH9AdcmnxwAOVEvb0iH1UJvWEJEWxe9jTdsxfOQpU2ehLRG4Kwj2viWh7s9R6frbBKQ+8w014lWP9maMrCWCTlfrjsJOWpGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-LbA3p-fHOmqRYxhf3xAGfQ-1; Thu, 15 Feb 2024 10:37:45 -0500
X-MC-Unique: LbA3p-fHOmqRYxhf3xAGfQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CCF0F1025622;
	Thu, 15 Feb 2024 15:37:44 +0000 (UTC)
Received: from gentoo.redhat.com (unknown [10.45.226.49])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3792B112132A;
	Thu, 15 Feb 2024 15:37:44 +0000 (UTC)
From: Alexey Gladkov <legion@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [RFC PATCH v1 3/5] sticon: Allow to get max font width and height
Date: Thu, 15 Feb 2024 15:37:22 +0000
Message-ID: <0c724c30a36aefe2cb4470182cf868d256fbabcd.1708011391.git.legion@kernel.org>
In-Reply-To: <cover.1708011391.git.legion@kernel.org>
References: <cover.1708011391.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 drivers/video/console/sticon.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/video/console/sticon.c b/drivers/video/console/sticon.c
index 992a4fa431aa..63368b3ff9c5 100644
--- a/drivers/video/console/sticon.c
+++ b/drivers/video/console/sticon.c
@@ -56,6 +56,11 @@
 #define BLANK 0
 static int vga_is_gfx;
 
+#define STICON_MIN_FONT_WIDTH 6
+#define STICON_MIN_FONT_HEIGHT 6
+#define STICON_MAX_FONT_WIDTH 32
+#define STICON_MAX_FONT_HEIGHT 32
+
 #define STI_DEF_FONT	sticon_sti->font
 
 /* borrowed from fbcon.c */
@@ -180,8 +185,10 @@ static int sticon_set_font(struct vc_data *vc, struct console_font *op,
 	struct sti_cooked_font *cooked_font;
 	unsigned char *data = op->data, *p;
 
-	if ((w < 6) || (h < 6) || (w > 32) || (h > 32) || (vpitch != 32)
-	    || (op->charcount != 256 && op->charcount != 512))
+	if ((w < STICON_MIN_FONT_WIDTH) || (h < STICON_MIN_FONT_HEIGHT) ||
+	    (w > STICON_MAX_FONT_WIDTH) || (h > STICON_MAX_FONT_HEIGHT) ||
+	    (vpitch != 32) ||
+	    (op->charcount != 256 && op->charcount != 512))
 		return -EINVAL;
 	pitch = ALIGN(w, 8) / 8;
 	bpc = pitch * h;
@@ -273,6 +280,15 @@ static int sticon_font_set(struct vc_data *vc, struct console_font *font,
 	return sticon_set_font(vc, font, vpitch);
 }
 
+static int sticon_font_info(struct vc_data *vc, struct console_font *font)
+{
+	font->width = STICON_MAX_FONT_WIDTH;
+	font->height = STICON_MAX_FONT_HEIGHT;
+	font->charcount = 512;
+
+	return 0;
+}
+
 static void sticon_init(struct vc_data *c, int init)
 {
     struct sti_struct *sti = sticon_sti;
@@ -371,6 +387,7 @@ static const struct consw sti_con = {
 	.con_scroll		= sticon_scroll,
 	.con_switch		= sticon_switch,
 	.con_blank		= sticon_blank,
+	.con_font_info		= sticon_font_info,
 	.con_font_set		= sticon_font_set,
 	.con_font_default	= sticon_font_default,
 	.con_build_attr		= sticon_build_attr,
-- 
2.43.0


