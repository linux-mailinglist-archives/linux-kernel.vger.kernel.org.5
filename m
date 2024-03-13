Return-Path: <linux-kernel+bounces-102551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E122B87B3C2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51E0BB21AA9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A9C56B9B;
	Wed, 13 Mar 2024 21:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FI57p4S+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BB5481DE
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 21:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366447; cv=none; b=jtX/KpC/kyIoCVdB7W3g7WhBcFrw7IfUnKrUqTlZIhKHhw/c9c0k6rFWNQdHaTsyUn6XrYWJ5XUTTUBqjQxKZyFi75CpDSdZ4Vk9gRmXgnnfXA9W8ZU7vhnRfa9tw6ZraVhXxh8z/jDdqwg0TSzFt54ro/MAuxBKs/pKtK065JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366447; c=relaxed/simple;
	bh=s4/9x2JKNYrGxGEsr2TDxHlJ4NRbQYZwHeWSFcDqyfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T/w3vn1liqqIiJkwLiGpsrrJoY2Iitlu/WrFweIWixeKJlVJVQFxkShU6jYOC3repGkPx/qCLFOINDWtDJGUSP/20saptnnAExXOZLT2P7SEb7uDVI3k4FrkEEQEZNY7AF6njjc2PAN2IqvJOuFsS6z2Jn9EBPGZm9gRsXGdt0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FI57p4S+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710366444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Cvg3h+nHFQQ2z0yoilgh/3E5YQAg693jLTvjOOpWcMg=;
	b=FI57p4S+EUcPi+r1+QxwPl0qovIAantYoBd76JKd9wff2BDeBE1QK85NxHnYzA8IJiin5G
	DOaGBjfWifd7hjEwFNDUDpp9rMPUkT8pn9KGRRkOHv24Ic9tyDg8SAUoKJEVO6EdbiYYI6
	vbqNIvIvCpIvbUEhT9Fin9vShdYtHZI=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-f1aRwyYZPIe3mo3yyeGXrw-1; Wed, 13 Mar 2024 17:47:23 -0400
X-MC-Unique: f1aRwyYZPIe3mo3yyeGXrw-1
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-474c751e9baso10129137.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 14:47:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710366442; x=1710971242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cvg3h+nHFQQ2z0yoilgh/3E5YQAg693jLTvjOOpWcMg=;
        b=BxFfXxJSj5o7wGB6mCknSDg3VAagyHqaXTgeCBoAwwcc0q7pfyKRPHgIgwlSyhxxvb
         o40gPZTBmGpXiJiY8qz3nSfz6bjvQdsVyC37KOtD9mZDuPywDoadxd946EeDLpEH2v/5
         7ix2n7u2mCSPKNWXitRlTf+YnkugTy02P/x6lttZ0GMupHjXKCNKF0tU/nbI5bhXlU79
         lzsLe/4xbrcbSKEnoqvkIDX2oyN4rWMPJaOyL5TIgemDD6NwM22VYOAL6R+ZIqFbUxCJ
         6rQAYTj7GWdfJZ0mdff01twwCkO2XkIQ3SNhqSCLxU8xBVWCj2gBoZKnpV5Xe1DLYlq1
         2o+A==
X-Gm-Message-State: AOJu0YxlhwiRWJckSFApc30iJ3ZQu0hExzs1mcxKL2Ehh+6qQAAGOqtx
	Y9pkgEL6/qFFtnEDswy6LjDTz8IYOxQ3KwHHifeHK14vNu4w8LVXasMdgLdWiqgmD4YBCCawyc4
	EqVrOa1WZYOo7CuNi+GyEB55AfbcnVGVQojgIlFZtg6eMpByOjXREtjX3I1N3qC8Oa/ye7B0OTF
	riEBYTdbOyw9P4nQ4e+eC1UglS1BL8LqB8z5Zqylxs0tY=
X-Received: by 2002:a67:fc48:0:b0:474:d24b:f5cc with SMTP id p8-20020a67fc48000000b00474d24bf5ccmr185187vsq.2.1710366442106;
        Wed, 13 Mar 2024 14:47:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExtUpFAsO3j//nWUMiYrfkHfIQvS7XHG2BBi3o5gYAsKI/7+sGpzOvwSA+TSYy8KtxKUURKw==
X-Received: by 2002:a67:fc48:0:b0:474:d24b:f5cc with SMTP id p8-20020a67fc48000000b00474d24bf5ccmr185164vsq.2.1710366441588;
        Wed, 13 Mar 2024 14:47:21 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id dv10-20020ad44eea000000b0069111c5cdd4sm60114qvb.100.2024.03.13.14.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 14:47:21 -0700 (PDT)
From: peterx@redhat.com
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: linux-arm-kernel@lists.infradead.org,
	Matthew Wilcox <willy@infradead.org>,
	linuxppc-dev@lists.ozlabs.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	x86@kernel.org,
	peterx@redhat.com,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	sparclinux@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 00/13] mm/treewide: Remove pXd_huge() API
