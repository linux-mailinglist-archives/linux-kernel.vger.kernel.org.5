Return-Path: <linux-kernel+bounces-70987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3108D859F0E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D6561F228CD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869D7224F0;
	Mon, 19 Feb 2024 09:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="iVHcZXmQ"
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BDB22338;
	Mon, 19 Feb 2024 09:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708333412; cv=none; b=WHVOboF8WDquekUXaU4fb1ikL70ZPlEkpp2UwBd0NZzh/CdQQKVV1xPLe2s9yCUKaw0NLjnhMKPydqWK05gkW21F1tTVVdlA3VJhe2pdtCiklQya2NiufHrKmVMGntsbXEw+ZZlhVnVkfz0I1kuN0BN67RJtn2RxB0NzpNviMag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708333412; c=relaxed/simple;
	bh=GPN8Mk6AjKdJprvHnW5OkPBaRiGS9zcym0UU+Uw2+sU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=odiODHZyPv84LwItsb5RdmgcRMLTErxD2HREk4Kbj6CUFERtrr6gsnbJ44iP2PdidE9hcXDh2C7kKfTeFp+gBEisBrnOW9/V7yFSG6wHeIsd0XNBrMhXGrMXIlGxvc+RbaA7H2TZAgkNaOlykEoi7yqpsFszruLrPwGLsZPJzrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=iVHcZXmQ; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from dragon.fritz.box (unknown [58.7.187.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id CE8B23FFCB;
	Mon, 19 Feb 2024 09:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1708333408;
	bh=kQhfdLR3qGyplgiIkg8pJk0Ou4Y1K7ya0QDBpb51jFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=iVHcZXmQo7IsnzjNyp460QrosKoV/xU7lHU7R+KlQqDk17uxXD7TxGTqgKArpvZWg
	 znkJWdPT5Aar1ubS8CqJZuGS0qxispCALk9DIEOsKkeryBpmN+qO62+cWKkRnAgjoX
	 8zXe/tn2lmIiWmtgaPY1t9devOiX5jobe9lL6rAXd5EU/ahXc4jRWZeMGe3+NlC86l
	 xTZriajSGckLS0lZ8ZzwZ5m2UamNlLXywN/+44/o27fCxS2OvKDh9MgqexxhgjfNmM
	 knMfD7nlywRtSmwFKFrvFTWOlY20KLaSCzm8wMLIYXJzj0lGJdwV2TZ49lwIrQXC2A
	 dIrsXGb+HCiCg==
From: Daniel van Vugt <daniel.van.vugt@canonical.com>
To: 
Cc: Daniel van Vugt <daniel.van.vugt@canonical.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Helge Deller <deller@gmx.de>,
	Daniel Vetter <daniel@ffwll.ch>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] fbcon: Defer console takeover for splash screens to first switch
Date: Mon, 19 Feb 2024 17:02:34 +0800
Message-ID: <20240219090239.22568-2-daniel.van.vugt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240219090239.22568-1-daniel.van.vugt@canonical.com>
References: <bb8d631d-9f6c-48e8-a504-8931ee21014d@amd.com>
 <20240219090239.22568-1-daniel.van.vugt@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Until now, deferred console takeover only meant defer until there is
output. But that risks stepping on the toes of userspace splash screens
as console messages may appear before the splash screen.

This becomes more likely the later the splash screen starts, but even
systems whose splash exists in initrd may not be not immune because they
still rely on racing against all possible kernel messages that might
trigger the fbcon takeover. And those kernel messages are hardware
dependent so what boots silently on one machine may not be so quiet on
the next. We also want to shield users from seeing warnings about their
hardware/firmware that they don't always have the power to fix themselves,
and may not be deemed worthy of fixing by the vendor.

So now we check the command line for the expectation of userspace splash
(CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER_CONDITION) and if present
then defer fbcon's takeover until the first console switch. In the case
of Plymouth, its value would typically be "splash". This keeps the boot
experience clean and silent so long as the command line requests so.

Closes: https://bugs.launchpad.net/bugs/1970069
Cc: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Daniel van Vugt <daniel.van.vugt@canonical.com>
---
v2: Added Kconfig option instead of hard coding "splash".
v3: Default to disabled, not "splash". If enabled then take over on
    switch rather than on first output after switch.
v4: Elaborate more in the commit message about races and Kconfig. Also
    move these revision comments below the line marker.
---
 drivers/video/console/Kconfig    | 12 +++++++++
 drivers/video/fbdev/core/fbcon.c | 44 +++++++++++++++++++++++++++++---
 2 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index bc31db6ef7..2f9435335f 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -138,6 +138,18 @@ config FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
 	  by the firmware in place, rather then replacing the contents with a
 	  black screen as soon as fbcon loads.
 
+config FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER_CONDITION
+	string "Command line parameter to defer takeover to first switch"
+	depends on FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
+	default ""
+	help
+	  If enabled this defers further the framebuffer console taking over
+	  until the first console switch has occurred. And even then only if
+	  the specified parameter is found on the command line. This ensures
+	  fbcon does not interrupt userspace splash screens such as Plymouth
+	  which may be yet to start rendering at the time of the first console
+	  output.
+
 config STI_CONSOLE
 	bool "STI text console"
 	depends on PARISC && HAS_IOMEM
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 1183e7a871..e5d841ab03 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -76,6 +76,7 @@
 #include <linux/crc32.h> /* For counting font checksums */
 #include <linux/uaccess.h>
 #include <asm/irq.h>
+#include <asm/cmdline.h>
 
 #include "fbcon.h"
 #include "fb_internal.h"
@@ -3348,7 +3349,7 @@ static int fbcon_output_notifier(struct notifier_block *nb,
 {
 	WARN_CONSOLE_UNLOCKED();
 
-	pr_info("fbcon: Taking over console\n");
+	pr_info("fbcon: Taking over console for output\n");
 
 	dummycon_unregister_output_notifier(&fbcon_output_nb);
 
@@ -3357,6 +3358,27 @@ static int fbcon_output_notifier(struct notifier_block *nb,
 
 	return NOTIFY_OK;
 }
+
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER_CONDITION
+static int initial_console;
+static struct notifier_block fbcon_switch_nb;
+
+static int fbcon_switch_notifier(struct notifier_block *nb,
+				 unsigned long action, void *data)
+{
+	struct vc_data *vc = data;
+
+	WARN_CONSOLE_UNLOCKED();
+
+	if (vc->vc_num != initial_console) {
+		pr_info("fbcon: Taking over console for switch\n");
+		dummycon_unregister_switch_notifier(&fbcon_switch_nb);
+		schedule_work(&fbcon_deferred_takeover_work);
+	}
+
+	return NOTIFY_OK;
+}
+#endif
 #endif
 
 static void fbcon_start(void)
@@ -3368,8 +3390,18 @@ static void fbcon_start(void)
 		deferred_takeover = false;
 
 	if (deferred_takeover) {
-		fbcon_output_nb.notifier_call = fbcon_output_notifier;
-		dummycon_register_output_notifier(&fbcon_output_nb);
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER_CONDITION
+		if (cmdline_find_option_bool(boot_command_line,
+		      CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER_CONDITION)) {
+			initial_console = fg_console;
+			fbcon_switch_nb.notifier_call = fbcon_switch_notifier;
+			dummycon_register_switch_notifier(&fbcon_switch_nb);
+		} else
+#endif
+		{
+			fbcon_output_nb.notifier_call = fbcon_output_notifier;
+			dummycon_register_output_notifier(&fbcon_output_nb);
+		}
 		return;
 	}
 #endif
@@ -3416,8 +3448,12 @@ void __exit fb_console_exit(void)
 {
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
 	console_lock();
-	if (deferred_takeover)
+	if (deferred_takeover) {
 		dummycon_unregister_output_notifier(&fbcon_output_nb);
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER_CONDITION
+		dummycon_unregister_switch_notifier(&fbcon_switch_nb);
+#endif
+	}
 	console_unlock();
 
 	cancel_work_sync(&fbcon_deferred_takeover_work);
-- 
2.43.0


