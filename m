Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26377768A8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbjHITZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbjHITZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:25:23 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777BC4697;
        Wed,  9 Aug 2023 12:24:18 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbea14706eso807735e9.2;
        Wed, 09 Aug 2023 12:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691609057; x=1692213857;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TwJSdhTVBtoRdC+WKmKXaSMWi9tGMReDfyfqFSEPiQo=;
        b=l6uiO69hwgNHoBkvQkUdh5VQBz4kBl67ce4b0UfA99F7TdZAeT97JcoZdmI0jFyf3P
         LbEEsXfH/0QduKrVBF7ZPQvK122wnQY5IIk9Fk9b3mP/oFmgAoeQk/ckJlTxGIIXZDGW
         oFTdCergjtSQbrCjaQvmwhRg0sgH/iYJzZr6ZS82++ftLbwGUh1PnPCWkGxLuER8SQkd
         Fm+gzYWzSe7M9TS0YQqmkfvycsl9/u+8y5VAU0l4ZX52P1h7ss/EIk++SkplVr5kb0di
         Q4zSPzVXIllhlALctiTAhVjMuTN3l/1rzYhSh92Q7mjvgyPJhvtOJlQRLdY2QvPdQ5TU
         LQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691609057; x=1692213857;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TwJSdhTVBtoRdC+WKmKXaSMWi9tGMReDfyfqFSEPiQo=;
        b=aFYIZE1ZndAP8NIL9ZGyi2DR2gY/U6C3264at+PVgMpD1ieK99DfY4Z8P8cclhrm/M
         KD+Dq9QSJldKJaB8ziCTKLYE0dpMY4pGPyoQkHODaTe4k4iRSwkCHQL0WhVdwtd8OshG
         ug/3RkrPvjy4ulRMMt5/WC7iOsiTCPTNBveHjgWWEBxgKmw2SyiRDrVv14f8yDx6GqMY
         uO80ioKszCEF72B6Fg0+Rv0kIGQqvh29iUsPvS9LUkk/PQkKaxN7fWKvCOE2m5o+EBiN
         xOYoZ1yrVQt9m3C1rvsUB8dw/l7SBfGK5nxTV60WQO7lIhU/eSZL3sbjbCTqx9QDiNYY
         /zOg==
X-Gm-Message-State: AOJu0YympxEvO3pTzw+uQRdRRJJq7OwsW6lfkZ9YOgMT8qqaGlwhycre
        fawmauVG/qhGkE+fjic60DMEzc6iLpQheXTN
X-Google-Smtp-Source: AGHT+IF9sdUPmLqm+ZlJMWp96z/Kt4+IDWlhFua8Z4LNiAlk09X9pzqB6x/yhsoFxvbGdZPkQmD1iw==
X-Received: by 2002:a05:600c:d7:b0:3fb:b5dc:dab1 with SMTP id u23-20020a05600c00d700b003fbb5dcdab1mr49248wmm.39.1691609056628;
        Wed, 09 Aug 2023 12:24:16 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id y9-20020a7bcd89000000b003fba6a0c881sm2776208wmj.43.2023.08.09.12.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 12:24:16 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Wed, 09 Aug 2023 21:24:03 +0200
Subject: [PATCH v2 1/6] kernel/reboot: distinguish between cold and warm
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230809-pca9450-reboot-v2-1-b98b4f8139d5@skidata.com>
References: <20230809-pca9450-reboot-v2-0-b98b4f8139d5@skidata.com>
In-Reply-To: <20230809-pca9450-reboot-v2-0-b98b4f8139d5@skidata.com>
To:     Lee Jones <lee@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        peng.fan@oss.nxp.com, rafael.j.wysocki@intel.com,
        Jerome Neanne <jneanne@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Bara <benjamin.bara@skidata.com>

