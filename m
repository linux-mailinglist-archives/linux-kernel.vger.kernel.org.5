Return-Path: <linux-kernel+bounces-1932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D44D815606
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 02:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3AEC1F2578D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9C91FBA;
	Sat, 16 Dec 2023 01:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cjCM8QpH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7483A3FFB
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 01:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702690644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KH7LHyJ+LsPwH+bGnDG9Wd9NgeRdlqn7GY3HTAJcVcY=;
	b=cjCM8QpHTDWi609uEE7DIKJZe8g0zJEt2fQJBgguZuL3Exe5GF6GSlpTvV3NgpKAwpb1Kd
	evMl5DhvAWstpIZrGhPo9U//KN67Y+llyWj2z77XGP4vPHWC/oRlfh3gypvSsSaSkF77D+
	W/r1bdmnuScydeG7THMUkn1KOPtKS0Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-sQYicR6GMrW7FqwSQg05cw-1; Fri, 15 Dec 2023 20:37:17 -0500
X-MC-Unique: sQYicR6GMrW7FqwSQg05cw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 55B3A101A551;
	Sat, 16 Dec 2023 01:37:17 +0000 (UTC)
Received: from llong.com (unknown [10.22.9.217])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DA72BC15968;
	Sat, 16 Dec 2023 01:37:16 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	George Stark <gnstark@salutedevices.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 2/2] locking/rwsem: Make DEBUG_RWSEMS and PREEMPT_RT mutually exclusive
Date: Fri, 15 Dec 2023 20:36:56 -0500
Message-Id: <20231216013656.1382213-2-longman@redhat.com>
In-Reply-To: <20231216013656.1382213-1-longman@redhat.com>
References: <20231216013656.1382213-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

The debugging code enabled by CONFIG_DEBUG_RWSEMS will only be
compiled in when CONFIG_PREEMPT_RT isn't set. There is no point to
allow CONFIG_DEBUG_RWSEMS to be set in a kernel configuration where
CONFIG_PREEMPT_RT is also set. Make them mutually exclusive.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 lib/Kconfig.debug | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index cc7d53d9dc01..2a95caa7e122 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1297,7 +1297,7 @@ config PROVE_LOCKING
 	select DEBUG_SPINLOCK
 	select DEBUG_MUTEXES if !PREEMPT_RT
 	select DEBUG_RT_MUTEXES if RT_MUTEXES
-	select DEBUG_RWSEMS
+	select DEBUG_RWSEMS if !PREEMPT_RT
 	select DEBUG_WW_MUTEX_SLOWPATH
 	select DEBUG_LOCK_ALLOC
 	select PREEMPT_COUNT if !ARCH_NO_PREEMPT
@@ -1420,7 +1420,7 @@ config DEBUG_WW_MUTEX_SLOWPATH
 
 config DEBUG_RWSEMS
 	bool "RW Semaphore debugging: basic checks"
-	depends on DEBUG_KERNEL
+	depends on DEBUG_KERNEL && !PREEMPT_RT
 	help
 	  This debugging feature allows mismatched rw semaphore locks
 	  and unlocks to be detected and reported.
-- 
2.39.3


