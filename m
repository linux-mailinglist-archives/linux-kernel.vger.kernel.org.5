Return-Path: <linux-kernel+bounces-54122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E6F84AB0F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 01:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 400521F26537
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 00:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC83139D;
	Tue,  6 Feb 2024 00:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OO/pTgcS"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF8B10E4
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 00:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707178728; cv=none; b=WHCakoPTAoQtoC5wKR9Q3oOSMfZaiEF7WwUSzSJmducpX7xn5w7tn0h5nfu5NhYT9gwjr4uyDLTjbYRAOaUL8FTXrzPeHViKfWKA5eIclIu2K8sc7PDMu34HtG1pZBdHo5emXMuuvPeNuorUJJtlNjoes9rE4ePEeVdK6dQOcSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707178728; c=relaxed/simple;
	bh=CrDEUCTORojkXppF6D9ZxIR1/2J+n08DWOvmkSYbvVY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=G+mlQ0kEgCJhqw/7rmWKl5XV+kKFEdmdXPvrQ3B1Z28njSYWuIoFukPIz0hE9XIJsg4A1MHrfaM03VjSSZjaa6jxVi6RpsFQKMog3LSe5nAaPYzPSVfHeNrKuZitidBE+kxYMiwFFk3d1YrEPn1uxVXWKQ9BsMLs4cji2lIDRpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OO/pTgcS; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d93edfa76dso42935155ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 16:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707178726; x=1707783526; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=OorrusT4e8sp3jFsRY5RJRrpy3EbIYDzZ/4+uafbLUs=;
        b=OO/pTgcSk3zyBoWxocHflB51yj2T5Xo6zJlCMXhzXBV4JZs+o7XOwaAHSqyZAwWCTf
         LdZJtNov3edz6lpT2+AJ7ovmezqlWF8dua95aOtefGqANctsWkz9DfxRqPT14TTXXKBT
         RproC/ShYIzlVkwYutzP8Iq0MgNhZ5+uyTM+xlyJJjcgvxlWkWT0j+vsN+lOdyBsPK8Z
         j2UTwjECt0hU73ptXpt7N0EOO3UAfmmvSHS2KcMuKMU+LtHd6laedNQfOL6HTQQ9rCjK
         pY4wwHHMmiXNmWsgoe2rInqssFcDzbZb5LaKgQIutguiCp3g2yxYWvnCGv/Y8jUT0gqv
         cIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707178726; x=1707783526;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OorrusT4e8sp3jFsRY5RJRrpy3EbIYDzZ/4+uafbLUs=;
        b=ijkid09CQT39v89OBJ2BGfjISL7NoS0/zDdqPK7YNfM/R0aWOj82uf6CMuHgZpBOka
         XBkNRxBLkrQM/BLBQau0tIQUr5VPLGWSiJRggL+ORIqWMwRo0GRVO6Wq/t4jKXua4ZCa
         qYqFOQJkmT/bJgquTYEdpc3cuvAkC0psYvr6BXSzQJ5rKOE9C0JQJR3nsUwm9dLwhDQt
         mHSGEf0AV7VrSInaF1n9cw3l2vYxILOxrVMy0DlcAe5qvg0zcKUGVoqdm7ph+UmdCVoI
         dtERNyHikZlnCXj0uMPTq4KUxGZcfH0Zy/h2oyd0mdcYssr/MafYJxUHxvg/R/XS6jH5
         IbxQ==
X-Gm-Message-State: AOJu0YztsGjnv30Ee4GHrnu6CuPCdZNu+QxWftCpYyXo/F1EqTpWeZ83
	Es/wJWypYdYX4KUM6YoWSvC4R3ma0v7hUGnynxoBJ7UHIE3HIY3Q
