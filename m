Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9949C81217B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 23:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442818AbjLMWac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 17:30:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjLMWa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 17:30:26 -0500
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72627DC;
        Wed, 13 Dec 2023 14:30:30 -0800 (PST)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 2F4C010000B;
        Thu, 14 Dec 2023 01:30:28 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 2F4C010000B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1702506628;
        bh=kF9z8Zs1NRPVQ38LR3pEhvUwo7xq0rlkJwa/lSFCewY=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=QQknCQHV9d+Gfy+NW/NmGZk5I0Qpsv4KYKdNMQ6mHsNnjApsyAfBiN0XSWX8iaH2W
         YKj5QVf89sohWLQbG0jVMCPGZIm58cfe6qLaq9lEKEyVPzn3NcuV8641Ll4sLD1OIa
         AwASqbcHQeYoegB3kgOcq/rLXTLb787MI2o7lalWa/WMRFVGFmB51tRb/eThCNmhc4
         +nSCGUmgh+WGHkNQnJm+HsldGQXoauZQf8qujipQJ+6qFmJxcsSzHhlKImLLo06dnW
         PERYE3pLbrqhsocVfXg/dU5ZBVYlcOgdRW+tB9q1ViM6dw6vAbD3Be4snZQryWHDu9
         iI+WZDZVVqbrw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Thu, 14 Dec 2023 01:30:27 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Dec 2023 01:30:27 +0300
From:   George Stark <gnstark@salutedevices.com>
To:     <andy.shevchenko@gmail.com>, <pavel@ucw.cz>, <lee@kernel.org>,
        <vadimp@nvidia.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
        <christophe.leroy@csgroup.eu>, <hdegoede@redhat.com>,
        <mazziesaccount@gmail.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <will@kernel.org>, <longman@redhat.com>,
        <boqun.feng@gmail.com>, <nikitos.tr@gmail.com>
CC:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <kernel@salutedevices.com>,
        George Stark <gnstark@salutedevices.com>
Subject: [PATCH v3 03/11] devm-helpers: introduce devm_mutex_init
Date:   Thu, 14 Dec 2023 01:30:12 +0300
Message-ID: <20231213223020.2713164-4-gnstark@salutedevices.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231213223020.2713164-1-gnstark@salutedevices.com>
References: <20231213223020.2713164-1-gnstark@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 182098 [Dec 13 2023]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;127.0.0.199:7.1.2;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/12/13 21:35:00 #22672360
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using of devm API leads to a certain order of releasing resources.
So all dependent resources which are not devm-wrapped should be deleted
with respect to devm-release order. Mutex is one of such objects that
often is bound to other resources and has no own devm wrapper.
Since mutex_destroy() actually does nothing in non-debug builds
frequently calling mutex_destroy() is just ignored which is safe for now
but wrong formally and can lead to a problem if mutex_destroy() is
extended so introduce devm_mutex_init().

Signed-off-by: George Stark <gnstark@salutedevices.com>
---
 include/linux/devm-helpers.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/linux/devm-helpers.h b/include/linux/devm-helpers.h
index 74891802200d..4043c3481d2e 100644
--- a/include/linux/devm-helpers.h
+++ b/include/linux/devm-helpers.h
@@ -24,6 +24,7 @@
  */
 
 #include <linux/device.h>
+#include <linux/mutex.h>
 #include <linux/workqueue.h>
 
 static inline void devm_delayed_work_drop(void *res)
@@ -76,4 +77,30 @@ static inline int devm_work_autocancel(struct device *dev,
 	return devm_add_action(dev, devm_work_drop, w);
 }
 
+#ifdef mutex_destroy
+static inline void devm_mutex_release(void *res)
+{
+	mutex_destroy(res);
+}
+#endif
+
+/**
+ * devm_mutex_init - Resource-managed mutex initialization
+ * @dev:	Device which lifetime mutex is bound to
+ * @lock:	Pointer to a mutex
+ *
+ * Initialize mutex which is automatically destroyed when the driver is detached.
+ *
+ * Returns: 0 on success or a negative error code on failure.
+ */
+static inline int devm_mutex_init(struct device *dev, struct mutex *lock)
+{
+	mutex_init(lock);
+#ifdef mutex_destroy
+	return devm_add_action_or_reset(dev, devm_mutex_release, lock);
+#else
+	return 0;
+#endif
+}
+
 #endif
-- 
2.25.1

