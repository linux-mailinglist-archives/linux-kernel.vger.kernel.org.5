Return-Path: <linux-kernel+bounces-39003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BC583C98C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10CDD298F26
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAA413E229;
	Thu, 25 Jan 2024 17:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlQGOMTQ"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6CE13DBBE
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 17:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706202402; cv=none; b=YIULHe8bEQAyAX8uIBbP4xUWHVAmX6loFHXgU8DeDT3ZV6mm2s1xDNjRFx6KpJoW9UvZlkwlzzOmb1sTgjOcP+jq/XmRwED5DPLK16novE7xebde0lwAKgKq3uR6MJ8HUiiPn/uKUuTnL2TgAPj4z6I3eKp6JVQXd6AxlYyaiKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706202402; c=relaxed/simple;
	bh=+j2zPD8v5bQpd5vQ/bJCMx1KxRnTcwgz10hAwd088h4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ixBHx2QNcWswh7VUc+OwTB0WTBKZ+pj9/pGjT2YUGaDTnpo4JTAFU7VCgPm3ETo0FbqpAx7P/RYZGHj6yj4Q71plbuJkbExPWGdMQR5VHu1JkFFxaj61hjpNrFdFN58jxs6o7oV1FSRLo9Sv3TVJiUccAQwWNrUI7CfPlH2C/Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlQGOMTQ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d89518d3b1so3139895ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706202400; x=1706807200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BP94kd7tIP37TF57FbSnD6bXMFgUJFtyq1wtlwZ5Yms=;
        b=JlQGOMTQcF+rV/GC5OA1wlrxy7SUb3h5+CcArfEPnAyHsMIIXso+DxH3A/HjQn3Ju0
         qRnxJFxdDlSr/1WXxMU4rBAo+s1xDwEIeeRPzRF2Sxu5paStFMSW/z0i0wEwdR59YgGv
         /3dibl0+HE+U50S+Bldvh0B3rRizFr7BPXUJebsrfPKNWw7lf+GdJRCUsP+Arh6nVD0y
         w5jWXTQSs/Nw2/umQkrmDniEom4Q0ojO77zRPs/5FmQFpMaQ25jlYUD3hYTmUNLvQhUJ
         fxm8PjLSJM4qCsr46UZ0UmkBJhQOYu4W8jm9L/wP1cFZIgdB6iHDp6MCpkg1JtojbQ+G
         Gryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706202400; x=1706807200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BP94kd7tIP37TF57FbSnD6bXMFgUJFtyq1wtlwZ5Yms=;
        b=Dpvd6yvPXf262nwJFGtDhvWiVYK8pTUzTtUq7LdGuX4SwpK856QPzfveXW7UGPt/Cn
         r/MxuUVRwfuErV2xGwDVesaduYzSVWyO45I/TH/p/lTQjRyH8ugBes8O+Ri9UGCXi77o
         Dln19pFRcheMGwJEPW+RGb0ZZVzWVqeHyKfXs682ekPf/FOd0dl+GKBgjcKT5Iro9I8N
         +yxNe1lyyNPWd6CwD2h+NSqKdD2nStCMAuT8GDCVhj9+cezB8JJRuoqXZKuPI4+5t7SN
         WuKevwhPzzyXxa9Qx2s64ObdRC0ADpE4Yc/ePhkrLBPGI+g93+xdHhxQ614YER38WtTs
         of9A==
X-Gm-Message-State: AOJu0YwbarQ8ycEfKLX1AViPfeQkqLjXyTUEoQUqDOaihOObnxCiDAYO
	60XRZxAW+vSgfpfycpUxEhUb9tgZR0szyevewVT2AGe1ZdWvSyeF
X-Google-Smtp-Source: AGHT+IEo5rcZ8ZXAtcsxUmglTjVBD0RRbROLd+6fsnO7IZLftVafOhXP8su8BHxEDFAmmiz5okZr/w==
X-Received: by 2002:a17:902:d551:b0:1d7:8535:d09f with SMTP id z17-20020a170902d55100b001d78535d09fmr146622plf.24.1706202399801;
        Thu, 25 Jan 2024 09:06:39 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902c18400b001d71649bf9asm10971145pld.252.2024.01.25.09.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 09:06:39 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: linux-kernel@vger.kernel.org,
	Naohiro.Aota@wdc.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 06/10] workqueue: RCU protect wq->dfl_pwq and implement accessors for it
