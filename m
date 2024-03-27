Return-Path: <linux-kernel+bounces-120299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A85288D583
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F285EB21D0C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300CB1FA1;
	Wed, 27 Mar 2024 04:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qlCVrBxl"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D726936B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 04:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711514814; cv=none; b=Kxw0D3OcUs+i1W+14GKKmdDFsubzk8vnekRaSBdiYeriLeExlDc932urUv4kjK5AhUFTzzFqDgjU4kaljYo0+vcuOJkQyI/loaYxGrzsxzzfl3u53xxuQL5z8TimQb3X33fuSTTbKug9RYsxD4Puhlc1wiCKJY+fNfCufq61e8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711514814; c=relaxed/simple;
	bh=fe5JVNVJ26q344L0rybfdlbQv6wcoQuYXBEVYTlnn1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QbAxzVYx+syOWs64Rob03PM8TbXQVhFtLqa/mh+wODpsnCx/6w8DWkvaVdTuiBzQLx5pwxYZhjaNWv+tZjtxkfF1I6Rzz69//mudWWkYvWOhHFc48OHnMUFsR9eDumGeMpX0hJyfiKnm4duqI+fen1NJzHpOKYZtxjbenGvCm1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qlCVrBxl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=yMtOAxSy6zJWmW6mKZyujtiV9qAtMlkG5asbEMkPM8M=; b=qlCVrBxleP59TvWq1qxNfR4OWp
	1AvF8+Z1C2um2UozsID95ACtjZRxZneIti+7+LQe5oswU0fbFaW39pna2P7xaMs/wrf/ycIWrNuE7
	fNeU4f7G/vQntnDDQeINaCYmwcdWcrByabCc8iLu40ZwymgOhzSHQZv53SMstSTi7oJReYR/WPIdc
	OHdfixb7CMdbg8Yh51ntHoQIqstBBykR3jAvi+hvK2pIkrk4As8gd9J/1pf4dWJv6anB/OpluRS1u
	FPR1rEixlTGU+YLR0fkU+4UHuIEzLPTE5Da8SOcX1RTeObkw1ltDa5Z+nN4aNqj26wiqBEyubIXg/
	UgEYGgiw==;
Received: from [50.53.2.121] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpLBa-00000007Rar-263h;
	Wed, 27 Mar 2024 04:46:50 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org
Subject: [PATCH] mm/slab: fix kcalloc() kernel-doc warnings
Date: Tue, 26 Mar 2024 21:46:49 -0700
Message-ID: <20240327044649.9199-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the parameter names for kcalloc() in slab.h to prevent kernel-doc
warnings:

include/linux/slab.h:730: warning: Function parameter or struct member '_n' not described in 'kcalloc'
include/linux/slab.h:730: warning: Function parameter or struct member '_size' not described in 'kcalloc'
include/linux/slab.h:730: warning: Function parameter or struct member '_flags' not described in 'kcalloc'
include/linux/slab.h:730: warning: Excess function parameter 'n' description in 'kcalloc'
include/linux/slab.h:730: warning: Excess function parameter 'size' description in 'kcalloc'
include/linux/slab.h:730: warning: Excess function parameter 'flags' description in 'kcalloc'

Fixes: bc7b83f5e4bf ("mm/slab: enable slab allocation tagging for kmalloc and friends")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Link: https://lore.kernel.org/linux-next/20240325123603.1bdd6588@canb.auug.org.au/
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
---
 include/linux/slab.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/include/linux/slab.h b/include/linux/slab.h
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -727,7 +727,7 @@ static inline __realloc_size(2, 3) void
  * @size: element size.
  * @flags: the type of memory to allocate (see kmalloc).
  */
-#define kcalloc(_n, _size, _flags)		kmalloc_array(_n, _size, (_flags) | __GFP_ZERO)
+#define kcalloc(n, size, flags)		kmalloc_array(n, size, (flags) | __GFP_ZERO)
 
 void *kmalloc_node_track_caller_noprof(size_t size, gfp_t flags, int node,
 				  unsigned long caller) __alloc_size(1);

