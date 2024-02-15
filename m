Return-Path: <linux-kernel+bounces-67212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D43A885680E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 876CB1F2F1E5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC509134748;
	Thu, 15 Feb 2024 15:37:54 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3496134724
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 15:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708011474; cv=none; b=Ot3KaILSS9g675JMidz8TTCxOSPg24D6iheE/VgN+qwbgKsSOweQn76gtRfou16JIVskwx+PM+wd8xGq0SFe/xmYrVux9XC/qto92f3B3OvbcTYgh/rCUnhiyaioxgtt8B5mkau25I9FMkfOgw0K2/ZcABlbILLcBl5HZ/RxKHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708011474; c=relaxed/simple;
	bh=Wi1Uo3NTt3EhwOxhS1vpUDA6r4xPVGJhZxavZcntHe8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NUCcIuEF0w+h1mLItivVSU2TS/42dTVTv9OrQXUHT9n2VlTKuKUNQh8LuciDlf2W/ergck+rNWNRJ8tWsNBu/48nvTjhRdTdBVQikSWy1Ele3m7Hrb6Q9XzVLa2kufMR5+A244yLMOdRESqZj2Q6gavWoNOx8IxZwfABPbplO6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-5N3N6lTGOKWbNHkP7jCTUQ-1; Thu,
 15 Feb 2024 10:37:44 -0500
X-MC-Unique: 5N3N6lTGOKWbNHkP7jCTUQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0005B3C11A04;
	Thu, 15 Feb 2024 15:37:43 +0000 (UTC)
Received: from gentoo.redhat.com (unknown [10.45.226.49])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5EDB9112132A;
	Thu, 15 Feb 2024 15:37:43 +0000 (UTC)
From: Alexey Gladkov <legion@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [RFC PATCH v1 2/5] newport_con: Allow to get max font width and height
Date: Thu, 15 Feb 2024 15:37:21 +0000
Message-ID: <84a8e29072a5bdcc954d13b55b0574c6b0126499.1708011391.git.legion@kernel.org>
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
 drivers/video/console/newport_con.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index e8e4f82cd4a1..1364197136e7 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -33,6 +33,9 @@
 
 #define NEWPORT_LEN	0x10000
 
+#define NEWPORT_MAX_FONT_WIDTH 8
+#define NEWPORT_MAX_FONT_HEIGHT 16
+
 #define FONT_DATA ((unsigned char *)font_vga_8x16.data)
 
 static unsigned char *font_data[MAX_NR_CONSOLES];
@@ -328,8 +331,8 @@ static void newport_init(struct vc_data *vc, int init)
 {
 	int cols, rows;
 
-	cols = newport_xsize / 8;
-	rows = newport_ysize / 16;
+	cols = newport_xsize / NEWPORT_MAX_FONT_WIDTH;
+	rows = newport_ysize / NEWPORT_MAX_FONT_HEIGHT;
 	vc->vc_can_do_color = 1;
 	if (init) {
 		vc->vc_cols = cols;
@@ -507,8 +510,8 @@ static int newport_set_font(int unit, struct console_font *op, unsigned int vpit
 
 	/* ladis: when I grow up, there will be a day... and more sizes will
 	 * be supported ;-) */
-	if ((w != 8) || (h != 16) || (vpitch != 32)
-	    || (op->charcount != 256 && op->charcount != 512))
+	if ((w != NEWPORT_MAX_FONT_WIDTH) || (h != NEWPORT_MAX_FONT_HEIGHT) ||
+	    (vpitch != 32) || (op->charcount != 256 && op->charcount != 512))
 		return -EINVAL;
 
 	if (!(new_data = kmalloc(FONT_EXTRA_WORDS * sizeof(int) + size,
@@ -569,6 +572,15 @@ static int newport_font_default(struct vc_data *vc, struct console_font *op, cha
 	return newport_set_def_font(vc->vc_num, op);
 }
 
+static int newport_font_info(struct vc_data *vc, struct console_font *font)
+{
+	font->width = NEWPORT_MAX_FONT_WIDTH;
+	font->height = NEWPORT_MAX_FONT_HEIGHT;
+	font->charcount = 512;
+
+	return 0;
+}
+
 static int newport_font_set(struct vc_data *vc, struct console_font *font,
 			    unsigned int vpitch, unsigned int flags)
 {
@@ -688,6 +700,7 @@ const struct consw newport_con = {
 	.con_scroll	  = newport_scroll,
 	.con_switch	  = newport_switch,
 	.con_blank	  = newport_blank,
+	.con_font_info	  = newport_font_info,
 	.con_font_set	  = newport_font_set,
 	.con_font_default = newport_font_default,
 	.con_save_screen  = newport_save_screen
-- 
2.43.0


