Return-Path: <linux-kernel+bounces-58893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C79484EE3A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 01:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E72D1C22EF0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3B0393;
	Fri,  9 Feb 2024 00:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtVG1Hk1"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E362364
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 00:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707437521; cv=none; b=X0INzOEn7H1V8MBLOmbWR7YEKLqOOWcuZloC0fRCqSBX3qtXLbQXJ1mcQvcbsHgh4Yun2wOzOVrIIK/z+g0H5y75WkuRYjOzif0EWE3FLrHC/TX/+WgBpYNj3XHp1MuhjJc1PBd6XUGk/IHmkS70ECmYbkYlPqgEsWlxdDR2lhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707437521; c=relaxed/simple;
	bh=MrtQG68CQj3jGguwb2kDauw/NcdRMELRTxmQJt6Xpy8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HwzSgHzdUX/0p32Jl2vg3mdERE8XffGKkNGtHk5Gc/Iv8C/e7lmShv98ADbJ0DKVPIZFzvREzbl9zb49lNaJlSVdjZDHHsxwBvBvlKt4n1+YzZVTjj2vC8koLt6bEzX/kNZ19mvbBvCBK70wl98y6appTDsltr5eBKruZvALxwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FtVG1Hk1; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e062fa6e00so266145b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 16:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707437519; x=1708042319; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=XQZvJgedD8LlLuZzJKiEJoT/ySdzdPZ0zmmi9A45YQg=;
        b=FtVG1Hk17IBgMwfvOLZCIEQCeuf8J/qEoJ6rAVoUH+vkR5Heac1N5TRHk9Thwe3W0p
         gKBErW/pV153rUDZ7HYqBjUoZjMTzwxcHz+aEUngqmz/9v9VF/quI/H8eQBfsojUtP/K
         wiwA5urRNjrpcWZtxayr8Obk79EVpJoB91+fqlGgY84sZuHzAfIN1nq1rpkCefAyEZCe
         QTNVRNAs7BS3iUt8vXpBeyASLHl+TlWn56gwmxJkyLmbfMP0vzPXUryT3TVdxZX6H74P
         15MSTqIxBdSHX6L2nk/Exx4xCBdN0kc85QGyDjD+hHH0BM2Hgm4X7SG4P8gzAPWSrp6e
         exuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707437519; x=1708042319;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XQZvJgedD8LlLuZzJKiEJoT/ySdzdPZ0zmmi9A45YQg=;
        b=fC2EVhRWJt4tGpus1dHPuQ7IGhv9krs7tISVsWIhOJGOPSWM7JnnmKkwkLAJxevsp1
         IYqUoTgYE/l/LW0c4yJRBmcn+mVk8rIZnUprck0M9ehD9U8Bse7M1oqXPVMMUt2Q6Mai
         iLRgInaQHmbtLNnRCAAOywXbeF6Bb8M6UPIRfP4bdAZN5V8YxJpJjN6FUliqau87DGrO
         lPgal8UmYIpcc0iAntenP12OejqAEvRTsev/Qo0hFvPbqtfrzNuL90TOV5yDwVjHTi8/
         rambh2Lj6XZ4Izkjo5L9YeQh7uMeobH1uwwFiVJCl6v9I+5H8lwb3F7G1AzOtXuVgncT
         ZO0w==
X-Gm-Message-State: AOJu0YyXPuCA9iEU3BFFhfNsQZIdCKOORd/gZ42Mu1TdkJy7GpRpffn8
	YfluTgwE0zzQG1VG/MWFk4a4RN8MS2Lgy5SBgqC/o3oBcKRgoZrb4pYB0cbshT0=
X-Google-Smtp-Source: AGHT+IGnFYpaVRndUc26lHbUP8stfI9w6JFXcCEMp3DU1MIcOzuq90I0BUWGFuWwcISUG6vD/6IK0g==
X-Received: by 2002:a05:6a00:1393:b0:6e0:4b09:a9c4 with SMTP id t19-20020a056a00139300b006e04b09a9c4mr136174pfg.2.1707437518757;
        Thu, 08 Feb 2024 16:11:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWk7lyW/tEgtaQBxQGucpaotDVXiVjuNQymjGei6+VSK0+3ar7g8KPGJ7xfOmttyRTSguFKepmdvOmSs+jSiBPkBgbXjpNG6eFpvHKJy4+hYbSFgJQWCCYCoWGGnYbsb3u7OCCFkb3CJ+5Csw7oe2FjC2+YDxJL
Received: from localhost ([2620:10d:c090:400::4:3c45])
        by smtp.gmail.com with ESMTPSA id fn6-20020a056a002fc600b006e03c2f96fbsm367245pfb.148.2024.02.08.16.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 16:11:58 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 8 Feb 2024 14:11:56 -1000
From: Tejun Heo <tj@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 1/2 wq/for-6.9] workqueue: Implement
 workqueue_set_min_active()
Message-ID: <ZcVtzJvJCRV5OLM-@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Since 5797b1c18919 ("workqueue: Implement system-wide nr_active enforcement
for unbound workqueues"), unbound workqueues have separate min_active which
sets the number of interdependent work items that can be handled. This value
is currently initialized to WQ_DFL_MIN_ACTIVE which is 8. This isn't high
enough for some users, let's add an interface to adjust the setting.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/workqueue.h |    2 ++
 kernel/workqueue.c        |   27 +++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -553,6 +553,8 @@ extern bool flush_rcu_work(struct rcu_wo
 
 extern void workqueue_set_max_active(struct workqueue_struct *wq,
 				     int max_active);
+extern void workqueue_set_min_active(struct workqueue_struct *wq,
+				     int min_active);
 extern struct work_struct *current_work(void);
 extern bool current_is_workqueue_rescuer(void);
 extern bool workqueue_congested(int cpu, struct workqueue_struct *wq);
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5627,6 +5627,33 @@ void workqueue_set_max_active(struct wor
 EXPORT_SYMBOL_GPL(workqueue_set_max_active);
 
 /**
+ * workqueue_set_min_active - adjust min_active of an unbound workqueue
+ * @wq: target unbound workqueue
+ * @min_active: new min_active value
+ *
+ * Set min_active of an unbound workqueue. Unlike other types of workqueues, an
+ * unbound workqueue is not guaranteed to be able to process max_active
+ * interdependent work items. Instead, an unbound workqueue is guaranteed to be
+ * able to process min_active number of interdependent work items which is
+ * %WQ_DFL_MIN_ACTIVE by default.
+ *
+ * Use this function to adjust the min_active value between 0 and the current
+ * max_active.
+ */
+void workqueue_set_min_active(struct workqueue_struct *wq, int min_active)
+{
+	/* min_active is only meaningful for non-ordered unbound workqueues */
+	if (WARN_ON((wq->flags & (WQ_BH | WQ_UNBOUND | __WQ_ORDERED)) !=
+		    WQ_UNBOUND))
+		return;
+
+	mutex_lock(&wq->mutex);
+	wq->saved_min_active = clamp(min_active, 0, wq->saved_max_active);
+	wq_adjust_max_active(wq);
+	mutex_unlock(&wq->mutex);
+}
+
+/**
  * current_work - retrieve %current task's work struct
  *
  * Determine if %current task is a workqueue worker and what it's working on.

