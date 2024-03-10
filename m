Return-Path: <linux-kernel+bounces-98261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCEA877797
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 17:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F79D281B82
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 16:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E00838F94;
	Sun, 10 Mar 2024 16:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="qficNoLl"
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4A9376E4
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 16:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710087661; cv=none; b=QMBFwIpA+ZEjsCTD5R97XEGVJjfSODiWjU7Wj426iYL19bpjbn1yNprf7K6nqzDMMfSXZi/ox9S+WCt8E9H3wTXS6VioQgKtcpI0LKt1V9SpNFFrTEq9fANAWBuLMhmzBPMw5Bq3ea3IShbOURZr2dL5lXFMlrZ8Z0ep03QhcbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710087661; c=relaxed/simple;
	bh=H/ERMdxRZgif1YJjlln1siCzO3C4zNY/tYb9SV+i2iA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hu7UsWAf/SOwX1LyqbwLWoQYSYcQ5+XLgsQQ2uQ+eorsUQqtxkJzzUMan7vGZe5OFTosw28wC4ns/sR36tOjVn6wYAf3rPZdJAZOuDQcLzEF3l94kDGZSAZuFYswYzZsamgIkuulgA10Gx4tVUcrZXqUJyZtmY/lkptjcDJIh4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=qficNoLl; arc=none smtp.client-ip=80.12.242.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id jLttrAANWxtdHjLttr6yeJ; Sun, 10 Mar 2024 17:19:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1710087590;
	bh=rXUTIQg24bJuU6dk3QojcqSr+hAPwOurGASti1sp4RU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=qficNoLlTmRbC98KhpXz+06bJl9S27dmuS7XfY7h1metUQ4MceNL+uNpnNZWcG9qh
	 q/rHPjrRbOHfy/ncsfrwXdbslrSt3OJfUrHrMQMmlibMRiDQO55/L4k4tum5G5/iCw
	 zWWi72iaKXlA3pR1PCROofbT5RGAI0k9T8YJmD6s1a6q+Pgo9MiiL/yGwlxA1VKsLM
	 nuk+Q8lBlSGrAmftbRp45/n0z340Bszj73CfPpmrafbQ8+DR9ejt0jvu/TlQ2hw31e
	 CkwjU/Vt/1Il8+mA66GMTU5TMysUOYV/7BBag1AKh/hH+ULrUzGVWKh9bn251XXjRA
	 /mPgFgWV+vm3g==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 10 Mar 2024 17:19:50 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Minas Harutyunyan <hminas@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-usb@vger.kernel.org
Subject: [PATCH] usb: dwc2: Remove cat_printf()
Date: Sun, 10 Mar 2024 17:19:44 +0100
Message-ID: <abf3d0361ea291468d121062207a766b0c3228f2.1710087556.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cat_printf() implements the newly introduced seq_buf API.
Use the latter to save some line of code.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only, with DWC2_PRINT_SCHEDULE defined.
---
 drivers/usb/dwc2/hcd_queue.c | 52 ++++++------------------------------
 1 file changed, 8 insertions(+), 44 deletions(-)

diff --git a/drivers/usb/dwc2/hcd_queue.c b/drivers/usb/dwc2/hcd_queue.c
index 0d4495c6b9f7..238c6fd50e75 100644
--- a/drivers/usb/dwc2/hcd_queue.c
+++ b/drivers/usb/dwc2/hcd_queue.c
@@ -16,6 +16,7 @@
 #include <linux/interrupt.h>
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
+#include <linux/seq_buf.h>
 #include <linux/slab.h>
 #include <linux/usb.h>
 
@@ -359,41 +360,6 @@ static unsigned long *dwc2_get_ls_map(struct dwc2_hsotg *hsotg,
 }
 
 #ifdef DWC2_PRINT_SCHEDULE
-/*
- * cat_printf() - A printf() + strcat() helper
- *
- * This is useful for concatenating a bunch of strings where each string is
- * constructed using printf.
- *
- * @buf:   The destination buffer; will be updated to point after the printed
- *         data.
- * @size:  The number of bytes in the buffer (includes space for '\0').
- * @fmt:   The format for printf.
- * @...:   The args for printf.
- */
-static __printf(3, 4)
-void cat_printf(char **buf, size_t *size, const char *fmt, ...)
-{
-	va_list args;
-	int i;
-
-	if (*size == 0)
-		return;
-
-	va_start(args, fmt);
-	i = vsnprintf(*buf, *size, fmt, args);
-	va_end(args);
-
-	if (i >= *size) {
-		(*buf)[*size - 1] = '\0';
-		*buf += *size;
-		*size = 0;
-	} else {
-		*buf += i;
-		*size -= i;
-	}
-}
-
 /*
  * pmap_print() - Print the given periodic map
  *
@@ -416,9 +382,7 @@ static void pmap_print(unsigned long *map, int bits_per_period,
 	int period;
 
 	for (period = 0; period < periods_in_map; period++) {
-		char tmp[64];
-		char *buf = tmp;
-		size_t buf_size = sizeof(tmp);
+		DECLARE_SEQ_BUF(buf, 64);
 		int period_start = period * bits_per_period;
 		int period_end = period_start + bits_per_period;
 		int start = 0;
@@ -442,19 +406,19 @@ static void pmap_print(unsigned long *map, int bits_per_period,
 				continue;
 
 			if (!printed)
-				cat_printf(&buf, &buf_size, "%s %d: ",
-					   period_name, period);
+				seq_buf_printf(&buf, "%s %d: ",
+					       period_name, period);
 			else
-				cat_printf(&buf, &buf_size, ", ");
+				seq_buf_puts(&buf, ", ");
 			printed = true;
 
-			cat_printf(&buf, &buf_size, "%d %s -%3d %s", start,
-				   units, start + count - 1, units);
+			seq_buf_printf(&buf, "%d %s -%3d %s", start,
+				       units, start + count - 1, units);
 			count = 0;
 		}
 
 		if (printed)
-			print_fn(tmp, print_data);
+			print_fn(seq_buf_str(&buf), print_data);
 	}
 }
 
-- 
2.44.0


