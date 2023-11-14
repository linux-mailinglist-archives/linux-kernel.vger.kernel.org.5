Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54FE7EAD28
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 10:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbjKNJi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 04:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbjKNJi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 04:38:27 -0500
Received: from cmccmta2.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 288C418E;
        Tue, 14 Nov 2023 01:38:20 -0800 (PST)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
        by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee565534009c5c-d14fe;
        Tue, 14 Nov 2023 17:38:17 +0800 (CST)
X-RM-TRANSID: 2ee565534009c5c-d14fe
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from ubuntu.localdomain (unknown[10.54.5.255])
        by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee565534008686-5bf03;
        Tue, 14 Nov 2023 17:38:17 +0800 (CST)
X-RM-TRANSID: 2ee565534008686-5bf03
From:   zhujun2 <zhujun2@cmss.chinamobile.com>
To:     shuah@kernel.org
Cc:     mathieu.desnoyers@efficios.com, zhujun2@cmss.chinamobile.com,
        ivan.orlov0322@gmail.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/media_tests: fix a resource leak
Date:   Tue, 14 Nov 2023 01:38:12 -0800
Message-Id: <20231114093812.7169-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
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



