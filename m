Return-Path: <linux-kernel+bounces-69119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C888584D2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFEA11C20BC2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E11C1350DC;
	Fri, 16 Feb 2024 18:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="km/nJS2u"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B040131E22
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 18:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708106777; cv=none; b=uXT2cDuIouKtJKNJAUowZYr8jDv1G7Lr8XMwG+yHo15e+vwQrimaCER6dg7d9nef9ZGz47e4s1igEEQerjjfwcLdCCtJu8ieTNTfsniMo+85Z3VHxt/s6Ni8rxcHBUQ7CRUQE8lgPKziSA3HVtBAhE8r2F2dHVDGscvLo5f4ZO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708106777; c=relaxed/simple;
	bh=rA+Bhv3/TvEC8fa8VDcKiAHnAwvTr3i2sZPLuuN/ifQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PrrO767H0CFZQAG/Z1SnzKSa9JxfVMMMQep0cJH2prpzqEYobQBSWDb3tZx1J3LarZ+Jjkk9w1UOfZYy/lb599RKVf/eXh12KyyN8AVfPX0V7NXTRhS1lqJt4j7gOMqPOEdDBc2yvn/13b5fk06LwnQaAjb51I10zb/SYsgAbHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=km/nJS2u; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5c66b093b86so2527049a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708106775; x=1708711575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQL03BXEohlBiV8WF4+w4OjRLuExQ3dvTWReO6nS+hc=;
        b=km/nJS2uKTVSPSmB3uSgBRZoILEZOGWc64KaHRJMn8xbSbTtpWqhwzrxQUwFLqK+O1
         H3Yh3EUNyi7CndeCb3tRgcPLM88dim21MqdAyKb4/qpaBOsYYOe6LWfNsoYl3I0VKZnC
         lxYx9oAhRbv8v4Nut7C8fmOWN8+wtQVGctZxgKl+e7J7HJ8Ta1XheFET4U+g+q5gdTOn
         gjHJRSe7/tO76eKTpdppk5+Cmiegqw/v86BUoD4lCfhkMfV/ywIRpEGqJ6/0dFhizDGx
         cCsG9+13LXm6IDH4u6z+1Z3O6jEY3zaqftzbR2WphTSwAKmT0+8yiNKAIzRMC3KvXOGU
         ODDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708106775; x=1708711575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XQL03BXEohlBiV8WF4+w4OjRLuExQ3dvTWReO6nS+hc=;
        b=v27WeMic0e/UwgYKUSiGL14486F0kHYXeJSgbHRidPoEhoVPtEOOVAcPaWa9ktwDt1
         Pd/16+9MunQxBFcaFZAIRw3IJS4cJPUBwFIM5aym+hWdchHZnQTxoKxPM8BXu55nzz2e
         Enh0I7olhDd7gJM1TV9bi4l9RFlygu2UHwMwdEsozekQek1YSwzu3F6p3O2mpXv9Afhd
         CRQBD8iXIJF9C85ctJEk5doc9yZYZYR3REe0LadJoN2UXODiDy6NdswLvqAhY7gV2d68
         GB/M9CijrF6t94cQZuIxItAGdXMcx76GAozDBypBwqqzx94yYNZJUVD88+cFtX83dJ8u
         qAFw==
X-Forwarded-Encrypted: i=1; AJvYcCVjdyd4zlJdWQOeTROeHYbqz7yvd5ATQ+DMaSY3hH7hJOvhgHADwbTVYKDfQnpts10uc7DngU4llYP18Bh7ETZnvT5Nnqj4QjVI0+5j
X-Gm-Message-State: AOJu0YxZpe1wsIE8ExwmDZZgJd/OeJp4YlQiSd4JvLxal2qHzv7VQXhH
	s8uTPztqXWlXGGaItX8m0oCs9xEoNJMhy5Trc6ofaF+hroM3nklV
