Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8563755A61
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 05:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjGQDzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 23:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjGQDzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 23:55:33 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDB1E64
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 20:55:31 -0700 (PDT)
Received: from dggpeml500019.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R47WW5qYyzrRpW;
        Mon, 17 Jul 2023 11:54:47 +0800 (CST)
Received: from localhost.localdomain (10.90.76.33) by
 dggpeml500019.china.huawei.com (7.185.36.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 11:55:29 +0800
From:   Chenyuan Mi <michenyuan@huawei.com>
To:     <dan.j.williams@intel.com>
CC:     <Jonathan.Cameron@huawei.com>, <dave.jiang@intel.com>,
        <rrichter@amd.com>, <alison.schofield@intel.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] cxl: Fix memory leak bug in alloc_mock_res()
Date:   Mon, 17 Jul 2023 04:16:09 +0000
Message-ID: <20230717041609.1162445-1-michenyuan@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.76.33]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500019.china.huawei.com (7.185.36.137)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When gen_pool_alloc_algo() fails, the error handling path
forgets to free 'res'. It would cause a memory leak bug.

Fix it by add kfree() in error handling path.

Signed-off-by: Chenyuan Mi <michenyuan@huawei.com>
---
 tools/testing/cxl/test/cxl.c |   4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 0e78d8e19895..250ffd147067 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -405,8 +405,10 @@ static struct cxl_mock_res *alloc_mock_res(resource_size_t size, int align)
 	INIT_LIST_HEAD(&res->list);
 	phys = gen_pool_alloc_algo(cxl_mock_pool, size,
 				   gen_pool_first_fit_align, &data);
-	if (!phys)
+	if (!phys) {
+		kfree(res);
 		return NULL;
+	}
 
 	res->range = (struct range) {
 		.start = phys,
-- 
2.25.1

