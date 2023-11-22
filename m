Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBED17F4ADC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344592AbjKVPgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344567AbjKVPgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:36:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4702D55;
        Wed, 22 Nov 2023 07:34:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB8BC433AB;
        Wed, 22 Nov 2023 15:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700667272;
        bh=P/to+IvbAg1hMAo72yB0NJK2eoy5sppbolmnEMq6Xl4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SyRAMp9z5mN0c0pgG9fVPHVOHBj64MApndVzwykEK/vOl4OMfGWWe7k/l1dyDL/Ya
         hDoVXfy06jYfYOaPgaMVKp+ENb++erpmrAjCkE9KdnjWOj2kH8QYC9TKOuAkFj4Cn/
         2fPNSA9gdEk/DiLNxlZd2xHR3LdJTeglgbNx8Qf3Io5Nv4j215Tx8tSui7tB16Wd0P
         PhXv2/FC9tFeDkgh3Oickoa4imhrlqsEBtMiVP8F5qcyBKVwmXqqoIMNBETVs0ML6z
         iKvR2GUFEpoOwVBJiu+heB9Y9W9Hgxas2jYAANehGHNsYZ6UWxDNevF3CsDeLrY/y7
         PaM0WjnpRySHA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Sasha Levin <sashal@kernel.org>, agk@redhat.com,
        dm-devel@lists.linux.dev
Subject: [PATCH AUTOSEL 6.5 15/15] dm-crypt: start allocating with MAX_ORDER
Date:   Wed, 22 Nov 2023 10:33:17 -0500
Message-ID: <20231122153340.852434-15-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122153340.852434-1-sashal@kernel.org>
References: <20231122153340.852434-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.12
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
index dc0463bf3c2cf..696e5895edb7d 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1680,7 +1680,7 @@ static struct bio *crypt_alloc_buffer(struct dm_crypt_io *io, unsigned int size)
 	unsigned int nr_iovecs = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	gfp_t gfp_mask = GFP_NOWAIT | __GFP_HIGHMEM;
 	unsigned int remaining_size;
-	unsigned int order = MAX_ORDER - 1;
+	unsigned int order = MAX_ORDER;
 
 retry:
 	if (unlikely(gfp_mask & __GFP_DIRECT_RECLAIM))
-- 
2.42.0

