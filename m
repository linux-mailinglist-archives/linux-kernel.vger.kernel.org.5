Return-Path: <linux-kernel+bounces-106872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCB987F4C1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 01:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C92E2B2175A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DAB80B;
	Tue, 19 Mar 2024 00:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zs7UEoiR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26EB363
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 00:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710809456; cv=none; b=laFChGGNCGNjBR65PcCn5qg3/9RS7XM+z07/Eq5dbD1Ql+vBhPLrps89x6gfSB/DLmIfWq1OHM6yNaeMWbUTVlSOW0zMjF9PG2ciVbz4n5NiF5bq9Rm8XqD+28EWuiUCIVlViLUsbnFKvlQecezMciuj8bdfuxpPJ4I/f38G2DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710809456; c=relaxed/simple;
	bh=T2xYr/VrtWPcd5kQXh6hL6/nbNnJNAdr7tnOCwTsMho=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dKIFzKJqv4AzFdCaLzorwPrkdZj5PKFRvrL9UbpNO2UpboVKH6Pgj9kh7O5Px69sEMiuIYIAWHFtJyRisFzNVd1yofeSwAQa8VBA0djVp7YFq+PcaXMG/5flsTl3ms6og3IHmUCwpNc30PNsS8d6mZ7/rVj5/gHTsc+lwnrCT8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zs7UEoiR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710809453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4d6qJ5WBSXyvd5gKY/blIvNFMP9EdNN0VHAYdQgc4TA=;
	b=Zs7UEoiRdEHHorKDcaYFRWihBjZgDFFuS/GV+5YgFmB1TsfXxFYA1dXl1lqiI3KKjkstAH
	v2KqCIqkxPi65N4j/PjQPLs88kHX0L7qSA1faCxdfGTTcvnNmE+5pvrs4hyCrP5MqWkG3d
	C13dcnVxOg9GE8dX56HVdhYmklhEkxo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-23gRmf0LMTy0Iu58eDjqLg-1; Mon,
 18 Mar 2024 20:50:49 -0400
X-MC-Unique: 23gRmf0LMTy0Iu58eDjqLg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C870138009F1;
	Tue, 19 Mar 2024 00:50:48 +0000 (UTC)
Received: from llong.com (unknown [10.22.34.80])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 34B6C40C6DB5;
	Tue, 19 Mar 2024 00:50:48 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Waiman Long <longman@redhat.com>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] locking/qspinlock: Always evaluate lockevent* non-event parameter once
Date: Mon, 18 Mar 2024 20:50:04 -0400
Message-Id: <20240319005004.1692705-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

The inc parameter of lockevent_add() and the cond parameter of
lockevent_cond_inc() are only evaluated when CONFIG_LOCK_EVENT_COUNTS
is on. That can cause problem if those parameters are expressions
with side effect like a "++". Fix this by evaluating those non-event
parameters once even if CONFIG_LOCK_EVENT_COUNTS is off. This will also
eliminate the need of the __maybe_unused attribute to the wait_early
local variable in pv_wait_node().

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lock_events.h        | 4 ++--
 kernel/locking/qspinlock_paravirt.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/lock_events.h b/kernel/locking/lock_events.h
index a6016b91803d..d2345e9c0190 100644
--- a/kernel/locking/lock_events.h
+++ b/kernel/locking/lock_events.h
@@ -53,8 +53,8 @@ static inline void __lockevent_add(enum lock_events event, int inc)
 #else  /* CONFIG_LOCK_EVENT_COUNTS */
 
 #define lockevent_inc(ev)
-#define lockevent_add(ev, c)
-#define lockevent_cond_inc(ev, c)
+#define lockevent_add(ev, c)		do { (void)(c); } while (0)
+#define lockevent_cond_inc(ev, c)	do { (void)(c); } while (0)
 
 #endif /* CONFIG_LOCK_EVENT_COUNTS */
 
diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index ae2b12f68b90..169950fe1aad 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -294,7 +294,7 @@ static void pv_wait_node(struct mcs_spinlock *node, struct mcs_spinlock *prev)
 {
 	struct pv_node *pn = (struct pv_node *)node;
 	struct pv_node *pp = (struct pv_node *)prev;
-	bool __maybe_unused wait_early;
+	bool wait_early;
 	int loop;
 
 	for (;;) {
-- 
2.39.3


