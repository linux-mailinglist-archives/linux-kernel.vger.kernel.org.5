Return-Path: <linux-kernel+bounces-70986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 923F6859F0A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EAA6281CF4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099B92232C;
	Mon, 19 Feb 2024 09:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Al4oZOn0"
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2431CD1F;
	Mon, 19 Feb 2024 09:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708333392; cv=none; b=Z4dOK8WnZ39wFZyUvARSZ6+TWq2UML2akWhtDyxDY6INIv0iG7tacYruune7MISmepW4cJqniNS5N0oyVIS6yfDdf/cl6oZPkNbwnWmFXJ2wKGiZ99Ay7+7IzpGDtuOySLvlPKVJgCEF+Hkpaoc/ha0T2pTJZeQynvN2mn5VqIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708333392; c=relaxed/simple;
	bh=CV4GH9UNJ6zNQc6c5xVZP+xrV8bnxAF5VgMaNZ9XGwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ErjP29qPeCIAT4yaF5t2D6yd7hcxHTc9pzQvrbYZrfyoEoqwloH3EpDiUGbcDPX10WlfY6QzgJSV/TNYVfpf+qmnIBpicj3QuswNvaBQOIptj7EJYroCK5heuDKGljvPJSLg5bzaxjKZAqTaLQRoqd02LTIc2GnGQwZB8crTpJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Al4oZOn0; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from dragon.fritz.box (unknown [58.7.187.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 51F753FFCB;
	Mon, 19 Feb 2024 09:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1708333382;
	bh=qrYMi74bcCPFGEWKyxCuYJeZThHsF8LjYHDib4wabmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=Al4oZOn0ScbIR3AVLorfwEDF/5CS85wWgFVY3g4D7ozov/IfnGT0akRSxUmy80iY8
	 AIGO2ImJUtycicQQ0NWjANNxfA25Aez0V0SFYMzYJekRQjRpEYLofpXccbzv+Xnehq
	 QRNVg9DeYX4WuNl7vJwzrOOEvvliQm/9X+0PaoI62CfumZv8aNBj/7fjxHkhBi7v4h
	 iOYalDVjncZyQUSlH3vF9kqqiMbEnqQh/ZCh2WVt4YKCjutmP2Ah4Z2mI4o1XNpM25
	 sRQJYuxePHHme5hXF6zzuDeUo8Nsnmk4smFnYeFaElHDGZrfEdKAENnrJfD4mGrL5r
	 rLL8F6ja+Lccg==
From: Daniel van Vugt <daniel.van.vugt@canonical.com>
To: 
Cc: Daniel van Vugt <daniel.van.vugt@canonical.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] dummycon: Add dummycon_(un)register_switch_notifier
Date: Mon, 19 Feb 2024 17:02:33 +0800
Message-ID: <20240219090239.22568-1-daniel.van.vugt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <bb8d631d-9f6c-48e8-a504-8931ee21014d@amd.com>
References: <bb8d631d-9f6c-48e8-a504-8931ee21014d@amd.com>
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


