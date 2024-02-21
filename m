Return-Path: <linux-kernel+bounces-75228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C807485E4EE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE9281C239A0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F8B84FD7;
	Wed, 21 Feb 2024 17:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="OcvIKM4U"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B5582865
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 17:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708537936; cv=none; b=GJHXh89d4rsD/h0Plw6rwYMHx2VuSs9ec6I7SFc033U2w1SgLp/I4Og9AC5lmZ9U00DU06jbfp/2CSwU2wv84qL2K6uLvTo2eB8/QE+EdUiPBLTAKqtUwVa8/lw2EVaeEcqtv0a/cOEyG12JCPGAAmeJU7llClyFgMx/4R5X2lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708537936; c=relaxed/simple;
	bh=rI+UFBLzHgh5osY1C+DB3EoIdb5NuomFAo9d4P0bbRs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r+CBmjWzYtf+rszLgSPGieRVrw2t+XO7o6zJDhjUS0z5pc6SSnK5gVdhlqxqHInF9BoHDXmsvfpGLV2fPnvmkSD2VA58sTrD2G9Fa+i44Tsz0PR5wsS+oRw9NDKyslQ6wtfkjz4VzuTwXbUYv6xu72qO9lMOFveF/zsQmlHxp34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=OcvIKM4U; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d918008b99so57646435ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1708537933; x=1709142733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5V8y3dySFl8kdmMCLan3vQixGPkJBiAZiaFJHDPmSXw=;
        b=OcvIKM4Uf0WoTJ2OjOhpb7hR1He3GV1/B4b3A6C4INqKAK5r/bvVqVT3Lmtod+5rUg
         0lz0ZOM5REfDMkFcT2AG9b+DYdPCxweX/Gs2boFEo/Ai2pcfy0NQFwJ1/edOVcWAR0jt
         viwJbUxHKNFX3J7VD7M5lTxjR7QezjgRh7b4OZZTkYrJ2owvd2WP/wMhPNKi8DXUDASt
         3FEJ9w2Ue9xw7PxkdZbk+eR5pWE23vksovNxUeKwjgcyw7R0groru3G8DUk8r6r9SeSO
         cMYSo7QTz+1PjVbn45ssnyg9P15LO6VVfSCZif5gjxljGPLoL7jVGzzoxoIl87U9JFiW
         y9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708537933; x=1709142733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5V8y3dySFl8kdmMCLan3vQixGPkJBiAZiaFJHDPmSXw=;
        b=DZPrvCcbWrS6BX9kz/wvnYGAXqoMWD05L2fppqOe3S+kJ2rMNsR6ua0RG6iMh1Oh+v
         ObutY5JrtJqpAEPHKbAl681UnlelNETWW4cwx0NMwjoH1l3wfGGvIlMAbR5ornR+Erll
         6GAR/jdzI2TXP+VvwItA2udyLev4qNSzU4Z1m6rTNGyPTtV068EHAcBGnAFqSP+xoPvL
         I4UqzoVDwB/K8AtglwWbRxc2P653Dj2u3QsZCvY8loSfLXXtWZNmNiQUcTZd9n52ga+X
         CePjELD+yRleKTcI5bb5FksFMEnd4zrLwsW7uM07blk7bxtUEaWuDzULI/x4FVuStjke
         49kA==
X-Forwarded-Encrypted: i=1; AJvYcCVSjg6hJLsp7KuCqSOM3J1uZAiIU3JGXH86myTolHV0UAaGptFDrO3sm8fvoVCpTnXWtQt+Uq9JsRODSgXvTUVJoRcCqj1Pavica65K
X-Gm-Message-State: AOJu0YyhCwMSoU5p/08efTaHhftqEOQEgEFQrohkWoOa/lgqHkI3M7ep
	MGIjoC6G2kvWZULkoaiqpDJYiuPIFxAriRQVLi95TgvBy8c1MdW1BlMlb9Y5xA==
X-Google-Smtp-Source: AGHT+IGW8WYnnvJLYkMaaoUrrD89EyF1j7SjyCLvgEkswY7dZasilkjwVId/1YGCSZSr4OIgcKfI2A==
X-Received: by 2002:a17:902:d508:b0:1db:d3d7:88a7 with SMTP id b8-20020a170902d50800b001dbd3d788a7mr11668295plg.49.1708537933064;
        Wed, 21 Feb 2024 09:52:13 -0800 (PST)
Received: from zhadum.home.kylehuey.com (c-76-126-33-191.hsd1.ca.comcast.net. [76.126.33.191])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902e9c600b001d706e373a9sm8312596plk.292.2024.02.21.09.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 09:52:12 -0800 (PST)
From: Kyle Huey <me@kylehuey.com>
X-Google-Original-From: Kyle Huey <khuey@kylehuey.com>
To: Kyle Huey <khuey@kylehuey.com>,
	Robert O'Callahan <robert@ocallahan.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] perf/ring_buffer: Trigger FASYNC signals for watermark wakeups
Date: Wed, 21 Feb 2024 09:52:09 -0800
Message-Id: <20240221175210.19936-1-khuey@kylehuey.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf_output_wakeup() already marks the perf event fd available for polling.
Add code to trigger IO signals with FASYNC too.

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
---
 include/linux/perf_event.h  | 8 ++++++++
 kernel/events/core.c        | 8 --------
 kernel/events/ring_buffer.c | 3 +++
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index c8bd5bb6610c..c077968d7e52 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1914,4 +1914,12 @@ static inline void perf_lopwr_cb(bool mode)
 }
 #endif
 
+static inline struct fasync_struct **perf_event_fasync(struct perf_event *event)
+{
+	/* only the parent has fasync state */
+	if (event->parent)
+		event = event->parent;
+	return &event->fasync;
+}
+
 #endif /* _LINUX_PERF_EVENT_H */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index a329bec42c4d..36b5fbdf8e6e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6684,14 +6684,6 @@ static const struct file_operations perf_fops = {
  * to user-space before waking everybody up.
  */
 
-static inline struct fasync_struct **perf_event_fasync(struct perf_event *event)
-{
-	/* only the parent has fasync state */
-	if (event->parent)
-		event = event->parent;
-	return &event->fasync;
-}
-
 void perf_event_wakeup(struct perf_event *event)
 {
 	ring_buffer_wakeup(event);
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 60ed43d1c29e..033e54bb5c62 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -22,6 +22,9 @@ static void perf_output_wakeup(struct perf_output_handle *handle)
 	atomic_set(&handle->rb->poll, EPOLLIN);
 
 	handle->event->pending_wakeup = 1;
+	if (*perf_event_fasync(handle->event) && !handle->event->pending_kill)
+		handle->event->pending_kill = POLL_IN;
+
 	irq_work_queue(&handle->event->pending_irq);
 }
 
-- 
2.34.1


