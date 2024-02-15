Return-Path: <linux-kernel+bounces-67213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBE4856829
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFA20B238CB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03068135405;
	Thu, 15 Feb 2024 15:37:56 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EDD133417
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 15:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708011475; cv=none; b=QB238gR7XWcMp5Dh8gXGmMJI6pSLPs92jwz+vQd6LOHc+PL4fvcfEympTbR2jELujCgK1NNZJMEP1EO3Ck8LUf5Ybqdd/tTK1WiOYv2guW9QXKEr7vTh/SEvBHpFZ/uh25iHQPZGCfbqzoTwUZ4zGwZFNHInrxQOGAU1s3Ct5mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708011475; c=relaxed/simple;
	bh=PzRCrAYZ3bmmaS2SVBTn1kR7ocsfUIv45eipG7Xx1Iw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MBCYIM1zJf395pYF5l0KAWs4RVi3N/+HmyUz9fHp6yZgRcm9bFK6LSXnlKzum5a2AfmQupTAlyGmxK7rI/TQQkRxgcYcQh/FK5yLVw4IXiHQFL3hYJDhlg5ya8hYOesgWRAYyjQGCzdQqXoiWX7VBrCqvPGV1oXaHTb/4XDDzxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-MvIx3WUINFKvlgf5QeaYgQ-1; Thu, 15 Feb 2024 10:37:45 -0500
X-MC-Unique: MvIx3WUINFKvlgf5QeaYgQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A5320185A782;
	Thu, 15 Feb 2024 15:37:45 +0000 (UTC)
Received: from gentoo.redhat.com (unknown [10.45.226.49])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0FDDC112132A;
	Thu, 15 Feb 2024 15:37:44 +0000 (UTC)
From: Alexey Gladkov <legion@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [RFC PATCH v1 4/5] vgacon: Allow to get max font width and height
Date: Thu, 15 Feb 2024 15:37:23 +0000
Message-ID: <b73164a958e9c8749ff1bc0902eb8453fcd30dd8.1708011391.git.legion@kernel.org>
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
 drivers/video/console/vgacon.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 8ef1579fa57f..a499a469df4d 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -61,6 +61,10 @@ static struct vgastate vgastate;
 #define BLANK 0x0020
 
 #define VGA_FONTWIDTH       8   /* VGA does not support fontwidths != 8 */
+
+#define VGACON_MAX_FONT_WIDTH VGA_FONTWIDTH
+#define VGACON_MAX_FONT_HEIGHT 32
+
 /*
  *  Interface used by the world
  */
@@ -1013,6 +1017,15 @@ static int vgacon_adjust_height(struct vc_data *vc, unsigned fontheight)
 	return 0;
 }
 
+static int vgacon_font_info(struct vc_data *vc, struct console_font *font)
+{
+	font->width = VGACON_MAX_FONT_WIDTH;
+	font->height = VGACON_MAX_FONT_HEIGHT;
+	font->charcount = 512;
+
+	return 0;
+}
+
 static int vgacon_font_set(struct vc_data *c, struct console_font *font,
 			   unsigned int vpitch, unsigned int flags)
 {
@@ -1022,7 +1035,8 @@ static int vgacon_font_set(struct vc_data *c, struct console_font *font,
 	if (vga_video_type < VIDEO_TYPE_EGAM)
 		return -EINVAL;
 
-	if (font->width != VGA_FONTWIDTH || font->height > 32 || vpitch != 32 ||
+	if (font->width != VGACON_MAX_FONT_WIDTH ||
+	    font->height > VGACON_MAX_FONT_HEIGHT || vpitch != 32 ||
 	    (charcount != 256 && charcount != 512))
 		return -EINVAL;
 
@@ -1177,6 +1191,7 @@ const struct consw vga_con = {
 	.con_scroll = vgacon_scroll,
 	.con_switch = vgacon_switch,
 	.con_blank = vgacon_blank,
+	.con_font_info = vgacon_font_info,
 	.con_font_set = vgacon_font_set,
 	.con_font_get = vgacon_font_get,
 	.con_resize = vgacon_resize,
-- 
2.43.0


