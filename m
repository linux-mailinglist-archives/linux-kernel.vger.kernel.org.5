Return-Path: <linux-kernel+bounces-87357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E24786D33B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 157581F22BD5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A0613C9E1;
	Thu, 29 Feb 2024 19:32:39 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F577A5F;
	Thu, 29 Feb 2024 19:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709235159; cv=none; b=fqyAVRv6rJVegw4D4l1RUfnJbUARmv34Rn+TwruQj2LZB7UG7Tu/JszYUpcXisGy5aMC3zN1leyw7ac9dCySuMvWxrpskTKM7x0lyICcnj5VK5PO5GZPm6xGoAa2eTv8XerO9hQjWh1TJqNf3ENgpdJQHWvhEyAurY7hRniWr1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709235159; c=relaxed/simple;
	bh=j4u9BHygwjjo7Ecj2eWal+ye8Cv8ztly1iJNSlqiYt8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=NQojRh26vPaSaQs/quYLoBGUUFqprYYsRK0HbB5pg7aGW+JF0UHgdrZiyXJky0+Ywi20KvwllAJCSpH4kOkc0QDZoYtdbHOFn2ot201cAVNLwDfJqSj71LB9J2+aDFPRtCLkZXfyUHAITljM+o9gJksXqiKjxEaH/jQdtKMRpS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62671C433C7;
	Thu, 29 Feb 2024 19:32:37 +0000 (UTC)
Date: Thu, 29 Feb 2024 14:34:44 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 vaclav.zindulka@tlapnet.cz, Jamal Hadi Salim  <jhs@mojatatu.com>, Jiri
 Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>
Subject: [PATCH] tracing/net_sched: Fix tracepoints that save qdisc_dev() as
 a string
Message-ID: <20240229143432.273b4871@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

I'm updating __assign_str() and will be removing the second parameter. To
make sure that it does not break anything, I make sure that it matches the
__string() field, as that is where the string is actually going to be
saved in. To make sure there's nothing that breaks, I added a WARN_ON() to
make sure that what was used in __string() is the same that is used in
__assign_str().

In doing this change, an error was triggered as __assign_str() now expects
the string passed in to be a char * value. I instead had the following
warning:

include/trace/events/qdisc.h: In function =E2=80=98trace_event_raw_event_qd=
isc_reset=E2=80=99:
include/trace/events/qdisc.h:91:35: error: passing argument 1 of 'strcmp' f=
rom incompatible pointer type [-Werror=3Dincompatible-pointer-types]
   91 |                 __assign_str(dev, qdisc_dev(q));

That's because the qdisc_enqueue() and qdisc_reset() pass in qdisc_dev(q)
to __assign_str() and to __string(). But that function returns a pointer
to struct net_device and not a string.

It appears that these events are just saving the pointer as a string and
then reading it as a string as well.

Use qdisc_dev(q)->name to save the device instead.

Fixes: a34dac0b90552 ("net_sched: add tracepoints for qdisc_reset() and qdi=
sc_destroy()")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/events/qdisc.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/trace/events/qdisc.h b/include/trace/events/qdisc.h
index a3995925cb05..1f4258308b96 100644
--- a/include/trace/events/qdisc.h
+++ b/include/trace/events/qdisc.h
@@ -81,14 +81,14 @@ TRACE_EVENT(qdisc_reset,
 	TP_ARGS(q),
=20
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
=20
 	TP_fast_assign(
-		__assign_str(dev, qdisc_dev(q));
+		__assign_str(dev, qdisc_dev(q)->name);
 		__assign_str(kind, q->ops->id);
 		__entry->parent =3D q->parent;
 		__entry->handle =3D q->handle;
@@ -106,14 +106,14 @@ TRACE_EVENT(qdisc_destroy,
 	TP_ARGS(q),
=20
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
=20
 	TP_fast_assign(
-		__assign_str(dev, qdisc_dev(q));
+		__assign_str(dev, qdisc_dev(q)->name);
 		__assign_str(kind, q->ops->id);
 		__entry->parent =3D q->parent;
 		__entry->handle =3D q->handle;
--=20
2.43.0


