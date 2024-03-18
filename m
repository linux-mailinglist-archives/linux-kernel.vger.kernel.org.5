Return-Path: <linux-kernel+bounces-106209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF8F87EACA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C79B1C21087
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F7D4E1CF;
	Mon, 18 Mar 2024 14:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K04WwRbW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6014CDEB
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710771714; cv=none; b=MFmLkE3yi6CoH5o+VIc/GHmfM8x/LYCOM+68Ib0Bw31VMgy1+WP6xx41Mjey2wEoVW7gxxE32xh6rIBSm4wbpcTN9Yw0/3IqW6hIvfdeVzRoWUUL+6DzGVexorHpeaB6j1LjET8vMtFt1vgl2J8xECqqo4NnF10S2rWJRpSnxEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710771714; c=relaxed/simple;
	bh=fbmmrMFnYH8ln09BbkU1anr7KedTZF03Qizagwy4S3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=DSCJQrLZtfGQUS0GGeGVypGaxtGQfeeicfJx5tR6RUAkosykyj/tzsvtmF9Q+4krP3XjbzJHKZ8pBL85694eld/sLcrYhhOiYJ1LL91KqBOMOvxc94+SwW9QUht5D5/6cZOVEJ+eh8CDRRCAnFt0DBB6F54P7lU6Hnn0Bx4YXwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K04WwRbW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710771711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=F5ye388VWoErT8xKd/JXdRVRXGFtTvAxoGWVnY3cKSY=;
	b=K04WwRbWPa/jwg4p6XHqAx7xMTDQz4CQp5LBDpWKm43uiYvfZM7GYqSswwgLYuXtEGXa8K
	SSdVpnIR9k9P3V0et/yA42t8PO9jo49ZJuzeT+eXhTe4Xs/3KatK6VLRH/yHtKNKF0fsk1
	JhA1R1yPz6uaZCw5trF/cjCYSzx9Zvw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-wJFmYP1ANHGgSGjgt3Fcnw-1; Mon,
 18 Mar 2024 10:21:49 -0400
X-MC-Unique: wJFmYP1ANHGgSGjgt3Fcnw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 02C8F3C0F180;
	Mon, 18 Mar 2024 14:21:49 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C88FE492BD0;
	Mon, 18 Mar 2024 14:21:45 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH 0/6] mm/mm_init.c: refactor free_area_init_core()
Date: Mon, 18 Mar 2024 22:21:32 +0800
Message-ID: <20240318142138.783350-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

In function free_area_init_core(), the code calculating
zone->managed_pages and the subtracting dma_reserve from DMA zone looks
very confusing.

From git history, the code calculating zone->managed_pages was for
zone->present_pages originally. The early rough assignment is for
optimize zone's pcp and water mark setting. Later, managed_pages was
introduced into zone to represent the number of managed pages by buddy.
Now, zone->managed_pages is zeroed out and reset in mem_init() when
calling memblock_free_all(). zone's pcp and wmark setting relying on
actual zone->managed_pages are done later than mem_init() invocation.
So we don't need rush to early calculate and set zone->managed_pages,
just set it as zone->present_pages, will adjust it in mem_init().

And also add a new function calc_nr_kernel_pages() to count up free but
not reserved pages in memblock, then assign it to nr_all_pages and
nr_kernel_pages after memmap pages are allocated.


Baoquan He (6):
  mm/mm_init.c: remove the useless dma_reserve
  x86: remove unneeded memblock_find_dma_reserve()
  mm/mm_init.c: add new function calc_nr_all_pages()
  mm/mm_init.c: remove meaningless calculation of zone->managed_pages in
    free_area_init_core()
  mm/mm_init.c: remove unneeded calc_memmap_size()
  mm/mm_init.c: remove arch_reserved_kernel_pages()

 arch/powerpc/include/asm/mmu.h |   4 --
 arch/powerpc/kernel/fadump.c   |   5 --
 arch/x86/include/asm/pgtable.h |   1 -
 arch/x86/kernel/setup.c        |   2 -
 arch/x86/mm/init.c             |  47 -------------
 include/linux/mm.h             |   4 --
 mm/mm_init.c                   | 117 +++++++++------------------------
 7 files changed, 30 insertions(+), 150 deletions(-)

-- 
2.41.0


