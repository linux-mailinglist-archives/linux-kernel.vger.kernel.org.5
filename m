Return-Path: <linux-kernel+bounces-82325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3024C86829A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4F721F229FF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1C413172A;
	Mon, 26 Feb 2024 21:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAogCIzq"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B249405CE
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 21:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708981963; cv=none; b=YaPqQzOJkN5DSExlMnMpVfLZqy+YgMR3KW6rRbg07capW5OIc0X0biCuvqAZ+jDYGKJlLm0mhyuOOGBL9mfwHm2UXUU/eAFonHlF2ODuQXLnG5NBCw4aLxuDqgR91CYzQBMLaBHo7HivTcXnNEtYYYvoBrkrSrrq5SkrXbZeU0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708981963; c=relaxed/simple;
	bh=GdPy4GkFXCLovNiPIxd6I6JUjafJipYvTlGkL2o8yIk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rsrUfT/nKd8EqN54s7G6QWRt4+R2tSALVRd70cNjGDR8+ynqw5uHOPq7fTD4EVQK87unt+Xc7m8/NJzqRl6EVNlgyDDhLX5Ox3WDYJ7W/BOLOB1k7ph6+jPf2jOHnJJYpcwsE52707kqXOoLaFW+vB1AMsg5t9r//4Xsa5TCiec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VAogCIzq; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-412a5b63c11so8889715e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 13:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708981960; x=1709586760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3x3BD2GkxMZMqd/1VnWeb2aZg9kXrVU17QnxzRPyDP4=;
        b=VAogCIzqKBgfwtzs+GAfkGxXrO3DNLL+/W4NTHLXiupKs/faJxC9OeLeVWOs7lKDdR
         v/HXkvEwc6sW4k/QrIYpDtW71ZrVnPm7FGveAZcwW6du3zEL4GQaGyhc44amDJBuYm92
         IpPjfc4w0fJoivzMuXMY8TNf0i0aU0HPkxDLv7RxOvJsDzVOHN6MuaEZXOXfY+Y5/I2e
         9+Ed3MLG2R1q0o3ypkVk5lcYfWUl0qOUUHdOioe0TuFjMcXGUGt2Fcr47okFbDtsdAAY
         YUpcBeeUFDgne5UkvaBpscvlkwUY1/s/rmUUw9mid8G/MxktyHPlBnVmrGClx5xSQugN
         gSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708981961; x=1709586761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3x3BD2GkxMZMqd/1VnWeb2aZg9kXrVU17QnxzRPyDP4=;
        b=rtAQAHCWTQsN99/cSSgwvxcchzJw8QZzmWlyOrRZn+n2eXrLoHs1x8MRU1d78PfThV
         W/wAu6htS/25XJMYd0285uyJGwt5WBvQ3QY6OwDjLucTfbskIMDTwAEn2fbl7q/ODCr8
         eevYVvZM/elIKmxZXwt0wnRkTu278iOk3MSkdYUaaBLdMjdMsf4IwsFIGodpvS6rE8eM
         0gM9XO+AcPm87kEstMlPV90kV2CTJFnLsZ11iAmJEzdVQAjd2i9OQSbtVRqU7Nqxch60
         BW9+0jq5lNq7+JojjTNvxFbrbtxwpn1ELnNbNfhY3iawISHUe2C6xwmUAvuKwiTJhgXM
         oqAA==
X-Gm-Message-State: AOJu0Ywq9drKvbnjfRliec05YxRu5fYqpDoLSjwMynMKcjpk3q+WXfam
	s/Ue4ExLYKuzHbC7/ylgZ4rL3pecoCTvlqnlv05KoAPybNCwAWOC
X-Google-Smtp-Source: AGHT+IF5wzD5j3BXPOyaSwbFRLla4v6z311ZI9LOfaEzQBlG7tsV7ZQyWxSNVsQdKXlZKO2S8ulABQ==
X-Received: by 2002:a05:600c:45cd:b0:412:7b4d:b256 with SMTP id s13-20020a05600c45cd00b004127b4db256mr5815822wmo.18.1708981960416;
        Mon, 26 Feb 2024 13:12:40 -0800 (PST)
Received: from localhost.localdomain (host86-133-224-40.range86-133.btcentralplus.com. [86.133.224.40])
        by smtp.gmail.com with ESMTPSA id bv15-20020a0560001f0f00b0033d47c6073esm9373109wrb.12.2024.02.26.13.12.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 Feb 2024 13:12:40 -0800 (PST)
From: Levi Yun <ppbuk5246@gmail.com>
To: hannes@cmpxchg.org,
	surenb@google.com,
	peterz@infradead.org,
	mingo@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com
Cc: linux-kernel@vger.kernel.org,
	Levi Yun <ppbuk5246@gmail.com>
Subject: [PATCH v2] psi: Fix avg trigger being fired unexpectedly.
Date: Mon, 26 Feb 2024 21:12:37 +0000
Message-ID: <20240226211237.48415-1-ppbuk5246@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 915a087e4c473("psi: Fix trigger being fired unexpectedly at initial")
fixes unexpected event fired when group->total accumulated for PSI_POLL.
But, for PSI_AVGS, win->value should be initialized with group->total[PSI_AVGS].
Moreover, to get exact initial value for win->value, it should be set
under each trigger lock to avoid concurrent changes to group->total[].

Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
Acked-by: Suren Baghdasaryan <surenb@google.com>
---
v2: Fix commit message.
---
 kernel/sched/psi.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 7b4aa5809c0f..e7f66ab2ad3e 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1323,9 +1323,6 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group, char *buf,
 	t->state = state;
 	t->threshold = threshold_us * NSEC_PER_USEC;
 	t->win.size = window_us * NSEC_PER_USEC;
-	window_reset(&t->win, sched_clock(),
-			group->total[PSI_POLL][t->state], 0);
-
 	t->event = 0;
 	t->last_event_time = 0;
 	t->of = of;
@@ -1336,6 +1333,8 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group, char *buf,

 	if (privileged) {
 		mutex_lock(&group->rtpoll_trigger_lock);
+		window_reset(&t->win, sched_clock(),
+				group->total[PSI_POLL][t->state], 0);

 		if (!rcu_access_pointer(group->rtpoll_task)) {
 			struct task_struct *task;
@@ -1361,6 +1360,9 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group, char *buf,
 	} else {
 		mutex_lock(&group->avgs_lock);

+		window_reset(&t->win, sched_clock(),
+				group->total[PSI_AVGS][t->state], 0);
+
 		list_add(&t->node, &group->avg_triggers);
 		group->avg_nr_triggers[t->state]++;

--
2.39.2

