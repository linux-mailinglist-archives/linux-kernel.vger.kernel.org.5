Return-Path: <linux-kernel+bounces-81789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E075867A1C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D46E12A3EFB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C4C12C7EB;
	Mon, 26 Feb 2024 15:22:40 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C5912C522
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 15:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708960960; cv=none; b=txSVx+g+XLOZTsdsuRYzkY+TMO18Zgp2iLtzYYTa2bYYq+HPCNkabJkjlny5HvjQYQ+nCyZH0VWU9LO3wczB708bXGMXAOiR1VjKPQvjzSCNOP4Tc1GQ3q0OOPX8C2xdMa67G2fXlwhOGKgVndOs4cUkGOWEXrCwkqTMx/yQ2S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708960960; c=relaxed/simple;
	bh=XXRAFqi6kit/CJzUZCswo5V1wts4Yus3f0+vof+UBHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z4WrzbEZYsmGGpcZkseMtCh4PpcD6ouQtK/dYEm7RmgxTB4HLcbxulTiVVI6KSFLP27QOylkaMXbhT83EaOpevnjXwI5zvLK7SRrJqTcUD2jyNrkf/KdLMaSbYLizHzH77bjpEP377S/S3/uIVz+DCsLKD9FSRdzF75kKC0qiLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-qE5a-wOcMIKf7NpvicHYHg-1; Mon, 26 Feb 2024 10:21:23 -0500
X-MC-Unique: qE5a-wOcMIKf7NpvicHYHg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D37ED800074;
	Mon, 26 Feb 2024 15:21:22 +0000 (UTC)
Received: from gentoo.redhat.com (unknown [10.45.224.64])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 21406492BE2;
	Mon, 26 Feb 2024 15:21:22 +0000 (UTC)
From: Alexey Gladkov <legion@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-api@vger.kernel.org
Subject: [RFC PATCH v2 1/5] VT: Add KD_FONT_OP_GET_INFO operation
Date: Mon, 26 Feb 2024 16:21:10 +0100
Message-ID: <a13e766ee428f515dca3afb4365e8e09623660c7.1708960303.git.legion@kernel.org>
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

Each driver has its own restrictions on font size. There is currently no
way to understand what the requirements are. The new operation allows
userspace to get the maximum font size values.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 drivers/tty/vt/vt.c       | 24 ++++++++++++++++++++++++
 drivers/tty/vt/vt_ioctl.c | 12 ++++++++++++
 include/linux/console.h   |  2 ++
 include/linux/vt_kern.h   |  1 +
 include/uapi/linux/kd.h   | 13 ++++++++++++-
 5 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 156efda7c80d..8c2a3d98b5ec 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -4680,6 +4680,30 @@ int con_font_op(struct vc_data *vc, struct console_font_op *op)
 	return -ENOSYS;
 }
 
+int con_font_info(struct vc_data *vc, struct console_font_info *info)
+{
+	int rc = -EINVAL;
+
+	info->min_height = 0;
+	info->max_height = max_font_height;
+
+	info->min_width = 0;
+	info->max_width = max_font_width;
+
+	info->flags = KD_FONT_INFO_FLAG_LOW_SIZE | KD_FONT_INFO_FLAG_HIGH_SIZE;
+
+	console_lock();
+	if (vc->vc_mode != KD_TEXT)
+		rc = -EINVAL;
+	else if (vc->vc_sw->con_font_info)
+		rc = vc->vc_sw->con_font_info(vc, info);
+	else
+		rc = -ENOSYS;
+	console_unlock();
+
+	return rc;
+}
+
 /*
  *	Interface exported to selection and vcs.
  */
diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index 8c685b501404..a5f160e15a76 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -479,6 +479,18 @@ static int vt_k_ioctl(struct tty_struct *tty, unsigned int cmd,
 		break;
 	}
 
+	case KDFONTINFO:
+		struct console_font_info fnt_info;
+
+		if (copy_from_user(&fnt_info, up, sizeof(fnt_info)))
+			return -EFAULT;
+		ret = con_font_info(vc, &fnt_info);
+		if (ret)
+			return ret;
+		if (copy_to_user(up, &fnt_info, sizeof(fnt_info)))
+			return -EFAULT;
+		break;
+
 	default:
 		return -ENOIOCTLCMD;
 	}
diff --git a/include/linux/console.h b/include/linux/console.h
index 779d388af8a0..5bea6f6c2042 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -20,6 +20,7 @@
 #include <linux/types.h>
 
 struct vc_data;
+struct console_font_info;
 struct console_font_op;
 struct console_font;
 struct module;
@@ -59,6 +60,7 @@ struct consw {
 			unsigned int lines);
 	int	(*con_switch)(struct vc_data *vc);
 	int	(*con_blank)(struct vc_data *vc, int blank, int mode_switch);
+	int	(*con_font_info)(struct vc_data *vc, struct console_font_info *info);
 	int	(*con_font_set)(struct vc_data *vc, struct console_font *font,
 			unsigned int vpitch, unsigned int flags);
 	int	(*con_font_get)(struct vc_data *vc, struct console_font *font,
diff --git a/include/linux/vt_kern.h b/include/linux/vt_kern.h
index c1f5aebef170..6bda4cc1fe6f 100644
--- a/include/linux/vt_kern.h
+++ b/include/linux/vt_kern.h
@@ -32,6 +32,7 @@ void do_blank_screen(int entering_gfx);
 void do_unblank_screen(int leaving_gfx);
 void poke_blanked_console(void);
 int con_font_op(struct vc_data *vc, struct console_font_op *op);
+int con_font_info(struct vc_data *vc, struct console_font_info *info);
 int con_set_cmap(unsigned char __user *cmap);
 int con_get_cmap(unsigned char __user *cmap);
 void scrollback(struct vc_data *vc);
diff --git a/include/uapi/linux/kd.h b/include/uapi/linux/kd.h
index 6b384065c013..781e086e55bf 100644
--- a/include/uapi/linux/kd.h
+++ b/include/uapi/linux/kd.h
@@ -183,8 +183,19 @@ struct console_font {
 
 #define KD_FONT_FLAG_DONT_RECALC 	1	/* Don't recalculate hw charcell size [compat] */
 
+#define KDFONTINFO	0x4B73	/* font information */
+
+#define KD_FONT_INFO_FLAG_LOW_SIZE	(1U << 0) /* 256 */
+#define KD_FONT_INFO_FLAG_HIGH_SIZE	(1U << 1) /* 512 */
+
+struct console_font_info {
+	unsigned int min_width, min_height;	/* minimal font size */
+	unsigned int max_width, max_height;	/* maximum font size */
+	unsigned int flags;			/* KD_FONT_INFO_FLAG_* */
+};
+
 /* note: 0x4B00-0x4B4E all have had a value at some time;
    don't reuse for the time being */
-/* note: 0x4B60-0x4B6D, 0x4B70-0x4B72 used above */
+/* note: 0x4B60-0x4B6D, 0x4B70-0x4B73 used above */
 
 #endif /* _UAPI_LINUX_KD_H */
-- 
2.44.0


