Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38427A49B9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240411AbjIRMct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240205AbjIRMcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:32:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783E0A0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 05:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cpAbBYTKmkzihhvn0GK5MWKwNefggPh+NJadP+iJe64=; b=AUbHTaw3Bu9yRf7DiCxmD8MH7+
        AokoqwUpFQ1Z2q2IHHJaO5LQ0J4ry1kIOSc0X3mVEtj3rGuAKtYsPkHo/i/G6+94B804BgasRX4um
        SrFm8k8/Jofn6g4qQc06eYEjTvwkRoZ2YPGHBt9NbfKCCOxKzNZwI9R5wODXd1pMSI9ZSDFL6cE5W
        YFblzjIVE1SleTxGO8Gt1gURYO5N3hckaepRphZcfk8f/oUMS+69HPxVa/6n1iFW7Ec/PoKqOlpAD
        k0vqdMbXN7hEuiBJoYZnDaJ/zrgL0c5pwbZOhs9+zIj/BKxQ2j+QJp69lfH869rUmXHmSkxPVNjmw
        i02oLksw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qiDQ6-00B20W-Ow; Mon, 18 Sep 2023 12:32:06 +0000
Date:   Mon, 18 Sep 2023 13:32:06 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     syzbot <syzbot+6e4f59235036c3c2e296@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] WARNING in page_add_anon_rmap
Message-ID: <ZQhDRtWYSJWfHvEM@casper.infradead.org>
References: <0000000000008bf71d06059a2276@google.com>
 <a841592f-942d-b1b7-db93-7bd31c96e4eb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a841592f-942d-b1b7-db93-7bd31c96e4eb@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 12:00:24PM +0200, David Hildenbrand wrote:
> > If you want syzbot to run the reproducer, reply with:
> > #syz test: git://repo/address.git branch-or-commit-hash
> > If you attach or paste a git patch, syzbot will apply it before testing.

If I understand correctly, you have to do it like this:

#syz test

diff --git a/mm/rmap.c b/mm/rmap.c
index 789a2beb8b3a..f13a2927163d 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1249,8 +1249,10 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
 	}
 	if (flags & RMAP_EXCLUSIVE)
 		SetPageAnonExclusive(page);
-	VM_WARN_ON_FOLIO(page_mapcount(page) > 1 && PageAnonExclusive(page),
-			 folio);
+	/* While PTE-mapping a THP we have a PMD and a PTE mapping. */
+	VM_WARN_ON_FOLIO((atomic_read(&page->_mapcount) > 0 ||
+			  (folio_test_large(folio) && folio_entire_mapcount(folio) > 1)) &&
+			 PageAnonExclusive(page), folio);
 	mlock_vma_folio(folio, vma, compound);
 }
-- 
