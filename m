Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0064377B2D2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 09:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbjHNHnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 03:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234260AbjHNHne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 03:43:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A8294
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 00:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691999013; x=1723535013;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RReoo07Z8COfyQe4vCo2LnNBVJrUhMSozbnkyWWcdFM=;
  b=Y2um6b59bFJq2QJ28RbMGjgW5fghkFwKnxV4/IGQ93qnHukybI3wKcJ9
   pNtfAfMDH26fb2byq/CsMn0nj8mhp8fMkvBZ9EVX0/Ty8zw7jmycQGa2L
   U5HdBj1HyshJiw2SEcwF6TY61yW+TZqJxi2HyNFebdpawMNkhbS5G+YlH
   Vx1n5PLDqAB8uVnZt/SutaZV/2hzuuOp5sl3DHJV5UzM0j3Y9TTLIvXUJ
   7MTtP3/WEy0Q3rg8SwblLnE46YYCQ85spJv6rQsivlzrjW1FfE2tKBuMb
   BH6a0VSvw/vUAabdryqxCDmfbAzmkNmY4OQEAVss5KRIsF7Wi1OKSmIr8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="438314744"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="438314744"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 00:43:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="803372565"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="803372565"
Received: from navanban-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.127.25])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 00:43:32 -0700
Subject: [PATCH v2 4/5] mm/slab: Add __free() support for kvfree
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-coco@lists.linux.dev
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 14 Aug 2023 00:43:32 -0700
Message-ID: <169199901230.1782217.9803098171993981037.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <169199898909.1782217.10899362240465838600.stgit@dwillia2-xfh.jf.intel.com>
References: <169199898909.1782217.10899362240465838600.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow for the declaration of variables that trigger kvfree() when they
go out of scope.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/slab.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 848c7c82ad5a..241025367943 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -746,6 +746,8 @@ static inline __alloc_size(1, 2) void *kvcalloc(size_t n, size_t size, gfp_t fla
 extern void *kvrealloc(const void *p, size_t oldsize, size_t newsize, gfp_t flags)
 		      __realloc_size(3);
 extern void kvfree(const void *addr);
+DEFINE_FREE(kvfree, void *, if (_T) kvfree(_T))
+
 extern void kvfree_sensitive(const void *addr, size_t len);
 
 unsigned int kmem_cache_size(struct kmem_cache *s);

