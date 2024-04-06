Return-Path: <linux-kernel+bounces-133873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 748F589AA26
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 11:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7E2E1F22DA9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 09:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8323EA86;
	Sat,  6 Apr 2024 09:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="gFrTYqbP"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22663B18D
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 09:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712395224; cv=none; b=dMIo78MOkZO/niLdD8zQfWY3nEKw/Ap0fglzlYrN7wtV4nzmFDsS41/kI/pOtOjiqTdUFSZkGgrdyiH6uQStdVlp6+qBLbQqij8p6D0XAfVxddW2H3gtTLv9y9tdKHE3mI1z720uv9lTq4pmaAlRT87iXeclm9kmKy3D6Ezy3Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712395224; c=relaxed/simple;
	bh=a78vMWglkqZNxVpizm3bz2mABJk4IrXHntVwOv9hkR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MYl1zgBCc4/b+6x6eCUtx0CpsPlLRCOQtpfkQII+z1bMpDfGatyQ8q/VM6BgI9OEfxojCOIrG1ErLCePuRTU7b25Akg5DkY97TrAupE01fPU3Dw2Vb3IqjMQkyVr1tgsInKDHWL7vPavm3Dicz6ME4c3rGMKJxAKyzkUN8VymSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=gFrTYqbP; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 00BE7424A5
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 09:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1712395218;
	bh=U9JiGxHu1Zu7lOUTn6nQmFFrRqhFXaTmBwUIearvaJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=gFrTYqbPR572IK0B/W7HVVRJ/NcPKS8ke+uoR1TW0dviOaQxlT9VtQdDeShH5mIvL
	 1WCRak/kefII4Kz6xCI/Ji7N+pDw9ihewWaHGZu2LCly/xnVNgeyf30p7SsA6tXy0Z
	 QZbXc2Ayx4BW9kQ6mJOFUd5DG3qoZgQ4nxVkDAjGxwmXcqT7uANLn9ByLTi6N3ozY0
	 fgYBKYjne4yQjr3MCGZAb1XfVRH+jsxxu5W6do4zfEa6dN4itGb/1NtC/hj96lczRV
	 xOpogtjNQGPJukFCFvholqM3hiahVbqe5wRtVUO5Im+X50cQBa9JcdBeXMX13DtcN0
	 CCnNFu+ngrdVw==
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-516be44ea1dso2472118e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2024 02:20:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712395216; x=1713000016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U9JiGxHu1Zu7lOUTn6nQmFFrRqhFXaTmBwUIearvaJY=;
        b=SGRe1dJGD5oi0ER15R2tuE8mRPj4etvb1UbyspX0xRaBckcxwFZFdA9tB5QaYjKtYZ
         ut7QWXrGB/pE7ZGwCZiU3gmcmbnMCAkprNcsR/g0rLPf3fnvjr/ywwcGdMiIIimiyrUf
         8vG+ualLtOs0HIvDvmKG5E5UKnkr78XZXa623bJnY0GhpT8qGB9fzxw2BnGU0LeSi9Ul
         5mctt21v3cE8acIPxEXrxE1y4CRF7wu9Q2W/dg5BO6YQtE64OrGMF4TaeDNSRJ67OhM4
         YODcFF5S+LNkjMZCIPW3nZVoTBIYQDTaB4hFhODl2uTHr4bNIxjcb3ad/u6j0L7F0fSM
         tjog==
X-Forwarded-Encrypted: i=1; AJvYcCUXXE/LwTPtGRrFXqBr1MvbdYGwPzqC6rJfRu9oIKT0XrpW8tQtdWPS1fy4SBNIYfcB0+nzWUG1WkOSZHWrTUdMJe0mWdi8FNhKcvGS
X-Gm-Message-State: AOJu0Yx9R7v/N7/CMVG5QwDNMPsSWrcEny3i0jy7Pq8YM5y/wM7+chys
	V9fHwV2hooRr7eYi37z/BrU1GYZ8HFoVKYpgHsYwYnXxmYEfeAftZLMuMqHNlUaFouJMEq2VbWw
	OIGdSiBJPMsDZBLNiOIFcD1BPYwxpk/H5onxVQpgQuxxM8g2erHovp0O/fjIm77+swgtyRHSL0e
	4tAg==
X-Received: by 2002:ac2:5df9:0:b0:515:d50f:c6cc with SMTP id z25-20020ac25df9000000b00515d50fc6ccmr2674253lfq.63.1712395215920;
        Sat, 06 Apr 2024 02:20:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHS/Wj4fTtj4EhH4SwuK4rc7frejoX2SMVVjV8lwzSRp5JOOCrfUKz3Ui9mytME96ZdhQmWHg==
X-Received: by 2002:ac2:5df9:0:b0:515:d50f:c6cc with SMTP id z25-20020ac25df9000000b00515d50fc6ccmr2674231lfq.63.1712395215460;
        Sat, 06 Apr 2024 02:20:15 -0700 (PDT)
Received: from gpd.station (net-2-39-142-110.cust.vodafonedsl.it. [2.39.142.110])
        by smtp.gmail.com with ESMTPSA id l23-20020a7bc457000000b00414924f307csm5779993wmi.26.2024.04.06.02.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 02:20:14 -0700 (PDT)
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
Subject: [PATCH v4 2/4] libbpf: ringbuf: allow to consume up to a certain amount of items
Date: Sat,  6 Apr 2024 11:15:42 +0200
Message-ID: <20240406092005.92399-3-andrea.righi@canonical.com>
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


