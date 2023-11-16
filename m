Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE3F7ED8E1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 02:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344476AbjKPB3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 20:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344326AbjKPB3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 20:29:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4538419B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 17:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700098160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PGiD5LrOPbNAVIZVL9CsLOYGNogun3F0ZNXBV5lOZSk=;
        b=LgKVGdB6I4hNe4lwEdpQGH/NWKuJhQm4TWd80F/drBP9Vq8+DJCrNjCFv/e2kuYEzj5+7d
        e3ZI6JJ9s8w+mluRgz+vQmVYzjLiY7p4QY+g3zRawMDOY2z+hgurdBfHgiSJViKCvNQYr6
        S95Aih6Eb2bBC33DMba37QwRgM6LpgQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-w0VJCoTSNWCS79fGDUeRTw-1; Wed, 15 Nov 2023 20:29:17 -0500
X-MC-Unique: w0VJCoTSNWCS79fGDUeRTw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-66ffa15d354so814626d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 17:29:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700098156; x=1700702956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PGiD5LrOPbNAVIZVL9CsLOYGNogun3F0ZNXBV5lOZSk=;
        b=FJ8tWTHSk7IrYTtgVBxiuvJsBDwI9TAywTI9/KP81JFBMTD004U5/1PrtccqxC+Xkh
         IVwp9SRsLDKoD9ebHCG86graWF20A7ICcwfb3WEDaTLxNssqoQkr/vJOjGp3/fwubx+I
         Y0G0nJrmWrh/btWLcDrqxzGz7SCBh4YkJOBqwqbwvXYSBHQYajKPfs/31UOE1aY9AkxD
         CcTSYYjYqsmCWsknGO2rhtyTdan/VvVAxLq2SoCn9QqnFbyhFAYPSJCtyzQRYwLw5K+0
         +WHpYhpqluAv6RQzV/tz0exP1bU+nGIrym8RIr9Tb3gAcOhWQWjoJzv8clJkmmHvyqe2
         JAHw==
X-Gm-Message-State: AOJu0Yx9GOtu0iC3/zK1za/xuyk4dpw1sTCc/EyS5n5pNgP9Od8BQ9R7
        LVheTEt/84XV1vrY/26q7ORNrZ35BpDcpbIgxg9AszZGCRRsVmh4yB1v3agZ+rvVttMinK+Nqsl
        iNnh2E5gSwNI5u/By5Mj9jQOT5RNnvxqc/5UTqCqpLyeND4xEy9d+7pvDcOQh3cGvqqRwcIeMYB
        LZsw38+A==
X-Received: by 2002:a05:622a:8008:b0:41e:a62b:3d28 with SMTP id jr8-20020a05622a800800b0041ea62b3d28mr6714107qtb.4.1700098156347;
        Wed, 15 Nov 2023 17:29:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEODK+EO2T6pc5X1e/ytZXEP5MAlQvhJeor+MetW91HDS49FOIp5Z13gLBn7JzEPU2jgEp9Cg==
X-Received: by 2002:a05:622a:8008:b0:41e:a62b:3d28 with SMTP id jr8-20020a05622a800800b0041ea62b3d28mr6714076qtb.4.1700098155869;
        Wed, 15 Nov 2023 17:29:15 -0800 (PST)
Received: from x1n.redhat.com (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id c24-20020ac85198000000b0041e383d527esm3922598qtn.66.2023.11.15.17.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 17:29:15 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>, peterx@redhat.com,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        James Houghton <jthoughton@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH RFC 03/12] mm: Export HPAGE_PXD_* macros even if !THP
Date:   Wed, 15 Nov 2023 20:28:59 -0500
Message-ID: <20231116012908.392077-4-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231116012908.392077-1-peterx@redhat.com>
References: <20231116012908.392077-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These macros can be helpful when we plan to merge hugetlb code into generic
code.  Move them out and define them even if !THP.

We actually already defined HPAGE_PMD_NR for other reasons even if !THP.
Reorganize these macros.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/huge_mm.h | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index fa0350b0812a..ec463410aecc 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -64,17 +64,19 @@ ssize_t single_hugepage_flag_show(struct kobject *kobj,
 				  enum transparent_hugepage_flag flag);
 extern struct kobj_attribute shmem_enabled_attr;
 
-#define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
-#define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
-
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #define HPAGE_PMD_SHIFT PMD_SHIFT
 #define HPAGE_PMD_SIZE	((1UL) << HPAGE_PMD_SHIFT)
 #define HPAGE_PMD_MASK	(~(HPAGE_PMD_SIZE - 1))
+#define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
+#define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
 
 #define HPAGE_PUD_SHIFT PUD_SHIFT
 #define HPAGE_PUD_SIZE	((1UL) << HPAGE_PUD_SHIFT)
 #define HPAGE_PUD_MASK	(~(HPAGE_PUD_SIZE - 1))
+#define HPAGE_PUD_ORDER (HPAGE_PUD_SHIFT-PAGE_SHIFT)
+#define HPAGE_PUD_NR (1<<HPAGE_PUD_ORDER)
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 
 extern unsigned long transparent_hugepage_flags;
 
@@ -254,13 +256,6 @@ static inline bool thp_migration_supported(void)
 }
 
 #else /* CONFIG_TRANSPARENT_HUGEPAGE */
-#define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
-#define HPAGE_PMD_MASK ({ BUILD_BUG(); 0; })
-#define HPAGE_PMD_SIZE ({ BUILD_BUG(); 0; })
-
-#define HPAGE_PUD_SHIFT ({ BUILD_BUG(); 0; })
-#define HPAGE_PUD_MASK ({ BUILD_BUG(); 0; })
-#define HPAGE_PUD_SIZE ({ BUILD_BUG(); 0; })
 
 static inline bool folio_test_pmd_mappable(struct folio *folio)
 {
-- 
2.41.0

