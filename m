Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91D2792C00
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351206AbjIERFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354162AbjIEJ71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 05:59:27 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC8118C;
        Tue,  5 Sep 2023 02:59:23 -0700 (PDT)
Received: from lhrpeml500004.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rg1CY4m95z6D8dW;
        Tue,  5 Sep 2023 17:58:01 +0800 (CST)
Received: from mscphis00759.huawei.com (10.123.66.134) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 5 Sep 2023 10:59:20 +0100
From:   Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
To:     <masahiroy@kernel.org>
CC:     <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yusongping@huawei.com>, <artem.kuzin@huawei.com>
Subject: [PATCH] kconfig: fix possible buffer overflow
Date:   Tue, 5 Sep 2023 17:59:14 +0800
Message-ID: <20230905095914.1699335-1-konstantin.meskhidze@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.66.134]
X-ClientProxiedBy: mscpeml100002.china.huawei.com (7.188.26.75) To
 lhrpeml500004.china.huawei.com (7.191.163.9)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Buffer 'new_argv' is accessed without bound check after accessing with
bound check via 'new_argc' index.

Fixes: e298f3b49def ("kconfig: add built-in function support")
Co-developed-by: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
---
 scripts/kconfig/preprocess.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/kconfig/preprocess.c b/scripts/kconfig/preprocess.c
index 748da578b418..d1f5bcff4b62 100644
--- a/scripts/kconfig/preprocess.c
+++ b/scripts/kconfig/preprocess.c
@@ -387,24 +387,27 @@ static char *eval_clause(const char *str, size_t len, int argc, char *argv[])
 			if (new_argc >= FUNCTION_MAX_ARGS)
 				pperror("too many function arguments");
 			new_argv[new_argc++] = prev;
 			prev = p + 1;
 		} else if (*p == '(') {
 			nest++;
 		} else if (*p == ')') {
 			nest--;
 		}
 
 		p++;
 	}
+
+	if (new_argc >= FUNCTION_MAX_ARGS)
+		pperror("too many function arguments");
 	new_argv[new_argc++] = prev;
 
 	/*
 	 * Shift arguments
 	 * new_argv[0] represents a function name or a variable name.  Put it
 	 * into 'name', then shift the rest of the arguments.  This simplifies
 	 * 'const' handling.
 	 */
 	name = expand_string_with_args(new_argv[0], argc, argv);
 	new_argc--;
 	for (i = 0; i < new_argc; i++)
 		new_argv[i] = expand_string_with_args(new_argv[i + 1],
-- 
2.34.1

