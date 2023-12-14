Return-Path: <linux-kernel+bounces-149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 410C7813CD6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73E8E1C21D1C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5FF6F60B;
	Thu, 14 Dec 2023 21:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qFYyVTuH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BsC4fnb9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ED06E2BF
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 21:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702590126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=krH2QkxdJALvXRu9Bq+Fw3gs7PqsPIKkUheQqZKkVK0=;
	b=qFYyVTuHxgTC9QlqyN1QHK4WWfE+6QS+rbWzDp1kBMoZyEwL1jBrlUDxSBt83RF2jSKdlA
	7yg9jBlzbenZo7mLyIr1X94I8l71A4kFMrVWwjuSQoVBE7UUdKn5C7q72xIHkRcsFipQ1p
	SUC0G6X64Ls7EHDGpIWHfWB2FOQ4Y+3YGhF9ezaXMQ0Oqy5tWZvSH7It2NZGDZ3mSbWHsA
	bGA5qd3r5PI28RTsZ/NPKam9jm18sp7LTL7YQtn8bR0womOuLsioiX3v5r8+F46kqNG0k9
	DZYZqLCVOQzeq/o8a5LqDMlwuya6GYVe5l16p+R+mZSbncMtq82KHSTWy6JS4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702590126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=krH2QkxdJALvXRu9Bq+Fw3gs7PqsPIKkUheQqZKkVK0=;
	b=BsC4fnb9tj450t5e44z0HhzQgechD4kbG8CjJvyXCEcSe27WZN0mvwHswe3ax+IlcCw2RX
	yGM+a1ZEl7KBdfAA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v3 06/14] printk: For @suppress_panic_printk check for other CPU in panic
Date: Thu, 14 Dec 2023 22:47:53 +0106
Message-Id: <20231214214201.499426-7-john.ogness@linutronix.de>
In-Reply-To: <20231214214201.499426-1-john.ogness@linutronix.de>
References: <20231214214201.499426-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently @suppress_panic_printk is checked along with
non-matching @panic_cpu and current CPU. This works
because @suppress_panic_printk is only set when
panic_in_progress() is true.

Rather than relying on the @suppress_panic_printk semantics,
use the concise helper function other_cpu_in_progress(). The
helper function exists to avoid open coding such tests.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index be95a6851164..22bb45d8f2f2 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2270,8 +2270,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 	if (unlikely(suppress_printk))
 		return 0;
 
-	if (unlikely(suppress_panic_printk) &&
-	    atomic_read(&panic_cpu) != raw_smp_processor_id())
+	if (unlikely(suppress_panic_printk) && other_cpu_in_panic())
 		return 0;
 
 	if (level == LOGLEVEL_SCHED) {
-- 
2.39.2


