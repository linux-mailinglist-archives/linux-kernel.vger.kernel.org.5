Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC2B75B05D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjGTNtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjGTNtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:49:47 -0400
Received: from out203-205-251-60.mail.qq.com (out203-205-251-60.mail.qq.com [203.205.251.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41998A2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1689860984;
        bh=pXW60cWQc6IVLFxjVvj7YpZW/1awm7nI8f7WBZ++PB0=;
        h=From:To:Cc:Subject:Date;
        b=Aq3Bw+BCcxdgCDvvAa3fqwDzj69wgcMLdEwyk8gdel78LBywHPRiCFX6/qeEH0Hl6
         RVSHwCg5jL/GRep42w7lvrvAZ6cDS+PXGTa2zdQSykD205K6MRBBwM9DKkzUj6i5nk
         3Njk/FGPtEH1h6c2G2y1bHF25h07o7HVjbGJkF0E=
Received: from linkpc.nju.edu.cn ([58.213.8.104])
        by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
        id C68A9691; Thu, 20 Jul 2023 21:49:40 +0800
X-QQ-mid: xmsmtpt1689860980tn9rzsk4s
Message-ID: <tencent_710619B2865DE8AC059D51A027D919CBD00A@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur9MiK9Mh21RRx51oFb4x9WBhNn4UDTn639pc4tGVsSTqKNyRa4Xg
         Q1QUnzgAW8GPIrMPjjUnEe85hK160jUTPb9nABOIEBtJlWLgTXCc/uXRqv1+odsLuOiU26CKKIDL
         8JPGv2g1U3n5cZGESqlvHOzHxNsvfeCQmglFwDeaNLCOpnHiAx1AUhagSwsx52l4+hqTxbMLXQP7
         DSnENmPGvdKp+TCg0BpuxajnNrX79wcQlEDZctavG68QP+XZcZI8x7q4jHOImM26qsO5uLThgYS8
         PkphtqL5jGTUm9b9ck5ONzAQk0KgWeR5dZIVU3WDrgUnjetA2gahOCYBatd0QSt0942X8bKvVb3Y
         Y2jr/SctdX8utM+y85pSWJVvlAYmigaEsk6wKZVJ32WwfSK9qporgqi6owFrbnwICKI6OW0yyxJz
         DWBKfafR0KcGC5KZNlwyom+0lzPt57gaj+BnAWUBIrOxxWkzazmkD4wJdZram93HpiHx51+ohkZS
         wpdFfD7QJBvLA4sKsGgVXa7Q2TofJFNPKlGTCfUkEBtO1NUtT/D8tT6DRJG/rOXqMP9vf8nFwYyG
         /a8pzBubKaFlHfLfEY7eD/6478UY1cjGSr5poT9g4ys3KsCMQs0OJaeIzD1JevoUacClx9BJOQnp
         78XD6o4sf/ZRS9aB9Jdbe9UdVWbim+maRjo9KQScq7PtD1wT8Ub6J+HHIxWtoztUEtJSSRjQiYfS
         gBuyTCGL9AA3xZPdgJBzpiLTGEwviQY0xTe7IdAQoiJijdm5NWGlZl5gS57uIx1T1pNddlta2Tp2
         +9u/S8oYkmxxMWNOS98vmfEg1l6IS7UDHyMxv+UsKiEXO7Fo87xrEVBXFA4nQyJnK+hYMaQBwcjT
         bfhzfJ9WJnqnBN0fEjgywojTlrLwfWl/Oe82aXLwhER0asFz7ysGilw0mJTIbxvEK7gEUBLjfz2u
         EW26SrvrCflB/+eOvJg2RNnhsA58aeSQcpIBpsra7o2c1jsOOuqSRdhGSpCPGw
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From:   Linke Li <lilinke99@foxmail.com>
To:     linux-mm@kvack.org
Cc:     mike.kravetz@oracle.com, muchun.song@linux.dev, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        dan.carpenter@linaro.org, Linke Li <lilinke99@gmail.com>
Subject: [PATCH v2] hugetlbfs: Fix integer overflow check in hugetlbfs_file_mmap()
Date:   Thu, 20 Jul 2023 21:49:39 +0800
X-OQ-MSGID: <20230720134939.121783-1-lilinke99@foxmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linke Li <lilinke99@gmail.com>

```
	vma_len = (loff_t)(vma->vm_end - vma->vm_start);
	len = vma_len + ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
	/* check for overflow */
	if (len < vma_len)
		return -EINVAL;
```

There is a signed integer overflow in the code, which is undefined
behavior according to the C stacnard. Although kernel disables some
optimizations by using the "-fno-strict-overflow" option, there is
still a risk.

Using macro "check_add_overflow" to do the overflow check can
effectively detect integer overflow and avoid any undefined behavior.

Signed-off-by: Linke Li <lilinke99@gmail.com>
---
 fs/hugetlbfs/inode.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 7b17ccfa039d..60f3010b0f71 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -155,9 +155,7 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 		return -EINVAL;
 
 	vma_len = (loff_t)(vma->vm_end - vma->vm_start);
-	len = vma_len + ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
-	/* check for overflow */
-	if (len < vma_len)
+    if (check_add_overflow(vma_len, (loff_t)vma->vm_pgoff << PAGE_SHIFT, &len))
 		return -EINVAL;
 
 	inode_lock(inode);
-- 
2.25.1

