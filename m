Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB307D8631
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345488AbjJZPuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 11:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345479AbjJZPuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:50:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F487196;
        Thu, 26 Oct 2023 08:50:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD90FC433C7;
        Thu, 26 Oct 2023 15:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698335415;
        bh=2TNYOlAWXSo2s3s0MUtNW5qeHxKzDFx3ObC+ajuBzvo=;
        h=From:Date:Subject:To:Cc:From;
        b=a0vlJmCmYlf9/apd7la5cvFEuusbJYvfjIz1qcz9wjIsLkiYuC3Fi5GS2TvFET3pc
         QRlxZT2qT7qYb2+CQLS69YUWI72lGqjUU3IFKXprabDIfKRSGPHyIgeaDdgwXpb7uh
         67FDiwdUgbN7P87+gvKiRiD8SIwzynvnAnLEYJmcpXIKGE90omnbjsIyAvYojUX53A
         f7u5dJdG0HcutOtn5gGHO1vXdCRqccsV+83iV5g8u+dvdWfAQ7K1lY+yZeYBZCuinQ
         uhEzbR2xAsDowfVGDeBAzd/ksfmyCC8lnpV+46CH/eY9HYrcKm8vdYzJClCw9IM8bh
         AvR90wL0K8rSA==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 26 Oct 2023 16:49:19 +0100
Subject: [PATCH] regmap: Ensure range selector registers are updated after
 cache sync
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231026-regmap-fix-selector-sync-v1-1-633ded82770d@kernel.org>
X-B4-Tracking: v=1; b=H4sIAH+KOmUC/x2MQQqDMBBFryKz7kASbRe9SnERkokOtFFmpCjBu
 zu4efDg/d9ASZgU3l0DoT8rL9XEPzpIc6wTIWdzCC703oUXCk2/uGLhHZW+lLZFUI+aMGb/9EM
 x5gI2X4Usuq8/43letFvR32oAAAA=
To:     Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=3008; i=broonie@kernel.org;
 h=from:subject:message-id; bh=2TNYOlAWXSo2s3s0MUtNW5qeHxKzDFx3ObC+ajuBzvo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlOoq13XfJMKLkO/6LHKkYMytONA8JC1UZg/ZKY9M1
 tXGBwOGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZTqKtQAKCRAk1otyXVSH0PujB/
 4i0FN10uwbwubidM8dysJf5BXaMoQCcR85HUy6JMnSSjFuukqe+zc/WONlibNM6Bbtvc1xiKCOAxsx
 98wmL1SCF9wSKLcsib5kHU5f9ZZpl0Zsfg/UgdQdse8hbcVksU3t3sF5I40pJgT6W2p+f7VY9VLyIR
 d0Bzt2wze2KQZM6SOiM9ljkQh5PgAxaQZdN3E92LS+QirepKHDC11UZatT/m0QXeYS6isIlKwc2QLm
 Y6jprBJGG1NTPPs8kuXFF3C8qlXzdnipWPHcWjXQTjetRFX7x5RwHoPCRD82xtiCa6mnadeY2l2Qnd
 /mMAD/DkgMz/+rnRCjGiZQKifuH/eY
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we sync the register cache we do so with the cache bypassed in order
to avoid overhead from writing the synced values back into the cache. If
the regmap has ranges and the selector register for those ranges is in a
register which is cached this has the unfortunate side effect of meaning
that the physical and cached copies of the selector register can be out of
sync after a cache sync. The cache will have whatever the selector was when
the sync started and the hardware will have the selector for the register
that was synced last.

Fix this by rewriting all cached selector registers after every sync,
ensuring that the hardware and cache have the same content. This will
result in extra writes that wouldn't otherwise be needed but is simple
so hopefully robust. We don't read from the hardware since not all
devices have physical read support.

Given that nobody noticed this until now it is likely that we are rarely if
ever hitting this case.

Reported-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/base/regmap/regcache.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index c5d151e9c481..92592f944a3d 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -334,6 +334,11 @@ static int regcache_default_sync(struct regmap *map, unsigned int min,
 	return 0;
 }
 
+static int rbtree_all(const void *key, const struct rb_node *node)
+{
+	return 0;
+}
+
 /**
  * regcache_sync - Sync the register cache with the hardware.
  *
@@ -351,6 +356,7 @@ int regcache_sync(struct regmap *map)
 	unsigned int i;
 	const char *name;
 	bool bypass;
+	struct rb_node *node;
 
 	if (WARN_ON(map->cache_type == REGCACHE_NONE))
 		return -EINVAL;
@@ -392,6 +398,30 @@ int regcache_sync(struct regmap *map)
 	/* Restore the bypass state */
 	map->cache_bypass = bypass;
 	map->no_sync_defaults = false;
+
+	/*
+	 * If we did any paging with cache bypassed and a cached
+	 * paging register then the register and cache state might
+	 * have gone out of sync, force writes of all the paging
+	 * registers.
+	 */
+	rb_for_each(node, 0, &map->range_tree, rbtree_all) {
+		struct regmap_range_node *this =
+			rb_entry(node, struct regmap_range_node, node);
+
+		/* If there's nothing in the cache there's nothing to sync */
+		ret = regcache_read(map, this->selector_reg, &i);
+		if (ret != 0)
+			continue;
+
+		ret = _regmap_write(map, this->selector_reg, i);
+		if (ret != 0) {
+			dev_err(map->dev, "Failed to write %x = %x: %d\n",
+				this->selector_reg, i, ret);
+			break;
+		}
+	}
+
 	map->unlock(map->lock_arg);
 
 	regmap_async_complete(map);

---
base-commit: 611da07b89fdd53f140d7b33013f255bf0ed8f34
change-id: 20231026-regmap-fix-selector-sync-ad1514fd15df

Best regards,
-- 
Mark Brown <broonie@kernel.org>

