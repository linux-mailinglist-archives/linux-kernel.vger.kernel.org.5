Return-Path: <linux-kernel+bounces-107337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9F087FB35
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C3791F22715
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFE5548F9;
	Tue, 19 Mar 2024 09:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHqJJWvg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FF57EF0D;
	Tue, 19 Mar 2024 09:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710842017; cv=none; b=rchGV3iWOt1M3L/GhH8dbdk+XBoLU2+pbuw0vdaL+2aPi9OBHY59Sv9mLlc1V3hPUtNBe7R+8vA6+CW9U+RVFw2sU6Lw64f+21SbVxcO+HXJ1w2ku25+rvQaxlPknla6zd3U+0xxFOWZ7BQMjrWxPLrCZMuBXhpoC/RBL6ZzOOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710842017; c=relaxed/simple;
	bh=eLFz8uhtcnkr+mmr2mJCW7abChfFurz5pgm0LRWZQB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zo8rikIAeGC6T2KThSFk/wlM30I6ypydKAOx/XNMyvKaGvITRxoL0mmOUu6IxfsLy8Y6wehNEpJ6etd8h81Whg94l1N+flJmA30StzpgN45ado/KcA1zyBxVaCv19XK7hv8l3ZRGO0hzUa1Qzrvqlgw2E65PN4LG9CGlAYEs8uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHqJJWvg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E2BC43390;
	Tue, 19 Mar 2024 09:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710842017;
	bh=eLFz8uhtcnkr+mmr2mJCW7abChfFurz5pgm0LRWZQB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NHqJJWvgG/Ta6pLiACZEFm17+bQhvOQdA7Nbh87/2cIGfLxrHJF/0MLxyFm8Z8MY/
	 2zZqmJV1n5CLU0R9b38C1aRrQaUNrBQtdTT8wwi7Kv+OvwIY0E3JSGsR/iSP+Qu6f3
	 poQjo72mqGCmCRWWUUxJGKFO6neiiQj/VAa0nss1ZpusTi0zsNjTRs5LIpPDiJHtOn
	 8iPnf9cT6VOxiBTypwaqKeCXMPrmJye1TZOmCPfiMZiG3K1IONjpnzGudq6IhdazX0
	 xUaBRIs9G5av4WsL9gpibAs+bYzDndZmeRrcNXj1CNjv8714aMH7KuW/WAMZpW4C3P
	 Gtb/P4t6pocJw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Stefani Seibold <stefani@seibold.net>
Subject: [RFT 04/15] kfifo: remove support for physically non-contiguous memory
Date: Tue, 19 Mar 2024 10:53:04 +0100
Message-ID: <20240319095315.27624-6-jirislaby@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240319095315.27624-1-jirislaby@kernel.org>
References: <20240319095315.27624-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First, there is no such user. The only user of this interface is
caam_rng_fill_async() and that uses kfifo_alloc() -> kmalloc().

Second, the implementation does not allow anything else than direct
mapping and kmalloc() (due to virt_to_phys()), anyway.

Therefore, there is no point in having this dead (and complex) code in
the kernel.

Note the setup_sgl_buf() function now boils down to simple sg_set_buf().
That is called twice from setup_sgl() to take care of kfifo buffer
wrap-around.

setup_sgl_buf() will be extended shortly, so keeping it in place.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Stefani Seibold <stefani@seibold.net>
---
 lib/kfifo.c | 38 +++++---------------------------------
 1 file changed, 5 insertions(+), 33 deletions(-)

diff --git a/lib/kfifo.c b/lib/kfifo.c
index a36bfdbdb17d..d5830960ab87 100644
--- a/lib/kfifo.c
+++ b/lib/kfifo.c
@@ -305,43 +305,15 @@ int __kfifo_to_user(struct __kfifo *fifo, void __user *to,
 }
 EXPORT_SYMBOL(__kfifo_to_user);
 
-static int setup_sgl_buf(struct scatterlist *sgl, void *buf,
-		int nents, unsigned int len)
+static unsigned int setup_sgl_buf(struct scatterlist *sgl, void *buf,
+				  int nents, unsigned int len)
 {
-	int n;
-	unsigned int l;
-	unsigned int off;
-	struct page *page;
-
-	if (!nents)
+	if (!nents || !len)
 		return 0;
 
-	if (!len)
-		return 0;
+	sg_set_buf(sgl, buf, len);
 
-	n = 0;
-	page = virt_to_page(buf);
-	off = offset_in_page(buf);
-	l = 0;
-
-	while (len >= l + PAGE_SIZE - off) {
-		struct page *npage;
-
-		l += PAGE_SIZE;
-		buf += PAGE_SIZE;
-		npage = virt_to_page(buf);
-		if (page_to_phys(page) != page_to_phys(npage) - l) {
-			sg_set_page(sgl, page, l - off, off);
-			sgl = sg_next(sgl);
-			if (++n == nents || sgl == NULL)
-				return n;
-			page = npage;
-			len -= l - off;
-			l = off = 0;
-		}
-	}
-	sg_set_page(sgl, page, len, off);
-	return n + 1;
+	return 1;
 }
 
 static unsigned int setup_sgl(struct __kfifo *fifo, struct scatterlist *sgl,
-- 
2.44.0


