Return-Path: <linux-kernel+bounces-152891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 422C18AC5D0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68D5B1C2104B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265D350283;
	Mon, 22 Apr 2024 07:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TajcPByk"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3CF502A4
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 07:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713771794; cv=none; b=YKiLS1zcRMcUPrJO4k2GNqCmDpypFXkK5VHcu87+N3JsYpdQKBWLA2YITbXP+vpaLjhQKZmjKGnrEU2gurrBWrah143symwUIEcKG3u3ahh3TmMsIO9uaUS8STV/CKofY60htFvpugZUvI65hLF7FVD252pUCknx6WBmxvUt8oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713771794; c=relaxed/simple;
	bh=Tifl00pi8az9qD8WZxeEmmg/browFVnK/hcBZYXoc2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uMPuZmtHFfULP5xXzQJCG/A0A6bPdqtPCRty6oIH6wyFr3nSf3BCm/9cvjX+pkOpPgDXEjVMf1tHbSm8xqMQN0IKGto0Q5FFQilYT5IDmjagvpf9i4xv+ldcM+8wjZPcIxUzkbMT7Iz7yKtaULXHg82uaesQcxEwIIXkqfIlOmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=TajcPByk; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e2bbc2048eso33640975ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 00:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713771792; x=1714376592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zrl4akKhVgEJxLJYwq5+gLRsb/mo5Xi0vTQ5EYuojH0=;
        b=TajcPBykzMV0eL9dLEJzwK4tSkjkhUlb+1GJCEKbUfsiz9/1tFOGOSQdyIRkrK6EwR
         N8uJW6oXfym0FiLE7W3mnioTQMVWIrONt3kBEgH5pCY042GKYJ7hsQ+amXmAAqrqk9pj
         rbIo3S2z2oiTEUV3pGQiqEsZ6S8v1UYYxZWDa4+xQaBMa4oDODNgMjOAaq7GquZZHTu/
         wGUN/f/A3ikRl4r9ZC65b9mH6CAl8kdwhIFT5eLhruReXkT2ta3qfe2cwrcDD5PQZRsn
         5+xZFV/vJqfWyPR1/Rx6IOHdJWF6ozeqhqYIpylPpqBoKVenns5kqBTreMataC1zSKpf
         BDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713771792; x=1714376592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zrl4akKhVgEJxLJYwq5+gLRsb/mo5Xi0vTQ5EYuojH0=;
        b=l6FAy8Moa4dmnTJaeInt5fMZgY950t00VQSjEvMvVgnXoQr0yitS5goK25Iydc5PdW
         zUYk1bMUWOPL4WBNhQc4+n6BVBQBN1G2m80KQVWAN4Fn9lWp9XUsPbE3c8PYVCuvXcym
         tixKvUH+knCEBxQxhk9fxXBf58GC9rBN+tBNcvyKmOKeGo9tkLCQebKN0XsRvIASYgI6
         brLWXh2Yv8IxWEkT/zE1oYtYtGJD3BYmwrZ5QI0xTIlEzZ15QJUGTn2YTUsvW0+BW/rL
         AyRBM0x5rpf2eU07OAbIs/IqEvsKhn2TwLs54XVuInkx1+3BqCH7GFg0lMHA3CKCmrCw
         RYNg==
X-Gm-Message-State: AOJu0YzFljzxaPRDY10FHBlzV19HU7sqMvse7IGZ2tRt9s/RoLA9Wnp4
	FOZJW1fddnha10qY9D6CVgj0VDA91WwRvWGJIprd9i38IczEUNDzywxFK/eTZWqhzH5AxoW2mw3
	a
X-Google-Smtp-Source: AGHT+IEc9oEJpvxbLzrOG8tkIAbOFSv29i67Gv0xrVCixugzuwunQk9IqJOdyb3sAb6X7Uc5rZD22A==
X-Received: by 2002:a17:902:db07:b0:1e4:bd90:f1d4 with SMTP id m7-20020a170902db0700b001e4bd90f1d4mr11064583plx.40.1713771792141;
        Mon, 22 Apr 2024 00:43:12 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id e11-20020a170902784b00b001e0bae4490fsm7595634pln.154.2024.04.22.00.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 00:43:11 -0700 (PDT)
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
Subject: [PATCH v2 3/4] virtio_balloon: introduce memory allocation stall counter
Date: Mon, 22 Apr 2024 15:42:53 +0800
Message-Id: <20240422074254.1440457-4-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240422074254.1440457-1-pizhenwei@bytedance.com>
References: <20240422074254.1440457-1-pizhenwei@bytedance.com>
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
 drivers/virtio/virtio_balloon.c     | 8 ++++++++
 include/uapi/linux/virtio_balloon.h | 6 ++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 87a1d6fa77fb..ab039e83bc6f 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -323,6 +323,8 @@ static inline unsigned int update_balloon_vm_stats(struct virtio_balloon *vb,
 #ifdef CONFIG_VM_EVENT_COUNTERS
 	unsigned long events[NR_VM_EVENT_ITEMS];
 	unsigned int idx = start;
+	unsigned int zid;
+	unsigned long stall = 0;
 
 	all_vm_events(events);
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_SWAP_IN,
@@ -333,6 +335,12 @@ static inline unsigned int update_balloon_vm_stats(struct virtio_balloon *vb,
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_MINFLT, events[PGFAULT]);
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_OOM_KILL, events[OOM_KILL]);
 
+	/* sum all the stall events */
+	for (zid = 0; zid < MAX_NR_ZONES; zid++)
+		stall += events[ALLOCSTALL_NORMAL - ZONE_NORMAL + zid];
+
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


