Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA39F79B404
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349113AbjIKVci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236525AbjIKKu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 06:50:28 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694AEE9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 03:50:22 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 38BAnDF3026510;
        Mon, 11 Sep 2023 18:49:13 +0800 (+08)
        (envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Rkk0N2ltsz2Rkw7N;
        Mon, 11 Sep 2023 18:46:12 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 11 Sep 2023 18:49:10 +0800
From:   "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <ke.wang@unisoc.com>
Subject: [PATCH] mm: remove redundant clear page when CONFIG_INIT_ON_ALLOC_DEFAULT_ON configured
Date:   Mon, 11 Sep 2023 18:49:06 +0800
Message-ID: <20230911104906.2058503-1-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.73.40]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 38BAnDF3026510
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

There will be redundant clear page within vma_alloc_zeroed_movable_folio
when CONFIG_INIT_ON_ALLOC_DEFAULT_ON is on. Remove it by judging related
configs.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 include/linux/highmem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 99c474de800d..3926f8414729 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -227,7 +227,7 @@ struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *vma,
 	struct folio *folio;
 
 	folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vaddr, false);
-	if (folio)
+	if (folio && !want_init_on_alloc(GFP_HIGHUSER_MOVABLE))
 		clear_user_highpage(&folio->page, vaddr);
 
 	return folio;
-- 
2.25.1

