Return-Path: <linux-kernel+bounces-64754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D91C385426F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2146B1C2401B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 05:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D9510799;
	Wed, 14 Feb 2024 05:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Px90Xudt"
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA833C154;
	Wed, 14 Feb 2024 05:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707888907; cv=none; b=X87kbpZQUDkwYqRIiP7frlAUOMD2bHkWeV9Q+L9xN3ylIEt8l7YONQG896+MjapTFuyetuEiasva12l1fPUj1JF9wTabAO5NNtxO2NFK9Y6f1tGsHHFe/pxouBffbSb3sdVGN558h/qY+zW4je9+diW15nrW7F1mhb6UHaZQ7Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707888907; c=relaxed/simple;
	bh=CV4GH9UNJ6zNQc6c5xVZP+xrV8bnxAF5VgMaNZ9XGwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OuGKsHFYxs/uNiFm/ZJKkPdHa6Qut29pmuB+ze2pV1QT6jeaZMXlIGm+EKAMlq2x/e0xsh8BfFu9AGWCxy6TFW5zpNzczVmw4wVD7UW0NYvxUxk5uYDoj9PFmzqtjop8+ifyu/dswjGSacjtYYqmfFZeWyowwG3tro62E6jL9KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Px90Xudt; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from dragon.fritz.box (unknown [58.7.187.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id BEEC53F70B;
	Wed, 14 Feb 2024 05:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1707888299;
	bh=qrYMi74bcCPFGEWKyxCuYJeZThHsF8LjYHDib4wabmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=Px90XudtIw8G/nXpr3KPL73tUtf47tJt/JZebPKDpRWH2GNiEwP2Mm/CUybeu9o02
	 6IdIslOUhot5rKw49c/cYACmlLe1+BOCbuZtnqzmXPLnCkCLquLfR+I7jQB9chpd4s
	 sd6GaOjN/XO6LYhA2h0BvArMIb5DAnV40hpUOfN60j/hbtyzt6IFJ2pRsu3+ynk3bw
	 OZt7NYKZL9DEFqQNbk2ABRdB0lnR8q0NVcq/VAHimC/1e10E/STh5VjU0305cK5lTW
	 6A2U6xo+um95HDA8VcwCSYs9ajb9oJahvYLVaUpJtMoG3QOyhkkKn6ly9SJFJvhcEl
	 YL39mpzZPKIbw==
From: Daniel van Vugt <daniel.van.vugt@canonical.com>
To: 
Cc: Daniel van Vugt <daniel.van.vugt@canonical.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dummycon: Add dummycon_(un)register_switch_notifier
Date: Wed, 14 Feb 2024 13:24:06 +0800
Message-ID: <20240214052412.22770-1-daniel.van.vugt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <f2c54ff7-d601-49d0-b5ad-9b111d743ded@canonical.com>
References: <f2c54ff7-d601-49d0-b5ad-9b111d743ded@canonical.com>
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


