Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8AB07C7597
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 20:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442051AbjJLSBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 14:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442006AbjJLSBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 14:01:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005C9DA;
        Thu, 12 Oct 2023 11:01:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9FF0C433C9;
        Thu, 12 Oct 2023 18:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697133673;
        bh=QFecizGKt2XzydnEGdzznTEe7ougz7DAeR8j0nzXygc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DMuRQoiK6bHpZsT8I6pivOrbIDkfr9gWP+8JAK3rIodq8z9/Heo6IiNsWLp9HviUb
         JMYnED3NQGeDdTnzmnlOoUfZtqC1iql2IIEmRmc81GEB2opteuiSteNxv12YmQK5Ik
         RBnqKOop9/SeZiW/eNpQyHtLAoeULgKiK7mJEJpw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andrew Donnellan <ajd@linux.ibm.com>,
        Alexander Potapenko <glider@google.com>,
        Xiaoke Wang <xkernel.wang@foxmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1 6/6] lib/test_meminit: fix off-by-one error in test_pages()
Date:   Thu, 12 Oct 2023 20:00:48 +0200
Message-ID: <20231012180030.279678796@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231012180030.112560642@linuxfoundation.org>
References: <20231012180030.112560642@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit efb78fa86e95 ("lib/test_meminit: allocate pages up to order
MAX_ORDER") works great in kernels 6.4 and newer thanks to commit
23baf831a32c ("mm, treewide: redefine MAX_ORDER sanely"), but for older
kernels, the loop is off by one, which causes crashes when the test
runs.

Fix this up by changing "<= MAX_ORDER" "< MAX_ORDER" to allow the test
to work properly for older kernel branches.

Fixes: 421855d0d24d ("lib/test_meminit: allocate pages up to order MAX_ORDER")
Cc: Andrew Donnellan <ajd@linux.ibm.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Xiaoke Wang <xkernel.wang@foxmail.com>
Cc: <stable@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/test_meminit.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/lib/test_meminit.c
+++ b/lib/test_meminit.c
@@ -93,7 +93,7 @@ static int __init test_pages(int *total_
 	int failures = 0, num_tests = 0;
 	int i;
 
-	for (i = 0; i <= MAX_ORDER; i++)
+	for (i = 0; i < MAX_ORDER; i++)
 		num_tests += do_alloc_pages_order(i, &failures);
 
 	REPORT_FAILURES_IN_FN();


