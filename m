Return-Path: <linux-kernel+bounces-101874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0834087AC56
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A83C3B23616
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10ED776EE9;
	Wed, 13 Mar 2024 16:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7/7lxPJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441D776C93;
	Wed, 13 Mar 2024 16:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348008; cv=none; b=Yw/36duQl1Hy03mISE5Xb3OAHHmhSc6/QlkRvZh7pAFu8k71lH4/UUMRaJQBJYsz3C8vKxU5fq7SM/RP1tTb/niC0I6TzvQ4PcQbuNz5BpUmGEdS6Gm9nFCbVJ+V4MIVXlt6T6+3F8XhWKxH+4H8onf5bLFH18xls7ZwjPSMFvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348008; c=relaxed/simple;
	bh=zVXcsojt3NoTCzwiD8lRVyRUKNBhxrBo3ee7NlCp+A4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ajFFdZvxJNexL5LatMam1vcnsNemzvmkCCYX9IRRGX8KxfdkGHw4+demQC1wiy86cf/EK5jVlmpuCw/fNImom3Jl5Lj6uQH9puoRIBXDtHBQ1EWSpHA5ZrsgEF/CnlEH00Trqz29JN8ge5tAd3yIkhOv+BadyMmuxUXocIhPr8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7/7lxPJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E662AC433F1;
	Wed, 13 Mar 2024 16:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348007;
	bh=zVXcsojt3NoTCzwiD8lRVyRUKNBhxrBo3ee7NlCp+A4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b7/7lxPJdI2LIRx5C9wz2yTVSCuHGb7joeqKzUH8XgkusgoS663fubNxZ0us7mCSY
	 uCvNz9BMJB4ytxynOzF+ptzZwJf0FrFxRUWlzjJs/Q/6uG+K3aDYZULX3OOj/tNE12
	 1NW2eebo822hfNQt/L0dDC7LjpSXA47C4SXWa8zPzlNw82pa9iQ7cvJ9sNleRCdksB
	 7kFJKmBsCNj0pqnZyd1ZsFSc1K52M2czUR9l1y3P4yv7IrPOQ7MDrZJLA5xNWPsD4V
	 c1A43wTbs7DtDDIpznmYPqRO7nXi2fLJm8FpprOa8GoIWFbdqGE/1ukEmnwaOqZK1/
	 lb8tCDc1S3uMA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 06/71] tracing/net_sched: Fix tracepoints that save qdisc_dev() as a string
Date: Wed, 13 Mar 2024 12:38:52 -0400
Message-ID: <20240313163957.615276-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163957.615276-1-sashal@kernel.org>
References: <20240313163957.615276-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.82-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.82-rc1
X-KernelTest-Deadline: 2024-03-15T16:39+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

[ Upstream commit 51270d573a8d9dd5afdc7934de97d66c0e14b5fd ]

I'm updating __assign_str() and will be removing the second parameter. To
make sure that it does not break anything, I make sure that it matches the
__string() field, as that is where the string is actually going to be
saved in. To make sure there's nothing that breaks, I added a WARN_ON() to
make sure that what was used in __string() is the same that is used in
__assign_str().

In doing this change, an error was triggered as __assign_str() now expects
the string passed in to be a char * value. I instead had the following
warning:

include/trace/events/qdisc.h: In function ‘trace_event_raw_event_qdisc_reset’:
include/trace/events/qdisc.h:91:35: error: passing argument 1 of 'strcmp' from incompatible pointer type [-Werror=incompatible-pointer-types]
   91 |                 __assign_str(dev, qdisc_dev(q));

That's because the qdisc_enqueue() and qdisc_reset() pass in qdisc_dev(q)
to __assign_str() and to __string(). But that function returns a pointer
to struct net_device and not a string.

It appears that these events are just saving the pointer as a string and
then reading it as a string as well.

Use qdisc_dev(q)->name to save the device instead.

Fixes: a34dac0b90552 ("net_sched: add tracepoints for qdisc_reset() and qdisc_destroy()")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/trace/events/qdisc.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/trace/events/qdisc.h b/include/trace/events/qdisc.h
index a3995925cb057..1f4258308b967 100644
--- a/include/trace/events/qdisc.h
+++ b/include/trace/events/qdisc.h
@@ -81,14 +81,14 @@ TRACE_EVENT(qdisc_reset,
 	TP_ARGS(q),
 
 	TP_STRUCT__entry(
-		__string(	dev,		qdisc_dev(q)	)
-		__string(	kind,		q->ops->id	)
-		__field(	u32,		parent		)
-		__field(	u32,		handle		)
+		__string(	dev,		qdisc_dev(q)->name	)
+		__string(	kind,		q->ops->id		)
+		__field(	u32,		parent			)
+		__field(	u32,		handle			)
 	),
 
 	TP_fast_assign(
-		__assign_str(dev, qdisc_dev(q));
+		__assign_str(dev, qdisc_dev(q)->name);
 		__assign_str(kind, q->ops->id);
 		__entry->parent = q->parent;
 		__entry->handle = q->handle;
@@ -106,14 +106,14 @@ TRACE_EVENT(qdisc_destroy,
 	TP_ARGS(q),
 
 	TP_STRUCT__entry(
-		__string(	dev,		qdisc_dev(q)	)
-		__string(	kind,		q->ops->id	)
-		__field(	u32,		parent		)
-		__field(	u32,		handle		)
+		__string(	dev,		qdisc_dev(q)->name	)
+		__string(	kind,		q->ops->id		)
+		__field(	u32,		parent			)
+		__field(	u32,		handle			)
 	),
 
 	TP_fast_assign(
-		__assign_str(dev, qdisc_dev(q));
+		__assign_str(dev, qdisc_dev(q)->name);
 		__assign_str(kind, q->ops->id);
 		__entry->parent = q->parent;
 		__entry->handle = q->handle;
-- 
2.43.0


