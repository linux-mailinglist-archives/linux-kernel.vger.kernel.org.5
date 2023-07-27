Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7AB4764322
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 02:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjG0A5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 20:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjG0A5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 20:57:48 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E87A0;
        Wed, 26 Jul 2023 17:57:46 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VoIRP9O_1690419462;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VoIRP9O_1690419462)
          by smtp.aliyun-inc.com;
          Thu, 27 Jul 2023 08:57:43 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, jiri@resnulli.us
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH net-next] team: Remove NULL check before dev_{put, hold}
Date:   Thu, 27 Jul 2023 08:57:41 +0800
Message-Id: <20230727005741.114069-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call netdev_{put, hold} of dev_{put, hold} will check NULL,
so there is no need to check before using dev_{put, hold},
remove it to silence the warning:

./drivers/net/team/team.c:2325:3-10: WARNING: NULL check before dev_{put, hold} functions is not needed.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5991
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/net/team/team.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index d3dc22509ea5..bc50fc3f6913 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -2321,8 +2321,7 @@ static struct team *team_nl_team_get(struct genl_info *info)
 	ifindex = nla_get_u32(info->attrs[TEAM_ATTR_TEAM_IFINDEX]);
 	dev = dev_get_by_index(net, ifindex);
 	if (!dev || dev->netdev_ops != &team_netdev_ops) {
-		if (dev)
-			dev_put(dev);
+		dev_put(dev);
 		return NULL;
 	}
 
-- 
2.20.1.7.g153144c

