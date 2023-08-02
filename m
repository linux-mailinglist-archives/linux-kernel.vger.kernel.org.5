Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0CA76D6E7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 20:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjHBSgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 14:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjHBSgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 14:36:19 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970BE19AD
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 11:36:18 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbc63c2e84so1620785e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 11:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691001377; x=1691606177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TAs2W0UQPvG+IMRnbk4btgVlH770IjvAYL2tx8M/WQo=;
        b=Y0WhxoV/BzAocRJ6IJmR0uV2Pq0+TNdd0NezQ/SRyF+Kbz8K4DGauZiFY/NktvtwR0
         1IBGENdk8cwRnPqNa33a+uZXNT9V4HdV0yfHr/VWbEekJctSBupAqMset2u9zbJOZ976
         bhsank+kn1yQpM9JJ4BooL1vewrYaI2dLDP9umlvIPMbfuAXNtzSR00hhscVorvRA+lQ
         KMhZqxbj/QJ9zVLnG6kFquAUgKvNJOBI/kNU8+QYQB0Q29xGXT8v9pYI/G/JPWA5GriJ
         RjRHb9hVHKjvzAGFIWl3Q+FkXr9reiTFWq+TZQUxmug9fhUJyfVc62Sh4R08PiOuDd1G
         /JSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691001377; x=1691606177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TAs2W0UQPvG+IMRnbk4btgVlH770IjvAYL2tx8M/WQo=;
        b=BOwDwOiwpf1yQe6ulemJU0Ohy7hHMOfYXCUKVQNXMsL4FS75pQoop5swZdosfCXz+H
         3rNr/YaoLGxNVIKduOuCARlduRMshCWgGZrNltasKd57l+G8pilyq/EW4tJaPogyAggr
         WD4Fys62Gftm/S65gsRyRX8CdaSQXzrwN49jKRaAxceTXSmptV/BDw7eGrGaH6x0mgOz
         sF+gJITINbsttRfwWWM7lVmoJi4L4gfLi3ezCqFq1RMWvHAXWFM5Ggf9rIJVxH910Dg7
         4/rLPQjZEcpHL9BCnCtT+i/7rWdLODfGKRHG8BIVjTindqoTjIpyu+tZLilCGhWlxfSX
         CsPQ==
X-Gm-Message-State: ABy/qLZCMKzOFt6g9ZCCEXpKG348e6z32IdJgciO9ZOSb8cbpt3OmMnK
        ys95jxW98nrjBHIfnES2xmo=
X-Google-Smtp-Source: APBJJlFhUQqZe+Xo9YYnuL4IdIpOPvWU+jVICi15RIjPf7K8uwY+77EYoazV0uQThsil71PmxVQrgA==
X-Received: by 2002:adf:ce8a:0:b0:317:5c18:f31d with SMTP id r10-20020adfce8a000000b003175c18f31dmr5318090wrn.35.1691001376650;
        Wed, 02 Aug 2023 11:36:16 -0700 (PDT)
Received: from localhost.localdomain (host31-52-141-59.range31-52.btcentralplus.com. [31.52.141.59])
        by smtp.gmail.com with ESMTPSA id z1-20020adfd0c1000000b0031424f4ef1dsm19839681wrh.19.2023.08.02.11.36.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 02 Aug 2023 11:36:16 -0700 (PDT)
From:   Levi Yun <ppbuk5246@gmail.com>
To:     rppt@kernel.org, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Levi Yun <ppbuk5246@gmail.com>
Subject: [PATCH] mm/mm_init: Ignore kernelcore=mirror boot option when no mirror memory presents.
Date:   Wed,  2 Aug 2023 19:36:14 +0100
Message-ID: <20230802183614.15520-1-ppbuk5246@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the machine where no mirror memory is set,
All memory region in ZONE_NORMAL is used as ZONE_MOVABLE
when kernelcore=mirror boot option is used.
So, ZONE_NORMAL couldn't be populated properly
because all of ZONE_NORMAL pages is absent.

To avoid this abnormal situation,
ignore disable kernelcore=mirror option when no mirror memory is found.

Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
---
 mm/mm_init.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index a1963c3322af..4c180ef1a993 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -376,10 +376,13 @@ static void __init find_zone_movable_pfns_for_nodes(void)
 	 */
 	if (mirrored_kernelcore) {
 		bool mem_below_4gb_not_mirrored = false;
+		bool no_mirror_mem = true;
 
 		for_each_mem_region(r) {
-			if (memblock_is_mirror(r))
+			if (memblock_is_mirror(r)) {
+				no_mirror_mem = false;
 				continue;
+			}
 
 			nid = memblock_get_region_node(r);
 
@@ -398,6 +401,12 @@ static void __init find_zone_movable_pfns_for_nodes(void)
 		if (mem_below_4gb_not_mirrored)
 			pr_warn("This configuration results in unmirrored kernel memory.\n");
 
+		if (no_mirror_mem) {
+			pr_warn("There is no mirrored memory. Ignore kernelcore=mirror.\n");
+			mirrored_kernelcore = false;
+			memset(zone_movable_pfn, 0x00, sizeof(zone_movable_pfn));
+		}
+
 		goto out2;
 	}
 
-- 
2.37.2