X-Google-Smtp-Source: AGHT+IGU3FN2UieCzy0mAvl4DFtG11qtE0JPuTrtymJjuovBIGHTp+DwEe+gu2FzoIZXFZUMSKqYYg==
X-Received: by 2002:a17:903:94e:b0:1d9:b27b:1b66 with SMTP id ma14-20020a170903094e00b001d9b27b1b66mr121101plb.7.1707178726169;
        Mon, 05 Feb 2024 16:18:46 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXQ4PQ3ac++et2fganKI0xwdo/7a4jpgQishQlScIcKs0fEVtFzcZdnoB4vL0E599Loga8FhnOY+lqtjxvbVo7L6rT64RInV56edmmQTHTyxZFSe4VD18/HYMyIVLxA4EwRSXBBVdqUuTI8D+SAODk=
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id x6-20020a170902ec8600b001d958de13c7sm486411plg.0.2024.02.05.16.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 16:18:45 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 5 Feb 2024 14:18:44 -1000
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH REPOST wq/for-6.9] workqueue: Don't implicitly make UNBOUND
 workqueues w/ @max_active==1 ordered
Message-ID: <ZcF65MlIYdKqukzK@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

5c0338c68706 ("workqueue: restore WQ_UNBOUND/max_active==1 to be ordered")
automoatically promoted UNBOUND workqueues w/ @max_active==1 to ordered
workqueues because UNBOUND workqueues w/ @max_active==1 used to be the way
to create ordered workqueues and the new NUMA support broke it. These
problems can be subtle and the fact that they can only trigger on NUMA
machines made them even more difficult to debug.

However, overloading the UNBOUND allocation interface this way creates other
issues. It's difficult to tell whether a given workqueue actually needs to
be ordered and users that legitimately want a min concurrency level wq
unexpectedly gets an ordered one instead. With planned UNBOUND workqueue
udpates to improve execution locality and more prevalence of chiplet designs
which can benefit from such improvements, this isn't a state we wanna be in
forever.

There aren't that many UNBOUND w/ @max_active==1 users in the tree and the
preceding patches audited all and converted them to
alloc_ordered_workqueue() as appropriate. This patch removes the implicit
promotion of UNBOUND w/ @max_active==1 workqueues to ordered ones.

v2: v1 patch incorrectly dropped !list_empty(&wq->pwqs) condition in
    apply_workqueue_attrs_locked() which spuriously triggers WARNING and
    fails workqueue creation. Fix it.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: kernel test robot <oliver.sang@intel.com>
Link: https://lore.kernel.org/oe-lkp/202304251050.45a5df1f-oliver.sang@intel.com
---
Hello,

The only remaining case that allocates an UNBOUND workqueue with @max_active
w/o WQ_SYSFS is the newly added fs/bcachefs/btree_update_interior.c and Kent
confirmed that that wq doesn't need ordering.

I'm applying this patch to wq/for-6.9.

Thanks.

 Documentation/core-api/workqueue.rst |   14 +++++---------
 include/linux/workqueue.h            |    4 +---
 kernel/workqueue.c                   |   22 ++++------------------
 3 files changed, 10 insertions(+), 30 deletions(-)

--- a/Documentation/core-api/workqueue.rst
+++ b/Documentation/core-api/workqueue.rst
@@ -256,15 +256,11 @@ may queue at the same time.  Unless ther
 throttling the number of active work items, specifying '0' is
 recommended.
 
