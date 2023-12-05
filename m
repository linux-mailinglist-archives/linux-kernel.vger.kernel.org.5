Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DCE804579
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 04:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344176AbjLEDFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 22:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344112AbjLEDFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 22:05:52 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89543BF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 19:05:58 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3b9b8522d91so844283b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 19:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1701745558; x=1702350358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jzYDmmhRG2n20WSmvmn2jO+KOPCtoJ3u06D8mep65Xg=;
        b=kQg3buZvZ6F4/DpJAKZWwepxnSOd63RTxKqTyubgcJ2C6sRD36IVtMaAMyyiyXgI3n
         CwbjMzfJOuyuMRnSlpnpt8YBvQNIEPdCtEUNHyFG3w+MP2JwTowTzR/6KkXg7FW3m78d
         pYpAZQs+jOfTVOdx+yHwS/wqpU5Rinpo2TvF+n1klPzY+BLXxrWLC39H6aZuW4PH3FpG
         FJ27ihgtu3Hclqqluo9svJR+twpJN9OqpXWz+GM96bDGobHzl14YcRF8aetB1XWZOzUt
         rzJ5BUPZ18i5gdvgTwOIQwOsElshi6Zayp/Tr7m4kxoYUHFR3518th5wqG3Dz0F5Pf/L
         jE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701745558; x=1702350358;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jzYDmmhRG2n20WSmvmn2jO+KOPCtoJ3u06D8mep65Xg=;
        b=n4waV/jzULCilWbVeg++B5FgZxYsH+Blihg3puDz/lzGJ2dLhxTaBVp3mS76J0cZvI
         tUHQ+1nZNqkRCJpuZL4hBetBQ3iJL2K73j6j5OXGvyZjdCzGP4atCV+8kNoRYP+ywQFq
         5akPmhHsqh1TDNpjgRzA2QfY38CJ0Xbs9HY8uzwrdCdckpbWnGovaEjd7vhEcNYwfmBA
         Rv1BJdzqwFOY5hSza9CfBZ7w320QSvy15yD6uK8RrVkZILajS4XswJh0LISLwR7DMMJT
         YQf6YUH9EEdNOZOgfxTTv7wPpiEgU/DxrLAAzIUteL54xFrKaFNuvR8rm0l/r+Cdh5A2
         skEg==
X-Gm-Message-State: AOJu0Yx4zY/5RlR2934s1HpuFtp5iV9LHHoeL8PrC69siquTRO5poCdL
        T+0dViLT1jQQF3pIKOklj5gTY/aYDy1o0fd/QIR7XHDm
X-Google-Smtp-Source: AGHT+IFBb0oP0UUkjKTxK2YQOmu7n4p4NPrrmlEXlUiLFndQCEE3Su2u+A+v5yzj06Eyu8u5+f6z9A==
X-Received: by 2002:a05:6808:23cb:b0:3b8:b063:6b90 with SMTP id bq11-20020a05680823cb00b003b8b0636b90mr6290092oib.63.1701745557781;
        Mon, 04 Dec 2023 19:05:57 -0800 (PST)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.12])
        by smtp.gmail.com with ESMTPSA id ff22-20020a056a002f5600b006cbafa4b426sm92435pfb.110.2023.12.04.19.05.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 04 Dec 2023 19:05:56 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, muchun.song@linux.dev,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm: hugetlb_vmemmap: add check of CONFIG_MEMORY_HOTPLUG back
Date:   Tue,  5 Dec 2023 11:05:30 +0800
Message-Id: <20231205030530.3802-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compiler will optimize the code as much as possible if we add
the check of CONFIG_MEMORY_HOTPLUG back.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb_vmemmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index eb05596662d42..be1586a114ce1 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -119,7 +119,7 @@ static int vmemmap_pmd_entry(pmd_t *pmd, unsigned long addr,
 	 *   +--+ |                        |
 	 *        +------------------------+
 	 */
-	if (unlikely(!vmemmap_walk->nr_walked)) {
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG) && unlikely(!vmemmap_walk->nr_walked)) {
 		struct page *page = head ? head + pte_index(addr) :
 				    pte_page(ptep_get(pte_offset_kernel(pmd, addr)));
 
-- 
2.20.1

