Return-Path: <linux-kernel+bounces-133875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F1589AA30
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 11:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 668EB1C209ED
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 09:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475833BBE5;
	Sat,  6 Apr 2024 09:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="FKZhXKdn"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3DF3FBA7
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 09:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712395238; cv=none; b=nGgMTJkrUlHY6ge3AuWet/yU1xQHobiFxRJlABe+o5FdobU0M4bLtWjgsxRMku7gO2psbUJmKSjWtI1Tuz1O6FAMpn8yNbVqY9oq/rtUGx1sbPxOcX56Lh8CprycOAFqFEdSba105Mfmi8LXM4LJa2Ua+gwxh3eVuSjQuEx03cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712395238; c=relaxed/simple;
	bh=WxyORd5UGrvrhH3ovdgj29XhigFycIY9JFgRu0PCY/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=euU0/XDUC154CLEZ1NCKG6FZbHQn/nT/DagKp6vnx0UCJ9xwW+gzBlxSnA9rfiAdead5XWWesyF630VcbyQPUUFkm7BKMy8x2a4UNSS1/hWcFnF4NVIjA5haKeszhlYslZMpU+V/EaMm3Y2WFfINC66+s6XehiKnybO7CqNymDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=FKZhXKdn; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A280E3FE67
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 09:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1712395224;
	bh=OGumsLBWYsNiBqaQkxgfB4Yj3V+oiBGI9bnDO7L7IE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=FKZhXKdnqeowQv0waOcRef6TIIWf8DZwwosHupqS/iFa0vVTAGbEHCWCBtimSKvST
	 LBPjTWRoyQY2QzJTLSn7yJBpJN3DhtxLk55ZGLwkJwyReZyeTNp75LjFMcbtX/GX9t
	 yR6GkLOcv/IzneyAGtsEj0QERz1OqLqGNiHTRjwi7ie+H+Kl5hk2bNc8bz3YQ1dlzt
	 kYC7fTsAtQ9c4/gm5G3506V0n0Qmw+ecMFxCUsIzAqlqi2xdshQ4fhh9GU9cC6TmTk
	 ZBRnppVTi/dXkPvzH6/4fgvKYmADevchJc3XjNlbkpqQyl28pNA4voUUP+arFiZ/mA
	 yTm7FRUygKDkQ==
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-41645ed539eso17365e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2024 02:20:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712395218; x=1713000018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OGumsLBWYsNiBqaQkxgfB4Yj3V+oiBGI9bnDO7L7IE8=;
        b=JkIn0YovjCFS6M2D8xuire09WPoQ06/blfINzCUlbZUjQsh2U4CsmS/qX6V+FpqXYh
         rOV/tQn0nup7lmJGqAbt6B1FrDHdEb8S3u5ShHggZXigT60g15g5Y3jt1p5X6ajLXD4N
         vKtuvAcRhk9bzOxUFCXxLlckx+pj3aLMY413oqHVS2lJ4nZ3BRHArqwZ+L71Qwru+SZl
         kIuO1goAkoCSEc9bTKJWAL0sUlSAUK4rMon0IMPIuHiv45LPYYlclDY0VA9bZ4KLIZkQ
         bW2ILtJQXFdDmwE0PbqHcJyV1nf7GcxwzEeqjJsEkNnsWCjgqQhkFrEjtuqrx4YZIefi
         HiWA==
X-Forwarded-Encrypted: i=1; AJvYcCVpsZM5TOzHbQg67opfkcnL6zxQl503iMexwGZ0JDMFeUTDEd5swy9Vw7Ko4EG4ztThZ9M7VzN06v+rLWYvjxDNVWO7VZkFpHj0YjIb
X-Gm-Message-State: AOJu0YzWCTTKPj8Tj6nXHVzIaIsJ7JO0AXxPjfc+aTYVZFdJQxk74/8+
	ZaxTnqpNymzSFNRP0e9nzaPQ0erGgSzGSiXHe/DvC2PDoXuvXQoWJscqfeTNDHG/XYR3znwJjZN
	CNC+8wBsYUh/TR2j0tAI1K2+HcQaVcHJ1aGvTJrrSW0PW61BxIMqiklr2Uytpy9a38MLv5MikP8
	7EuA==
X-Received: by 2002:a05:600c:4e8c:b0:415:6728:a584 with SMTP id f12-20020a05600c4e8c00b004156728a584mr2494541wmq.25.1712395217760;
        Sat, 06 Apr 2024 02:20:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNXztDhLsiKAKWeuFLp95WeOaSFimKeT6ittgqyCRbNIAyGvgIZJkAN7068+uWqmdKvBO5fg==
X-Received: by 2002:a05:600c:4e8c:b0:415:6728:a584 with SMTP id f12-20020a05600c4e8c00b004156728a584mr2494512wmq.25.1712395217054;
        Sat, 06 Apr 2024 02:20:17 -0700 (PDT)
