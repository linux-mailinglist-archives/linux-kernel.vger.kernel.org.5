Return-Path: <linux-kernel+bounces-96061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD0E8756A8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA3CA281EF1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DC513664E;
	Thu,  7 Mar 2024 19:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="en0C+U7e"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E02137C5D
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 19:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709838363; cv=none; b=Nctkv3aAG8OuFxvXDNqgToTxyxPx8WLiYEWyePTkR9a/3jQIvD36k7T1y89Wm+mDv0BvT0XncXP8jfBfajjXrFP+BYL9XINFXCDBH4qD2QTIzT82XkkEtgHVQs8pO+WEybwfLBCaCeX8IzZsgRKDmBX9c3PJqy7uDUn/7mCtElY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709838363; c=relaxed/simple;
	bh=g6DAKDR36tOItH/bhG0Z9srSph8oii5Fydx/RihO+aE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZJjgGdDgHWx/9YmwSa7In7XGyeERYVIJzMKE0+DrVt5NsaqXfgIesvcfGUKV2J3s/22KL+bmZ0PhV+sXRFAt+xMMhj2Wcl8vytUignsBeiNLk6zU/sqcMkCnTeJgGgci2Ps0u4jdqdtPHuk2DcIAZ7K1smjSdrxpcKD650dzc7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=en0C+U7e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709838360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X7P8UeQpeEQEOjxcmff4v9+LPAL41neHMZQcXXo7jRE=;
	b=en0C+U7ekiy25FS4EAfpk0bnDLqgDV6eTcMfJPBXW6YKwtJENfWUXgdUbWTXnZ6quKlU38
	Y3eDIuOuCC7mKNIgnDZ8DBQUs+K6DkArC0R7H5gC5cZ24JpTJaMLF7jirq0/ANC/YCis/a
	kmHLum6uEH0KTyFRXOjJTtIw9JUYTqQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-Xf1BggqGN1iqaD3Ogzjweg-1; Thu,
 07 Mar 2024 14:05:56 -0500
X-MC-Unique: Xf1BggqGN1iqaD3Ogzjweg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD95B1C00B8B;
	Thu,  7 Mar 2024 19:05:55 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2CF7C2166AF0;
	Thu,  7 Mar 2024 19:05:55 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 1/2] mm/kmemleak: Compact kmemleak_object further
Date: Thu,  7 Mar 2024 14:05:47 -0500
Message-Id: <20240307190548.963626-2-longman@redhat.com>
In-Reply-To: <20240307190548.963626-1-longman@redhat.com>
References: <20240307190548.963626-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

With commit 56a61617dd22 ("mm: use stack_depot for recording kmemleak's
backtrace"), the size of kmemleak_object has been reduced by 128 bytes
for 64-bit arches. The replacement "depot_stack_handle_t trace_handle"
is actually just 4 bytes long leaving a hole of 4 bytes. By moving up
trace_handle to another existing 4-byte hold, we can save 8 more bytes
from kmemleak_object reducing its overall size from 248 to 240 bytes.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/kmemleak.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 4f58f6170cdf..0114a694e520 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -158,9 +158,9 @@ struct kmemleak_object {
 	int count;
 	/* checksum for detecting modified objects */
 	u32 checksum;
+	depot_stack_handle_t trace_handle;
 	/* memory ranges to be scanned inside an object (empty for all) */
 	struct hlist_head area_list;
-	depot_stack_handle_t trace_handle;
 	unsigned long jiffies;		/* creation timestamp */
 	pid_t pid;			/* pid of the current task */
 	char comm[TASK_COMM_LEN];	/* executable name */
-- 
2.39.3


