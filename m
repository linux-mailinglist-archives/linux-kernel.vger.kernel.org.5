Return-Path: <linux-kernel+bounces-86325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DD686C3F2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64F61284784
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8901251C2C;
	Thu, 29 Feb 2024 08:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sv/am9A2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F71F50A7E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 08:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709196195; cv=none; b=Pv8z4kie/FbbGAFqfNeB4Uikt/yOO9Ftrf0RWocCS3LE+Lm9o2sPDVaSxbjFnxrp6d3d5x9N2//HqGrfIlDPY55Pf0oRtKdFB8Dpm8MlNsV7xmCVSINDn2Ur7GoT00QAiD2Zi2XDm0asofwLvf4e8Jo+qAZeqEtAj8BvExyT3Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709196195; c=relaxed/simple;
	bh=OpghRkYBRv5vOLqSsMEp9J7irwZMGw99BVcLsJuz6Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kJOmASpikvfYh9Nr9+DrNfddpoySig5uidkb1nb40lQeVTBS1O4aMYvUdM8RGQheTsN/3/MTH5MnG/hrbclr9x8/vo16rJqeadQIiHwImtnpA9eVBz4MOu+FJPkDyWze0OI7vpr2+uyOQE5AdrAN9Te2VoQyIO0ywHi2a4hZoBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sv/am9A2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709196193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=V2zDOtq/zMs9EWQrhRs/fjSpny2ZJnGnEwNBTlsPnCA=;
	b=Sv/am9A2IoqTIIAemQ6JZH2K424RO6Qq3BcL14+bbSnZWZAV74JRGZolOs9TfCqom5Xclk
	BaORXCvm0Q+TwbPuN+lPnERdi9Wy5eAyo2kgxT7Y2zz2l99fVDXaSTiH/x0cOmpoXrKj2K
	a2Q63BBpLojbxc+TiSTNqfPVx1k4G1Q=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-258-WTxOHKzPMra3bRoOtE4B5g-1; Thu,
 29 Feb 2024 03:43:07 -0500
X-MC-Unique: WTxOHKzPMra3bRoOtE4B5g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A97DD2932483;
	Thu, 29 Feb 2024 08:43:06 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0A4B028D;
	Thu, 29 Feb 2024 08:43:00 +0000 (UTC)
From: peterx@redhat.com
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	Yang Shi <shy828301@gmail.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Jason Gunthorpe <jgg@nvidia.com>,
	peterx@redhat.com,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	x86@kernel.org
Subject: [PATCH v2 0/7] mm/treewide: Replace pXd_large() with pXd_leaf()
Date: Thu, 29 Feb 2024 16:42:51 +0800
Message-ID: <20240229084258.599774-1-peterx@redhat.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

From: Peter Xu <peterx@redhat.com>

[based on latest akpm/mm-unstable, commit 1274e7646240]

v2:
- Added patch "mm/ppc: Replace pXd_is_leaf() with pXd_leaf()" [Christophe]
- Added patch "mm/x86: Drop two unnecessary pud_leaf() definitions" [syzbot]
- Touched up two more comments which also referenced pmd_large()

These two APIs are mostly always the same.  It's confusing to have both of
them.  Merge them into one.  Here I used pXd_leaf() only because pXd_leaf()
is a global API which is always defined, while pXd_large() is not.

We have yet one more API that is similar which is pXd_huge(), but that's
even trickier, so let's do it step by step.

Some special cares are taken for ppc and x86, they're done as separate
cleanups first.  Only lightly tested on x86.

Please have a look, thanks.

Peter Xu (7):
  mm/ppc: Define pXd_large() with pXd_leaf()
  mm/ppc: Replace pXd_is_leaf() with pXd_leaf()
  mm/x86: Replace p4d_large() with p4d_leaf()
  mm/x86: Drop two unnecessary pud_leaf() definitions
  mm/treewide: Replace pmd_large() with pmd_leaf()
  mm/treewide: Replace pud_large() with pud_leaf()
  mm/treewide: Drop pXd_large()

 arch/arm/include/asm/pgtable-2level.h        |  1 -
 arch/arm/include/asm/pgtable-3level.h        |  1 -
 arch/arm/mm/dump.c                           |  4 +--
 arch/powerpc/include/asm/book3s/64/pgtable.h | 26 ++++--------------
 arch/powerpc/include/asm/pgtable.h           | 28 --------------------
 arch/powerpc/kvm/book3s_64_mmu_radix.c       | 12 ++++-----
 arch/powerpc/mm/book3s64/pgtable.c           |  4 +--
 arch/powerpc/mm/book3s64/radix_pgtable.c     | 16 +++++------
 arch/powerpc/mm/pgtable.c                    |  6 ++---
 arch/powerpc/mm/pgtable_64.c                 |  8 +++---
 arch/powerpc/xmon/xmon.c                     |  6 ++---
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
 arch/x86/include/asm/pgtable.h               | 20 +++++---------
 arch/x86/kvm/mmu/mmu.c                       |  4 +--
 arch/x86/mm/fault.c                          | 16 +++++------
 arch/x86/mm/ident_map.c                      |  2 +-
 arch/x86/mm/init_32.c                        |  2 +-
 arch/x86/mm/init_64.c                        | 14 +++++-----
 arch/x86/mm/kasan_init_64.c                  |  4 +--
 arch/x86/mm/mem_encrypt_identity.c           |  6 ++---
 arch/x86/mm/pat/set_memory.c                 | 14 +++++-----
 arch/x86/mm/pgtable.c                        |  4 +--
 arch/x86/mm/pti.c                            |  8 +++---
 arch/x86/power/hibernate.c                   |  6 ++---
 arch/x86/xen/mmu_pv.c                        | 10 +++----
 drivers/misc/sgi-gru/grufault.c              |  2 +-
 include/asm-generic/pgtable-nopmd.h          |  1 -
 36 files changed, 128 insertions(+), 181 deletions(-)

-- 
2.43.0


