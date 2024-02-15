Return-Path: <linux-kernel+bounces-67706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F3D856F73
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C1A61F22747
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C801420D3;
	Thu, 15 Feb 2024 21:38:10 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E35513EFE5
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 21:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708033090; cv=none; b=ce6B5Jp1QgJl0w8d23SZrqaJkm4TLdPlsJR+CYJ9uD4E+2NH77KP5mIbvK3ijZ1RX9VAXu85KUx5JmrVxUgxm7SYF9TDyQkkQR6EciqbTShNb7/vH4OF3aIBy2sRfnwtQ8HxJB8uzd1A7OpFIuNGKNVwb6znMNJAtRIWgn2gTMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708033090; c=relaxed/simple;
	bh=j9clN+6FLqBEVM98VPdidI4cfFXyGBOIbUyOq31qKj8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=eo2OAdXpdxEMBNTO9lHvM1MA3PRMNbA6n+p/+cV86a9r3BeCOmdAdAMAtxpI/6OPuJAgVsobnYpw6cT8ka3lcM9KXmYruxGpMEMwv1FVREW/2+UW6kgaT0bULqvCtICv85vobxD3aAh5vg61ekdj7ndmEdPlGR51RQxHmRrygdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC7EC433B2;
	Thu, 15 Feb 2024 21:38:10 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rajSK-00000000eeW-45ky;
	Thu, 15 Feb 2024 16:39:44 -0500
Message-ID: <20240215213944.834660013@goodmis.org>
User-Agent: quilt/0.67
Date: Thu, 15 Feb 2024 16:39:19 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [for-linus][PATCH 3/4] seq_buf: Dont use "proxy" headers
References: <20240215213916.385127578@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Update header inclusions to follow IWYU (Include What You Use)
principle.

Link: https://lkml.kernel.org/r/20240215142255.400264-1-andriy.shevchenko@linux.intel.com

Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/seq_buf.h |  5 ++++-
 lib/seq_buf.c           | 14 ++++++++++++--
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
index c44f4b47b945..07b26e751060 100644
--- a/include/linux/seq_buf.h
+++ b/include/linux/seq_buf.h
@@ -2,7 +2,10 @@
 #ifndef _LINUX_SEQ_BUF_H
 #define _LINUX_SEQ_BUF_H
 
-#include <linux/fs.h>
+#include <linux/bug.h>
+#include <linux/minmax.h>
+#include <linux/seq_file.h>
+#include <linux/types.h>
 
 /*
  * Trace sequences are used to allow a function to call several other functions
diff --git a/lib/seq_buf.c b/lib/seq_buf.c
index 010c730ca7fc..dfbfdc497d85 100644
--- a/lib/seq_buf.c
+++ b/lib/seq_buf.c
@@ -13,9 +13,19 @@
  * seq_buf_init() more than once to reset the seq_buf to start
  * from scratch.
  */
-#include <linux/uaccess.h>
-#include <linux/seq_file.h>
+
+#include <linux/bug.h>
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/hex.h>
+#include <linux/minmax.h>
+#include <linux/printk.h>
 #include <linux/seq_buf.h>
+#include <linux/seq_file.h>
+#include <linux/sprintf.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
 
 /**
  * seq_buf_can_fit - can the new data fit in the current buffer?
-- 
2.43.0