Date: Thu, 25 Jan 2024 07:05:59 -1000
Message-ID: <20240125170628.2017784-7-tj@kernel.org>
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

wq->cpu_pwq is RCU protected but wq->dfl_pwq isn't. This is okay because
currently wq->dfl_pwq is used only accessed to install it into wq->cpu_pwq
which doesn't require RCU access. However, we want to be able to access
wq->dfl_pwq under RCU in the future to access its __pod_cpumask and the code
can be made easier to read by making the two pwq fields behave in the same
way.

- Make wq->dfl_pwq RCU protected.

- Add unbound_pwq_slot() and unbound_pwq() which can access both ->dfl_pwq
  and ->cpu_pwq. The former returns the double pointer that can be used
  access and update the pwqs. The latter performs locking check and
  dereferences the double pointer.

- pwq accesses and updates are converted to use unbound_pwq[_slot]().

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c | 64 +++++++++++++++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 24 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index bfb6e951852a..1bca0a4ab9d1 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -304,7 +304,7 @@ struct workqueue_struct {
 	int			saved_max_active; /* WQ: saved max_active */
 
 	struct workqueue_attrs	*unbound_attrs;	/* PW: only for unbound wqs */
-	struct pool_workqueue	*dfl_pwq;	/* PW: only for unbound wqs */
+	struct pool_workqueue __rcu *dfl_pwq;   /* PW: only for unbound wqs */
 
 #ifdef CONFIG_SYSFS
 	struct wq_device	*wq_dev;	/* I: for sysfs interface */
@@ -635,6 +635,23 @@ static int worker_pool_assign_id(struct worker_pool *pool)
 	return ret;
 }
 
+static struct pool_workqueue __rcu **
+unbound_pwq_slot(struct workqueue_struct *wq, int cpu)
+{
+       if (cpu >= 0)
+               return per_cpu_ptr(wq->cpu_pwq, cpu);
+       else
+               return &wq->dfl_pwq;
+}
+
+/* @cpu < 0 for dfl_pwq */
+static struct pool_workqueue *unbound_pwq(struct workqueue_struct *wq, int cpu)
+{
+	return rcu_dereference_check(*unbound_pwq_slot(wq, cpu),
+				     lockdep_is_held(&wq_pool_mutex) ||
+				     lockdep_is_held(&wq->mutex));
+}
+
 static unsigned int work_color_to_flags(int color)
 {
 	return color << WORK_STRUCT_COLOR_SHIFT;
@@ -4325,10 +4342,11 @@ static void wq_calc_pod_cpumask(struct workqueue_attrs *attrs, int cpu,
 				"possible intersect\n");
 }
 
-/* install @pwq into @wq's cpu_pwq and return the old pwq */
+/* install @pwq into @wq and return the old pwq, @cpu < 0 for dfl_pwq */
 static struct pool_workqueue *install_unbound_pwq(struct workqueue_struct *wq,
 					int cpu, struct pool_workqueue *pwq)
 {
+	struct pool_workqueue __rcu **slot = unbound_pwq_slot(wq, cpu);
 	struct pool_workqueue *old_pwq;
 
 	lockdep_assert_held(&wq_pool_mutex);
@@ -4337,8 +4355,8 @@ static struct pool_workqueue *install_unbound_pwq(struct workqueue_struct *wq,
 	/* link_pwq() can handle duplicate calls */
 	link_pwq(pwq);
 
-	old_pwq = rcu_access_pointer(*per_cpu_ptr(wq->cpu_pwq, cpu));
-	rcu_assign_pointer(*per_cpu_ptr(wq->cpu_pwq, cpu), pwq);
+	old_pwq = rcu_access_pointer(*slot);
+	rcu_assign_pointer(*slot, pwq);
 	return old_pwq;
 }
 
@@ -4438,14 +4456,11 @@ static void apply_wqattrs_commit(struct apply_wqattrs_ctx *ctx)
 
 	copy_workqueue_attrs(ctx->wq->unbound_attrs, ctx->attrs);
 
-	/* save the previous pwq and install the new one */
+	/* save the previous pwqs and install the new ones */
 	for_each_possible_cpu(cpu)
 		ctx->pwq_tbl[cpu] = install_unbound_pwq(ctx->wq, cpu,
 							ctx->pwq_tbl[cpu]);
-
-	/* @dfl_pwq might not have been used, ensure it's linked */
-	link_pwq(ctx->dfl_pwq);
-	swap(ctx->wq->dfl_pwq, ctx->dfl_pwq);
+	ctx->dfl_pwq = install_unbound_pwq(ctx->wq, -1, ctx->dfl_pwq);
 
 	mutex_unlock(&ctx->wq->mutex);
 }
