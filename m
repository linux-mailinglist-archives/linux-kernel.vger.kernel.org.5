Return-Path: <linux-kernel+bounces-157066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B691F8B0C63
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E5A22837FC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004D115E5DC;
	Wed, 24 Apr 2024 14:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PhQFf29g"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF0C15E213
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713968524; cv=none; b=Ag/OqlRt8rAtlSsxyM5XgDp6nff2qCsKKaulN/VBS1NtpP3ND54oUiGcr3/eDVEwz6w6T6ULv3XoMXW5gsNwaTO/MwtUCL2YJUPkIXug7tIvv7KCC+/SxAoDQ3oz3PJgo/aFL2LtSq78yAabxQeSrGHoonyBMXEjwQBxueBt3jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713968524; c=relaxed/simple;
	bh=zQ4ggdIVSkhmIl2fRvA4hlHqqYytUieTW/CMICOA+M0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qci/cHn5q1gVrDmR6aM0ZEeujPexAAtGw4dqxf29F/Q0FXXbcKcytMKQpTdiAvluPB5Cp1lvkxoFZaP0kZzGhivCeriMOlpul4ySoTYt9CvoAVpPs0oZZj2w7bzJsR9arY7ZpXxQ5zVNKfzlNw6xnkASZxmeemWJimXw16shM/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PhQFf29g; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41aa2f6ff2dso18762985e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713968521; x=1714573321; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rbu3CtHQPDzqG7bcEJAxBge0HJMTre8Cbx1YM3r4SiU=;
        b=PhQFf29ga/hT0xj/PCph+ZrNplHd6tQQd2dn6+TdsALaGumsnp/f7mNw3b29JafvXu
         oYhouAbiojPQzZpKLxPUuyfOEIC32hqc5lSca7zFClv20+P+7QPDNGDtVk8flDL43TZP
         ZGoga8Wxo9dBfZO8zI6iaap847E1kt7WM5d+G+DBcliy1lXQ6UZ9qpXhXfPAOj2HcEyD
         K4pLuPVeQYpXr/W7WzhCr7oHxFJg/Lpx27phdOvuaVz6VGN5IxdMqA+oa88Mj4+Or1HM
         8IoTq+EWUDWlOd2fY535+gPVk1iqGx5NhUyRcUVWNnbbur3NO1uB3xGx0wUwdJ84P/0h
         tvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713968521; x=1714573321;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rbu3CtHQPDzqG7bcEJAxBge0HJMTre8Cbx1YM3r4SiU=;
        b=EvpvCbyHLIlPRWwcn5D1qvReTmheRVI0jQ9vqLD8k4FuOCEqSHuXAo/VeFEU5UiiaI
         xK4dqhajA9Sw8MlNkr2qOlBzOn35vLuCuz0rKet/LKxiHGzG0TmoPtFxT+Gi5XmxSE37
         M5gJdP3s/fvRY1KmW3n21mDWqBVyUR9T6XcTSFEaUVhOKa+C11Iubsm6canItW9Eigqs
         6ArLVLvatj0gggd46U9oRKQb+fwwZVYKwTXIv52wZt4nlozEhBMfW3UwYmmZgnhIW+Fu
         vnnO+gJY4hcrDF4zB9+d/HW80BxhDeRxWoEQB8qccNxzZ48WMhADsHUdgv7dggU01ZT3
         xVFA==
X-Forwarded-Encrypted: i=1; AJvYcCVE6vthk/REG710gGBJyxplnhIz/LwluttfCO0HMSgyCiLui4yyMSJ6DjkbyK7HlWtf03YbQJYAE2N9/MhSrGZP+XNSx+5WvIFy9Zkx
X-Gm-Message-State: AOJu0YxfHWPs6ppJ+on1vKjNsqKMB8w8v02GlbIu4rHTlIhbQDW4vMaA
	H3nxVfMJ+8KGccSVpEpDqysjlpA0WZMFnIpRk9fKv6WHIetAiiLtg4Yo5zSeAsI=
