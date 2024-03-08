Return-Path: <linux-kernel+bounces-96889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B9E87629E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0333F1C210CF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7AB5B5CF;
	Fri,  8 Mar 2024 10:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBySYHTE"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5123658239
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 10:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709895565; cv=none; b=gpDKoa/9k5y2b3o4rynY57grkVzqy0dgXn2F+G5TH9a6BuXCy/nsVQhKkBLWt1gyb8u8B8N3AVw1+UnUid9781XPdHsP5nbPWIVl4d9KQDUY5oXfVYxsCXf9vlbbHZ+LxM9WX5rIRuImf1JwbTbyFSZ1BXGRDEW0WVigX+HCp9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709895565; c=relaxed/simple;
	bh=A3rn/di0TQLpQiYh2AGCJI+ueeZiWtNVcO2Lb3sTkRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VPR9yPPf+vd8ZnN3ty3IkgXxJ3dwz++nAOwU+TfD+n1FxBgeZghkS/WsWSfGDHUUJEBHaCEcxQUGyIqZHTQZXBlKpE5uGzwxHmwhwEfArjNJ6IWNBFhDRFjnZ71BOcnnqgUFOojDi/p16R/pgEmPyJQ2cuk5eG7fJy70rAEvQTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBySYHTE; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41312adc3deso10654895e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 02:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709895563; x=1710500363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AmmiIoTIOSqOS6k+PYGbdPJRqghLzMN0dL6QEudSlAc=;
        b=QBySYHTEFWqpIrifQ6f7VgPEmzf8YGin+3nuw0TjPdx7crmuy/lafgKZDkoc6JG5JZ
         QvVi59ug9JwSzjB70ZOveaNCQTT59NhR++sy1lectznZyLum4rVXlkjXI0b+2e4pBS0B
         vhF/AWf6GG7G87hJb08HpjQyPLakw4YXbYHy4TVbwoKiuKFjFC9XDQDX0he8AKjoCxI9
         X1EMjkk5b8lxGOfN6zjHNsSBq6+4A2wC52tulDn03qlEXgYYTZhnlacqCoYp8DKJhRWs
         iJRCHmnvnIF20wuzSIhl0NlRkSUVomfPCYO/qsQdDmJcm/Nn4w9AMwRZrPgXtgv4nZE3
         MN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709895563; x=1710500363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AmmiIoTIOSqOS6k+PYGbdPJRqghLzMN0dL6QEudSlAc=;
        b=nM1ITqX+zmbOqohO/WfOglW8rHqG/IJhPx2x80aFCfHPqaJIToksP1C3Qj+RsSEP45
         83OJsCZbQb0r6esjS7V9lMW0iEGY7CMggkUNVEMAadh1FsNyEfyi5GpjtFn3m/c2KZeE
         y4QWhNIvgU0CwZmTSYp1vjhUlFGZ12k9p/7d2vnP/xXLLLnxSHUAr5UktOtM8YPxZpSH
         iAKVoI//VeqXg8HZU0WPmV/TWovqyQJ5/yntLl6jAs9PeXNFhWGVHA1BNL34CUY4eP84
         FMVKDPfzaJ4D6miFQQfKwpbriP0r4TOtc+AUknXJa3pbUICG9Gy+zUeW40ypYZFuQgYj
         689w==
X-Gm-Message-State: AOJu0Yz6+NDQvJzES/Dob6ERn7Jljy+sWUM19b2PhUaVhfRN0VnyrOnw
	4gZvwvPZGvbfRlqOZHoBh2g5mREJMGfarmpzjso6sVsJEk+zIV7C7ZsaxMHeGPE=
X-Google-Smtp-Source: AGHT+IFaj/wYXB+SZg6AFczDOjTIN8/CaZvDV4ePDIOFHebKSslJo+jPufqL+3Oi+Gpgu5us1jT0/Q==
X-Received: by 2002:a05:600c:1549:b0:413:1047:362f with SMTP id f9-20020a05600c154900b004131047362fmr3234852wmg.30.1709895562580;
        Fri, 08 Mar 2024 02:59:22 -0800 (PST)
Received: from kepler.redhat.com (1F2EF3E5.nat.pool.telekom.hu. [31.46.243.229])
        by smtp.gmail.com with ESMTPSA id g20-20020a05600c4ed400b00412f679bae1sm5632382wmq.26.2024.03.08.02.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 02:59:22 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 08/10] sched/balancing: Update run_rebalance_domains() comments
Date: Fri,  8 Mar 2024 11:58:59 +0100
Message-Id: <20240308105901.1096078-9-mingo@kernel.org>
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

The first sentence of the comment explaining run_rebalance_domains()
is historic and not true anymore:

    * run_rebalance_domains is triggered when needed from the scheduler tick.

.. contradicted/modified by the second sentence:

    * Also triggered for NOHZ idle balancing (with NOHZ_BALANCE_KICK set).

Avoid that kind of confusion straight away and explain from what
places sched_balance_softirq() is triggered.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f3c03c6db3c8..b567c0790f44 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12409,9 +12409,12 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 }
 
 /*
- * This softirq may be triggered from the scheduler tick, or by
- * any of the flags in NOHZ_KICK_MASK: NOHZ_BALANCE_KICK,
- * NOHZ_STATS_KICK or NOHZ_NEXT_KICK.
+ * This softirq handler is triggered via SCHED_SOFTIRQ from two places:
+ *
+ * - directly from the local scheduler_tick() for periodic load balancing
+ *
+ * - indirectly from a remote scheduler_tick() for NOHZ idle balancing
+ *   through the SMP cross-call nohz_csd_func()
  */
 static __latent_entropy void run_rebalance_domains(struct softirq_action *h)
 {
-- 
2.40.1


