Return-Path: <linux-kernel+bounces-133688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C40D789A75E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 00:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7C541C21282
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 22:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033F32D7B8;
	Fri,  5 Apr 2024 22:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="RMB+3U21"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C9B2D61A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 22:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712356579; cv=none; b=PJ3ZFVOgMsSVSbcIcfNvloKdEmDA9hN9EHxbRQx/MTVqdap07NEFCA1rPljO+UeXE/woIQ/KdjSutayms1pQpfSjpmTd3tv8bR0jDGtUZmei8EajT76cLxzkjYMQeWXLpdzaAmKsFeSQGJIIM9Ue3af6OVZDIrW57X/qydyLHvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712356579; c=relaxed/simple;
	bh=QMvCqoIxUJk4A3mQL/m6zq/lJ4o+BiC3MUzbNU4scZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UE7Hc07KAN9g3LBmOqrWjTuEY6cD91Cx3jofxjh1aTNnPfNGUfFBIHvbeBlXN81K1UF5nyLM1MMLhglyNNWrCbvIM7rsl9afwROUMg964BOQL9FBz9Wji2M14USxkVkIJpLp4cT5gAY5bllmHYD31r8+qoCIjVAEMn3VR5q6oo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=RMB+3U21; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C87F73FE5A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 22:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1712356573;
	bh=3VLnZHG6NMsFZ484LFX99y48PIsMB85l7TlShPfpb8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=RMB+3U21AiqEFB1hoLH7ZqM94SEut0BUv8OgHnCDw+g5No5+U5gMeDe98100Qkzoe
	 pVJ+0xs2Bx8zRucRW+P4t+eS8FX0vBHIUdf/bT6c18WI/KPubLAthJgg1W2vwx5592
	 ZiIu5N88Ywi0l4gnuOuQiMWFUvEJ677Ic+FHELjb4zw2J1GGIo1wqb+2Jz/a93fF4z
	 +D1FUbhPJRVgjX3LCsaXt8EYImBpKOFoirTCAQKo6DGyzc0CoEs8IDN4MV9VZpwlBV
	 5yoDdTVMEnefrZtV1dDFMtxB6wi5btXOGb4EIXYcAXjJXXeqgPAy3YgKMWtOlpIZ0W
	 4C3lDamKlLQuQ==
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-416331732aaso2646825e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 15:36:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712356565; x=1712961365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3VLnZHG6NMsFZ484LFX99y48PIsMB85l7TlShPfpb8M=;
        b=gimBWmcBZSZUGvRwK3rCZAc0njnF2VS1PHmy0onYue6bOyDBQ65VJwlOjzzxiqbNC6
         abUTnAripaNFWHGxNlOLzAAgxVY4kV61/nbG/z9veuJReeARIFrIzQNoXZyV0A2GkxP6
         gOfOPSZFqMTialiacPML3SGXFLQj+z/jDor2m9N4nNxe/9bEBHZ9Iez4d1ZdQ+lmyuwJ
         nxP+Tsqclf9Z0TQINYzFhOesccJTrVjCBtNmKcTWavX1oOf6FXNy/nbzxSmhvGBiQ48G
         7/eXuHGPTWkba6DuqlirngcN2+MrUInj/X/rkAtDxr10anRMAQJHX+cho2EAJCaOPX5/
         rGPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGn99kCzP28qWZQxSunuwLZUsrPU0jV8LZhbBOv79cvONb7nnfcU1Em4zOoV3igcUP/M9us7SGE1yYbm2/cGEHThpMLpm13KGKhRbI
X-Gm-Message-State: AOJu0YzIn4kG0htm2/o2Ajiok98VXMi7yibXC73AM0YwMvhz8rMyhPfo
	VxRCIqYbOHRyVxA14xrG/PpVMBf9vZ5Ok7QG4HAcchAWOnPdvwT+4McF03j6BKuoN3QW3okWpZg
	ahng4VlJdhj2ec1YZhUpbzk0/xM+aTJ2r9UlW+/7PHdNEGgn55i4M3KHmS2TiXMO2axEWZjSeWo
	xJmA==
X-Received: by 2002:a05:600c:1e24:b0:412:efc8:299b with SMTP id ay36-20020a05600c1e2400b00412efc8299bmr1976468wmb.39.1712356564661;
        Fri, 05 Apr 2024 15:36:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFy6QBCKBbZSuFIsTW1GksJvbLyNHWJv1lSbckpk7UcILNYkV43dYJd1R4rSx10ciYc2EMozQ==
X-Received: by 2002:a05:600c:1e24:b0:412:efc8:299b with SMTP id ay36-20020a05600c1e2400b00412efc8299bmr1976459wmb.39.1712356564143;
        Fri, 05 Apr 2024 15:36:04 -0700 (PDT)
Received: from gpd.station (net-2-39-142-110.cust.vodafonedsl.it. [2.39.142.110])
        by smtp.gmail.com with ESMTPSA id bi21-20020a05600c3d9500b004163334df40sm1475698wmb.19.2024.04.05.15.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 15:36:03 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] libbpf: Add ring__consume_n / ring_buffer__consume_n
Date: Sat,  6 Apr 2024 00:16:05 +0200
Message-ID: <20240405223556.11142-3-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240405223556.11142-1-andrea.righi@canonical.com>
References: <20240405223556.11142-1-andrea.righi@canonical.com>
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
 tools/lib/bpf/libbpf.map |  6 ++++++
 tools/lib/bpf/ringbuf.c  | 38 +++++++++++++++++++++++++++++++++++---
 3 files changed, 53 insertions(+), 3 deletions(-)

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
index 51732ecb1385..23d82bba021a 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -416,3 +416,9 @@ LIBBPF_1.4.0 {
 		btf__new_split;
 		btf_ext__raw_data;
 } LIBBPF_1.3.0;
+
+LIBBPF_1.5.0 {
+	global:
+		ring__consume_n;
+		ring_buffer__consume_n;
+} LIBBPF_1.4.0;
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


