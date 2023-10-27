Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6387D8DAE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 06:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345200AbjJ0EBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 00:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJ0EB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 00:01:29 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E59E1B2;
        Thu, 26 Oct 2023 21:01:24 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VuzXPJb_1698379259;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VuzXPJb_1698379259)
          by smtp.aliyun-inc.com;
          Fri, 27 Oct 2023 12:01:19 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     rajur@chelsio.com
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] cxgb4: Fix missing error code in cxgb4_port_mirror_alloc()
Date:   Fri, 27 Oct 2023 12:00:57 +0800
Message-Id: <20231027040057.67810-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The error code is missing in this code scenario, add the error code
'-EINVAL' to the return value 'ret'.

drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c:1525 cxgb4_port_mirror_alloc() warn: missing error code 'ret'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7063
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index 2eb33a727bba..e59e199184f4 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -1522,6 +1522,7 @@ int cxgb4_port_mirror_alloc(struct net_device *dev)
 	mutex_lock(&pi->vi_mirror_mutex);
 	if (pi->viid_mirror) {
 		pi->vi_mirror_count++;
+		ret = -EINVAL;
 		goto out_unlock;
 	}
 
-- 
2.20.1.7.g153144c