X-Google-Smtp-Source: AGHT+IGqxAXxOtPD63SKaGX/vtzm4PnE/j4LFLNS+70NxHdpPcb3rgN8pMmwPYmCLEzyUXpYw1Y9NQ==
X-Received: by 2002:a05:600c:154f:b0:418:e08c:817 with SMTP id f15-20020a05600c154f00b00418e08c0817mr1761473wmg.32.1713968520750;
        Wed, 24 Apr 2024 07:22:00 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id je12-20020a05600c1f8c00b004183edc31adsm27649971wmb.44.2024.04.24.07.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 07:22:00 -0700 (PDT)
From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Wed, 24 Apr 2024 15:21:41 +0100
Subject: [PATCH v2] serial: kgdboc: Fix NMI-safety problems from keyboard
 reset code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-kgdboc_fix_schedule_work-v2-1-50f5a490aec5@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHQVKWYC/42NUQ6CMBBEr0L22xqKRcAv72EIacsWNpDWbBU1h
 LtbOYGfbzLzZoWITBjhkq3AuFCk4BMUhwzsqP2AgvrEUOSFypVsxDT0JtjO0buLdsT+OWP3Cjw
 Jl1ujlKn1qVSQ5nfGVNrVtzbxSPER+LM/LfKX/iFdpJDCOdnUtTxXFZbXmbzmcAw8QLtt2xfsN
 8yIwQAAAA==
To: Jason Wessel <jason.wessel@windriver.com>, 
 Douglas Anderson <dianders@chromium.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, Liuye <liu.yeC@h3c.com>, 
 stable@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4055;
 i=daniel.thompson@linaro.org; h=from:subject:message-id;
 bh=zQ4ggdIVSkhmIl2fRvA4hlHqqYytUieTW/CMICOA+M0=;
 b=owEBbQKS/ZANAwAKAXzjJV0594ihAcsmYgBmKRV5Wm2kC9hXmk1syJZaOzjZr40TcSJ3+kCD8
 Le6DrhAgK+JAjMEAAEKAB0WIQQvNUFTUPeVarpwrPB84yVdOfeIoQUCZikVeQAKCRB84yVdOfeI
 oe8JEACq4DWqHSaha3tdg43NRvx3r3lp+1RIoZJTpXkJvDcRqZBur0QZaN5enNHuOZ7h23bi0z0
 3G/06X0RqQLXPnROu0bhZGwOHxEwZsdyZwkOI8K786wrJtxZ8OeKlKPKjh/jXd8/TuEFlJvKxBA
 kqalG7vC2g8E4NaI9o/SJZ/G8u3HQUgmBBt2J9yqOPI65yQHst89j4MTQkWIl067p8GKYKvYI7x
 hu4Dh4dYnKZYezWiV+4r/Scb4E344be3xvwhpL7Mlx3//qTSm6SEqsTfF/R3Rryp8Y3aWNDlyEx
 mWVdmPZvMnXRMMU4X8mPafGACNPGMCUH5nUrWScO492cvqy3DiqP3XtiqbuKcp90d1U8Ycgbubf
 m+5JWlSDixrC1nQn6AJhWR/pL9F5PieinPIrA/ZxMQlMRUZVmmo4eMs4TS4u7zY/570eMmjj8FH
 tx1yQrX6yu8/OyVwWm/jBkulK0p4ErHxbNqad8++8QglVZ/Z7LjWzVlpEYF/cj0Sd+TwGFxsu22
 N+DUnLN2BhwwVpnHG+4t0fxpM3RHTZjNQZ3S2U3C2m7f0Yucm5ojCRWU3NYvDq+ZO9DQtkUuds/
 I4WaG+g6zGRwtcVfbf06Ih1m+++WZHVfrLOTe495+m4RhFVBOCqRqh72aLihN42svzQ9fFEWBE6
 ZGCViho+/fVYTQg==
X-Developer-Key: i=daniel.thompson@linaro.org; a=openpgp;
 fpr=E38BE19861669213F6E2661AA8A4E3BC5B7B28BE

