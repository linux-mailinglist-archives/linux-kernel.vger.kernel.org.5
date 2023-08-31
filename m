Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE46F78E772
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 09:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240863AbjHaH5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 03:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjHaH5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 03:57:14 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD361A4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 00:57:11 -0700 (PDT)
Received: from kwepemm600014.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RbthC4jW2zNmvm;
        Thu, 31 Aug 2023 15:53:31 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.175.28) by
 kwepemm600014.china.huawei.com (7.193.23.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 31 Aug 2023 15:57:09 +0800
From:   Yi Yang <yiyang13@huawei.com>
To:     <akpm@linux-foundation.org>, <machel@vivo.com>,
        <mhiramat@kernel.org>, <ast@kernel.org>,
        <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] lib: error-inject: fix error check for debugfs_create_file()
Date:   Thu, 31 Aug 2023 15:56:53 +0800
Message-ID: <20230831075653.238562-1-yiyang13@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.28]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600014.china.huawei.com (7.193.23.54)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The debugfs_create_file() function returns error pointers, it never
returns NULL, we need to check the return value correctly to avoid
debugfs_remove() is not called.

Fixes: 540adea3809f ("error-injection: Separate error-injection from kprobe")
Signed-off-by: Yi Yang <yiyang13@huawei.com>
---
 lib/error-inject.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/error-inject.c b/lib/error-inject.c
index 887acd9a6ea6..8bcdea5229eb 100644
--- a/lib/error-inject.c
+++ b/lib/error-inject.c
@@ -219,7 +219,7 @@ static int __init ei_debugfs_init(void)
 	dir = debugfs_create_dir("error_injection", NULL);
 
 	file = debugfs_create_file("list", 0444, dir, NULL, &ei_fops);
-	if (!file) {
+	if (IS_ERR(file)) {
 		debugfs_remove(dir);
 		return -ENOMEM;
 	}
-- 
2.17.1

