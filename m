Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2157F97D3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 04:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbjK0DGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 22:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbjK0DGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 22:06:04 -0500
X-Greylist: delayed 534 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 26 Nov 2023 19:06:09 PST
Received: from mail-m24124.xmail.ntesmail.com (mail-m24124.xmail.ntesmail.com [45.195.24.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D87123
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 19:06:09 -0800 (PST)
Received: from fedora.. (unknown [211.103.144.18])
        by mail-m2838.qiye.163.com (Hmail) with ESMTPA id E2BBA3C0140;
        Mon, 27 Nov 2023 10:56:53 +0800 (CST)
From:   fuqiang wang <fuqiang.wang@easystack.cn>
To:     Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kexec: avoid out of bounds in crash_exclude_mem_range()
Date:   Mon, 27 Nov 2023 10:56:39 +0800
Message-ID: <20231127025641.62210-1-fuqiang.wang@easystack.cn>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlDQkMdVhkYGEtMTRkfSU0dSFUZERMWGhIXJBQOD1
        lXWRgSC1lBWUlKSlVKS0hVSk9PVUpDWVdZFhoPEhUdFFlBWU9LSFVKTU9JTE5VSktLVUpCS0tZBg
        ++
X-HM-Tid: 0a8c0eb555fa8420kuqwe2bba3c0140
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mk06Pxw5TDErKy0POVYIPA80
        FSJPChxVSlVKTEtKS05IQ0pOS09DVTMWGhIXVR0OChIaFRxVDBoVHDseGggCCA8aGBBVGBVFWVdZ
        EgtZQVlJSkpVSktIVUpPT1VKQ1lXWQgBWUFJSUhLNwY+
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the split happened, judge whether mem->nr_ranges is equal to
mem->max_nr_ranges. If it is true, return -ENOMEM.

The advantage of doing this is that it can avoid array bounds caused by
some bugs. E.g., Before commit 4831be702b95 ("arm64/kexec: Fix missing
extra range for crashkres_low."), reserve both high and low memories for
the crashkernel may cause out of bounds.

On the other hand, move this code before the split to ensure that the
array will not be changed when return error.

Signed-off-by: fuqiang wang <fuqiang.wang@easystack.cn>
---
 kernel/crash_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index efe87d501c8c..ffdc246cf425 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -611,6 +611,9 @@ int crash_exclude_mem_range(struct crash_mem *mem,
 		}
 
 		if (p_start > start && p_end < end) {
+			/* Split happened */
+			if (mem->nr_ranges == mem->max_nr_ranges)
+				return -ENOMEM;
 			/* Split original range */
 			mem->ranges[i].end = p_start - 1;
 			temp_range.start = p_end + 1;
@@ -626,9 +629,6 @@ int crash_exclude_mem_range(struct crash_mem *mem,
 	if (!temp_range.end)
 		return 0;
 
-	/* Split happened */
-	if (i == mem->max_nr_ranges - 1)
-		return -ENOMEM;
 
 	/* Location where new range should go */
 	j = i + 1;
-- 
2.42.0

