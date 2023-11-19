Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2FCC7F0887
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 20:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjKSTsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 14:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjKSTsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 14:48:09 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E008211A
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:48:05 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-357cc880bd8so14138705ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700423285; x=1701028085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tM0GQjuVnFv7RufWXzCKq9li8NCfwru2okUxp/uvL+E=;
        b=bQbQ3YTvLIP9LH2t1GMs9zqgejkdaGNPxoDVKKh73N5sqhbbjr8T6V8/JKDnQabOOh
         /qRdKJtbeBuVKz6qiLkgB1i/i+neW8S75xSXJ3l6Unn82Qj/mkeUawLjWCa6Jae8iE6Q
         d47bG2IU4g7wCrGZayiNRT+8QdmukBz5hAlQbze6YsyWinY/5XOIImih14QN9GLMcA6N
         yJpz0WDO4TpISDbkVkKip/X64Q2twM4B/o1Yz7Ep5t13eEoLwJoljNgQBOVvvFBUi2t0
         oIzwf5HvzXOT4ZWxSHh+ggG3pSD624M+HRrNDoPEmrogKKVAPm3xTaQ4w6xNohGPbxvV
         n2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700423285; x=1701028085;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tM0GQjuVnFv7RufWXzCKq9li8NCfwru2okUxp/uvL+E=;
        b=DfHFiiH72e5TOK7Zq8n4zpmve9Q34oPdBKUOZuBIfId2Y2a+HWlXlgDSrWq6ZYnnIV
         mj9vsl2cYP2B0Miz6hN1eMewBmNXG63IPjuFpbz4UmeE3KmPO5rMiEStgioDox55xdq2
         8faPFb7xR14lUllobk+WJGTI3wxmfa3SS/N5E3OzEcJKD62cyItlVh98v3gdvnY2UR00
         qxcY1C0W4p3Td4+fdUMTULPBHCcy0uHvcDxsc62+2PskX18UZZFDbBqYtyPvlbYx/zUT
         rWo0uqzsT8tCfZV5LpcqYUKHK0mpJSmpUHMbTkDrURVCScq2qPxBctMVjPKws/5CfFAx
         uqfg==
X-Gm-Message-State: AOJu0YxsnnAxhFbBWO2h8Rd2pgVIY1p03Tgv+pKpX5nFF7PpL6YR1yM2
        RwsPqK7R9cTzGT5EHvaBh7I=
X-Google-Smtp-Source: AGHT+IF1UkKRv/ipdxof7nKQAoicjYZ8F2kSET5NL02/aAVKfiSk21ZO3YlPkVn68ZksUna/3gG5lw==
X-Received: by 2002:a92:c26d:0:b0:35b:695:c3c8 with SMTP id h13-20020a92c26d000000b0035b0695c3c8mr353889ild.9.1700423285183;
        Sun, 19 Nov 2023 11:48:05 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([115.171.40.79])
        by smtp.gmail.com with ESMTPSA id a6-20020aa78646000000b006cb7feae74fsm1237140pfo.164.2023.11.19.11.48.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Nov 2023 11:48:04 -0800 (PST)
From:   Kairui Song <ryncsn@gmail.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        Kairui Song <kasong@tencent.com>
Subject: [PATCH 01/24] mm/swap: fix a potential undefined behavior issue
Date:   Mon, 20 Nov 2023 03:47:17 +0800
Message-ID: <20231119194740.94101-2-ryncsn@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231119194740.94101-1-ryncsn@gmail.com>
References: <20231119194740.94101-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kairui Song <kasong@tencent.com>

When folio is NULL, taking the address of its struct member is an
undefined behavior, the UB is caused by applying -> operator
to a pointer not pointing to any object. Although in practice this
won't lead to a real issue, still better to fix it, also makes the
code less error-prone, when folio is NULL, page is also NULL,
instead of a meanless offset value.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index e27e2e5beb3f..70ffa867b1be 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3861,7 +3861,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			/* skip swapcache */
 			folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
 						vma, vmf->address, false);
-			page = &folio->page;
 			if (folio) {
 				__folio_set_locked(folio);
 				__folio_set_swapbacked(folio);
@@ -3879,6 +3878,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 					workingset_refault(folio, shadow);
 
 				folio_add_lru(folio);
+				page = &folio->page;
 
 				/* To provide entry to swap_readpage() */
 				folio->swap = entry;
-- 
2.42.0

