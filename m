Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B76756E44
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 22:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjGQUdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 16:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjGQUdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 16:33:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F20A191
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:33:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E75DB61278
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 20:33:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12199C433C7;
        Mon, 17 Jul 2023 20:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689625995;
        bh=asnEKCSLQS/uNfyRgYl+ksnbJzzBRAv8Ur+NiRrtqSE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=dfbHZzBNjmAh2GPJQXl4+PaLzVLBTGWLswICTnQVJW216Oo8KlI66DrLdViLmyf2C
         9rK28bfTGMx4Q0OHIrus77fko1PutrcwiMIHF41ViglSealy8zAZgcAwvU3SnTewYc
         oynzCKz+H5BOCykQKioEVO8XQlr6ea6iOYeG8yeFCCSUtoaWHfnZYYAzMpldeu/5Fd
         sPcKYDeBugl4TJ0gadfrRYF9R0wMV2mu822lsNUEbgr8dvQPF3RD39KWkCeriq7sU6
         2o/nO4NJQCSZ2LUcDVwOlVZPDyzep9NAdPclZDWYNki1And5yKrvoTOUWjZHu9l683
         g2XEA7uVOyktw==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 17 Jul 2023 21:33:03 +0100
Subject: [PATCH 1/3] regmap: Let users check if a register is cached
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-regmap-cache-check-v1-1-73ef688afae3@kernel.org>
References: <20230717-regmap-cache-check-v1-0-73ef688afae3@kernel.org>
In-Reply-To: <20230717-regmap-cache-check-v1-0-73ef688afae3@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1894; i=broonie@kernel.org;
 h=from:subject:message-id; bh=asnEKCSLQS/uNfyRgYl+ksnbJzzBRAv8Ur+NiRrtqSE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBktaWFmLfcJep5LqvVZiSrYHrXWYcDXZnPESyRi
 cO5BUNFXQKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZLWlhQAKCRAk1otyXVSH
 0IDsCACCdkNOcaAD2yxTysnsoFA5Go65pphKHCRH16FNb9l77a994IjWeN6pqJb/HoIhCx4v8qm
 NV9os3vvsXgvzc++6x42Fe0DnYKdlF4FWccBqddxjdYtGKxQFocxz6QxfDJMApOrf8jjgBQ2Lga
 LrrOASaENXQfKC1M7W/+MBpzvLhEzXi3Zlm9rtoGNce3EFxYe4XZBCWkT6LHlF/ggLDMk+4PjUo
 b5aVLhhWfO0rLd0ZodVPjM7S3IWWjsahQC0HiTZQB7QhVowINFH3+DFd7HjAPBQvLM/aQvw9lRx
 SR2v3OItdm7tkpng4SgeDNv76HdCJQIYiaYP0T5+q2VHcx5z
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

The HDA driver has a use case for checking if a register is cached which
it bodges in awkwardly and unclearly. Provide an API which allows it to
directly do what it's trying to do.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regcache.c | 23 +++++++++++++++++++++++
 include/linux/regmap.h         |  1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index 28bc3ae9458a..4d25a906b688 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -561,6 +561,29 @@ void regcache_cache_bypass(struct regmap *map, bool enable)
 }
 EXPORT_SYMBOL_GPL(regcache_cache_bypass);
 
+/**
+ * regcache_reg_cached - Check if a register is cached
+ *
+ * @map: map to check
+ * @reg: register to check
+ *
+ * Reports if a register is cached.
+ */
+bool regcache_reg_cached(struct regmap *map, unsigned int reg)
+{
+	unsigned int val;
+	int ret;
+
+	map->lock(map->lock_arg);
+
+	ret = regcache_read(map, reg, &val);
+
+	map->unlock(map->lock_arg);
+
+	return ret == 0;
+}
+EXPORT_SYMBOL_GPL(regcache_reg_cached);
+
 void regcache_set_val(struct regmap *map, void *base, unsigned int idx,
 		      unsigned int val)
 {
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 8fc0b3ebce44..c9182a47736e 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1287,6 +1287,7 @@ int regcache_drop_region(struct regmap *map, unsigned int min,
 void regcache_cache_only(struct regmap *map, bool enable);
 void regcache_cache_bypass(struct regmap *map, bool enable);
 void regcache_mark_dirty(struct regmap *map);
+bool regcache_reg_cached(struct regmap *map, unsigned int reg);
 
 bool regmap_check_range_table(struct regmap *map, unsigned int reg,
 			      const struct regmap_access_table *table);

-- 
2.39.2