Date: Wed, 13 Mar 2024 17:47:06 -0400
Message-ID: <20240313214719.253873-1-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Peter Xu <peterx@redhat.com>

[based on akpm/mm-unstable latest commit 9af2e4c429b5]

v1:
- Rebase, remove RFC tag
- Fixed powerpc patch build issue, enhancing commit message [Michael]
- Optimize patch 1 & 3 on "none || !present" check [Jason]

In previous work [1], we removed the pXd_large() API, which is arch
specific.  This patchset further removes the hugetlb pXd_huge() API.

Hugetlb was never special on creating huge mappings when compared with
other huge mappings.  Having a standalone API just to detect such pgtable
entries is more or less redundant, especially after the pXd_leaf() API set
is introduced with/without CONFIG_HUGETLB_PAGE.

When looking at this problem, a few issues are also exposed that we don't
have a clear definition of the *_huge() variance API.  This patchset
started by cleaning these issues first, then replace all *_huge() users to
use *_leaf(), then drop all *_huge() code.

On x86/sparc, swap entries will be reported "true" in pXd_huge(), while for
all the rest archs they're reported "false" instead.  This part is done in
patch 1-5, in which I suspect patch 1 can be seen as a bug fix, but I'll
leave that to hmm experts to decide.

Besides, there are three archs (arm, arm64, powerpc) that have slightly
different definitions between the *_huge() v.s. *_leaf() variances.  I
tackled them separately so that it'll be easier for arch experts to chim in
when necessary.  This part is done in patch 6-9.

The final patches 10-13 do the rest on the final removal, since *_leaf()
will be the ultimate API in the future, and we seem to have quite some
confusions on how *_huge() APIs can be defined, provide a rich comment for
*_leaf() API set to define them properly to avoid future misuse, and
hopefully that'll also help new archs to start support huge mappings and
avoid traps (like either swap entries, or PROT_NONE entry checks).

The whole series is only lightly tested on x86, while as usual I don't have
the capability to test all archs that it touches.

[1] https://lore.kernel.org/r/20240305043750.93762-1-peterx@redhat.com

Peter Xu (13):
  mm/hmm: Process pud swap entry without pud_huge()
  mm/gup: Cache p4d in follow_p4d_mask()
  mm/gup: Check p4d presence before going on
  mm/x86: Change pXd_huge() behavior to exclude swap entries
  mm/sparc: Change pXd_huge() behavior to exclude swap entries
  mm/arm: Use macros to define pmd/pud helpers
  mm/arm: Redefine pmd_huge() with pmd_leaf()
  mm/arm64: Merge pXd_huge() and pXd_leaf() definitions
  mm/powerpc: Redefine pXd_huge() with pXd_leaf()
  mm/gup: Merge pXd huge mapping checks
  mm/treewide: Replace pXd_huge() with pXd_leaf()
  mm/treewide: Remove pXd_huge()
  mm: Document pXd_leaf() API

 arch/arm/include/asm/pgtable-2level.h         |  4 +--
 arch/arm/include/asm/pgtable-3level-hwdef.h   |  1 +
 arch/arm/include/asm/pgtable-3level.h         |  6 ++--
 arch/arm/mm/Makefile                          |  1 -
 arch/arm/mm/hugetlbpage.c                     | 34 -------------------
 arch/arm64/include/asm/pgtable.h              |  6 +++-
 arch/arm64/mm/hugetlbpage.c                   | 18 ++--------
 arch/loongarch/mm/hugetlbpage.c               | 12 +------
 arch/mips/include/asm/pgtable-32.h            |  2 +-
 arch/mips/include/asm/pgtable-64.h            |  2 +-
 arch/mips/mm/hugetlbpage.c                    | 10 ------
 arch/mips/mm/tlb-r4k.c                        |  2 +-
 arch/parisc/mm/hugetlbpage.c                  | 11 ------
 .../include/asm/book3s/64/pgtable-4k.h        | 20 -----------
 .../include/asm/book3s/64/pgtable-64k.h       | 25 --------------
 arch/powerpc/include/asm/book3s/64/pgtable.h  | 27 +++++++--------
 arch/powerpc/include/asm/nohash/pgtable.h     | 10 ------
 arch/powerpc/mm/pgtable_64.c                  |  6 ++--
 arch/riscv/mm/hugetlbpage.c                   | 10 ------
 arch/s390/mm/hugetlbpage.c                    | 10 ------
 arch/sh/mm/hugetlbpage.c                      | 10 ------
 arch/sparc/mm/hugetlbpage.c                   | 12 -------
 arch/x86/mm/hugetlbpage.c                     | 26 --------------
 arch/x86/mm/pgtable.c                         |  4 +--
 include/linux/hugetlb.h                       | 24 -------------
 include/linux/pgtable.h                       | 24 ++++++++++---
 mm/gup.c                                      | 24 ++++++-------
 mm/hmm.c                                      |  9 ++---
 mm/memory.c                                   |  2 +-
 29 files changed, 68 insertions(+), 284 deletions(-)
 delete mode 100644 arch/arm/mm/hugetlbpage.c

-- 
2.44.0


