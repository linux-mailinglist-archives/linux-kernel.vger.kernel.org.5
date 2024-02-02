Return-Path: <linux-kernel+bounces-49511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E07846B50
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AD2128F69E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A61604DD;
	Fri,  2 Feb 2024 08:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="U8UqnvCa"
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F2255769;
	Fri,  2 Feb 2024 08:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706864119; cv=none; b=iB3++85hc7PT0F8tfH6TBLD7Yp+iS4iZ/GNy2CUm2qAgpM+RMX3rMsStv9cuzl4ML8dWD8rYB4J4vEk1K8/jhozjBJjZY+FUuoXb+/g+SnTfyngOG6pYVMx/gVg6Ws1pGdNWKWdovZjJ/TlBlEICY8m1y9udYCHRXCeat4b1qoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706864119; c=relaxed/simple;
	bh=CV4GH9UNJ6zNQc6c5xVZP+xrV8bnxAF5VgMaNZ9XGwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ukCJcIYnab3qnEVvJ8ShOozgtqc2gQr/egoYQDRjXAgvfUfBkmuoxMmYSXsLWbT9I2FSpUCAbEe4nHT/Qume+NZiHFU6GoBoxwHzR6b4FsMz5MM85MNYrsBZuccNxuOJgAXNZk0VcNM2PO/3Nyw9o4nYgk94GdvmmpRWk4k4PUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=U8UqnvCa; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from dragon.fritz.box (unknown [58.7.187.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 7D1AE419B1;
	Fri,  2 Feb 2024 08:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1706864103;
	bh=qrYMi74bcCPFGEWKyxCuYJeZThHsF8LjYHDib4wabmI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=U8UqnvCaViIiodS5APZKF6sQKAIa+eUT41hLsslejEPofW6tCDRsG1EpMjQNNoV8D
	 gsF7wGHgRw9/nzbp7L6LgHPPBpO7ATs09FYRGDlvQzUsmhsXC3elrRUp8VmTqpK96v
	 ZhBmbzoUoX0vnfeLN0fFUfIXvdu5G6nQMOgV7XPYeGsH/aJF9JYVdRrQ7sVnRjS9eB
	 OzjTI518N7YaFJZ9ES+93o8PvNHBaNnPHXJMcxAS+mDZSwhDrb+q81zuLOGFhPGyeG
	 DJR+O/EJt2v4qhV4d8bnMN54j13/tGUJQwmj/i1gH6GQUp/4h6Q+t7CQrlvk1EDLGw
	 2WQdXXsVRtqcA==
From: Daniel van Vugt <daniel.van.vugt@canonical.com>
To: 
Cc: Daniel van Vugt <daniel.van.vugt@canonical.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dummycon: Add dummycon_(un)register_switch_notifier
Date: Fri,  2 Feb 2024 16:53:54 +0800
Message-ID: <20240202085408.23251-1-daniel.van.vugt@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To detect switch attempts before a real console exists. This will be
used for the same purpose as dummycon_(un)register_output_notifier,
for fbcon to detect a more polite time to take over.

Signed-off-by: Daniel van Vugt <daniel.van.vugt@canonical.com>
---
 drivers/video/console/dummycon.c | 35 +++++++++++++++++++++++++++-----
 include/linux/console.h          |  2 ++
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/video/console/dummycon.c b/drivers/video/console/dummycon.c
index 14af5d9e13..55e9b600ce 100644
--- a/drivers/video/console/dummycon.c
+++ b/drivers/video/console/dummycon.c
@@ -83,6 +83,32 @@ static int dummycon_blank(struct vc_data *vc, int blank, int mode_switch)
 	/* Redraw, so that we get putc(s) for output done while blanked */
 	return 1;
 }
+
+/* This is protected by the console_lock */
+static RAW_NOTIFIER_HEAD(dummycon_switch_nh);
+
+void dummycon_register_switch_notifier(struct notifier_block *nb)
+{
+	WARN_CONSOLE_UNLOCKED();
+
+	raw_notifier_chain_register(&dummycon_switch_nh, nb);
+}
+
+void dummycon_unregister_switch_notifier(struct notifier_block *nb)
+{
+	WARN_CONSOLE_UNLOCKED();
+
+	raw_notifier_chain_unregister(&dummycon_switch_nh, nb);
+}
+
+static int dummycon_switch(struct vc_data *vc)
+{
+	WARN_CONSOLE_UNLOCKED();
+
+	raw_notifier_call_chain(&dummycon_switch_nh, 0, vc);
+
+	return 0;
+}
 #else
 static void dummycon_putc(struct vc_data *vc, int c, int ypos, int xpos) { }
 static void dummycon_putcs(struct vc_data *vc, const unsigned short *s,
@@ -91,6 +117,10 @@ static int dummycon_blank(struct vc_data *vc, int blank, int mode_switch)
 {
 	return 0;
 }
+static int dummycon_switch(struct vc_data *vc)
+{
+	return 0;
+}
 #endif
 
 static const char *dummycon_startup(void)
@@ -120,11 +150,6 @@ static bool dummycon_scroll(struct vc_data *vc, unsigned int top,
 	return false;
 }
 
-static int dummycon_switch(struct vc_data *vc)
-{
-	return 0;
-}
-
 /*
  *  The console `switch' structure for the dummy console
  *
diff --git a/include/linux/console.h b/include/linux/console.h
index 779d388af8..8fd70ae623 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -531,5 +531,7 @@ extern void console_init(void);
 /* For deferred console takeover */
 void dummycon_register_output_notifier(struct notifier_block *nb);
 void dummycon_unregister_output_notifier(struct notifier_block *nb);
+void dummycon_register_switch_notifier(struct notifier_block *nb);
+void dummycon_unregister_switch_notifier(struct notifier_block *nb);
 
 #endif /* _LINUX_CONSOLE_H */
-- 
2.43.0


