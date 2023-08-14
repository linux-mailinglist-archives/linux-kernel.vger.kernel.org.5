Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE8677C126
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 21:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbjHNT7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 15:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbjHNT6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 15:58:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4187B10F2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 12:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8y8Cxp20leez+KCFbDnHIE/08EfhVajhz7Hb7arHBgc=; b=QWU6nQ+KgBU8NhZs9pOpMN58ss
        LwMsUonJ8kXIozIOuBFgYcg/hOw1vm736P5sp0ttA16CsMcCM7aT93kVVX3BOgVps3iH8iPgdZKxI
        vwo4SG9bH+yRohnAZ8/qqWJ4zPJfM7jBIUpVCfxgLA+hNXu6FGpPrIZ6zlZSgPqm+m20u4x1PmVE+
        JZ2qsTU1CcTbNbV5/xtOKkhi1z32rqJ+PW/U5OGufOlKTW9sU65dKwZrCa/lBC/jGozp/3sf4ma/t
        3w7xuf3VYvU4nNNTOZEwmvAeZqCq+ow2Uw6ekPFmWb+wHuDkp7EEQLZAEo25ia84R6l1IPShYVyDD
        AjRhCbXg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qVdi8-003vcn-AH; Mon, 14 Aug 2023 19:58:44 +0000
Date:   Mon, 14 Aug 2023 20:58:44 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH RFC v2 0/3] mm: Properly document tail pages for a folio
Message-ID: <ZNqHdIi8ySqwoswd@casper.infradead.org>
References: <20230814184411.330496-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814184411.330496-1-peterx@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 02:44:08PM -0400, Peter Xu wrote:

Look, this is all still too complicated.  And you're trying to make
something better that I'm trying to make disappear.  I'd really rather
you spent your time worrying about making userfaultfd use folios
than faffing with this.

How about this?

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5e74ce4a28cd..873285bb5d45 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -334,11 +334,14 @@ struct folio {
 	/* public: */
 			unsigned char _folio_dtor;
 			unsigned char _folio_order;
+			/* two bytes available here */
 			atomic_t _entire_mapcount;
 			atomic_t _nr_pages_mapped;
 			atomic_t _pincount;
+			/* no more space on 32-bt */
 #ifdef CONFIG_64BIT
 			unsigned int _folio_nr_pages;
+			/* twelve bytes available on 64-bit */
 #endif
 	/* private: the union with struct page is transitional */
 		};
@@ -360,6 +363,7 @@ struct folio {
 			unsigned long _head_2a;
 	/* public: */
 			struct list_head _deferred_list;
+			/* three more words available here */
 	/* private: the union with struct page is transitional */
 		};
 		struct page __page_2;
