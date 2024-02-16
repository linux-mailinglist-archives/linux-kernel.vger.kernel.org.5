Return-Path: <linux-kernel+bounces-69124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B04E88584D7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64AE9283778
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C798136662;
	Fri, 16 Feb 2024 18:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdbbcaFM"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EE11350F6
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 18:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708106786; cv=none; b=GjZT1E1EKhQhRudX6b148zIteTYdIeKQWw22jLAbfVHzoTDXV/HlHtYnIpdeiTAjVUi8VHBaY+S+6s2AiD0bS8FAWicizGdn4DmdehzP5vJk+l/WGICo7WMq8ER6+f8e4VESeHxF9q03YFoxM9VAIBxpDh+ceB4aud0jGLnDg/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708106786; c=relaxed/simple;
	bh=EnYPc6hrKRSIFSoUsgaDvii7SmmceMlHcVdpQXbdsuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDP84rDzk9drakkuA7PsOPbgBs0tApn40uohfSgXFsNmmEU0if3cPd25lO33XZhN34YaXfw+cjfKFmq6IEfW26YbIaEUgx2TgnnA9b7AGckfOCa8HtrhPfToKavPaMpn2C6RTk1pT144exr81X5pePCWku/cgUKXzQwNO+pTRuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdbbcaFM; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d7354ba334so21020085ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708106784; x=1708711584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THTKmyp+zgWOjBKgKcw4Z+riVlmxEgNDNx8pO3NcTsI=;
        b=gdbbcaFMNY/ebW43+vxgJooQrhcl3/BE94BYK16j+YHCfaGbOuQ5kK6KonUOZIR5qr
         4TUhnoSrobYQOarxx/dKlLd/xwlsTvcd/WQFy82fg0jJ/lqpAZjA0+y7s7Byxa+Fxmyz
         73zkW5IyM0pMmEDYblGav90tm+sPHkVeFiczjf6/NNWU1hzhWfApmZPNPA06MXvGItpw
         gYwziVVTIJ9Nv+PYV42SDqX62ZSyHE9NE4p2VJdRGCimxj9pqvp0lKGqIdRrNq1hE21k
         aJiAC7fGFBv6KhNAk6da8SnWgL3Wv0AfqPG2O0g2LyCVaIQmNJPiVJodaWacahAxCMUZ
         1w3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708106784; x=1708711584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=THTKmyp+zgWOjBKgKcw4Z+riVlmxEgNDNx8pO3NcTsI=;
        b=RZxj1FTXqETFXVspEjBEY7Q7J267hQAqIKGhA4ES0ZU8Ivwq9u+jNhI12egnY23Tb4
         HrAm09okVOShLtUGqP5uk44W4wa5wiTpRj2uh33VFAWnPCT5QoXZQaTiPHHW2MTaoxE/
         FGcboGyW3ML1RFzu7GyUtd8SoKPoPAp9K65T93PojRfESjhPE553pHe4/V9LZN4x50qE
         eoz7c1eiK5M9zPxR3ybU662dMbSpeFZ3KjwWZRTV7lzvCDKweIQOuckPU3WrVbjv7u6z
         ljO0hVvGOtCSwVQ46Rc1C8YrgcwqxJ6ewhjnKHY6yX4fPElKfkmOQ78Trc3uYbqtRc6D
         OBUA==
X-Forwarded-Encrypted: i=1; AJvYcCWN/gl3nNZP9JcD4so+3ozUCwnlXv5onsypR0O0uWzkc0H1SUakg2MAI9EkmnRPqDEm3vHyfdePQOvdKi1aP+Knbv09/EvRW/Kxr50L
X-Gm-Message-State: AOJu0YzQqphPRahM0dBXQoF5mj3455qKsjUjnTbZJfygVFD0rTzM3uJI
	uMEiXQWJ/6FTog92R7543AryBSkLr9kg2QeESQo7KWHsY8hLciPp
X-Google-Smtp-Source: AGHT+IGcv8p5w0DKpT6n3NgeVHtNYa2f+Jvr1oVoo9FptlkvvnPVNIAMawfPI3PJrI0+TdZd1c9LQQ==
X-Received: by 2002:a17:902:6e0f:b0:1d9:167b:8e6c with SMTP id u15-20020a1709026e0f00b001d9167b8e6cmr4774669plk.46.1708106783880;
        Fri, 16 Feb 2024 10:06:23 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id n4-20020a170902d2c400b001db6e600ae0sm144232plc.267.2024.02.16.10.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 10:06:23 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	allen.lkml@gmail.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 06/17] workqueue: Introduce work_cancel_flags
Date: Fri, 16 Feb 2024 08:04:47 -1000
Message-ID: <20240216180559.208276-7-tj@kernel.org>
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

The cancel path used bool @is_dwork to distinguish canceling a regular work
and a delayed one. The planned disable/enable support will need passing
around another flag in the code path. As passing them around with bools will
be confusing, let's introduce named flags to pass around in the cancel path.

WORK_CANCEL_DELAYED replaces @is_dwork. No functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index b590d93d054b..317c85f051b0 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -96,6 +96,10 @@ enum worker_flags {
 				  WORKER_UNBOUND | WORKER_REBOUND,
 };
 
