Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87240765793
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjG0P1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234595AbjG0P0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:26:50 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22631FF5;
        Thu, 27 Jul 2023 08:26:48 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-31765792c7cso1180620f8f.0;
        Thu, 27 Jul 2023 08:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690471607; x=1691076407;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R87BTfopelhJFglN5IN6As+cGJH4HVKKMNIB+DJTWpo=;
        b=NZgk4HfJyy0U4LwtA03w7bjkCYbSBrHp5nQVOMa0tqIsIfnFDBSpzQAK9pPan32YCP
         758WhVpcdhjbgLsuvtBOrQD+80wwe7F0GznGNKVr4kDJK8BYdLOFfXtxdB7XNrAR4+5C
         9I4Uww/xYkLM7KkG92p0N5cuCmq730dfnY12q61mNO87ICkJfUjDf9/zbpfIFVbcMhRh
         8Xb1CjUYih4bJAkOfFvj0pM65gx26WCjJIb7uZ9U2wVhehioTdTH7R8SjQr0cAY3zqtm
         0ldygbdhKV4ZwI8DESfq2nYUf1YNEMfFJCS9c59FaVqcZwk89vBqaVLLo/+V+vCdB8NL
         P4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690471607; x=1691076407;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R87BTfopelhJFglN5IN6As+cGJH4HVKKMNIB+DJTWpo=;
        b=GO8FeAjfRtSZhlGl1/Im5gvcABrzZqHdfxMe1ano+mmD8xw/tjUW8X3NFOCbIRWUje
         pDAMZbPXF+oqC13RrSN+Tas3OLbVG1wQaIMH/nW5WTMoEpYQVIRyV22f3Lm7MoFn/n9E
         X72pWBZVjiXX7qq4N/4jmt1TjTZDGG1lgkmG7ruuknrjuOuvmRcUtUncU06kougsfhvq
         E7IsYHKZo4QDB0rXrxC3vKZa/hpoUbcMBO/5B/5J4TvgpTdKL7ggUqcV2W+SaE0ySWMl
         ehii1ivr7MG0svZFtq9g9rRYJmC+4gFnYF/Zscv3j6pjUMO/TmBhvG0G5Nzd6540H4Rj
         nyvg==
X-Gm-Message-State: ABy/qLZq46i9LrEMZT+7q+DIMBomhmCnUqNgAvLNkZpfOonelgi51TCW
        kq0FHiPVYuMc3fdXGC9OH7yA0N/ixD+Ij0IV
X-Google-Smtp-Source: APBJJlGWncJjmVx3/BMhSoTbn13HjjrbEC9bf/p8ktEEBuc6Uxfm2DMRhqlYdSmkIsOlbWsCdcadaA==
X-Received: by 2002:a5d:6744:0:b0:314:15a8:7879 with SMTP id l4-20020a5d6744000000b0031415a87879mr2219378wrw.34.1690471606869;
        Thu, 27 Jul 2023 08:26:46 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id b17-20020adfde11000000b003143765e207sm2350622wrm.49.2023.07.27.08.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 08:26:46 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Thu, 27 Jul 2023 17:26:36 +0200
Subject: [PATCH 1/6] kernel/reboot: distinguish between cold and warm
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230727-pca9450-reboot-v1-1-c8edb27bf404@skidata.com>
References: <20230727-pca9450-reboot-v1-0-c8edb27bf404@skidata.com>
In-Reply-To: <20230727-pca9450-reboot-v1-0-c8edb27bf404@skidata.com>
To:     Lee Jones <lee@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Robin Gong <yibin.gong@nxp.com>,
        Jerome Neanne <jneanne@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Bara <benjamin.bara@skidata.com>

As a couple of PMICs support warm and cold resets (e.g. tps65219 or
pca9450) and the 'reboot_mode' kernel parameter allows to specify the
reboot mode, distinguish between cold and warm reboot handlers.
This is done by maintaining two different restart handler lists. When
the mode is unspecified, the cold restart handlers are preferred
(independent of their actual priority).

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 include/linux/reboot.h | 22 ++++++++++++
 kernel/reboot.c        | 92 ++++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 108 insertions(+), 6 deletions(-)

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
index 3bba88c7ffc6..d0d3faf70a79 100644
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
 
@@ -222,7 +239,18 @@ EXPORT_SYMBOL(unregister_restart_handler);
  */
 void do_kernel_restart(char *cmd)
 {
-	atomic_notifier_call_chain(&restart_handler_list, reboot_mode, cmd);
+	/*
+	 * REBOOT_GPIO can be either cold or warm -> let handler decide.
+	 * Prefer cold reboot if mode not specified.
+	 */
+	if (reboot_mode == REBOOT_UNDEFINED || reboot_mode == REBOOT_GPIO ||
+	    reboot_mode == REBOOT_HARD || reboot_mode == REBOOT_COLD)
+		atomic_notifier_call_chain(&cold_restart_handler_list,
+					   reboot_mode, cmd);
+	if (reboot_mode == REBOOT_UNDEFINED || reboot_mode == REBOOT_GPIO ||
+	    reboot_mode == REBOOT_SOFT || reboot_mode == REBOOT_WARM)
+		atomic_notifier_call_chain(&warm_restart_handler_list,
+					   reboot_mode, cmd);
 }
 
 void migrate_to_reboot_cpu(void)
@@ -414,7 +442,15 @@ register_sys_off_handler(enum sys_off_mode mode,
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
@@ -560,6 +596,50 @@ int devm_register_restart_handler(struct device *dev,
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

