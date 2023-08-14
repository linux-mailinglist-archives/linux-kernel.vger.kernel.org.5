Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFBE877B59B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 11:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbjHNJhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 05:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234699AbjHNJgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 05:36:46 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0E2E73
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 02:36:29 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe2048c910so37656665e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 02:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692005788; x=1692610588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9GIkI+02jFm9GaovqHGnU7H+AqY3jsX4KEby4kRqP0=;
        b=uitaqFVvR6wG+2WZxZnkMJsbIyf80+jIPR57rXBxpxxKezVlMzJKTeUBYqcHrfaKlO
         hrp7aqI4YGAn8CplW3KnRMOYvF/HPhiP+ar40CrfhJrKkBOjD5jjozVwn5GvtfmZmra8
         +jsuiDnH//FbniWJ0t5T8gOYrPGZC4L43txWOhyP6azrObVGJ7n2KsXvfZqGY46CPBjk
         9ODpZZejIlfw9nq6gj1CG1oHAWUtAcj6hTOaZrZgvCVmdwiB0H70LwcApl+a1DHwGXmY
         GB7hp0lceP+YVqEbga7HVcupnwQjyha4U0713nOcu2uf7hPGZKH1lT5Dll/XwMtfa2AW
         e+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692005788; x=1692610588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x9GIkI+02jFm9GaovqHGnU7H+AqY3jsX4KEby4kRqP0=;
        b=isPFth6x4mbjCK/YNinKaptx0XJu+Db41qmauxE2rxjG1Lln6khfXskDwpYBxw8fzw
         9pBSkUJVMokgAIKK5jwTX8UZuWyMCiwLcAjtDqTurvOlII9Q/Ti11cr5vsshnTlb/JsA
         gkFnpZh97qhTKtI552UckbV80kHrdVmHHSOdM+UUZ6PYSayqhAct0NwJV60VErT4o6vC
         6Xobi6T9TI+N+3iSB6JGIPrj5AzEd7E9MHYLrHcORiZ30Yk32pj2ghfnQIic+nkomv1s
         nzspttHvEy1lunVC8anRiRSVr+pqHNkj8/P9Wjedd/IKlzSHHPea0DrukxGESiK6KsDk
         qpgQ==
X-Gm-Message-State: AOJu0YygtAIFaT7HNSieMVJlQGMXl0rAGKnVbmcBuew2Vuyr0lg31UQc
        SQv2RuDy/6I88h1iO1E0INiv7Q==
X-Google-Smtp-Source: AGHT+IFaC6Rol9Y8nb9mL70jZdV+uutTcBU5024FejmDgQwfHUC721qGuBg5I6GrWg6a8kDq+u8OgQ==
X-Received: by 2002:adf:ff92:0:b0:317:ed01:dc48 with SMTP id j18-20020adfff92000000b00317ed01dc48mr6349175wrr.9.1692005788084;
        Mon, 14 Aug 2023 02:36:28 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d0cb:d23e:f2fb:62b4])
        by smtp.gmail.com with ESMTPSA id d17-20020adfe851000000b003197839d68asm2422140wrn.97.2023.08.14.02.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 02:36:27 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 2/2] genirq: proc: fix a procfs entry leak
Date:   Mon, 14 Aug 2023 11:36:21 +0200
Message-Id: <20230814093621.23209-3-brgl@bgdev.pl>
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

When removing the proc entry for a desc that still has active users, we
will leak the irqaction entries. Let's remove them in
unregister_irq_proc().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 kernel/irq/proc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 83ed403991c6..b284604a091a 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -390,6 +390,15 @@ void register_irq_proc(unsigned int irq, struct irq_desc *desc)
 	mutex_unlock(&register_lock);
 }
 
+static void unregister_action_proc(struct irqaction *action)
+{
+	if (!action)
+		return;
+
+	unregister_action_proc(action->secondary);
+	unregister_handler_proc(action);
+}
+
 void unregister_irq_proc(unsigned int irq, struct irq_desc *desc)
 {
 	char name [MAX_NAMELEN];
@@ -408,6 +417,12 @@ void unregister_irq_proc(unsigned int irq, struct irq_desc *desc)
 #endif
 	remove_proc_entry("spurious", desc->dir);
 
+	/*
+	 * If at this point, this irq desc is still requested, we need to
+	 * remove the proc handler entries or we'll leak them.
+	 */
+	unregister_action_proc(desc->action);
+
 	sprintf(name, "%u", irq);
 	remove_proc_entry(name, root_irq_dir);
 }
-- 
2.39.2

