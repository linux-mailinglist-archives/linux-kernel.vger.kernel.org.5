Return-Path: <linux-kernel+bounces-40707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D0583E465
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19E461C22829
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B498B250F0;
	Fri, 26 Jan 2024 21:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnZWwvIf"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C2124B31
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 21:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706306327; cv=none; b=GEAI9rqyF91FRXaip+Kp638MOL32/KqwesqU+PxtRUe57aOg9rkkxxwjNuzuTG0/G/zEqStx16mW7Kfrg2iVTRTJQhuRP8kBF6gGkR4h1Bb05crQs5xUw7nu9OodWnp/A30RgxGpH8gQUQ8ZynGoAQxz+tKKu/bR4P/exoOZeIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706306327; c=relaxed/simple;
	bh=D45Up2bdBfDyI7OgcSPW8IyQu74BTfqA+rIamsUdIsw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mBYWRYX0U/rbZ8HtlvwTjEBcHxy/y5qcLzum4E+DKsVAMP04S17xeBSgk7NuUPWSx7Sfp2wI2+aAHfFAFoIIdZhxXu9JEGhf/FRTmU2Ck145QMxJVOqL62kDGfYG/1OtFRv4dyJmpbiuWk5Zh+FaihNszB9bm76ZA1HHyff40DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnZWwvIf; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d7232dcb3eso6448155ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 13:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706306325; x=1706911125; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=TWFD8GN2cVl4vpBfTmCVEM0ZmFoZqktV+61fEzV3wTw=;
        b=HnZWwvIf3AHGBe/bVjNpWYif4NOzxbvAIU74ZfJkfdQDXvbhjmDp+FPdEah+AmrRMs
         QT4WMAWT6Xcsp/RsaCieypnSfDagDoeXQVk3Qnv0v4EE4SoK9kEDLmPN5r+MdamP55zH
         msiWXeQGaUky1kjv/+YpgWTQhCbCiQD+OS2hXqL7HfnD0nCe4uRVN7nfUs2Fh4WRJSad
         3XJgi7aJcZ39PL5ORf7S7xWEB5Wh30czeTFSrwz51CTi+9zFIHoWJC+4Vdm7IMnlvH7V
         oC5+9EyGIlUkzMrEL78E3UeS6L7CcZdaly0L0aFdXj1lHupsQG+yTQkybTLUwpE4sA10
         PQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706306325; x=1706911125;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TWFD8GN2cVl4vpBfTmCVEM0ZmFoZqktV+61fEzV3wTw=;
        b=HkBYUyui9p4FHSmYGQYW39iw330rvB0qJPzWim7h94UJn7SiqQeP7537fk3KgwJ449
         ZQcVQFJfDtXk/uZXjmsHfkuxbzOF/ipB43lhI/p22oMuf8k18eD7RQCwEMy7U2yeEN80
         +S0Ij35nZp8TwjNIsPcJFE8TXklvbO0bZMYkMJJl6oZVqxqIgtFvfIoRpAbHy9tx70dH
         XsjJL1DHH10NrM0EBhlCp7y4vk4L+MBK8Q2y8fsFUsjgd7WEoTE+KnGnRLINhgQEjicl
         nViNUI36QZbxKnsRZRoPcsNq1IUmi23Nt5AwWp+h/3cx2+JMMH8+qcD1iN9qXN1ZdCek
         ScAA==
X-Gm-Message-State: AOJu0Yy8/uE5ifCV4oLdCICgjYIgv28uTtmh7JEFQI5eNv9BJHISOPJm
	X4EODNL9hYgUMxjIR9iM9UZYEQosHGQd1YLQUPOcHJ9fed9y7CUPjnPvFF7Y
X-Google-Smtp-Source: AGHT+IHP9cd5TIFAOU3gcvoQsz/ywakikA29dHOhFvI+6g0y8TcHrpoLhO6RIX2q0dFBv0cZyGCAeA==
X-Received: by 2002:a17:902:b08d:b0:1d7:8e11:152c with SMTP id p13-20020a170902b08d00b001d78e11152cmr411980plr.3.1706306324723;
        Fri, 26 Jan 2024 13:58:44 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id ko3-20020a17090307c300b001d77c28ae9dsm1403355plb.17.2024.01.26.13.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 13:58:44 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 26 Jan 2024 11:58:43 -1000
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH wq/for-6.9] workqueue: Break up enum definitions and give
 names to the types
Message-ID: <ZbQrE6xwqiSUlTRn@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From e563d0a7cdc1890ff36bb177b5c8c2854d881e4d Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Fri, 26 Jan 2024 11:55:50 -1000

workqueue is collecting different sorts of enums into a single unnamed enum
type which can increase confusion around enum width. Also, unnamed enums
can't be accessed from BPF. Let's break up enum definitions according to
their purposes and give them type names.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
Applied to wq/for-6.9.

 include/linux/workqueue.h | 41 +++++++++++++++++++++++----------------
 kernel/workqueue.c        |  6 +++++-
 2 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 2cc0a9606175..78047d0d9882 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -22,7 +22,7 @@
  */
 #define work_data_bits(work) ((unsigned long *)(&(work)->data))
 
