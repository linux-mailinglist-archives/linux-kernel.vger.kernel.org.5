Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47AB764E44
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 10:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbjG0Iz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 04:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233744AbjG0Iz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 04:55:26 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E753A12670
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 01:36:12 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fbf09a9139so1177886e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 01:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wowsignal-io.20221208.gappssmtp.com; s=20221208; t=1690446969; x=1691051769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O2wrzhWx+47YfIynN9uLYZgBiAlpxfP+vVN0o8guwaA=;
        b=M7DZmUq1wAJNqP3efqYAQosIIM+CE/R9FA3xiMLuDHqZnmA2kjYxTnLfNbDEQy2qi/
         HrjSU7t//Hh70HE75AyjfO68YYY7/vpWkPCzOn43KKaxB216NXBKzWEk2kN9PDqBR+Iz
         9/qvMefi1GHeGbOIURzf0g5QwK/xkzQHkH4P9KbqEosi8zx6HerWYfZvsQXTrS/aEqx7
         4LU7uV2w1uTR99B6sfv67f2ByGU5ABeNcSJBVk5NRh2bVWUxIO9LicSzQ1EmQqK33qww
         LxQzEw1d0VSLPeGzdDXbfO5rB6CAHftTHgiXHU25aJWZq/EZNpuVtvKG6/bNZs7lkxWq
         J4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690446969; x=1691051769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O2wrzhWx+47YfIynN9uLYZgBiAlpxfP+vVN0o8guwaA=;
        b=cxZgqNH37NxzTaZ5WnmU1V2t4j8WB02r4IMiZb7QH/wVVyVaugtQ7+fgNyLhDzh1Q3
         nkb4762yR8pNWhyT1jQ/KB+BzsJy9uLVDsj8WIuezZ91vCYStFnSvBfIb6YmAbEhlkzy
         QJdhjGJgfmseg1oTbSM8V++E/3HnwDAaDjqwMM0vCUTrA/9psY6Ckoz852ubmXxBhJQh
         gJXchZ5/yGfvUbpQ/0kJuc0BZ2IQ1JSfI7a6sV41pzc76JLc9xpRljgKrTNVux5dOjcR
         14gQCkckoIc3wCf033VZW7NISbJBf/AslP5jhcGZg06v96Qrfn5jQJBzcl8tsczjwkNO
         fIuw==
X-Gm-Message-State: ABy/qLa2fiFMKP20eH9pmnAdRkj4MFBp3SZ81XY8RfifEumSjZ8H8ypj
        AaScCnITry4G8gAQ0i6XZpPpWw==
X-Google-Smtp-Source: APBJJlHa3RX51lM3Mi/JS7edY3dEn3be6jpAPQp1vf6v8GiWMGedK/SGGJvYUz28VPePc0J34L7CdQ==
X-Received: by 2002:a2e:b015:0:b0:2b6:d326:156d with SMTP id y21-20020a2eb015000000b002b6d326156dmr1169576ljk.19.1690446969125;
        Thu, 27 Jul 2023 01:36:09 -0700 (PDT)
Received: from localhost (212-51-140-210.fiber7.init7.net. [212.51.140.210])
        by smtp.gmail.com with ESMTPSA id o12-20020adfcf0c000000b00301a351a8d6sm1305676wrj.84.2023.07.27.01.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 01:36:08 -0700 (PDT)
From:   Adam Sindelar <adam@wowsignal.io>
To:     bpf@vger.kernel.org
Cc:     Adam Sindelar <ats@fb.com>, David Vernet <void@manifault.com>,
        Brendan Jackman <jackmanb@google.com>,
        KP Singh <kpsingh@chromium.org>, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v4] libbpf: Expose API to consume one ring at a time
Date:   Thu, 27 Jul 2023 10:34:38 +0200
Message-Id: <20230727083436.293201-1-adam@wowsignal.io>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already provide ring_buffer__epoll_fd to enable use of external
polling systems. However, the only API available to consume the ring
buffer is ring_buffer__consume, which always checks all rings. When
polling for many events, this can be wasteful.

Signed-off-by: Adam Sindelar <adam@wowsignal.io>
---
v1->v2: Added entry to libbpf.map
v2->v3: Correctly set errno and handle overflow
v3->v4: Fixed an embarrasing typo from zealous autocomplete

 tools/lib/bpf/libbpf.h   |  1 +
 tools/lib/bpf/libbpf.map |  1 +
 tools/lib/bpf/ringbuf.c  | 22 ++++++++++++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 55b97b2087540..20ccc65eb3f9d 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1195,6 +1195,7 @@ LIBBPF_API int ring_buffer__add(struct ring_buffer *rb, int map_fd,
 				ring_buffer_sample_fn sample_cb, void *ctx);
 LIBBPF_API int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms);
 LIBBPF_API int ring_buffer__consume(struct ring_buffer *rb);
+LIBBPF_API int ring_buffer__consume_ring(struct ring_buffer *rb, uint32_t ring_id);
 LIBBPF_API int ring_buffer__epoll_fd(const struct ring_buffer *rb);
 
 struct user_ring_buffer_opts {
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 9c7538dd5835e..42dc418b4672f 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -398,4 +398,5 @@ LIBBPF_1.3.0 {
 		bpf_prog_detach_opts;
 		bpf_program__attach_netfilter;
 		bpf_program__attach_tcx;
+		ring_buffer__consume_ring;
 } LIBBPF_1.2.0;
diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index 02199364db136..457469fc7d71e 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -290,6 +290,28 @@ int ring_buffer__consume(struct ring_buffer *rb)
 	return res;
 }
 
+/* Consume available data from a single RINGBUF map identified by its ID.
+ * The ring ID is returned in epoll_data by epoll_wait when called with
+ * ring_buffer__epoll_fd.
+ */
+int ring_buffer__consume_ring(struct ring_buffer *rb, uint32_t ring_id)
+{
+	struct ring *ring;
+	int64_t res;
+
+	if (ring_id >= rb->ring_cnt)
+		return libbpf_err(-EINVAL);
+
+	ring = &rb->rings[ring_id];
+	res = ringbuf_process_ring(ring);
+	if (res < 0)
+		return libbpf_err(res);
+
+	if (res > INT_MAX)
+		return INT_MAX;
+	return res;
+}
+
 /* Poll for available data and consume records, if any are available.
  * Returns number of records consumed (or INT_MAX, whichever is less), or
  * negative number, if any of the registered callbacks returned error.
-- 
2.39.2

