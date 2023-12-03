Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACB180202E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 02:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjLCBNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 20:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCBNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 20:13:07 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA21CBB
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 17:13:12 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-33334480eb4so1477566f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 17:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1701565991; x=1702170791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CiRe3KaMz7qXr4nqou1C0i3C+8hu1AhqYe4Mk2ycjxk=;
        b=qGRKkziCucMhXyXECLDFB4ew8cLOsFh/RsJKfSB97B2WlzfsY5iPm8Reb3wpGcsl0J
         qKBTeeWMs7vqh3QI95HE5LAExPPvMM2WGb7g2y/UL54IWRzyrpuuXoWFF/t3+bgW5LSS
         TwgZa+uJgSMT/u42Wx2iKnAWb1oTn8obVWiYpEMJRXDlozmceZVqw3BTKV7APajFV1tp
         HhJFHwIRnilexLpH1GWH7H/P+SUM2clD3sFuErRlRppLDeTtStDUQ7I+K+hcG8cW81bK
         LL5POn0Ay4r7iXR+nDT1WtMNRONRFruVwUn7GRLOH5irPWqcI3uXzOOiEj+c9qxmcHPu
         Poew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701565991; x=1702170791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CiRe3KaMz7qXr4nqou1C0i3C+8hu1AhqYe4Mk2ycjxk=;
        b=IThTw5+phF4B7M1vSgbSUbIU2abRjfqcJYEL1srR+GH9O1T1Dgsv5VXBvyRCD9hFa+
         DK+z1k7jPMAeiooIzkPJsLDp/nG10C/EdcfPnpHvAslmPWAqn5Wp0UD2cCngeGNNRQ3H
         gwSohy0w8PQwzXf3agEzDrm6zk1QOMJjaD958dXZg+76ni4zPcPePdhJRxtrRHJ6Vuwu
         jB+oCOCNHet5ZDGUNcOwIjg27M9sCWGalBC1NOtPDnTq6OFWVS8dbIo+PLmmS9+vdFgZ
         0mc69i/k6O2H+I4lTiwe9L2oACOYUpsRSLxAv1n4dA8r3+L6zJCl4qda9a6pTUgsocfM
         q7HQ==
X-Gm-Message-State: AOJu0YwP6VuiEJFt/8eczVrFSCl4QNYzyrE1JWofRG+53e4eqDuCb4T/
        KHxWWKnWZIwjGMHbUHhskJjwmw==
X-Google-Smtp-Source: AGHT+IHRIfzLa8YKlslVe+YOb7SeJ6FggyLmRoDeS1w2HTCzwgsZ+I0NVpr/1ksa5YIq6cpJpDUUPw==
X-Received: by 2002:a05:6000:c50:b0:332:f025:e339 with SMTP id do16-20020a0560000c5000b00332f025e339mr2298801wrb.19.1701565991325;
        Sat, 02 Dec 2023 17:13:11 -0800 (PST)
Received: from airbuntu.. (host109-153-232-45.range109-153.btcentralplus.com. [109.153.232.45])
        by smtp.gmail.com with ESMTPSA id p8-20020a5d59a8000000b003333ed23356sm1831781wrr.4.2023.12.02.17.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 17:13:10 -0800 (PST)
From:   Qais Yousef <qyousef@layalina.io>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        John Stultz <jstultz@google.com>, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v2] rcu: Provide a boot time parameter to control lazy RCU
Date:   Sun,  3 Dec 2023 01:12:52 +0000
Message-Id: <20231203011252.233748-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow more flexible arrangements while still provide a single kernel
for distros, provide a boot time parameter to enable/disable lazy RCU.

Specify:

	rcutree.enable_rcu_lazy=[y|1|n|0]

Which also requires

	rcu_nocbs=all

at boot time to enable/disable lazy RCU.

To disable it by default at build time when CONFIG_RCU_LAZY=y, the new
CONFIG_RCU_LAZY_DEFAULT_OFF can be used.

Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---

Changes since v1:

	* Use module_param() instead of module_param_cb()
	* Add new CONFIG_RCU_LAZY_DEFAULT_OFF to force default off.
	* Remove unnecessary READ_ONCE()

Tested on qemu only this time with various config/boot configuration to ensure
expected values are in sysfs.

Did a bunch of build tests against various configs/archs.

 Documentation/admin-guide/kernel-parameters.txt |  5 +++++
 kernel/rcu/Kconfig                              | 13 +++++++++++++
 kernel/rcu/tree.c                               |  7 ++++++-
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 65731b060e3f..2f0386a12aa7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5021,6 +5021,11 @@
 			this kernel boot parameter, forcibly setting it
 			to zero.
 
+	rcutree.enable_rcu_lazy= [KNL]
+			To save power, batch RCU callbacks and flush after
+			delay, memory pressure or callback list growing too
+			big.
+
 	rcuscale.gp_async= [KNL]
 			Measure performance of asynchronous
 			grace-period primitives such as call_rcu().
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index bdd7eadb33d8..e7d2dd267593 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -314,6 +314,19 @@ config RCU_LAZY
 	  To save power, batch RCU callbacks and flush after delay, memory
 	  pressure, or callback list growing too big.
 
+	  Requires rcu_nocbs=all to be set.
+
+	  Use rcutree.enable_rcu_lazy=0 to turn it off at boot time.
+
+config RCU_LAZY_DEFAULT_OFF
+	bool "Turn RCU lazy invocation off by default"
+	depends on RCU_LAZY
+	default n
+	help
+	  Allows building the kernel with CONFIG_RCU_LAZY=y yet keep it default
+	  off. Boot time param rcutree.enable_rcu_lazy=1 can be used to switch
+	  it back on.
+
 config RCU_DOUBLE_CHECK_CB_TIME
 	bool "RCU callback-batch backup time check"
 	depends on RCU_EXPERT
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 3ac3c846105f..8b7675624815 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2719,6 +2719,9 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
 }
 
 #ifdef CONFIG_RCU_LAZY
+static bool enable_rcu_lazy __read_mostly = !IS_ENABLED(CONFIG_RCU_LAZY_DEFAULT_OFF);
+module_param(enable_rcu_lazy, bool, 0444);
+
 /**
  * call_rcu_hurry() - Queue RCU callback for invocation after grace period, and
  * flush all lazy callbacks (including the new one) to the main ->cblist while
@@ -2744,6 +2747,8 @@ void call_rcu_hurry(struct rcu_head *head, rcu_callback_t func)
 	__call_rcu_common(head, func, false);
 }
 EXPORT_SYMBOL_GPL(call_rcu_hurry);
+#else
+#define enable_rcu_lazy		false
 #endif
 
 /**
@@ -2792,7 +2797,7 @@ EXPORT_SYMBOL_GPL(call_rcu_hurry);
  */
 void call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
-	__call_rcu_common(head, func, IS_ENABLED(CONFIG_RCU_LAZY));
+	__call_rcu_common(head, func, enable_rcu_lazy);
 }
 EXPORT_SYMBOL_GPL(call_rcu);
 
-- 
2.34.1

