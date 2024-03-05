Return-Path: <linux-kernel+bounces-91665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3C48714D3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 05:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2DE81F22F6E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0778740BE7;
	Tue,  5 Mar 2024 04:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZIGO1yDC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5120929A2
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 04:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709613484; cv=none; b=ZcuhqwALNzNz5qHLR3wsuNig2PNqRuTf6KcTjdkNsVk5YGDSQvhZkp7VkYzKj6OM73C+8iYBIf/0WzY8T9WMRudNv+qAIP9F8WSu3gFxTm1jnoFQDPOt+lSrfPcQKRkt8a/m6Ksc4SFB+jCer8YN70Ayf+Xmf9ScBKh2xgePh+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709613484; c=relaxed/simple;
	bh=Jw9TD1F7N+FWimssBh6Rt0JyGd/kmDLyF8btMOYDg8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=H2B3dz32rlCcmKDyxD9Edf8RLu+SYbUrFdNXDfqA9rUz271T54BeSDlUf8uVZDWbnvjJtC04N4Yhm+aHC79yH0Quk7oxAH5T9xUMEOOct8CoPfwyg9GgYP5U7TcbVBqYnHXgnrvsvrUJ4rlbizu2egcUKpwc6SdNpgNZOSH0wdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZIGO1yDC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709613481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YPd4GFiSShJn+ZRqzxhUGsjklTy+tvdVZ7YEdaffubE=;
	b=ZIGO1yDCn5Zso0dF0+fl0FRd0ttZPg4FXH6h/YrKuPNeq00UjStUbMjCenwwRJV8tlrGb5
	lg1ZL5KNDBZp23Pq+QgxnvOFuI0nR6sYW4zHRoWNd/UW7yDcbZGGbdlkheAUD6eCh3PGTe
	Jz/cxRIJpGjkqgbIgeZGwo2C5GiiT3E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-ls-yFlXOMLKW33D-c7G0hg-1; Mon, 04 Mar 2024 23:37:59 -0500
X-MC-Unique: ls-yFlXOMLKW33D-c7G0hg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EDAC780F7EC;
	Tue,  5 Mar 2024 04:37:58 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.31])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1E712C1F086;
	Tue,  5 Mar 2024 04:37:52 +0000 (UTC)
From: peterx@redhat.com
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	x86@kernel.org,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Yang Shi <shy828301@gmail.com>,
	peterx@redhat.com,
	Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev@lists.ozlabs.org,
	Muchun Song <muchun.song@linux.dev>
Subject: [PATCH v3 00/10] mm/treewide: Replace pXd_large() with pXd_leaf()
Date: Tue,  5 Mar 2024 12:37:40 +0800
Message-ID: <20240305043750.93762-1-peterx@redhat.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

From: Peter Xu <peterx@redhat.com>

[based on latest akpm/mm-unstable, commit b38c34939fe4]

v3:
- Added three patches
  - mm/treewide: Align up pXd_leaf() retval across archs
    Per request from Jason to further cleanup the retvals
  - mm/kasan: Use pXd_leaf() in shadow_mapped()
    Something I spot when saw a pXd_large() comment block, put it as a
    separate patch to cleanup.
  - mm/x86: Replace pgd_large() with pgd_leaf()
    Overlooked we even have pgd_leaf() defined for x86, added one more
    patch for it.  Now I'm pretty sure p?d_large() all gone for good.
- Collected R-bs / A-bs

v2: https://lore.kernel.org/r/20240229084258.599774-1-peterx@redhat.com
v1: https://lore.kernel.org/r/20240228085350.520953-1-peterx@redhat.com

These two APIs are mostly always the same.  It's confusing to have both of
them.  Merge them into one.  Here I used pXd_leaf() only because pXd_leaf()
is a global API which is always defined, while pXd_large() is not.

We have yet one more API that is similar which is pXd_huge(), but that's
even trickier, so let's do it step by step.

Some special cares are taken for ppc and x86, they're done as separate
cleanups first.  Only lightly tested on x86.

Please have a look, thanks.

Peter Xu (10):
  mm/ppc: Define pXd_large() with pXd_leaf()
  mm/ppc: Replace pXd_is_leaf() with pXd_leaf()
  mm/x86: Replace p4d_large() with p4d_leaf()
  mm/x86: Replace pgd_large() with pgd_leaf()
  mm/x86: Drop two unnecessary pud_leaf() definitions
  mm/kasan: Use pXd_leaf() in shadow_mapped()
  mm/treewide: Replace pmd_large() with pmd_leaf()
  mm/treewide: Replace pud_large() with pud_leaf()
  mm/treewide: Drop pXd_large()
  mm/treewide: Align up pXd_leaf() retval across archs

 arch/arm/include/asm/pgtable-2level.h        |  1 -
 arch/arm/include/asm/pgtable-3level.h        |  1 -
 arch/arm/mm/dump.c                           |  4 +--
 arch/loongarch/kvm/mmu.c                     |  2 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h | 26 ++++--------------
 arch/powerpc/include/asm/pgtable.h           | 28 --------------------
 arch/powerpc/kvm/book3s_64_mmu_radix.c       | 12 ++++-----
 arch/powerpc/mm/book3s64/pgtable.c           |  4 +--
 arch/powerpc/mm/book3s64/radix_pgtable.c     | 16 +++++------
 arch/powerpc/mm/pgtable.c                    |  6 ++---
 arch/powerpc/mm/pgtable_64.c                 |  8 +++---
 arch/powerpc/xmon/xmon.c                     |  6 ++---
 arch/riscv/include/asm/pgtable-64.h          |  2 +-
 arch/riscv/include/asm/pgtable.h             |  2 +-
 arch/s390/boot/vmem.c                        |  4 +--
 arch/s390/include/asm/pgtable.h              | 20 +++++++-------
 arch/s390/mm/gmap.c                          | 14 +++++-----
 arch/s390/mm/hugetlbpage.c                   |  6 ++---
 arch/s390/mm/pageattr.c                      |  4 +--
 arch/s390/mm/pgtable.c                       |  8 +++---
 arch/s390/mm/vmem.c                          | 12 ++++-----
 arch/sparc/include/asm/pgtable_64.h          |  8 +++---
 arch/sparc/mm/init_64.c                      |  6 ++---
 arch/x86/boot/compressed/ident_map_64.c      |  2 +-
 arch/x86/include/asm/pgtable.h               | 24 +++++++----------
 arch/x86/kvm/mmu/mmu.c                       |  6 ++---
 arch/x86/mm/fault.c                          | 16 +++++------
 arch/x86/mm/ident_map.c                      |  2 +-
 arch/x86/mm/init_32.c                        |  2 +-
 arch/x86/mm/init_64.c                        | 14 +++++-----
 arch/x86/mm/kasan_init_64.c                  |  4 +--
 arch/x86/mm/mem_encrypt_identity.c           |  6 ++---
 arch/x86/mm/pat/set_memory.c                 | 14 +++++-----
 arch/x86/mm/pgtable.c                        |  4 +--
 arch/x86/mm/pti.c                            | 10 +++----
 arch/x86/power/hibernate.c                   |  6 ++---
 arch/x86/xen/mmu_pv.c                        | 10 +++----
 drivers/misc/sgi-gru/grufault.c              |  2 +-
 include/asm-generic/pgtable-nopmd.h          |  1 -
 include/linux/pgtable.h                      |  8 +++---
 mm/kasan/shadow.c                            | 11 ++------
 41 files changed, 141 insertions(+), 201 deletions(-)

-- 
2.44.0


