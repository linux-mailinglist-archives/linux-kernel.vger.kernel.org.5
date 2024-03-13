Return-Path: <linux-kernel+bounces-101764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 634C587AB61
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FF5828CB00
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399BD605D2;
	Wed, 13 Mar 2024 16:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hthfsGtx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED07604D1;
	Wed, 13 Mar 2024 16:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347589; cv=none; b=Qk4JTqdUdj0JZInD6LpMr5aQbicbRaMp4CgU5RlGYolCeu0Vq8PCY9a9OU+X5lUIPojWG8rGgLBjIgiXDXJccyR4CKy+yste0bmQFOmSx7m/wcr3JCWxu3wCi27DML0P+7aNU2RxlC+Q1ZoQO8IUPPw9DDp+YigS1OrqVD7wHtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347589; c=relaxed/simple;
	bh=zVXcsojt3NoTCzwiD8lRVyRUKNBhxrBo3ee7NlCp+A4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FBtduCkeIYBbklR1oh2BLtdOoVqG8FmURzQOAGE1caiuTix505e+gLP5bY6rcBSUFDde378SaD5Pab1EsLnN72ldqtS1y/hAxdzmTQu3Bg+rrzKCjqChSdqERXCEWGtHorOxi1tNSdzRFbTvW5+I0FdEIIZQGh1O4prX9BY4TPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hthfsGtx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A73C433F1;
	Wed, 13 Mar 2024 16:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347589;
	bh=zVXcsojt3NoTCzwiD8lRVyRUKNBhxrBo3ee7NlCp+A4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hthfsGtxGpG09PCNQ42mGFnp6XR1VG0jXWl6GVFbNFIh+iJsJ2kHycD4Ne2ZotVOn
	 P/63kqiCqyQHEGGTbGXBTKq4QZH2xnUhAifXauWQ/PhfJnZMTDC6viN09yX+fLqUzK
	 QDJ8JCRDwOZF7mC93/dlKllM0o9Pm02AliArcuM3SrkwPdrQhEzf5Z/TkdS0R98E/d
	 R2TIur094+0xvGOAZ39fOQqsVb9VbZ0CsPJi7JaxwYo1721BHWTpbrirCl64dbUr+i
	 bV2r0i1fNeV/6olpuE3wFA7Q1Zl2WX5A3C+5dgU7T6Svu0xuVCFNCay3Ujd8VIG7fg
	 Gz4AMHs0TpeMA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 25/61] tracing/net_sched: Fix tracepoints that save qdisc_dev() as a string
Date: Wed, 13 Mar 2024 12:32:00 -0400
Message-ID: <20240313163236.613880-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163236.613880-1-sashal@kernel.org>
References: <20240313163236.613880-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.7.10-rc1
X-KernelTest-Deadline: 2024-03-15T16:32+00:00
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


