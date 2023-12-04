Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634C7803C5C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 19:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjLDSHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 13:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjLDSHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 13:07:12 -0500
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68886FA;
        Mon,  4 Dec 2023 10:07:16 -0800 (PST)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id B7D4610000A;
        Mon,  4 Dec 2023 21:07:14 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru B7D4610000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1701713234;
        bh=C1kd2llJNcGGgAraxX7oH4BfSAuepfS4aqwkW0KOQ7M=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=JMFIIEw+TJjmTZaUN2hwxIHFsYUAKZELyeJ7UiXtfsZsEkB9YNKyGrv8u/3IuFsZ9
         bZrWfC857T2TXB2I0K/DzVOWPR7BRbDwfryP1rrll4TFBsXiwNcP+lADCmDOWittk/
         L+cWaFO7Nl4L8x2di8RLkOv+n3yybtqNQgv/gqmcv7LreFSu8i2Bp/LTuKuMxO0KaI
         WGRNqhOCwXFAGujYvFY3nyP5pzCcBga70Org1s2OtNXM2wbXqIDtT8CjKUrYhFuhCD
         ZEopm8HY/eWEi9hELx5HgO/SW+s2CPEwIC84ryMu5wrcO3sBXH+m6xG6o5AxSlj84p
         zLb3c0DjmwJdg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Mon,  4 Dec 2023 21:07:14 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 4 Dec 2023 21:07:14 +0300
From:   George Stark <gnstark@salutedevices.com>
To:     <pavel@ucw.cz>, <lee@kernel.org>, <vadimp@nvidia.com>,
        <mpe@ellerman.id.au>, <npiggin@gmail.com>,
        <christophe.leroy@csgroup.eu>, <hdegoede@redhat.com>,
        <mazziesaccount@gmail.com>, <andy.shevchenko@gmail.com>,
        <jic23@kernel.org>
CC:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <kernel@salutedevices.com>,
        George Stark <gnstark@salutedevices.com>
Subject: [PATCH v2 01/10] devm-helpers: introduce devm_mutex_init
Date:   Mon, 4 Dec 2023 21:05:54 +0300
Message-ID: <20231204180603.470421-2-gnstark@salutedevices.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204180603.470421-1-gnstark@salutedevices.com>
References: <20231204180603.470421-1-gnstark@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181831 [Dec 04 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 5 0.3.5 98d108ddd984cca1d7e65e595eac546a62b0144b, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/12/04 11:06:00 #22624476
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
but wrong formally and can lead to a problem if mutex_destroy() is
extended so introduce devm_mutex_init().

Signed-off-by: George Stark <gnstark@salutedevices.com>
---
 include/linux/devm-helpers.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/devm-helpers.h b/include/linux/devm-helpers.h
index 74891802200d..2f56e476776f 100644
--- a/include/linux/devm-helpers.h
+++ b/include/linux/devm-helpers.h
@@ -76,4 +76,22 @@ static inline int devm_work_autocancel(struct device *dev,
 	return devm_add_action(dev, devm_work_drop, w);
 }
 
+static inline void devm_mutex_release(void *res)
+{
+	mutex_destroy(res);
+}
+
+/**
+ * devm_mutex_init - Resource-managed mutex initialization
+ * @dev:	Device which lifetime work is bound to
+ * @lock:	Pointer to a mutex
+ *
+ * Initialize mutex which is automatically destroyed when driver is detached.
+ */
+static inline int devm_mutex_init(struct device *dev, struct mutex *lock)
+{
+	mutex_init(lock);
+	return devm_add_action_or_reset(dev, devm_mutex_release, lock);
+}
+
 #endif
-- 
2.38.4

