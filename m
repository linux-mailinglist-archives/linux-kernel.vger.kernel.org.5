Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144DE7FAEDB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 01:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbjK1AJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 19:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjK1AJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 19:09:16 -0500
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B68137
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 16:09:21 -0800 (PST)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id AD7BE100017;
        Tue, 28 Nov 2023 03:09:19 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru AD7BE100017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1701130159;
        bh=RspzObIsUHICsIUxC0hsMmw1kijkxCac0RSZzLLuBi8=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=vcv6HPoQN2WVZ+a3/EPmBjoXtkDeIOhhHZi1eiD1uPPIlc+qy2v8YkG9QDPhPkJn9
         nKcVdHObuAKuvmMMzs3gqYNmlpezkihpPfasMmO9jKh1uoOjwmQIFml4YIx0cHdaWe
         VkbvirCtQduEc6RJ23Loq3IfL48oOEKsVtC8KD5SF9Qct5QKv1aMOKcWMogpV+Yt4d
         +/DD+RNZJSmg7VQcs20RcUCaeu/UjA55JixEIYAeWeJNUAR3KrsB2aWlQcU3EL4ED/
         Q5HmQbHJqeElNn2aTEyvwe/Yr/cxYsE5D20b93/RdPCr+gVZgcYcC3CL2cCfl0IXLx
         MwzhoL96SHAaw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Tue, 28 Nov 2023 03:09:18 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 28 Nov 2023 03:09:18 +0300
From:   George Stark <gnstark@salutedevices.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <will@kernel.org>,
        <longman@redhat.com>, <boqun.feng@gmail.com>,
        <andriy.shevchenko@linux.intel.com>, <jic23@kernel.org>,
        <gnstark@salutedevices.com>
CC:     <linux-kernel@vger.kernel.org>, <kernel@salutedevices.com>
Subject: [RFC PATCH 1/1] locking: introduce devm_mutex_init and devm_mutex_destroy
Date:   Tue, 28 Nov 2023 03:09:10 +0300
Message-ID: <20231128000910.73784-1-gnstark@salutedevices.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181630 [Nov 27 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 5 0.3.5 98d108ddd984cca1d7e65e595eac546a62b0144b, {Tracking_from_domain_doesnt_match_to}, p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/27 21:09:00 #22555279
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

Using of devm API leads to certain order of releasing resources.
So all dependent resources which are not devm-wrapped should be deleted
with respect to devm-release order. Mutex is one of such objects that
often is bound to other resources and has no own devm wrapping.
Since mutex_destroy() actually does nothing in non-debug builds
frequently calling mutex_destroy() is just ignored which is safe for now
but wrong formally and can lead to a problem if mutex_destroy() will be
extended so introduce devm_mutex_init() and devm_mutex_destroy().

Signed-off-by: George Stark <gnstark@salutedevices.com>
---
 include/linux/mutex.h  |  3 +++
 kernel/locking/mutex.c | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index a33aa9eb9fc3..7f60cd842322 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -119,6 +119,9 @@ do {									\
 extern void __mutex_init(struct mutex *lock, const char *name,
 			 struct lock_class_key *key);
 
+int devm_mutex_init(struct device *dev, struct mutex *lock);
+void devm_mutex_destroy(struct device *dev, struct mutex *lock);
+
 /**
  * mutex_is_locked - is the mutex locked
  * @lock: the mutex to be queried
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index d973fe6041bf..a73124719dcb 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -56,6 +56,43 @@ __mutex_init(struct mutex *lock, const char *name, struct lock_class_key *key)
 }
 EXPORT_SYMBOL(__mutex_init);
 
+static void devm_mutex_release(struct device *dev, void *res)
+{
+	mutex_destroy(*(struct mutex **)res);
+}
+
+static int devm_mutex_match(struct device *dev, void *res, void *data)
+{
+	struct mutex **r = res;
+
+	if (WARN_ON(!r || !*r))
+		return 0;
+
+	return *r == data;
+}
+
+int devm_mutex_init(struct device *dev, struct mutex *lock)
+{
+	struct mutex **ptr;
+
+	ptr = devres_alloc(devm_mutex_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	mutex_init(lock);
+
+	*ptr = lock;
+	devres_add(dev, ptr);
+	return 0;
+}
+EXPORT_SYMBOL(devm_mutex_init);
+
+void devm_mutex_destroy(struct device *dev, struct mutex *lock)
+{
+	devres_release(dev, devm_mutex_release, devm_mutex_match, lock);
+}
+EXPORT_SYMBOL(devm_mutex_destroy);
+
 /*
  * @owner: contains: 'struct task_struct *' to the current lock owner,
  * NULL means not owned. Since task_struct pointers are aligned at
-- 
2.38.4

