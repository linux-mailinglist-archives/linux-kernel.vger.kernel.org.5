Return-Path: <linux-kernel+bounces-39004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4351D83C98D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE8A2283403
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF2713E23B;
	Thu, 25 Jan 2024 17:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CP8iY8hx"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDDE13E217
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 17:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706202403; cv=none; b=rotV7Lu8/dMlp8dWBMuWPfUBhcwbGjSDYLOEZqwZcjYuf1vhmg3294NKHPbClsNOqAxglFRKuiQ88cgIoBH9dNOQXN1j9Xdn6X2W/uuHkhM2LKDCFZ3yehKZvW/UlTGqQHLTwHa9QpbdBLviujgJWXTTDAtIWLoYI+wQuul8yxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706202403; c=relaxed/simple;
	bh=4QEScTWZeMXuR6EMVgA7q8PtQ0FRcx37UQIneiCdlUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ExMeKngVXEr74l+BjomRsOubKQ1/6oVr3dqxVDgtTGxI8eNoxIRO770yvNU+eVX9EUxp2kEswpwIXiHB+gqQNUKTNA8drpFaaXOrjjErRQOIFm3t0frU9k6D3vx3/6u3remlYezbJ9k/nSAtqpOpgPA+M1NgNS3Khidp1dIq24g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CP8iY8hx; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ddc0c02593so1337507b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706202401; x=1706807201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O07DQhiSnJ3njKpY0a13YAWlJTYhBSuVhQHUWKAk0+M=;
        b=CP8iY8hxm74gV2+Qg4a0M/HVdJwl19zLp2dKcZCLgkvvKozwmDgZtsjO11ssfZjbUV
         M0AVD31ZbUruFlWQZeCg9PYXw0THDjoiThcQ/vk7SwkxGlnpX+I9TlmSuWKrtUfNf6kg
         2g1akJZGG8j0xgIhaUGKSq/DwDdKA6KfmrWfMEtkWfOV9LWzSlpQjXKGpGe5OREU3GKt
         0k9fQRjsTvzlCdwffwK5kTFlAztm2NpbMvqn487kV9s5D6z3x0w7ZLJ3nAqnGCpy1Jld
         Q3jIzcUgziBsQXe17KFQKSbrBFjtjSxywGNV2Ka5k4mHtxjNW+Uj3cgmRRE3YEqegjdw
         T/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706202401; x=1706807201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O07DQhiSnJ3njKpY0a13YAWlJTYhBSuVhQHUWKAk0+M=;
        b=qyrPJqivDeBnHPGU2WE35U7Zi2/t0k7YfZgkXDHPTLxiFI+xyrUYIcmfJ2jsYIDz4t
         rZowFoRFpPCu2mJAToYouxcMuZvCr6ZJPVX8FIRGcgVDlx9McOzKoTmTxACud7QibRRb
         ZYAAIpb9FLuRTFBcBaLsss8kQyPom0JLwyoikxLfeUNWHNJ5VsawTwFDYZgrA9EBmjeg
         h9UGN8FYmfMjcwTvn7QrmInSPouMS1bk0IXhkFbgd8y5N81OAiF0ydCxSJve/nb2dHuE
         TGitckH+vs4YbKAGuvr1O/hVMcILvzbK+q2R3W51B3bOOM3FDwP27qUm4iBEin0Caqde
         VF7A==
X-Gm-Message-State: AOJu0YyFWZMVt3AGJgumnuNGarGuD0eczfpEuts4gnRcIS9PA9Mh8hAT
	Zd+QGQCbQrmmwxA0eNerCL6QbKOKkGk+k9FJ0R4OcpGsMpgWS2Ju
X-Google-Smtp-Source: AGHT+IEfsmLhKtAlcqc0gc2iPELtj82Gfsxx0/Vj7Nx5hZDE4k/mXEg5FVQylc6qi3an4qjBj2PIAg==
X-Received: by 2002:a05:6a20:7d86:b0:19b:81be:34e4 with SMTP id v6-20020a056a207d8600b0019b81be34e4mr1268569pzj.50.1706202401280;
        Thu, 25 Jan 2024 09:06:41 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id 20-20020a630f54000000b005d2ea240d88sm4935987pgp.9.2024.01.25.09.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 09:06:41 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: linux-kernel@vger.kernel.org,
	Naohiro.Aota@wdc.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 07/10] workqueue: Move pwq_dec_nr_in_flight() to the end of work item handling
Date: Thu, 25 Jan 2024 07:06:00 -1000
Message-ID: <20240125170628.2017784-8-tj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125170628.2017784-1-tj@kernel.org>
References: <20240125170628.2017784-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The planned shared nr_active handling for unbound workqueues will make
pwq_dec_nr_active() sometimes drop the pool lock temporarily to acquire
other pool locks, which is necessary as retirement of an nr_active count
from one pool may need kick off an inactive work item in another pool.

This patch moves pwq_dec_nr_in_flight() call in try_to_grab_pending() to the
end of work item handling so that work item state changes stay atomic.
process_one_work() which is the other user of pwq_dec_nr_in_flight() already
calls it at the end of work item handling. Comments are added to both call
sites and pwq_dec_nr_in_flight().

This shouldn't cause any behavior changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 1bca0a4ab9d1..38d4957b08d1 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1583,6 +1583,11 @@ static void pwq_dec_nr_active(struct pool_workqueue *pwq)
  * A work either has completed or is removed from pending queue,
  * decrement nr_in_flight of its pwq and handle workqueue flushing.
  *
+ * NOTE:
+ * For unbound workqueues, this function may temporarily drop @pwq->pool->lock
+ * and thus should be called after all other state updates for the in-flight
+ * work item is complete.
+ *
  * CONTEXT:
  * raw_spin_lock_irq(pool->lock).
  */
@@ -1707,11 +1712,13 @@ static int try_to_grab_pending(struct work_struct *work, bool is_dwork,
 		pwq_activate_work(pwq, work);
 
 		list_del_init(&work->entry);
-		pwq_dec_nr_in_flight(pwq, *work_data_bits(work));
 
 		/* work->data points to pwq iff queued, point to pool */
 		set_work_pool_and_keep_pending(work, pool->id);
 
+		/* must be the last step, see the function comment */
+		pwq_dec_nr_in_flight(pwq, *work_data_bits(work));
+
 		raw_spin_unlock(&pool->lock);
 		rcu_read_unlock();
 		return 1;
@@ -2777,6 +2784,8 @@ __acquires(&pool->lock)
 	worker->current_func = NULL;
 	worker->current_pwq = NULL;
 	worker->current_color = INT_MAX;
+
+	/* must be the last step, see the function comment */
 	pwq_dec_nr_in_flight(pwq, work_data);
 }
 
-- 
2.43.0


