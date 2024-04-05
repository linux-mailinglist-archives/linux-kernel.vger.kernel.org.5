Return-Path: <linux-kernel+bounces-133686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA76B89A759
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 00:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDC8F1C216C6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 22:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AA72E852;
	Fri,  5 Apr 2024 22:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="W8hVtIXj"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FF61D52B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 22:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712356577; cv=none; b=QhnEztVBmtscBG651y84K4tVh0ckA0hyfDYyC+uzPnbuYX0bX7H/c0v+4vUNELUtHDvLhuLOPdqdZGSZSt5atbNczvjcCqpBq0/3ht5r90eE90qEKKV7FRplAXtixV5tG4ctP8Y2MGqHkVBV0aOlaVs2lW9Gq3Z5yIllSbLVuZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712356577; c=relaxed/simple;
	bh=a78vMWglkqZNxVpizm3bz2mABJk4IrXHntVwOv9hkR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cvs8cG9FuRdpDp+V8teEn2nH0cw01m2EeiNuWaXqpMYrAdpiOnYNMI9EyA/JOk5lxFS9DaT73Yjs4uPsJs0qjXXIBwCrnLgx9KwTW5yqADVMZOvdVYU0Nrz5BWFwpTT5gWWaHr7Ddvd0113PZiaadHErajolSEjuHe7yh/UD7Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=W8hVtIXj; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A7A5A3FE51
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 22:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1712356564;
	bh=U9JiGxHu1Zu7lOUTn6nQmFFrRqhFXaTmBwUIearvaJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=W8hVtIXjFuDUvmiKWhDbjnGt6i0qTw3PUA5gvOBYeLP8BIiCGs2UJKsS6kdppHUWn
	 Fdmf1HeKJyyjenD1xw5yaLl5BNQKbfGMQe4McwRN28YSXew3Y1aAR259b6CbJ+cA5J
	 FKVoSLp9Gv9FuapotJwwl8h5u+P828WkWTHHSGYWoX46Tn5jgG+Tjw65xR/9W+XYtW
	 34otTcv/sRrzCoA6zTvv14dadVG1YOZq+K7hJIdAgUnpLkpBg1dAi67ilxvrlfKGI2
	 BmKIphP+iYx2xNZDsDznppIyuNxHKIxqwOWqI2NKMbebXTh02HT8TRbQrQokEWqqrT
	 BFAr27G3n/N/Q==
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2d86005189eso19155931fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 15:36:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712356562; x=1712961362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U9JiGxHu1Zu7lOUTn6nQmFFrRqhFXaTmBwUIearvaJY=;
        b=m1y4IyJl2m0E/dfkvKrQCuPR1s9ffDEkoAqlcDrUGkvkuSZhaF4qosoTWrnZD72Lc9
         sXZV+e84d0ZcSjN+QE3nwglaysd+ErhvV6srF8VlfFdgs1uFpJi5wyNdT78UifLuZcRe
         RdoCr/vMLNDZpTNJb3u+30jegMmenA4YCZSQCvTMV9B3NBgmQTp3ZqVlzIdazi0+xDPD
         l1NwkSadNQkZmiijAIun3VtR7URxuO4z0m7tZu2OOYzZQZqARULu1iA5eZPK5+nqXV+y
         2NSw2HXnNqFrVeRhT/lGOTcC290fxEt9dtmhPSHneiS5gezJTwh9v0TgGmPNtf3INQUS
         9+DQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTP3/tMZ4BaLNDwz5GgzqMlmzj5bAX3yr7jMMdUWePldS0cg7XAsBeUShp+ZkX9IseKaoNxMk2GALU02wSGkcnVaUb0Y3aFjcD3o+o
X-Gm-Message-State: AOJu0YxeFJQYgKBw/1s/MpYhCzNn79GqdsjVD41+lSsfuqa3pQnCtZg5
	8cAhq7YdY0cS1DE0wIsR9KxUhWGmIl+5PLCjPOiUOwauqUR+TInmB4yf/DE8jqDU37h72+e9C+r
	0fUxlNoGY6yONKIzYnZDfPQShXfaTF6sP7R6m1oaaClw6MGvF+dPFrL5bcXI9cpZua4ArpXQh9Y
	3oIg==