+enum work_cancel_flags {
+	WORK_CANCEL_DELAYED	= 1 << 0,	/* canceling a delayed_work */
+};
+
 enum wq_internal_consts {
 	NR_STD_WORKER_POOLS	= 2,		/* # standard pools per cpu */
 
@@ -2028,7 +2032,7 @@ static void pwq_dec_nr_in_flight(struct pool_workqueue *pwq, unsigned long work_
 /**
  * try_to_grab_pending - steal work item from worklist and disable irq
  * @work: work item to steal
- * @is_dwork: @work is a delayed_work
+ * @cflags: %WORK_CANCEL_ flags
  * @irq_flags: place to store irq state
  *
  * Try to grab PENDING bit of @work.  This function can handle @work in any
@@ -2055,7 +2059,7 @@ static void pwq_dec_nr_in_flight(struct pool_workqueue *pwq, unsigned long work_
  *
  * This function is safe to call from any context including IRQ handler.
  */
-static int try_to_grab_pending(struct work_struct *work, bool is_dwork,
+static int try_to_grab_pending(struct work_struct *work, u32 cflags,
 			       unsigned long *irq_flags)
 {
 	struct worker_pool *pool;
@@ -2064,7 +2068,7 @@ static int try_to_grab_pending(struct work_struct *work, bool is_dwork,
 	local_irq_save(*irq_flags);
 
 	/* try to steal the timer if it exists */
-	if (is_dwork) {
+	if (cflags & WORK_CANCEL_DELAYED) {
 		struct delayed_work *dwork = to_delayed_work(work);
 
 		/*
@@ -2543,7 +2547,8 @@ bool mod_delayed_work_on(int cpu, struct workqueue_struct *wq,
 	int ret;
 
 	do {
-		ret = try_to_grab_pending(&dwork->work, true, &irq_flags);
+		ret = try_to_grab_pending(&dwork->work, WORK_CANCEL_DELAYED,
+					  &irq_flags);
 	} while (unlikely(ret == -EAGAIN));
 
 	if (likely(ret >= 0)) {
@@ -4103,13 +4108,13 @@ bool flush_rcu_work(struct rcu_work *rwork)
 }
 EXPORT_SYMBOL(flush_rcu_work);
 
-static bool __cancel_work(struct work_struct *work, bool is_dwork)
+static bool __cancel_work(struct work_struct *work, u32 cflags)
 {
 	unsigned long irq_flags;
 	int ret;
 
 	do {
-		ret = try_to_grab_pending(work, is_dwork, &irq_flags);
+		ret = try_to_grab_pending(work, cflags, &irq_flags);
 	} while (unlikely(ret == -EAGAIN));
 
 	if (unlikely(ret < 0))
@@ -4134,14 +4139,14 @@ static int cwt_wakefn(wait_queue_entry_t *wait, unsigned mode, int sync, void *k
 	return autoremove_wake_function(wait, mode, sync, key);
 }
 
-static bool __cancel_work_sync(struct work_struct *work, bool is_dwork)
+static bool __cancel_work_sync(struct work_struct *work, u32 cflags)
 {
 	static DECLARE_WAIT_QUEUE_HEAD(cancel_waitq);
 	unsigned long irq_flags;
 	int ret;
 
 	do {
-		ret = try_to_grab_pending(work, is_dwork, &irq_flags);
+		ret = try_to_grab_pending(work, cflags, &irq_flags);
 		/*
 		 * If someone else is already canceling, wait for it to
 		 * finish.  flush_work() doesn't work for PREEMPT_NONE
@@ -4203,7 +4208,7 @@ static bool __cancel_work_sync(struct work_struct *work, bool is_dwork)
  */
 bool cancel_work(struct work_struct *work)
 {
-	return __cancel_work(work, false);
+	return __cancel_work(work, 0);
 }
 EXPORT_SYMBOL(cancel_work);
 
@@ -4227,7 +4232,7 @@ EXPORT_SYMBOL(cancel_work);
  */
 bool cancel_work_sync(struct work_struct *work)
 {
-	return __cancel_work_sync(work, false);
+	return __cancel_work_sync(work, 0);
 }
 EXPORT_SYMBOL_GPL(cancel_work_sync);
 
@@ -4249,7 +4254,7 @@ EXPORT_SYMBOL_GPL(cancel_work_sync);
  */
 bool cancel_delayed_work(struct delayed_work *dwork)
 {
-	return __cancel_work(&dwork->work, true);
+	return __cancel_work(&dwork->work, WORK_CANCEL_DELAYED);
 }
 EXPORT_SYMBOL(cancel_delayed_work);
 
@@ -4264,7 +4269,7 @@ EXPORT_SYMBOL(cancel_delayed_work);
  */
 bool cancel_delayed_work_sync(struct delayed_work *dwork)
 {
-	return __cancel_work_sync(&dwork->work, true);
+	return __cancel_work_sync(&dwork->work, WORK_CANCEL_DELAYED);
 }
 EXPORT_SYMBOL(cancel_delayed_work_sync);
 
-- 
2.43.2


