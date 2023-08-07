Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA4B771DB5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 12:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjHGKBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 06:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjHGKB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 06:01:28 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1746F4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 03:01:27 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bc6bfc4b58so3940675ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 03:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691402487; x=1692007287;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwYs+O8vgVUJyFlM5JLIVDfwN1J1PxEBLDaKVVtoMJk=;
        b=oLL+7m6qYd+7DmSzgxQ/ozPBUYav/WFnUQSkLLnbvTrC/Eah1DuL3NQa1bI4YPhny2
         eKQvY1rOkDmzv/HkX511l60S2rxcznZ9ftrIudmmcrZIY3sI+fm2kIidGg9Hg0tG/4O7
         tJxEi3/gKDEFHdttLLrHktUDcEtc4Gu1lmMNvD2eN0MVJIphMJzpK5Qi8xB2jHkX4v/C
         V73p0DQjGCGjO5bl+BYELymO00X+U3tcuapjTyT3gSV9taYqpEduPipGxmCXAD6FxCz7
         d1+uIcENzfr7LOsC2HTX+/idCoS7gdhz3+mQ8F1Xjp6hT4EjJOqzCQuNMv7QVdelseGI
         Mv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691402487; x=1692007287;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SwYs+O8vgVUJyFlM5JLIVDfwN1J1PxEBLDaKVVtoMJk=;
        b=R9Lje20ZWawcxl0mDzTgM7NTyvlQEiInNilPIBsEJlPv8udj/phUtWhdmy8e9xr2sJ
         cluUfLSvXLsIGWkceqKUY6Qi1oCgV2mpIZnN3CZHv7ebBBAi6pdJA+ixpBVbstdps1ti
         ZDH0a3Sh71dnaGx5+wJ/SAOwTw3djuVjR/ll6D1j615uJKLejg3HpUIStGiOCHwJemdI
         tN/1llGeawcX802RZrZJ4Gz7CLkuFTxjZVGEwV18Ma+9g1IK7/Lez0r0GIJWzmd6IQxT
         3nqWotzFJLsKfm21xhYKSI4/++02DhIkc+MmcMgZ5N73g2YgFbQLMUTmcueAowFNwn11
         v6bw==
X-Gm-Message-State: AOJu0YyQm5ADBd0tQjim3nTcdSZ55a5T+cnvNLeybc9YmXIopsehpd4D
        KGw1Spxb/To3xs9sLgPnoTqrkt4dYxEHmR4T
X-Google-Smtp-Source: AGHT+IFebdmfKSKoXjZXDKP1MSLkwdlsoq5rPCk96tCzk/RXPb8Sxcuq26swmScT/Xm0Zc8Km/HeTw==
X-Received: by 2002:a17:902:c404:b0:1bb:a367:a77 with SMTP id k4-20020a170902c40400b001bba3670a77mr9004909plk.31.1691402486995;
        Mon, 07 Aug 2023 03:01:26 -0700 (PDT)
Received: from localhost.localdomain ([1.237.29.215])
        by smtp.gmail.com with ESMTPSA id ji1-20020a170903324100b001b881a8251bsm6484800plb.106.2023.08.07.03.01.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Aug 2023 03:01:26 -0700 (PDT)
From:   Hyeongtak Ji <hyeongtak.ji@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hyeongtak Ji <hyeongtak.ji@gmail.com>,
        Hyeongtak Ji <hyeongtak.ji@sk.com>
Subject: [PATCH] mm/vmscan: consider previously reclaimed pages in shrink_lruvec()
Date:   Mon,  7 Aug 2023 19:01:16 +0900
Message-Id: <1691402476-4838-1-git-send-email-hyeongtak.ji@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

shrink_lruvec() currently ignores previously reclaimed pages in
scan_control->nr_reclaimed.  This can lead shrink_lruvec() to reclaiming
more pages than expected.

This patch fixes shrink_lruvec() to take into account the previously
reclaimed pages.

Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 1080209a568b..315da4ae16f1 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6261,7 +6261,7 @@ static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 	unsigned long nr_to_scan;
 	enum lru_list lru;
 	unsigned long nr_reclaimed = 0;
-	unsigned long nr_to_reclaim = sc->nr_to_reclaim;
+	unsigned long nr_to_reclaim = sc->nr_to_reclaim - sc->nr_reclaimed;
 	bool proportional_reclaim;
 	struct blk_plug plug;
 
-- 
2.7.4

