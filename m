Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0977B8134A1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573781AbjLNPXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573729AbjLNPXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:23:11 -0500
Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E32A1B9;
        Thu, 14 Dec 2023 07:23:14 -0800 (PST)
Received: from luzhipeng.223.5.5.5 (unknown [183.128.132.216])
        by mail-app3 (Coremail) with SMTP id cC_KCgCnERjUHXtlJKHhAA--.55199S2;
        Thu, 14 Dec 2023 23:23:01 +0800 (CST)
From:   Zhipeng Lu <alexious@zju.edu.cn>
To:     alexious@zju.edu.cn
Cc:     Edward Cree <ecree.xilinx@gmail.com>,
        Martin Habets <habetsm.xilinx@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-net-drivers@amd.com, linux-kernel@vger.kernel.org
Subject: [PATCH] sfc: fix a double-free bug in efx_probe_filters
Date:   Thu, 14 Dec 2023 23:22:46 +0800
Message-Id: <20231214152247.3482788-1-alexious@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cC_KCgCnERjUHXtlJKHhAA--.55199S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKw48uF1xuFy8JFWrKrWUXFb_yoWktFbE9r
        92gFn5Jr15AryFyw4jqw43Z3429r1Yvr1rAas7KFW3twnrJa47trZ09F93X347WFy7CF9r
        X39rtry3Aa429jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbx8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
        n2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
        6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHU
        DUUUUU=
X-CM-SenderInfo: qrsrjiarszq6lmxovvfxof0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In efx_probe_filters, the channel->rps_flow_id is freed in a
efx_for_each_channel marco  when success equals to 0.
However, after the following call chain:

efx_probe_filters
  |-> ef100_net_open
        |-> ef100_net_stop
              |-> efx_remove_filters

The channel->rps_flow_id is freed again in the efx_for_each_channel of
efx_remove_filters, triggering a double-free bug.

Fixes: a9dc3d5612ce ("sfc_ef100: RX filter table management and related gubbins")
Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
---
 drivers/net/ethernet/sfc/rx_common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/rx_common.c b/drivers/net/ethernet/sfc/rx_common.c
index d2f35ee15eff..fac227d372db 100644
--- a/drivers/net/ethernet/sfc/rx_common.c
+++ b/drivers/net/ethernet/sfc/rx_common.c
@@ -823,8 +823,10 @@ int efx_probe_filters(struct efx_nic *efx)
 		}
 
 		if (!success) {
-			efx_for_each_channel(channel, efx)
+			efx_for_each_channel(channel, efx) {
 				kfree(channel->rps_flow_id);
+				channel->rps_flow_id = NULL;
+			}
 			efx->type->filter_table_remove(efx);
 			rc = -ENOMEM;
 			goto out_unlock;
-- 
2.34.1

