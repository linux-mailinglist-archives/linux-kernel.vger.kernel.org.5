Return-Path: <linux-kernel+bounces-81594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D99228677F3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0C2D1C21F82
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C70129A6D;
	Mon, 26 Feb 2024 14:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N6JZhZHD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6F412AADD
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 14:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708956815; cv=none; b=FOXZ36dJAKgqmKbiOGe43vCRtghjtRc9EzHPGeBiINDBPpQPp78EytMDnlveRfnEXCrzYhEOWbMh5WKEiFyi+rwThlYR4kUbMs9Jicjf/CLVfSvz6ZbYXP7PUeU9hny82BHTbxG7eNC6blPpbzce1g4rkwOTR5RPlSM0C2Vww+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708956815; c=relaxed/simple;
	bh=UVAE9RqLRkDyhfixRtMTUcQy8PG3f5qZCw1Da0i/Ms4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=se02KcKYHEExry8wSULInnETznDQzzPKEpcMDPdWG/eqUT1X3obg9D+bTKCoINXJBIwBMT8gMoE7CdCWkUZzB3NDXRe0KkzWMx/y7PIk8vZBEqAv0DI+Ljwl8bAwBV/LIAZlX7ETrpLpg2ZCzChVAmfVpL3P3ClVSRxo8Uv7hpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N6JZhZHD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708956811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9l7/KyH7FSkqjGNyaxNZdzpo1PhHKtJHQ16wAurIa8s=;
	b=N6JZhZHDYELhU5MIHVpdfYxFhXqIg2f3QoAWi7Dd1NBUrZc5KJcal9kzllWXqohj4WWX7e
	49yCnqOhVamm7+XzBcgWYjq5Vy+cu4jbJkDRyBIZR/kL2b4uNPRvHl8sQx5W9S+2OmuDmA
	Djx3XI/SmOqqH3TDp9KFPp6OKXuoAA8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-r3rwLlA3P2ii8TZDvNd-Yw-1; Mon, 26 Feb 2024 09:13:28 -0500
X-MC-Unique: r3rwLlA3P2ii8TZDvNd-Yw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A5F1910B7AB1;
	Mon, 26 Feb 2024 14:13:27 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.224])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6F9041C06714;
	Mon, 26 Feb 2024 14:13:25 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 0/2] mm: remove total_mapcount()
Date: Mon, 26 Feb 2024 15:13:22 +0100
Message-ID: <20240226141324.278526-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Let's remove the remaining user from mm/memfd.c so we can get rid of
total_mapcount().

v1 -> v2:
* Adjust mm/memfd.c separately, and as suggested by Willy, clean it up
  properly.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>

David Hildenbrand (2):
  mm/memfd: refactor memfd_tag_pins() and memfd_wait_for_pins()
  mm: remove total_mapcount()

 include/linux/mm.h |  9 +--------
 mm/memfd.c         | 47 ++++++++++++++++++----------------------------
 2 files changed, 19 insertions(+), 37 deletions(-)

-- 
2.43.2


