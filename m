Return-Path: <linux-kernel+bounces-69122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A1C8584D5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E46231F23D64
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA1F135A4E;
	Fri, 16 Feb 2024 18:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQzNUwIJ"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783051353FD
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 18:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708106783; cv=none; b=R0BANBPeLyD06Pys2yXsNUjaUSwRrADmqwA8oDzJLPLIoaNfAq+RsViBbxirHGV7pTtEpEXKJ2neL3rEEs9Lc+Ck75nlevjiP552uNL8vD5T0Yceh2BD0S3eN5528nFsvYKxSoYFwd0mJIUd3c8IEQkORJfDbYLf8kMYG/3Najw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708106783; c=relaxed/simple;
	bh=8S4nvCiX9SIcGhxtmUUofNJcQBOMVPXacIdRA1r1JaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GkNH4nn0ytvHGko4rgDIjkNGaCBV8EC9olGo5kLVfkINxSU1ckFJ8opTbaqecifGljS9yJCN9yTSSoZlgZCMSFW87F6Y8wieUDV8OptizHjI9Pai9N+3L4nHTfKIjhr26EdyYvaItxVzFIyQlplZ5JQUf67pWLFdVRVaeUq1eUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQzNUwIJ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d93edfa76dso8831135ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708106780; x=1708711580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+DS0DtBclwHzHSMAZjstaKCNqredx4H7iHvNpCWzDbo=;
        b=gQzNUwIJtOqsqMNUMZllVTcJ+u2MFrWH+aUoQn0zdRVKVac/UZmyuSs5pnkMgq+d7k
         E4PtgNzdBmoLR1Spdqz2KBd4HKr7bS0UdDTe8x/hHLaZcUU8/wgUmFhqstU7ZQqGkDfh
         tj52XI4CYAcyIJ4Rpku32aRJXZILKiFDtqAcd9jBIhA+CsP9ccs4HWNgrUvQmoqywYzp
         6U2OzopvxifY03ioYbdOXjTgqCXHgio3Fl6F98WZ9jwxVxViEwSA3M8FbYu8pfX7y+qN
         gY2d4q54SA1T6kK/zf6Cu/PJeZER0q8xrE5dtbO/38z7KOlESXFDqJxThtpAhbOA1K74
         XUaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708106780; x=1708711580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+DS0DtBclwHzHSMAZjstaKCNqredx4H7iHvNpCWzDbo=;
        b=KqM8SpcOJugr6YaHfCjQntKNghP+domhfutgSDHE5cp3ybEaluezGU66Z3mkP0tt/T
         yawj59oDJKE13AaIJ2rbtqYxCHcTX4AFJi6IJ+HtFwzTP9iVG1IVsbPs3CzbuFFU5WsQ
         /qOFqJ2wQdg7LCkzchuSNDapfV6wIMlRgHQ23Y5gBee2Km2l4IWXk9jHCRuO2Phrbfbd
         9prPcL9pxGQTNhCozOJE4Pmw1ywyLMUcIxEc3vGlOw+6ux2GF90wR1QDApzi6bTDh2YZ
         9G8Ilhe80F5dQhfocbDJnJIPXH0OrLRiR3Pa0BjgGyA/iLRSkKimFDCVI0jxYn3bZoQw
         VPEw==
X-Forwarded-Encrypted: i=1; AJvYcCU0H2Ll2ANiUx1M9heTeEVCVEX860XgMSbojzKx1+CBnEY/ID3oHvZiweed6eY7PsQh8Hm1FwugcsJ6omAHGLt9KLSPL8ZflOlBzFWV
X-Gm-Message-State: AOJu0YxjvzmO60WjwQUToR3SjSL7RT26TRZA45COzG5u2YzBoXkYkx4h
	wt7czOPq3fwmnlg78L5CooFbXyf4e6yWqpwesaqMnYIap9d6z9Sj
X-Google-Smtp-Source: AGHT+IF+5CSfdvF6O20LVOP5Xil3z4mzEfFzIK7aqKmjXmMViPMDxrLGA1Uqgeo5d/MRHz7cwyAqNQ==
X-Received: by 2002:a17:903:904:b0:1db:a6b8:6b23 with SMTP id ll4-20020a170903090400b001dba6b86b23mr3323978plb.27.1708106780472;
        Fri, 16 Feb 2024 10:06:20 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id jc15-20020a17090325cf00b001db54324488sm161468plb.38.2024.02.16.10.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 10:06:20 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	allen.lkml@gmail.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 04/17] workqueue: Reorganize flush and cancel[_sync] functions
Date: Fri, 16 Feb 2024 08:04:45 -1000
Message-ID: <20240216180559.208276-5-tj@kernel.org>
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

They are currently a bit disorganized with flush and cancel functions mixed.
Reoranize them so that flush functions come first, cancel next and
cancel_sync last. This way, we won't have to add prototypes for internal
functions for the planned disable/enable support.