X-Received: by 2002:a2e:7210:0:b0:2d8:6561:72ca with SMTP id n16-20020a2e7210000000b002d8656172camr1995338ljc.19.1712356562457;
        Fri, 05 Apr 2024 15:36:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBVMYT18cPC1QCrh2MWjzCOnxzSsVoLjeD9J9cFM+sm3A78FEmzC3KWLy5fGTZ57Qk1PyOaA==
X-Received: by 2002:a2e:7210:0:b0:2d8:6561:72ca with SMTP id n16-20020a2e7210000000b002d8656172camr1995321ljc.19.1712356561922;
        Fri, 05 Apr 2024 15:36:01 -0700 (PDT)
Received: from gpd.station (net-2-39-142-110.cust.vodafonedsl.it. [2.39.142.110])
        by smtp.gmail.com with ESMTPSA id bi21-20020a05600c3d9500b004163334df40sm1475698wmb.19.2024.04.05.15.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 15:36:01 -0700 (PDT)
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
Subject: [PATCH v3 1/2] libbpf: ringbuf: allow to consume up to a certain amount of items
Date: Sat,  6 Apr 2024 00:16:04 +0200
Message-ID: <20240405223556.11142-2-andrea.righi@canonical.com>
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

In some cases, instead of always consuming all items from ring buffers
in a greedy way, we may want to consume up to a certain amount of items,
for example when we need to copy items from the BPF ring buffer to a
limited user buffer.

This change allows to set an upper limit to the amount of items consumed
from one or more ring buffers.

Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 tools/lib/bpf/ringbuf.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index aacb64278a01..2c4031168413 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -231,7 +231,7 @@ static inline int roundup_len(__u32 len)
 	return (len + 7) / 8 * 8;
 }
 
-static int64_t ringbuf_process_ring(struct ring *r)
+static int64_t ringbuf_process_ring(struct ring *r, size_t n)
 {
 	int *len_ptr, len, err;
 	/* 64-bit to avoid overflow in case of extreme application behavior */
@@ -268,6 +268,9 @@ static int64_t ringbuf_process_ring(struct ring *r)
 			}
 
 			smp_store_release(r->consumer_pos, cons_pos);
+
+			if (cnt >= n)
+				goto done;
 		}
 	} while (got_new_data);
 done:
@@ -287,13 +290,15 @@ int ring_buffer__consume(struct ring_buffer *rb)
 	for (i = 0; i < rb->ring_cnt; i++) {
 		struct ring *ring = rb->rings[i];
 
-		err = ringbuf_process_ring(ring);
+		err = ringbuf_process_ring(ring, INT_MAX);
 		if (err < 0)
 			return libbpf_err(err);
 		res += err;
+		if (res > INT_MAX) {
+			res = INT_MAX;
+			break;
+		}
 	}
-	if (res > INT_MAX)
-		return INT_MAX;
 	return res;
 }
 
@@ -314,13 +319,15 @@ int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms)
 		__u32 ring_id = rb->events[i].data.fd;
 		struct ring *ring = rb->rings[ring_id];
 
-		err = ringbuf_process_ring(ring);
+		err = ringbuf_process_ring(ring, INT_MAX);
 		if (err < 0)
 			return libbpf_err(err);
 		res += err;
+		if (res > INT_MAX) {
+			res = INT_MAX;
+			break;
+		}
 	}
-	if (res > INT_MAX)
-		return INT_MAX;
 	return res;
 }
 
@@ -375,7 +382,7 @@ int ring__consume(struct ring *r)
 {
 	int64_t res;
 
-	res = ringbuf_process_ring(r);
+	res = ringbuf_process_ring(r, INT_MAX);
 	if (res < 0)
 		return libbpf_err(res);
 
-- 
2.43.0


