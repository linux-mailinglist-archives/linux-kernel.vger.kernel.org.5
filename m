Return-Path: <linux-kernel+bounces-163671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C988B6E31
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3A2F1F2415A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DDC1C9ECC;
	Tue, 30 Apr 2024 09:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gwmu/Ds3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C471292CC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468765; cv=none; b=R5DepMcEXCgK19WNl275Jsh+7nRGyvC2/5Sdp/2fzY79MQ+4a6z03QtMUqj+MSYpdS40kolaIFOahW+nypUQIzIS0YJpeSv18y7mqYWUrPNqM1gIgmAWz9Gp2xTlAaVHt0k1cmYQ6+spyItwOvptUbWIiS3r/qzRBfWYuqLeiDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468765; c=relaxed/simple;
	bh=EhzmsmACDjSS2wF8AAU8jhpFiZPWOh++BLOw9/rEa+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kvX+dE0ORsfh7TsqvFOOQsykQUHcLxb2ZUTKyvqT4XaQkmx13spDmM/H6piD4x0LhpcdoMSQ7TeZFXkqEuCC66lVyIAEnjwM25W08sTlw2SdxfaXbV697lmaLcBi6hQzOpZFTKacX1sFLEUsHyv5ot1F9uV2533rog95iy3r+rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gwmu/Ds3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714468762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cr16UT0MedV0Vp3mwekrGAUra3AvoUK3dAixRbWR98k=;
	b=Gwmu/Ds3hZADpsk+ALtqwcO/q36/1wkxuGzjzpZDEAHWZBXbQEgebxj1oi2+x3FdrvlHHc
	74lHVOe35NAe9E2p4qvwbllMf/wufj6g1MEpqU5rKZA8LcvGjYLwAHw4V+vzX8O1NTJVxG
	YAbL3ueeAyGC9k2AGr4qtg7JStSZZ7E=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-1YdhBgv9NS6dWMlzMt85DQ-1; Tue,
 30 Apr 2024 05:19:19 -0400
X-MC-Unique: 1YdhBgv9NS6dWMlzMt85DQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 757ED3806738;
	Tue, 30 Apr 2024 09:19:18 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.193.247])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5220F40C5C2;
	Tue, 30 Apr 2024 09:19:16 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH v2 26/27] rcu: Update stray documentation references to rcu_dynticks_eqs_{enter, exit}()
Date: Tue, 30 Apr 2024 11:17:30 +0200
Message-ID: <20240430091740.1826862-27-vschneid@redhat.com>
In-Reply-To: <20240430091740.1826862-1-vschneid@redhat.com>
References: <20240430091740.1826862-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

rcu_dynticks_eqs_{enter, exit}() have been replaced by their
context-tracking counterparts since commit:

  171476775d32 ("context_tracking: Convert state to atomic_t")

Update the stray documentation references.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 .../RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst   | 4 ++--
 Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg  | 4 ++--
 Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg   | 4 ++--
 Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg       | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
index 0533814a1f69a..50fc99aba777f 100644
--- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
+++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
@@ -147,8 +147,8 @@ RCU read-side critical sections preceding and following the current
 idle sojourn.
 This case is handled by calls to the strongly ordered
 ``atomic_add_return()`` read-modify-write atomic operation that
-is invoked within ``rcu_dynticks_eqs_enter()`` at idle-entry
-time and within ``rcu_dynticks_eqs_exit()`` at idle-exit time.
+is invoked within ``ct_kernel_enter_state()`` at idle-entry
+time and within ``ct_kernel_exit_state()`` at idle-exit time.
 The grace-period kthread invokes ``rcu_watching_snap()`` and
 ``rcu_watching_changed_since()`` (both of which invoke
 an ``atomic_add_return()`` of zero) to detect idle CPUs.
diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg
index b57210ecd689e..c7d16b72f0973 100644
--- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg
+++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg
@@ -607,7 +607,7 @@
        font-weight="bold"
        font-size="192"
        id="text202-7-5-3-27-6"
-       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">rcu_dynticks_eqs_enter()</text>
+       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">ct_kernel_enter_state()</text>
     <text
        xml:space="preserve"
        x="3745.7725"
@@ -638,7 +638,7 @@
        font-weight="bold"
        font-size="192"
        id="text202-7-5-3-27-6-1"
-       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">rcu_dynticks_eqs_exit()</text>
+       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">ct_kernel_exit_state()</text>
     <text
        xml:space="preserve"
        x="3745.7725"
diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg
index bd2b33e05447f..bcb71714b4197 100644
--- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg
+++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg
@@ -977,7 +977,7 @@
        font-weight="bold"
        font-size="192"
        id="text202-7-5-3-27-6"
-       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">rcu_dynticks_eqs_enter()</text>
+       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">ct_kernel_enter_state()</text>
     <text
        xml:space="preserve"
        x="3745.7725"
@@ -1008,7 +1008,7 @@
        font-weight="bold"
        font-size="192"
        id="text202-7-5-3-27-6-1"
-       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">rcu_dynticks_eqs_exit()</text>
+       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">ct_kernel_exit_state()</text>
     <text
        xml:space="preserve"
        x="3745.7725"
diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
index 8ece2b559bd35..e110b0ac74ffe 100644
--- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
+++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
@@ -3107,7 +3107,7 @@
          font-weight="bold"
          font-size="192"
          id="text202-7-5-3-27-6"
-         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">rcu_dynticks_eqs_enter()</text>
+         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">ct_kernel_enter_state()</text>
       <text
          xml:space="preserve"
          x="3745.7725"
@@ -3138,7 +3138,7 @@
          font-weight="bold"
          font-size="192"
          id="text202-7-5-3-27-6-1"
-         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">rcu_dynticks_eqs_exit()</text>
+         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">ct_kernel_exit_state()</text>
       <text
          xml:space="preserve"
          x="3745.7725"
-- 
2.43.0


