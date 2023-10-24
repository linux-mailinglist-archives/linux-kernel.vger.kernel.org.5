Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2256E7D53FD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 16:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343732AbjJXO10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 10:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbjJXO1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 10:27:24 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2F0118
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 07:27:22 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c9d407bb15so37827635ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 07:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698157641; x=1698762441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YcQTC+eJzzLlnaNT0UmsWQUFrQijvQZ05PsjYq0iiBE=;
        b=ReFm1ccBKvcROySXJNFfIeYwVkc9xhxTm2kQHo9OOV+VtBCm3lr9tpyEf2D6LnSZt2
         IBstcR6Sl3hq9n0kwpNRModkrUAWsJ9zq1mL41xuRjiUSCQpqvbw6BMahbhej5c6wlKW
         +1XyYhlSrj0sLigAndFTPStHBTrx/SjxzdrBPIeUi8riRYSL/Cf72RsbrKZ7ietDnB1s
         kQCxJv9YfXvfPTzX3Xtk0QnvmhIh9IGGVf8boUkCBLY7UGQW6JCULLnW7yY8QosekCOy
         VTrP2pJVFjxpXYMgZom8jfxGxNFlYa4daV9qX03FZYNuHodglKjHDjvi3Ds/qmNlLT/f
         w3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698157641; x=1698762441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YcQTC+eJzzLlnaNT0UmsWQUFrQijvQZ05PsjYq0iiBE=;
        b=OJENbDSKyLidnFnEm57lm0w6usooQGTuPwS4lk4jhg7upSV18BpMKqnr1TmlxCtW6q
         rViKDiHZdlvhteT6LleBfRjQp7gcez5GoDyMI57kJPRVIaEBEHS1AsvRkymgNtw53iTf
         K/QwU+FqffdE7WARu55t4+vK6J1tPiUVIrJrHCmW7t6erVKDrwaokIYDBws0/4qn0XIL
         T9nmpGl5k9WJTr3l1ekzHhLG7sDtXsUGMwg9r+ukUxPVBvrrceVhYXSA1uRqzLGKt+6A
         ciAaoWnLknns4k9quGxSNPqvn43XrReix5bRFoCdh4hYFBAh2ncz7A4Q9ANxmCTy9fiK
         uRpg==
X-Gm-Message-State: AOJu0Yws15TzmtqUNYHGtsZN3JdG5RcjYTiBp3I9VDUH+MqbXkAVTMFo
        g9x1WXYIhJcX+nwHeMI6/mGFPg==
X-Google-Smtp-Source: AGHT+IHHAHbFJzr12MFDRq5IG9+LtJIaiU1yv0G+Yr3j00NhXl3Xbofdpc7yRWDb+5EBBHPOfNdDTQ==
X-Received: by 2002:a17:902:c409:b0:1c5:a49e:7aa with SMTP id k9-20020a170902c40900b001c5a49e07aamr14869540plk.27.1698157641443;
        Tue, 24 Oct 2023 07:27:21 -0700 (PDT)
Received: from Tower.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id 1-20020a170902ee4100b001c9db5e2929sm7488397plo.93.2023.10.24.07.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 07:27:20 -0700 (PDT)
From:   Zhongkun He <hezhongkun.hzk@bytedance.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, yosryahmed@google.com, nphamcs@gmail.com,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zhongkun He <hezhongkun.hzk@bytedance.com>
Subject: [PATCH] mm: zswap: fix the lack of page lru flag in  zswap_writeback_entry
Date:   Tue, 24 Oct 2023 22:27:06 +0800
Message-Id: <20231024142706.195517-1-hezhongkun.hzk@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The zswap_writeback_entry() will add a page to the swap cache, decompress
the entry data into the page, and issue a bio write to write the page back
to the swap device. Move the page to the tail of lru list  through
SetPageReclaim(page) and folio_rotate_reclaimable().

Currently, about half of the pages will fail to move to the tail of lru
list because there is no LRU flag in page which is not in the LRU list but
the cpu_fbatches. So fix it.

Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
---
 mm/zswap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/zswap.c b/mm/zswap.c
index 083c693602b8..b9b94cbd403c 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1139,6 +1139,11 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	/* move it to the tail of the inactive list after end_writeback */
 	SetPageReclaim(page);
 
+	if (!PageLRU(page)) {
+		/* drain lru cache to help folio_rotate_reclaimable() */
+		lru_add_drain();
+	}
+
 	/* start writeback */
 	__swap_writepage(page, &wbc);
 	put_page(page);
-- 
2.25.1

