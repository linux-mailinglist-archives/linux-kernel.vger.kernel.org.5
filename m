Return-Path: <linux-kernel+bounces-62898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FEC8527AB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 04:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A6041F236AC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 03:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327218F77;
	Tue, 13 Feb 2024 03:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J5BSFnse"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08C48BFC
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 03:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707794235; cv=none; b=bcAtasYKG/XxqVvHSH3T4PQlhHTpW42IiNpNcx1Ad55bu8rd+XGgaT/zQJDpjf6kC/d2cwdzcZYyZnALp1o5jAQs1lWIUUVnbTspN5YePtuydcylhpZVeZEzD+WociowqlA4xjnzvFQei5Rd3KhfajI2USQ85wFs1Rhml11tZvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707794235; c=relaxed/simple;
	bh=F1m/aD6lzCMWutOEh5r7wEcTmpqLVziRfs8NPgMbPwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jXBe8Dqc9IIMYPHcCx+unCpwHNczEPFSacsgpsjySU/Gijsh6NpM1QIyRPuusX+CNd/qyINhxy1JyNJySA3ZFdRMxvkUsFXcOnP7XXbpt3zZlciGKsErd9XTiQnrKyjfYxDfKLP/97qw6Ie6FA8fe4d3htR5q+CudahSbVr7BNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J5BSFnse; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707794232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=j8JzdnskN++AwAUpZbIrZ2/Bzk43WRvT61K84t7fBEY=;
	b=J5BSFnse1WLzcycPcS2yScjAkYH8aeTQfLOyCw7tV54aPoX0oj/mPM1gUYg3/YFg9DCxXw
	wk7/AbY7IZdRq9pM7P73S+Y0bIIyTEGVcqLUhN2pNVm3nHi6wCcYFpB8jkf3PUB4ksfMVb
	d1UvpC0KuwSDknz2LmZgE+zMUTlyv10=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-17-go-GN1tgMwG2tSyP-yXtLQ-1; Mon,
 12 Feb 2024 22:17:08 -0500
X-MC-Unique: go-GN1tgMwG2tSyP-yXtLQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B5841C04B5A;
	Tue, 13 Feb 2024 03:17:08 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.62])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 98A0AAC17;
	Tue, 13 Feb 2024 03:17:06 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	George Stark <gnstark@salutedevices.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 0/4] locking: Some locking code cleanups
Date: Mon, 12 Feb 2024 22:16:52 -0500
Message-Id: <20240213031656.1375951-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

This series contains a number of cleanup locking patches.

Waiman Long (4):
  locking/qspinlock: Fix 'wait_early' set but not used warning
  locking/mutex: Clean up mutex.h
  locking/rwsem: Clarify that RWSEM_READER_OWNED is just a hint
  locking/rwsem: Make DEBUG_RWSEMS and PREEMPT_RT mutually exclusive

 include/linux/mutex.h               | 23 +++++++++++------------
 kernel/locking/qspinlock_paravirt.h |  2 +-
 kernel/locking/rwsem.c              |  6 +++---
 lib/Kconfig.debug                   |  4 ++--
 4 files changed, 17 insertions(+), 18 deletions(-)

-- 
2.39.3


