Return-Path: <linux-kernel+bounces-137537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A58389E398
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BA7A1C20FB8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7927315885C;
	Tue,  9 Apr 2024 19:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O3RC6mn0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6136015884F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 19:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712690840; cv=none; b=grFwVR8QMMX5yhZd8FgUrik+oZb8KUisomXJDqO44Ep4PZmOjwTULpoaW7RowKvTGqxs46EqJyWct07GGIUr/Bjit5o1+TLY8r6pbyB35WsqksNiNGhxCNTd+AJJr4K8K3Bv72taLVtEw6rDsNUZ6vc9QetusABavwPslWZJC/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712690840; c=relaxed/simple;
	bh=zq0eZo/dQN8kHyMpocUFZ1dZ9OgFSNipiTHPXkCAd8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OdPKDpIZV4cnalJkav7R4mFW+PNPwRGMtJofnIiviKPq1hT5WcVwbCqiARvdr5ZzX3Z1F6trWGy3NjHbqEXrIhyHd/idhM9jDv4pEfXynV+BvWJKsF8lGmXGoBNJfFlu3auOfFMIIsDSlsxCjJ3DDlLrW3HT1NgQUflso+/5+AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O3RC6mn0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712690838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IIAPKUbl/14adNwXxGFYrjBvnjcRb79R1asl7bmu1AM=;
	b=O3RC6mn0zF/zKX+TIZMbGBaNfZhjwTw34pTMb6uz2pCPSSbgsBx5vZCXXwEEspmayYfNuv
	tFpRfm3dfoac9UO1Q//oI9RdiTxSpAeQlLTpUm1PLrpij7YUU8DeVSosrlq7ow1OBVKqv5
	W+7lmSDL3bd44Yj44uXm/fRLxy58a9w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-cPzfINHFMa2e8lR0ggInCw-1; Tue, 09 Apr 2024 15:27:12 -0400
X-MC-Unique: cPzfINHFMa2e8lR0ggInCw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A5CC830E7B;
	Tue,  9 Apr 2024 19:27:11 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.106])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B9D8740B4980;
	Tue,  9 Apr 2024 19:26:52 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Peter Xu <peterx@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Yin Fengwei <fengwei.yin@intel.com>,
	Yang Shi <shy828301@gmail.com>,
	Zi Yan <ziy@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Hugh Dickins <hughd@google.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Muchun Song <muchun.song@linux.dev>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <naoya.horiguchi@nec.com>,
	Richard Chang <richardycc@google.com>
Subject: [PATCH v1 18/18] Documentation/admin-guide/cgroup-v1/memory.rst: don't reference page_mapcount()
Date: Tue,  9 Apr 2024 21:23:01 +0200
Message-ID: <20240409192301.907377-19-david@redhat.com>
In-Reply-To: <20240409192301.907377-1-david@redhat.com>
References: <20240409192301.907377-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Let's stop talking about page_mapcount().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 Documentation/admin-guide/cgroup-v1/memory.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index 46110e6a31bb..9cde26d33843 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -802,8 +802,8 @@ a page or a swap can be moved only when it is charged to the task's current
 |   | anonymous pages, file pages (and swaps) in the range mmapped by the task |
 |   | will be moved even if the task hasn't done page fault, i.e. they might   |
 |   | not be the task's "RSS", but other task's "RSS" that maps the same file. |
-|   | And mapcount of the page is ignored (the page can be moved even if       |
-|   | page_mapcount(page) > 1). You must enable Swap Extension (see 2.4) to    |
+|   | The mapcount of the page is ignored (the page can be moved independent   |
+|   | of the mapcount). You must enable Swap Extension (see 2.4) to            |
 |   | enable move of swap charges.                                             |
 +---+--------------------------------------------------------------------------+
 
-- 
2.44.0


