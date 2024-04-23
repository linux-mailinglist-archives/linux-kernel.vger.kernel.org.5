Return-Path: <linux-kernel+bounces-154466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DCF8ADC5A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 05:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FD33281EC0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 03:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E07225D7;
	Tue, 23 Apr 2024 03:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Sf7wDfjX"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64683224EF
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 03:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713843692; cv=none; b=s9NyCWg0C0rnHeCP97rjUNepn2DuJJHZnHs5TAXlowED0g25vsWRzgaM8a4YRuK8pSHckORdT6ApGIAX+PF1bM6g6Nkx+h/YJjIUVHQQbeRN3UqYfSuYKbeEF9SR8nn8QFSWlq4xzHMcPiBYOepmmIZghpSwNB7QuEnnsGEzJDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713843692; c=relaxed/simple;
	bh=T2mh8rRfGjxk++iQjwyZbxgJDDwtHaHq4Lo1WcLQsh8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kgnpSk6upBUDAgQTzamB9n033ArX357MJ7rGiDQotRaZsr5hVRKxRo2qfmmO/cQ4nx6jPEPf/sX6ZKUBuiz6u/mfi7SadkMbWbgM2amgOWKVIcp6tUgXKIA1LUxAOhwf1lGC1Ay+jHpF+w6sq+bMQW8cPJZu21dN8w2+xLjvwVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Sf7wDfjX; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ee0642f718so4301848b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 20:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713843690; x=1714448490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0uuoQxJ0kINjaQgEP7wqVGQ+5rr3s87tkW4G+81Ziw=;
        b=Sf7wDfjXTjkUIcH39MDLDCX6rPMe7ProY+HtT7tUlsJ59wnIxBr7OCMPfIR2ZQkF/q
         HPRvZYtyJjOR017eFw0SNYGHHNuDNGdjRylt/8gZA2KfGNgVkky26CbrteXMW8g62EsY
         HyzBgDL5esMWYiaNQsdlBcawBZFiLzjJg2jISCylaccXQ/nlEm2GoifQ8uZ64jWPyh5Q
         6DszFf9rUiWYMunZF4j0yMjbcvhmol38XY6wMkdt7bilZt0k7go/1pDBImalHqB4qETE
         Y344O+5eEO1+A1+OMieuvPTt9GNXM5ZpFfubF3SOlmunf3+Zvm3jmopxkSa1TEus7asO
         DBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713843690; x=1714448490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0uuoQxJ0kINjaQgEP7wqVGQ+5rr3s87tkW4G+81Ziw=;
        b=nOwfdz3KrzP84tYVVtjWEwdZF0tVyzxt/jAD1WqWUMXJBuO40lRyVj+YYPHtFlcq2F
         RF99S5icNyZPqk7HXZK/MCgdkcUbfu5Lu+auYVGrboMJd8SdVcYQReQdXlsh4ge8F3gx
         RisbrS4yV3kNNmG9ylwSdqsw5LWsKU5uY1FHNJ4MFil2rbWWBQcirGOdFYZiJu3kI4OA
         kMMdc5sz60+92oYL/ijPndCnfwUdzhCIQKLjW2/yIt0fGzZmwfk/u2krRhYUwkrrxfxv
         newl+Mr7ew0ebXlrVtj0SSH9UmrfAEL6dnErp/H0I4cMUnPAfsFeH4Ao42yITILA8IqM
         LHTg==
X-Gm-Message-State: AOJu0YweFG7CHUmMmtdF09cb2Wboj9LBtyfn9gMEB4+f1bXwmKQurX1+
	07c53mPIZY7tPQx9Wyuy9B/zIhCVQxqsiVLeHWkd8Df0jQbF0SrIwdmWiieemVKnMdDSSma84aY
	J
X-Google-Smtp-Source: AGHT+IH3OpN2sFYi3GvJfqyxhabzuW3WUwrv+oQUG4aXzn7ZEeGp3bOQixCyYcifZfO95/rYrfTxJA==
X-Received: by 2002:a05:6a20:841b:b0:1a9:54fe:b9b7 with SMTP id c27-20020a056a20841b00b001a954feb9b7mr2176395pzd.21.1713843690300;
        Mon, 22 Apr 2024 20:41:30 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id b16-20020a63d810000000b005e438fe702dsm8266980pgh.65.2024.04.22.20.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 20:41:30 -0700 (PDT)
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
Subject: [PATCH v3 4/4] virtio_balloon: introduce memory scan/reclaim info
Date: Tue, 23 Apr 2024 11:41:09 +0800
Message-Id: <20240423034109.1552866-5-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423034109.1552866-1-pizhenwei@bytedance.com>
References: <20240423034109.1552866-1-pizhenwei@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expose memory scan/reclaim information to the host side via virtio
balloon device.

Now we have a metric to analyze the memory performance:

y: counter increases
n: counter does not changes
h: the rate of counter change is high
l: the rate of counter change is low

