Return-Path: <linux-kernel+bounces-2103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DB08157E0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 06:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 220141C24A19
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 05:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C439515487;
	Sat, 16 Dec 2023 05:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PftWoVll"
X-Original-To: linux-kernel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FAD14A83;
	Sat, 16 Dec 2023 05:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DRzD28PnFYkXAjvTslH+uCrYblRpF/G5LiUv3oBCMWs=; b=PftWoVllvpIbDKadTZVhY2eDGq
	w79/fVfbaA5r3Jr9tL5NZVbgypqSjw5GFHuVwMuV/4rdTtFDYEIX8sRMFXpRXJ6b3XooC9ZoSXAev
	YuzSPwdbp39dK41y74oo1qJUPxYjsRI71Xnl9sPAYVpa1vaoEeva2qqOhH0OtJVHu8VE+/pI6pZyb
	RUEd5Id2I3+b3WZXWWAJiWZr3BzUjX0Ai6hC6OgrDoUrxZOtniZggBl7/zc3XBwPcopm/XbKNGDJS
	Hd2JHQTRWbIdoHNIqn5/+4exygwxiRUtsebf2Lmt7syk7+gh6BvKD8Dn/Mq8+ouN1BEzL/kgXVI8+
	GUrTd+nw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rENbu-007RNq-3X; Sat, 16 Dec 2023 05:53:14 +0000
Date: Sat, 16 Dec 2023 05:53:14 +0000
From: Matthew Wilcox <willy@infradead.org>
To: syzbot <syzbot+8b23309d5788a79d3eea@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] general protection fault in bio_first_folio
Message-ID: <ZX07SsSqIQ2TYwEi@casper.infradead.org>
References: <0000000000006c14cd060c99ac12@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000006c14cd060c99ac12@google.com>

On Fri, Dec 15, 2023 at 09:20:22PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:

Good bot.

> commit 1b151e2435fc3a9b10c8946c6aebe9f3e1938c55
> Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> Date:   Mon Aug 14 14:41:00 2023 +0000
> 
>     block: Remove special-casing of compound pages
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=152f8a8ee80000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=172f8a8ee80000
> console output: https://syzkaller.appspot.com/x/log.txt?x=132f8a8ee80000
> 
> general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]

I _think_ what's happened here is that __bio_release_pages() was called
with a zero-length bio.

> CPU: 0 PID: 5059 Comm: syz-executor696 Not tainted 6.7.0-rc5-next-20231212-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
> RIP: 0010:_compound_head include/linux/page-flags.h:247 [inline]
> RIP: 0010:bio_first_folio+0xcb/0x5c0 include/linux/bio.h:289

... bio_first_folio() doesn't handle it well, whereas
bio_for_each_segment_all() did.

> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next abb240f7a2bd

diff --git a/include/linux/bio.h b/include/linux/bio.h
index ec4db73e5f4e..1518f1201ddd 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -286,6 +286,11 @@ static inline void bio_first_folio(struct folio_iter *fi, struct bio *bio,
 {
 	struct bio_vec *bvec = bio_first_bvec_all(bio) + i;
 
+	if (i >= bio->bi_vcnt) {
+		fi->folio = NULL;
+		return;
+	}
+
 	fi->folio = page_folio(bvec->bv_page);
 	fi->offset = bvec->bv_offset +
 			PAGE_SIZE * (bvec->bv_page - &fi->folio->page);
@@ -303,10 +308,8 @@ static inline void bio_next_folio(struct folio_iter *fi, struct bio *bio)
 		fi->offset = 0;
 		fi->length = min(folio_size(fi->folio), fi->_seg_count);
 		fi->_next = folio_next(fi->folio);
-	} else if (fi->_i + 1 < bio->bi_vcnt) {
-		bio_first_folio(fi, bio, fi->_i + 1);
 	} else {
-		fi->folio = NULL;
+		bio_first_folio(fi, bio, fi->_i + 1);
 	}
 }
 

