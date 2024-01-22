Return-Path: <linux-kernel+bounces-32845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A26E8360D3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53303284726
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0301346452;
	Mon, 22 Jan 2024 11:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKX8MNHG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4437346441;
	Mon, 22 Jan 2024 11:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921511; cv=none; b=T3Y7L3yAPtszoPEJsjp/g1T9WFuybki12RiRZh7vMH4tDLEapHL5MM71S5wE6iFQfyk8EmXMUdB4GufKiSrSON4b1LCJKemjCm2aXuGB/qq3F/mwUClP1IvVfTi5NFTnxn3TPPacZCGHwKCbBq28ppJLGJFSYn8HBVD8dYbWmUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921511; c=relaxed/simple;
	bh=5YnvEHuFcc8AIaC+xvMeZuB5PSZXwT77cd4oUnrMXeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ka8G+EowLiHLDi86qrU8v67MeeUpX1CZr9hRbP4TUCvGAaWYuIOEK8o3zLAFKTRF+89LJkLpoQyUqePA1R3NpjMM+s0tQvm0dxInbgAu+qhOrFqpxjfTII5gH6sDdpwbrA+wuMfMO87hMHWeEzG3X8L/yUzQUdXnfif/3K36TqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKX8MNHG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A287C433A6;
	Mon, 22 Jan 2024 11:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705921511;
	bh=5YnvEHuFcc8AIaC+xvMeZuB5PSZXwT77cd4oUnrMXeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fKX8MNHGPf56c71WFeA/o5leTvTrtyVdP4LG00e9KXo1lh8y4ZtslMG6h/0fw5+Iw
	 YbdObyOgKu1A/p3mhkyrp49gh1OSzpF2QNOs6R211rTvaNIkH0Z71F9487VX6kqx8z
	 /OJm5jtNYXJsz1SxBnmi0tK2lamGaAU79fsJyFst7ZfIOqWPJvzpMOXQUwfh5kgkGh
	 lve3PaSSzEgCueFGTQm3EVBraRUMN/JvSw/fkGZMYn8Ige/Pl18ie/ofimUpM+tSFN
	 WfOBiXn9z+W/Gfjjmrd/H68558gC5TkEQr0Yk3h7QbXk5wwJo84YIT9PhoRc8Uanhf
	 9RZQ0geB7M1MA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 32/47] tty: vt: define a common enum for VESA blanking constants
Date: Mon, 22 Jan 2024 12:03:46 +0100
Message-ID: <20240122110401.7289-33-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122110401.7289-1-jirislaby@kernel.org>
References: <20240122110401.7289-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are currently two places with VESA blanking constants definitions:
fb.h and console.h. Extract/unify the two to a separate header (vesa.h).

Given the fb's is in an uapi header, create the common header in uapi
too.

Note that instead of macros, an enum (vesa_blank_mode) is created. But
the macros are kept too (they now expand to the enum constants), just in
case someone in userspace performs some #ifdeffery.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>
---

Notes:
    [v2] new in v2

 include/linux/console.h   |  7 +------
 include/uapi/linux/fb.h   |  8 +-------
 include/uapi/linux/vesa.h | 18 ++++++++++++++++++
 3 files changed, 20 insertions(+), 13 deletions(-)
 create mode 100644 include/uapi/linux/vesa.h

diff --git a/include/linux/console.h b/include/linux/console.h
index f7c6b5fc3a36..860f82756c9c 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -18,6 +18,7 @@
 #include <linux/bits.h>
 #include <linux/rculist.h>
 #include <linux/types.h>
+#include <linux/vesa.h>
 
 struct vc_data;
 struct console_font_op;
@@ -520,12 +521,6 @@ void vcs_remove_sysfs(int index);
  */
 extern atomic_t ignore_console_lock_warning;
 
-/* VESA Blanking Levels */
-#define VESA_NO_BLANKING        0
-#define VESA_VSYNC_SUSPEND      1
-#define VESA_HSYNC_SUSPEND      2
-#define VESA_POWERDOWN          3
-
 extern void console_init(void);
 
 /* For deferred console takeover */
diff --git a/include/uapi/linux/fb.h b/include/uapi/linux/fb.h
index 3a49913d006c..cde8f173f566 100644
--- a/include/uapi/linux/fb.h
+++ b/include/uapi/linux/fb.h
@@ -4,6 +4,7 @@
 
 #include <linux/types.h>
 #include <linux/i2c.h>
+#include <linux/vesa.h>
 
 /* Definitions of frame buffers						*/
 
@@ -293,13 +294,6 @@ struct fb_con2fbmap {
 	__u32 framebuffer;
 };
 
-/* VESA Blanking Levels */
-#define VESA_NO_BLANKING        0
-#define VESA_VSYNC_SUSPEND      1
-#define VESA_HSYNC_SUSPEND      2
-#define VESA_POWERDOWN          3
-
-
 enum {
 	/* screen: unblanked, hsync: on,  vsync: on */
 	FB_BLANK_UNBLANK       = VESA_NO_BLANKING,
diff --git a/include/uapi/linux/vesa.h b/include/uapi/linux/vesa.h
new file mode 100644
index 000000000000..81947f5088cd
--- /dev/null
+++ b/include/uapi/linux/vesa.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_VESA_H
+#define _UAPI_LINUX_VESA_H
+
+/* VESA Blanking Levels */
+enum vesa_blank_mode {
+	VESA_NO_BLANKING	= 0,
+#define VESA_NO_BLANKING	VESA_NO_BLANKING
+	VESA_VSYNC_SUSPEND	= 1,
+#define VESA_VSYNC_SUSPEND	VESA_VSYNC_SUSPEND
+	VESA_HSYNC_SUSPEND	= 2,
+#define VESA_HSYNC_SUSPEND	VESA_HSYNC_SUSPEND
+	VESA_POWERDOWN		= VESA_VSYNC_SUSPEND | VESA_HSYNC_SUSPEND,
+#define VESA_POWERDOWN		VESA_POWERDOWN
+	VESA_BLANK_MAX		= VESA_POWERDOWN,
+};
+
+#endif
-- 
2.43.0


