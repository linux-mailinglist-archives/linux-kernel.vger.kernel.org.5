Return-Path: <linux-kernel+bounces-85144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0066C86B116
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC54288C99
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F74315697B;
	Wed, 28 Feb 2024 14:00:24 +0000 (UTC)
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C557D14F9FA
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709128823; cv=none; b=FNPHT+pIwEpEUT2930Et9dFUufl2HMx5cBDpHkLLMQO8ovXl5Qh4fAFipO+LIIozTwYRwftZAeXmBZEmi/YB+Q7Er9hvxPit012Z89IYoVUrgc6sQ1RsbnN3oIV/g0kDy5b1W7OiWICmWa2Ny0S0UFjpyzM7Gh5ZNuGuhqzU+Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709128823; c=relaxed/simple;
	bh=4RDX7e5uLT6BzbyOJ79PymaRYtEzEpblMVdATSHcbSo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P8DiFeVMYAhjbkXSOZsklm895eoiJBCfKwDIVb+6cKK3WqMzlfRKkNHd5XXcI3cB7M7vliXhhaWAlF+mrYMDAhC4gsPIxYhvyvR2WsO9LbDZ905wHa/omKDFOu10e7eS5E5WCqOxvwJ9eACTYjihvtyVV+1FZJwI+79xZnxt4Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:48c4:26a9:d9ec:22cb])
	by laurent.telenet-ops.be with bizsmtp
	id se072B0024gWvPH01e07C9; Wed, 28 Feb 2024 15:00:13 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rfKTV-001tZB-DQ;
	Wed, 28 Feb 2024 15:00:07 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rfKTe-006hlC-T9;
	Wed, 28 Feb 2024 15:00:06 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Chris Down <chris@chrisdown.name>,
	Petr Mladek <pmladek@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jessica Yu <jeyu@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jason Baron <jbaron@akamai.com>,
	Jim Cromie <jim.cromie@gmail.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubli@redhat.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/4] dev_printk: Add and use dev_no_printk()
Date: Wed, 28 Feb 2024 15:00:03 +0100
Message-Id: <8583d54f1687c801c6cda8edddf2cf0344c6e883.1709127473.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1709127473.git.geert+renesas@glider.be>
References: <cover.1709127473.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When printk-indexing is enabled, each dev_printk() invocation emits a
pi_entry structure.  This is even true when the dev_printk() is
protected by an always-false check, as is typically the case for debug
messages: while the actual code to print the message is optimized out by
the compiler, the pi_entry structure is still emitted.

Avoid emitting pi_entry structures for unavailable dev_printk() kernel
messages by:
  1. Introducing a dev_no_printk() helper, mimicked after the existing
     no_printk() helper, which calls _dev_printk() instead of
     dev_printk(),
  2. Replacing all "if (0) dev_printk(...)" constructs by calls to the
     new helper.

This reduces the size of an arm64 defconfig kernel with
CONFIG_PRINTK_INDEX=y by 957 KiB.

Fixes: ad7d61f159db7397 ("printk: index: Add indexing support to dev_printk")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/linux/dev_printk.h | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/include/linux/dev_printk.h b/include/linux/dev_printk.h
index 6bfe70decc9fb3bc..ae80a303c216be55 100644
--- a/include/linux/dev_printk.h
+++ b/include/linux/dev_printk.h
@@ -129,6 +129,16 @@ void _dev_info(const struct device *dev, const char *fmt, ...)
 		_dev_printk(level, dev, fmt, ##__VA_ARGS__);		\
 	})
 
+/*
+ * Dummy dev_printk for disabled debugging statements to use whilst maintaining
+ * gcc's format checking.
+ */
+#define dev_no_printk(level, dev, fmt, ...)				\
+	({								\
+		if (0)							\
+			_dev_printk(level, dev, fmt, ##__VA_ARGS__);	\
+	})
+
 /*
  * #defines for all the dev_<level> macros to prefix with whatever
  * possible use of #define dev_fmt(fmt) ...
@@ -158,10 +168,7 @@ void _dev_info(const struct device *dev, const char *fmt, ...)
 	dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__)
 #else
 #define dev_dbg(dev, fmt, ...)						\
-({									\
-	if (0)								\
-		dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
-})
+	dev_no_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__)
 #endif
 
 #ifdef CONFIG_PRINTK
@@ -247,20 +254,14 @@ do {									\
 } while (0)
 #else
 #define dev_dbg_ratelimited(dev, fmt, ...)				\
-do {									\
-	if (0)								\
-		dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
-} while (0)
+	dev_no_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__)
 #endif
 
 #ifdef VERBOSE_DEBUG
 #define dev_vdbg	dev_dbg
 #else
 #define dev_vdbg(dev, fmt, ...)						\
-({									\
-	if (0)								\
-		dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
-})
+	dev_no_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__)
 #endif
 
 /*
-- 
2.34.1


