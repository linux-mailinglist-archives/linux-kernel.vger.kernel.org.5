Return-Path: <linux-kernel+bounces-81788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7ACE867AF7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F0B8B262F6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8552F12C52D;
	Mon, 26 Feb 2024 15:22:39 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CA912C528
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 15:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708960959; cv=none; b=edr8QLnMiLRkfW1y4VR3SpScVH1lbfTCOafmMoGT9M30od4aW8/y7kQPRnM6DLWUwrN46XYX1DprHR0YJC3WGC7mZFcg4Xzya9oJRiDQHhep5vaV1qvZqV8GWH6f9qtCBx7nMzBD+EjxtnDYSwYdLzUGDU/i/5MRHUIk9DB0h6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708960959; c=relaxed/simple;
	bh=jJGWS4fls7FxdD0C7TzlrnH9rCl6Eia5MnOtRY3vNvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FdlwwKQwxyz6VtDgSjxNiUeTQuTFDK+YFba2RrBNTQMXnF/Xw7vQLvXZSQVH67rCaNaTlTdU+oGhp/C/9VCNe8AX1RHys53b1LSh3/m3UM1/k69+W34nIMhBZlJ/MlKL+HTOUdEJFg3CsBzLWrrA6wZahKAmYg785rz/rd+ka2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-A_t5tt-EMT2pGOjzsrEoTQ-1; Mon,
 26 Feb 2024 10:21:26 -0500
X-MC-Unique: A_t5tt-EMT2pGOjzsrEoTQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B5CE71C106A1;
	Mon, 26 Feb 2024 15:21:25 +0000 (UTC)
Received: from gentoo.redhat.com (unknown [10.45.224.64])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 04798492BD7;
	Mon, 26 Feb 2024 15:21:24 +0000 (UTC)
From: Alexey Gladkov <legion@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-api@vger.kernel.org
Subject: [RFC PATCH v2 4/5] vgacon: Allow to get max font width and height
Date: Mon, 26 Feb 2024 16:21:13 +0100
Message-ID: <6e8da86c7c8aa955158e8fec048a2c89cba4b592.1708960303.git.legion@kernel.org>
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
 drivers/video/console/vgacon.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 8ef1579fa57f..b75d31ef3353 100644
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
@@ -1013,6 +1017,19 @@ static int vgacon_adjust_height(struct vc_data *vc, unsigned fontheight)
 	return 0;
 }
 
+static int vgacon_font_info(struct vc_data *vc, struct console_font_info *info)
+{
+	info->min_width = VGACON_MAX_FONT_WIDTH;
+	info->min_height = 0;
+
+	info->max_width = VGACON_MAX_FONT_WIDTH;
+	info->max_height = VGACON_MAX_FONT_HEIGHT;
+
+	info->flags = KD_FONT_INFO_FLAG_LOW_SIZE | KD_FONT_INFO_FLAG_HIGH_SIZE;
+
+	return 0;
+}
+
 static int vgacon_font_set(struct vc_data *c, struct console_font *font,
 			   unsigned int vpitch, unsigned int flags)
 {
@@ -1022,7 +1039,8 @@ static int vgacon_font_set(struct vc_data *c, struct console_font *font,
 	if (vga_video_type < VIDEO_TYPE_EGAM)
 		return -EINVAL;
 
-	if (font->width != VGA_FONTWIDTH || font->height > 32 || vpitch != 32 ||
+	if (font->width != VGACON_MAX_FONT_WIDTH ||
+	    font->height > VGACON_MAX_FONT_HEIGHT || vpitch != 32 ||
 	    (charcount != 256 && charcount != 512))
 		return -EINVAL;
 
@@ -1177,6 +1195,7 @@ const struct consw vga_con = {
 	.con_scroll = vgacon_scroll,
 	.con_switch = vgacon_switch,
 	.con_blank = vgacon_blank,
+	.con_font_info = vgacon_font_info,
 	.con_font_set = vgacon_font_set,
 	.con_font_get = vgacon_font_get,
 	.con_resize = vgacon_resize,
-- 
2.44.0


