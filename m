Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B987BE3AF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 16:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346459AbjJIO4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 10:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234598AbjJIO4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:56:14 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BD3100
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 07:56:10 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3231df054c4so4324161f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 07:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1696863368; x=1697468168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fj3iSs9I07s+0bx1L727//TIOkD+aXcGIVkL4AdCGYI=;
        b=KmIeus//Q8sGmvoh1TbSuAYzcsZRcTAO4FCYvGOvxZ1/r0RtgWS3yf6B/UAtZbhxro
         ICDhe3sgBqMB3oI1JqdRIKU0rZyUbEG+isDTxF2Xc8wZ1hsAb9BAw7PlLYleKARPBLAE
         ZUcJDsX+CrWYvQ9hzwvdoi4wlnlrNEpc43H5/P1y4aWKl73VJHrDrFUrS70fiTKm088P
         sz+tvYdBSWiBlK6mQrqSZifVl1oULMkZLj4lGNNNVl3jxN4jvTHi5YakxWSeK627QV0J
         YHucbBqtmv6HvP6vmWZW4yfib7j3C/zbeE72Ih72jZ5kchk7JMYMjGxzjiJDHd+49J5R
         P8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696863368; x=1697468168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fj3iSs9I07s+0bx1L727//TIOkD+aXcGIVkL4AdCGYI=;
        b=hcVhp3p0CQyi3u3ITiFyL3wLpRGN6gYBSJh/p4lxAhRDRSsjzFzCFhROhauWdznO/a
         4EYUwEKVlluvqfh8B6OAzDTwJFl6uF5/f4ONo5VhRhlJtAl3p0EGS3URe4R07Tfx8UG5
         uIbfxjMfb/CKixaB8PvVq4jr70Dtxilg+/c7daU+019aX5PuTgwpsrd+6DVxaM/w/YNr
         61OQpvSl1iUtjj3qRzA8MRdtMyidprwkWItwrh0jgjn0HlOQIF8LPmgfs/dwqLkVJ4vK
         oBPugojSAR9wfzrgVvn8bFyxFh+h3kT/nh8wNRQUDYwwFGMZB5vYXD5F/MTYvcUrYTrS
         LOVQ==
X-Gm-Message-State: AOJu0Yx4y+Q8ZCyD9u7nkUc3SGi76eiMnvw3n/Ddv/yWKtJpCOKbxa4U
        7p6GgrqI/rMjCeBq3h22QOxx6w==
X-Google-Smtp-Source: AGHT+IHYSLObDLoA/qdhIh1iRz1HOR4N6RSOT4pgLJFX08n15tZbBT/CIBftt0i9sEERyIi1aEqhhQ==
X-Received: by 2002:adf:fb0b:0:b0:31f:c1b5:d4c1 with SMTP id c11-20020adffb0b000000b0031fc1b5d4c1mr12721447wrr.35.1696863368447;
        Mon, 09 Oct 2023 07:56:08 -0700 (PDT)
Received: from localhost.localdomain ([2a02:6b6a:b5c7:0:c1b1:1479:6449:a1ff])
        by smtp.gmail.com with ESMTPSA id g7-20020a5d5407000000b00327df8fcbd9sm9965173wrv.9.2023.10.09.07.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 07:56:08 -0700 (PDT)
From:   Usama Arif <usama.arif@bytedance.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, mike.kravetz@oracle.com,
        songmuchun@bytedance.com, fam.zheng@bytedance.com,
        liangma@liangbit.com, punit.agrawal@bytedance.com,
        Usama Arif <usama.arif@bytedance.com>
Subject: [PATCH] mm: hugetlb: Only prep and add allocated folios for non-gigantic pages
Date:   Mon,  9 Oct 2023 15:56:05 +0100
Message-Id: <20231009145605.2150897-1-usama.arif@bytedance.com>
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

Calling prep_and_add_allocated_folios when allocating gigantic pages
at boot time causes the kernel to crash as folio_list is empty
and iterating it causes a NULL pointer dereference. Call this only
for non-gigantic pages when folio_list has entires.

Fixes: bfb41d6b2fe148 ("hugetlb: restructure pool allocations")
Signed-off-by: Usama Arif <usama.arif@bytedance.com>
---
 mm/hugetlb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f3749fc125d4..b12f5fd295bb 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3397,7 +3397,8 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 	}
 
 	/* list will be empty if hstate_is_gigantic */
-	prep_and_add_allocated_folios(h, &folio_list);
+	if (!hstate_is_gigantic(h))
+		prep_and_add_allocated_folios(h, &folio_list);
 
 	if (i < h->max_huge_pages) {
 		char buf[32];
-- 
2.25.1

