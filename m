Return-Path: <linux-kernel+bounces-82158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 371E7868005
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C82681F2B01F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF3612FB3E;
	Mon, 26 Feb 2024 18:47:51 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633E012F39B
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 18:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708973271; cv=none; b=O7ClPWzF7xl1wMDeLDZrNCkZHqgFr346q8YF0Fh+EURdwxVHbVcntjFI54rQNKmsyRa6fujnAYRXvEp6Y9z0EpSSp/E6yfgljumgNpmPOBPVDqqa765c9aq2RF4fUBNgSbP8Mdxzj7pbf1uNSPFP6El/5kQ5dh/gc5s8Artdgws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708973271; c=relaxed/simple;
	bh=8Nw3++8KqkLBDEGgcPa6Hj7GfV5L5E4uJvDO01jI9ng=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=AqKaBSyut2TQCNl4W7JxrHVzqlnKVX6DhrximeXTo0hN7tXJXiOW1Tu1C64RjpOMj+TbrRoMb2oZvqP9y6JAtCoVQ4aV35nMPbNs6jogcLFuAcG5t8xhURJc6qrI38Rb9N2q1RBL8otAnC8vqNEincAoNVtlTjvFIYIKeTr1Lvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 035BCC43601;
	Mon, 26 Feb 2024 18:47:51 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1reg2x-000000090av-1qPA;
	Mon, 26 Feb 2024 13:49:51 -0500
Message-ID: <20240226184951.297987021@goodmis.org>
User-Agent: quilt/0.67
Date: Mon, 26 Feb 2024 13:49:36 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 4/5] tracing: Add warning if string in __assign_str() does not match
 __string()
References: <20240226184932.303400070@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

In preparation to remove the second parameter of __assign_str(), make sure
it is really a duplicate of __string() by adding a WARN_ON_ONCE().

Link: https://lore.kernel.org/linux-trace-kernel/20240223161356.63b72403@gandalf.local.home

Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/stages/stage6_event_callback.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/trace/stages/stage6_event_callback.h b/include/trace/stages/stage6_event_callback.h
index 0c0f50bcdc56..935608971899 100644
--- a/include/trace/stages/stage6_event_callback.h
+++ b/include/trace/stages/stage6_event_callback.h
@@ -35,6 +35,7 @@
 	do {								\
 		char *__str__ = __get_str(dst);				\
 		int __len__ = __get_dynamic_array_len(dst) - 1;		\
+		WARN_ON_ONCE((src) != __data_offsets.dst##_ptr_);	\
 		memcpy(__str__, __data_offsets.dst##_ptr_ ? :		\
 		       EVENT_NULL_STR, __len__);			\
 		__str__[__len__] = '\0';				\
-- 
2.43.0



