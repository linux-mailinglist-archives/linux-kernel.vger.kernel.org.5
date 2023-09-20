Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB007A71EC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 07:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbjITFWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 01:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbjITFVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 01:21:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF95FD7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 22:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=muiwzLxZMy2jBRh4Pcbc7GxkV5wLF//W5T5aDFUGToo=; b=Z1VwBgv4GnNAEnNv9MdCTu7HQK
        jHpWqEkNRqm058IC99bKK7tUqs1ukIg+6+ZdyJP+fTHKNpeSdgBdm9vjjd8NFQamC69nYGBgg4RWL
        QiTZ5bkOzDqISdieJjn+r7kIRMJNUv/BIyi9FuPTiEbOdJAKHzIdNoOXl6bDWGFi7AajbK+BPD700
        dMoUuCr76hm8tWGihZrDYxoXvCPqQEW8mAQls80UQmOBd/fLfBkuNB/q5DS83ugJYJy/N9NAiYZSo
        dp0B0Z25hOX4Ka7Ow/lDmHSLQgMICe6s7ufeiLzsGpEsndwVJpz/VxUGY4LUK76MtQeM+pyn6fR4h
        hHrXhiSw==;
Received: from [2601:1c2:980:9ec0::9fed] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qipej-001tym-1t;
        Wed, 20 Sep 2023 05:21:45 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 12/16] xtensa: tlb: include <asm/tlb.h> for missing prototype
Date:   Tue, 19 Sep 2023 22:21:35 -0700
Message-ID: <20230920052139.10570-13-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920052139.10570-1-rdunlap@infradead.org>
References: <20230920052139.10570-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the prototype for check_tlb_sanity() to <asm/tlb.h> and use that
header to prevent a build warning:

arch/xtensa/mm/tlb.c:273:6: warning: no previous prototype for 'check_tlb_sanity' [-Wmissing-prototypes]
  273 | void check_tlb_sanity(void)

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/tlb.h |    2 ++
 arch/xtensa/mm/tlb.c          |    1 +
 2 files changed, 3 insertions(+)

diff -- a/arch/xtensa/include/asm/tlb.h b/arch/xtensa/include/asm/tlb.h
--- a/arch/xtensa/include/asm/tlb.h
+++ b/arch/xtensa/include/asm/tlb.h
@@ -18,4 +18,6 @@
 
 #define __pte_free_tlb(tlb, pte, address)	pte_free((tlb)->mm, pte)
 
+void check_tlb_sanity(void);
+
 #endif	/* _XTENSA_TLB_H */
diff -- a/arch/xtensa/mm/tlb.c b/arch/xtensa/mm/tlb.c
--- a/arch/xtensa/mm/tlb.c
+++ b/arch/xtensa/mm/tlb.c
@@ -17,6 +17,7 @@
 #include <linux/mm.h>
 #include <asm/processor.h>
 #include <asm/mmu_context.h>
+#include <asm/tlb.h>
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
 
