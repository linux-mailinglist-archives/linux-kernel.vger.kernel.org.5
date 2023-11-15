Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41AC37EC79C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjKOPuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjKOPuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:50:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BB6196
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 07:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700063402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=71Btu3XYwWZK+FmqHCgDmjFCfU/69a0+IvtQoWaiN/g=;
        b=cs99e+sxZCmsydxlhkOjAydfc4EWDUPNWFb95KZpo6K/hsdGJNwk1Pwt60NyZMxCq+8JKo
        uo0Z4gwr2D8UfBGr/lRYzZrrICOaQ5C3ESWEfD6R8xMgj/LjN9txLMh/oV+eh+er1jYFCp
        0fstdgKyyaRPVguSVnYcFIwW3omiba8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-230-IlTGLqZBOdmHvz4PCUDiHg-1; Wed,
 15 Nov 2023 10:49:58 -0500
X-MC-Unique: IlTGLqZBOdmHvz4PCUDiHg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D97E13C000B4;
        Wed, 15 Nov 2023 15:49:56 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4FED7492BE0;
        Wed, 15 Nov 2023 15:49:54 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        David Laight <David.Laight@ACULAB.COM>,
        Matthew Wilcox <willy@infradead.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v3 01/10] iov_iter: Fix some checkpatch complaints in kunit tests
Date:   Wed, 15 Nov 2023 15:49:37 +0000
Message-ID: <20231115154946.3933808-2-dhowells@redhat.com>
In-Reply-To: <20231115154946.3933808-1-dhowells@redhat.com>
References: <20231115154946.3933808-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some checkpatch complaints in the new iov_iter kunit tests:

 (1) Some lines had eight spaces instead of a tab at the start.

 (2) Checkpatch doesn't like (void*)(unsigned long)0xnnnnnULL, so switch to
     using POISON_POINTER_DELTA plus an offset instead.

Reported-by: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Christian Brauner <brauner@kernel.org>
cc: Jens Axboe <axboe@kernel.dk>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: David Hildenbrand <david@redhat.com>
cc: John Hubbard <jhubbard@nvidia.com>
cc: Brendan Higgins <brendanhiggins@google.com>
cc: David Gow <davidgow@google.com>
cc: linux-kselftest@vger.kernel.org
cc: kunit-dev@googlegroups.com
cc: linux-mm@kvack.org
cc: linux-fsdevel@vger.kernel.org
---
 lib/kunit_iov_iter.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/kunit_iov_iter.c b/lib/kunit_iov_iter.c
index 859b67c4d697..4a6c0efd33f5 100644
--- a/lib/kunit_iov_iter.c
+++ b/lib/kunit_iov_iter.c
@@ -53,7 +53,7 @@ static void *__init iov_kunit_create_buffer(struct kunit *test,
 	void *buffer;
 
 	pages = kunit_kcalloc(test, npages, sizeof(struct page *), GFP_KERNEL);
-        KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pages);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pages);
 	*ppages = pages;
 
 	got = alloc_pages_bulk_array(GFP_KERNEL, npages, pages);
@@ -63,7 +63,7 @@ static void *__init iov_kunit_create_buffer(struct kunit *test,
 	}
 
 	buffer = vmap(pages, npages, VM_MAP | VM_MAP_PUT_PAGES, PAGE_KERNEL);
-        KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buffer);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buffer);
 
 	kunit_add_action_or_reset(test, iov_kunit_unmap, buffer);
 	return buffer;
@@ -548,7 +548,7 @@ static void __init iov_kunit_extract_pages_kvec(struct kunit *test)
 		size_t offset0 = LONG_MAX;
 
 		for (i = 0; i < ARRAY_SIZE(pagelist); i++)
-			pagelist[i] = (void *)(unsigned long)0xaa55aa55aa55aa55ULL;
+			pagelist[i] = (void *)POISON_POINTER_DELTA + 0x5a;
 
 		len = iov_iter_extract_pages(&iter, &pages, 100 * 1024,
 					     ARRAY_SIZE(pagelist), 0, &offset0);
@@ -626,7 +626,7 @@ static void __init iov_kunit_extract_pages_bvec(struct kunit *test)
 		size_t offset0 = LONG_MAX;
 
 		for (i = 0; i < ARRAY_SIZE(pagelist); i++)
-			pagelist[i] = (void *)(unsigned long)0xaa55aa55aa55aa55ULL;
+			pagelist[i] = (void *)POISON_POINTER_DELTA + 0x5a;
 
 		len = iov_iter_extract_pages(&iter, &pages, 100 * 1024,
 					     ARRAY_SIZE(pagelist), 0, &offset0);
@@ -709,7 +709,7 @@ static void __init iov_kunit_extract_pages_xarray(struct kunit *test)
 			size_t offset0 = LONG_MAX;
 
 			for (i = 0; i < ARRAY_SIZE(pagelist); i++)
-				pagelist[i] = (void *)(unsigned long)0xaa55aa55aa55aa55ULL;
+				pagelist[i] = (void *)POISON_POINTER_DELTA + 0x5a;
 
 			len = iov_iter_extract_pages(&iter, &pages, 100 * 1024,
 						     ARRAY_SIZE(pagelist), 0, &offset0);

