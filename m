Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F6275DF44
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 01:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjGVXP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 19:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjGVXPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 19:15:20 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926641708
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 16:15:17 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-76ad842d12fso245745785a.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 16:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1690067716; x=1690672516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jqX+omN+4AV/jEW9gJWFZdBmlFQeDD8EFviSI3KwL+8=;
        b=h4VGOvKMgez+/NKOawppSiHt7934PF71iQ7qv8jvSgyoGVHQdeSp1JgcRIsn2D88hx
         g2qwPAuZJScjWF75Ou+qLGKjKOMoBD6KgtLtf0HDYfqszmZ+yCoggVBesEXvtWMjVL8g
         JpUjuA4gJbUNFr73GuH0FlWZrgf5yI6+x2LMQdtPiA8g0Av/6cdf1+CYfjPWtybKpcP9
         eVd7uPFytoOlTw5R5xKtG9M76QYaPDi/SS5XihMN3binOTlJbuopN24pguAFSUKmGTZV
         KDBH4hbi0ALobtUZ6mlYQTvapei1p+n2u+rufzxhHrLS/TA6KLItQHUFRHlM6LpiyDgq
         m73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690067716; x=1690672516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jqX+omN+4AV/jEW9gJWFZdBmlFQeDD8EFviSI3KwL+8=;
        b=eLenBmQTUY3EHLJWA8o1sEZTyNYppcTihuAIeEjq3zMkQjUwNaCfOLvq8VC3DF6aKU
         FHTnt+K1ToK39UE3zzFBzmHySNI/sM9XgwDzup+hxafgEa7TFcC82TxaSCzApEvVHSiq
         tCZ1/+9mFcgMpmfQJ0I609Lrp4aKP3Tjj+B+0PjDM+4qdlmzdogxaDnM57J1asxv9s5G
         cOIqGDc0MYRh4HfrwJ8hGX0+XKsyXA4cnX8Oq5hHE+aOHhMS8ZC0kJd5zeMSP5pVepiS
         9yWbH9oCmMsu3y8V57NtW8dSF3qWuzDPp8gjLECRQdnm9hBad2K/xAsoNEHAPE7toB24
         cvOg==
X-Gm-Message-State: ABy/qLY4a6WU46dqcASOd835b7GG1oE2P4N1Lc/cCC8uovMtTqSpE2f+
        CsnMq22/ymN2r6GhBxL7sdgNdA==
X-Google-Smtp-Source: APBJJlFbRKGfdxJ0JTND8bD4QwfCFUoHWRvornko1ZnN1WHJ1NJtPHQPbc8oka0cm1metbm5E4tqEg==
X-Received: by 2002:a05:620a:2807:b0:75b:23a0:e7e9 with SMTP id f7-20020a05620a280700b0075b23a0e7e9mr4800481qkp.74.1690067716634;
        Sat, 22 Jul 2023 16:15:16 -0700 (PDT)
Received: from soleen.c.googlers.com.com (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id u21-20020ae9c015000000b007675c4b530fsm2075957qkk.28.2023.07.22.16.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 16:15:16 -0700 (PDT)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, akpm@linux-foundation.org,
        corbet@lwn.net, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, rick.p.edgecombe@intel.com
Subject: [PATCH v2 3/3] mm/page_table_check: Check writable zero page in page table check
Date:   Sat, 22 Jul 2023 23:15:08 +0000
Message-ID: <20230722231508.1030269-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230722231508.1030269-1-pasha.tatashin@soleen.com>
References: <20230722231508.1030269-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rick Edgecombe <rick.p.edgecombe@intel.com>

The zero page should remain all zero, so that it can be mapped as
read-only for read faults of memory that should be zeroed. If it is ever
mapped writable to userspace, it could become non-zero and so other apps
would unexpectedly get non-zero data. So the zero page should never be
mapped writable to userspace. Check for this condition in
page_table_check_set().

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 mm/page_table_check.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index ad4447e999f8..db1ed36f7203 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -114,6 +114,8 @@ static void page_table_check_set(struct mm_struct *mm, unsigned long addr,
 	if (!pfn_valid(pfn))
 		return;
 
+	PAGE_TABLE_CHECK_WARN(is_zero_pfn(pfn) && rw);
+
 	page = pfn_to_page(pfn);
 	page_ext = page_ext_get(page);
 
-- 
2.41.0.487.g6d72f3e995-goog

