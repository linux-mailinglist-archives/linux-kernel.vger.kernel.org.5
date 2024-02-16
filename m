Return-Path: <linux-kernel+bounces-69132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E138584E0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6F6F28458C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518491350FE;
	Fri, 16 Feb 2024 18:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqMkOVwh"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31DE145B09
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 18:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708106801; cv=none; b=i9wCor4jx/Qk4Whf4zbNmLaiAVXM2qt2FcwoY37IqBrzF2yw8K+jT5QpO3Hwz1LFLglMFStm7v8YMzUTdHpXj63A39Pvyx4DSvoL3cRwIZt3/v+wDx5iCIF7cW+RDxEJYCvpcftFOfxx+ytQjsGmVDA/dtC2gwInAyt6GVbAERE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708106801; c=relaxed/simple;
	bh=z0GyY03vKK4q1rF1q8Nt5aQw7DEoslNs5/981jnsvW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ukRPaNZm/m85+VzzBxy1XqlUGpLZ/zKpOsdCWII83fQTXmRhXysZ9tnhF2gfWu4uMYv/tXlvGGrKsCRrMP3/Yiav9b7bNQrFxPRTKCZG+cjx000ksy6hu+XrqdnqBtgdm2fOMYEyPA9doB7FRbW2gkCLHlcYPhciG97O0olL02E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GqMkOVwh; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1db51e55023so15744985ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708106799; x=1708711599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zk4Yw7otsNk9FpXH6NBaGmePt/Pu9b2Fl+Zht6UJW3M=;
        b=GqMkOVwhuaK15WeXyfpOf/8VwkZGR2kY0Pi5tX1jOXiKhotyFxd8IZFaHztDbW4Ahx
         Qi+4C+E0IW8NX1OAnrqhmHfJDdXcuY4s0IAsc9n+mRizGErC88xxh3CdIWgxk/dTHrdR
         p8JgkSM5EnnVbffELdxkQuktFjv5ccsppWCtcj0EL9Cx6VrEJ2yEFXH1mmp98Vh82RRF
         5UOlmYionERCyBo6p/JFEs0ItoYjIqpaqkSrVmPxjkpe3STnh/lmgddaLOdk7+qr7mMA
         Ik8I1bPTWmb7tI8WC8YtkZr4KaGPoM9PV5wEM6TBsxxykrXkMi8uv075xgs6XiTX0bo1
         30LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708106799; x=1708711599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zk4Yw7otsNk9FpXH6NBaGmePt/Pu9b2Fl+Zht6UJW3M=;
        b=jH16EgS00kl2XUyEq35Wpor8w15oPV2KKlemr6qPRayuo4mybQxq1BvbcscYu2rIUy
         6L+luN5h9FEwjJ0vz7ODRNAT9Tp8K4vuA1W3LiOoNFbpcCmF7Jf/qvPPsxBHSzDr3ghR
         66pVelxaniyOnXI33tkt6NTTBMigexoeFzQGUx1EtZ/4HyagyhJ+pbuliDAeH9A4FM2P
         EnXCtfIRlHjsFxkVcqFbLp+9NFm3hM3yuiHerse/KigzY/sPRvRs8JFlIENpTnfES2dY
         D+3HJz006xV7S5liRYNwxhqZ7pJvBgQHgV98tAzw31aUzqr8E0UwZO+516S5uoAi5eu0
         qIUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCCATgZk+O+jH0vRk5aflmFAtk3OkXRmDoRReRQIkGY+sxkCTxBErxIfpoNbUterXDq0B3zIpfrc9Yf7jNsiBfA6MFrl3rxuY82cA2
X-Gm-Message-State: AOJu0Ywu8MitfxioC8v9SO+Vel3akTNqGhrTDzcP038lE1auOBkVGnBB
	hDWuMvxJqnSA9hnCXUhRYSyJXmXfW81FHirQMrqeEYNerAD1hrXM
X-Google-Smtp-Source: AGHT+IEgxadNhFoisXolslWTcBY0ZK9QbF4dRH9KoL/v1zxfLvJdMLi9sOaXCIoagOSds75DzyLYdg==
X-Received: by 2002:a17:903:2593:b0:1d9:9c67:58eb with SMTP id jb19-20020a170903259300b001d99c6758ebmr5435411plb.30.1708106799261;
        Fri, 16 Feb 2024 10:06:39 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id kn14-20020a170903078e00b001d8f82c61cdsm146168plb.231.2024.02.16.10.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 10:06:38 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	allen.lkml@gmail.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 14/17] workqueue: Remember whether a work item was on a BH workqueue
Date: Fri, 16 Feb 2024 08:04:55 -1000
Message-ID: <20240216180559.208276-15-tj@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240216180559.208276-1-tj@kernel.org>
References: <20240216180559.208276-1-tj@kernel.org>
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
index e9d25e1f79d7..6a2abc81ae2b 100644
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
@@ -3154,7 +3160,7 @@ __acquires(&pool->lock)
 	 * PENDING and queued state changes happen together while IRQ is
 	 * disabled.
 	 */
-	set_work_pool_and_clear_pending(work, pool->id, 0);
+	set_work_pool_and_clear_pending(work, pool->id, pool_offq_flags(pool));
 
 	pwq->stats[PWQ_STAT_STARTED]++;
 	raw_spin_unlock_irq(&pool->lock);
-- 
2.43.2


