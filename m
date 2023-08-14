Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449C277B59C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 11:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbjHNJhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 05:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234541AbjHNJgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 05:36:46 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B839CE62
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 02:36:28 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31781e15a0cso3640630f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 02:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692005787; x=1692610587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AOycXFd04D023OSn4+z5Wjq2kon8lZE9bJtSlqr368g=;
        b=yEAPLYgIWyopvhSbUln0QMRDhSY1QZPCVDzv7XKCmhkJXptR/csHkTQ5sKLcrdeJUo
         u0fG3zvbMuMI/gQ9C7hGHaUqVc/CeoOS1OY8KKinWbMV+46ynQFTSuxhoXFQ6jDBpzds
         scZtJmyFSHgzw9vl8iy37xwleG22WMEmayoklPOahCC7aj7dmmxB0vv4HJGi6qNwtEFL
         dIi58P9rqoUPxq7dMwpry4/kLIDaxKV4ooD/VXe7zU74FaccmLD1LBiHj9ttVSWH5jbp
         gOOvp80W2moUFlAdKtAUaMxkyQNLqHCu9LCPNF+zdikRNVWcru8D1t/g6WyDzpxKHCIN
         /iqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692005787; x=1692610587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AOycXFd04D023OSn4+z5Wjq2kon8lZE9bJtSlqr368g=;
        b=k9f3isMo9CecSihqCj9XPTcORcbkeWqup4q8fAUKNu158u39kjiW9OMI7gpWqYH/ks
         xD+T9i5aBytC0x0aZdjVFrQN9WdK1pLmwOjVHwO6WJJfo4kDsanXoGVtG0BDPZ/uAULY
         YgGFkoxHuwFmyaHiiq4K1oU85gaN3MnZbFkOsoYAGs3EuapURQ9wR0tsST1v13cIfKaX
         XgLD+M94sxkI5TfhKaULHhpKPgdUHaPAvvDuYaofAtnjkV2y1T/XQ4BgQ5P20PnAOEsD
         p/1q+GEfUfsVCPXCsv1II/Ouf9IExjKFy/rn7fZMR5qkE4NMTR+j6MthYfuFZPkdiyy6
         0KVg==
X-Gm-Message-State: AOJu0YzjsKvrzwkBt8YkVK2CKNhZVo3lF9qK0KQhO61vrqvKmts994kj
        lsaTxbj0r6tELsrvRc76xcp2nfO7hZBN3de0kOU/pw==
X-Google-Smtp-Source: AGHT+IHPno+ZzX4R7cnG+fm9okmHN9AWrh8xZXYJD+2CXbvpBfkJxaxf50EuUaZXfyMlbhiVRKbiwg==
X-Received: by 2002:adf:f3c6:0:b0:319:6b4a:23aa with SMTP id g6-20020adff3c6000000b003196b4a23aamr4198919wrp.65.1692005787114;
        Mon, 14 Aug 2023 02:36:27 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d0cb:d23e:f2fb:62b4])
        by smtp.gmail.com with ESMTPSA id d17-20020adfe851000000b003197839d68asm2422140wrn.97.2023.08.14.02.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 02:36:26 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 1/2] genirq: proc: drop unused argument from unregister_handler_proc()
Date:   Mon, 14 Aug 2023 11:36:20 +0200
Message-Id: <20230814093621.23209-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230814093621.23209-1-brgl@bgdev.pl>
References: <20230814093621.23209-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The irq argument is unused. Drop it.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 kernel/irq/internals.h | 5 ++---
 kernel/irq/manage.c    | 6 +++---
 kernel/irq/proc.c      | 2 +-
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index bdd35bb9c735..eee0e27e6750 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -125,14 +125,13 @@ void __irq_wake_thread(struct irq_desc *desc, struct irqaction *action);
 extern void register_irq_proc(unsigned int irq, struct irq_desc *desc);
 extern void unregister_irq_proc(unsigned int irq, struct irq_desc *desc);
 extern void register_handler_proc(unsigned int irq, struct irqaction *action);
-extern void unregister_handler_proc(unsigned int irq, struct irqaction *action);
+extern void unregister_handler_proc(struct irqaction *action);
 #else
 static inline void register_irq_proc(unsigned int irq, struct irq_desc *desc) { }
 static inline void unregister_irq_proc(unsigned int irq, struct irq_desc *desc) { }
 static inline void register_handler_proc(unsigned int irq,
 					 struct irqaction *action) { }
-static inline void unregister_handler_proc(unsigned int irq,
-					   struct irqaction *action) { }
+static inline void unregister_handler_proc(struct irqaction *action) { }
 #endif
 
 extern bool irq_can_set_affinity_usr(unsigned int irq);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index d2742af0f0fd..7ed8a151ded8 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1937,7 +1937,7 @@ static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
 	 */
 	chip_bus_sync_unlock(desc);
 
-	unregister_handler_proc(irq, action);
+	unregister_handler_proc(action);
 
 	/*
 	 * Make sure it's not being used on another CPU and if the chip
@@ -2056,7 +2056,7 @@ static const void *__cleanup_nmi(unsigned int irq, struct irq_desc *desc)
 	if (!WARN_ON(desc->action == NULL)) {
 		irq_pm_remove_action(desc, desc->action);
 		devname = desc->action->name;
-		unregister_handler_proc(irq, desc->action);
+		unregister_handler_proc(desc->action);
 
 		kfree(desc->action);
 		desc->action = NULL;
@@ -2487,7 +2487,7 @@ static struct irqaction *__free_percpu_irq(unsigned int irq, void __percpu *dev_
 
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
 
-	unregister_handler_proc(irq, action);
+	unregister_handler_proc(action);
 
 	irq_chip_pm_put(&desc->irq_data);
 	module_put(desc->owner);
diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 623b8136e9af..83ed403991c6 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -414,7 +414,7 @@ void unregister_irq_proc(unsigned int irq, struct irq_desc *desc)
 
 #undef MAX_NAMELEN
 
-void unregister_handler_proc(unsigned int irq, struct irqaction *action)
+void unregister_handler_proc(struct irqaction *action)
 {
 	proc_remove(action->dir);
 }
-- 
2.39.2

