Return-Path: <linux-kernel+bounces-32858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53491836102
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 077841F25470
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6253648792;
	Mon, 22 Jan 2024 11:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRbHUgHF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BF948781;
	Mon, 22 Jan 2024 11:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921537; cv=none; b=UPghqrYyT1y11CxPNPY4LgWnthL/uCwKRMdgdBfzT2oK6rIWzQy9kPcnZAaANsIkJeLvrnZa1N5+7ctmz7Szn+6SkP/5c/0EVB3t4rNB6iX7DnVHmgQ1pPUlGnXWULWy54IbM5Zrmp3vf1ADt3V793XdsCV4TsqKcHpw/+qwjAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921537; c=relaxed/simple;
	bh=yElSmtG37qdY1QnV95p5waGPy2ApYIEYWs4uZ+i9NVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZPRNt0g/iASQLVCH/EIKV0CTRf2qbi8XCEwlQPAJ4WQUI78mdZrKvZ5u5l6iRdBx5hzW2cDdCFRa1JmR5FUqCDKMj3obFxBwAKBAmb7LDV3iUtcHchVNw78TBfFLv/tCpp+VOhxZHBySwNMqAx3AOioAvpjIq3CF2Z3PuCsuwu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRbHUgHF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B4DC43394;
	Mon, 22 Jan 2024 11:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705921537;
	bh=yElSmtG37qdY1QnV95p5waGPy2ApYIEYWs4uZ+i9NVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PRbHUgHFzLa480wveIWYQZHKNMyf6XTDxZapcWX2mn56a8MAPNZ5+sZSEJUmauIWM
	 xnpRDgpSDjd46/bbEwl5M++Y3EstSPovezQ6iKQqCCfXjEc7gpCx47KuNGfDHk2tAK
	 z2AMMlRTFV7hcubN2PaBuC/OhyPefNQwHAzj21fE+ZU3MRs/PUl4x5jU7BGV5kLCYb
	 TGAxDPzVKXNOaXFMKJTfa6WgWJYt6mZKapQ5Cpk234e5asrrghldNuJyOnDwZoT4YB
	 CIGk6xBNE2npOpXRN8JIaFRsCtXro5xOt2MGATcpnyaIuAsuU+W0K0yToZNo9DTuqy
	 PehOnF4zjqHPw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 44/47] tty: vt: remove unused consw::con_flush_scrollback()
Date: Mon, 22 Jan 2024 12:03:58 +0100
Message-ID: <20240122110401.7289-45-jirislaby@kernel.org>
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

consw::con_flush_scrollback() is unused since commit 973c096f6a85
(vgacon: remove software scrollback support). Drop it.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c     | 27 ++++++++++++---------------
 include/linux/console.h |  4 ----
 2 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index cbe1a1106d53..bfe51af9a0f3 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -888,21 +888,18 @@ static void flush_scrollback(struct vc_data *vc)
 	WARN_CONSOLE_UNLOCKED();
 
 	set_origin(vc);
-	if (vc->vc_sw->con_flush_scrollback) {
-		vc->vc_sw->con_flush_scrollback(vc);
-	} else if (con_is_visible(vc)) {
-		/*
-		 * When no con_flush_scrollback method is provided then the
-		 * legacy way for flushing the scrollback buffer is to use
-		 * a side effect of the con_switch method. We do it only on
-		 * the foreground console as background consoles have no
-		 * scrollback buffers in that case and we obviously don't
-		 * want to switch to them.
-		 */
-		hide_cursor(vc);
-		vc->vc_sw->con_switch(vc);
-		set_cursor(vc);
-	}
+	if (!con_is_visible(vc))
+		return;
+
+	/*
+	 * The legacy way for flushing the scrollback buffer is to use a side
+	 * effect of the con_switch method. We do it only on the foreground
+	 * console as background consoles have no scrollback buffers in that
+	 * case and we obviously don't want to switch to them.
+	 */
+	hide_cursor(vc);
+	vc->vc_sw->con_switch(vc);
+	set_cursor(vc);
 }
 
 /*
diff --git a/include/linux/console.h b/include/linux/console.h
index fa2cd81102b8..1eac3e6e32a2 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -96,10 +96,6 @@ struct consw {
 			enum vc_intensity intensity,
 			bool blink, bool underline, bool reverse, bool italic);
 	void	(*con_invert_region)(struct vc_data *vc, u16 *p, int count);
-	/*
-	 * Flush the video console driver's scrollback buffer
-	 */
-	void	(*con_flush_scrollback)(struct vc_data *vc);
 	/*
 	 * Prepare the console for the debugger.  This includes, but is not
 	 * limited to, unblanking the console, loading an appropriate
-- 
2.43.0


