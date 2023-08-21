Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E85782DE9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235910AbjHUQKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbjHUQKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:10:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE8DED
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692634140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=muHISTWWYfRXSKtPnEJYxlovjaz8Sci5+XbEJ+VCnBs=;
        b=SmVrJV0iTKtxXPaLaj3Q4JJUZlkOFiWJLtACrVFpTIwrNmqO5prmv4815FnkQPbc3ltJ1r
        9AA3/hobmvWNk/MgS+M4gPss/T0vWBCDJfCI5r3FJYQafoBf3falCmFHc3zni0A5BTEigS
        apFnEbkWeBJ58AkEIQnoksfmMhsfXBM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-49-WkVWTVgaOcOgmPoTqKKANQ-1; Mon, 21 Aug 2023 12:08:57 -0400
X-MC-Unique: WkVWTVgaOcOgmPoTqKKANQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1B0C6108BF27;
        Mon, 21 Aug 2023 16:08:53 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.184])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 31539492C13;
        Mon, 21 Aug 2023 16:08:50 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Xu <peterx@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Hugh Dickins <hughd@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>
Subject: [PATCH mm-unstable v1 0/4] mm/swap: stop using page->private on tail pages for THP_SWAP + cleanups
Date:   Mon, 21 Aug 2023 18:08:45 +0200
Message-ID: <20230821160849.531668-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series stops using page->private on tail pages for THP_SWAP,
replaces folio->private by folio->swap for swapcache folios, and starts
using "new_folio" for tail pages that we are splitting to remove the usage
of page->private for swapcache handling completely.

@Willy, I added your SOB on patch #2 from [1], hoping that's ok.

[1] https://lore.kernel.org/all/ZN1IH/8JxkkOU5Ec@casper.infradead.org/

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Seth Jennings <sjenning@redhat.com>
Cc: Dan Streetman <ddstreet@ieee.org>
Cc: Vitaly Wool <vitaly.wool@konsulko.com>

David Hildenbrand (3):
  mm/swap: stop using page->private on tail pages for THP_SWAP
  mm/swap: inline folio_set_swap_entry() and folio_swap_entry()
  mm/huge_memory: work on folio->swap instead of page->private when
    splitting folio

Matthew Wilcox (1):
  mm/swap: use dedicated entry for swap in folio

 arch/arm64/mm/mteswap.c  |  5 +++--
 include/linux/mm_types.h | 35 ++++++++++++++---------------------
 include/linux/swap.h     | 12 +++++-------
 mm/huge_memory.c         | 40 +++++++++++++++++++---------------------
 mm/memory.c              |  4 ++--
 mm/rmap.c                |  2 +-
 mm/shmem.c               |  6 +++---
 mm/swap_state.c          |  6 +++---
 mm/swapfile.c            |  6 +++---
 mm/util.c                |  2 +-
 mm/vmscan.c              |  2 +-
 mm/zswap.c               |  4 ++--
 12 files changed, 57 insertions(+), 67 deletions(-)

-- 
2.41.0

