Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E262A7ED8E3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 02:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344517AbjKPB3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 20:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344498AbjKPB3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 20:29:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8DB199
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 17:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700098163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bUKDadnp+1aD4MuuhezpyppaSOr8lCSuMGXbTAXddpQ=;
        b=EQ9DHPYog5gjUZU2fkQMByjxMp4TytU1nvXgGzlu7Qx8kOBVGotuAfA4DZZg/X+HQpsfay
        R7uUAF/At2X+V0FiQeYu7Mk8XrSuxtK2iM41rRw8rcffqaBypE9rtFb+qEbE3/VdIt1me5
        zy1k4uWq4Fx9WeH551GIij5CmWwD/Oc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-4Qd8MIcmOk-Nvc_gpjxIoQ-1; Wed, 15 Nov 2023 20:29:21 -0500
X-MC-Unique: 4Qd8MIcmOk-Nvc_gpjxIoQ-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-41cbafdb4b6so931571cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 17:29:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700098161; x=1700702961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bUKDadnp+1aD4MuuhezpyppaSOr8lCSuMGXbTAXddpQ=;
        b=k9eEFSbhhlgrcGtAikDFRan7CnSbGRU1FQkSi3E5dvBWBXKdmrfxSwbuIbJRqSJmOH
         5VYE1YAu8LdMxpnZqB06FAWOpSTBEkS/BaL0zenC6ETYUeIYPijpodxApMBIzHRnw6+G
         qhD83jcuSiXTP0xiRhqY25OQXDFza/MQTQxONxh3DCppN3e8ERaHB/AVuKMu0hl8shmg
         1Bqd2LyStajvfU78XJ3sMY/EEVhcfBgkQm9K7TmiACl/SeBr59TihLxwSwXT6nYpp7hM
         vgOwJOyn9/YnFhIpgq2/zYTHgpiVRF9BUHRAf1vFHiB3Ba9wsUDwvgv1zf5b3RUHVmkk
         HNEA==
X-Gm-Message-State: AOJu0Yzh6vWbY0n/PDkqTVsRE04oxzCGL9W1hpHiO4npGoz7kPy92W8U
        gBgqUZ6BTQOaTMpgeB/8JR8cOlo0sg/5mdMO4bGrx1jCVSKen/8g3iLDWMyLgoeEW+lqyXQwncj
        bWzZNx43CXF8Ny7ajiBBifzp09uapLQEqqFK/twIyTjaZcNOzdBWRlS0XEowj9dRcVgL/gz0qbl
        NpiWFygw==
X-Received: by 2002:a05:622a:810e:b0:41c:d433:6c86 with SMTP id jx14-20020a05622a810e00b0041cd4336c86mr6482576qtb.4.1700098161061;
        Wed, 15 Nov 2023 17:29:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBd1/VL7OzaVonjYuLiYORLZv0OSCh6ZT9Z6PevvXUdWDeqJg/IL5dpgLaUCzFthgUgScdWA==
X-Received: by 2002:a05:622a:810e:b0:41c:d433:6c86 with SMTP id jx14-20020a05622a810e00b0041cd4336c86mr6482544qtb.4.1700098160768;
        Wed, 15 Nov 2023 17:29:20 -0800 (PST)
Received: from x1n.redhat.com (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id c24-20020ac85198000000b0041e383d527esm3922598qtn.66.2023.11.15.17.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 17:29:20 -0800 (PST)
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
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH RFC 06/12] mm/gup: Drop folio_fast_pin_allowed() in hugepd processing
Date:   Wed, 15 Nov 2023 20:29:02 -0500
Message-ID: <20231116012908.392077-7-peterx@redhat.com>
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

Hugepd format is only used in PowerPC with hugetlbfs.  In commit
a6e79df92e4a ("mm/gup: disallow FOLL_LONGTERM GUP-fast writing to
file-backed mappings"), we added a check to fail gup-fast if there's
potential risk of violating GUP over writeback file systems.  That should
never apply to hugepd.

Drop that check, not only because it'll never be true for hugepd, but also
it paves way for reusing the function outside fast-gup.

Cc: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 0e00204761d2..424d45e1afb3 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2816,11 +2816,6 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 		return 0;
 	}
 
-	if (!folio_fast_pin_allowed(folio, flags)) {
-		gup_put_folio(folio, refs, flags);
-		return 0;
-	}
-
 	if (!pte_write(pte) && gup_must_unshare(NULL, flags, &folio->page)) {
 		gup_put_folio(folio, refs, flags);
 		return 0;
-- 
2.41.0

