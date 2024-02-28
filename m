Return-Path: <linux-kernel+bounces-85156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D814D86B13D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DA821F22E2F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7D8154BE3;
	Wed, 28 Feb 2024 14:05:14 +0000 (UTC)
Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03534145341
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709129113; cv=none; b=IXiCBRUz+gERNynz5Gfd3URB//7bcLnVVACa1XmRxjQCRb129nlMwUlPPBhdV0tIG5mKrB8pHs55lVFXPZFDO5IgQEt9yA26O9LjqdXkIh/+xyKQzlCEPGlbwIe/pT9N9Cw17bbHj9SmnwIgW4464UU0Gzd9nQ+7Fg/rLVcLQ5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709129113; c=relaxed/simple;
	bh=L3K4rtzy6gxBJUGpTTcskVWOegBL2LVnvlohsA27NJs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PfbOzvfpdWWxVqKLNRGuoLnwtUejpb/mQ8Ij37avd850+Dn3YaQEOpHKdO5m6gbX4GcJ+TsmBUZUzG1yi4mBD25BDiY8ubTLL231wnXQQObGLdNAI7Zpt6jWJHdsmDQ10fExjv5bsejsuFb3DCjZcS+zT7cCwpTL8wVliAbyzFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:48c4:26a9:d9ec:22cb])
	by andre.telenet-ops.be with bizsmtp
	id se542B0064gWvPH01e54PF; Wed, 28 Feb 2024 15:05:10 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rfKYI-001tZa-F6;
	Wed, 28 Feb 2024 15:05:04 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rfKYR-006hqA-UZ;
	Wed, 28 Feb 2024 15:05:03 +0100
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
Subject: [PATCH net-next] Simplify net_dbg_ratelimited() dummy
Date: Wed, 28 Feb 2024 15:05:02 +0100
Message-Id: <5d75ce122b5cbfe62b018a7719960e34cfcbb1f2.1709128975.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no need to wrap calls to the no_printk() helper inside an
always-false check, as no_printk() already does that internally.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/linux/net.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/linux/net.h b/include/linux/net.h
index c9b4a63791a45948..15df6d5f27a7badc 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -299,10 +299,7 @@ do {									\
 	net_ratelimited_function(pr_debug, fmt, ##__VA_ARGS__)
 #else
 #define net_dbg_ratelimited(fmt, ...)				\
-	do {							\
-		if (0)						\
-			no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__); \
-	} while (0)
+	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
 #endif
 
 #define net_get_random_once(buf, nbytes)			\
-- 
2.34.1


