Return-Path: <linux-kernel+bounces-76746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C20D385FBDC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 755B21F26C69
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8E014F9DE;
	Thu, 22 Feb 2024 15:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NgHKYPFT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089E914C588
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 15:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708614365; cv=none; b=Hxot6Lxxhe8TUIptsf2k5Inxcd76JrIaf6kksJSfNAciZB0c/CQUw8l14pCypICJpOaziJUkwb4HtOe83cAjjPIKo7e6FEBwJb8VF9eqd/rpvmdEKCxt2hDubaB/aGYkxdNgAoK5MrhqFXFPQOIAn+35OtD2tU+o0QxVVO3efzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708614365; c=relaxed/simple;
	bh=+AQtJf5/TvyBdLCUnBNNQA5gg3qQ4hhhj1LJzSNraEg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FI0lUsEn7Qx1/JofFpPwRMDV96K1NNezRvVmqaLt2MDZfIHVYj863jnQ650/SrcleaIVnVUTf1wrtC5YArQHOiB5d70iInGY1QzvLxl6WPh3qp/fYgEe+CJiRe7LIRF0z1xvuiuadFOcwXBfu5fDG722J5Pr7xNmxdk8ovSdA2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NgHKYPFT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708614362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YwAU1bVRiWDpl3C11z2EMbgNyQd13w59+mKdZ8PW7BM=;
	b=NgHKYPFT9r0lOI8X4TIAS9mrqzlfkYroWInVX9fjBbeH4Ig3+WcDtmKFYr2ZN1g4fvsaLi
	Y8A6/Sh4iFIw9o0rixtPRveKz6AC/AOEG3x6yisOGS/uBDUuyBjPLlngXssdHfJTFqyoV6
	SgI8Gxy29YBkdeCH6WrJRztijs/JcpY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-5jPZbsV8P0GUuj6YG1SU7g-1; Thu,
 22 Feb 2024 10:05:58 -0500
X-MC-Unique: 5jPZbsV8P0GUuj6YG1SU7g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D3CF42825BA9;
	Thu, 22 Feb 2024 15:05:57 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3C8A7111D3D9;
	Thu, 22 Feb 2024 15:05:57 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	George Stark <gnstark@salutedevices.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v2 4/4] locking/rwsem: Make DEBUG_RWSEMS and PREEMPT_RT mutually exclusive
Date: Thu, 22 Feb 2024 10:05:40 -0500
Message-Id: <20240222150540.79981-5-longman@redhat.com>
In-Reply-To: <20240222150540.79981-1-longman@redhat.com>
References: <20240222150540.79981-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

The debugging code enabled by CONFIG_DEBUG_RWSEMS will only be
compiled in when CONFIG_PREEMPT_RT isn't set. There is no point to
allow CONFIG_DEBUG_RWSEMS to be set in a kernel configuration where
CONFIG_PREEMPT_RT is also set. Make them mutually exclusive.

Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
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


