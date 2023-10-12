Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C277C6885
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 10:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235382AbjJLIRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 04:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235369AbjJLIRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 04:17:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C0698;
        Thu, 12 Oct 2023 01:17:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ABBBC433C7;
        Thu, 12 Oct 2023 08:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697098666;
        bh=kKM1/FVUExrLMQC4dwFAB0Kn9+SEc0qIzTH/g3iioCQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Um/yzqpBM5ntawTnSotFLEFiZZdIgG3bpVBcUsAnGLZ0Di8jvo8eCbI/vN1fUs03y
         qE+QLVLDQ2aMovHAfxwH8ZHlCITLOTeTLE9vQWUGgWtlHpzvtjDmXxZ2R7nkqDB4pg
         PT3B1cP7LKpTlguNNk6CwshozRija+2c+F3aW4HY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Alexander Potapenko <glider@google.com>,
        Xiaoke Wang <xkernel.wang@foxmail.com>, stable@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] lib/test_meminit: fix off-by-one error in test_pages()
Date:   Thu, 12 Oct 2023 10:17:39 +0200
Message-ID: <2023101238-greasily-reiterate-aafc@gregkh>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Lines:  31
X-Developer-Signature: v=1; a=openpgp-sha256; l=1112; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=kKM1/FVUExrLMQC4dwFAB0Kn9+SEc0qIzTH/g3iioCQ=; b=owGbwMvMwCRo6H6F97bub03G02pJDKnqqxeHlrRM3PrmvWQiy1SJN/HxhcHGUy/udA0+/EyQ4 yWT6fWijlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZiI1nWGBSsEGZ0fndaot27e eUxN63yq97niJoYF878r/tbcODk4oCLc3CT8u+XHnxu/AgA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit efb78fa86e95 ("lib/test_meminit: allocate pages up to order
MAX_ORDER"), the loop for testing pages is set to "<= MAX_ORDER" which
causes crashes in systems when run.  Fix this to "< MAX_ORDER" to fix
the test to work properly.

Fixes: efb78fa86e95 ("lib/test_meminit: allocate pages up to order MAX_ORDER")
Cc: Andrew Donnellan <ajd@linux.ibm.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Xiaoke Wang <xkernel.wang@foxmail.com>
Cc: <stable@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/test_meminit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_meminit.c b/lib/test_meminit.c
index 0ae35223d773..85d8dd8e01dc 100644
--- a/lib/test_meminit.c
+++ b/lib/test_meminit.c
@@ -93,7 +93,7 @@ static int __init test_pages(int *total_failures)
 	int failures = 0, num_tests = 0;
 	int i;
 
-	for (i = 0; i <= MAX_ORDER; i++)
+	for (i = 0; i < MAX_ORDER; i++)
 		num_tests += do_alloc_pages_order(i, &failures);
 
 	REPORT_FAILURES_IN_FN();
-- 
2.42.0

