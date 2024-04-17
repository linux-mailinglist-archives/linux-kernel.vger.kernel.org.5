Return-Path: <linux-kernel+bounces-149004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E468A8A5E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7677281C03
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E08017334F;
	Wed, 17 Apr 2024 17:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rgi79x/4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693F617332E;
	Wed, 17 Apr 2024 17:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713375523; cv=none; b=lv1iAIyZfh4L+15GFrFdRKpastICuwTmX7E7JNB+MPf5M6TXuKa/oOMl6tD4jLBRIh+5WzUFJh7Q+9T5AuurRBLGqvNeQc/dUNjcD8oKp2UiHVnEEPi55BdL9SstDTn73mmpYAUP8Z3Fc4BT4rjAM6za9nzyx5gf+DmBBxnGklk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713375523; c=relaxed/simple;
	bh=C0FpDzSLaiHIHj/ONRnFc7WXhx4hCXnanMrm22f3vqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IAxg2Xr9IuRBb/i+uYvHtAL1d3Uk1m/EvGVxam0odt7SRFQapbZCTjWtAtqOk4h1rhPMTE8N1p6+UD/GjC8uvCMJLubn6iyqoUgILXjVvEcvcmv3IU/XEOeISYNZypgHSsdvIA81LCjQyS7xgnLXSehfuEgSaQXUtT/3FX5xvqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rgi79x/4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29440C072AA;
	Wed, 17 Apr 2024 17:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713375523;
	bh=C0FpDzSLaiHIHj/ONRnFc7WXhx4hCXnanMrm22f3vqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rgi79x/4IuxqyBzev4Ar/fiA5n5fThIVqdm8kLAg53rt0S6Q2KfIH5eqmO96LB+i+
	 klbm4o6WdGflf7r/AZOKn7ciYxe18529ml1OlOvJnQBLjmSVfAIXdzeX4k8vADoLJx
	 jBRf54a5VXr5b/4N+9SCHaAcjuIq7W1BevUOUt8Gs+5fmYCq+bK8EftdD82eruMZhW
	 6T7ap2HfK6l+LpDhR7DOHXzIiVlHVBTl6eYB8RlhK8L8Bj8ZFq4HXSmxy/bFfKgggt
	 /w5HEXbZwILmiv3r3pxvI0vgR6dQvZp3OQsI4Xaq3sPpp2PlnNEUzotiqBMA18hvVG
	 fzcVwBmpVyTUQ==
From: Alexey Gladkov <legion@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	kbd@lists.linux.dev,
	linux-api@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Helge Deller <deller@gmx.de>
Subject: [PATCH v5 2/3] VT: Add KDFONTINFO ioctl
Date: Wed, 17 Apr 2024 19:37:36 +0200
Message-ID: <bd2755e7b6ebe9b49e82d04d9908a176e0fe2f15.1713375378.git.legion@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713375378.git.legion@kernel.org>
References: <cover.1712080158.git.legion@kernel.org> <cover.1713375378.git.legion@kernel.org>
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
 drivers/tty/vt/vt_ioctl.c | 13 +++++++++++++
 include/linux/console.h   |  3 +++
 include/linux/vt_kern.h   |  1 +
 include/uapi/linux/kd.h   | 14 ++++++++++++++
 5 files changed, 55 insertions(+)

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
index 4b91072f3a4e..9a2f8081f650 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -479,6 +479,19 @@ static int vt_k_ioctl(struct tty_struct *tty, unsigned int cmd,
 		break;
 	}
 
+	case KDFONTINFO: {
+		struct console_font_info fnt_info;
+
+		memset(&fnt_info, 0, sizeof(fnt_info));
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
index 8ddb2219a84b..68b715ad4d5c 100644
--- a/include/uapi/linux/kd.h
+++ b/include/uapi/linux/kd.h
@@ -185,6 +185,20 @@ struct console_font {
 
 #define KD_FONT_FLAG_DONT_RECALC 	1	/* Don't recalculate hw charcell size [compat] */
 
+/* font information */
+
+#define KD_FONT_INFO_FLAG_LOW_SIZE	_BITUL(0) /* 256 */
+#define KD_FONT_INFO_FLAG_HIGH_SIZE	_BITUL(1) /* 512 */
+
+struct console_font_info {
+	__u32  flags;			/* KD_FONT_INFO_FLAG_* */
+	__u32 min_width, min_height;	/* minimal font size */
+	__u32 max_width, max_height;	/* maximum font size */
+	__u32 reserved[5];		/* This field is reserved for future use. Must be 0. */
+};
+
+#define KDFONTINFO	_IOR(KD_IOCTL_BASE, 0x73, struct console_font_info)
+
 /* note: 0x4B00-0x4B4E all have had a value at some time;
    don't reuse for the time being */
 /* note: 0x4B60-0x4B6D, 0x4B70-0x4B72 used above */
-- 
2.44.0


