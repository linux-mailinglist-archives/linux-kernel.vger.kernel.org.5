Return-Path: <linux-kernel+bounces-82266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 014B5868160
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A59121F2468C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C8512FF82;
	Mon, 26 Feb 2024 19:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqqrgstT"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2927A60BA1
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 19:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708976812; cv=none; b=A+qIYwSoCk8LE0i45PXLiqyWpvErvWaIAst6WbAz1J33kLt9eJoY5o/z6PbvHsh//2vIEBMULH6/HU1374ascAXv00KhDke/FfqbDPEgHzOSgug+jh7nQtn7jwPYDzIuFHcArfRsdW4I+T5QIakGTjlp7hY86e0Vys/3/e0oPn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708976812; c=relaxed/simple;
	bh=yMSkd40jQ58IsjTFcyz6Y0aROzLE9aRQL+3vxznmzos=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BGIXPk086pQ4Y3BYa6bmNl5jhgwksqugvXsI1uVlwDrwdV+wEdI6s4zAOjZggASbWQYhvoIDYA1BObK9xQ0ew80T4XkyBa3rHZvqoFTnD/1bzR+ylA6FNo6ldRT4jz8lN7YNs5gsEtibcP8nwal/mh3h6GFkWr2EG03HK0OKBgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqqrgstT; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d208be133bso54655101fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 11:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708976809; x=1709581609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ek2V91xP+64JAHW/SkXga3bXiJC6Qhuuv1X5zy2fbQc=;
        b=hqqrgstTWoiW4MH3bmBsIW/jABm5EFevS0hi1CtJQzNkbmdx0V54XiYUjEm+n0AhiS
         JhtSKtDFZ/I2tkCxhcNbf2lUPg1y0K0eh4Ys6h84wkyWdd3XG8f8SZhGn4D99Y7VfC6S
         u9GIy8zgjzsgK71TtWewyW4E4SbW36qkMjWpe4+olnFprjLzTNgsmTe6vJQjbfft42m5
         9BhhKbiIVzUgzgNgIaxJrttomrUmFQj6y0SO9TItvCzsaujgM6krm3GrKxnEq1PHaM9X
         xZSmFLPjrhjYaQ+BoNXQ0xh10tspFZWOWBy1Tq7wn+AYm6VoS1t/BMC0Qb6rm9l4+hPE
         l6Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708976809; x=1709581609;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ek2V91xP+64JAHW/SkXga3bXiJC6Qhuuv1X5zy2fbQc=;
        b=JwZ95eqNq1/D+BQ+crdaYsQgGmk2KmCgVDYdyXlmuNh9jU/SdKhjspC3YLll7YQgrG
         +1hbgWYmg3CbuSHlXFNqXNt47pvpeaODrWqq6TsR9jFgI409uKUbSP+lxJ9I4hXViDyY
         taRP6rXDs7c0YJ4SXo3vEEfPFck2mpmr/uojtRXDzBni/vrKs859DSUE73LDMEMJwpAm
         YA4WSfVK3gvdJglIpG2HiSN6ZvaxCNN3LlTCwgQBabAE8zRuqqZIhuBO+HLap/B7Lpos
         h5WkE5gMXW++gRq/xiabmE2zM2tSl4niJVWi5GQ/B4fOVu9tlUjgynvZriJhFoq7hTZD
         t6bA==
X-Gm-Message-State: AOJu0YylR3i+JvsYhlWwZMA2r5yacrSJw6kTEW9o8uiIXfqPCf1vsQ9w
	F3XITwhxh6Qu2lbQqccy3M6wLNti82plL4apJPqX8JoOpOERPYFk
X-Google-Smtp-Source: AGHT+IF2GxvAjeDiXSF6GLyuxDh9BJgcMbwryKAGrX8RsjuVPXDVCE9uco4cqw9tZGd+ESQQW6juJQ==
X-Received: by 2002:a2e:80d3:0:b0:2d2:8c9a:c4e5 with SMTP id r19-20020a2e80d3000000b002d28c9ac4e5mr2272204ljg.18.1708976808940;
        Mon, 26 Feb 2024 11:46:48 -0800 (PST)
Received: from localhost.localdomain (host86-133-224-40.range86-133.btcentralplus.com. [86.133.224.40])
        by smtp.gmail.com with ESMTPSA id x1-20020a05600c2a4100b0041292306f2csm12728453wme.16.2024.02.26.11.46.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 Feb 2024 11:46:48 -0800 (PST)
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
Subject: [PATCH] psi: Fix avg trigger being fired unexpectedly.
Date: Mon, 26 Feb 2024 19:46:42 +0000
Message-ID: <20240226194642.47530-1-ppbuk5246@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 915a087e4c473("psi: Fix trigger being fired unexpectedly at initial")
fixes unexpected event fired when group->total accumlated for PSI_POLL.
But, for PSI_AVGS, win->value should be initialized with group->total[PSI_AVGS].
Moreover, to get exact initial value for win->value, it should be set
under each trigger lock to synchronize each rtpoll/avgs_works.

Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
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

