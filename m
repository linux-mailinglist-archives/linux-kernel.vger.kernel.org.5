Return-Path: <linux-kernel+bounces-67210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A1785680C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C2ED1C21A7F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9E813472D;
	Thu, 15 Feb 2024 15:37:54 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016F5134721
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 15:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708011473; cv=none; b=O8rPlp7Y7kTsr7t/KC3+fTYv3z1z7MJfsJYq0+Ul3VuHvB06K+YEOBh7khLNsuCXHSbvWTw/bSqucja7CMZ/LjjB5sOKAI1aI4ND4zk1cXjhAPhUEmy95PYH/uRBgSxWZ5XcqLNXTvhuAtAOyLsRGgtrlDNjU0U6XAxGQZEMHZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708011473; c=relaxed/simple;
	bh=474Y3iVLHHUM1rCff7tk5dxLN3ak3aH90Sl7yM/vUg4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H9vdPMYrRW5/rM+/EQFMi+iV3qgJd1nubl9ddiacBlQ0k2AX5K7vD8BeTNZ0beJvE/g+BEGNZ1fcCeD8ZXkpMB1XZyKAfCn6lRCT7BMysKWrOuOXfpamFwo/0atXyDxi/EVf3YOok+l7ratnU8LOggAjI9D8Ly1XUOTHFPnQ4Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-9OgLH7iLM0K_zkVk9ukhBA-1; Thu,
 15 Feb 2024 10:37:43 -0500
X-MC-Unique: 9OgLH7iLM0K_zkVk9ukhBA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 273471C0983A;
	Thu, 15 Feb 2024 15:37:43 +0000 (UTC)
Received: from gentoo.redhat.com (unknown [10.45.226.49])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 858F7112132A;
	Thu, 15 Feb 2024 15:37:42 +0000 (UTC)
From: Alexey Gladkov <legion@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [RFC PATCH v1 1/5] VT: Add KD_FONT_OP_GET_INFO operation
Date: Thu, 15 Feb 2024 15:37:20 +0000
Message-ID: <f3fe608ece222f7782eff0fe714faf6439197090.1708011391.git.legion@kernel.org>
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

Each driver has its own restrictions on font size. There is currently no
way to understand what the requirements are. The new operation allows
userspace to get the maximum font size values.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 drivers/tty/vt/vt.c       | 27 +++++++++++++++++++++++++++
 drivers/tty/vt/vt_ioctl.c |  2 +-
 include/linux/console.h   |  1 +
 include/uapi/linux/kd.h   |  1 +
 4 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 156efda7c80d..e1d0f95ccba0 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -4628,6 +4628,31 @@ static int con_font_set(struct vc_data *vc, struct console_font_op *op)
 	return rc;
 }
 
+static int con_font_info(struct vc_data *vc, struct console_font_op *op)
+{
+	struct console_font font;
+	int rc = -EINVAL;
+
+	font.height = max_font_height;
+	font.width = max_font_width;
+	font.charcount = max_font_glyphs;
+
+	console_lock();
+	if (vc->vc_mode != KD_TEXT)
+		rc = -EINVAL;
+	else if (vc->vc_sw->con_font_info)
+		rc = vc->vc_sw->con_font_info(vc, &font);
+	else
+		rc = -ENOSYS;
+	console_unlock();
+
+	op->height = font.height;
+	op->width = font.width;
+	op->charcount = font.charcount;
+
+	return rc;
+}
+
 static int con_font_default(struct vc_data *vc, struct console_font_op *op)
 {
 	struct console_font font = {.width = op->width, .height = op->height};
@@ -4673,6 +4698,8 @@ int con_font_op(struct vc_data *vc, struct console_font_op *op)
 		return con_font_get(vc, op);
 	case KD_FONT_OP_SET_DEFAULT:
 		return con_font_default(vc, op);
+	case KD_FONT_OP_GET_INFO:
+		return con_font_info(vc, op);
 	case KD_FONT_OP_COPY:
 		/* was buggy and never really used */
 		return -EINVAL;
diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index 8c685b501404..d6853d30ad19 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -469,7 +469,7 @@ static int vt_k_ioctl(struct tty_struct *tty, unsigned int cmd,
 
 		if (copy_from_user(&op, up, sizeof(op)))
 			return -EFAULT;
-		if (!perm && op.op != KD_FONT_OP_GET)
+		if (!perm && op.op != KD_FONT_OP_GET && op.op != KD_FONT_OP_GET_INFO)
 			return -EPERM;
 		ret = con_font_op(vc, &op);
 		if (ret)
diff --git a/include/linux/console.h b/include/linux/console.h
index 779d388af8a0..4afd9139d529 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -59,6 +59,7 @@ struct consw {
 			unsigned int lines);
 	int	(*con_switch)(struct vc_data *vc);
 	int	(*con_blank)(struct vc_data *vc, int blank, int mode_switch);
+	int	(*con_font_info)(struct vc_data *vc, struct console_font *font);
 	int	(*con_font_set)(struct vc_data *vc, struct console_font *font,
 			unsigned int vpitch, unsigned int flags);
 	int	(*con_font_get)(struct vc_data *vc, struct console_font *font,
diff --git a/include/uapi/linux/kd.h b/include/uapi/linux/kd.h
index 6b384065c013..21a1fb18dba0 100644
--- a/include/uapi/linux/kd.h
+++ b/include/uapi/linux/kd.h
@@ -180,6 +180,7 @@ struct console_font {
 #define KD_FONT_OP_COPY		3	/* Obsolete, do not use */
 #define KD_FONT_OP_SET_TALL	4	/* Set font with vpitch = height */
 #define KD_FONT_OP_GET_TALL	5	/* Get font with vpitch = height */
+#define KD_FONT_OP_GET_INFO	6
 
 #define KD_FONT_FLAG_DONT_RECALC 	1	/* Don't recalculate hw charcell size [compat] */
 
-- 
2.43.0


