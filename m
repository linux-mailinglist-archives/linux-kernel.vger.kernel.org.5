Return-Path: <linux-kernel+bounces-149578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BE28A9309
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 587F5B21CC8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68C86BFA7;
	Thu, 18 Apr 2024 06:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="FvohFNb8"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9309875801
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 06:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713421578; cv=none; b=RE24aHMZCAYA2kkSzbc/z58jFDFeUq60HoUn5Ry1rFfqEYyEjH+xW+ESQmVQpmF0apAmaaQcUMQrOnxUImt+pxqfnQZwlGES7M/kotLJsYKNb2zc+4Pj4SEK3YExF+mFZyRD8B1Ol+M+/9oBiK5ZSt/1JGGyK6qlNktFoVkW7lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713421578; c=relaxed/simple;
	bh=Xzbgih7B8aIf9LhXB1XHaCkjr0jHp8G/PviFgcyTSdE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bBL73AeDOyH03FprMnXXePwCWxj7F9WVv7AKb1Xsl3cLsbZdjcL4hKFwXtdPm6VGqHQrXY4fkRpCIaA3xS2kcqy+SVlsSi2QGf+9RqYwX3//0rF+3O0/Aw6xAYMq1TKSkuLtZDl1hZ48y3BUYpYHALvRLoupAVqe3pwLtd/Mid0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=FvohFNb8; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ecf1bb7f38so566242b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 23:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713421576; x=1714026376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLD61XepBARAsgwAEEryGhLKo22WgyhNR7D0Io1kaZU=;
        b=FvohFNb83f7um1yMuROvMcDV88ouDia5Lne4LUeEQ+AmptfrQ1G23pOFJiFWJ0igcw
         mxam4BjJin+ruGZ8L25N/X4tqMPLMS5vFaaP6OcwghpbwM04R9WiWlTifbDTGhDa42fw
         hQ3IXyVER6MQJiv2tOu/MGH0b2Xi6HhRJi/8u5ZHoLXTGvuYUsmnRD44JlcUJJbOfKv9
         uAafSp76FowJ577Vfrg7sYK2tLEjVHylHbQxs2QaKoEPZRfETId5noErNTS9s/+MpjWY
         zQV6gDziAtOl8P+A7gttFYWrjC2N5YxWnbbdwZj7qF9jmuxocSuT4nHPKHAfcuSpKN/U
         KVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713421576; x=1714026376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qLD61XepBARAsgwAEEryGhLKo22WgyhNR7D0Io1kaZU=;
        b=nurP1qk4y8FigIDstONJRlsMQtCriH4ENidDaKyjY+U/CduqskBELTzJ7KpXW+m7Fn
         PixhAfDUYfj92KBdV/vOBNExfPgnbNKJPSlUIX/c3SuvRp9MvAETnFh1Low2r1HBEI1i
         SHqnDD/xQKiAs2omMQ2UUTC37aCRTn2u2p3TXir11PKKnj6v6YTPE/dSCgJWNWhHjLD6
         gJYPb7Me56i9PSvMWJxZCAJd8JfqEf+C96pvveKwqoFI+muPiqvHMYFO0w3JWOCFHtkv
         f9Tr2WtcDdjkHdz9dhyx2/OzlQlMT+cLcCd0uIhtzRXhbowrpFJ2SHveuxSrBcbWkMZX
         68lg==
X-Gm-Message-State: AOJu0YyBY8QR5ngbI8ee80UWNuZmZhPWWgiHaVYQzGotabs3iByD4Ukv
	7WjQfjsKemRZBG9hRVbqHlCbvhOAvjuijbr5cfmpgEUPf3+iPVUG202ZcxceFDqSDq1nilXmSxU
	G
X-Google-Smtp-Source: AGHT+IExq7y1kqyqGXewPq6tqKPgeINzrgW8X9DzhXoz5Wq5smACLbcQzHv5/LkcKr/osJEn2qOGzg==
X-Received: by 2002:a05:6a20:9717:b0:1a9:dcd9:9756 with SMTP id hr23-20020a056a20971700b001a9dcd99756mr2120694pzc.16.1713421576513;
        Wed, 17 Apr 2024 23:26:16 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id s21-20020a632155000000b005cd8044c6fesm666392pgm.23.2024.04.17.23.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 23:26:16 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	virtualization@lists.linux.dev