This is pure code reorganization. No functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c | 136 ++++++++++++++++++++++-----------------------
 1 file changed, 68 insertions(+), 68 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 7e2af79bfa62..962061dca05c 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4061,6 +4061,65 @@ bool flush_work(struct work_struct *work)
 }
 EXPORT_SYMBOL_GPL(flush_work);
 
+/**
+ * flush_delayed_work - wait for a dwork to finish executing the last queueing
+ * @dwork: the delayed work to flush
+ *
+ * Delayed timer is cancelled and the pending work is queued for
+ * immediate execution.  Like flush_work(), this function only
+ * considers the last queueing instance of @dwork.
+ *
+ * Return:
+ * %true if flush_work() waited for the work to finish execution,
+ * %false if it was already idle.
+ */
+bool flush_delayed_work(struct delayed_work *dwork)
+{
+	local_irq_disable();
+	if (del_timer_sync(&dwork->timer))
+		__queue_work(dwork->cpu, dwork->wq, &dwork->work);
+	local_irq_enable();
+	return flush_work(&dwork->work);
+}
+EXPORT_SYMBOL(flush_delayed_work);
+
+/**
+ * flush_rcu_work - wait for a rwork to finish executing the last queueing
+ * @rwork: the rcu work to flush
+ *
+ * Return:
+ * %true if flush_rcu_work() waited for the work to finish execution,
+ * %false if it was already idle.
+ */
+bool flush_rcu_work(struct rcu_work *rwork)
+{
+	if (test_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(&rwork->work))) {
+		rcu_barrier();
+		flush_work(&rwork->work);
+		return true;
+	} else {
+		return flush_work(&rwork->work);
+	}
+}
+EXPORT_SYMBOL(flush_rcu_work);
+
+static bool __cancel_work(struct work_struct *work, bool is_dwork)
+{
+	unsigned long flags;
+	int ret;
+
+	do {
+		ret = try_to_grab_pending(work, is_dwork, &flags);
+	} while (unlikely(ret == -EAGAIN));
+
+	if (unlikely(ret < 0))
+		return false;
+
+	set_work_pool_and_clear_pending(work, get_work_pool_id(work));
+	local_irq_restore(flags);
+	return ret;
+}
+
 struct cwt_wait {
 	wait_queue_entry_t		wait;
 	struct work_struct	*work;
@@ -4139,6 +4198,15 @@ static bool __cancel_work_sync(struct work_struct *work, bool is_dwork)
 	return ret;
 }
 
+/*
+ * See cancel_delayed_work()
+ */
+bool cancel_work(struct work_struct *work)
+{
+	return __cancel_work(work, false);
+}
+EXPORT_SYMBOL(cancel_work);
+
 /**
  * cancel_work_sync - cancel a work and wait for it to finish
  * @work: the work to cancel
@@ -4163,74 +4231,6 @@ bool cancel_work_sync(struct work_struct *work)
 }
 EXPORT_SYMBOL_GPL(cancel_work_sync);
 
-/**
- * flush_delayed_work - wait for a dwork to finish executing the last queueing
- * @dwork: the delayed work to flush
- *
- * Delayed timer is cancelled and the pending work is queued for
- * immediate execution.  Like flush_work(), this function only
- * considers the last queueing instance of @dwork.
- *
- * Return:
- * %true if flush_work() waited for the work to finish execution,
- * %false if it was already idle.
- */
-bool flush_delayed_work(struct delayed_work *dwork)
-{
-	local_irq_disable();
-	if (del_timer_sync(&dwork->timer))
-		__queue_work(dwork->cpu, dwork->wq, &dwork->work);
-	local_irq_enable();
-	return flush_work(&dwork->work);
-}
-EXPORT_SYMBOL(flush_delayed_work);
-
-/**
- * flush_rcu_work - wait for a rwork to finish executing the last queueing
- * @rwork: the rcu work to flush
- *
- * Return:
- * %true if flush_rcu_work() waited for the work to finish execution,
- * %false if it was already idle.
- */
-bool flush_rcu_work(struct rcu_work *rwork)
-{
-	if (test_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(&rwork->work))) {
-		rcu_barrier();
-		flush_work(&rwork->work);
-		return true;
-	} else {
-		return flush_work(&rwork->work);
-	}
-}
-EXPORT_SYMBOL(flush_rcu_work);
-
-static bool __cancel_work(struct work_struct *work, bool is_dwork)
-{
-	unsigned long flags;
-	int ret;
-
-	do {
-		ret = try_to_grab_pending(work, is_dwork, &flags);
-	} while (unlikely(ret == -EAGAIN));
-
-	if (unlikely(ret < 0))
-		return false;
-
-	set_work_pool_and_clear_pending(work, get_work_pool_id(work));
-	local_irq_restore(flags);
-	return ret;
-}
-
-/*
- * See cancel_delayed_work()
- */
-bool cancel_work(struct work_struct *work)
-{
-	return __cancel_work(work, false);
-}
-EXPORT_SYMBOL(cancel_work);
-
 /**
  * cancel_delayed_work - cancel a delayed work
  * @dwork: delayed_work to cancel
-- 
2.43.2


