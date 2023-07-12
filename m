Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244AF750EBF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 18:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbjGLQku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 12:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjGLQks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 12:40:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04971BFA
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 09:40:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4645A6182F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:40:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81DFDC433C7;
        Wed, 12 Jul 2023 16:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689180045;
        bh=Xaf8786M4BZAwaCyMWvrzMpoT9EgT4/vGgm/mwozBhY=;
        h=From:Date:Subject:To:Cc:From;
        b=FoUMILZTUGT93NMepLj+HQE3ZA+gIw4aWQZwKOfqAiQb/HIg3MrCao+26mP40W5Y2
         3pHznD6kNRZPTHwIly9/LvPPBgz+O8xji+pIsrZDR84LaYTPgUXPH3jCNGfd+drIzb
         CT11iKApGA1hTvL33vy6LJ1Zk4NSpFdYceLTxFq3ZpMrHz3cXd/58eh8QLFAx/PbWc
         XgGnTUvDGE80qz71+7LikWYc/wvUGsivF9JeboSBoY3tkuYnT6ZoaPHtqUiRMjxmL8
         QPLAOx0EnnLzlq4Z8JuM84ljWBbMBGbqos6NMCdGYCI9hCS8xDUe8JAPbEhlG6pCl9
         xCfmEIHQwyZMg==
From:   Mark Brown <broonie@kernel.org>
Date:   Wed, 12 Jul 2023 17:40:39 +0100
Subject: [PATCH] mfd: wcd934x: Update to use maple tree register cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230712-mfd-wcd934x-maple-v1-1-0d7aba4b0077@kernel.org>
X-B4-Tracking: v=1; b=H4sIAIbXrmQC/x2NywrCQAwAf6XkbKAmblF/RTzsI7UL7loS0ULpv
 7v1OAzDrGCiWQyu3Qoqn2z5VRscDx3EydeHYE6NgXrifiDGMib8xnTh04LFz0/BsyPHTjhQHKB
 1wZtgUF/jtJfF21t0F7PKmJf/7Hbfth8Q4e/PfAAAAA==
To:     Lee Jones <lee@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1263; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Xaf8786M4BZAwaCyMWvrzMpoT9EgT4/vGgm/mwozBhY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkrteKrccIvCvIXTXxhxq0ROJWKfeYX+K/dWjTA
 FEJ8QUBvMGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZK7XigAKCRAk1otyXVSH
 0Nq1B/9nCMAt1/e1zpJzHWUF9levm8FBmUGZKLIq/YaHNrDOb9FNXGX76lrPCkZM3JO4qtZll1f
 1NfsgpT1u+wvKKMHTMYvzN22YVw1BN6B5qyBLVBQWjXoBgpa/sOZfYcUImxUFqPkAulL61VTsRh
 rgUxCwZLXAH8SiZ+HzYTkX6GYmN6Ex/DibixbsKZ5tFmAFAHCK/33FTJbWUKuPjjpMwgv2IYiG+
 9Hhm6GvymzeCxvd5Q7V4B5k1QeB09/62WvbDxRnk6C5ZgKitL7vm/cOZRu0woAS9xEp2cO2prgE
 P5N8CylJI5+wCsVWE27fchH+XSUF8hOHnboT7buqG7UbqVVH
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache. In
v6.5 it has also acquired the ability to generate multi-register writes in
sync operations, bringing performance up to parity with the rbtree cache
there.

Update the wcd934x to use the more modern data structure.

Signed-off-by: Mark Brown <broonie@kernel.org>
---


Signed-off-by: Mark
---
 drivers/mfd/wcd934x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/wcd934x.c b/drivers/mfd/wcd934x.c
index 6b942d5270c1..7b9873b72c37 100644
--- a/drivers/mfd/wcd934x.c
+++ b/drivers/mfd/wcd934x.c
@@ -112,7 +112,7 @@ static const struct regmap_range_cfg wcd934x_ranges[] = {
 static struct regmap_config wcd934x_regmap_config = {
 	.reg_bits = 16,
 	.val_bits = 8,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.max_register = 0xffff,
 	.can_multi_write = true,
 	.ranges = wcd934x_ranges,

---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230623-mfd-wcd934x-maple-852535e3b2c6

Best regards,
-- 
Mark Brown <broonie@kernel.org>

