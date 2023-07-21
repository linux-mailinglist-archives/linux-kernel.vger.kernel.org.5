Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6903C75D0A3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 19:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjGUR0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 13:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjGUR0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 13:26:46 -0400
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE3F30F0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 10:26:08 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id MtsuqfxG71d2aMtsuqAyD5; Fri, 21 Jul 2023 19:25:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1689960345;
        bh=S0Q94L8t1F+wYZ+no5Ur/HtGB5I8fAPeAwIMg1DRGMg=;
        h=From:To:Cc:Subject:Date;
        b=GCQyWz5OgPbCw535Ns8tGqCkWOjzPWjvRJfIyEwCgTlQ6hZVa+cUjesHZcBpLkYQm
         IiKoNBx+KpiCP9aSZjSK06yWkqqsDACFYqUDzyIy4Uw8VwJ+rjoQLpmYzMQzjubx9P
         2zD5DkdOjH5PiuG9AP+uy2wNBvivtVDa8gwTz+xbsBQoPdTxjnAOKVUTQwQKvSoC77
         pDtw5QR01L1CiEZWV6G1T7vcZV7VAvw6JKrcJ3ZKQ2lidBlXYiv/6d6RslZsqOccwy
         Gsv6p9WVvjExhv93ZxnhEN7QaToEz8nl3CRtTyOZWirOWOwU3P+g2Y5E9JwS2hy8kp
         Fvk/eSbpDSxiw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 21 Jul 2023 19:25:45 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] regmap: Fix the type used for a bitmap pointer
Date:   Fri, 21 Jul 2023 19:25:43 +0200
Message-Id: <5600df5003d23da10efcfafbda97ca55776d0d29.1689960321.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bitmaps should be defined as 'unsigned long', not 'long'.
Fix the type of 'cache_present' is the 'struct regcache_rbtree_node'.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
No differences in the generated code with gcc 12.1.0.
---
 drivers/base/regmap/regcache-rbtree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regcache-rbtree.c b/drivers/base/regmap/regcache-rbtree.c
index fabf87058d80..4056c9d32ffa 100644
--- a/drivers/base/regmap/regcache-rbtree.c
+++ b/drivers/base/regmap/regcache-rbtree.c
@@ -22,7 +22,7 @@ struct regcache_rbtree_node {
 	/* block of adjacent registers */
 	void *block;
 	/* Which registers are present */
-	long *cache_present;
+	unsigned long *cache_present;
 	/* base register handled by this block */
 	unsigned int base_reg;
 	/* number of registers available in the block */
-- 
2.34.1

