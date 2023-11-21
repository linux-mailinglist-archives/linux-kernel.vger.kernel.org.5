Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0627F246F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 03:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbjKUC7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 21:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjKUC7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 21:59:31 -0500
Received: from cmccmta1.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D8553DC;
        Mon, 20 Nov 2023 18:59:24 -0800 (PST)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
        by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee2655c1d09f85-7c2b4;
        Tue, 21 Nov 2023 10:59:21 +0800 (CST)
X-RM-TRANSID: 2ee2655c1d09f85-7c2b4
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from ubuntu.localdomain (unknown[10.54.5.255])
        by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee7655c1d082ed-c5454;
        Tue, 21 Nov 2023 10:59:21 +0800 (CST)
X-RM-TRANSID: 2ee7655c1d082ed-c5454
From:   zhujun2 <zhujun2@cmss.chinamobile.com>
To:     kernel-janitors@vger.kernel.org
Cc:     mathieu.desnoyers@efficios.com, ivan.orlov0322@gmail.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, zhujun2@cmss.chinamobile.com
Subject: [PATCH] selftests/media_tests: fix a resource leak
Date:   Mon, 20 Nov 2023 18:59:18 -0800
Message-Id: <20231121025918.2570-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <8431b227-d053-4a9a-a278-2a43753fdaf7@efficios.com>
References: <8431b227-d053-4a9a-a278-2a43753fdaf7@efficios.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The opened file should be closed in main(), otherwise resource
leak will occur that this problem was discovered by code reading

Signed-off-by: zhujun2 <zhujun2@cmss.chinamobile.com>
---
 tools/testing/selftests/media_tests/media_device_open.c | 3 +++
 tools/testing/selftests/media_tests/media_device_test.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/tools/testing/selftests/media_tests/media_device_open.c b/tools/testing/selftests/media_tests/media_device_open.c
index 93183a37b133..2dfb2a11b148 100644
--- a/tools/testing/selftests/media_tests/media_device_open.c
+++ b/tools/testing/selftests/media_tests/media_device_open.c
@@ -70,6 +70,7 @@ int main(int argc, char **argv)
 	fd = open(media_device, O_RDWR);
 	if (fd == -1) {
 		printf("Media Device open errno %s\n", strerror(errno));
+		close(fd);
 		exit(-1);
 	}
 
@@ -79,4 +80,6 @@ int main(int argc, char **argv)
 	else
 		printf("Media device model %s driver %s\n",
 			mdi.model, mdi.driver);
+
+	close(fd);
 }
diff --git a/tools/testing/selftests/media_tests/media_device_test.c b/tools/testing/selftests/media_tests/media_device_test.c
index 4b9953359e40..7cabb62535a7 100644
--- a/tools/testing/selftests/media_tests/media_device_test.c
+++ b/tools/testing/selftests/media_tests/media_device_test.c
@@ -79,6 +79,7 @@ int main(int argc, char **argv)
 	fd = open(media_device, O_RDWR);
 	if (fd == -1) {
 		printf("Media Device open errno %s\n", strerror(errno));
+		close(fd);
 		exit(-1);
 	}
 
@@ -100,4 +101,6 @@ int main(int argc, char **argv)
 		sleep(10);
 		count--;
 	}
+
+	close(fd);
 }
-- 
2.17.1



