Return-Path: <linux-kernel+bounces-62900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C52E28527AD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 04:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B5E428585C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 03:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523ACB647;
	Tue, 13 Feb 2024 03:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EEOgOMIV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC19D8C0B
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 03:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707794236; cv=none; b=t9Dvm6ZdVEWLEYVxL0yE49cSHBkY1VCNT87T8Z2sk+JsjOlIcdEpKX9RxOM3dPeqG9rZLRyX+J57QlzDytdznB2TVVJxwBYExuisoz4yMkbiO+yFZyiJkPn8eGErVIPgcj5t9v+kvPCHMDA9Cto62CxFvdP9MdDjhbtg5GBPknk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707794236; c=relaxed/simple;
	bh=d7iQUrDMIH4V0V8AYVQKlZ+76ZsY0HbBL3eK0bUgED0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=arjzErPQitbKccQ7tgBSbXE+Z5ghCAe740nOGs+2r5UAEyLbUTl6pl233dLqYyplttu6zsYdf7p5AU8dzrRjkNGA8hibl1dmZiHQtrExq28AUy/SitgpMX+JI5XRE6DY1+2SQaHUpr/zsyoSw/ATTOHNdMuZW2RTbkQEUNl9gMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EEOgOMIV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707794233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KJtQOCSLbtCyrptuxIvNN7xHcs9vT9tWJNF1nm9qSgs=;
	b=EEOgOMIVxVXAjvmxIflvZnq8BLWlRXoaLKrItYd0h2QUXPLCY4f35lLzPz2BWb0Oes72s7
	u14vc/v+5ZnYWZUlnkL3ljj8klnS8mLndlQ5bJz1bJFDrvO9n90peBiTGwXUWMK/Hk8I1A
	NgIy1NAdBMb0kjbDjGNvRQVhPBX0brc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-rjXgcXF4ML-s5EbS2O7hIQ-1; Mon, 12 Feb 2024 22:17:09 -0500
X-MC-Unique: rjXgcXF4ML-s5EbS2O7hIQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 25A71811E79;
	Tue, 13 Feb 2024 03:17:09 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.62])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3C9CEAC1C;
	Tue, 13 Feb 2024 03:17:08 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	George Stark <gnstark@salutedevices.com>,
	Waiman Long <longman@redhat.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 1/4] locking/qspinlock: Fix 'wait_early' set but not used warning
Date: Mon, 12 Feb 2024 22:16:53 -0500
Message-Id: <20240213031656.1375951-2-longman@redhat.com>
In-Reply-To: <20240213031656.1375951-1-longman@redhat.com>
References: <20240213031656.1375951-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

When CONFIG_LOCK_EVENT_COUNTS is off, the wait_early variable will be
set but not used. This is expected. Recent compilers will not generate
wait_early code in this case.

Add the __maybe_unused attribute to wait_early for suppressing this
W=1 warning.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312260422.f4pK3f9m-lkp@intel.com/
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/qspinlock_paravirt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index 6a0184e9c234..ae2b12f68b90 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -294,8 +294,8 @@ static void pv_wait_node(struct mcs_spinlock *node, struct mcs_spinlock *prev)
 {
 	struct pv_node *pn = (struct pv_node *)node;
 	struct pv_node *pp = (struct pv_node *)prev;
+	bool __maybe_unused wait_early;
 	int loop;
-	bool wait_early;
 
 	for (;;) {
 		for (wait_early = false, loop = SPIN_THRESHOLD; loop; loop--) {
-- 
2.39.3


