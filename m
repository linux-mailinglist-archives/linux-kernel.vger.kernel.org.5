Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11506788581
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 13:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240331AbjHYLT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 07:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243017AbjHYLTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 07:19:16 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B6F1FC4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 04:18:50 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-31c65820134so623900f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 04:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692962329; x=1693567129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxvZHKtYENKC1N901ur/ZbT/Aj89mU0uDVwxqxk+868=;
        b=K/Jam9neS+gbs4EpfQDhGOSkHOH1JbnmbxU85K89H2k7ENKtddEhSBMHutTYc2ujhw
         ZMp0c1Adl/pniAsythqyZLNw4NXnEULOCFp0MuLwG2lxrPEoKnblKqitSh0fpcWNhXkz
         C4MYw4KlJP7ZB7HCzQeS49dldXs559hTCc1db7Kq3xFpD1EY8DCo7sLfxOqmJl6PxG/S
         wbJjBOIR3B2vAcL9tu3KuUiquHb/e+5RaoNbkUK/TBgFdvAo0zeqvkuVeYFqFBSB6MUa
         tZwke+2F5iihc4kb3eDabnmS298FS/DaifERsJLqGQC2ThyLlXPsFG2aaNJGbHq00ppL
         y1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692962329; x=1693567129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nxvZHKtYENKC1N901ur/ZbT/Aj89mU0uDVwxqxk+868=;
        b=VKWOQc0jgB9BLBHOMQniDlLQe+PEs6ZhSXvmkmcC3BdtO9ir9Om1zX76b/A0OLYYyY
         Avjib2KXDjvHla6BwmW3K5ckRX3o9ae8qVv+oJ3lV814HSOBoSuar8QnbGhP6AbSrn/y
         WOfYzpSGwM9wzfUh/RO96wiYt69fnPv8KWw68IBDT8VzZdkdatUFVhdxYCGvc9QXjkea
         c0PHNNaJecynhzEOmgrGx4Ho1Rh/YI9+CBW1zV4aOR86zupWDge9SIAIr6WiJCyfnhsy
         b4PF0iZFKMEU2mX7cpEHTfO7vuOvcXwxnfnOHTm8RnAXtAi81Kju55biumC7sUbVN/QG
         FrNQ==
X-Gm-Message-State: AOJu0Yxx4xZJuCfw41aox/Bs4HN8oTDIMuA/itSHXYwyiLSW23pdzuCY
        UUfbHSynxKDR5lLYPcOta1W+/A==
X-Google-Smtp-Source: AGHT+IG7fidFBnhPCCm7z2OPyt2Wleqo2J6p8ROG+32Spl+z/EhkhXc8nY2Kixdo4gyAJlJbfWGltA==
X-Received: by 2002:a5d:568f:0:b0:317:e5ec:8767 with SMTP id f15-20020a5d568f000000b00317e5ec8767mr13413417wrv.21.1692962329092;
        Fri, 25 Aug 2023 04:18:49 -0700 (PDT)
Received: from localhost.localdomain ([2a02:6b6a:b5c7:0:9000:8d13:d0bb:ba7d])
        by smtp.gmail.com with ESMTPSA id g9-20020a056000118900b0031ad5fb5a0fsm1939502wrx.58.2023.08.25.04.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 04:18:48 -0700 (PDT)
From:   Usama Arif <usama.arif@bytedance.com>
To:     linux-mm@kvack.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        rppt@kernel.org
Cc:     linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        punit.agrawal@bytedance.com, Usama Arif <usama.arif@bytedance.com>
Subject: [v3 1/4] mm: hugetlb_vmemmap: Use nid of the head page to reallocate it
Date:   Fri, 25 Aug 2023 12:18:33 +0100
Message-Id: <20230825111836.1715308-2-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230825111836.1715308-1-usama.arif@bytedance.com>
References: <20230825111836.1715308-1-usama.arif@bytedance.com>
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
---
 mm/hugetlb_vmemmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index c2007ef5e9b0..208907f2c5e1 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -324,7 +324,7 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
 		.reuse_addr	= reuse,
 		.vmemmap_pages	= &vmemmap_pages,
 	};
-	int nid = page_to_nid((struct page *)start);
+	int nid = page_to_nid((struct page *)reuse);
 	gfp_t gfp_mask = GFP_KERNEL | __GFP_THISNODE | __GFP_NORETRY |
 			__GFP_NOWARN;
 
-- 
2.25.1

