Return-Path: <linux-kernel+bounces-62899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 107708527AC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 04:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B368D1F23686
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 03:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C046AA93D;
	Tue, 13 Feb 2024 03:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="REzFb0Ui"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD998C0A
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 03:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707794236; cv=none; b=UXklX6WMLsjM4UqXfFg6enqEnlc2uP1JZfIVZr0wQ0bG+W5GHoSDaAQAKlRd2gZitsvz/MS1v+sQnCMPr68WGc8rlYOlMl+hdxU4ua1CKupLXRfDBhVPydPxdJtxQkxqJ7ruPXGyY6qYyHJkWn7hhALVounE+7lIJzyOv/AFLT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707794236; c=relaxed/simple;
	bh=DKDhVG/tH5THyTRx5j1f2Hlbcx8R7tgFZfqbMdDQ0aA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ala+ajW4Xc+0tXriFlD1fdm2JUUd3fIR8t5CAswcrv8kKTe5Q3HN+UxRaEqCUJO6OfW455xI12y+clNJ05LnlnMEtWxXrm6jgYPXyet+aOvWnKKN3Xgh90b48jWC/GsNaEeHUIAZIgcKteTskQy9HXJ51QsV0rDZ72NAEVRXPUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=REzFb0Ui; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707794233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yGWd21YNNFyE7PXWYSjal19PhVVgZAsoAbEKZ2AIsfQ=;
	b=REzFb0UiZ/MujEoP5YJVErrEJL0/Ck10g0RlSZyX8RGp5BcDKIM5i2N+vwjvLIofeROo2S
	7GOSmmDKQ7FCnrGdjPiHuCa9WuTAE3xp3g2V54qnZTDF4oOA4uf7kphabxk7mLNSsNFBrf
	1AsM6YhjgKVHbJPMa9IVRBea4LQaYPA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-ULbFT_OqOFmMKgZHl0L9-Q-1; Mon,
 12 Feb 2024 22:17:11 -0500
X-MC-Unique: ULbFT_OqOFmMKgZHl0L9-Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 499121C04B61;
	Tue, 13 Feb 2024 03:17:11 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.62])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A5343AD69;
	Tue, 13 Feb 2024 03:17:10 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	George Stark <gnstark@salutedevices.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 4/4] locking/rwsem: Make DEBUG_RWSEMS and PREEMPT_RT mutually exclusive
Date: Mon, 12 Feb 2024 22:16:56 -0500
Message-Id: <20240213031656.1375951-5-longman@redhat.com>
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

The debugging code enabled by CONFIG_DEBUG_RWSEMS will only be
compiled in when CONFIG_PREEMPT_RT isn't set. There is no point to
allow CONFIG_DEBUG_RWSEMS to be set in a kernel configuration where
CONFIG_PREEMPT_RT is also set. Make them mutually exclusive.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 lib/Kconfig.debug | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 975a07f9f1cc..cb695bc76d30 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1303,7 +1303,7 @@ config PROVE_LOCKING
 	select DEBUG_SPINLOCK
 	select DEBUG_MUTEXES if !PREEMPT_RT
 	select DEBUG_RT_MUTEXES if RT_MUTEXES
-	select DEBUG_RWSEMS
+	select DEBUG_RWSEMS if !PREEMPT_RT
 	select DEBUG_WW_MUTEX_SLOWPATH
 	select DEBUG_LOCK_ALLOC
 	select PREEMPT_COUNT if !ARCH_NO_PREEMPT
@@ -1426,7 +1426,7 @@ config DEBUG_WW_MUTEX_SLOWPATH
 
 config DEBUG_RWSEMS
 	bool "RW Semaphore debugging: basic checks"
-	depends on DEBUG_KERNEL
+	depends on DEBUG_KERNEL && !PREEMPT_RT
 	help
 	  This debugging feature allows mismatched rw semaphore locks
 	  and unlocks to be detected and reported.
-- 
2.39.3


