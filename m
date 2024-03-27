Return-Path: <linux-kernel+bounces-121336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F20D688E62D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E7211C2CFD0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34C0153BDC;
	Wed, 27 Mar 2024 13:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P63ApZGS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F21A139CFE
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 13:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711544754; cv=none; b=sPbPxjTNciowGpBf8D7XGMDcuxFg0O8s7kD9kt8ecsI3CUxXicb4w601Cw8rI6wMUMQH7OChEkjCZu9g3Jwff5iL8928JSRYWc5RV9deNLmnIp50tNDjdYomSVmwY+NlXYHonHXIRfb8iw+3AeQe7I1xk3HyozTIWsmami7Gg78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711544754; c=relaxed/simple;
	bh=T7TNvmCf/1yeTIag2IxePhj+p5To/2TxutzNxnT6nU8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bWBtEptdAFA1JvToT+vIMccRtP7EI2aKIwFoMGcudx/0B6Iuf5u5FaYxRnp2dTITYQEGnJLjvtdWQwD/YojdqptQv8UllwjCBOR41ugAUY2/+HV4pzgAGxewipNnl6bL4moIYDUd9gA6QF9diPj6TApH5hPRo8b2JeFN7Af/7m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P63ApZGS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711544751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rNcKksIhCQ6uwQhIYkqsC9yoUW4iGyOTSKFTVMknF84=;
	b=P63ApZGSZy7Xud1oZ6F/X/dTH4o0jOJ5gg3mE0q+R/obH+R5m4pWBRvQKnWUzVPIbAgo+s
	LYxtaKy1rWXpGzfW6wjO1r0sJ1SxTwFpMNRlk3zqQaSqQdDC29jWBEW/2wGJkD2HEB+p2x
	rKOwa2cK7d5bR9eglPByNt4g/Pj1+JU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-hmCVBBIZOmqVEcZ9AutL7A-1; Wed, 27 Mar 2024 09:05:47 -0400
X-MC-Unique: hmCVBBIZOmqVEcZ9AutL7A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B304D85530E;
	Wed, 27 Mar 2024 13:05:46 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.208])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E78F81C05E1C;
	Wed, 27 Mar 2024 13:05:42 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH RFC 0/3] mm/gup: consistently call it GUP-fast
Date: Wed, 27 Mar 2024 14:05:35 +0100
Message-ID: <20240327130538.680256-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Some cleanups around function names, comments and the config option of
"GUP-fast" -- GUP without "lock" safety belts on.

With this cleanup it's easy to judge which functions are GUP-fast specific.
We now consistently call it "GUP-fast", avoiding mixing it with "fast GUP",
"lockless", or simply "gup" (which I always considered confusing in the
ode).

So the magic now happens in functions that contain "gup_fast", whereby
gup_fast() is the entry point into that magic. Comments consistently
reference either "GUP-fast" or "gup_fast()".

Based on mm-unstable from today. I won't CC arch maintainers, but only
arch mailing lists, to reduce noise.

Tested on x86_64, cross compiled on a bunch of archs, whereby some of them
don't properly even compile on mm-unstable anymore in my usual setup
(alpha, arc, parisc64, sh) ... maybe the cross compilers are outdated,
but there are no new ones around. Hm.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: loongarch@lists.linux.dev
Cc: linux-mips@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-s390@vger.kernel.org
Cc: linux-sh@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-perf-users@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: x86@kernel.org

David Hildenbrand (3):
  mm/gup: consistently name GUP-fast functions
  mm/treewide: rename CONFIG_HAVE_FAST_GUP to CONFIG_HAVE_GUP_FAST
  mm: use "GUP-fast" instead "fast GUP" in remaining comments

 arch/arm/Kconfig       |   2 +-
 arch/arm64/Kconfig     |   2 +-
 arch/loongarch/Kconfig |   2 +-
 arch/mips/Kconfig      |   2 +-
 arch/powerpc/Kconfig   |   2 +-
 arch/s390/Kconfig      |   2 +-
 arch/sh/Kconfig        |   2 +-
 arch/x86/Kconfig       |   2 +-
 include/linux/rmap.h   |   8 +-
 kernel/events/core.c   |   4 +-
 mm/Kconfig             |   2 +-
 mm/filemap.c           |   2 +-
 mm/gup.c               | 170 +++++++++++++++++++++--------------------
 mm/internal.h          |   2 +-
 mm/khugepaged.c        |   2 +-
 15 files changed, 105 insertions(+), 101 deletions(-)

-- 
2.43.2


