Return-Path: <linux-kernel+bounces-81791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50532867AEF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16EE1B2B7AC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C861E12E1D9;
	Mon, 26 Feb 2024 15:22:47 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F063112C812
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 15:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708960967; cv=none; b=KD5PHcJN2qmHt79+s+2LV7T6q7NWyfZiLd8zIP0unQ8rQAQZbyzQznUrmuz2CRyUxLThkcbTSDHJ7P/+pmdDSCxRijzQZvieXX9jVPlAZmhPqc3oTw4RA7X5OrpvLbm7Oq+r13jTRjdf7N/y1jdQsUO3ivNXrSAhuBAX/uxx5So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708960967; c=relaxed/simple;
	bh=kmBEBhIPZ3K6yo8dFqH+CwKILdo/XwZlWONCFjWvj5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SeYBM+7LvNqvu7nzGYBZj3G3T8o3RMvtQ8ZbjDHgduZ15JIT0LCuPcJLoIBU9TG5mLaQaDv0mnAujD99GoG7XJmowhLA1DZ2ALawqaWMgwAfB8OBiCBCvJuTGwMM0OUVlPsn+9TRddpHIKboQHWlL04wkoE8CYN1dERONuIUXVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-LNEoIRY9OxCisOBL_DgNZg-1; Mon, 26 Feb 2024 10:21:25 -0500
X-MC-Unique: LNEoIRY9OxCisOBL_DgNZg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C09591097B05;
	Mon, 26 Feb 2024 15:21:24 +0000 (UTC)
Received: from gentoo.redhat.com (unknown [10.45.224.64])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0C3DB492BE2;
	Mon, 26 Feb 2024 15:21:23 +0000 (UTC)
From: Alexey Gladkov <legion@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-api@vger.kernel.org
Subject: [RFC PATCH v2 3/5] sticon: Allow to get max font width and height
Date: Mon, 26 Feb 2024 16:21:12 +0100
Message-ID: <07c0cb7f0c175460561957190e48a6e01a74a676.1708960303.git.legion@kernel.org>
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
 drivers/video/console/sticon.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/video/console/sticon.c b/drivers/video/console/sticon.c
index 992a4fa431aa..d32ca458eb77 100644
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
+	if (!in_range(w, STICON_MIN_FONT_WIDTH, STICON_MAX_FONT_WIDTH) ||
+	    !in_range(h, STICON_MIN_FONT_HEIGHT, STICON_MAX_FONT_HEIGHT) ||
+	    (vpitch != 32) ||
+	    (op->charcount != 256 && op->charcount != 512))
 		return -EINVAL;
 	pitch = ALIGN(w, 8) / 8;
 	bpc = pitch * h;
@@ -273,6 +280,19 @@ static int sticon_font_set(struct vc_data *vc, struct console_font *font,
 	return sticon_set_font(vc, font, vpitch);
 }
 
+static int sticon_font_info(struct vc_data *vc, struct console_font_info *info)
+{
+	info->min_width = STICON_MIN_FONT_WIDTH;
+	info->min_height = STICON_MIN_FONT_HEIGHT;
+
+	info->max_width = STICON_MAX_FONT_WIDTH;
+	info->max_height = STICON_MAX_FONT_HEIGHT;
+
+	info->flags = KD_FONT_INFO_FLAG_LOW_SIZE | KD_FONT_INFO_FLAG_HIGH_SIZE;
+
+	return 0;
+}
+
 static void sticon_init(struct vc_data *c, int init)
 {
     struct sti_struct *sti = sticon_sti;
@@ -371,6 +391,7 @@ static const struct consw sti_con = {
 	.con_scroll		= sticon_scroll,
 	.con_switch		= sticon_switch,
 	.con_blank		= sticon_blank,
+	.con_font_info		= sticon_font_info,
 	.con_font_set		= sticon_font_set,
 	.con_font_default	= sticon_font_default,
 	.con_build_attr		= sticon_build_attr,
-- 
2.44.0


