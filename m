Return-Path: <linux-kernel+bounces-75215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E045385E4CD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E35D1C23512
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F409085640;
	Wed, 21 Feb 2024 17:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFEXX01i"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5B485299
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 17:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708537430; cv=none; b=BnBeEkXO8vrjqtXpsDvpdtos6qm1m/CKy19uxvX4FgU1KC2g2riq/Keo1V8ta307drPQWk7CCYnpLZVvREYnxp7tsqkq+x5JZUO1YzboIP54/52nsn1XZikxmHZhDyUu3xZCuzzQL5/Zpdu6wTs1oOIe+4bKW3gSZf4t300k4rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708537430; c=relaxed/simple;
	bh=ZBeuvd+NyoO93pvV8f41PEEEKxGrVyRYzGq6EK/Bovc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HxPN2BDuq7PSoq5q6pdXLE6ptLdZSXbGzCdyyMbI3K4s1EFXogQtaA1kXTXUphpy4lBW4tpGiAm3lT33gakJPzHrhospO3lb03LUeq94y4GbezZun3MXTGBYiQOySx5ARHb5RrYklPKDMBh4pk83R/c6gcJKzSQvPyyiOXmn/D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFEXX01i; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5d3907ff128so6122368a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708537428; x=1709142228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDjrGi9Q0wrexX4b+X9Kwc6A2mH8Q8RC+mxLUguXsmU=;
        b=DFEXX01iH1ddtDWbRAdGAp8PzRjegx0ok/gk40t6H5d8C25F0qNp08in6kgwDf9j53
         9sIYR9aCZrdv9Bg97oDL7QeaGXhAlfUom+X41wNgHp0OZsw1Htz45DfbkElpsm6v//jF
         8N0yafiA9QuexNI5gd1UrNJwdPJMSp1hbz3e98eGPfQHbcOGUXip/cCaqYAIbD1jjViJ
         pM0Ke5ykdHg+cXPaGc+/aveAPbuFEsKcvbe0uco+axCC8gBxZ8j/PLrg7S3/UJNSmnW0
         pumqaNTZi244WQOFJ8o7oH04jEtwQSzbvKRfFPkPq98JDWl4mRgor4jQSrw3REHGEE8B
         erXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708537428; x=1709142228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LDjrGi9Q0wrexX4b+X9Kwc6A2mH8Q8RC+mxLUguXsmU=;
        b=dTgVoWgK9qQbdZspIiIO4wOykzPkK7izTu90QF1vhrqRAOOjHUuLHq0dTBHdM8iUDo
         bxAXeLqRZmCjdrIABqrTWDcVjUKM9S1+xkJGzVa8CLxS5VF3vWfVBrn29UkOmYrW/eBT
         1CqReTSBWCalftcaNHifyKaO5dMO0NGkQBzHDfpb9FI9XemcxMT/saTLuzrsQmwVgp0Z
         /JTtjTLW7ZY+6mJmrsF1wsl05QmsRBf5h+rYL6j00vyWC+uymXp/uc2EHF7TXXSv56da
         c7/IIULiZnDtw9Ow2Xo5CwBEAUM9m9hVejgaqTwf1EvwsqkpaVZVWeor8pL6yphiW35p
         N48A==
X-Forwarded-Encrypted: i=1; AJvYcCWa1itkEWRfdUH+7BUzuT4r24wIXFH0uzz2aQk/AhYTOeWgq+q2KpXj5XKUIC8b1MJPm0RueT6h26AhVEf0y2NOsVmZNtgFU8gmp6ZF
X-Gm-Message-State: AOJu0Yx2JuZyxvF0KzfNd9Di5PR1xOBFs5yNgJLqs24leqiR/4UZk8WS
	vnEE6vSqZsKMMXiySErt/Va7U0qTCXAm4uGffhip0x0t9RLgifB3
