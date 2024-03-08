Return-Path: <linux-kernel+bounces-96883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DCB876292
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 542991C216CB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37EA56479;
	Fri,  8 Mar 2024 10:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2o4lpIO"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6007655E5A
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 10:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709895560; cv=none; b=pEGknppArSd4lGkfHhkXdjb/bZja/jF8lD9MqfyjASaGDxE6tJg/SwSNSUG4HI3d5nWjgIkxX0NG9SZrP4prFaMOqFBYsUMq0a6wY0Y0edPssIzp3rGhwi5c+4HTpyA1ECGoClAxxOWbOdMGUGhljqSvORxTW6fFT0ziZu5u/7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709895560; c=relaxed/simple;
	bh=JagAYaWf++ODRpywnfop8bzRaSlCWa+JwvJsgilSydE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DY+vAqNBg7gO9qFcr5WxMCPCaOJBNU6xgBkgLiT4iZMsKesk1o/UCpBBxogpCo9LLV3ysUZBWqJC4GdQCRtPSycodFrVJfJodRJdfX6VhZ7cEbpnr5UjEg75WeAnk1rzNWiFOozFhzOMW5Ig4Mbo4ZmMZVV+2+6nym53dVdvo1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2o4lpIO; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4131b27cda2so2146665e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 02:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709895557; x=1710500357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCECdkdBNez11DlTdqaYyAJcVrugZwGDKkCobhbfy9A=;
        b=S2o4lpIOocwvHH4mucVu7cILQntoF6sZ7rRA0CzjUyqnhqTjPSz5D4hxwZ2TJFylQz
         KfMXFtNe21uXAKiqVhmlA+5nhAE1FUH7iqqpVxUIXK6v+RO7xDo4AElHr6Cu9olGEwQ/
         GERlSxWvxcPpGBkUQkNJ3w+AJYSwoCjAHUh2B3B6Rffi/SERIREE+Iq9nFy9F+vKDgpK
         X1y+6GePnQlxinCsQIbCX3q3t/ekmI8KJmbPGxfhhv8P5iL5YaYMNl6dpBJe7mNI4SP1
         63S5WOUzRXXAfLI3CsaU1TqwECS2Jnk8iaZGNgbv3g2oUYWMMS+UsjKKVo1D83HOoj5Q
         ab5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709895557; x=1710500357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kCECdkdBNez11DlTdqaYyAJcVrugZwGDKkCobhbfy9A=;
        b=Z7/LtDbrysFuX04/P1WFZhJxUOdj1849tYmAHg2lzwUotfWp2DgK4ozhQbEz8iMoDz
         r+iQN7BAl9xMDC4wmvLHkXvazl7KzIZ6PwKH+ia6Z7zltTd/wnA1s2NlVVakXRXDebv6
         /Nfr+r4Dg2fEtrakaZZl80rb8Xe6ELGxagWF2e6EVsX++M2vebKVmzHs4DHI4E6Gov19
         aSa7vIE1V9U/NWVEkDFtvqVS+OCD2BIt05Pj8CAwDxVlL/gokteHDrtPkcZ+1O3zzseV
         6MypNgu9snJQVCdaPewrWUmdWhokGw7GFjwIqQPm1OcBUD5VCT1YxF8O9E77x3iPJpuL
         aCWw==
X-Gm-Message-State: AOJu0YwIvUHwJUVq4UpblVfVWklNro8mGjNgMmXX7JoIFEbpzWUwO7fz
	AqkU28uW4Ek9eLBes9ZUgK1jp1m6aY/84WfOVxMh4vGzU+DlK4Sp8y6cLKaw3sw=
X-Google-Smtp-Source: AGHT+IERVUUUBh21Wd3Ab6xPzr2OYcduLqq4LxXwVQg6KjxFXWFCWz6L4f8+e7khx35szexroy9U+Q==
X-Received: by 2002:a05:600c:1f13:b0:413:1ae3:6acb with SMTP id bd19-20020a05600c1f1300b004131ae36acbmr751599wmb.26.1709895556402;
        Fri, 08 Mar 2024 02:59:16 -0800 (PST)
Received: from kepler.redhat.com (1F2EF3E5.nat.pool.telekom.hu. [31.46.243.229])
        by smtp.gmail.com with ESMTPSA id g20-20020a05600c4ed400b00412f679bae1sm5632382wmq.26.2024.03.08.02.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 02:59:15 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 02/10] sched/balancing: Remove reliance on 'enum cpu_idle_type' ordering when iterating [CPU_MAX_IDLE_TYPES] arrays in show_schedstat()
Date: Fri,  8 Mar 2024 11:58:53 +0100
Message-Id: <20240308105901.1096078-3-mingo@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240308105901.1096078-1-mingo@kernel.org>
References: <20240308105901.1096078-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shrikanth Hegde <sshegde@linux.ibm.com>

show_schedstat() output breaks and doesn't print all entries
if the ordering of the definitions in 'enum cpu_idle_type' is changed,
because show_schedstat() assumes that 'CPU_IDLE' is 0.

Fix it before we change the definition order & values.

[ mingo: Added changelog. ]

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Valentin Schneider <vschneid@redhat.com>
---
 kernel/sched/stats.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index 857f837f52cb..85277953cc72 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -150,8 +150,7 @@ static int show_schedstat(struct seq_file *seq, void *v)
 
 			seq_printf(seq, "domain%d %*pb", dcount++,
 				   cpumask_pr_args(sched_domain_span(sd)));
-			for (itype = CPU_IDLE; itype < CPU_MAX_IDLE_TYPES;
-					itype++) {
+			for (itype = 0; itype < CPU_MAX_IDLE_TYPES; itype++) {
 				seq_printf(seq, " %u %u %u %u %u %u %u %u",
 				    sd->lb_count[itype],
 				    sd->lb_balanced[itype],
-- 
2.40.1


