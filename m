Return-Path: <linux-kernel+bounces-154463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1215A8ADC54
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 05:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 042901C21AAB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 03:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972601CF92;
	Tue, 23 Apr 2024 03:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="eNp82nlB"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619F81CA82
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 03:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713843682; cv=none; b=rCDsvZ20i40GNLveR42fK+Ucvsvcb4Hb7JLp3oh/wZ2bd5Oy2exLjI1BeQ91/d9hCkM4DiPjpeUsMlXoy5+hmBuCr7R1A3415QelM9XEyQiWIAsbryNiin3/hJeuVOxGyiOqdKuhBUKTyfYFTVyGR7UADu/9oZzOIRAWeQUlGVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713843682; c=relaxed/simple;
	bh=iSysrDVuYXg0UMc79wYI1kULCvYs69ZhGh9/V1D5h+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AUz+4ZReggx4D+NfOGc8mhlI5oFQtZKbGpc0fhEZ5yFC5sIMf9c/zeCRGzHr9JRSCsrgcRKIKnKo6Wk4DLULRWmdke4zTkPsi4YgxSUXBWvXuZNaT+zL3Do9DZ7E5QR+KRPtlFp35vQICuy3eXfkAXRr3Xl3zKhoPir0kj6xh8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=eNp82nlB; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6ea26393116so3362132a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 20:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713843680; x=1714448480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KkBGMpzb7Zyfmx1ZstJgk5Op8ktl/5dFs5p8PlYlyX8=;
        b=eNp82nlBJNHzj3Yh79uzhq7zJoIKFlmg9pMmQWYf8K/RsEBOyR4ekwf0wM5i4sbX5d
         Z8nn9f7Uyay3jD5e2r5o3q61beKYFK7i95QtRx+9thKnACyVYU2k2XPSquyR9WdygDJR
         g2ajt8UTJ80rYf0dajsHKt2VPmjsD2MXdql1NI/k4oposkFxBH1jJqibNdZYB2JK3Xaa
         W8fxUD4eCsoAHQBchl49THouhe4lEr4AE9QSVqBV1m7ksV/YqkllmYTcz1/Ytp2NJzEs
         MFu0nzRkGk6iGKouEIDDrMmrw8bmib4qkviIwpgZT+n+HDkWgQB4OjzfbZ1/EyLfiTNq
         VP7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713843680; x=1714448480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KkBGMpzb7Zyfmx1ZstJgk5Op8ktl/5dFs5p8PlYlyX8=;
        b=B8KRJmSEvpNTE3sc6UhzxgvdCzVznFVw/i5Y48w3HJ+lfLHEgCbZA1OORMKX+fM5Oj
         2NYS8M0vXhyciT5QJdknis3RkrIjqAqtAjTvc37evFLqawtiDu4+6klcmvsQ69RX7UeT
         JWGwqjgtSSeX083nCWVBoUSfyDOLRXEZ2YkoFUH9ZzCoZApnYs2TQzNS2TcCKQlY7Njo
         hzllhMIpTbFI63ZRd29STBpITPEvQbU8Mxdu+4smZ81+jqCPxp0uNyyrdRAv5NPEhDHT
         kwqeFau63ddcLZXrXgZnVcGS9EzWx38uvIkfBMjOD80kGOysw4wIzivAUOv8ALJtpbmR
         coJg==
X-Gm-Message-State: AOJu0Yz1OLD3yhtitOr6jWBB62iiDvPMMGOPxfD4mNVmBKhKm7Kspr4v
	niusKmOiEF7aFXjCdyuxSpyVecz1ATfzCGXTLEp194BDFMSbMLtXfAhmM0WwUoFe09jFUd8Rc2U
	4
X-Google-Smtp-Source: AGHT+IFPWbPsOAgDjqPCg7khKs3ioBh3D8C//sMkXvFal/sejW6ukQN3/LZM7rjAVP3UsOTPrF/iBA==
X-Received: by 2002:a05:6830:4392:b0:6ed:686:b43 with SMTP id s18-20020a056830439200b006ed06860b43mr9633062otv.17.1713843680244;
        Mon, 22 Apr 2024 20:41:20 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id b16-20020a63d810000000b005e438fe702dsm8266980pgh.65.2024.04.22.20.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 20:41:19 -0700 (PDT)
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
Subject: [PATCH v3 1/4] virtio_balloon: separate vm events into a function
Date: Tue, 23 Apr 2024 11:41:06 +0800
Message-Id: <20240423034109.1552866-2-pizhenwei@bytedance.com>
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

All the VM events related statistics have dependence on
'CONFIG_VM_EVENT_COUNTERS', separate these events into a function to
make code clean. Then we can remove 'CONFIG_VM_EVENT_COUNTERS' from
'update_balloon_stats'.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/virtio/virtio_balloon.c | 43 ++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 1f5b3dd31fcf..1710e3098ecd 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -316,34 +316,49 @@ static inline void update_stat(struct virtio_balloon *vb, int idx,
 
 #define pages_to_bytes(x) ((u64)(x) << PAGE_SHIFT)
 
-static unsigned int update_balloon_stats(struct virtio_balloon *vb)
+#ifdef CONFIG_VM_EVENT_COUNTERS
+/* Return the number of entries filled by vm events */
+static inline unsigned int update_balloon_vm_stats(struct virtio_balloon *vb)
 {
 	unsigned long events[NR_VM_EVENT_ITEMS];
-	struct sysinfo i;
 	unsigned int idx = 0;
-	long available;
-	unsigned long caches;
 
 	all_vm_events(events);
-	si_meminfo(&i);
-
-	available = si_mem_available();
-	caches = global_node_page_state(NR_FILE_PAGES);
-
-#ifdef CONFIG_VM_EVENT_COUNTERS
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_SWAP_IN,
-				pages_to_bytes(events[PSWPIN]));
+		    pages_to_bytes(events[PSWPIN]));
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_SWAP_OUT,
-				pages_to_bytes(events[PSWPOUT]));
+		    pages_to_bytes(events[PSWPOUT]));
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_MAJFLT, events[PGMAJFAULT]);
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_MINFLT, events[PGFAULT]);
+
 #ifdef CONFIG_HUGETLB_PAGE
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_HTLB_PGALLOC,
 		    events[HTLB_BUDDY_PGALLOC]);
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_HTLB_PGFAIL,
 		    events[HTLB_BUDDY_PGALLOC_FAIL]);
-#endif
-#endif
+#endif /* CONFIG_HUGETLB_PAGE */
+
+	return idx;
+}
+#else /* CONFIG_VM_EVENT_COUNTERS */
+static inline unsigned int update_balloon_vm_stats(struct virtio_balloon *vb)
+{
+	return 0;
+}
+#endif /* CONFIG_VM_EVENT_COUNTERS */
+
+static unsigned int update_balloon_stats(struct virtio_balloon *vb)
+{
+	struct sysinfo i;
+	unsigned int idx;
+	long available;
+	unsigned long caches;
+
+	idx = update_balloon_vm_stats(vb);
+
+	si_meminfo(&i);
+	available = si_mem_available();
+	caches = global_node_page_state(NR_FILE_PAGES);
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_MEMFREE,
 				pages_to_bytes(i.freeram));
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_MEMTOT,
-- 
2.34.1