X-Google-Smtp-Source: AGHT+IGMfzuhAEPutUNy6FtizVy01OL1r11wwnwt4zpX+lCIQj4H5TIwrRGi8PBEvHAjygpoX7QFqg==
X-Received: by 2002:a17:90b:381:b0:299:336e:512d with SMTP id ga1-20020a17090b038100b00299336e512dmr3741056pjb.11.1708106775230;
        Fri, 16 Feb 2024 10:06:15 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id cm18-20020a17090afa1200b00299268defb9sm297679pjb.41.2024.02.16.10.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 10:06:14 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	allen.lkml@gmail.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 01/17] workqueue: Cosmetic changes
Date: Fri, 16 Feb 2024 08:04:42 -1000
Message-ID: <20240216180559.208276-2-tj@kernel.org>
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

Reorder some global declarations and adjust comments and whitespaces for
clarity and consistency. No functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 6ae441e13804..b280caf81fb2 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -376,8 +376,6 @@ struct workqueue_struct {
 	struct wq_node_nr_active *node_nr_active[]; /* I: per-node nr_active */
 };
 
-static struct kmem_cache *pwq_cache;
-
 /*
  * Each pod type describes how CPUs should be grouped for unbound workqueues.
  * See the comment above workqueue_attrs->affn_scope.
@@ -389,20 +387,15 @@ struct wq_pod_type {
 	int			*cpu_pod;	/* cpu -> pod */
 };
 
-static struct wq_pod_type wq_pod_types[WQ_AFFN_NR_TYPES];
-static enum wq_affn_scope wq_affn_dfl = WQ_AFFN_CACHE;
-
 static const char *wq_affn_names[WQ_AFFN_NR_TYPES] = {
-	[WQ_AFFN_DFL]			= "default",
-	[WQ_AFFN_CPU]			= "cpu",
-	[WQ_AFFN_SMT]			= "smt",
-	[WQ_AFFN_CACHE]			= "cache",
-	[WQ_AFFN_NUMA]			= "numa",
-	[WQ_AFFN_SYSTEM]		= "system",
+	[WQ_AFFN_DFL]		= "default",
+	[WQ_AFFN_CPU]		= "cpu",
+	[WQ_AFFN_SMT]		= "smt",
+	[WQ_AFFN_CACHE]		= "cache",
+	[WQ_AFFN_NUMA]		= "numa",
+	[WQ_AFFN_SYSTEM]	= "system",
 };
 
-static bool wq_topo_initialized __read_mostly = false;
-
 /*
  * Per-cpu work items which run for longer than the following threshold are
  * automatically considered CPU intensive and excluded from concurrency
@@ -418,6 +411,12 @@ static bool wq_power_efficient = IS_ENABLED(CONFIG_WQ_POWER_EFFICIENT_DEFAULT);
 module_param_named(power_efficient, wq_power_efficient, bool, 0444);
 
 static bool wq_online;			/* can kworkers be created yet? */
+static bool wq_topo_initialized __read_mostly = false;
+
+static struct kmem_cache *pwq_cache;
+
+static struct wq_pod_type wq_pod_types[WQ_AFFN_NR_TYPES];
+static enum wq_affn_scope wq_affn_dfl = WQ_AFFN_CACHE;
 
 /* buf for wq_update_unbound_pod_attrs(), protected by CPU hotplug exclusion */
 static struct workqueue_attrs *wq_update_pod_attrs_buf;
@@ -2231,7 +2230,6 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 	 */
 	lockdep_assert_irqs_disabled();
 
-
 	/*
 	 * For a draining wq, only works from the same workqueue are
 	 * allowed. The __WQ_DESTROYING helps to spot the issue that
@@ -4121,8 +4119,8 @@ static bool __cancel_work_timer(struct work_struct *work, bool is_dwork)
 	local_irq_restore(flags);
 
 	/*
-	 * This allows canceling during early boot.  We know that @work
-	 * isn't executing.
+	 * Skip __flush_work() during early boot when we know that @work isn't
+	 * executing. This allows canceling during early boot.
 	 */
 	if (wq_online)
 		__flush_work(work, true);
-- 
2.43.2


