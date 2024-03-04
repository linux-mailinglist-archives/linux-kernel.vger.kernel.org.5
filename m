Return-Path: <linux-kernel+bounces-90351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B8286FDFA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15AA9281AC6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C669374E6;
	Mon,  4 Mar 2024 09:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4G+Wxmq"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8452E417
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 09:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709545731; cv=none; b=QAxSP+gp5Wl6KA3llXTU6Bc74t8Niyty0PV9bLUMO7WrRqX20MgfITUIVdEGw5CsJrb0IFa4qg/S4ZYVGqSztIb/D40qbTbcodjRewjMlSYTpCCMNJJbwoWRUrBaZihqXtxjtOGkUwaQYe2gvASoMm6grU1aTJ/U/FToucHz0lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709545731; c=relaxed/simple;
	bh=H3dfBXEqvb28jdKvV+Cdvj0UO1ctCgFEa2CewBivLtA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JMvbvl43yD12wsLt44L9L0hVlf9D8B9LQYMRJHCXejGQ8eZAzXBMuQRnUx9Hv8NZ1iRMQghho4dxG3kuI63UeF952i0hfsLqCr6lKfM3ZnXlz7OpiQ13iv40mjUx7yUF3yKFtj6ASdgKQDYou8Y852eR2Tb0GTTiVkm02kXEjns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4G+Wxmq; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so6023526a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 01:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709545728; x=1710150528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqR7nteE4ruQbqsw6BhW1LGgKQJj5d/ALkmGz5hjH+Y=;
        b=d4G+WxmqMg3beqd+PfR4o7lvYBTfL7bT//WmwnQe793IHxYzXHE/hLyCUOpG6GP5cq
         POAMokrsmPa+Zc2rDWuJKUZ1QGJPGB0Tbtr271KwT3V9uJN1gF8aBkm2V1eZr0wLALuk
         HVHChznsOzFYM0wCZlxgL428e3CbtA6F4uCM1ZsxQgjwes752arDNFFvhy4xvN1rCO3+
         x6zXZS35qVZONLK5qz3BKnArzWR2trrTXcEKbjd8PKY+Tjdsj1qZwk8KKI/dl9PvYjNb
         GDu+JP2yXPSMM0vIGTpMs57gnaKxUzZU587pYSn8ubJuRcgwOOEnSkw7KytXT85Neb1i
         JX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709545728; x=1710150528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sqR7nteE4ruQbqsw6BhW1LGgKQJj5d/ALkmGz5hjH+Y=;
        b=EEEqXTzGsnPV2CAv9iem4AmndKxNzIywc2xpr+wzOkm5CvcdBvDoFDf8V++LeJ3Nh5
         qq34stXpju4Z3GaQ1PX5Oq4eNW/bZDgNMl28K6vYNxFW+u8ihBSMy5FhFkvcOD6FOhSg
         95IBjA3dipX9buPW4Bkg8QYCeHLIsAS9r3FIhtGkcKOagj2DhUiA40ucqHfyNx3K7DiB
         TanM2iwvms/dZnaDNyCobl52QJ97nVUM91FYf5dyw5KYak6sZafIuEj4Ju7C06VyLG5E
         UGc4o4tQBlnpqq+BmPZops30QSrkQ6WylrHx/bq7kFU0QJ986pSsy5iRxpYVD2lMNYmF
         2wCw==
X-Gm-Message-State: AOJu0YzeM8VBZGTTpsw+BrEnDHKx/Hd5h55MaOD1UD+vTCQ9T6jfeFsq
	2ARyHk4yAaHtqRGwXwF4W3YrbZMqTPus+l5qlgA9oy0YpsSN0/yr2u3qvgH8O9w=
X-Google-Smtp-Source: AGHT+IEIb82ASF63g7U6cQk+RqNpM8swI2FcerhLv8ZKltonxWReDLw35KKTRPUiHVycIVvQz0QZwA==
X-Received: by 2002:a17:906:19cf:b0:a43:ab98:d376 with SMTP id h15-20020a17090619cf00b00a43ab98d376mr6130002ejd.15.1709545728607;
        Mon, 04 Mar 2024 01:48:48 -0800 (PST)
Received: from kepler.redhat.com (1F2EF13F.nat.pool.telekom.hu. [31.46.241.63])
        by smtp.gmail.com with ESMTPSA id s22-20020a170906501600b00a42e2bc82dbsm4569839ejj.169.2024.03.04.01.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 01:48:48 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH 6/9] sched/balancing: Update run_rebalance_domains() comments
Date: Mon,  4 Mar 2024 10:48:28 +0100
Message-Id: <20240304094831.3639338-7-mingo@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240304094831.3639338-1-mingo@kernel.org>
References: <20240304094831.3639338-1-mingo@kernel.org>
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
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Valentin Schneider <vschneid@redhat.com>
---
 kernel/sched/fair.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4c46bffb6a7a..18b7d2999cff 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12409,8 +12409,13 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 }
 
 /*
- * run_rebalance_domains is triggered when needed from the scheduler tick.
- * Also triggered for NOHZ idle balancing (with NOHZ_BALANCE_KICK set).
+ * The run_rebalance_domains() softirq handler is triggered via SCHED_SOFTIRQ
+ * from two places:
+ *
+ *  - the scheduler_tick(),
+ *
+ *  - from the SMP cross-call function nohz_csd_func(),
+ *    used by NOHZ idle balancing (with NOHZ_BALANCE_KICK set).
  */
 static __latent_entropy void run_rebalance_domains(struct softirq_action *h)
 {
-- 
2.40.1


