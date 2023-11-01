Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2909A7DDEE0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 11:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbjKAKFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 06:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjKAKFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 06:05:10 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0CFDA
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 03:05:05 -0700 (PDT)
Received: from dggpemm500011.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SL2ZR2TxYzPp0C;
        Wed,  1 Nov 2023 18:00:47 +0800 (CST)
Received: from huawei.com (10.175.104.170) by dggpemm500011.china.huawei.com
 (7.185.36.110) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 1 Nov
 2023 18:04:52 +0800
From:   Ren Mingshuai <renmingshuai@huawei.com>
To:     <jirislaby@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <caowangbao@huawei.com>, <yanan@huawei.com>, <liaichun@huawei.com>
Subject: [PATCH] CAPI: Return -ENOMEM instead of -1
Date:   Wed, 1 Nov 2023 18:04:50 +0800
Message-ID: <20231101100450.120680-1-renmingshuai@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500011.china.huawei.com (7.185.36.110)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is more reasonable to return -ENOMEM instead of -1 when kmalloc
failed, although the caller doesn't care.

smatch warinings:
drivers/isdn/capi/capi.c:151 capiminor_add_ack() warn: returning -1 instead of -ENOMEM is sloppy

Signed-off-by: Ren Mingshuai <renmingshuai@huawei.com>
---
 drivers/isdn/capi/capi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/isdn/capi/capi.c b/drivers/isdn/capi/capi.c
index 2f3789515..6522f031a 100644
--- a/drivers/isdn/capi/capi.c
+++ b/drivers/isdn/capi/capi.c
@@ -149,7 +149,7 @@ static int capiminor_add_ack(struct capiminor *mp, u16 datahandle)
 	n = kmalloc(sizeof(*n), GFP_ATOMIC);
 	if (unlikely(!n)) {
 		printk(KERN_ERR "capi: alloc datahandle failed\n");
-		return -1;
+		return -ENOMEM;
 	}
 	n->datahandle = datahandle;
 	INIT_LIST_HEAD(&n->list);
-- 
2.27.0

