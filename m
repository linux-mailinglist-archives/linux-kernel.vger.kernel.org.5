Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D4579D027
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbjILLhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234996AbjILLgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:36:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C75E98
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 04:36:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FDA6C433C7;
        Tue, 12 Sep 2023 11:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694518611;
        bh=hWdIAXbpcAzILmAOadWsIIoXYCILRlwaxE0WMmyIs4k=;
        h=From:Date:Subject:To:Cc:From;
        b=u6src8WbsPa1dN03XNXRc8ehUQ97ADMKfNWWgG8fpchbR7UW202af166xj5k3ujAG
         ikNo8B0Ho79V/uHrSPRZcjabMcVa9kvuftDNPP96pZG++b7BC9b0pi0Z1RKuNKuOqi
         iQFhTr2l4vB7/sHOkqm8CeNeP0Rb0pXeS/5sY8109mJpTPjG5yGBdgbett4XOJdoqN
         vTEsW0xXZSYrZERADcBTrO8BqAdCe99ax4s+dYQNciNhZqTm8/oErrvy1nyGlUflML
         1pjViS/utwWB53hKMgzDEfYgMFjlv8ZfD8pqMjFHy9RNlb16FtvgQHE8VvStu3ThGt
         k1e0o+2rcX2ng==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 12 Sep 2023 12:36:46 +0100
Subject: [PATCH v2] mfd: wcd934x: Update to use maple tree register cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230912-mfd-wcd934x-maple-v2-1-292a154113e3@kernel.org>
X-B4-Tracking: v=1; b=H4sIAE1NAGUC/22Nyw6CMBBFf4V07ZjSAlVX/odh0ccAjVLIlCCG8
 O8W3Lo89+bkrCwieYzslq2McPbRDyGBOGXMdjq0CN4lZoILySshoW8cvK27ymKBXo8vhEspSlm
 iNMJWLHlGRwRDOthuN3sdJ6T9GAkbvxyxR52483Ea6HO053xffxmViz+ZOYccuFPa6MJwrtT9i
 RTwdR6oZfW2bV9NLRuZzAAAAA==
To:     Lee Jones <lee@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1406; i=broonie@kernel.org;
 h=from:subject:message-id; bh=hWdIAXbpcAzILmAOadWsIIoXYCILRlwaxE0WMmyIs4k=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlAE1QacasghZtHKjysimim3SOUAZ7QKui6Y0cG
 fM719ze4EKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZQBNUAAKCRAk1otyXVSH
 0JshB/9AsfhQLIMWztpfzgPjJyS2QSJylJCkG7LOcPDE1tfuRPIdjq491DxqeiesUlrK+psSh9Y
 H7tBFNXZJB/R4O3INBcS6kCTGxRoGz08Tjpoui319GIUgVL/hQRBN55fr5JGtflSD6xenZ+4rpn
 +TEyfoXdpOxakFFt/+v1CGeoXKtJJXuoEnaT0jg8Uy9H57FBOMy1C1/1+kDqUjZxA8Z/aIBRhWY
 QEU3sNyWHwcLgPn1k++ld1nJYjrGW0bfewFn9jvH74gdU49mgBxS5yWaoe5tpugDdqE6ilUS6uD
 BDuJP3gfVYGLe29SjayoR8PcOuHufFrkVymBlU4HvtHDdb0s
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
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
Changes in v2:
- Rebase onto v6.6-rc1.
- Link to v1: https://lore.kernel.org/r/20230712-mfd-wcd934x-maple-v1-1-0d7aba4b0077@kernel.org
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
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20230623-mfd-wcd934x-maple-852535e3b2c6

Best regards,
-- 
Mark Brown <broonie@kernel.org>