Currently, the kernel is not aware if the registered reboot handler is a
cold/hard or warm/soft one. However, there exists a 'reboot_mode' kernel
parameter which can be used to specify the type of reboot the kernel
should use. This parameter is currently not very well supported, due to
the lack of distinction possibilities. Instead, cold/hard reboot
handlers are often registered with a higher priorization to indicate the
kernel to prefer these over others. With a proper distinction
possibility, the reboot_mode kernel parameter can be respected in a much
simpler way. Additionally, a warning can be shown if no proper reboot
handler is implemented. Due to the priorization of cold/hard reboot
handlers, these are preferred implicitly and therefore the registration
helper can be used instead. The "unspecified" handlers are still
supported, as they are registered as "soft reboots" and are therefore
called as fallback.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
v2:
- fallback to warm handler if hard/cold restart requested but failed
- improve commit message
---
 include/linux/reboot.h | 22 ++++++++++++
 kernel/reboot.c        | 94 ++++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 110 insertions(+), 6 deletions(-)

diff --git a/include/linux/reboot.h b/include/linux/reboot.h
index 2b6bb593be5b..05199aedb696 100644
--- a/include/linux/reboot.h
+++ b/include/linux/reboot.h
@@ -119,6 +119,20 @@ enum sys_off_mode {
 	 * Handlers restart system. Handlers are disallowed to sleep.
 	 */
 	SYS_OFF_MODE_RESTART,
+
+	/**
+	 * @SYS_OFF_MODE_RESTART_COLD:
+	 *
+	 * Handlers cold restart system. Handlers are disallowed to sleep.
+	 */
+	SYS_OFF_MODE_RESTART_COLD,
+
+	/**
+	 * @SYS_OFF_MODE_RESTART_WARM:
+	 *
+	 * Handlers warm restart system. Handlers are disallowed to sleep.
+	 */
+	SYS_OFF_MODE_RESTART_WARM,
 };
 
 /**
@@ -157,6 +171,14 @@ int devm_register_restart_handler(struct device *dev,
 				  int (*callback)(struct sys_off_data *data),
 				  void *cb_data);
 
+int devm_register_cold_restart_handler(struct device *dev,
+				       int (*callback)(struct sys_off_data *data),
+				       void *cb_data);
+
+int devm_register_warm_restart_handler(struct device *dev,
+				       int (*callback)(struct sys_off_data *data),
+				       void *cb_data);
+
 int register_platform_power_off(void (*power_off)(void));
 void unregister_platform_power_off(void (*power_off)(void));
 
diff --git a/kernel/reboot.c b/kernel/reboot.c
index 3bba88c7ffc6..ab99f450801f 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -146,9 +146,15 @@ EXPORT_SYMBOL(devm_register_reboot_notifier);
 
 /*
  *	Notifier list for kernel code which wants to be called
- *	to restart the system.
+ *	to cold restart the system.
  */
-static ATOMIC_NOTIFIER_HEAD(restart_handler_list);
+static ATOMIC_NOTIFIER_HEAD(cold_restart_handler_list);
+
+/*
+ *	Notifier list for kernel code which wants to be called
+ *	to warm restart the system.
+ */
+static ATOMIC_NOTIFIER_HEAD(warm_restart_handler_list);
 
 /**
  *	register_restart_handler - Register function to be called to reset
@@ -190,7 +196,11 @@ static ATOMIC_NOTIFIER_HEAD(restart_handler_list);
  */
 int register_restart_handler(struct notifier_block *nb)
 {
-	return atomic_notifier_chain_register(&restart_handler_list, nb);
+	/*
+	 * Store all non-devm-based handlers in the warm list to ensure that the
+	 * "specified" handler are preferred over the "unspecified" ones.
+	 */
+	return atomic_notifier_chain_register(&warm_restart_handler_list, nb);
 }
 EXPORT_SYMBOL(register_restart_handler);
 
