Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1819C7F089E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 20:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjKSTuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 14:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbjKSTtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 14:49:51 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DA91BD9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:49:03 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6b1d1099a84so3606091b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700423343; x=1701028143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CM+OPz8sAX9/+pckE36Q2lCrK7XvSIfXWi261rZELtQ=;
        b=Afvt9npRwp95Im/FJLQ4+yLe4XtjOwRQlS5Bcenqfiu6s4zOVDNDC9TnLd2LDWhRkG
         Lf2Rk1xnJAxJCu05N3e5x7+kA52CyzE4QJvMnOej7jgkD7/TrKSYRxbeOZEiENa+1ffx
         vaITqRi5dxBNDB6InBBqOjlYYUHzoHuLXQxS3uUm9Mm/TnDtbYFej+7QIU3OEdCuKRKS
         UQG2QXnrODblRWZXfWxIhATw7KrBUVCu+krtYU7WYC5sGIqFPI8CE/QBuZK7Otg+aMeK
         w5ww+J45bGxSYsmDtMx2bO7Ot7hUiqUc+FTLPFYeQUCZv/sjEXwEGjoAB6Y3u1k5xelF
         gCQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700423343; x=1701028143;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CM+OPz8sAX9/+pckE36Q2lCrK7XvSIfXWi261rZELtQ=;
        b=hcr1MX/sniu/lkyTjcNc2ScEKn2CY5CQTz1Ha4oLyM/fySwiB1asq7RWacA4ri1yGq
         yYWiMt2khDWNXvL7kHkj4a4XQhxLEHFfG3UPhnyEPOw+V5WWmrdv/+TfOI1ABPkIHtjA
         G4TRwR/O1l6oV1wkAjPvhA9s2gIi539cbYqPDmacaUcRNp3yzLHRSidzj0rl7W6IE5Cl
         Ik1IsK3XR7L1IJSuNqBsfKqhA9TCX70A05aYe12ZvzQ19bW0gLbWB19K6x4RzwH1RURD
         dMfR6Gk3wi2LFpJClvYimhmK/8VCpvt/CE/JuCl//8SJgZdmMl8C2wkfK/BGA9CLojbl
         mhtw==
X-Gm-Message-State: AOJu0YxMWPGOpR9DEg3WP4XUy3GEhnANX0smxKd1gSjuHkt7Mdc9XQ/G
        nu7Rxnjvxm3tbMyUpkjapR4=
X-Google-Smtp-Source: AGHT+IGkCTfkx1rp2FzBZeJz7DuMjH5OX9xB0kVWtfaGQTv9o7aHxqdL3R9OOEYrRIDUL1WVW8rBzw==
X-Received: by 2002:a05:6a20:748e:b0:186:58d6:ca65 with SMTP id p14-20020a056a20748e00b0018658d6ca65mr7241893pzd.32.1700423343119;
        Sun, 19 Nov 2023 11:49:03 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([115.171.40.79])
        by smtp.gmail.com with ESMTPSA id a6-20020aa78646000000b006cb7feae74fsm1237140pfo.164.2023.11.19.11.49.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Nov 2023 11:49:02 -0800 (PST)
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
Subject: [PATCH 19/24] shmem, swap: refactor error check on OOM or race
Date:   Mon, 20 Nov 2023 03:47:35 +0800
Message-ID: <20231119194740.94101-20-ryncsn@gmail.com>
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

It should always check if a swap entry is already swaped in on error,
fix potential false error issue.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/shmem.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 81d129aa66d1..6154b5b68b8f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1857,13 +1857,11 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	page = swapin_page_non_fault(swap, gfp, mpol, ilx, fault_mm, &result);
 	mpol_cond_put(mpol);
 
-	if (PTR_ERR(page) == -EBUSY) {
-		if (!shmem_confirm_swap(mapping, index, swap))
-			return -EEXIST;
+	if (IS_ERR_OR_NULL(page)) {
+		if (!page)
+			error = -ENOMEM;
 		else
-			return -EINVAL;
-	} else if (!page) {
-		error = -ENOMEM;
+			error = -EINVAL;
 		goto failed;
 	} else {
 		folio = page_folio(page);
-- 
2.42.0

