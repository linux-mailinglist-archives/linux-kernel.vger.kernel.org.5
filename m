Return-Path: <linux-kernel+bounces-70438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3452D8597BA
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 17:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD14EB20EE1
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 16:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844186D1C6;
	Sun, 18 Feb 2024 16:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="JHaOFZbA"
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E886D1BE
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 16:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708272830; cv=none; b=k845zrWG7Q8UHz4a4vUGG1YKTlk9mZsaw4BEXyzPSZuhef3QVhOdpNlpmTE5MyeVFFzsJmK+QeCNVIIAhTNF47Wql9NxrH/8hZYQT1HZJPGLw4eJUp7+PV1JlE/9hJ62OuvHtwsiQuomElrUkNcU4Y0GDPjTzVovLZDd0uLSlBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708272830; c=relaxed/simple;
	bh=bbVXN7nFPxD2+8T/Qp3xY6pFsgPWqO0g3GtqcUTohS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SLtOjaCZfvf9wLlMfpjwjNhr38t6O4EpkF/0cAd40vAvfBEojEZdApD5wUlqM0i3Nz9Vnk188x9yI5Nx3M+VYAv5UZP/78ztafZwm4VODL19gsbJYmZc15OPeoGEBBpz9uV2QqSKmK8bNYi7j/+zlScjS/5sncnC9z1h7HV060k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=JHaOFZbA; arc=none smtp.client-ip=80.12.242.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id bjmLrpU1LVqNHbjmLrVuBk; Sun, 18 Feb 2024 17:12:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1708272754;
	bh=yP76YXZufoYcbf/1hIaf1uWL8S4sDWOfmF4KUI6YdvU=;
	h=From:To:Cc:Subject:Date;
	b=JHaOFZbAvu0zG1EvsB/x423fdxAWjYdx+Flpo+0ruoCfh8f0EnbAsRDDWzio52hMD
	 gqImRib0PIjw31bAQaABDabNQjHimRkR1HYvo1VOtSQkqpSHWXo7t9sFmscYKOBZP5
	 9mtdG71zMCFgwKWJEj687d9tdx4+uqqidiCAa0SCrczJ8e9oI+gVPA/zQTg9XGfU64
	 bTOlvP3vYm3zvCE3LqOCH1LLeYL+Wh8iZXftj8dNT+YUQO36EHtMhGMGFgQeaOZ6w7
	 MmQClqXECsTRopQXvfGmb4gNNJM5d4g8Lr4eBtD2GFzTxL9YCvMpDEcSxWfksBW3V4
	 e7Z5HvIfNy0GQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 18 Feb 2024 17:12:34 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	Brian Foster <bfoster@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-bcachefs@vger.kernel.org
Subject: [PATCH v2] bcachefs: Avoid a potential useless over memory allocation in bch2_prt_[v]printf()
Date: Sun, 18 Feb 2024 17:12:28 +0100
Message-ID: <4c614db674887346ea418acaeafd6bf86502ec77.1708272713.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

2 issues related to incorrect available space in the output buffer
computation may lead to some extra memory allocation.


First: vsnprintf() takes the size of the buffer, *including* the space for
the trailing null.

But printbuf_remaining() returns the number of characters we can print
to the output buffer, *excluding* the terminating null.

So, use printbuf_remaining_size(), which includes the space for the
terminating null.


Second: if the return value of vsnprintf() is greater than or equal to the
passed size, the resulting string is truncated.
So, in order to see if some extra space is needed, the check needs to be
changed.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Un-tested

v2: - Use printbuf_remaining_size() instead of hand-writing it.  [Brian Foster]
    - Reword the commit log, hoping it is clearer.
    - Synch with -next-20240215

v1: https://lore.kernel.org/all/0f40108bed3e084057223bdbe32c4b37f8500ff3.1694845203.git.christophe.jaillet@wanadoo.fr/
---
 fs/bcachefs/printbuf.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/bcachefs/printbuf.c b/fs/bcachefs/printbuf.c
index b27d22925929..8cee9c2f88c4 100644
--- a/fs/bcachefs/printbuf.c
+++ b/fs/bcachefs/printbuf.c
@@ -55,9 +55,10 @@ void bch2_prt_vprintf(struct printbuf *out, const char *fmt, va_list args)
 		va_list args2;
 
 		va_copy(args2, args);
-		len = vsnprintf(out->buf + out->pos, printbuf_remaining(out), fmt, args2);
+		len = vsnprintf(out->buf + out->pos, printbuf_remaining_size(out),
+				fmt, args2);
 		va_end(args2);
-	} while (len + 1 >= printbuf_remaining(out) &&
+	} while (len >= printbuf_remaining_size(out) &&
 		 !bch2_printbuf_make_room(out, len + 1));
 
 	len = min_t(size_t, len,
@@ -72,9 +73,10 @@ void bch2_prt_printf(struct printbuf *out, const char *fmt, ...)
 
 	do {
 		va_start(args, fmt);
-		len = vsnprintf(out->buf + out->pos, printbuf_remaining(out), fmt, args);
+		len = vsnprintf(out->buf + out->pos, printbuf_remaining_size(out),
+				fmt, args);
 		va_end(args);
-	} while (len + 1 >= printbuf_remaining(out) &&
+	} while (len >= printbuf_remaining_size(out) &&
 		 !bch2_printbuf_make_room(out, len + 1));
 
 	len = min_t(size_t, len,
-- 
2.43.2


