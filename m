Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360967CD4A3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 08:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjJRGsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 02:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjJRGs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 02:48:29 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9707B0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 23:48:26 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VuPuRWb_1697611697;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VuPuRWb_1697611697)
          by smtp.aliyun-inc.com;
          Wed, 18 Oct 2023 14:48:23 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     pmladek@suse.com
Cc:     rostedt@goodmis.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, senozhatsky@chromium.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] lib/vsprintf: Remove redundant code
Date:   Wed, 18 Oct 2023 14:48:17 +0800
Message-Id: <20231018064817.86721-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When variable needcolon is assigned a value of false, it must be
assigned a value of true later on, which is redundant code.

lib/vsprintf.c:1411:4: warning: Value stored to 'needcolon' is never read.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6909
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 lib/vsprintf.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index afb88b24fa74..9a9086885da8 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1406,10 +1406,9 @@ char *ip6_compressed_string(char *p, const char *addr)
 			i += longest - 1;
 			continue;
 		}
-		if (needcolon) {
+		if (needcolon)
 			*p++ = ':';
-			needcolon = false;
-		}
+
 		/* hex u16 without leading 0s */
 		word = ntohs(in6.s6_addr16[i]);
 		hi = word >> 8;
-- 
2.20.1.7.g153144c