X-Google-Smtp-Source: AGHT+IGLAw4xbwhNMxJzjShqj/ztV8DsyGzJCo1CbKRokNIWHVJobubqeQQiLHQP0BkQhrNHzhS3HA==
X-Received: by 2002:a05:6a21:3403:b0:1a0:5841:6756 with SMTP id yn3-20020a056a21340300b001a058416756mr21805621pzb.4.1708537427901;
        Wed, 21 Feb 2024 09:43:47 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id w184-20020a6262c1000000b006e47ab9b2e5sm3973800pfb.215.2024.02.21.09.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 09:43:46 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	allen.lkml@gmail.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/7] workqueue: Remember whether a work item was on a BH workqueue
Date: Wed, 21 Feb 2024 07:43:02 -1000
Message-ID: <20240221174333.700197-5-tj@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221174333.700197-1-tj@kernel.org>
References: <20240221174333.700197-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an off-queue flag, WORK_OFFQ_BH, that indicates whether the last
workqueue the work item was on was a BH one. This will be used to sanity
check the context cancel_sync operations can be called from for the work
item.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/workqueue.h |  4 +++-
 kernel/workqueue.c        | 10 ++++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 86483743ad28..7710cd52f7f0 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -52,9 +52,10 @@ enum work_bits {
 	 *
 	 * MSB
 	 * [ pool ID ] [ disable depth ] [ OFFQ flags ] [ STRUCT flags ]
-	 *                  16 bits          0 bits       4 or 5 bits
+	 *                  16 bits          1 bit        4 or 5 bits
 	 */
 	WORK_OFFQ_FLAG_SHIFT	= WORK_STRUCT_FLAG_BITS,
+	WORK_OFFQ_BH_BIT	= WORK_OFFQ_FLAG_SHIFT,
 	WORK_OFFQ_FLAG_END,
 	WORK_OFFQ_FLAG_BITS	= WORK_OFFQ_FLAG_END - WORK_OFFQ_FLAG_SHIFT,
 
@@ -98,6 +99,7 @@ enum wq_misc_consts {
 };
 
 /* Convenience constants - of type 'unsigned long', not 'enum'! */
+#define WORK_OFFQ_BH		(1ul << WORK_OFFQ_BH_BIT)
 #define WORK_OFFQ_FLAG_MASK	(((1ul << WORK_OFFQ_FLAG_BITS) - 1) << WORK_OFFQ_FLAG_SHIFT)
 #define WORK_OFFQ_DISABLE_MASK	(((1ul << WORK_OFFQ_DISABLE_BITS) - 1) << WORK_OFFQ_DISABLE_SHIFT)
 #define WORK_OFFQ_POOL_NONE	((1ul << WORK_OFFQ_POOL_BITS) - 1)
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 9529ab1d9464..a03252ef3c8f 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -759,6 +759,11 @@ static int work_next_color(int color)
 	return (color + 1) % WORK_NR_COLORS;
 }
 
+static unsigned long pool_offq_flags(struct worker_pool *pool)
+{
+	return (pool->flags & POOL_BH) ? WORK_OFFQ_BH : 0;
+}
+
 /*
  * While queued, %WORK_STRUCT_PWQ is set and non flag bits of a work's data
  * contain the pointer to the queued pwq.  Once execution starts, the flag
@@ -2111,7 +2116,8 @@ static int try_to_grab_pending(struct work_struct *work, u32 cflags,
 		 * this destroys work->data needed by the next step, stash it.
 		 */
 		work_data = *work_data_bits(work);
-		set_work_pool_and_keep_pending(work, pool->id, 0);
+		set_work_pool_and_keep_pending(work, pool->id,
+					       pool_offq_flags(pool));
 
 		/* must be the last step, see the function comment */
 		pwq_dec_nr_in_flight(pwq, work_data);
@@ -3163,7 +3169,7 @@ __acquires(&pool->lock)
 	 * PENDING and queued state changes happen together while IRQ is
 	 * disabled.
 	 */
-	set_work_pool_and_clear_pending(work, pool->id, 0);
+	set_work_pool_and_clear_pending(work, pool->id, pool_offq_flags(pool));
 
 	pwq->stats[PWQ_STAT_STARTED]++;
 	raw_spin_unlock_irq(&pool->lock);
-- 
2.43.2


