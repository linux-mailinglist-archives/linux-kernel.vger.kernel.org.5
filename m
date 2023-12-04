Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9B4802CAA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 09:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343664AbjLDIGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 03:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbjLDIGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 03:06:19 -0500
Received: from cmccmta2.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7362510C;
        Mon,  4 Dec 2023 00:06:08 -0800 (PST)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
        by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee8656d8867851-c7851;
        Mon, 04 Dec 2023 16:06:00 +0800 (CST)
X-RM-TRANSID: 2ee8656d8867851-c7851
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain.localdomain (unknown[10.54.5.252])
        by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee2656d8862379-275e9;
        Mon, 04 Dec 2023 16:05:59 +0800 (CST)
X-RM-TRANSID: 2ee2656d8862379-275e9
From:   liujing <liujing@cmss.chinamobile.com>
To:     shuah@kernel.org
Cc:     akpm@linux-foundation.org, adobriyan@gmail.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        liujing <liujing@cmss.chinamobile.com>
Subject: [PATCH] Fixed an open function not judging the return value and closed the open function
Date:   Mon,  4 Dec 2023 03:05:54 -0500
Message-Id: <20231204080554.2424-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: liujing <liujing@cmss.chinamobile.com>
---
 tools/testing/selftests/proc/proc-pid-vm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/proc/proc-pid-vm.c b/tools/testing/selftests/proc/proc-pid-vm.c
index cacbd2a4aec9..5fc9b46f236f 100644
--- a/tools/testing/selftests/proc/proc-pid-vm.c
+++ b/tools/testing/selftests/proc/proc-pid-vm.c
@@ -205,7 +205,12 @@ static int make_exe(const uint8_t *payload, size_t len)
 	/* Avoid ETXTBSY on exec. */
 	snprintf(buf, sizeof(buf), "/proc/self/fd/%u", fd);
 	fd1 = open(buf, O_RDONLY|O_CLOEXEC);
+	if (fd == -1) {
+		exit(1);
+	}
+
 	close(fd);
+	close(fd1);
 
 	return fd1;
 }
-- 
2.18.2