Cc: mst@redhat.com,
	david@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	akpm@linux-foundation.org,
	zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 2/3] virtio_balloon: introduce memory allocation stall counter
Date: Thu, 18 Apr 2024 14:26:01 +0800
Message-Id: <20240418062602.1291391-3-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418062602.1291391-1-pizhenwei@bytedance.com>
References: <20240418062602.1291391-1-pizhenwei@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Memory allocation stall counter represents the performance/latency of
memory allocation, expose this counter to the host side by virtio
balloon device via out-of-bound way.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/virtio/virtio_balloon.c     | 20 +++++++++++++++++++-
 include/uapi/linux/virtio_balloon.h |  6 ++++--
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index fd19934a847f..e88e6573afa5 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -321,7 +321,7 @@ static unsigned int update_balloon_stats(struct virtio_balloon *vb)
 	unsigned long events[NR_VM_EVENT_ITEMS];
 	struct sysinfo i;
 	unsigned int idx = 0;
-	long available;
+	long available, stall = 0;
 	unsigned long caches;
 
 	all_vm_events(events);
@@ -338,6 +338,24 @@ static unsigned int update_balloon_stats(struct virtio_balloon *vb)
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_MAJFLT, events[PGMAJFAULT]);
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_MINFLT, events[PGFAULT]);
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_OOM_KILL, events[OOM_KILL]);
+
+	/* sum all the stall events */
+#ifdef CONFIG_ZONE_DMA
+	stall += events[ALLOCSTALL_DMA];
+#endif
+#ifdef CONFIG_ZONE_DMA32
+	stall += events[ALLOCSTALL_DMA32];
+#endif
+#ifdef CONFIG_HIGHMEM
+	stall += events[ALLOCSTALL_HIGH];
+#endif
+#ifdef CONFIG_ZONE_DEVICE
+	stall += events[ALLOCSTALL_DEVICE];
+#endif
+	stall += events[ALLOCSTALL_NORMAL];
+	stall += events[ALLOCSTALL_MOVABLE];
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_ALLOC_STALL, stall);
+
 #ifdef CONFIG_HUGETLB_PAGE
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_HTLB_PGALLOC,
 		    events[HTLB_BUDDY_PGALLOC]);
diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index b17bbe033697..487b893a160e 100644
--- a/include/uapi/linux/virtio_balloon.h
+++ b/include/uapi/linux/virtio_balloon.h
@@ -72,7 +72,8 @@ struct virtio_balloon_config {
 #define VIRTIO_BALLOON_S_HTLB_PGALLOC  8  /* Hugetlb page allocations */
 #define VIRTIO_BALLOON_S_HTLB_PGFAIL   9  /* Hugetlb page allocation failures */
 #define VIRTIO_BALLOON_S_OOM_KILL      10 /* OOM killer invocations */
-#define VIRTIO_BALLOON_S_NR       11
+#define VIRTIO_BALLOON_S_ALLOC_STALL   11 /* Stall count of memory allocatoin */
+#define VIRTIO_BALLOON_S_NR       12
 
 #define VIRTIO_BALLOON_S_NAMES_WITH_PREFIX(VIRTIO_BALLOON_S_NAMES_prefix) { \
 	VIRTIO_BALLOON_S_NAMES_prefix "swap-in", \
@@ -85,7 +86,8 @@ struct virtio_balloon_config {
 	VIRTIO_BALLOON_S_NAMES_prefix "disk-caches", \
 	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-allocations", \
 	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-failures", \
-	VIRTIO_BALLOON_S_NAMES_prefix "oom-kills" \
+	VIRTIO_BALLOON_S_NAMES_prefix "oom-kills", \
+	VIRTIO_BALLOON_S_NAMES_prefix "alloc-stalls" \
 }
 
 #define VIRTIO_BALLOON_S_NAMES VIRTIO_BALLOON_S_NAMES_WITH_PREFIX("")
-- 
2.34.1


