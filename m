Return-Path: <linux-kernel+bounces-102034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD9C87ADC7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D5801C22747
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428F4150992;
	Wed, 13 Mar 2024 16:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYQ8MvJz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B641504F8;
	Wed, 13 Mar 2024 16:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348414; cv=none; b=mv3JWW/+c1MXwMhO2+Ix5tL5Se959ZCXF+0bd0RtC6jXRrxNr/i+TmhMVqTmj5mEfdq+g8zb3Tgvi2r58meUGFhVlDzedRiiWHjBCtfRXLlOzRPsRhcgmkhumFch2qQk7tE7K8WZHr/nWtclXCOf5CdwqrX0VBLlYqH/lIo5nF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348414; c=relaxed/simple;
	bh=omi08HlZB7RPci6HACpNcDwsfJMHYTb4HMrBrSZf9Cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cBx5jV2vnoRnLKxSfusuTRbilzLwfLLgWVwV+JcmBv0vha82L5kY5KLdfanxaLRb46NJ1iVw4LfqAoORtef7ZauIaxCgjgIZdThEn3xhgnOmviVnHEMEPdaZe8tlYOom4jb+rZWABvZT2HuABUq7sOz57LfSuX+4vcsY5RzXgGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYQ8MvJz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84219C43394;
	Wed, 13 Mar 2024 16:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348414;
	bh=omi08HlZB7RPci6HACpNcDwsfJMHYTb4HMrBrSZf9Cw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eYQ8MvJzCLOkOhj6oabegtSZcnAE3u49on1+xq3vlXEsLjX+luSUQ19MrajbChHpY
	 VTJ44Ag6VlFdBDO01vLcc3vyW/rb8rfoTDundxhRAAObjhs/OeWWY7hKJx/PxI+wcV
	 9qjutpylDBSLyZQ/0pC6zbGiYrwZZvLgBYpVGWw/f/dDw+phPdzdBToRhPag9VmyNa
	 CC7YpC3dFyuCYMMCSIND4CG3cbQLymqHu5KgxQRXI+lzVcS3bNba48fU5hS9ZIiZae
	 mAL//C80dPCehOZ71cKL7m89VtmNvMmyVdh4tMxWtLwegc0TU+nOzQbzWclyFLbzHz
	 sBmCxbzg8YtfA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 10/73] tracing/net_sched: Fix tracepoints that save qdisc_dev() as a string
Date: Wed, 13 Mar 2024 12:45:37 -0400
Message-ID: <20240313164640.616049-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164640.616049-1-sashal@kernel.org>
References: <20240313164640.616049-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.213-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.213-rc1
X-KernelTest-Deadline: 2024-03-15T16:46+00:00
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
index 330d32d84485b..a50df41634c58 100644
--- a/include/trace/events/qdisc.h
+++ b/include/trace/events/qdisc.h
@@ -53,14 +53,14 @@ TRACE_EVENT(qdisc_reset,
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
@@ -78,14 +78,14 @@ TRACE_EVENT(qdisc_destroy,
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


