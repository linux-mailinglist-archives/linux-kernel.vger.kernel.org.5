Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F3679E854
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 14:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240515AbjIMMwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 08:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238125AbjIMMwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 08:52:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B04219B1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 05:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694609479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9L5orXA49Ta9+cSBXm9ctIOTPZV+C60BUWB87EtMv4Y=;
        b=LtQ2IwJUz2d57lIE4Vzxgna6EsbxQwlcx11eEBG7T3bs5Covv4PJlbpjd6xAzvUpZyNQ0D
        t3bBM9oLKJZn/1wdsayUY1XPOyNw2FSlFpE+7Sjawzgav0h7RRO5aIeqBaj1D2iG9GujG3
        HJxBwGeOxeagZez4WJc12jVdGJyfU14=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-600--iYlVuCWNnuGtJb8YMJ3Zw-1; Wed, 13 Sep 2023 08:51:17 -0400
X-MC-Unique: -iYlVuCWNnuGtJb8YMJ3Zw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 176F888B7A7;
        Wed, 13 Sep 2023 12:51:17 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3982A21B2413;
        Wed, 13 Sep 2023 12:51:15 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>
Subject: [PATCH v1 0/6] Anon rmap cleanups
Date:   Wed, 13 Sep 2023 14:51:07 +0200
Message-ID: <20230913125113.313322-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some cleanups around rmap for anon pages. I'm working on more cleanups
also around file rmap -- also to handle the "compound" parameter
internally only and to let hugetlb use page_add_file_rmap(), but these
changes make sense separately.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Muchun Song <muchun.song@linux.dev>

David Hildenbrand (6):
  mm/rmap: drop stale comment in page_add_anon_rmap and
    hugepage_add_anon_rmap()
  mm/rmap: move SetPageAnonExclusive out of __page_set_anon_rmap()
  mm/rmap: move folio_test_anon() check out of __folio_set_anon()
  mm/rmap: warn on new PTE-mapped folios in page_add_anon_rmap()
  mm/rmap: simplify PageAnonExclusive sanity checks when adding anon
    rmap
  mm/rmap: pass folio to hugepage_add_anon_rmap()

 include/linux/rmap.h |  2 +-
 mm/migrate.c         |  2 +-
 mm/rmap.c            | 79 +++++++++++++++++++++-----------------------
 3 files changed, 39 insertions(+), 44 deletions(-)

-- 
2.41.0

