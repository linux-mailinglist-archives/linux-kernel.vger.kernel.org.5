Return-Path: <linux-kernel+bounces-96885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3325876295
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C86E281D36
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993BA57892;
	Fri,  8 Mar 2024 10:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IObQntos"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E6F55E7C
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 10:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709895562; cv=none; b=KJmx4EJ51RhhiEfoexwuGwfNSG/+My3wjGlfUZIvAo23U0dZ3h2/XCbaAa9fT3hZ5+DGujB0jeyp88eDuu6RjBMVxH+e30+OG3OCwqq+1AIZX1uGTtJOn0XkPS87WkkfLFJy7S2dLPr3iSjpGZ/W+Ek6oF4zMGJfWwYvONBAG6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709895562; c=relaxed/simple;
	bh=krbxrxofvU3bNtV7aKPXLRF9gzUuYzAL8MX80bNIYPU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m0skH0tElI/BTCSQ4VvszHydVfefYemL7gNNTYv9RSJzxxRQ6Xr0zINxDKSDjSYqPyOjKRakCVkKDRgPqIz1UGNK8r8tNH9LCWsphyrLt4PFn8QhS2jsoDGCI72JKwoMXQeYIQe+HlRoQP6b4LxZ8oB4te+1vfrfweXYYW7Tudc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IObQntos; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5134d7e16a8so1722436e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 02:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709895559; x=1710500359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6OlRhqx5GPQQyNuVhSp2D6im2dbAlAubZWjZjVrs0g=;
        b=IObQntos4zSlSpz33iqmTIo/SexIRY7J9cVs8IILs99GHpBrY5j540Rp3SbIMGK2vg
         tQ7UnvGyq3dZtzJpGu6H5khFgodrvJybGOyUBV4Q7B4TVBan63I2jasWzd0uacIU4DR1
         uxO5hlIK3tbH6CxvX7kpJouG59FiblrFc4Lm6d9nRxvl3H2955q/uDMTnNzqyNDmukK/
         +Wstli6TxJfYQaPAIfS2fANb52gIH5+BlhuErCPMzqGzsyAlTKFPtcCR5vydQ71PU3YR
         w1H1vb+RLqzSgy7ACYLMkvQ2LE1LYrqFMhGrRQ+XkxzOrD1T01tKDG+rmObqo5Zkzqnp
         nrTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709895559; x=1710500359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C6OlRhqx5GPQQyNuVhSp2D6im2dbAlAubZWjZjVrs0g=;
        b=MbgJZpxXpF2hMen0DI4nJ8Oy0hg1L0ZeeoMyyeAo2eaOel36WFU5kI8bIbOv1dKybr
         HVGgpYNmRsZqfo9/L0dIWsblMN3U+uVQG0lAMbrRZcUMCXYTg4gJ76CP4wkj5sRqlzPu
         BlkQDcLb6VLvH1iTI7a1AoZtuVZ64kljM03KQirTq+ztZolJ8iOigehpQkSOCMXxevPV
         BbYd32U/WCX202sH5KtPPPRLTAGfnO5uDWl46QQSklJfr1RCETBBV2wfl5Bw2l/wXpuF
         gqPNvOE4jwbYQ7jIct1UR/hyIoUwAorBdDKt31hwkXWR3OG4OwmU+ZyvTPPflrPGHsfi
         dtxQ==
X-Gm-Message-State: AOJu0Yyy6Dfp2EE2gSnd31DxnJQqzep9v1dumubavezay95vBUZnrFOd
	yAfIHmaVYEBytFiUECXwOO8Z3LQDNtTyvkxKmr5oh/KjrTE4srTM1Stxucj3Qgs=
X-Google-Smtp-Source: AGHT+IGBAIlaoj7aRO2Usvo2XvWB9spb15J7P0KvkzOFSOxIE2BZ3lhAv5Rwpi7GfZCMX3uow8kflQ==
X-Received: by 2002:ac2:4d8b:0:b0:513:351e:3204 with SMTP id g11-20020ac24d8b000000b00513351e3204mr3533270lfe.26.1709895558500;
        Fri, 08 Mar 2024 02:59:18 -0800 (PST)
Received: from kepler.redhat.com (1F2EF3E5.nat.pool.telekom.hu. [31.46.243.229])
        by smtp.gmail.com with ESMTPSA id g20-20020a05600c4ed400b00412f679bae1sm5632382wmq.26.2024.03.08.02.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 02:59:17 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 04/10] sched/debug: Increase SCHEDSTAT_VERSION to 16
Date: Fri,  8 Mar 2024 11:58:55 +0100
Message-Id: <20240308105901.1096078-5-mingo@kernel.org>
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

We changed the order of definitions within 'enum cpu_idle_type',
which changed the order of [CPU_MAX_IDLE_TYPES] columns in
show_schedstat().

Suggested-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index 85277953cc72..78e48f5426ee 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -113,7 +113,7 @@ void __update_stats_enqueue_sleeper(struct rq *rq, struct task_struct *p,
  * Bump this up when changing the output format or the meaning of an existing
  * format, so that tools can adapt (or abort)
  */
-#define SCHEDSTAT_VERSION 15
+#define SCHEDSTAT_VERSION 16
 
 static int show_schedstat(struct seq_file *seq, void *v)
 {
-- 
2.40.1


