Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8036789D2B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 13:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjH0LJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 07:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjH0LIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 07:08:54 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2329139
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 04:08:52 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-31c4d5bd69cso1927754f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 04:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693134531; x=1693739331;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sONyVx9cK/CieoE/wcRBUETqKBRrm5Dew5BY7/Nseo0=;
        b=qVmdDWjHPSeSGp2+zhejnysiAKOaPT5mXMxwVIHfWdz8rPNQGowjpptzLhZRnPikTv
         oMkPQDJwZ5yyAF2/0j42NG5ncK8QCRm2U2PDnfEUEh41Kk3kfgg4UCYHHdXtWcYTTBEP
         dMduXB1dy1Uj/2mz9HA4uy2QMaq/sRl5LMhBe/xmFdKCFLCfkdNbeVfmfFs/adjNrnHd
         urnz3MTCRj5fcoET90oYjo4D/j6FXoXb5uL62juMF4+d8z7zagWDTUJD/CclXyV2Decj
         t1hNd/sb8e81pJQoXWQzMxN2j16GwcX8ffqSYeuEMcU9CPDTX1sAsTMqRlsvAoWGi46O
         FZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693134531; x=1693739331;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sONyVx9cK/CieoE/wcRBUETqKBRrm5Dew5BY7/Nseo0=;
        b=FB6U6tlZkCKg8ffWUVc8OczR4uwojigIaZ4zPBv8EU7zzNPMtT6pAI0AYN3cZ/jTHb
         6pgw5bIpbxxL2DQGjNkoDJ2NWToY2f2Il/GIRlK4CoKByib8HG5sLQy2Zcl8MKmYLXzA
         ngQy/NGTU/wcyRV9zsqueDRxP6DLg8GUahHKCX2WnDjayXkahpKZxiEqfQrYiCMaon7J
         WZV1EqQGD8luWLxqAJxL+Vn962OxdJS4RhyTR9lKXtisQ6NFHDOXk8P9reVUKRPMUGI+
         Qbzj3uEJyejgrSb3Xg37zG0lQZWVp42bHmsSOy2FXTZKio4fPzz3lxvHoMzZYCfKMVkw
         fYQQ==
X-Gm-Message-State: AOJu0Yz/oqgMM2TvZDiZeKK9dmxgFBVPpBtgauAUrfv7vxM0bUdRabHI
        +vFsOh9ugiF/J6r4Qe0h8k8=
X-Google-Smtp-Source: AGHT+IE6A9cejXZz+BLsFwob3V1yjzDPwsZo4kaUzgcstoivARk5t1e9p32fyCpIsi+pSTAC8OZgpA==
X-Received: by 2002:a5d:4f0f:0:b0:319:89ce:da0b with SMTP id c15-20020a5d4f0f000000b0031989ceda0bmr16765705wru.68.1693134530967;
        Sun, 27 Aug 2023 04:08:50 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id f12-20020adff44c000000b00319779ee691sm7299281wrp.28.2023.08.27.04.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 04:08:50 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH] mm: refactor si_mem_available()
Date:   Sun, 27 Aug 2023 12:08:48 +0100
Message-ID: <20230827110848.43510-1-lstoakes@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The si_mem_available() function needlessly places LRU statistics into an
array before retrieving only two of them, simply access those directly.

In addition, refactor the code so that the blocks of code which calculate
the page cache and reclaimable components each resemble one another to
clearly indicate we cap both against wmark_low in the same fashion.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 mm/show_mem.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/mm/show_mem.c b/mm/show_mem.c
index 4b888b18bdde..ba0808d6917f 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -34,13 +34,8 @@ long si_mem_available(void)
 	long available;
 	unsigned long pagecache;
 	unsigned long wmark_low = 0;
-	unsigned long pages[NR_LRU_LISTS];
 	unsigned long reclaimable;
 	struct zone *zone;
-	int lru;
-
-	for (lru = LRU_BASE; lru < NR_LRU_LISTS; lru++)
-		pages[lru] = global_node_page_state(NR_LRU_BASE + lru);
 
 	for_each_zone(zone)
 		wmark_low += low_wmark_pages(zone);
@@ -56,7 +51,8 @@ long si_mem_available(void)
 	 * start swapping or thrashing. Assume at least half of the page
 	 * cache, or the low watermark worth of cache, needs to stay.
 	 */
-	pagecache = pages[LRU_ACTIVE_FILE] + pages[LRU_INACTIVE_FILE];
+	pagecache = global_node_page_state(NR_ACTIVE_FILE) +
+		global_node_page_state(NR_INACTIVE_FILE);
 	pagecache -= min(pagecache / 2, wmark_low);
 	available += pagecache;
 
@@ -67,7 +63,8 @@ long si_mem_available(void)
 	 */
 	reclaimable = global_node_page_state_pages(NR_SLAB_RECLAIMABLE_B) +
 		global_node_page_state(NR_KERNEL_MISC_RECLAIMABLE);
-	available += reclaimable - min(reclaimable / 2, wmark_low);
+	reclaimable -= min(reclaimable / 2, wmark_low);
+	available += reclaimable;
 
 	if (available < 0)
 		available = 0;
-- 
2.42.0

