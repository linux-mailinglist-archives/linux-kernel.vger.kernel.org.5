Return-Path: <linux-kernel+bounces-15050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F17718226AB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 02:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FBEB2840A6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 01:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0F9185A;
	Wed,  3 Jan 2024 01:51:27 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17231116;
	Wed,  3 Jan 2024 01:51:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66BEEC433CA;
	Wed,  3 Jan 2024 01:51:26 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rKqQm-00000000k6G-2cE0;
	Tue, 02 Jan 2024 20:52:28 -0500
Message-ID: <20240103015228.487061905@goodmis.org>
User-Agent: quilt/0.67
Date: Tue, 02 Jan 2024 20:50:45 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org
Subject: [for-linus][PATCH 2/2] eventfs: Fix bitwise fields for "is_events"
References: <20240103015043.912131206@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

A flag was needed to denote which eventfs_inode was the "events"
directory, so a bit was taken from the "nr_entries" field, as there's not
that many entries, and 2^30 is plenty. But the bit number for nr_entries
was not updated to reflect the bit taken from it, which would add an
unnecessary integer to the structure.

Link: https://lore.kernel.org/linux-trace-kernel/20240102151832.7ca87275@gandalf.local.home

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Fixes: 7e8358edf503e ("eventfs: Fix file and directory uid and gid ownership")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index 899e447778ac..42bdeb471a07 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -63,7 +63,7 @@ struct eventfs_inode {
 	};
 	unsigned int			is_freed:1;
 	unsigned int			is_events:1;
-	unsigned int			nr_entries:31;
+	unsigned int			nr_entries:30;
 };
 
 static inline struct tracefs_inode *get_tracefs(const struct inode *inode)
-- 
2.42.0



