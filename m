Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA57C7F3367
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbjKUQOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233518AbjKUQN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:13:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8176BD5D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 08:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pc0r5D23rBHNJck1Tzl0Wknay+soa9dLyPzStnk2UGk=; b=Hmo7ZZJet9t9EVZ40clQ8jIh5I
        vCPgjMkGKPqgmKeeHEVXc6MUtJn7O01BAiuxhcbiJQZd10B2SpJ+QX0tQ6ESuJZMfwipLAWz8i226
        3KWPaDgoQ2YyqB09obL43Su3MIbIG/gHbXXIZycsXj79xuueL3XKwr7pGu+3Onl1Z1WwTMHWy//TA
        Z1bGZLpCQoh4sQbeuMvPp9IxS/wCMVZCVInWxO22lOw8REqEv/dyVVPVutYojVsc3WsZgx8H/gEWi
        NqNtWEkR+lzQRVduZ52IWIm0G80Ocrr5LtWFMOXPEHpro3xFmlGUj8CYOdi2u9dz7WGCuKP5YEXT7
        CGyk1sfw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r5TNW-005jSi-VU; Tue, 21 Nov 2023 16:13:35 +0000
Date:   Tue, 21 Nov 2023 16:13:34 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     akpm@linux-foundation.org, david@redhat.com, hannes@cmpxchg.org,
        kirill.shutemov@linux.intel.com, shakeelb@google.com,
        n-horiguchi@ah.jp.nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] mm: migrate: rcu stalls because of invalid swap
 cache entries
Message-ID: <ZVzXLu4Ds+3aQtGm@casper.infradead.org>
References: <1700569840-17327-1-git-send-email-quic_charante@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1700569840-17327-1-git-send-email-quic_charante@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 06:00:40PM +0530, Charan Teja Kalla wrote:
> The below race on a folio between reclaim and migration exposed a bug
> of not populating the swap cache with proper folio resulting into the
> rcu stalls:

Thank you for figuring out this race and describing it so well.
It explains a few things I've seen, at least potentially.

What would you think to this?  I think a better fix would be to
fix the swap cache to user multi-order entries, but I would like to
see this backportable!

diff --git a/mm/migrate.c b/mm/migrate.c
index d9d2b9432e81..2d67ca47d2e2 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -405,6 +405,7 @@ int folio_migrate_mapping(struct address_space *mapping,
 	int dirty;
 	int expected_count = folio_expected_refs(mapping, folio) + extra_count;
 	long nr = folio_nr_pages(folio);
+	long entries, i;
 
 	if (!mapping) {
 		/* Anonymous page without mapping */
@@ -442,8 +443,10 @@ int folio_migrate_mapping(struct address_space *mapping,
 			folio_set_swapcache(newfolio);
 			newfolio->private = folio_get_private(folio);
 		}
+		entries = nr;
 	} else {
 		VM_BUG_ON_FOLIO(folio_test_swapcache(folio), folio);
+		entries = 1;
 	}
 
 	/* Move dirty while page refs frozen and newpage not yet exposed */
@@ -453,7 +456,11 @@ int folio_migrate_mapping(struct address_space *mapping,
 		folio_set_dirty(newfolio);
 	}
 
-	xas_store(&xas, newfolio);
+	/* Swap cache still stores N entries instead of a high-order entry */
+	for (i = 0; i < entries; i++) {
+		xas_store(&xas, newfolio);
+		xas_next(&xas);
+	}
 
 	/*
 	 * Drop cache reference from old page by unfreezing
