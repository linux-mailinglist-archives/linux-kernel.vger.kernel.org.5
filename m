Return-Path: <linux-kernel+bounces-160820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 060DD8B4349
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 02:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5FA62834F2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188CF2D627;
	Sat, 27 Apr 2024 00:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Nm5yyRv3"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A7D2577B
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 00:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714178267; cv=none; b=azwWRG8Da2LcVUd5jqlbW25YFek6pzk4hhGirJuJMM2+mtLm9aYYe/zzheB8hpQH4ESgO1gQGYNVb3cPyDrKxohQ5ZNQIi1hom3B15LJW8PqQsSc0+LYVmdahF35sA8ep/iI3jaK0ejSQR9yaAZfTfsAAL02jMZR4iAMYQFg49o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714178267; c=relaxed/simple;
	bh=tJK4g+poJ9VBpRehNiwwG1ZwM1nTxzq5jA9+UhY0/zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GgBcGdFGOHHsEYRpnhJ69VeN807mIMgJiM5VMAHve6EOflh18aImACHgChxzHjgeQR846Gi1X6FtsNitQclqN2l9L5lXwi6JVEyfdkBsOLnI/ZQJ6G9Pmh4t7V9jeiytMICmXpoXvS1QpnnwzFIqQ6SFP5tIS7V8LC9l1569MDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Nm5yyRv3; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714178263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gfv3iMSIWQC4QbQ/6GXaLS8Cjd7JxtChDyD5rQgDX9Q=;
	b=Nm5yyRv30txwaGJ50+RpR3dkkQIdU/cAkah0rz5E9NaWS6JEnqIlf8pCbX0XdNDBFnxc6N
	Hbz4uF6xZb+psVAA6G6MVW0R9CvKnIaxzNY6sPTfTQEuMd3bY+WiOBBBHx+n4a1jgGVc7m
	SpP+ZPeUku+xQYxxAw2TOWgKmw/JcxQ=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] memcg: reduce memory size of mem_cgroup_events_index
Date: Fri, 26 Apr 2024 17:37:27 -0700
Message-ID: <20240427003733.3898961-2-shakeel.butt@linux.dev>
In-Reply-To: <20240427003733.3898961-1-shakeel.butt@linux.dev>
References: <20240427003733.3898961-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

mem_cgroup_events_index is a translation table to get the right index of
the memcg relevant entry for the general vm_event_item. At the moment,
it is defined as integer array. However on a typical system the max
entry of vm_event_item (NR_VM_EVENT_ITEMS) is 113, so we don't need to
use int as storage type of the array. For now just use int8_t as type
and add a BUILD_BUG_ON() and will switch to short once NR_VM_EVENT_ITEMS
touches 127.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 602ad5faad4d..53769d06053f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -607,11 +607,14 @@ static const unsigned int memcg_vm_event_stat[] = {
 };
 
 #define NR_MEMCG_EVENTS ARRAY_SIZE(memcg_vm_event_stat)
-static int mem_cgroup_events_index[NR_VM_EVENT_ITEMS] __read_mostly;
+static int8_t mem_cgroup_events_index[NR_VM_EVENT_ITEMS] __read_mostly;
 
 static void init_memcg_events(void)
 {
-	int i;
+	int8_t i;
+
+	/* Switch to short once this failure occurs. */
+	BUILD_BUG_ON(NR_VM_EVENT_ITEMS >= 127 /* INT8_MAX */);
 
 	for (i = 0; i < NR_MEMCG_EVENTS; ++i)
 		mem_cgroup_events_index[memcg_vm_event_stat[i]] = i + 1;
-- 
2.43.0


