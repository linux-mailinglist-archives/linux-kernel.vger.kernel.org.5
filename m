Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E01675BCE5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 05:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjGUDpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 23:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjGUDpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 23:45:13 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFB6272E
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 20:45:12 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R6b4w2MtfzVjnH;
        Fri, 21 Jul 2023 11:43:44 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 11:45:09 +0800
From:   Peng Zhang <zhangpeng362@huawei.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <willy@infradead.org>
CC:     <hch@infradead.org>, <sidhartha.kumar@oracle.com>,
        <akpm@linux-foundation.org>, <wangkefeng.wang@huawei.com>,
        <sunnanyong@huawei.com>, ZhangPeng <zhangpeng362@huawei.com>
Subject: [PATCH v4 03/10] mm/page_io: introduce bio_first_folio_all()
Date:   Fri, 21 Jul 2023 11:44:44 +0800
Message-ID: <20230721034451.16412-4-zhangpeng362@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230721034451.16412-1-zhangpeng362@huawei.com>
References: <20230721034451.16412-1-zhangpeng362@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600020.china.huawei.com (7.193.23.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ZhangPeng <zhangpeng362@huawei.com>

Introduce bio_first_folio_all() to return a folio, which makes it easier
to use.

Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
---
 Documentation/block/biovecs.rst | 1 +
 include/linux/bio.h             | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/block/biovecs.rst b/Documentation/block/biovecs.rst
index ddb867e0185b..b9dc0c9dbee4 100644
--- a/Documentation/block/biovecs.rst
+++ b/Documentation/block/biovecs.rst
@@ -134,6 +134,7 @@ Usage of helpers:
 	bio_for_each_bvec_all()
 	bio_first_bvec_all()
 	bio_first_page_all()
+	bio_first_folio_all()
 	bio_last_bvec_all()
 
 * The following helpers iterate over single-page segment. The passed 'struct
diff --git a/include/linux/bio.h b/include/linux/bio.h
index c4f5b5228105..027ff9ab5d12 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -253,6 +253,11 @@ static inline struct page *bio_first_page_all(struct bio *bio)
 	return bio_first_bvec_all(bio)->bv_page;
 }
 
+static inline struct folio *bio_first_folio_all(struct bio *bio)
+{
+	return page_folio(bio_first_page_all(bio));
+}
+
 static inline struct bio_vec *bio_last_bvec_all(struct bio *bio)
 {
 	WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED));
-- 
2.25.1

