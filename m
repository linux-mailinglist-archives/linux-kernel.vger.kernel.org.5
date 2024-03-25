Return-Path: <linux-kernel+bounces-117310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE1988A9DE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA2432A3F8F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AF8157E79;
	Mon, 25 Mar 2024 14:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TO7mgnCp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FDA13249F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 14:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711378642; cv=none; b=IyC560TgGECE43vINK1ka6pKm+1DxmiYC77FtkpCZN5ic1OV20wFNw5n5fhA05G8iTl5Hdtkn6EHcVnKYM2D4C97dKptOcHGFJRUtM94brHaQOfpSb7zJckgZ0cjKaaipqJSrfWEsZzG+PF8QWFgKknkv5qQXQruXIZzc3q34G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711378642; c=relaxed/simple;
	bh=uYITEVm7lhnJTUWEPp778d1BV6/h4dw5f+lXXIA4nZo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=AzaIrHdlzhCl0Rjg3SdXzQJwA4qs7uqBIjCSRvjG1AGP2Iw628zE8p3zZQm1u6tKKgEWHHh209XtERuWmWbBhSPU/B50i77byzv21Fd4Cc3NGpZKPH+XGYLpDyD2z+99z7GChQ2QeSNwYrjRGESERJOPf6SHrigKF5cMt4fvJsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TO7mgnCp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711378639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DL/tRS+4pUx9m3XgAdE8DYrulXqMo6B5z0clIVzdqIA=;
	b=TO7mgnCpwpyswvvF2CjCm/OxYMACvGUy5UDMhJ3VuPz79hREonO9FSBglTxqjd9gDLC4dS
	VuxWQQPsH9muZN1wli0+GkzIA8jn1rGez6zmFW+BgkP9jnAWQYxEOBJFUYiVMulb2KP2tC
	FrR4PAcu0xFX9WzvFMJH431mL8frH3A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-8fUELVHUOWGLH-ZeoGwWYw-1; Mon, 25 Mar 2024 10:57:15 -0400
X-MC-Unique: 8fUELVHUOWGLH-ZeoGwWYw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8914E800264;
	Mon, 25 Mar 2024 14:57:15 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 15D883C20;
	Mon, 25 Mar 2024 14:57:10 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 0/6] mm/mm_init.c: refactor free_area_init_core()
Date: Mon, 25 Mar 2024 22:56:40 +0800
Message-ID: <20240325145646.1044760-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

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

Changelog:
----------
v1->v2:
=======
These are all suggested by Mike, thanks to him.
- Swap the order of patch 1 and 2 in v1 to describe code change better,
  Mike suggested this.
- Change to initializ zone->managed_pages as 0 in free_area_init_core()
  as there isn't any page added into buddy system. And also improve the
  ambiguous description in log. These are all in patch 4.

Baoquan He (6):
  x86: remove unneeded memblock_find_dma_reserve()
  mm/mm_init.c: remove the useless dma_reserve
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
 mm/mm_init.c                   | 125 ++++++++-------------------------
 7 files changed, 29 insertions(+), 159 deletions(-)

-- 
2.41.0


