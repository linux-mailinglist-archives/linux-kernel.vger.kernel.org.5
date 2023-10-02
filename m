Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB43E7B5502
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 16:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237781AbjJBOas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237772AbjJBOaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:30:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAF6B7
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 07:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696257000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PalIgpkg7RpREnvjJnIUIQKWWHdrC6Ts2Eu6+woe0bY=;
        b=eCSwdZe5SCNhp5uCbCp7A3QNXXPu2Lh3TxLdIONsK79Pn+5wxhlelZRXoJ5Uk0LpdSF7st
        xfrXmG7ODwtHCCLYs0l4MG1aX7F7pH3PjpKX0+zMbuiTVI3TG2fNHqRChJkWnYr/Ik7KjR
        In2WtLRqkCUtbdprusMCBqWW6OIlTlU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-259-N15ftSkwOSO7sW3jxqSNfw-1; Mon, 02 Oct 2023 10:29:52 -0400
X-MC-Unique: N15ftSkwOSO7sW3jxqSNfw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6CB14101B046;
        Mon,  2 Oct 2023 14:29:51 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1315A10EE6CE;
        Mon,  2 Oct 2023 14:29:49 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v1 0/3] mm/rmap: convert page_move_anon_rmap() to folio_move_anon_rmap()
Date:   Mon,  2 Oct 2023 16:29:46 +0200
Message-ID: <20231002142949.235104-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert page_move_anon_rmap() to folio_move_anon_rmap(), letting the
callers handle PageAnonExclusive. I'm including cleanup patch #3 because it
fits into the picture and can be done cleaner by the conversion.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>

David Hildenbrand (3):
  mm/rmap: move SetPageAnonExclusive() out of page_move_anon_rmap()
  mm/rmap: convert page_move_anon_rmap() to folio_move_anon_rmap()
  memory: move exclusivity detection in do_wp_page() into
    wp_can_reuse_anon_folio()

 include/linux/rmap.h |  2 +-
 mm/huge_memory.c     |  3 +-
 mm/hugetlb.c         |  6 ++-
 mm/memory.c          | 87 +++++++++++++++++++++++---------------------
 mm/rmap.c            | 17 ++++-----
 5 files changed, 59 insertions(+), 56 deletions(-)

-- 
2.41.0

