Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA10A76A664
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 03:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbjHABdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 21:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbjHABd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 21:33:29 -0400
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 531FA114;
        Mon, 31 Jul 2023 18:33:25 -0700 (PDT)
Received: from localhost.localdomain (unknown [115.200.228.232])
        by mail-app2 (Coremail) with SMTP id by_KCgC3vorBYMhkoIHfCg--.63792S4;
        Tue, 01 Aug 2023 09:32:50 +0800 (CST)
From:   Lin Ma <linma@zju.edu.cn>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, daniel.machon@microchip.com, petrm@nvidia.com,
        linma@zju.edu.cn, peter.p.waskiewicz.jr@intel.com,
        jeffrey.t.kirsher@intel.com, alexander.h.duyck@intel.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Markus.Elfring@web.de, horms@kernel.org
Subject: [PATCH net v2] net: dcb: choose correct policy to parse DCB_ATTR_BCN
Date:   Tue,  1 Aug 2023 09:32:48 +0800
Message-Id: <20230801013248.87240-1-linma@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: by_KCgC3vorBYMhkoIHfCg--.63792S4
X-Coremail-Antispam: 1UD129KBjvJXoWxWw1xKw1DWFW5XF43Ar17Awb_yoW5Zw18pa
        4vgrykCayUJry3GrWDuFZY9a97Ww1UCr4UJr17WFyIyFW7tFn3K347GFyFgw18tF42vrZ7
        ur1Y9343ta1Yq3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
        JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoO
        J5UUUUU
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dcbnl_bcn_setcfg uses erroneous policy to parse tb[DCB_ATTR_BCN],
which is introduced in commit 859ee3c43812 ("DCB: Add support for DCB
BCN"). Please see the comment in below code

static int dcbnl_bcn_setcfg(...)
{
  ...
  ret = nla_parse_nested_deprecated(..., dcbnl_pfc_up_nest, .. )
  // !!! dcbnl_pfc_up_nest for attributes
  //  DCB_PFC_UP_ATTR_0 to DCB_PFC_UP_ATTR_ALL in enum dcbnl_pfc_up_attrs
  ...
  for (i = DCB_BCN_ATTR_RP_0; i <= DCB_BCN_ATTR_RP_7; i++) {
  // !!! DCB_BCN_ATTR_RP_0 to DCB_BCN_ATTR_RP_7 in enum dcbnl_bcn_attrs
    ...
    value_byte = nla_get_u8(data[i]);
    ...
  }
  ...
  for (i = DCB_BCN_ATTR_BCNA_0; i <= DCB_BCN_ATTR_RI; i++) {
  // !!! DCB_BCN_ATTR_BCNA_0 to DCB_BCN_ATTR_RI in enum dcbnl_bcn_attrs
  ...
    value_int = nla_get_u32(data[i]);
  ...
  }
  ...
}

That is, the nla_parse_nested_deprecated uses dcbnl_pfc_up_nest
attributes to parse nlattr defined in dcbnl_pfc_up_attrs. But the
following access code fetch each nlattr as dcbnl_bcn_attrs attributes.
By looking up the associated nla_policy for dcbnl_bcn_attrs. We can find
the beginning part of these two policies are "same".

static const struct nla_policy dcbnl_pfc_up_nest[...] = {
        [DCB_PFC_UP_ATTR_0]   = {.type = NLA_U8},
        [DCB_PFC_UP_ATTR_1]   = {.type = NLA_U8},
        [DCB_PFC_UP_ATTR_2]   = {.type = NLA_U8},
        [DCB_PFC_UP_ATTR_3]   = {.type = NLA_U8},
        [DCB_PFC_UP_ATTR_4]   = {.type = NLA_U8},
        [DCB_PFC_UP_ATTR_5]   = {.type = NLA_U8},
        [DCB_PFC_UP_ATTR_6]   = {.type = NLA_U8},
        [DCB_PFC_UP_ATTR_7]   = {.type = NLA_U8},
        [DCB_PFC_UP_ATTR_ALL] = {.type = NLA_FLAG},
};

static const struct nla_policy dcbnl_bcn_nest[...] = {
        [DCB_BCN_ATTR_RP_0]         = {.type = NLA_U8},
        [DCB_BCN_ATTR_RP_1]         = {.type = NLA_U8},
        [DCB_BCN_ATTR_RP_2]         = {.type = NLA_U8},
        [DCB_BCN_ATTR_RP_3]         = {.type = NLA_U8},
        [DCB_BCN_ATTR_RP_4]         = {.type = NLA_U8},
        [DCB_BCN_ATTR_RP_5]         = {.type = NLA_U8},
        [DCB_BCN_ATTR_RP_6]         = {.type = NLA_U8},
        [DCB_BCN_ATTR_RP_7]         = {.type = NLA_U8},
        [DCB_BCN_ATTR_RP_ALL]       = {.type = NLA_FLAG},
        // from here is somewhat different
        [DCB_BCN_ATTR_BCNA_0]       = {.type = NLA_U32},
        ...
        [DCB_BCN_ATTR_ALL]          = {.type = NLA_FLAG},
};

Therefore, the current code is buggy and this
nla_parse_nested_deprecated could overflow the dcbnl_pfc_up_nest and use
the adjacent nla_policy to parse attributes from DCB_BCN_ATTR_BCNA_0.

Hence use the correct policy dcbnl_bcn_nest to parse the nested
tb[DCB_ATTR_BCN] TLV.

Fixes: 859ee3c43812 ("DCB: Add support for DCB BCN")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
Reviewed-by: Simon Horman <horms@kernel.org>
---
V1 -> V2: 1. Change the commit message to imperative mood suggested
             by Markus.
          2. Add Reviewed-by tag from Simon

 net/dcb/dcbnl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/dcb/dcbnl.c b/net/dcb/dcbnl.c
index c0c438128575..2e6b8c8fd2de 100644
--- a/net/dcb/dcbnl.c
+++ b/net/dcb/dcbnl.c
@@ -980,7 +980,7 @@ static int dcbnl_bcn_setcfg(struct net_device *netdev, struct nlmsghdr *nlh,
 		return -EOPNOTSUPP;
 
 	ret = nla_parse_nested_deprecated(data, DCB_BCN_ATTR_MAX,
-					  tb[DCB_ATTR_BCN], dcbnl_pfc_up_nest,
+					  tb[DCB_ATTR_BCN], dcbnl_bcn_nest,
 					  NULL);
 	if (ret)
 		return ret;
-- 
2.17.1

