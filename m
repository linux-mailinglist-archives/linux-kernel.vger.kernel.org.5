Return-Path: <linux-kernel+bounces-36730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9166483A5AD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEBF41C2785B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC9E18038;
	Wed, 24 Jan 2024 09:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J6FchOiY"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B378818021;
	Wed, 24 Jan 2024 09:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706089189; cv=none; b=DpXzgEg20Xaq23W9IU3tt+URP8EUqCpNUUoHpBX3LZshAvRFKpR/QJyN+j2pYh+fTwML/zQiSMS88Rsn8x0Z76H+9cR7f6fzc2CVyTE8WMYHHCJp0fMjZqwTAI5dW63UBshDdhNVbh59r1EC5MDZj7Q0Hw4gOdjT9ekfpW4aCu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706089189; c=relaxed/simple;
	bh=csxSFjKQHyJjxXdzXVfeqcnrqnGQMSacuTyh3j8G7gk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fi7Zlx/Y301vX1Xa9HEwrc+0FaG+j6vquwa+0hj+X7wDhvtO3mJAjvhVLMDplAqKPcF0AWvb69qMYYbdpMknd/VaPGdSfVqwBwFJjTzoqqiOhuKkFe2fW48A9uO8YZFE1pnOKetRK8kaAPjbln8DtXFeyKNFJhfFhfJRkmkcJn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=J6FchOiY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=iJqhfHE63yLibvofZGhJTgUGPFr97HkcGRUKyFZYBvw=; b=J6FchOiYBzu7hZPX+AZnNaaF3u
	TIfzf4T6K6vwvP1XXMXrAaxhkY48buvnSxR8ax0XKp7xcmlOwmEZbbJDMs4pTGBASt9lXaN/NOedj
	6ih9qjAbrL6tgO6mbWBsujjvZUfhX/g6pWcBswfXyhfsIEpr55MpizgfVaeOdVRWBam4ibuhs5KlM
	GtWlYulU0k2QwY6P0GNmspXsTZeSJdSkXg+dZ6R1G46ED1oLkbOvhRNYJ+e097XxndJtIw4Hl2LDr
	+pFzsI3q3szln9220i8Zy22fNqE2v6MCDKXCZk0Ogl6prYxJsPslH9QKhv0+nEz5RxATI7VDArcm7
	cGGngGYA==;
Received: from [2001:4bb8:188:3f09:9c13:25f:1e5b:57f9] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rSZjW-002I8t-0r;
	Wed, 24 Jan 2024 09:39:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	tj@kernel.org,
	jiangshanlai@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH, RFC] block: set noio context in submit_bio_noacct_nocheck
Date: Wed, 24 Jan 2024 10:39:41 +0100
Message-Id: <20240124093941.2259199-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Make sure all in-line block layer submission runs in noio reclaim
context.  This is a big step towards allowing GFP_NOIO, the other
one would be to have noio (and nofs for that matter) workqueues for
kblockd and driver internal workqueues.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 11342af420d0c4..b85ef8a0fdf6a0 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -691,6 +691,8 @@ static void __submit_bio_noacct_mq(struct bio *bio)
 
 void submit_bio_noacct_nocheck(struct bio *bio)
 {
+	unsigned int noio_flag = memalloc_noio_save();
+
 	blk_cgroup_bio_start(bio);
 	blkcg_bio_issue_init(bio);
 
@@ -715,6 +717,8 @@ void submit_bio_noacct_nocheck(struct bio *bio)
 		__submit_bio_noacct_mq(bio);
 	else
 		__submit_bio_noacct(bio);
+
+	memalloc_noio_restore(noio_flag);
 }
 
 /**
-- 
2.39.2


