Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007BD754CFC
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 03:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjGPBJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 21:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjGPBJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 21:09:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3433D271F
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 18:09:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C544060C47
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 01:09:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3452C433C7;
        Sun, 16 Jul 2023 01:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689469772;
        bh=5SSm4qEXPJuLohs5+byCGS3o4lRGePIKkaLKy1/+IXc=;
        h=From:To:Cc:Subject:Date:From;
        b=RNE0S0KQf9cRwje4zpnYyVSB45dXyxazFqRNu79k0NvYqvDcqN3SDgAQKkSSlThfu
         bvt8zjM+7qrgXnrITpz0BXGwD6EIWrjEvP8Sgouy+zj3Ti9+08V0ssNOZS4t84SVjB
         +i7dELXzNCAV4Ps/cElbr5vod97Fi8CSEMEzQsKkGpjCI4AAnTvKvmFtgbTxa0igmt
         jaz3LqNmLDx1Uirxipq9HaXZTwq2bhq0XjBjmWxL89463OKLVZYI9/hm0sA1muGdRd
         sBVyyfPI2Yan0+hwlQsdkB2X/Vo7PgdhJx7e4N8Sl0NgCz4jmCBnYdCKiKthemyOTr
         QSYdaRb4YsDzw==
From:   Chao Yu <chao@kernel.org>
To:     sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Chao Yu <chao@kernel.org>
Subject: [PATCH 1/2] mm/damon/dbgfs: reduce stack usage in str_to_schemes()
Date:   Sun, 16 Jul 2023 09:09:26 +0800
Message-Id: <20230716010927.3010606-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct damos_quota quota caused the stack usage of str_to_schemes() to
grow beyond the warning limit on 32-bit architectures w/ gcc.

mm/damon/dbgfs.c: In function ‘str_to_schemes’:
mm/damon/dbgfs.c:292:1: warning: the frame size of 1496 bytes is larger than 1024 bytes [-Wframe-larger-than=]

Allocating dynamic memory in str_to_schemes() to fix this issue.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 mm/damon/dbgfs.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index 124f0f8c97b7..78acc7366895 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -237,18 +237,26 @@ static struct damos **str_to_schemes(const char *str, ssize_t len,
 	int pos = 0, parsed, ret;
 	unsigned int action_input;
 	enum damos_action action;
+	struct damos_quota *quota;
 
 	schemes = kmalloc_array(max_nr_schemes, sizeof(scheme),
 			GFP_KERNEL);
 	if (!schemes)
 		return NULL;
 
+	quota = kmalloc(sizeof(struct damos_quota), GFP_KERNEL);
+	if (!quota) {
+		kfree(schemes);
+		return NULL;
+	}
+
 	*nr_schemes = 0;
 	while (pos < len && *nr_schemes < max_nr_schemes) {
 		struct damos_access_pattern pattern = {};
-		struct damos_quota quota = {};
 		struct damos_watermarks wmarks;
 
+		memset(quota, 0, sizeof(struct damos_quota));
+
 		ret = sscanf(&str[pos],
 				"%lu %lu %u %u %u %u %u %lu %lu %lu %u %u %u %u %lu %lu %lu %lu%n",
 				&pattern.min_sz_region, &pattern.max_sz_region,
@@ -256,10 +264,10 @@ static struct damos **str_to_schemes(const char *str, ssize_t len,
 				&pattern.max_nr_accesses,
 				&pattern.min_age_region,
 				&pattern.max_age_region,
-				&action_input, &quota.ms,
-				&quota.sz, &quota.reset_interval,
-				&quota.weight_sz, &quota.weight_nr_accesses,
-				&quota.weight_age, &wmarks.metric,
+				&action_input, &quota->ms,
+				&quota->sz, &quota->reset_interval,
+				&quota->weight_sz, &quota->weight_nr_accesses,
+				&quota->weight_age, &wmarks.metric,
 				&wmarks.interval, &wmarks.high, &wmarks.mid,
 				&wmarks.low, &parsed);
 		if (ret != 18)
@@ -278,15 +286,17 @@ static struct damos **str_to_schemes(const char *str, ssize_t len,
 			goto fail;
 
 		pos += parsed;
-		scheme = damon_new_scheme(&pattern, action, &quota, &wmarks);
+		scheme = damon_new_scheme(&pattern, action, quota, &wmarks);
 		if (!scheme)
 			goto fail;
 
 		schemes[*nr_schemes] = scheme;
 		*nr_schemes += 1;
 	}
+	kfree(quota);
 	return schemes;
 fail:
+	kfree(quota);
 	free_schemes_arr(schemes, *nr_schemes);
 	return NULL;
 }
-- 
2.40.1

