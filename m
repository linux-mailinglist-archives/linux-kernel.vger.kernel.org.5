Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89C2765890
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 18:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234194AbjG0QX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 12:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbjG0QXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:23:51 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B5C2D4B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 09:23:48 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-63cf96c37beso5142926d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 09:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1690475027; x=1691079827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4WqUpKSmXvGR1M+fIFBD/JXbqB10oByq1yE4svjvKk=;
        b=qNto7iFRrzOxESe9fv4KXfCHzvEpqtjq8zKP6G+FHbxknRdRQyruOVS/C6JV+mmMvY
         +/rWcuLtgsi9NpP8YgxSITdR8dLpz4uKoeqElIiF8b0B/yCc6cd24rpY8lAY+hhsYZCj
         nuB6QswJUQX/5foZILCFhUOhAhxdSuiL48uJ9//IKXR5DiNmxdHTFCXSUib5GYajdUMC
         BZX4uCMOPsz4wm4GIKg0pa4I8kmWdNTYMyl1/gbCDWOOuOnTP6xcrq/91YCR699FRai3
         uD/9XMZLJawLy/Dvhly73UgklITjc1pFzK3nbx3xqKttOiuUSz1YJoFeSUFYn+hyS7zH
         wtww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690475027; x=1691079827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V4WqUpKSmXvGR1M+fIFBD/JXbqB10oByq1yE4svjvKk=;
        b=IzwlHxanvXS0f8sD+SMJGQh8RMXbBArVrUW9Xda/VY/w4nh7+1Br7ZmOd0Yr9w1aPh
         KZ+suPIpp68DQ+TN46QVNQSMATUF4QpiqLzpik8LSjp0lacfwUc95YO93fMwadsWSzcx
         R8AQdtr8Ly/hKhjmMDCh7LB7/5CFmlag15KnePE87nxaUT/ey92gAQ5N86jTr9bIbjPl
         CKQO9VlHVWLDQhPwb+4AReg5+Nox9dSF5qkvDLg86rVHTSk0NCiwI2/bEWDq2vfmikod
         8XqVb5NyZkmYVEohrnifWnjnsSmAnisq9gThLYy8CSVZYxjnQmTYWJmUjOheSxhkaXxe
         OMpw==
X-Gm-Message-State: ABy/qLZ9RnKyp1z3JSslzjpoG6Q9zUcGDtb6R3YSqq0HiK2QDzVawk/q
        LXx0xVLAOd0u8eNFTt6tjNVKJaD+3/6foktG00IaIg==
X-Google-Smtp-Source: APBJJlEf3a+4nlFwkjw+loMNGiZ+A28qMm0A+SS4AICZPLdvjR5GWT3rErmZtaoO4i263nli3LNnqA==
X-Received: by 2002:a05:6214:d6a:b0:635:dbab:a588 with SMTP id 10-20020a0562140d6a00b00635dbaba588mr850652qvs.16.1690475027432;
        Thu, 27 Jul 2023 09:23:47 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:ad06])
        by smtp.gmail.com with ESMTPSA id s18-20020a0cb312000000b0063762ab2f90sm527074qve.83.2023.07.27.09.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 09:23:47 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] mm: zswap: use zswap_invalidate_entry() for duplicates
Date:   Thu, 27 Jul 2023 12:22:23 -0400
Message-ID: <20230727162343.1415598-2-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727162343.1415598-1-hannes@cmpxchg.org>
References: <20230727162343.1415598-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor cleanup. Instead of open-coding the tree deletion and the put,
use the zswap_invalidate_entry() convenience helper.

Suggested-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/zswap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 583ef7b84dc3..e123b1c7981c 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1344,9 +1344,7 @@ bool zswap_store(struct page *page)
 	spin_lock(&tree->lock);
 	while (zswap_rb_insert(&tree->rbroot, entry, &dupentry) == -EEXIST) {
 		zswap_duplicate_entry++;
-		/* remove from rbtree */
-		zswap_rb_erase(&tree->rbroot, dupentry);
-		zswap_entry_put(tree, dupentry);
+		zswap_invalidate_entry(tree, dupentry);
 	}
 	if (entry->length) {
 		spin_lock(&entry->pool->lru_lock);
-- 
2.41.0

