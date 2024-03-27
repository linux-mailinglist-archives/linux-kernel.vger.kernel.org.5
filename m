Return-Path: <linux-kernel+bounces-121680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 385B288EC5C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B91F91F3030F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44A114E2E2;
	Wed, 27 Mar 2024 17:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QlHyqx4J"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50F014E2C4
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 17:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711559877; cv=none; b=ABqklHwxPcZl10+x+Mnt1p2/4XFgcBLc3nMfU27zw+H0GNHSlstm5ilDM/IUsmaCYVrw9X1wFecl/iOniYZ8HelGVc2zqYb8HtKQqhZfcK4FgK8Ipb/cTo8yemGf8rrpjqy/lKl05boq966KSCwQrXMUBven2DPiQIbR8POb2CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711559877; c=relaxed/simple;
	bh=EdfLc/3/vb1dGCMhQldF+qYp0nlkvEKp1oqt7MkvxwY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e3D6luoJpktSE4WZbc0QcMkBElpIbw+N4qsf3vszr3JEMYXeqgEGzJi7yk804rhMLH4sEAf7eDhzOwYsPFJYCM6RzikDt7X5RluKdkL9x6A6EnvpNOd408pq6iDL/C/PkDpBLs6p23hsFaj9EbKYoyHhdR9mg9LCO81aVBp3f1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QlHyqx4J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711559874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gs7mz2T2Nzxhsdo7I/ZcfY9h1l0ujt1Yaj1fAdyaXDw=;
	b=QlHyqx4J2K5PbSdGQP7f8KwnpuXSovqXb3qVDwPO0OIrVhVHFuQh1LyAMcJtwfdwvSuIOU
	4BD8diFXNreZvSPFOtuP1SHXhSW62yjPMCuf6nRQ6s8dd4WdwUwjYCQjnB+x8gx1WhGVZz
	o7x2cBiBzhzC0Cl9960u9gJcRCBXkjc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-ENn_kGGANHuMOOroM-8g4Q-1; Wed, 27 Mar 2024 13:17:49 -0400
X-MC-Unique: ENn_kGGANHuMOOroM-8g4Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9A686101A526;
	Wed, 27 Mar 2024 17:17:48 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.208])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0EC5A1121312;
	Wed, 27 Mar 2024 17:17:43 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Xu <peterx@redhat.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	kvm@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: [PATCH v2 0/2] s390/mm: shared zeropage + KVM fixes
Date: Wed, 27 Mar 2024 18:17:35 +0100
Message-ID: <20240327171737.919590-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

This series fixes one issue with uffd + shared zeropages on s390x and
fixes that "ordinary" KVM guests can make use of shared zeropages again.

userfaultfd could currently end up mapping shared zeropages into processes
that forbid shared zeropages. This only apples to s390x, relevant for
handling PV guests and guests that use storage kets correctly. Fix it
by placing a zeroed folio instead of the shared zeropage during
UFFDIO_ZEROPAGE instead.

I stumbled over this issue while looking into a customer scenario that
is using:

(1) Memory ballooning for dynamic resizing. Start a VM with, say, 100 GiB
    and inflate the balloon during boot to 60 GiB. The VM has ~40 GiB
    available and additional memory can be "fake hotplugged" to the VM
    later on demand by deflating the balloon. Actual memory overcommit is
    not desired, so physical memory would only be moved between VMs.

(2) Live migration of VMs between sites to evacuate servers in case of
    emergency.

Without the shared zeropage, during (2), the VM would suddenly consume
100 GiB on the migration source and destination. On the migration source,
where we don't excpect memory overcommit, we could easilt end up crashing
the VM during migration.

Independent of that, memory handed back to the hypervisor using "free page
reporting" would end up consuming actual memory after the migration on the
destination, not getting freed up until reused+freed again.

While there might be ways to optimize parts of this in QEMU, we really
should just support the shared zeropage again for ordinary VMs.

We only expect legcy guests to make use of storage keys, so let's handle
zeropages again when enabling storage keys or when enabling PV. To not
break userfaultfd like we did in the past, don't zap the shared zeropages,
but instead trigger unsharing faults, just like we do for unsharing
KSM pages in break_ksm().

Unsharing faults will simply replace the shared zeropage by a zeroed
anonymous folio. We can already trigger the same fault path using GUP,
when trying to long-term pin a shared zeropage, but also when unmerging
a KSM-placed zeropages, so this is nothing new.

Patch #1 tested on 86-64 by forcing mm_forbids_zeropage() to be 1, and
running the uffd selftests.

Patch #2 tested on s390x: the live migration scenario now works as
expected, and kvm-unit-tests that trigger usage of skeys work well, whereby
I can see detection and unsharing of shared zeropages.

Based on Linus master. Andrew agreed that both patches can go via the
s390x tree.

v1 -> v2:
* "mm/userfaultfd: don't place zeropages when zeropages are disallowed"
 -> Minor "ret" ahndling tweaks
* "s390/mm: re-enable the shared zeropage for !PV and !skeys KVM guests"
 -> Added Fixes: tag

Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org

David Hildenbrand (2):
  mm/userfaultfd: don't place zeropages when zeropages are disallowed
  s390/mm: re-enable the shared zeropage for !PV and !skeys KVM guests

 arch/s390/include/asm/gmap.h        |   2 +-
 arch/s390/include/asm/mmu.h         |   5 +
 arch/s390/include/asm/mmu_context.h |   1 +
 arch/s390/include/asm/pgtable.h     |  15 ++-
 arch/s390/kvm/kvm-s390.c            |   4 +-
 arch/s390/mm/gmap.c                 | 163 +++++++++++++++++++++-------
 mm/userfaultfd.c                    |  34 ++++++
 7 files changed, 177 insertions(+), 47 deletions(-)

-- 
2.43.2


