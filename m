Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517F67FC185
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346366AbjK1OwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346347AbjK1OwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:52:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6844BD5D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701183130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=67STPsy6Yttu5OTEOdQdes0zyFL6yGDHY2kQG1seqTc=;
        b=dnWiF7tHh3T1y4v5o6v4IOZOBwIRZvKsGcIIo5O4s5jmHtLuiO23fX4uyDPstw/yIeciht
        meEUggFawqZMWpVLPIqOoHNZ53oYZwREtCg8ygwPYZU9oYbD4zWXtZjCRt5hpK5dlxXQ72
        K6Cog+d37m97tYCDqEkyaGS0lqUnzQA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-XDuPIX5MMNWkPMG8m_m4UQ-1; Tue, 28 Nov 2023 09:52:07 -0500
X-MC-Unique: XDuPIX5MMNWkPMG8m_m4UQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DEC1680D730;
        Tue, 28 Nov 2023 14:52:06 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.189])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D3DE75028;
        Tue, 28 Nov 2023 14:52:05 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>
Subject: [PATCH v1 0/5] mm/rmap: separate hugetlb rmap handling
Date:   Tue, 28 Nov 2023 15:52:00 +0100
Message-ID: <20231128145205.215026-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's just cleanly separate hugetlb rmap handling from "ordinary" rmap
handling, like we already do when adding anon hugetlb folios. We have
hugetlb special-casing/checks in the callers in all cases either way
already in place: it doesn't make too much sense to call generic-looking
functions that end up doing hugetlb specific things from hugetlb
special-cases.

This now also means that we won't run into "folio_test_pmd_mappable()"
cases for hugetlb, which doesn't make too much sense with gigantic hugetlb
folios that are in fact currently only PUD-mappable. Or having a
folio_add_file_rmap() function that looks like it clould be used by hugetlb
code, but really can't.

This is a stanalone cleanup, but it gets more relevant when adding more
rmap batching (we cannot map parts of a hugetlb folio) or changing the way
we handle partially-mappable folios as in [1], whereby we'd have to add
more hugetlb special casing to keep hugetlb working as is.

If ever something about hugetlb changes that makes them actually
partially-mappable folios, we can look into cleanly merging all code
paths, not just some.

[1] https://lkml.kernel.org/r/20231124132626.235350-1-david@redhat.com

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Muchun Song <muchun.song@linux.dev>

David Hildenbrand (5):
  mm/rmap: rename hugepage_add* to hugetlb_add*
  mm/rmap: introduce and use hugetlb_remove_rmap()
  mm/rmap: introduce and use hugetlb_add_file_rmap()
  mm/rmap: introduce and use hugetlb_try_dup_anon_rmap()
  mm/rmap: add hugetlb sanity checks

 include/linux/mm.h   | 12 +++++++++---
 include/linux/rmap.h | 37 +++++++++++++++++++++++++++++++++++--
 mm/hugetlb.c         | 21 ++++++++++-----------
 mm/migrate.c         |  6 +++---
 mm/rmap.c            | 31 ++++++++++++++++++-------------
 5 files changed, 75 insertions(+), 32 deletions(-)


base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
-- 
2.41.0

