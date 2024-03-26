Return-Path: <linux-kernel+bounces-119181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5708688C530
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 140C7303B74
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C6913BC3B;
	Tue, 26 Mar 2024 14:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hCNGfFh8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3D17E586
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 14:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711463563; cv=none; b=ABW6c2n5zcVx5nemqImZrXP7RKZzWyhJfg3nOl9wxgn1vWdai191uRPyCsFeTcCnLFsL42btWX/4GynjJfmYeTycR9kZOUgrE6L2Pw0LOv53U9LWVl7r7eWyVp75kJ2vkN54Apj7a8WzImfLfgIFrZ4fVZO4JIF4BnK3BWhNUkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711463563; c=relaxed/simple;
	bh=f7T8MkaAXp1DoF4aQypiINaYqrYwwuPzyFcZXUDYcV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IuY0qTvVNet8jZi3roOdo3LccgBDR2eW/4ncqXTmoggaY1DURxSDSVqsyxpXD2D16B17v5/KfGyzQvyiL8B9mfFdkA29+N241FCgkwiBVfU8p9DLT3hIXdtiUoMI02EjROl7hqbBl5m3gexEafSlCoqLyGI9bn4DA3ueQF0X7B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hCNGfFh8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711463560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=k3fG4r4Q8hx+GsgNbmv8fZt36Dp6KwDjh0kqtr+4P8U=;
	b=hCNGfFh81ZcQ+6W/sSj3bZjEwrs4jcFE+IxI8ea/f2c2zkRs17ogQdieowIDLr+GOGEGPP
	CaAvbAGzHoxwD64P8jmMNRjyb0IDbuA/6S/Iqbso60EOCbGFBSPLBD7UfUTrPTSzC2/Bqt
	seqn1kUDQz6+eUvVHerrRUCTh/wD46I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-lCb3fHdnM7OwuK4mX5a9sA-1; Tue, 26 Mar 2024 10:32:34 -0400
X-MC-Unique: lCb3fHdnM7OwuK4mX5a9sA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1FE6484AED1;
	Tue, 26 Mar 2024 14:32:34 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.164])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A118140C6CBF;
	Tue, 26 Mar 2024 14:32:31 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	xingwei lee <xrivendell7@gmail.com>,
	yue sun <samsun1006219@gmail.com>
Subject: [PATCH v2 0/3] mm/secretmem: one fix and one refactoring
Date: Tue, 26 Mar 2024 15:32:07 +0100
Message-ID: <20240326143210.291116-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Patch #1 fixes a GUP-fast issue, whereby we might succeed in pinning
secretmem folios. Patch #2 extends the memfd_secret selftest to cover
that case. Patch #3 removes folio_is_secretmem() and instead lets
folio_fast_pin_allowed() cover that case as well.

With this series, the reproducer (+selftests) works as expected. To
test patch #3, the gup_longterm test does exactly what we need, and
keeps on working as expected.

Without the fix:
	TAP version 13
	1..6
	ok 1 mlock limit is respected
	ok 2 file IO is blocked as expected
	not ok 3 vmsplice: unexpected memory access with fresh page
	ok 4 vmsplice is blocked as expected with existing page
	ok 5 process_vm_read is blocked as expected
	ok 6 ptrace is blocked as expected
	# Totals: pass:5 fail:1 xfail:0 xpass:0 skip:0 error:0

With the fix:
	TAP version 13
	1..6
	ok 1 mlock limit is respected
	ok 2 file IO is blocked as expected
	ok 3 vmsplice is blocked as expected with fresh page
	ok 4 vmsplice is blocked as expected with existing page
	ok 5 process_vm_read is blocked as expected
	ok 6 ptrace is blocked as expected
	# Totals: pass:6 fail:0 xfail:0 xpass:0 skip:0 error:0

v1 -> v2:
* "mm/secretmem: fix GUP-fast succeeding on secretmem folios"
 -> Drop the LRU check completely
 -> Rephrase patch description
 -> (Dropped RB from Mike)
* "selftests/memfd_secret: add vmsplice() test"
 -> Add test with fresh+existing page
 -> Change pass/fail message
 -> Rephrase patch description
 -> (Dropped RB from Mike)
* "mm: merge folio_is_secretmem() and folio_fast_pin_allowed() into
   gup_fast_folio_allowed()"
 -> Adjust to dropped LRU check
 -> Rename folio_fast_pin_allowed() to gup_fast_folio_allowed()
 -> Rephrase patch description
 -> Add RB from Mike

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>
Cc: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: xingwei lee <xrivendell7@gmail.com>
Cc: yue sun <samsun1006219@gmail.com>

David Hildenbrand (3):
  mm/secretmem: fix GUP-fast succeeding on secretmem folios
  selftests/memfd_secret: add vmsplice() test
  mm: merge folio_is_secretmem() and folio_fast_pin_allowed() into
    gup_fast_folio_allowed()

 include/linux/secretmem.h                 | 21 +---------
 mm/gup.c                                  | 48 ++++++++++++---------
 tools/testing/selftests/mm/memfd_secret.c | 51 ++++++++++++++++++++++-
 3 files changed, 79 insertions(+), 41 deletions(-)

-- 
2.43.2


