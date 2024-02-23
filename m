Return-Path: <linux-kernel+bounces-79139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B368861E1B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A2D01F25C63
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975F8149395;
	Fri, 23 Feb 2024 20:46:30 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D9E14938A;
	Fri, 23 Feb 2024 20:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708721190; cv=none; b=aEoBMNwJpVwzR2x/AUFClTAKpIAIlEk61obrUiqHxznLgmiX3NVo7x3Od7udbP2u0Rvy95fZefez3lcJYrp8URXXM1exhZTr6O9Pz9R0k+jmwfnOo7pTNpHZkhKQnJtktqzVdiEEUdQ6l9LbijfFCvPPMZmTRY46+iA3N0tWMdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708721190; c=relaxed/simple;
	bh=rMWchYtw6//ZqIK6YL+3KrAXiDAeU75FO6yh7LAh+sE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=VYcpCj8BnbRnOX41jyyaSoXAqKlUT6SwEu+K4SIbbManIaZuNhYAlCxMddCftYa7A11i0Peim/hLfcyrrcU9hNVSCYH9UI6rTJmtiSbXl4Pa4bfg/5Po/e/56Ivp0zkYhBeaReV46ncdSi0hCqLHhKGXvy2DCABIW3v3JkSsm2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DA8C433F1;
	Fri, 23 Feb 2024 20:46:28 +0000 (UTC)
Date: Fri, 23 Feb 2024 15:48:21 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH] tracing: Add warning if string in __assign_str() does not
 match __string()
Message-ID: <20240223154821.77b2426d@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

In preparation to remove the second parameter of __assign_str(), make sure
it is really a duplicate of __string() by adding a WARN_ON_ONCE().

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/stages/stage6_event_callback.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/trace/stages/stage6_event_callback.h b/include/trace/stages/stage6_event_callback.h
index 0c0f50bcdc56..7372e2c2a0c4 100644
--- a/include/trace/stages/stage6_event_callback.h
+++ b/include/trace/stages/stage6_event_callback.h
@@ -35,6 +35,7 @@
 	do {								\
 		char *__str__ = __get_str(dst);				\
 		int __len__ = __get_dynamic_array_len(dst) - 1;		\
+		WARN_ON_ONCE((src) && (src) != __data_offsets.dst##_ptr_); \
 		memcpy(__str__, __data_offsets.dst##_ptr_ ? :		\
 		       EVENT_NULL_STR, __len__);			\
 		__str__[__len__] = '\0';				\
-- 
2.43.0


