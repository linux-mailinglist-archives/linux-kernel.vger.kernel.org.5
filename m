Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E33A793B2F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 13:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236916AbjIFL2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 07:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239652AbjIFL2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 07:28:04 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3206F198A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 04:26:58 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40061928e5aso34014035e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 04:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1693999574; x=1694604374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=av0vrlLKsg9xBQaLOcb8CPCy93VQFu46a3TbtxpfU4U=;
        b=czpBoukDfVXyFaJd9Gk+66hc0DcfXYWJU0NzkDqNlmZ4mLox/jGqU03IZY6Pzt4HrG
         gKmT0Vsddr7sOa8T7RC5Ns7LK3gp915RaQCLxevSRXnMnwX9xSoINXUjZPW3mtkY+pDL
         Xa0Ap5+sn4qyNGV+hX+FntVAei4R3a0eOJ6CQjbm+GMuKFN9fflhxQvBynHJ1F7rXf4k
         7MCEnLkR/L8kxSvwTT7CVI3mnht7dBBzxRpimlsTzGxKc/n6zsZPJ5bvw/v0VyumrjvU
         VGUIjQ7UbeYxTGYLPJcy6H9xJADP8ojPa64aAG5WxVLWPnE2DafotBLYDoJvTEInQwMf
         FloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693999574; x=1694604374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=av0vrlLKsg9xBQaLOcb8CPCy93VQFu46a3TbtxpfU4U=;
        b=CTzrp20a9yO1+413lG6yx5kik8wVyEyamterxyj3wo15NMhRkxfw+FmG78lg2/eorZ
         uWU3ld+d7o11N6r7spmY0S/WGKsotAwidj3VoLj1Uoq/Nebs+HI4blXDE/7NJohBRIIU
         y+uqisZ/TPQCuHpgOb70W1SRQz1Y/SE7k/X5jYOvpP748A3heP7guAxSFdIfXpF6UGWl
         U3sZLyCqqLTd2q8Xz59FWgjV0/38/XXNcfyfLQtrM6vGeOnf5BtMmhxj8TZk8WENQiOo
         J3Ln1ZrSJB8kuxSE80kY5VWX8nP11+rL+GoPzqsA4JzecNPyuQOqsnAZ2dMvJT8mm9Ay
         Pi6g==
X-Gm-Message-State: AOJu0Yx2lEzytkYmtCWf7TvM4wW8QcuIdK5ZeOEFdMj7gqMwcBeHWMv2
        qh2cuEWgOlnK1ctEK8ZIqb2adg==
X-Google-Smtp-Source: AGHT+IGfuQHaisNrB06g+lM8DTnZejhWb0AvcDwNQlGyVyddAaYvBx9qw9hwTN1kM9+mHaBZBNHmCA==
X-Received: by 2002:a05:600c:3781:b0:401:73b2:f043 with SMTP id o1-20020a05600c378100b0040173b2f043mr2208214wmr.1.1693999574258;
        Wed, 06 Sep 2023 04:26:14 -0700 (PDT)
Received: from localhost.localdomain ([2a02:6b6a:b5c7:0:6dce:31d8:efb1:5d81])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c294900b003feff926fc5sm19517038wmd.17.2023.09.06.04.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 04:26:13 -0700 (PDT)
From:   Usama Arif <usama.arif@bytedance.com>
To:     linux-mm@kvack.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        rppt@kernel.org
Cc:     linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        punit.agrawal@bytedance.com, Usama Arif <usama.arif@bytedance.com>
Subject: [v4 1/4] mm: hugetlb_vmemmap: Use nid of the head page to reallocate it
Date:   Wed,  6 Sep 2023 12:26:02 +0100
Message-Id: <20230906112605.2286994-2-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230906112605.2286994-1-usama.arif@bytedance.com>
References: <20230906112605.2286994-1-usama.arif@bytedance.com>
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

If tail page prep and initialization is skipped, then the "start"
page will not contain the correct nid. Use the nid from first
vmemap page.

Signed-off-by: Usama Arif <usama.arif@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb_vmemmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index aeb7dd889eee..3cdb38d87a95 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -319,7 +319,7 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
 		.reuse_addr	= reuse,
 		.vmemmap_pages	= &vmemmap_pages,
 	};
-	int nid = page_to_nid((struct page *)start);
+	int nid = page_to_nid((struct page *)reuse);
 	gfp_t gfp_mask = GFP_KERNEL | __GFP_THISNODE | __GFP_NORETRY |
 			__GFP_NOWARN;
 
-- 
2.25.1

