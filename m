Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F18A7ED8DF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 02:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344425AbjKPB3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 20:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbjKPB3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 20:29:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630A8198
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 17:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700098156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rr9/qVNLgFGWDGzcAqjV00T9t0NzgxXDD6w387jcEYI=;
        b=NpAcFyZ/9LB3zx3oT/POa/0V2bySj9fzQ3llny5quZ0hpVWWU8UQvR7KYlxunEAezmlwtO
        I0S+oxN/XNvDnuzVJo5ZGx7xLRfFsohMFmNM8S1KFlAK2u7FAHL8pSBTv2l901oxbFj1CD
        B3qNCRouZ7dNzcuTKcW5l9ramCiuagk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-k_u7GC7_NJ-Y33KqFAf5PA-1; Wed, 15 Nov 2023 20:29:15 -0500
X-MC-Unique: k_u7GC7_NJ-Y33KqFAf5PA-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-66d7b75c854so807456d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 17:29:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700098154; x=1700702954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rr9/qVNLgFGWDGzcAqjV00T9t0NzgxXDD6w387jcEYI=;
        b=BdPGsJeQu0Z0N2pfLtaUMJWeIHJtmzwICZki8zMTcpwuBZoZXBOWCCJkLuMExhbViZ
         BBN+fUb/AV2MkeUrvwZb1AYh3ur/+JMnevRCKD6E39QiGjX3PLhKKaqfmeKsHKZg2nd7
         QwNFJw5lgTLcnsqDMVON9wJnd0Toc6r/4ulN1PkMnuPBKT3YpgVVVZtYychmM8vCxFFL
         Q0i0u6cKsOT2agxYmbLfQXWIcVLoSZEvQ3sQ0+0cRdDPlsjbAUn2DZUwhTARqmTniLJw
         ED72deEFFc92CSnKvfCbWWrekosI3d7nyYLh9Q4bHep9XLBh000m3Escdh1d7joeflic
         YMOw==
X-Gm-Message-State: AOJu0YxCiidt9RGVCXI7Oa82aMBQjZsg/EVR0t0E1nsC4w7rQg5gM97k
        zXZ27y2OQSwMsg3vE8VniVHMMQckjRzhWYuvhlxnGgsxFZS7xhX/DB7kLPOLOfrYc9GRuGuxQpy
        zWjt6y8dOswCRi2Uy/hMjGsj+cYOcFDr6KJlGSC6eWQfZA0SY/m1zLjNMVtvv8CyWs+IqDSEhZO
        +qd+sHmg==
X-Received: by 2002:ac8:5189:0:b0:421:c275:f917 with SMTP id c9-20020ac85189000000b00421c275f917mr7201803qtn.6.1700098154738;
        Wed, 15 Nov 2023 17:29:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFImkFHmltxmevzx1fu9EK+pMFz+bfHbyIeYa7FxbalfbUu9NzmbSIrMhaQwUJeT0EwTIDDnQ==
X-Received: by 2002:ac8:5189:0:b0:421:c275:f917 with SMTP id c9-20020ac85189000000b00421c275f917mr7201781qtn.6.1700098154444;
        Wed, 15 Nov 2023 17:29:14 -0800 (PST)
Received: from x1n.redhat.com (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id c24-20020ac85198000000b0041e383d527esm3922598qtn.66.2023.11.15.17.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 17:29:14 -0800 (PST)
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
Subject: [PATCH RFC 02/12] mm: Provide generic pmd_thp_or_huge()
Date:   Wed, 15 Nov 2023 20:28:58 -0500
Message-ID: <20231116012908.392077-3-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231116012908.392077-1-peterx@redhat.com>
References: <20231116012908.392077-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM defines pmd_thp_or_huge(), detecting either a THP or a huge PMD.  It
can be a helpful helper if we want to merge more THP and hugetlb code
paths.  Make it a generic default implementation, only exist when
CONFIG_MMU.  Arch can overwrite it by defining its own version.

For example, ARM's pgtable-2level.h defines it to always return false.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/pgtable.h | 4 ++++
 mm/gup.c                | 3 +--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index af7639c3b0a3..6f2fa1977b8a 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1355,6 +1355,10 @@ static inline int pmd_write(pmd_t pmd)
 #endif /* pmd_write */
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
+#ifndef pmd_thp_or_huge
+#define pmd_thp_or_huge(pmd)	(pmd_huge(pmd) || pmd_trans_huge(pmd))
+#endif
+
 #ifndef pud_write
 static inline int pud_write(pud_t pud)
 {
diff --git a/mm/gup.c b/mm/gup.c
index 231711efa390..a8b73a8289ad 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -3002,8 +3002,7 @@ static int gup_pmd_range(pud_t *pudp, pud_t pud, unsigned long addr, unsigned lo
 		if (!pmd_present(pmd))
 			return 0;
 
-		if (unlikely(pmd_trans_huge(pmd) || pmd_huge(pmd) ||
-			     pmd_devmap(pmd))) {
+		if (unlikely(pmd_thp_or_huge(pmd) || pmd_devmap(pmd))) {
 			/* See gup_pte_range() */
 			if (pmd_protnone(pmd))
 				return 0;
-- 
2.41.0