OOM: VIRTIO_BALLOON_S_OOM_KILL
STALL: VIRTIO_BALLOON_S_ALLOC_STALL
ASCAN: VIRTIO_BALLOON_S_SCAN_ASYNC
DSCAN: VIRTIO_BALLOON_S_SCAN_DIRECT
ARCLM: VIRTIO_BALLOON_S_RECLAIM_ASYNC
DRCLM: VIRTIO_BALLOON_S_RECLAIM_DIRECT

- OOM[y], STALL[*], ASCAN[*], DSCAN[*], ARCLM[*], DRCLM[*]:
  the guest runs under really critial memory pressure

- OOM[n], STALL[h], ASCAN[*], DSCAN[l], ARCLM[*], DRCLM[l]:
  the memory allocation stalls due to cgroup, not the global memory
  pressure.

- OOM[n], STALL[h], ASCAN[*], DSCAN[h], ARCLM[*], DRCLM[h]:
  the memory allocation stalls due to global memory pressure. The
  performance gets hurt a lot. A high ratio between DRCLM/DSCAN shows
  quite effective memory reclaiming.

- OOM[n], STALL[h], ASCAN[*], DSCAN[h], ARCLM[*], DRCLM[l]:
  the memory allocation stalls due to global memory pressure.
  the ratio between DRCLM/DSCAN gets low, the guest OS is thrashing
  heavily, the serious case leads poor performance and difficult
  trouble shooting. Ex, sshd may block on memory allocation when
  accepting new connections, a user can't login a VM by ssh command.

- OOM[n], STALL[n], ASCAN[h], DSCAN[n], ARCLM[l], DRCLM[n]:
  the low ratio between ARCLM/ASCAN shows that the guest tries to
  reclaim more memory, but it can't. Once more memory is required in
  future, it will struggle to reclaim memory.

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/virtio/virtio_balloon.c     |  9 +++++++++
 include/uapi/linux/virtio_balloon.h | 12 ++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index e6229e548832..225662358221 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -340,6 +340,15 @@ static inline unsigned int update_balloon_vm_stats(struct virtio_balloon *vb)
 
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_ALLOC_STALL, stall);
 
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_ASYNC_SCAN,
+		    pages_to_bytes(events[PGSCAN_KSWAPD]));
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_DIRECT_SCAN,
+		    pages_to_bytes(events[PGSCAN_DIRECT]));
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_ASYNC_RECLAIM,
+		    pages_to_bytes(events[PGSTEAL_KSWAPD]));
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_DIRECT_RECLAIM,
+		    pages_to_bytes(events[PGSTEAL_DIRECT]));
+
 #ifdef CONFIG_HUGETLB_PAGE
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_HTLB_PGALLOC,
 		    events[HTLB_BUDDY_PGALLOC]);
diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index 487b893a160e..ee35a372805d 100644
--- a/include/uapi/linux/virtio_balloon.h
+++ b/include/uapi/linux/virtio_balloon.h
@@ -73,7 +73,11 @@ struct virtio_balloon_config {
 #define VIRTIO_BALLOON_S_HTLB_PGFAIL   9  /* Hugetlb page allocation failures */
 #define VIRTIO_BALLOON_S_OOM_KILL      10 /* OOM killer invocations */
 #define VIRTIO_BALLOON_S_ALLOC_STALL   11 /* Stall count of memory allocatoin */
-#define VIRTIO_BALLOON_S_NR       12
+#define VIRTIO_BALLOON_S_ASYNC_SCAN    12 /* Amount of memory scanned asynchronously */
+#define VIRTIO_BALLOON_S_DIRECT_SCAN   13 /* Amount of memory scanned directly */
+#define VIRTIO_BALLOON_S_ASYNC_RECLAIM 14 /* Amount of memory reclaimed asynchronously */
+#define VIRTIO_BALLOON_S_DIRECT_RECLAIM 15 /* Amount of memory reclaimed directly */
+#define VIRTIO_BALLOON_S_NR       16
 
 #define VIRTIO_BALLOON_S_NAMES_WITH_PREFIX(VIRTIO_BALLOON_S_NAMES_prefix) { \
 	VIRTIO_BALLOON_S_NAMES_prefix "swap-in", \
@@ -87,7 +91,11 @@ struct virtio_balloon_config {
 	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-allocations", \
 	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-failures", \
 	VIRTIO_BALLOON_S_NAMES_prefix "oom-kills", \
-	VIRTIO_BALLOON_S_NAMES_prefix "alloc-stalls" \
+	VIRTIO_BALLOON_S_NAMES_prefix "alloc-stalls", \
+	VIRTIO_BALLOON_S_NAMES_prefix "async-scans", \
+	VIRTIO_BALLOON_S_NAMES_prefix "direct-scans", \
+	VIRTIO_BALLOON_S_NAMES_prefix "async-reclaims", \
+	VIRTIO_BALLOON_S_NAMES_prefix "direct-reclaims" \
 }
 
 #define VIRTIO_BALLOON_S_NAMES VIRTIO_BALLOON_S_NAMES_WITH_PREFIX("")
-- 
2.34.1


