Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACEE07F088A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 20:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjKSTsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 14:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjKSTsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 14:48:12 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3749111A
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:48:09 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5c9d850a0dbso6658997b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700423288; x=1701028088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cduqWiCMIKVDQKzalcbjrj5u/UZrGRNgI9eE9WPHu3A=;
        b=Y9sAFqwPPdpUQXqbpYpZjJ/bJFuU5qndB3eaipJ94VTJIKWoYM50djbzA8SIXrJp0E
         IQB+DXITZVEmKmCwo/wFMp1N+qG6z0btZOGJVXKggy+SgcgidRpVGvdBG4xhV4FE7AkJ
         l4rixv+zfi2XOjZY8M7Z/7CO8AVI+XwvjCe6aBACRlKbXd72bHRyilUuKRc5lIYCDts1
         8HNy+kHE3SV6ZJvDbF9sGSrswumW19xFIu7juY64z337qf3doIndP5V1a1OyCwmyU5sA
         PF5ITZ1VZkihNjhzdlLL6Df5ZWehP+u2rGd4pmS2P/flRVc9zWrd6aZlwiFW9dJQcnAQ
         +PUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700423288; x=1701028088;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cduqWiCMIKVDQKzalcbjrj5u/UZrGRNgI9eE9WPHu3A=;
        b=Yj3eNh5jUBAYPYvV47npF8G3aojkyElxcmw0nAUeXqjHu5dzbTX2PMrdkcx8dIHSSa
         DQ0RoMYLhigpSvwDTto6btWVqAQu5aF1DNESgT9vPsnP+70h2E4pdZH0CJgkBE2M0WN3
         ovdRVzX20sXBeKJd/zgJ95aZbOXKf2ETuzlYrNyIW1Znf8BM2T4mMSNsKpDSNDDEy874
         cUNjRuizQH3mwx4GLTgWf9TgFuWRJ2BNrTTKx1W/WgTWarnrKQ0/x//JHMqXhf1eqjeb
         X7BHIz/pejB41bTRlSi9uKHxb+Xr95lsA9x7pvN8eYOXUqJ04jlO8a5+BEsoMzxqdtq4
         itSw==
X-Gm-Message-State: AOJu0YzS44t4sk1xM3JMDaCRHfjvwppsUbVPIeIer9h9MyGrUF+pRknw
        eq7Qc1mj36D36QQzv3rlvv0=
X-Google-Smtp-Source: AGHT+IE1y2y3wIZaEr+VeLd45/7RB5OVC0un5QZpdb1Dva1zs1cgZibYuz6x5YXuFZ86VBTCpW+iXw==
X-Received: by 2002:a81:4841:0:b0:5be:94a6:d919 with SMTP id v62-20020a814841000000b005be94a6d919mr6198288ywa.25.1700423288412;
        Sun, 19 Nov 2023 11:48:08 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([115.171.40.79])
        by smtp.gmail.com with ESMTPSA id a6-20020aa78646000000b006cb7feae74fsm1237140pfo.164.2023.11.19.11.48.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Nov 2023 11:48:07 -0800 (PST)
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
Subject: [PATCH 02/24] mm/swapfile.c: add back some comment
Date:   Mon, 20 Nov 2023 03:47:18 +0800
Message-ID: <20231119194740.94101-3-ryncsn@gmail.com>
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

Some useful comments were dropped in commit b56a2d8af914 ('mm: rid
swapoff of quadratic complexity'), add them back.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swapfile.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 4bc70f459164..756104ebd585 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1879,6 +1879,17 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 				folio = page_folio(page);
 		}
 		if (!folio) {
+			/*
+			 * The entry could have been freed, and will not
+			 * be reused since swapoff() already disabled
+			 * allocation from here, or alloc_page() failed.
+			 *
+			 * We don't hold lock here, so the swap entry could be
+			 * SWAP_MAP_BAD (when the cluster is discarding).
+			 * Instead of fail out, We can just skip the swap
+			 * entry because swapoff will wait for discarding
+			 * finish anyway.
+			 */
 			swp_count = READ_ONCE(si->swap_map[offset]);
 			if (swp_count == 0 || swp_count == SWAP_MAP_BAD)
 				continue;
-- 
2.42.0

