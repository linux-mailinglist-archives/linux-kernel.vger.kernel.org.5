Return-Path: <linux-kernel+bounces-28299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C3082FCB1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 458151F2D1BB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FD65C8E0;
	Tue, 16 Jan 2024 21:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jSf9328k"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B230B2E653;
	Tue, 16 Jan 2024 21:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705440605; cv=none; b=Rs5U68eAR9Su9oiIJlgRjrqrz5Yu6Fmi4esyEIFQLSjQqlviPQSuZfD+E/2Smh6HHuwg0+9pEZ4h/yOSmpeVIY6vzC4ANqo7Ec3HYksn9Jrh6eXqClg0XaZ6b3Qh6g+Dpn+PuYl6vS77z7JNBI/2DCAlJRJ15Q080Ggd/HtiSmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705440605; c=relaxed/simple;
	bh=IAWk1YprB3PG7VN0yzjiLV8oZKHAOS9ZB6C24VAJCCQ=;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=jQ/qJZTL0/ubzkNgugGhwxpe7oxG8zDwD1xlq7dmr4I3XVL9LL6LnYzGyCbVtNRatHfC7vsqOQv2WoHt8SZixOxaOHqydYKztegxTcyDmazO8C9DtWMeBrMlSjNOM2G/hJ+Qln/gqD3qSeP1ugqa4iPmgAMgrJATSG120Y45dlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jSf9328k; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=HM/2mnrR5ku0dJRu3DvkRCaTPaWRj5EtYUk/YkITPe0=; b=jSf9328kIeMp0WquyPLyQD2UbG
	vdOiLmM3fVjvGvEIAGVSGmjkXI4q/ZzuI0kqep5Czy0xnrWg8fFBlWRV9bIzSn2IY/2ptCTijl0Ot
	8fj9Prv++oNv4PoY1BL6q853A/5/e6Ohua7ySUW+rEIlKGOvNsKMz+wPz9JLSFFNnrkCIHYwxxSBg
	cbGME98WXP1OA3X/qfenOm1/VYdcD1xvi6zSl/0fq9MR7GkqBKRrloOGG8lJQKo8+yIKwDvFONzYc
	vRcYh6evnSqdD2J+aKAD4gACbN8iXbT0foOZsnHhVcDKt7YHNQYkvwvFLPZLzYUJm39YMdivO8T3E
	sqHQQ0jQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rPr0S-00EJsm-W2; Tue, 16 Jan 2024 21:30:01 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+8b23309d5788a79d3eea@syzkaller.appspotmail.com,
	syzbot+004c1e0fced2b4bc3dcc@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] block: Fix iterating over an empty bio with bio_for_each_folio_all
Date: Tue, 16 Jan 2024 21:29:59 +0000
Message-Id: <20240116212959.3413014-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the bio contains no data, bio_first_folio() calls page_folio() on a
NULL pointer and oopses.  Move the test that we've reached the end of
the bio from bio_next_folio() to bio_first_folio().

Reported-by: syzbot+8b23309d5788a79d3eea@syzkaller.appspotmail.com
Reported-by: syzbot+004c1e0fced2b4bc3dcc@syzkaller.appspotmail.com
Fixes: 640d1930bef4 ("block: Add bio_for_each_folio_all()")
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/bio.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

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
 
-- 
2.43.0


