Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8947AD3DC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbjIYIzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbjIYIzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:55:45 -0400
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371A9C0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:55:37 -0700 (PDT)
Received: from localhost (unknown [124.16.138.129])
        by APP-01 (Coremail) with SMTP id qwCowAC3vfV1ShFlTKihAw--.8010S2;
        Mon, 25 Sep 2023 16:53:09 +0800 (CST)
From:   Chen Ni <nichen@iscas.ac.cn>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, nichen@iscas.ac.cn, izumi.taku@jp.fujitsu.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fjes: Add missing check for vzalloc
Date:   Mon, 25 Sep 2023 08:53:18 +0000
Message-Id: <20230925085318.1228225-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAC3vfV1ShFlTKihAw--.8010S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKryDWr4Utr43tw45uFW3KFg_yoW3Krg_ur
        4IqF13u34j9r1qyr4DArW3Zryjvryvvr1IqwnaqrWaqrWkCan7A34xuwsrX3yUGay3ZFnr
        Jr9rtr13A34fJjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb2kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8ZwCF
        04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
        x4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUjNJ55UUUUU==
X-Originating-IP: [124.16.138.129]
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because of the potential failure of the vzalloc(), the hw->hw_info.trace
could be NULL.
Therefore, we need to check it and return -ENOMEM in order to transfer
the error.

Fixes: b6ba737d0b29 ("fjes: ethtool -w and -W support for fjes driver")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/net/fjes/fjes_hw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/fjes/fjes_hw.c b/drivers/net/fjes/fjes_hw.c
index 704e949484d0..3a06a3cf021d 100644
--- a/drivers/net/fjes/fjes_hw.c
+++ b/drivers/net/fjes/fjes_hw.c
@@ -330,6 +330,9 @@ int fjes_hw_init(struct fjes_hw *hw)
 	ret = fjes_hw_setup(hw);
 
 	hw->hw_info.trace = vzalloc(FJES_DEBUG_BUFFER_SIZE);
+	if (!hw->hw_info.trace)
+		return -ENOMEM;
+
 	hw->hw_info.trace_size = FJES_DEBUG_BUFFER_SIZE;
 
 	return ret;
-- 
2.25.1

