Return-Path: <linux-kernel+bounces-14564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCAC821EC3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 16:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40A931C22468
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6ADB14F6B;
	Tue,  2 Jan 2024 15:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hn8fH/uP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B277C14F60
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 15:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704209690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l7cJAVtsGBwI8CAm3+P2nm6XZa7AWaTasxy0hzTbhJY=;
	b=Hn8fH/uPSFTLHy8DLdt3yIPXQfjCkMhyazzbiVZo/F1trUlAW8TXr6nc+vRQ5uJtEG4QvF
	7k9RaSyl8UcoA5pup6DQQ4iXy+FyV3JzmL8VHlW0FvMOSYtPnl8AmmZ8GWayr009yOVZp4
	d00kTF4BXroIYDhep6UtmB94z3aVphQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-_no57yUUN92YAbajRY0xaw-1; Tue, 02 Jan 2024 10:34:49 -0500
X-MC-Unique: _no57yUUN92YAbajRY0xaw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CC7AA881F07;
	Tue,  2 Jan 2024 15:34:48 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.22.16.87])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9C9D02026F96;
	Tue,  2 Jan 2024 15:34:48 +0000 (UTC)
From: Chris von Recklinghausen <crecklin@redhat.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org
Cc: crecklin@redhat.com
Subject: [PATCH] don't record leak information on allocations done between kmemleak_init and kmemleak_late_init
Date: Tue,  2 Jan 2024 10:34:28 -0500
Message-ID: <20240102153428.139984-1-crecklin@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

If an object is allocated after kmemleak_init is called but before
kmemleak_late_init is called, calls to kmemleak_not_leak or
kmemleak_ignore on the object don't prevent a scan from reporting the
object as a leak.

Avoid this situation by only registering objects in kmemleak_alloc when
kmemleak_initialized is set.

Signed-off-by: Chris von Recklinghausen <crecklin@redhat.com>
---
 mm/kmemleak.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 5501363d6b31..0c8a5f456874 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1117,7 +1117,8 @@ void __ref kmemleak_free_part(const void *ptr, size_t size)
 {
 	pr_debug("%s(0x%px)\n", __func__, ptr);
 
-	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
+	if (kmemleak_enabled && kmemleak_late_initialized && ptr &&
+		!IS_ERR(ptr))
 		delete_object_part((unsigned long)ptr, size, false);
 }
 EXPORT_SYMBOL_GPL(kmemleak_free_part);
@@ -1135,7 +1136,8 @@ void __ref kmemleak_free_percpu(const void __percpu *ptr)
 
 	pr_debug("%s(0x%px)\n", __func__, ptr);
 
-	if (kmemleak_free_enabled && ptr && !IS_ERR(ptr))
+	if (kmemleak_free_enabled && kmemleak_late_initialized && ptr &&
+		!IS_ERR(ptr))
 		for_each_possible_cpu(cpu)
 			delete_object_full((unsigned long)per_cpu_ptr(ptr,
 								      cpu));
@@ -1189,7 +1191,8 @@ void __ref kmemleak_not_leak(const void *ptr)
 {
 	pr_debug("%s(0x%px)\n", __func__, ptr);
 
-	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
+	if (kmemleak_enabled && kmamleak_late_initialized && ptr &&
+		!IS_ERR(ptr))
 		make_gray_object((unsigned long)ptr);
 }
 EXPORT_SYMBOL(kmemleak_not_leak);
@@ -1207,7 +1210,8 @@ void __ref kmemleak_ignore(const void *ptr)
 {
 	pr_debug("%s(0x%px)\n", __func__, ptr);
 
-	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
+	if (kmemleak_enabled && kmamleak_late_initialized && ptr &&
+		!IS_ERR(ptr))
 		make_black_object((unsigned long)ptr, false);
 }
 EXPORT_SYMBOL(kmemleak_ignore);
-- 
2.43.0