-Some users depend on the strict execution ordering of ST wq.  The
-combination of ``@max_active`` of 1 and ``WQ_UNBOUND`` used to
-achieve this behavior.  Work items on such wq were always queued to the
-unbound worker-pools and only one work item could be active at any given
-time thus achieving the same ordering property as ST wq.
-
-In the current implementation the above configuration only guarantees
-ST behavior within a given NUMA node. Instead ``alloc_ordered_workqueue()`` should
-be used to achieve system-wide ST behavior.
+Some users depend on strict execution ordering where only one work item
+is in flight at any given time and the work items are processed in
+queueing order. While the combination of ``@max_active`` of 1 and
+``WQ_UNBOUND`` used to achieve this behavior, this is no longer the
+case. Use ``alloc_ordered_queue()`` instead.
 
 
 Example Execution Scenarios
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -392,7 +392,6 @@ enum wq_flags {
 	__WQ_DRAINING		= 1 << 16, /* internal: workqueue is draining */
 	__WQ_ORDERED		= 1 << 17, /* internal: workqueue is ordered */
 	__WQ_LEGACY		= 1 << 18, /* internal: create*_workqueue() */
-	__WQ_ORDERED_EXPLICIT	= 1 << 19, /* internal: alloc_ordered_workqueue() */
 
 	/* BH wq only allows the following flags */
 	__WQ_BH_ALLOWS		= WQ_BH | WQ_HIGHPRI,
@@ -507,8 +506,7 @@ alloc_workqueue(const char *fmt, unsigne
  * Pointer to the allocated workqueue on success, %NULL on failure.
  */
 #define alloc_ordered_workqueue(fmt, flags, args...)			\
-	alloc_workqueue(fmt, WQ_UNBOUND | __WQ_ORDERED |		\
-			__WQ_ORDERED_EXPLICIT | (flags), 1, ##args)
+	alloc_workqueue(fmt, WQ_UNBOUND | __WQ_ORDERED | (flags), 1, ##args)
 
 #define create_workqueue(name)						\
 	alloc_workqueue("%s", __WQ_LEGACY | WQ_MEM_RECLAIM, 1, (name))
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5007,12 +5007,8 @@ static int apply_workqueue_attrs_locked(
 		return -EINVAL;
 
 	/* creating multiple pwqs breaks ordering guarantee */
-	if (!list_empty(&wq->pwqs)) {
-		if (WARN_ON(wq->flags & __WQ_ORDERED_EXPLICIT))
-			return -EINVAL;
-
-		wq->flags &= ~__WQ_ORDERED;
-	}
+	if (!list_empty(&wq->pwqs) && WARN_ON(wq->flags & __WQ_ORDERED))
+		return -EINVAL;
 
 	ctx = apply_wqattrs_prepare(wq, attrs, wq_unbound_cpumask);
 	if (IS_ERR(ctx))
@@ -5333,15 +5329,6 @@ struct workqueue_struct *alloc_workqueue
 			return NULL;
 	}
 
-	/*
-	 * Unbound && max_active == 1 used to imply ordered, which is no longer
-	 * the case on many machines due to per-pod pools. While
-	 * alloc_ordered_workqueue() is the right way to create an ordered
-	 * workqueue, keep the previous behavior to avoid subtle breakages.
-	 */
-	if ((flags & WQ_UNBOUND) && max_active == 1)
-		flags |= __WQ_ORDERED;
-
 	/* see the comment above the definition of WQ_POWER_EFFICIENT */
 	if ((flags & WQ_POWER_EFFICIENT) && wq_power_efficient)
 		flags |= WQ_UNBOUND;
@@ -5564,14 +5551,13 @@ void workqueue_set_max_active(struct wor
 	if (WARN_ON(wq->flags & WQ_BH))
 		return;
 	/* disallow meddling with max_active for ordered workqueues */
-	if (WARN_ON(wq->flags & __WQ_ORDERED_EXPLICIT))
+	if (WARN_ON(wq->flags & __WQ_ORDERED))
 		return;
 
 	max_active = wq_clamp_max_active(max_active, wq->flags, wq->name);
 
 	mutex_lock(&wq->mutex);
 
-	wq->flags &= ~__WQ_ORDERED;
 	wq->saved_max_active = max_active;
 	if (wq->flags & WQ_UNBOUND)
 		wq->saved_min_active = min(wq->saved_min_active, max_active);
@@ -7028,7 +7014,7 @@ int workqueue_sysfs_register(struct work
 	 * attributes breaks ordering guarantee.  Disallow exposing ordered
 	 * workqueues.
 	 */
-	if (WARN_ON(wq->flags & __WQ_ORDERED_EXPLICIT))
+	if (WARN_ON(wq->flags & __WQ_ORDERED))
 		return -EINVAL;
 
 	wq->wq_dev = wq_dev = kzalloc(sizeof(*wq_dev), GFP_KERNEL);

