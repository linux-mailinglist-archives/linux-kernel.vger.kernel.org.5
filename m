Return-Path: <linux-kernel+bounces-32812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABA483606A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DDAA1C22DEF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2252C3B789;
	Mon, 22 Jan 2024 11:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+uC6NJs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677A23B2BD;
	Mon, 22 Jan 2024 11:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921455; cv=none; b=CXXWLQFlkL9PaKTW0glNeUjZ5G2GNlYFAFNdXBqYWxXV8N1gm9zGzLHesVSMXbG5unEJ1QSt4dzmOibQzOPaYA0nKMHE8dd/sPitSjpirXvKVfl1L0P5OjydUomZoQON/VZBDn2vsmB2i09VrCJ4ex0J7MjlXdFSqqlHzHHP2Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921455; c=relaxed/simple;
	bh=rUROH6mYOVI5bovPWhIiic94alNwwSPkZdh64JHmGT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VWAFr3nVW0uhr9g6bGCdRqrDTKAhhrvUpKjKWFHuW0y4lLOB6RfhWMTZxq2CarObVfFst7Vfb1Zm70+M/AeBGlQ+8UUFubQ8PuGGwSSAUUe/Ot785bVO2p1Smds5TTrHOZAND56ap8hi6nS4c6DytdlaLVc0MVvirM7PHeRXqAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+uC6NJs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C369C433B1;
	Mon, 22 Jan 2024 11:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705921455;
	bh=rUROH6mYOVI5bovPWhIiic94alNwwSPkZdh64JHmGT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e+uC6NJszMS7X5ljJjXGjtSh5O7JlDZRB5HmN2rgIzPrJLWVIxO989g0oRbWP4iLO
	 p4OaHoKSjtgEUcQEvS4IurL24juBUtfIGldPAH1JriPWe3yF02KgL9CyGRicNj7NFB
	 Avkj9AX9vIiksWxfFG9wEiGI07P3N/FHMyYDNIM4rH+GB3X8ojQQGHWj1RD3HW4HKn
	 eFclKXRp7//TjjGF7ATlmAXV1xJhiLscWKgeYRdr6fT9IoV7zhRDfonggfJslY9jn9
	 UH/ExgdUBmf3ag52xP2tb87r6G8uH8nYq7rWUeurr3GfbSNaAOXxgume+1ykYaFbUJ
	 yyB2etiJgbyHA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 04/47] tty: vt: expect valid vc when in tty ops
Date: Mon, 22 Jan 2024 12:03:18 +0100
Message-ID: <20240122110401.7289-5-jirislaby@kernel.org>
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

At least since commits feebed6515a1 ("tty: shutdown method") and
bc1e99d93f09 ("TTY: vt, add ->install"), tty->driver_data in vc is
expected to be set since tty_operations::install() till ::cleanup().

So the checks of !tty->driver_data (aka !vc) in:
* vc_do_resize() by tty -> ioctl(TIOCSWINSZ) -> vt_resize()
* do_con_write() by tty -> tty_operations::write()/::put_char()
* con_flush_chars() by tty -> ::flush_chars()
are all superfluous. And also, holding a console lock is not needed to
fetch tty->driver_data.

Note there is even a stale comment in con_flush_chars() about a race
between that and con_close(). But con_close() does not set
tty->driver_data to NULL for years already.

Drop all these in a hope I am not terribly mistaken.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 55ce6cdecbca..e131edea00da 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1154,9 +1154,6 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
 
 	WARN_CONSOLE_UNLOCKED();
 
-	if (!vc)
-		return -ENXIO;
-
 	user = vc->vc_resize_user;
 	vc->vc_resize_user = 0;
 
@@ -2852,7 +2849,7 @@ static int do_con_write(struct tty_struct *tty, const u8 *buf, int count)
 	};
 	int c, tc, n = 0;
 	unsigned int currcons;
-	struct vc_data *vc;
+	struct vc_data *vc = tty->driver_data;
 	struct vt_notifier_param param;
 	bool rescan;
 
@@ -2860,13 +2857,6 @@ static int do_con_write(struct tty_struct *tty, const u8 *buf, int count)
 		return count;
 
 	console_lock();
-	vc = tty->driver_data;
-	if (vc == NULL) {
-		pr_err("vt: argh, driver_data is NULL !\n");
-		console_unlock();
-		return 0;
-	}
-
 	currcons = vc->vc_num;
 	if (!vc_cons_allocated(currcons)) {
 		/* could this happen? */
@@ -3312,16 +3302,13 @@ static void con_start(struct tty_struct *tty)
 
 static void con_flush_chars(struct tty_struct *tty)
 {
-	struct vc_data *vc;
+	struct vc_data *vc = tty->driver_data;
 
 	if (in_interrupt())	/* from flush_to_ldisc */
 		return;
 
-	/* if we race with con_close(), vt may be null */
 	console_lock();
-	vc = tty->driver_data;
-	if (vc)
-		set_cursor(vc);
+	set_cursor(vc);
 	console_unlock();
 }
 
-- 
2.43.0


