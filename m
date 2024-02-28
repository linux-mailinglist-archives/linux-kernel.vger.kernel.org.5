Return-Path: <linux-kernel+bounces-85146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB75E86B119
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7704028AA09
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E621586DC;
	Wed, 28 Feb 2024 14:00:24 +0000 (UTC)
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFCE150994
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709128824; cv=none; b=ShmYrJnJpO9+1iK4zt4AU7ruYBXWRUA0pr+yUrCE4Q4KOT5YhKkyzNNSUplRQMx7xIoycp0HjIAIp0lFJUnrVM6uoNa8NwXjw8eadAY3ojDl2/qOGzIcipoVRz7MkFE+D9WTeVx3xGwSSN3j+9lnIPIzs0RRyj6ToLao1EUdOGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709128824; c=relaxed/simple;
	bh=D8NXY2ItVpwUES37gGIiU5wimOI8cGreVo83CtoNigw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WHMBh1Urbtd+dLmvqp/kF4AEw4I0hzrPSP41v/POv28iDsiQLzl5VWpFV1PxuWvBfDgURpGnp/se24pCFPZddOtiH4JEdORSg2YqnVu7M4TzP2neHlPtZKhyl1YGQeFL7II1YTAaoOlH2AEhcOD2SkrSpaLHMFH71si6Bw3hBjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:48c4:26a9:d9ec:22cb])
	by albert.telenet-ops.be with bizsmtp
	id se072B0044gWvPH06e07Y7; Wed, 28 Feb 2024 15:00:13 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rfKTV-001tZG-EJ;
	Wed, 28 Feb 2024 15:00:07 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rfKTe-006hlI-Vc;
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
Subject: [PATCH 4/4] ceph: Use no_printk() helper
Date: Wed, 28 Feb 2024 15:00:05 +0100
Message-Id: <a21767eccb823435a7f18cdf115d7d572b4e945d.1709127473.git.geert+renesas@glider.be>
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

When printk-indexing is enabled, each printk() invocation emits a
pi_entry structure.  This is even true when the call is protected by an
always-false check: while the actual code to print the message is
optimized out by the compiler, the pi_entry structure is still emitted.

Fix this by replacing "if (0) printk(...)" constructs by calls to the
no_printk() helper.

This reduces the size of an arm64 kernel with CONFIG_PRINTK_INDEX=y and
CONFIG_CEPH_FS=y by ca. 4 KiB.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/linux/ceph/ceph_debug.h | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/include/linux/ceph/ceph_debug.h b/include/linux/ceph/ceph_debug.h
index 11a92a946016eab5..5f904591fa5f9e57 100644
--- a/include/linux/ceph/ceph_debug.h
+++ b/include/linux/ceph/ceph_debug.h
@@ -27,17 +27,13 @@
 		 ##__VA_ARGS__)
 # else
 /* faux printk call just to see any compiler warnings. */
-#  define dout(fmt, ...)	do {				\
-		if (0)						\
-			printk(KERN_DEBUG fmt, ##__VA_ARGS__);	\
-	} while (0)
-#  define doutc(client, fmt, ...)	do {			\
-		if (0)						\
-			printk(KERN_DEBUG "[%pU %llu] " fmt,	\
-			&client->fsid,				\
-			client->monc.auth->global_id,		\
-			##__VA_ARGS__);				\
-		} while (0)
+#  define dout(fmt, ...)					\
+		no_printk(KERN_DEBUG fmt, ##__VA_ARGS__)
+#  define doutc(client, fmt, ...)				\
+		no_printk(KERN_DEBUG "[%pU %llu] " fmt,		\
+			  &client->fsid,			\
+			  client->monc.auth->global_id,		\
+			  ##__VA_ARGS__)
 # endif
 
 #else
-- 
2.34.1


