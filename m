Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC08C80C84E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 12:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbjLKLmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 06:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234766AbjLKLm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 06:42:29 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA0ECD;
        Mon, 11 Dec 2023 03:42:31 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.88.194])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SpfxD4lNyz14M13;
        Mon, 11 Dec 2023 19:42:24 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (unknown [7.185.36.236])
        by mail.maildlp.com (Postfix) with ESMTPS id 100F8140517;
        Mon, 11 Dec 2023 19:42:30 +0800 (CST)
Received: from DESKTOP-8LI8G6S.china.huawei.com (10.174.149.11) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 19:42:29 +0800
From:   Gonglei <arei.gonglei@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <mst@redhat.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <lixiao91@huawei.com>,
        wangyangxin <wangyangxin1@huawei.com>,
        Gonglei <arei.gonglei@huawei.com>
Subject: [PATCH 2/2] crypto: virtio-crypto: Fix gcc check warnings
Date:   Mon, 11 Dec 2023 19:42:16 +0800
Message-ID: <1702294936-61080-3-git-send-email-arei.gonglei@huawei.com>
X-Mailer: git-send-email 2.8.2.windows.1
In-Reply-To: <1702294936-61080-1-git-send-email-arei.gonglei@huawei.com>
References: <1702294936-61080-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.149.11]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: wangyangxin <wangyangxin1@huawei.com>

Fix gcc check warnings in W=1 build mode.
Variable cpu not used when CONFIG_SMP not defined.

Fixes: dbaf0624ffa5 ("crypto: add virtio-crypto driver")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312040315.kPrI1OCE-lkp@int
el.com/
Signed-off-by: wangyangxin <wangyangxin1@huawei.com>
Signed-off-by: Gonglei <arei.gonglei@huawei.com>
---
 drivers/crypto/virtio/virtio_crypto_common.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_common.h b/drivers/crypto/virtio/virtio_crypto_common.h
index 7059bbe5a2eb..f0340bb7a10b 100644
--- a/drivers/crypto/virtio/virtio_crypto_common.h
+++ b/drivers/crypto/virtio/virtio_crypto_common.h
@@ -134,10 +134,9 @@ virtcrypto_clear_request(struct virtio_crypto_request *vc_req);
 
 static inline int virtio_crypto_get_current_node(void)
 {
-	int cpu, node;
+	int node;
 
-	cpu = get_cpu();
-	node = topology_physical_package_id(cpu);
+	node = topology_physical_package_id(get_cpu());
 	put_cpu();
 
 	return node;
-- 
2.33.0