-enum {
+enum work_bits {
 	WORK_STRUCT_PENDING_BIT	= 0,	/* work item is pending execution */
 	WORK_STRUCT_INACTIVE_BIT= 1,	/* work item is inactive */
 	WORK_STRUCT_PWQ_BIT	= 2,	/* data points to pwq */
@@ -36,21 +36,6 @@ enum {
 
 	WORK_STRUCT_COLOR_BITS	= 4,
 
-	WORK_STRUCT_PENDING	= 1 << WORK_STRUCT_PENDING_BIT,
-	WORK_STRUCT_INACTIVE	= 1 << WORK_STRUCT_INACTIVE_BIT,
-	WORK_STRUCT_PWQ		= 1 << WORK_STRUCT_PWQ_BIT,
-	WORK_STRUCT_LINKED	= 1 << WORK_STRUCT_LINKED_BIT,
-#ifdef CONFIG_DEBUG_OBJECTS_WORK
-	WORK_STRUCT_STATIC	= 1 << WORK_STRUCT_STATIC_BIT,
-#else
-	WORK_STRUCT_STATIC	= 0,
-#endif
-
-	WORK_NR_COLORS		= (1 << WORK_STRUCT_COLOR_BITS),
-
-	/* not bound to any CPU, prefer the local CPU */
-	WORK_CPU_UNBOUND	= NR_CPUS,
-
 	/*
 	 * Reserve 8 bits off of pwq pointer w/ debugobjects turned off.
 	 * This makes pwqs aligned to 256 bytes and allows 16 workqueue
@@ -74,6 +59,26 @@ enum {
 	WORK_OFFQ_LEFT		= BITS_PER_LONG - WORK_OFFQ_POOL_SHIFT,
 	WORK_OFFQ_POOL_BITS	= WORK_OFFQ_LEFT <= 31 ? WORK_OFFQ_LEFT : 31,
 
+};
+
+enum work_flags {
+	WORK_STRUCT_PENDING	= 1 << WORK_STRUCT_PENDING_BIT,
+	WORK_STRUCT_INACTIVE	= 1 << WORK_STRUCT_INACTIVE_BIT,
+	WORK_STRUCT_PWQ		= 1 << WORK_STRUCT_PWQ_BIT,
+	WORK_STRUCT_LINKED	= 1 << WORK_STRUCT_LINKED_BIT,
+#ifdef CONFIG_DEBUG_OBJECTS_WORK
+	WORK_STRUCT_STATIC	= 1 << WORK_STRUCT_STATIC_BIT,
+#else
+	WORK_STRUCT_STATIC	= 0,
+#endif
+};
+
+enum wq_misc_consts {
+	WORK_NR_COLORS		= (1 << WORK_STRUCT_COLOR_BITS),
+
+	/* not bound to any CPU, prefer the local CPU */
+	WORK_CPU_UNBOUND	= NR_CPUS,
+
 	/* bit mask for work_busy() return values */
 	WORK_BUSY_PENDING	= 1 << 0,
 	WORK_BUSY_RUNNING	= 1 << 1,
@@ -347,7 +352,7 @@ static inline unsigned int work_static(struct work_struct *work) { return 0; }
  * Workqueue flags and constants.  For details, please refer to
  * Documentation/core-api/workqueue.rst.
  */
-enum {
+enum wq_flags {
 	WQ_UNBOUND		= 1 << 1, /* not bound to any cpu */
 	WQ_FREEZABLE		= 1 << 2, /* freeze during suspend */
 	WQ_MEM_RECLAIM		= 1 << 3, /* may be used for memory reclaim */
@@ -387,7 +392,9 @@ enum {
 	__WQ_ORDERED		= 1 << 17, /* internal: workqueue is ordered */
 	__WQ_LEGACY		= 1 << 18, /* internal: create*_workqueue() */
 	__WQ_ORDERED_EXPLICIT	= 1 << 19, /* internal: alloc_ordered_workqueue() */
+};
 
+enum wq_consts {
 	WQ_MAX_ACTIVE		= 512,	  /* I like 512, better ideas? */
 	WQ_UNBOUND_MAX_ACTIVE	= WQ_MAX_ACTIVE,
 	WQ_DFL_ACTIVE		= WQ_MAX_ACTIVE / 2,
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index b6b690a17f7c..45d0a784ba4f 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -56,7 +56,7 @@
 
 #include "workqueue_internal.h"
 
-enum {
+enum worker_pool_flags {
 	/*
 	 * worker_pool flags
 	 *
@@ -75,7 +75,9 @@ enum {
 	 */
 	POOL_MANAGER_ACTIVE	= 1 << 0,	/* being managed */
 	POOL_DISASSOCIATED	= 1 << 2,	/* cpu can't serve workers */
+};
 
+enum worker_flags {
 	/* worker flags */
 	WORKER_DIE		= 1 << 1,	/* die die die */
 	WORKER_IDLE		= 1 << 2,	/* is idle */
@@ -86,7 +88,9 @@ enum {
 
 	WORKER_NOT_RUNNING	= WORKER_PREP | WORKER_CPU_INTENSIVE |
 				  WORKER_UNBOUND | WORKER_REBOUND,
+};
 
+enum wq_internal_consts {
 	NR_STD_WORKER_POOLS	= 2,		/* # standard pools per cpu */
 
 	UNBOUND_POOL_HASH_ORDER	= 6,		/* hashed by pool->attrs */
-- 
2.43.0


