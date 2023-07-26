Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8760E763733
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 15:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbjGZNLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 09:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjGZNK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 09:10:57 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65981BF2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 06:10:55 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-317715ec496so1350506f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 06:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wowsignal-io.20221208.gappssmtp.com; s=20221208; t=1690377054; x=1690981854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bATIaA6LQXRSZJACQ6TfpjUUXUJadMivsNlfpPDYAoY=;
        b=nSWbZevUMUYV6zgWbsW1IByr4aLDiUu+v2C9iL0m4qjiZKXn9qpb5jCMykSISS97ep
         1fXc8vJPyIoSFxoGFrlRV3oG8Q2M5cma+P1TQn/3Prv4RxiSPsWBaEKDA1WbZ2uT+aUO
         UAaDt6zhyQbd8AuxfKCECAU/8zhwGQS/NdcfHWc2xkSUc2sSL+GFUgxGLYDRWtSGtIIO
         qOdT25mS5WMwgmrW3NY3FkaNOgmt9bMbtTFHgigIanFoJg4pmU4zbeG5zdFHSeIMJHLn
         pDLvew4GXmWObHrn35QFRCEemzo6e0w5TiQ1SI9Eoc+gN9W4oS+GDMEV2g/JBFn0A+Ne
         AiNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690377054; x=1690981854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bATIaA6LQXRSZJACQ6TfpjUUXUJadMivsNlfpPDYAoY=;
        b=ZZxLnhGcVQXpE9Fts0BI3CVmUfqPvot32hiw9WxeF0QFHJgD2WiUFrXox2sEFDAKIy
         5JckIJUG22TBaGtxFJEf70HFF/Dv3gzoOvconSfgMhFmM75zgTbFeI7cI1L/9xOAoIPG
         w5t4cwfjCq4vjRgn6XY12VGnQwZMVG8/ovECGVxslLuCgPPzGqxOeyXIF2DKIT6VWMHf
         tN8azd2x0UOv4Tn5u6GYcyETWFUDdANvSC3+81V4s5W0q1or1eQ1wfGsJK1wnLJY2ANX
         +FLT8CwknujvOz8Q9sDYZZvXwZRmvBcYo5B9bMHU8Q4d5g4d0RbBKhgdqqFDzr4dl9Hb
         qL0w==
X-Gm-Message-State: ABy/qLZ9KlOtzp85n+TEJ1QrD/tYLGhi6T5wgYX8IkF9xillWJ1ahzh3
        7xMXrdfYSnFTUrjFjJ8sJhtVUg==
X-Google-Smtp-Source: APBJJlEvByG95YVt5n5013sBm/Gdu9d6b97o2ESe3K8JUQsn9Xx3YlYdAF+DPqKaaBf+0F+DZe/B0g==
X-Received: by 2002:a5d:4f10:0:b0:314:521:ce0a with SMTP id c16-20020a5d4f10000000b003140521ce0amr1485864wru.40.1690377054117;
        Wed, 26 Jul 2023 06:10:54 -0700 (PDT)
Received: from localhost (212-51-140-210.fiber7.init7.net. [212.51.140.210])
        by smtp.gmail.com with ESMTPSA id r5-20020a5d52c5000000b003143bb5ecd5sm19838856wrv.69.2023.07.26.06.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 06:10:53 -0700 (PDT)
From:   Adam Sindelar <adam@wowsignal.io>
To:     bpf@vger.kernel.org
Cc:     Adam Sindelar <ats@fb.com>, David Vernet <void@manifault.com>,
        Brendan Jackman <jackmanb@google.com>,
        KP Singh <kpsingh@chromium.org>, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v2] libbpf: Expose API to consume one ring at a time
Date:   Wed, 26 Jul 2023 15:09:46 +0200
Message-Id: <20230726130944.6873-1-adam@wowsignal.io>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
v0->v1: Added entry to libbpf.map

 tools/lib/bpf/libbpf.h   |  1 +
 tools/lib/bpf/libbpf.map |  1 +
 tools/lib/bpf/ringbuf.c  | 15 +++++++++++++++
 3 files changed, 17 insertions(+)

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
index 02199364db136..8d087bfc7d005 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -290,6 +290,21 @@ int ring_buffer__consume(struct ring_buffer *rb)
 	return res;
 }
 
+/* Consume available data from a single RINGBUF map identified by its ID.
+ * The ring ID is returned in epoll_data by epoll_wait when called with
+ * ring_buffer__epoll_fd.
+ */
+int ring_buffer__consume_ring(struct ring_buffer *rb, uint32_t ring_id)
+{
+	struct ring *ring;
+
+	if (ring_id >= rb->ring_cnt)
+		return libbpf_err(-EINVAL);
+
+	ring = &rb->rings[ring_id];
+	return ringbuf_process_ring(ring);
+}
+
 /* Poll for available data and consume records, if any are available.
  * Returns number of records consumed (or INT_MAX, whichever is less), or
  * negative number, if any of the registered callbacks returned error.
-- 
2.39.2

