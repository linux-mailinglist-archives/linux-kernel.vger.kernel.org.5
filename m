Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6395476052A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 04:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjGYCWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 22:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGYCW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 22:22:29 -0400
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF068CD;
        Mon, 24 Jul 2023 19:22:25 -0700 (PDT)
Received: from localhost.localdomain (unknown [39.174.92.167])
        by mail-app3 (Coremail) with SMTP id cC_KCgA3HbzAMb9kOIKkCw--.4468S4;
        Tue, 25 Jul 2023 10:21:53 +0800 (CST)
From:   Lin Ma <linma@zju.edu.cn>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, razor@blackwall.org, idosch@nvidia.com,
        lucien.xin@gmail.com, liuhangbin@gmail.com,
        edwin.peer@broadcom.com, jiri@resnulli.us,
        md.fahad.iqbal.polash@intel.com, anirudh.venkataramanan@intel.com,
        jeffrey.t.kirsher@intel.com, neerav.parikh@intel.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lin Ma <linma@zju.edu.cn>
Subject: [PATCH v1] rtnetlink: let rtnl_bridge_setlink checks IFLA_BRIDGE_MODE length
Date:   Tue, 25 Jul 2023 10:21:51 +0800
Message-Id: <20230725022151.417450-1-linma@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cC_KCgA3HbzAMb9kOIKkCw--.4468S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr4rAw15KF4Dtr45WrWkXrb_yoW8XF4xpa
        4rKa4xJF1DXr97Za17AFyrX3s7ZFZIgrW5Wr42ywn2yF9YqFyUCr98CFn0vry3AFsIqa43
        tr17Gr1avr1DGFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
        JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
        n2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wryl
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
        6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQvt
        AUUUUU=
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are totally 9 ndo_bridge_setlink handlers in the current kernel,
which are 1) bnxt_bridge_setlink, 2) be_ndo_bridge_setlink 3)
i40e_ndo_bridge_setlink 4) ice_bridge_setlink 5)
ixgbe_ndo_bridge_setlink 6) mlx5e_bridge_setlink 7)
nfp_net_bridge_setlink 8) qeth_l2_bridge_setlink 9) br_setlink.

By investigating the code, we find that 1-7 parse and use nlattr
IFLA_BRIDGE_MODE but 3 and 4 forget to do the nla_len check. This can
lead to an out-of-attribute read and allow a malformed nlattr (e.g.,
length 0) to be viewed as a 2 byte integer.

To avoid such issues, also for other ndo_bridge_setlink handlers in the
future. This patch adds the nla_len check in rtnl_bridge_setlink and
does an early error return if length mismatches.

Fixes: b1edc14a3fbf ("ice: Implement ice_bridge_getlink and ice_bridge_setlink")
Fixes: 51616018dd1b ("i40e: Add support for getlink, setlink ndo ops")
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Lin Ma <linma@zju.edu.cn>
---
 net/core/rtnetlink.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 3ad4e030846d..1e51291007ea 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -5148,6 +5148,11 @@ static int rtnl_bridge_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 				flags = nla_get_u16(attr);
 				break;
 			}
+
+			if (nla_type(attr) == IFLA_BRIDGE_MODE) {
+				if (nla_len(attr) < sizeof(u16))
+					return -EINVAL;
+			}
 		}
 	}
 
-- 
2.17.1

