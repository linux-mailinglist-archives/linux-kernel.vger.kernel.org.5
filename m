Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0269792BAC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346386AbjIEQ4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354228AbjIEKMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:12:32 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0CC18D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 03:12:28 -0700 (PDT)
Received: from lhrpeml500004.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rg1X40rn0z6K6Kj;
        Tue,  5 Sep 2023 18:12:20 +0800 (CST)
Received: from mscphis00759.huawei.com (10.123.66.134) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 5 Sep 2023 11:12:26 +0100
From:   Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
To:     <richard@nod.at>
CC:     <chengzhihao1@huawei.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <yusongping@huawei.com>,
        <artem.kuzin@huawei.com>
Subject: [PATCH] ubifs: fix possible dereference after free
Date:   Tue, 5 Sep 2023 18:12:22 +0800
Message-ID: <20230905101222.1725230-1-konstantin.meskhidze@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.66.134]
X-ClientProxiedBy: mscpeml100002.china.huawei.com (7.188.26.75) To
 lhrpeml500004.china.huawei.com (7.191.163.9)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'old_idx' could be dereferenced after free via 'rb_link_node' function
call.

Fixes: b5fda08ef213 ("ubifs: Fix memleak when insert_old_idx() failed")
Co-developed-by: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
---
 fs/ubifs/tnc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ubifs/tnc.c b/fs/ubifs/tnc.c
index 6b7d95b65f4b..f4728e65d1bd 100644
--- a/fs/ubifs/tnc.c
+++ b/fs/ubifs/tnc.c
@@ -64,8 +64,9 @@ static void do_insert_old_idx(struct ubifs_info *c,
 			p = &(*p)->rb_right;
 		else {
 			ubifs_err(c, "old idx added twice!");
 			kfree(old_idx);
+			return;
 		}
 	}
 	rb_link_node(&old_idx->rb, parent, p);
 	rb_insert_color(&old_idx->rb, &c->old_idx);
-- 
2.34.1

