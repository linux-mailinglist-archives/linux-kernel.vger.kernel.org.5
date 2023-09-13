Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5370079DF28
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 06:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238288AbjIME2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 00:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjIME2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 00:28:41 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF323A0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 21:28:37 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 086F0100B9C;
        Wed, 13 Sep 2023 04:28:37 +0000 (UTC)
Received: from pdx1-sub0-mail-a233.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 827A5100876;
        Wed, 13 Sep 2023 04:28:36 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1694579316; a=rsa-sha256;
        cv=none;
        b=BTcf+CMPZFBFZRkYOiTfGxe5JqX1Q2Lqd2AB3u/0fvX9GLsSNmAhlFa+K8J1yMlQzHGycP
        v1yabFqNsOGMHtHdSbqbMEzpTamiUBhNPYYF8rJSVmLod0bUs4NiIqc3mO7Ov4i0yOI/C9
        nvL27hymTV3sSKfHU4mNk8/mUwce4iWv99gJay1tt6eEIgcHVevda9WBMwYAMrKy9ZMWf5
        Tme4A5jqtGkTe95S8ibqxqZIv/UYoTMOOiAEOBFpeFMMLRubWslUHx5bWk2C4/EV+aW9Im
        ThQc3m0JmO+OwdlOg01yF9HpPGo2+GajbaTvVwFndVg2aS8XCJpD9TibD1aqIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1694579316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=/yoADglTe5LRXe8QAC7x+tHC2m5GGX8ny8N5OaZzQZk=;
        b=1nvMphhIhMYaTtidPqVQIX3cAwGS3a8/CoUZR8ReGqew5Pq71fjEl5Q/C6ytY4PEW4va+0
        7whwarpkYo9unVa4NOsnNXuNO1I//ROJpkxCO0gqkVI2JheMcc/4U/G72ljKPiR6Mlwya1
        Lzr+9hGyW/1vuUTS4Mftc1tCricwAUDAydefuoi1fbaohdr3iBbSzKVagcnLbL68JyRDqD
        JA+R2DNlmyM9LLEul3wn1oHgcj7s6Mrre4nQG/jHmOzPJyfatPwWIzZXTswTFZtE/LLZFr
        CKhcRvb3n07Uv1njkEDnK+wj2bIbe3zGIbxV+r49TqLlSoldLYLlvSwhu/ZmcQ==
ARC-Authentication-Results: i=1;
        rspamd-7c449d4847-mhc5l;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Occur-Whistle: 4acf19d25ec9ac29_1694579316833_1644878053
X-MC-Loop-Signature: 1694579316833:345388602
X-MC-Ingress-Time: 1694579316833
Received: from pdx1-sub0-mail-a233.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.96.239.67 (trex/6.9.1);
        Wed, 13 Sep 2023 04:28:36 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a233.dreamhost.com (Postfix) with ESMTPSA id 4RlnWl6dFnz2W;
        Tue, 12 Sep 2023 21:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1694579316;
        bh=/yoADglTe5LRXe8QAC7x+tHC2m5GGX8ny8N5OaZzQZk=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=eALfO7pd8+/QJbFtHt8ZepXQU1Y5IqTSW0k6KuOXrTrgCwC85+OX376Ft9yDoLbbU
         Oi3QlJ29fiA7LvzKpNe7JXjPJcn1WR2KxqxHeUqQHV2gpPtY0+SVIsmrkRMFb4uAQm
         CfkbXOzq/xgrHrHZ7iFEj2GDQEX0guMhNFi5SGgSqcP2SOd5GmcgKfoONrhYpgyI0V
         6+IkFvA5IHTUvQcZmSiMxkk7+jEMpgYJGMBdftfjUkgUkRJUWUbFAdQ5/CQaxJaTGA
         +H3vLvAyvYB0aWZLLADEgt+ddMfF1z8vm9U5olkq2/1ve50E4IYdx9FZRzbf7goxi/
         hIM0rg3XtU9RA==
Date:   Tue, 12 Sep 2023 21:28:33 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     tglx@linutronix.de, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        =?utf-8?B?QW5kcsOvwr/CvQ==?= Almeida <andrealmeid@igalia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] futex: Use a folio instead of a page
Message-ID: <nkjcgasa4nq2zh6y2iim5r6qrhn2opwldaok5smf65kmfqu2un@zvazsmqrhjiu>
References: <20230821142207.2537124-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230821142207.2537124-1-willy@infradead.org>
User-Agent: NeoMutt/20230517
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc tglx.

On Mon, 21 Aug 2023, Matthew Wilcox (Oracle) wrote:

>The futex code already handles compound pages correctly, but using a
>folio lets us tell the compiler that we already have the head page and
>it doesn't need to call compound_head() again.
>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

>Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>---
> kernel/futex/core.c | 67 ++++++++++++++++++++++-----------------------
> 1 file changed, 33 insertions(+), 34 deletions(-)
>
>diff --git a/kernel/futex/core.c b/kernel/futex/core.c
>index f10587d1d481..d1d7b3c175a4 100644
>--- a/kernel/futex/core.c
>+++ b/kernel/futex/core.c
>@@ -222,7 +222,8 @@ int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *key,
> {
>	unsigned long address = (unsigned long)uaddr;
>	struct mm_struct *mm = current->mm;
>-	struct page *page, *tail;
>+	struct page *page;
>+	struct folio *folio;
>	struct address_space *mapping;
>	int err, ro = 0;
>
>@@ -273,54 +274,52 @@ int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *key,
>		err = 0;
>
>	/*
>-	 * The treatment of mapping from this point on is critical. The page
>-	 * lock protects many things but in this context the page lock
>+	 * The treatment of mapping from this point on is critical. The folio
>+	 * lock protects many things but in this context the folio lock
>	 * stabilizes mapping, prevents inode freeing in the shared
>	 * file-backed region case and guards against movement to swap cache.
>	 *
>-	 * Strictly speaking the page lock is not needed in all cases being
>-	 * considered here and page lock forces unnecessarily serialization
>+	 * Strictly speaking the folio lock is not needed in all cases being
>+	 * considered here and folio lock forces unnecessarily serialization.
>	 * From this point on, mapping will be re-verified if necessary and
>-	 * page lock will be acquired only if it is unavoidable
>+	 * folio lock will be acquired only if it is unavoidable
>	 *
>-	 * Mapping checks require the head page for any compound page so the
>-	 * head page and mapping is looked up now. For anonymous pages, it
>-	 * does not matter if the page splits in the future as the key is
>-	 * based on the address. For filesystem-backed pages, the tail is
>-	 * required as the index of the page determines the key. For
>-	 * base pages, there is no tail page and tail == page.
>+	 * Mapping checks require the folio so it is looked up now. For
>+	 * anonymous pages, it does not matter if the folio is split
>+	 * in the future as the key is based on the address. For
>+	 * filesystem-backed pages, the precise page is required as the
>+	 * index of the page determines the key.
>	 */
>-	tail = page;
>-	page = compound_head(page);
>-	mapping = READ_ONCE(page->mapping);
>+	folio = page_folio(page);
>+	mapping = READ_ONCE(folio->mapping);
>
>	/*
>-	 * If page->mapping is NULL, then it cannot be a PageAnon
>+	 * If folio->mapping is NULL, then it cannot be an anonymous
>	 * page; but it might be the ZERO_PAGE or in the gate area or
>	 * in a special mapping (all cases which we are happy to fail);
>	 * or it may have been a good file page when get_user_pages_fast
>	 * found it, but truncated or holepunched or subjected to
>-	 * invalidate_complete_page2 before we got the page lock (also
>+	 * invalidate_complete_page2 before we got the folio lock (also
>	 * cases which we are happy to fail).  And we hold a reference,
>	 * so refcount care in invalidate_inode_page's remove_mapping
>	 * prevents drop_caches from setting mapping to NULL beneath us.
>	 *
>	 * The case we do have to guard against is when memory pressure made
>	 * shmem_writepage move it from filecache to swapcache beneath us:
>-	 * an unlikely race, but we do need to retry for page->mapping.
>+	 * an unlikely race, but we do need to retry for folio->mapping.
>	 */
>	if (unlikely(!mapping)) {
>		int shmem_swizzled;
>
>		/*
>-		 * Page lock is required to identify which special case above
>-		 * applies. If this is really a shmem page then the page lock
>+		 * Folio lock is required to identify which special case above
>+		 * applies. If this is really a shmem page then the folio lock
>		 * will prevent unexpected transitions.
>		 */
>-		lock_page(page);
>-		shmem_swizzled = PageSwapCache(page) || page->mapping;
>-		unlock_page(page);
>-		put_page(page);
>+		folio_lock(folio);
>+		shmem_swizzled = folio_test_swapcache(folio) || folio->mapping;
>+		folio_unlock(folio);
>+		folio_put(folio);
>
>		if (shmem_swizzled)
>			goto again;
>@@ -331,14 +330,14 @@ int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *key,
>	/*
>	 * Private mappings are handled in a simple way.
>	 *
>-	 * If the futex key is stored on an anonymous page, then the associated
>+	 * If the futex key is stored in anonymous memory, then the associated
>	 * object is the mm which is implicitly pinned by the calling process.
>	 *
>	 * NOTE: When userspace waits on a MAP_SHARED mapping, even if
>	 * it's a read-only handle, it's expected that futexes attach to
>	 * the object not the particular process.
>	 */
>-	if (PageAnon(page)) {
>+	if (folio_test_anon(folio)) {
>		/*
>		 * A RO anonymous page will never change and thus doesn't make
>		 * sense for futex operations.
>@@ -357,10 +356,10 @@ int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *key,
>
>		/*
>		 * The associated futex object in this case is the inode and
>-		 * the page->mapping must be traversed. Ordinarily this should
>-		 * be stabilised under page lock but it's not strictly
>+		 * the folio->mapping must be traversed. Ordinarily this should
>+		 * be stabilised under folio lock but it's not strictly
>		 * necessary in this case as we just want to pin the inode, not
>-		 * update the radix tree or anything like that.
>+		 * update i_pages or anything like that.
>		 *
>		 * The RCU read lock is taken as the inode is finally freed
>		 * under RCU. If the mapping still matches expectations then the
>@@ -368,9 +367,9 @@ int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *key,
>		 */
>		rcu_read_lock();
>
>-		if (READ_ONCE(page->mapping) != mapping) {
>+		if (READ_ONCE(folio->mapping) != mapping) {
>			rcu_read_unlock();
>-			put_page(page);
>+			folio_put(folio);
>
>			goto again;
>		}
>@@ -378,19 +377,19 @@ int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *key,
>		inode = READ_ONCE(mapping->host);
>		if (!inode) {
>			rcu_read_unlock();
>-			put_page(page);
>+			folio_put(folio);
>
>			goto again;
>		}
>
>		key->both.offset |= FUT_OFF_INODE; /* inode-based key */
>		key->shared.i_seq = get_inode_sequence_number(inode);
>-		key->shared.pgoff = page_to_pgoff(tail);
>+		key->shared.pgoff = folio->index + folio_page_idx(folio, page);
>		rcu_read_unlock();
>	}
>
> out:
>-	put_page(page);
>+	folio_put(folio);
>	return err;
> }
>
>--
>2.40.1
>