@@ -205,7 +215,14 @@ EXPORT_SYMBOL(register_restart_handler);
  */
 int unregister_restart_handler(struct notifier_block *nb)
 {
-	return atomic_notifier_chain_unregister(&restart_handler_list, nb);
+	int ret;
+
+	ret = atomic_notifier_chain_unregister(&warm_restart_handler_list, nb);
+	if (ret == -ENOENT)
+		ret = atomic_notifier_chain_unregister(&cold_restart_handler_list,
+						       nb);
+
+	return ret;
 }
 EXPORT_SYMBOL(unregister_restart_handler);
 
@@ -222,7 +239,20 @@ EXPORT_SYMBOL(unregister_restart_handler);
  */
 void do_kernel_restart(char *cmd)
 {
-	atomic_notifier_call_chain(&restart_handler_list, reboot_mode, cmd);
+	/*
+	 * REBOOT_GPIO can be either cold or warm -> let handler decide.
+	 * Prefer cold reboot if mode not specified.
+	 */
+	if (reboot_mode == REBOOT_UNDEFINED || reboot_mode == REBOOT_GPIO ||
+	    reboot_mode == REBOOT_HARD || reboot_mode == REBOOT_COLD) {
+		atomic_notifier_call_chain(&cold_restart_handler_list,
+					   reboot_mode, cmd);
+		if (reboot_mode == REBOOT_HARD || reboot_mode == REBOOT_COLD)
+			pr_emerg("hard/cold reboot failed, fallback!\n");
+	}
+
+	/* Always execute warm handler as fallback */
+	atomic_notifier_call_chain(&warm_restart_handler_list, reboot_mode, cmd);
 }
 
 void migrate_to_reboot_cpu(void)
@@ -414,7 +444,15 @@ register_sys_off_handler(enum sys_off_mode mode,
 		break;
 
 	case SYS_OFF_MODE_RESTART:
-		handler->list = &restart_handler_list;
+		handler->list = &warm_restart_handler_list;
+		break;
+
+	case SYS_OFF_MODE_RESTART_COLD:
+		handler->list = &cold_restart_handler_list;
+		break;
+
+	case SYS_OFF_MODE_RESTART_WARM:
+		handler->list = &warm_restart_handler_list;
 		break;
 
 	default:
@@ -560,6 +598,50 @@ int devm_register_restart_handler(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_register_restart_handler);
 
+/**
+ *	devm_register_cold_restart_handler - Register cold restart handler
+ *	@dev: Device that registers callback
+ *	@callback: Callback function
+ *	@cb_data: Callback's argument
+ *
+ *	Registers resource-managed sys-off handler with a default priority
+ *	and using cold restart mode.
+ *
+ *	Returns zero on success, or error code on failure.
+ */
+int devm_register_cold_restart_handler(struct device *dev,
+				       int (*callback)(struct sys_off_data *data),
+				       void *cb_data)
+{
+	return devm_register_sys_off_handler(dev,
+					     SYS_OFF_MODE_RESTART_COLD,
+					     SYS_OFF_PRIO_DEFAULT,
+					     callback, cb_data);
+}
+EXPORT_SYMBOL_GPL(devm_register_cold_restart_handler);
+
+/**
+ *	devm_register_warm_restart_handler - Register warm restart handler
+ *	@dev: Device that registers callback
+ *	@callback: Callback function
+ *	@cb_data: Callback's argument
+ *
+ *	Registers resource-managed sys-off handler with a default priority
+ *	and using warm restart mode.
+ *
+ *	Returns zero on success, or error code on failure.
+ */
+int devm_register_warm_restart_handler(struct device *dev,
+				       int (*callback)(struct sys_off_data *data),
+				       void *cb_data)
+{
+	return devm_register_sys_off_handler(dev,
+					     SYS_OFF_MODE_RESTART_WARM,
+					     SYS_OFF_PRIO_DEFAULT,
+					     callback, cb_data);
+}
+EXPORT_SYMBOL_GPL(devm_register_warm_restart_handler);
+
 static struct sys_off_handler *platform_power_off_handler;
 
 static int platform_power_off_notify(struct sys_off_data *data)

-- 
2.34.1

