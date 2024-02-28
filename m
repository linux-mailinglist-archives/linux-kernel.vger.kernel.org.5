Return-Path: <linux-kernel+bounces-84705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9D086AA7D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FFCA1C21EF6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B732D60A;
	Wed, 28 Feb 2024 08:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hDf+ZZCj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC282D05F
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 08:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110446; cv=none; b=G2LWaum5Qq62LTyvoq6pY9RHU7Zs81tahjhNTg9lsynsHKZnu/U7w1QR2dDvgN/VkNFaJ0K4NYClX63FXLRkZQGJHuzqcZMjCZQj/VwPNo58P9+GZSI7YNPiX/lEpaCBa2ZOrpuSTdUfmuWSJvT0XzogWTgmYCzBNOJi7VwgPiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110446; c=relaxed/simple;
	bh=oviEaG00ZryIXr9B+HIb7cA9uT665UZTqRreFwQnGfA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=P4lREbmM1Mdg/bQeW6lVVJTzLnK41KKy+RHc0/+DZBOjR6rcWXiBmV86pZuV6CEUIf1yrmUBVHSiSFJDtIrIdbqmIJ9UlaFPJOJW0/O3j93K2op+PyygvC/A8dRpi1gvHOPVtY3i2qevNCgHanrt3Vj9+sPBTcV3bZFhg04LPDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hDf+ZZCj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709110443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4bhVktrS6dMSA/g0STyv8QBeTwQNCemSRg5EzlavLyM=;
	b=hDf+ZZCjbyOq5nkjl0hkuP5gutlojRivkDe06yNoNsLW/BV1yZoT3/hEeu7Hb7RDRhazML
	3sAnmwBx8Ny81uRmY6ai5kb+uq9DjccuwFuHdI3y4kEdkta0zwC93hUawQo4luwyP8nxZj
	KlGGb72tb7rS6T2an1e/0sKMPQtHKBE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-474-_q4xEYi-M2ObYOFyZZeH3A-1; Wed,
 28 Feb 2024 03:53:59 -0500
X-MC-Unique: _q4xEYi-M2ObYOFyZZeH3A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7A3691C0CCB4;
	Wed, 28 Feb 2024 08:53:58 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 409942022AAA;
	Wed, 28 Feb 2024 08:53:52 +0000 (UTC)
From: peterx@redhat.com
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Yang Shi <shy828301@gmail.com>,
	Muchun Song <muchun.song@linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	x86@kernel.org,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	linuxppc-dev@lists.ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	peterx@redhat.com
Subject: [PATCH 0/5] mm/treewide: Replace pXd_large() with pXd_leaf()
Date: Wed, 28 Feb 2024 16:53:45 +0800
Message-ID: <20240228085350.520953-1-peterx@redhat.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

From: Peter Xu <peterx@redhat.com>

[based on latest akpm/mm-unstable, commit 1274e7646240]

These two APIs are mostly always the same.  It's confusing to have both of
them.  Merge them into one.  Here I used pXd_leaf() only because pXd_leaf()
is a global API which is always defined, while pXd_large() is not.

We have yet one more API that is similar which is pXd_huge(), but that's
even trickier, so let's do it step by step.

Some cautions are needed on either x86 or ppc: x86 is currently the only
user of p4d_large(), while ppc used to define pXd_large() only with THP,
while it is not the case for pXd_leaf().  For the rest archs, afaict
they're 100% identical.

Only lightly tested on x86.

Please have a look, thanks.

Peter Xu (5):
  mm/ppc: Define pXd_large() with pXd_leaf()
  mm/x86: Replace p4d_large() with p4d_leaf()
  mm/treewide: Replace pmd_large() with pmd_leaf()
  mm/treewide: Replace pud_large() with pud_leaf()
  mm/treewide: Drop pXd_large()

 arch/arm/include/asm/pgtable-2level.h        |  1 -
 arch/arm/include/asm/pgtable-3level.h        |  1 -
 arch/arm/mm/dump.c                           |  4 ++--
 arch/powerpc/include/asm/book3s/64/pgtable.h | 14 --------------
 arch/powerpc/include/asm/pgtable.h           |  4 ----
 arch/powerpc/mm/book3s64/pgtable.c           |  4 ++--
 arch/powerpc/mm/book3s64/radix_pgtable.c     |  2 +-
 arch/powerpc/mm/pgtable_64.c                 |  2 +-
 arch/s390/boot/vmem.c                        |  4 ++--
 arch/s390/include/asm/pgtable.h              | 20 ++++++++++----------
 arch/s390/mm/gmap.c                          | 14 +++++++-------
 arch/s390/mm/hugetlbpage.c                   |  6 +++---
 arch/s390/mm/pageattr.c                      |  4 ++--
 arch/s390/mm/pgtable.c                       |  8 ++++----
 arch/s390/mm/vmem.c                          | 12 ++++++------
 arch/sparc/include/asm/pgtable_64.h          |  8 ++++----
 arch/sparc/mm/init_64.c                      |  6 +++---
 arch/x86/boot/compressed/ident_map_64.c      |  2 +-
 arch/x86/include/asm/pgtable.h               | 15 +++++++--------
 arch/x86/kvm/mmu/mmu.c                       |  4 ++--
 arch/x86/mm/fault.c                          | 16 ++++++++--------
 arch/x86/mm/ident_map.c                      |  2 +-
 arch/x86/mm/init_32.c                        |  2 +-
 arch/x86/mm/init_64.c                        | 14 +++++++-------
 arch/x86/mm/kasan_init_64.c                  |  4 ++--
 arch/x86/mm/mem_encrypt_identity.c           |  6 +++---
 arch/x86/mm/pat/set_memory.c                 | 14 +++++++-------
 arch/x86/mm/pgtable.c                        |  4 ++--
 arch/x86/mm/pti.c                            |  8 ++++----
 arch/x86/power/hibernate.c                   |  6 +++---
 arch/x86/xen/mmu_pv.c                        | 10 +++++-----
 drivers/misc/sgi-gru/grufault.c              |  2 +-
 32 files changed, 101 insertions(+), 122 deletions(-)

-- 
2.43.0