Currently, when kdb is compiled with keyboard support, then we will use
schedule_work() to provoke reset of the keyboard status.  Unfortunately
schedule_work() gets called from the kgdboc post-debug-exception
handler.  That risks deadlock since schedule_work() is not NMI-safe and,
even on platforms where the NMI is not directly used for debugging, the
debug trap can have NMI-like behaviour depending on where breakpoints
are placed.

Fix this by using the irq work system, which is NMI-safe, to defer the
call to schedule_work() to a point when it is safe to call.

Reported-by: Liuye <liu.yeC@h3c.com>
Closes: https://lore.kernel.org/all/20240228025602.3087748-1-liu.yeC@h3c.com/
Cc: stable@vger.kernel.org
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
@Greg: I'm assuming this could/should go via your tree but feel free
       to share an ack if you want me to hoover it up instead.

Changes in v2:
- Fix typo in the big comment (thanks Doug)
- Link to v1: https://lore.kernel.org/r/20240419-kgdboc_fix_schedule_work-v1-1-ff19881677e5@linaro.org
---
 drivers/tty/serial/kgdboc.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index 7ce7bb1640054..58ea1e1391cee 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -19,6 +19,7 @@
 #include <linux/console.h>
 #include <linux/vt_kern.h>
 #include <linux/input.h>
+#include <linux/irq_work.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/serial_core.h>
@@ -48,6 +49,25 @@ static struct kgdb_io		kgdboc_earlycon_io_ops;
 static int                      (*earlycon_orig_exit)(struct console *con);
 #endif /* IS_BUILTIN(CONFIG_KGDB_SERIAL_CONSOLE) */
 
+/*
+ * When we leave the debug trap handler we need to reset the keyboard status
+ * (since the original keyboard state gets partially clobbered by kdb use of
+ * the keyboard).
+ *
+ * The path to deliver the reset is somewhat circuitous.
+ *
+ * To deliver the reset we register an input handler, reset the keyboard and
+ * then deregister the input handler. However, to get this done right, we do
+ * have to carefully manage the calling context because we can only register
+ * input handlers from task context.
+ *
+ * In particular we need to trigger the action from the debug trap handler with
+ * all its NMI and/or NMI-like oddities. To solve this the kgdboc trap exit code
+ * (the "post_exception" callback) uses irq_work_queue(), which is NMI-safe, to
+ * schedule a callback from a hardirq context. From there we have to defer the
+ * work again, this time using schedule_work(), to get a callback using the
+ * system workqueue, which runs in task context.
+ */
 #ifdef CONFIG_KDB_KEYBOARD
 static int kgdboc_reset_connect(struct input_handler *handler,
 				struct input_dev *dev,
@@ -99,10 +119,17 @@ static void kgdboc_restore_input_helper(struct work_struct *dummy)
 
 static DECLARE_WORK(kgdboc_restore_input_work, kgdboc_restore_input_helper);
 
+static void kgdboc_queue_restore_input_helper(struct irq_work *unused)
+{
+	schedule_work(&kgdboc_restore_input_work);
+}
+
+static DEFINE_IRQ_WORK(kgdboc_restore_input_irq_work, kgdboc_queue_restore_input_helper);
+
 static void kgdboc_restore_input(void)
 {
 	if (likely(system_state == SYSTEM_RUNNING))
-		schedule_work(&kgdboc_restore_input_work);
+		irq_work_queue(&kgdboc_restore_input_irq_work);
 }
 
 static int kgdboc_register_kbd(char **cptr)
@@ -133,6 +160,7 @@ static void kgdboc_unregister_kbd(void)
 			i--;
 		}
 	}
+	irq_work_sync(&kgdboc_restore_input_irq_work);
 	flush_work(&kgdboc_restore_input_work);
 }
 #else /* ! CONFIG_KDB_KEYBOARD */

---
base-commit: 0bbac3facb5d6cc0171c45c9873a2dc96bea9680
change-id: 20240419-kgdboc_fix_schedule_work-f0cb44b8a354

Best regards,
-- 
Daniel Thompson <daniel.thompson@linaro.org>


