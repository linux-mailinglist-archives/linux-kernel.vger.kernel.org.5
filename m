Return-Path: <linux-kernel+bounces-76743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D275185FBD9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70B1B1F25017
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC94C14C5B5;
	Thu, 22 Feb 2024 15:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dy+8yo4f"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A61F14A4E4
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 15:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708614363; cv=none; b=FYrhtBuiiX1TsmiPeWrTPDBhvrxjY7rcqc0TLdKqSQ4UXnifddznC9PSvPDtB2JBxza9I/RhPpJ9SI33Omjd4JzuwlrIdZqrC+hw/A8FuhWTrC1dSdYcT2Q4YL9Xrnx0fC5QYmGNXvQ1Zuu9YIRSCMV1cg9fXGV4fEDputf2mpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708614363; c=relaxed/simple;
	bh=aeHOJ9iVML/y8GMo8hBUeh/YCn/T6DMQYpgqNzuH3qU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cu5lFWwiswhxYB2KK4OEes00z1Oxm2Y6QOTSv1n/QkwdZp9ipihMW2FfT5xV8rmVAfIvzSL7AZ+kIhF1TOgYvpEr8RSITMMuOV+JCzGDROzSRKk6WR7p04X8WAAhpI7P2f/pczrIhSq3kV2EAfRZyto59sCGay0Wjdh2B3ExuQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dy+8yo4f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708614360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6lp5EbVDsr1293Y0XjQkZX4GDQn3K20EV4dIoRAKwfs=;
	b=Dy+8yo4fq9Rs505jwyrO+V6EdUPqC03+FUV2XJPoxYaa7hJOLNTxbrsbsGb4dpbBe5OO4f
	8i8wO+Gw4BXkMifLW88VITSRsj1T7FFjcjZ6lLR+/k/DWvqih/H1hBuh1Sp52AwlOOnP3J
	KLCEy5VLHwUCN3qL4GaXO6zKBclCO80=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-yAZZfy9hOwm0hMk4P6CfWQ-1; Thu, 22 Feb 2024 10:05:56 -0500
X-MC-Unique: yAZZfy9hOwm0hMk4P6CfWQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C6B5E863E83;
	Thu, 22 Feb 2024 15:05:55 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1F208112131D;
	Thu, 22 Feb 2024 15:05:55 +0000 (UTC)
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
Subject: [PATCH v2 1/4] locking/qspinlock: Fix 'wait_early' set but not used warning
Date: Thu, 22 Feb 2024 10:05:37 -0500
Message-Id: <20240222150540.79981-2-longman@redhat.com>
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

When CONFIG_LOCK_EVENT_COUNTS is off, the wait_early variable will be
set but not used. This is expected. Recent compilers will not generate
wait_early code in this case.

Add the __maybe_unused attribute to wait_early for suppressing this
W=1 warning.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312260422.f4pK3f9m-lkp@intel.com/
Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
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


