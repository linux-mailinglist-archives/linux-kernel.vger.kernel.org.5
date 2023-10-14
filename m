Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D727C92FA
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 08:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbjJNGfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 02:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJNGfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 02:35:11 -0400
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65547C2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 23:35:03 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id rYEiqpnupvhM3rYEiqYMnU; Sat, 14 Oct 2023 08:35:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1697265301;
        bh=CxADXXhhxjM3tj/eg2DX7kLfA3AdAqKP4iJHaVmLDhs=;
        h=From:To:Cc:Subject:Date;
        b=ILrQ4XJbS8aVq6H2ZU6HW0E5LFiW+PZDIamMUNxW2ttR9mqFi48qE2Kkzf2egfDsQ
         l+RoM4OHVWa9Lv7u5o/qSMUVL4Romq48Z9BfW43m0SczUedDrNW1bXX2kwEOUnRK9P
         0r3hrsp/tYGbCn3ekbTAXnyu40mqE2oEBNLiPsfa3MANvqrrNiHJfSNRidlNvfFEoc
         4U1X+13yFgBcoWJNIg07jP5b6/d/xLQRTRCmX0B8xNj+gfKYa9dtsg0jK3mdFm0lu3
         GfPjdxZ4jMTs+PQBozZx/Zg7GhCmnshc9xkBcSl73W/DfkR2zYNnR/1HE7zleI6WNb
         yjVWG1rGushcA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 14 Oct 2023 08:35:01 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Pravin B Shelar <pshelar@ovn.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        netdev@vger.kernel.org, dev@openvswitch.org
Subject: [PATCH v2 1/2] net: openvswitch: Use struct_size()
Date:   Sat, 14 Oct 2023 08:34:52 +0200
Message-Id: <e5122b4ff878cbf3ed72653a395ad5c4da04dc1e.1697264974.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use struct_size() instead of hand writing it.
This is less verbose and more robust.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
v2: No change

v1: https://lore.kernel.org/all/8be59c9e06fca8eff2f264abb4c2f74db0b19a9e.1696156198.git.christophe.jaillet@wanadoo.fr/


This is IMHO more readable, even if not perfect.

However (untested):
+	new = kzalloc(size_add(struct_size(new, masks, size),
			       size_mul(sizeof(u64), size)), GFP_KERNEL);
looks completely unreadable to me.
---
 net/openvswitch/flow_table.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/openvswitch/flow_table.c b/net/openvswitch/flow_table.c
index 4f3b1798e0b2..d108ae0bd0ee 100644
--- a/net/openvswitch/flow_table.c
+++ b/net/openvswitch/flow_table.c
@@ -220,16 +220,13 @@ static struct mask_array *tbl_mask_array_alloc(int size)
 	struct mask_array *new;
 
 	size = max(MASK_ARRAY_SIZE_MIN, size);
-	new = kzalloc(sizeof(struct mask_array) +
-		      sizeof(struct sw_flow_mask *) * size +
+	new = kzalloc(struct_size(new, masks, size) +
 		      sizeof(u64) * size, GFP_KERNEL);
 	if (!new)
 		return NULL;
 
 	new->masks_usage_zero_cntr = (u64 *)((u8 *)new +
-					     sizeof(struct mask_array) +
-					     sizeof(struct sw_flow_mask *) *
-					     size);
+					     struct_size(new, masks, size));
 
 	new->masks_usage_stats = __alloc_percpu(sizeof(struct mask_array_stats) +
 						sizeof(u64) * size,
-- 
2.34.1