Received: from gpd.station (net-2-39-142-110.cust.vodafonedsl.it. [2.39.142.110])
        by smtp.gmail.com with ESMTPSA id l23-20020a7bc457000000b00414924f307csm5779993wmi.26.2024.04.06.02.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 02:20:16 -0700 (PDT)
From: Andrea Righi <andrea.righi@canonical.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/4] libbpf: Add ring__consume_n / ring_buffer__consume_n
Date: Sat,  6 Apr 2024 11:15:43 +0200
Message-ID: <20240406092005.92399-4-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240406092005.92399-1-andrea.righi@canonical.com>
References: <20240406092005.92399-1-andrea.righi@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new API to consume items from a ring buffer, limited to a
specified amount, and return to the caller the actual number of items
consumed.

Link: https://lore.kernel.org/lkml/20240310154726.734289-1-andrea.righi@canonical.com/T
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 tools/lib/bpf/libbpf.h   | 12 ++++++++++++
 tools/lib/bpf/libbpf.map |  3 +++
 tools/lib/bpf/ringbuf.c  | 38 +++++++++++++++++++++++++++++++++++---
 3 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index f88ab50c0229..4f775a6dcaa0 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1293,6 +1293,7 @@ LIBBPF_API int ring_buffer__add(struct ring_buffer *rb, int map_fd,
 				ring_buffer_sample_fn sample_cb, void *ctx);
 LIBBPF_API int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms);
 LIBBPF_API int ring_buffer__consume(struct ring_buffer *rb);
+LIBBPF_API int ring_buffer__consume_n(struct ring_buffer *rb, size_t n);
 LIBBPF_API int ring_buffer__epoll_fd(const struct ring_buffer *rb);
 
 /**
@@ -1367,6 +1368,17 @@ LIBBPF_API int ring__map_fd(const struct ring *r);
  */
 LIBBPF_API int ring__consume(struct ring *r);
 
+/**
+ * @brief **ring__consume_n()** consumes up to a requested amount of items from
+ * a ringbuffer without event polling.
+ *
+ * @param r A ringbuffer object.
+ * @param n Maximum amount of items to consume.
+ * @return The number of items consumed, or a negative number if any of the
+ * callbacks return an error.
+ */
+LIBBPF_API int ring__consume_n(struct ring *r, size_t n);
+
 struct user_ring_buffer_opts {
 	size_t sz; /* size of this struct, for forward/backward compatibility */
 };
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 5dd81a7b96b5..23d82bba021a 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -418,4 +418,7 @@ LIBBPF_1.4.0 {
 } LIBBPF_1.3.0;
 
 LIBBPF_1.5.0 {
+	global:
+		ring__consume_n;
+		ring_buffer__consume_n;
 } LIBBPF_1.4.0;
diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index 2c4031168413..19cd34883011 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -277,6 +277,33 @@ static int64_t ringbuf_process_ring(struct ring *r, size_t n)
 	return cnt;
 }
 
+/* Consume available ring buffer(s) data without event polling, up to n
+ * records.
+ *
+ * Returns number of records consumed across all registered ring buffers (or
+ * n, whichever is less), or negative number if any of the callbacks return
+ * error.
+ */
+int ring_buffer__consume_n(struct ring_buffer *rb, size_t n)
+{
+	int64_t err, res = 0;
+	int i;
+
+	for (i = 0; i < rb->ring_cnt; i++) {
+		struct ring *ring = rb->rings[i];
+
+		err = ringbuf_process_ring(ring, n);
+		if (err < 0)
+			return libbpf_err(err);
+		res += err;
+		n -= err;
+
+		if (n == 0)
+			break;
+	}
+	return res;
+}
+
 /* Consume available ring buffer(s) data without event polling.
  * Returns number of records consumed across all registered ring buffers (or
  * INT_MAX, whichever is less), or negative number if any of the callbacks
@@ -378,17 +405,22 @@ int ring__map_fd(const struct ring *r)
 	return r->map_fd;
 }
 
-int ring__consume(struct ring *r)
+int ring__consume_n(struct ring *r, size_t n)
 {
-	int64_t res;
+	int res;
 
-	res = ringbuf_process_ring(r, INT_MAX);
+	res = ringbuf_process_ring(r, n);
 	if (res < 0)
 		return libbpf_err(res);
 
 	return res > INT_MAX ? INT_MAX : res;
 }
 
+int ring__consume(struct ring *r)
+{
+	return ring__consume_n(r, INT_MAX);
+}
+
 static void user_ringbuf_unmap_ring(struct user_ring_buffer *rb)
 {
 	if (rb->consumer_pos) {
-- 
2.43.0


