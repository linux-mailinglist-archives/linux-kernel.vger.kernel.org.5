Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2304A7F4A8B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344365AbjKVPeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235201AbjKVPdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:33:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5181BC9;
        Wed, 22 Nov 2023 07:33:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A62C433CB;
        Wed, 22 Nov 2023 15:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700667195;
        bh=DBJcN5FTG05qwhWIh0MyzB/8LycVdIjfM46WyfaKjzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lahtm9OeyXh+DnN6RG3klRBoI41SJnujm7SsriBS/yVSGWud9ukhj5uPzpvNSjojq
         Fim8i8SQthZqvUL5ll6zpndHTWYjjkD4x8zmJ5CTh9i3k1vfKT5ShcMfUmyewoPEsJ
         y9G6Ao1qUSvQmbqXobLmxw1/+bH7Ie+R6Vuopk5sXKU0oGRQ7zGn3V4LB6/5FWiu2q
         30DeJMRSOxDDu45dtj81WGp3l2G06cztfara+n1d5p55AiY1kUmgS2BuYYCpXEUQbq
         S0XfG1C1YYq47R+VI12+1TR2OkRLK3WR5mZIVRK8xWyHIlxyZZB+bwYpSU/VNnSOxd
         XEhK3Dlijnveg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Sasha Levin <sashal@kernel.org>, agk@redhat.com,
        dm-devel@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 17/17] dm-crypt: start allocating with MAX_ORDER
Date:   Wed, 22 Nov 2023 10:31:46 -0500
Message-ID: <20231122153212.852040-17-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122153212.852040-1-sashal@kernel.org>
References: <20231122153212.852040-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.2
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>

[ Upstream commit 13648e04a9b831b3dfa5cf3887dfa6cf8fe5fe69 ]

Commit 23baf831a32c ("mm, treewide: redefine MAX_ORDER sanely")
changed the meaning of MAX_ORDER from exclusive to inclusive. So, we
can allocate compound pages with up to 1 << MAX_ORDER pages.

Reflect this change in dm-crypt and start trying to allocate compound
pages with MAX_ORDER.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-crypt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 5315fd261c23b..9a4b4932438f3 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1679,7 +1679,7 @@ static struct bio *crypt_alloc_buffer(struct dm_crypt_io *io, unsigned int size)
 	unsigned int nr_iovecs = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	gfp_t gfp_mask = GFP_NOWAIT | __GFP_HIGHMEM;
 	unsigned int remaining_size;
-	unsigned int order = MAX_ORDER - 1;
+	unsigned int order = MAX_ORDER;
 
 retry:
 	if (unlikely(gfp_mask & __GFP_DIRECT_RECLAIM))
-- 
2.42.0

