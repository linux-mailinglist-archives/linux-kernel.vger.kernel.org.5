Return-Path: <linux-kernel+bounces-31538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D54832FA4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 21:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC45828160A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 20:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE8858104;
	Fri, 19 Jan 2024 20:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TP+emgSi"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F341B57873
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 20:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705695255; cv=none; b=a5DaFVMq8oxp5+jjyRuJf8J4U5zT0TSENYkXqn5KsyhJPpD349PgW/SihzKYU5oIOO/y1CclkHCP1BDs9kzuJUsm9NitgptNwUoeJuwxPPl+HESKUxlcGo74GhuVsgFiYeeDU0AIt65G5vwyjgzbPtRi8fi4o0CyxHOXl7IpalE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705695255; c=relaxed/simple;
	bh=F9Ijc1dkn4LnIYgLJYdQeo8/xAlm6GZYuUki9yJ2hME=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ixJzJES2ex9/r/ZS6ZgPLSbTZ5+yRUYiS1EYCjKbdWV9e/ILcRBKatVddXerX28rcmDG0Haz4pd9SojrUezpJy8YBv3mOr8ydrBBnJZwhw4gpTzbEWuoooHYn0BxVudYv7R/M3oRCm5yfSs3UzUlUz92sunGycQfrhJYJC5zmgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TP+emgSi; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e8801221cso10479895e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 12:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705695251; x=1706300051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cslHUuioJKZUdWZhA350tTceu4m4Qgt6DILKRrYZ0CA=;
        b=TP+emgSirsMxBcK31BpgZQs9B2cV6Xqdyn7U+yLygJylIirfAWFO07JRsReVegK9n1
         3G2/CVAyG41/yHTtiqn0u2/b/TyDJ3Igoc2CgmWbNh10ypo+BZpNfxa0t4HpuzbaRAvd
         Czfb9gboYR95/YbWzYZuxgnU6K4pOHGKOa/j8/zexW7kzmOqP4+3p+7RpCIqyen+cWkK
         P56HPBaYrWyho8crCZHPD+ZO1E0es7hpzh8028HJaWvUZRhSqnlBMIFJVvZBRaeL6yZD
         OKpfnun/0VlHw6cVBe3l8goGDxu5KMVyTsbi/2naV4THanuaYguqeMH/j81A47eRDhbL
         /J0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705695251; x=1706300051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cslHUuioJKZUdWZhA350tTceu4m4Qgt6DILKRrYZ0CA=;
        b=Kwv/ePGjfo5qsqsm4f1ZmAMnF0G7v6tjO4znD/uIggL7Oof1dWEhVMSnqlfb3mQDXD
         KLz/b7uQWLV9is6Qh42bjZXiQTtIdNUJK1aT7dtlG4W3eMRxAW58co01Np/Z8C0rRFVt
         6KoNHSZ2mlJ6jbyonQF75UpBSFJhDTwI/G3RGtwo9oJLm8BQiq20ZPwtRQE4CUONKlF3
         PDQtQT/uKkocMFN8OZ+7i6kQ4PFKTSSku0cmMnuLtvHaRDgas+FWYdOkaxYPZmRAHACk
         vpmFwq+7RGH8CE/uZk6dJPRLG+fGXY0BdNobMycySv6cI/zJUWjo+bEr/zMKKOruU9b6
         I0Zg==
X-Gm-Message-State: AOJu0YxR/zKd2ofFUcou6WXCLnHoMJWzKc/1lMwjLdRP+QTAmLLq72eT
	PF+PTufK0Uqv4QPBiqJEI3A7sqEV8htFZtE8U0M+bcujeqQzvq0U
X-Google-Smtp-Source: AGHT+IFOTbdL41cPmnp9k4iSwF+mjvZLoMetREkJ8ghXgjbgzt/oHLxO7qTkVIPVPM4SNAVG2Qk5Pw==
X-Received: by 2002:a1c:7404:0:b0:40e:6b8e:5ab2 with SMTP id p4-20020a1c7404000000b0040e6b8e5ab2mr189320wmc.106.1705695250892;
        Fri, 19 Jan 2024 12:14:10 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id q5-20020adff505000000b00339214d70b5sm2084788wro.85.2024.01.19.12.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 12:14:10 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Randy Dunlap <rdunlap@infradead.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Eric DeVolder <eric.devolder@oracle.com>,
	Nathan Chancellor <nathan@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Kees Cook <keescook@chromium.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	John Crispin <john@phrozen.org>
Subject: [PATCH 2/2] ARM: decompressor: add option to ignore MEM ATAGs
Date: Fri, 19 Jan 2024 21:12:45 +0100
Message-ID: <20240119201356.7903-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119201356.7903-1-ansuelsmth@gmail.com>
References: <20240119201356.7903-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some bootloaders can pass broken MEM ATAGs that provide hardcoded
information about mounted RAM size and physical location.
Example booloader provide RAM of size 1.7Gb but actual mounted RAM
size is 512Mb causing kernel panic.

Add option CONFIG_ARM_ATAG_DTB_COMPAT_IGNORE_MEM to ignore these ATAG
and not augument appended DTB memory node.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/Kconfig                        | 12 ++++++++++++
 arch/arm/boot/compressed/atags_to_fdt.c | 10 ++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b2ab8db63c4b..6bb5c6b28106 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1549,6 +1549,18 @@ config ARM_ATAG_DTB_COMPAT
 	  bootloaders, this option allows zImage to extract the information
 	  from the ATAG list and store it at run time into the appended DTB.
 
+config ARM_ATAG_DTB_COMPAT_IGNORE_MEM
+	bool "Ignore MEM ATAG information from bootloader"
+	depends on ARM_ATAG_DTB_COMPAT
+	help
+	  Some bootloaders can pass broken MEM ATAGs that provide hardcoded
+	  information about mounted RAM size and physical location.
+	  Example booloader provide RAM of size 1.7Gb but actual mounted RAM
+	  size is 512Mb causing kernel panic.
+
+	  Enable this option if MEM ATAGs should be ignored and the memory
+	  node in the appended DTB should NOT be augumented.
+
 choice
 	prompt "Kernel command line type" if ARM_ATAG_DTB_COMPAT
 	default ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER
diff --git a/arch/arm/boot/compressed/atags_to_fdt.c b/arch/arm/boot/compressed/atags_to_fdt.c
index 627752f18661..189db9fc7fea 100644
--- a/arch/arm/boot/compressed/atags_to_fdt.c
+++ b/arch/arm/boot/compressed/atags_to_fdt.c
@@ -10,6 +10,12 @@
 #define do_extend_cmdline 0
 #endif
 
+#if defined(CONFIG_ARM_ATAG_DTB_COMPAT_IGNORE_MEM)
+#define do_ignore_mem 1
+#else
+#define do_ignore_mem 0
+#endif
+
 #define NR_BANKS 16
 
 static int node_offset(void *fdt, const char *node_path)
@@ -170,6 +176,10 @@ int atags_to_fdt(void *atag_list, void *fdt, int total_space)
 				setprop_string(fdt, "/chosen", "bootargs",
 					       atag->u.cmdline.cmdline);
 		} else if (atag->hdr.tag == ATAG_MEM) {
+			/* Bootloader MEM ATAG are broken and should be ignored */
+			if (do_ignore_mem)
+				continue;
+
 			if (memcount >= sizeof(mem_reg_property)/4)
 				continue;
 			if (!atag->u.mem.size)
-- 
2.43.0