@@ -4555,9 +4570,7 @@ static void wq_update_pod(struct workqueue_struct *wq, int cpu,
 
 	/* nothing to do if the target cpumask matches the current pwq */
 	wq_calc_pod_cpumask(target_attrs, cpu, off_cpu);
-	pwq = rcu_dereference_protected(*per_cpu_ptr(wq->cpu_pwq, cpu),
-					lockdep_is_held(&wq_pool_mutex));
-	if (wqattrs_equal(target_attrs, pwq->pool->attrs))
+	if (wqattrs_equal(target_attrs, unbound_pwq(wq, cpu)->pool->attrs))
 		return;
 
 	/* create a new pwq */
@@ -4575,10 +4588,11 @@ static void wq_update_pod(struct workqueue_struct *wq, int cpu,
 
 use_dfl_pwq:
 	mutex_lock(&wq->mutex);
-	raw_spin_lock_irq(&wq->dfl_pwq->pool->lock);
-	get_pwq(wq->dfl_pwq);
-	raw_spin_unlock_irq(&wq->dfl_pwq->pool->lock);
-	old_pwq = install_unbound_pwq(wq, cpu, wq->dfl_pwq);
+	pwq = unbound_pwq(wq, -1);
+	raw_spin_lock_irq(&pwq->pool->lock);
+	get_pwq(pwq);
+	raw_spin_unlock_irq(&pwq->pool->lock);
+	old_pwq = install_unbound_pwq(wq, cpu, pwq);
 out_unlock:
 	mutex_unlock(&wq->mutex);
 	put_pwq_unlocked(old_pwq);
@@ -4616,10 +4630,13 @@ static int alloc_and_link_pwqs(struct workqueue_struct *wq)
 
 	cpus_read_lock();
 	if (wq->flags & __WQ_ORDERED) {
+		struct pool_workqueue *dfl_pwq;
+
 		ret = apply_workqueue_attrs(wq, ordered_wq_attrs[highpri]);
 		/* there should only be single pwq for ordering guarantee */
-		WARN(!ret && (wq->pwqs.next != &wq->dfl_pwq->pwqs_node ||
-			      wq->pwqs.prev != &wq->dfl_pwq->pwqs_node),
+		dfl_pwq = rcu_access_pointer(wq->dfl_pwq);
+		WARN(!ret && (wq->pwqs.next != &dfl_pwq->pwqs_node ||
+			      wq->pwqs.prev != &dfl_pwq->pwqs_node),
 		     "ordering guarantee broken for workqueue %s\n", wq->name);
 	} else {
 		ret = apply_workqueue_attrs(wq, unbound_std_wq_attrs[highpri]);
@@ -4853,7 +4870,7 @@ static bool pwq_busy(struct pool_workqueue *pwq)
 		if (pwq->nr_in_flight[i])
 			return true;
 
-	if ((pwq != pwq->wq->dfl_pwq) && (pwq->refcnt > 1))
+	if ((pwq != rcu_access_pointer(pwq->wq->dfl_pwq)) && (pwq->refcnt > 1))
 		return true;
 	if (!pwq_is_empty(pwq))
 		return true;
@@ -4937,13 +4954,12 @@ void destroy_workqueue(struct workqueue_struct *wq)
 	rcu_read_lock();
 
 	for_each_possible_cpu(cpu) {
-		pwq = rcu_access_pointer(*per_cpu_ptr(wq->cpu_pwq, cpu));
-		RCU_INIT_POINTER(*per_cpu_ptr(wq->cpu_pwq, cpu), NULL);
-		put_pwq_unlocked(pwq);
+		put_pwq_unlocked(unbound_pwq(wq, cpu));
+		RCU_INIT_POINTER(*unbound_pwq_slot(wq, cpu), NULL);
 	}
 
-	put_pwq_unlocked(wq->dfl_pwq);
-	wq->dfl_pwq = NULL;
+	put_pwq_unlocked(unbound_pwq(wq, -1));
+	RCU_INIT_POINTER(*unbound_pwq_slot(wq, -1), NULL);
 
 	rcu_read_unlock();
 }
-- 
2.43.0


