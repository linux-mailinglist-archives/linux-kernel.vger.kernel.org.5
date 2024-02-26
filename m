Return-Path: <linux-kernel+bounces-81787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC46F867A1A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 665A02A3E44
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F2112BEB1;
	Mon, 26 Feb 2024 15:22:36 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A28012A176
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 15:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708960956; cv=none; b=rfLBBUaSHTXGMa0kKV/Gw7YAVmBDg/5ecNbyy3haXrfIkYeXTbw83qcELgjdskQuYefTMsp2vOstgXZ7lGtSMHCTdK5EjCJlo0iwEH426zrJiFJsHP0ovUB1K5AtXmbCG5RnISNf/0Xo/8b7rxl1Eq7nYWp0SFn+eHAUqr1m1C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708960956; c=relaxed/simple;
	bh=yxolVSJbX/m3dNfKsgTDQ8S6trHvUXOwfNqXfcacNxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DEczITiYzUGwFtrwZcK636NCHuYkbXR2FGimRrwF69bHAyy4q35Ned2O23CLSRXwlts2vTSjJXVV7u33zVhRwwMhTYFktIoIpoQoqk615narCQZQlLSkQsqPv9Yq01XnGGVW9bzVsgwVqtRjfR35OOu5WEkt49HG05uZ9YjdeFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-0P7e64eiMSCuA8or5N7p9w-1; Mon, 26 Feb 2024 10:21:24 -0500
X-MC-Unique: 0P7e64eiMSCuA8or5N7p9w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C827C85A59A;
	Mon, 26 Feb 2024 15:21:23 +0000 (UTC)
Received: from gentoo.redhat.com (unknown [10.45.224.64])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 170BE492BD7;
	Mon, 26 Feb 2024 15:21:22 +0000 (UTC)
From: Alexey Gladkov <legion@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-api@vger.kernel.org
Subject: [RFC PATCH v2 2/5] newport_con: Allow to get max font width and height
Date: Mon, 26 Feb 2024 16:21:11 +0100
Message-ID: <a3a51895624aea1a6fc9a1f1996c187cd806b84c.1708960303.git.legion@kernel.org>
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
 drivers/video/console/newport_con.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index e8e4f82cd4a1..87f174a95fa8 100644
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
 
+static int newport_font_info(struct vc_data *vc, struct console_font_info *info)
+{
+	info->min_width = info->max_width = NEWPORT_MAX_FONT_WIDTH;
+	info->min_height = info->max_height = NEWPORT_MAX_FONT_HEIGHT;
+	info->flags = KD_FONT_INFO_FLAG_LOW_SIZE | KD_FONT_INFO_FLAG_HIGH_SIZE;
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
2.44.0


