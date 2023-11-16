Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3497ED8E2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 02:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344488AbjKPB3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 20:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344454AbjKPB30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 20:29:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA18199
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 17:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700098162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iVPh5vUSg15R+EjRvyUTGLnvTLGftOOyrePNaUJdD/U=;
        b=JGtAcCe9WHOXOtrqPb64GnJVE6w2GU9IMp9LSE+DCMXMvb/Im37grqe9PWvvqtY4HcefFj
        WyIj0z31+EEpk2kdYStFkdrNIgI9U+cFwKMStyfJg7XNxvbpUGRqM2DvZHAThMl0jYI4L4
        zPG1GL6D+HI1VFF8Be/T/EVW3xRIdMU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-2VO4HHQ_NoW6PizvXzl5Nw-1; Wed, 15 Nov 2023 20:29:20 -0500
X-MC-Unique: 2VO4HHQ_NoW6PizvXzl5Nw-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-41eb42115e9so899351cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 17:29:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700098159; x=1700702959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iVPh5vUSg15R+EjRvyUTGLnvTLGftOOyrePNaUJdD/U=;
        b=EVLJgYzbG9zKeP5DkNaiA2171uiCSv9C/hxeJUnOv70IgsOv6/gSE8Qm18Sofmlnig
         YYmOqMdC7mYAPoH+mV3HaYCr38Dr8Q4uQ9+XSBjn0/C6iNNDvo9VBLJiOiZF6pqc1JII
         Nc2w9qhuZvfMBvLBtg2HyxoOEKfy82HR2Ah39v3xtXJG+lUmihqPc84RW1nOePihrAMv
         ELrUhGJB+SAsnHuGEgkx2r8toH2TKSqVfKPu+TVuDQZCleMQmuO/D8J00fr/gFqBUd1T
         ia9y+LZpR60K7OhuHrkqPTIfX+AXL7347oK1mUP8igHeempXhLNXRoss8yKw7p0OsU6+
         /aig==
X-Gm-Message-State: AOJu0YxfDVtwfqnbd+Q5vdzrIoYyS+bt29fhzaD1F3Ib40eLhmBL9Pv7
        qvs79cMkLCjx3/xe7UUrXXiIVyvd7TGON4B5915qqtxJZSriCCmna5h9Vu1UW071Tg7gPJGncI5
        EmxBx3JOcFG/4VciACw+od0YKoZ/wHo5YacMD8I7bWtu5KLw1H66ypsWzA/AD6c6uEKcjLokER2
        fUWjveEQ==
X-Received: by 2002:ac8:4716:0:b0:421:b9be:d4a4 with SMTP id f22-20020ac84716000000b00421b9bed4a4mr6891661qtp.0.1700098159514;
        Wed, 15 Nov 2023 17:29:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJxMhrfIQJHLleHfYWSj3v7NIOAggKaUbuvyUHKkhcdknXN7d9JWqJ2v9ElBIqwX+6WGc0WQ==
X-Received: by 2002:ac8:4716:0:b0:421:b9be:d4a4 with SMTP id f22-20020ac84716000000b00421b9bed4a4mr6891630qtp.0.1700098159208;
        Wed, 15 Nov 2023 17:29:19 -0800 (PST)
Received: from x1n.redhat.com (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id c24-20020ac85198000000b0041e383d527esm3922598qtn.66.2023.11.15.17.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 17:29:18 -0800 (PST)
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
Subject: [PATCH RFC 05/12] mm/gup: Fix follow_devmap_p[mu]d() to return even if NULL
Date:   Wed, 15 Nov 2023 20:29:01 -0500
Message-ID: <20231116012908.392077-6-peterx@redhat.com>
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

This seems to be a bug not by any report but by code observations.

When GUP sees a devpmd or devpud, it should return whatever value returned
from follow_devmap_p[mu]d().  If page==NULL returned, it means a fault is
probably required.  Skipping return the NULL should allow the code to fall
through, which can cause unexpected behavior.

It was there at least before the follow page rework (080dbb618b) in 2017,
so 6 years.  Not yet digging for a Fixes, assuming it can hardly trigger
even if the logical bug does exist.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index a8b73a8289ad..0e00204761d2 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -708,8 +708,7 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 		ptl = pmd_lock(mm, pmd);
 		page = follow_devmap_pmd(vma, address, pmd, flags, &ctx->pgmap);
 		spin_unlock(ptl);
-		if (page)
-			return page;
+		return page;
 	}
 	if (likely(!pmd_trans_huge(pmdval)))
 		return follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
@@ -756,8 +755,7 @@ static struct page *follow_pud_mask(struct vm_area_struct *vma,
 		ptl = pud_lock(mm, pud);
 		page = follow_devmap_pud(vma, address, pud, flags, &ctx->pgmap);
 		spin_unlock(ptl);
-		if (page)
-			return page;
+		return page;
 	}
 	if (unlikely(pud_bad(*pud)))
 		return no_page_table(vma, flags);
-- 
2.41.0

