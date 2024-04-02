Return-Path: <linux-kernel+bounces-128462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF93895B25
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB0301C2108B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B903515B0FB;
	Tue,  2 Apr 2024 17:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCJcD0IB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA71215B0E2;
	Tue,  2 Apr 2024 17:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712080285; cv=none; b=C7Xj1xsHNzkJ1mluMXE9vvslziQSSwn1X8OmH6s/geOts7kZchb9dyYPgpyJL1nUlVlDQaBBTqISyuVB4DwyJe2d8wYQRP4K3aQoLWDkyd52XFFP0ZQQ65dyc1JTKTEOuurM51fc47F9eLE97u9eUE3l4uail/hxvzrPX82FuJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712080285; c=relaxed/simple;
	bh=mcZpMvFtZwhSB7YYS+YmnPDFhAZDnH/C5k4Mpq9FzcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=daAgC5pStZc6TMuD5ZmoGKqGNs4Lopt2v92e+aFUmc+3C7SMkEub/r1fbeDQvahKRypiU0tvbieQYRN6oItDxv0yZS6Rtj5IIPUrJUkI2sUgxlJpylGUi0hyID79NgzSO95Uo/5n7ifreYWIqZkGcSRyiFPVAdJfmCrh2hecX1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCJcD0IB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6ECC433C7;
	Tue,  2 Apr 2024 17:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712080284;
	bh=mcZpMvFtZwhSB7YYS+YmnPDFhAZDnH/C5k4Mpq9FzcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OCJcD0IBXDGg1DbWi/wLw28dQ4aN7qSRFaUDY8HSPDJOJY45G89fBV8qK9ZbAj8U8
	 Juw1UUlJzRQGV2mZoijgalpdR9rgltpjtig2vHX6OeKEz4f1aLInqtCSVvOEcPSp2V
	 TNVXZIF0GvBHHadHGDqq7AoX0K5ayf+2FPKbZFPNrVlnVFb8WiUbyUt2Wzt1JaI8iC
	 mws7qRNrGMrQUOGIWdAQTiN80lCIpmuKnpQDWz6aaSG29DRgvajIqBN6OimsPWbbZz
	 9Ag4t2nlkQ9QjMo3BdsNMCK2Oxd2vIzsIl2Lkl5QPrdt8Nt5TXx2kcZMxKPC5yif5c
	 DzERlwbUwX/mA==
From: Alexey Gladkov <legion@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	kbd@lists.linux.dev,
	linux-api@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Helge Deller <deller@gmx.de>
Subject: [PATCH v4 2/3] VT: Add KDFONTINFO ioctl
Date: Tue,  2 Apr 2024 19:50:45 +0200
Message-ID: <7cd32f988a147d7617742c9e074c753de0c6bc1f.1712080158.git.legion@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712080158.git.legion@kernel.org>
References: <74ca50e0-61b1-4d4c-85dd-a5d920548c04@kernel.org> <cover.1712080158.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each driver has its own restrictions on font size. There is currently no
way to understand what the requirements are. The new ioctl allows
userspace to get the minimum and maximum font size values.

Acked-by: Helge Deller <deller@gmx.de>
Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 drivers/tty/vt/vt.c       | 24 ++++++++++++++++++++++++
 drivers/tty/vt/vt_ioctl.c | 11 +++++++++++
 include/linux/console.h   |  3 +++
 include/linux/vt_kern.h   |  1 +
 include/uapi/linux/kd.h   | 13 ++++++++++++-
 5 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 9b5b98dfc8b4..e8db0e9ea674 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -4851,6 +4851,30 @@ int con_font_op(struct vc_data *vc, struct console_font_op *op)
 	return -ENOSYS;
 }
 
+int con_font_info(struct vc_data *vc, struct console_font_info *info)
+{
+	int rc;
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
index 4b91072f3a4e..40f9467f503d 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -479,6 +479,17 @@ static int vt_k_ioctl(struct tty_struct *tty, unsigned int cmd,
 		break;
 	}
 
+	case KDFONTINFO: {
+		struct console_font_info fnt_info;
+
+		ret = con_font_info(vc, &fnt_info);
+		if (ret)
+			return ret;
+		if (copy_to_user(up, &fnt_info, sizeof(fnt_info)))
+			return -EFAULT;
+		break;
+	}
+
 	default:
 		return -ENOIOCTLCMD;
 	}
diff --git a/include/linux/console.h b/include/linux/console.h
index 31a8f5b85f5d..4b798322aa01 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -21,6 +21,7 @@
 #include <linux/vesa.h>
 
 struct vc_data;
+struct console_font_info;
 struct console_font_op;
 struct console_font;
 struct module;
@@ -102,6 +103,8 @@ struct consw {
 	bool	(*con_switch)(struct vc_data *vc);
 	bool	(*con_blank)(struct vc_data *vc, enum vesa_blank_mode blank,
 			     bool mode_switch);
+	int	(*con_font_info)(struct vc_data *vc,
+				 struct console_font_info *info);
 	int	(*con_font_set)(struct vc_data *vc,
 				const struct console_font *font,
 				unsigned int vpitch, unsigned int flags);
diff --git a/include/linux/vt_kern.h b/include/linux/vt_kern.h
index d008c3d0a9bb..383b3a4f6113 100644
--- a/include/linux/vt_kern.h
+++ b/include/linux/vt_kern.h
@@ -33,6 +33,7 @@ void do_blank_screen(int entering_gfx);
 void do_unblank_screen(int leaving_gfx);
 void poke_blanked_console(void);
 int con_font_op(struct vc_data *vc, struct console_font_op *op);
+int con_font_info(struct vc_data *vc, struct console_font_info *info);
 int con_set_cmap(unsigned char __user *cmap);
 int con_get_cmap(unsigned char __user *cmap);
 void scrollback(struct vc_data *vc);
diff --git a/include/uapi/linux/kd.h b/include/uapi/linux/kd.h
index 8ddb2219a84b..abaf4dd6bb93 100644
--- a/include/uapi/linux/kd.h
+++ b/include/uapi/linux/kd.h
@@ -185,8 +185,19 @@ struct console_font {
 
 #define KD_FONT_FLAG_DONT_RECALC 	1	/* Don't recalculate hw charcell size [compat] */
 
+#define KDFONTINFO	_IO(KD_IOCTL_BASE, 0x73)	/* font information */
+
+#define KD_FONT_INFO_FLAG_LOW_SIZE	_BITUL(0) /* 256 */
+#define KD_FONT_INFO_FLAG_HIGH_SIZE	_BITUL(1) /* 512 */
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


