Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A9E764E23
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 10:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbjG0Iv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 04:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbjG0IvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 04:51:05 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9073C1FD
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 01:32:38 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3110ab7110aso711163f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 01:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wowsignal-io.20221208.gappssmtp.com; s=20221208; t=1690446702; x=1691051502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+FIdkei8j0Z6dR9PWH32VtzS9uGAiomSHDdNkPEK7YY=;
        b=A10BdUL/7HPmH5SS6q6httZ/Ojp8CeeZnqh8XMF/reS6CnkaZHsCBdPZ7Rfnoan4MT
         Eh2p80CGonbJeNmu2mdQVkB0MLxXq+SOXVUGhvdDwHowd2L6by0G0AbW++W7ITXPgdsf
         v9I62RUYrngrGiwDhj26BSQcr41j8dns1uE0IatYMAiZepfDaCCsBcPuwykeEoNy8S6S
         N8PEHEKH4DAYv1p78mKQNFMBRKVoBXNeLitLT2pHOx0MDDyxHPpVDwZ7KP0bjfDSMUG9
         UjnE2ZkpEHNehAuh+LyS3oRk/C/ez69FCMmngj14wc7CROEfPVflcvuUppapokC+HjGA
         6aGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690446702; x=1691051502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+FIdkei8j0Z6dR9PWH32VtzS9uGAiomSHDdNkPEK7YY=;
        b=L/w4T8KG8qHbfhoLl4pRZN/WDwUIuQz2DLkQKyx8XRhG1qNJS4xmsNkUFPUg+7VKM6
         TrbBsJ6dW153eoJBEPaAw18vGYhr+5BWU7dw7Ba68DAUz05DCVkU8iQ+UagfXM4Rxja9
         znIdKk989i3FBX81F75b1NY0cAAG+nZS5FkQ1rYQr61duzeH63QFRKriflIYjI6K7Uo+
         o16Fi1oCINHabhxc6MYNDWxoelhwNIcqKI2RRvPejp8LwWFwJuzDxGFBNoH8R0INSkvW
         a6ekxGgmI8/3736tjJAJJ94XU8GLTrH+QjLrYXoQNURars7Z2aD8/A+5+GjUaJgCLZK4
         2QmQ==
X-Gm-Message-State: ABy/qLa5KY82sKhI4EI/Pmj/KH52XQ5MeP1PPJ1LTg6KRjOo1KssjWYk
        X4DKPWVR/CJbrfhpl3hch7+9Jw==
X-Google-Smtp-Source: APBJJlFs+78ZtEvnBVELBgSLCy1PWM5/Gt0i7cgS1zxYweehf2AKKbyxppMOIWBjWSc9MH+r5K8qcA==
X-Received: by 2002:a5d:4cc7:0:b0:315:9362:3c70 with SMTP id c7-20020a5d4cc7000000b0031593623c70mr1225842wrt.60.1690446702139;
        Thu, 27 Jul 2023 01:31:42 -0700 (PDT)
Received: from localhost (212-51-140-210.fiber7.init7.net. [212.51.140.210])
        by smtp.gmail.com with ESMTPSA id k13-20020a056000004d00b003176bd661fasm1284502wrx.116.2023.07.27.01.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 01:31:41 -0700 (PDT)
From:   Adam Sindelar <adam@wowsignal.io>
To:     bpf@vger.kernel.org
Cc:     Adam Sindelar <ats@fb.com>, David Vernet <void@manifault.com>,
        Brendan Jackman <jackmanb@google.com>,
        KP Singh <kpsingh@chromium.org>, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v3] libbpf: Expose API to consume one ring at a time
Date:   Thu, 27 Jul 2023 10:23:12 +0200
Message-Id: <20230727082311.284075-1-adam@wowsignal.io>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
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
index 02199364db136..9f72b8c4504a7 100644
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
+		return libbpf_error(res);
+
+	if (res > INT_MAX)
+		return INT_MAX;
+	return res
+}
+
 /* Poll for available data and consume records, if any are available.
  * Returns number of records consumed (or INT_MAX, whichever is less), or
  * negative number, if any of the registered callbacks returned error.
-- 
2.39.2

