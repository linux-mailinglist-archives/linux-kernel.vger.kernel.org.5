Return-Path: <linux-kernel+bounces-31365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1467B832D42
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1753284E71
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712454EB5B;
	Fri, 19 Jan 2024 16:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lt4lcHZr"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348711EA91;
	Fri, 19 Jan 2024 16:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705682081; cv=none; b=kJXRDQ6RlD6PT7GnoOMJ5vE+0A/0stZ7Cr7SuWExF62fz06268IafRn1XR8/wGzHW8qoaxvBG/9f8QYMJj5JDrgQsD8b6XijC/kPm7zzoYFKzUOkOQtoOZlzQSlQLXDpn4WKD3sQjJ4yT/YlBjZxawJHGmY0Q1B3JW/eXiqJwJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705682081; c=relaxed/simple;
	bh=p0uhRomXP747eD0lrfKRHR3XfogCxogKEHI4Bqv1SBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=etOb/KfTR0rja30nw4f32M88Yf00fyjHUDn0Hyg1JJyotkyTALlXq4RtTC3VWqqxhlx/P0nHcQGMJ3xi2RD/uCJbDCvkFY3QNvIIIy8x/4pBHipVN9auso9pWvMlBVX30lmWGJQ6hDOgJS8/Wqs6dKxxRHGSZ8z3ySQYcxM8E+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Lt4lcHZr; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=E2DXX9J+b94QW5GPGfNYquiYbNTYKAfgE95rMIVDquM=; b=Lt4lcHZrYrOo7GYWIA1f9BGqCq
	7NYGF5wH98DEKKDKQKZWHUSYoI7ImlG7QnlD19/ZjAK4USUFrk4NSHh1HlsluWddhKf0nxncPbviU
	+aAODSWWqGuB5uQQ5Fr//F0n7rYLw7N3BuPUFGuE6SDesO3UrZy9L6gpRs2ZiuVpQJOvFMuY3kb/w
	gTXYUJbH0hRF9+77TR8xgpdwc31BS2pREfY0F/plEtounuD+le+DWJqyL9wrpN96ZYnNpQzAwHyXd
	YRee8sBHBZTYughIQpPk4Sa4ex4ydhYRorXVOdVW+OyoSjnXKBXijUE3Q0eYuyLU4Bu679fb/ubkq
	hsU4mWow==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rQrpG-00000005hDX-090S;
	Fri, 19 Jan 2024 16:34:38 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	stable@vger.kernel.org
Subject: [PATCH] block: Remove unnecessary unlikely()
Date: Fri, 19 Jan 2024 16:34:00 +0000
Message-ID: <20240119163434.1357155-1-willy@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jens added unlikely() thinking that this was an error path.  It's
actually just the end of the iteration, so does not warrant an
unlikely().

Fixes: 7bed6f3d08b7 ("block: Fix iterating over an empty bio with bio_for_each_folio_all")
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/bio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 875d792bffff..1518f1201ddd 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -286,7 +286,7 @@ static inline void bio_first_folio(struct folio_iter *fi, struct bio *bio,
 {
 	struct bio_vec *bvec = bio_first_bvec_all(bio) + i;
 
-	if (unlikely(i >= bio->bi_vcnt)) {
+	if (i >= bio->bi_vcnt) {
 		fi->folio = NULL;
 		return;
 	}
-- 
2.43.0


