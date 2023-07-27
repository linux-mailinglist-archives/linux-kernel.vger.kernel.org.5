Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5981765D8F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 22:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjG0Uqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 16:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjG0Uqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 16:46:35 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923272D45
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 13:46:34 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3176a439606so1400731f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 13:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690490793; x=1691095593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VUFHsk/m/GY1eTNfZx8Py//rj4lEwu1OMjpML8i4XiA=;
        b=ZZUlyW4YzysoCHAYMp2/sA6YrKmTeac3t3azsTg4jDgno5140SsxzboZ2DX+sYyTar
         QBt4NCcbIwVqU6ECOkAxzfNVYTJSA4UoAO9vNAzRgOzSciNduCZzg6hsTy30yZygE/FX
         Y3IhdC9ei8B4xOpa33YxJ+rAYbRMQmfBhHWbkpR2MzbCVvhFxC5cl2XdP9qY+d1bHhgd
         lqfn5I8dfHTphHuAk/OGTexXituKKGFsXZtEGV8Pe+xS2H+P9mt/hFkl6RI2Q/3BRFmT
         8QbfWy8NIL5JwByXBCIWXDjISwNspvj4RcypyTUIR9HRGShbKOG5H+xfqxUKSelybJ2e
         i7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690490793; x=1691095593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VUFHsk/m/GY1eTNfZx8Py//rj4lEwu1OMjpML8i4XiA=;
        b=XGLUlnn1iD+NYgCwrKBTGtwffgNr6WkRbv0VflyZIkqC9iSxHp+mrMKa+L1mFJketw
         mVA5rEGN6XBAUqxuHxI4b5AjZcVXWXP33T9FmONwd10gEkGiZw+iSfyEq52HZUgvAkx6
         1O7hJGnbD90U4ybeRe5UTHPNzBmtYZoW/++QWNLKsYq3bkJOEXQA+4ZyLFi0YNpbweXR
         xalkJP/GY7OyWKxIKb49CzfvMMuV6xMV61lCVTOfDiP/dS6r6nw4ldDZb73l9sgEupck
         RfGE36Q5qRBSYLcvdmzbKyfkwhwPCHDpM0N3PUy5ov4O39Y7QBVx2mc6cD+5YJ9HVG1e
         7WdA==
X-Gm-Message-State: ABy/qLbliNXnrAtc00L9SaqcPaiRNlWyHXfTxAtIxjsiyMVGRo2blJ1M
        jQJMhG7V1eLcN6MH2gwPWYlEdA==
X-Google-Smtp-Source: APBJJlG66jp7ldTsiVfnEBvuqVAQDlHt8IOfvNpmcOCKQllr9otAKlvj+wF8PQJddxyevra73/5ciQ==
X-Received: by 2002:adf:ef4f:0:b0:314:32b6:af3 with SMTP id c15-20020adfef4f000000b0031432b60af3mr204498wrp.5.1690490792997;
        Thu, 27 Jul 2023 13:46:32 -0700 (PDT)
Received: from localhost.localdomain ([2a02:6b6a:b465:0:7e3e:db9e:70fa:9ccb])
        by smtp.gmail.com with ESMTPSA id k1-20020a7bc401000000b003fc06169abdsm2701400wmi.2.2023.07.27.13.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 13:46:32 -0700 (PDT)
From:   Usama Arif <usama.arif@bytedance.com>
To:     linux-mm@kvack.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        rppt@kernel.org
Cc:     linux-kernel@vger.kernel.org, fam.zheng@bytedance.com,
        liangma@liangbit.com, simon.evans@bytedance.com,
        punit.agrawal@bytedance.com, Usama Arif <usama.arif@bytedance.com>
Subject: [v1 2/6] mm: hugetlb_vmemmap: Use nid of the head page to reallocate it
Date:   Thu, 27 Jul 2023 21:46:20 +0100
Message-Id: <20230727204624.1942372-3-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230727204624.1942372-1-usama.arif@bytedance.com>
References: <20230727204624.1942372-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index b721e87de2b3..bdf750a4786b 100644
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

