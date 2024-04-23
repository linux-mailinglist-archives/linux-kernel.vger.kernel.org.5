Return-Path: <linux-kernel+bounces-155553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66ACE8AF3D9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46292B25B5D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1FE13D886;
	Tue, 23 Apr 2024 16:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Ui2S+e8/"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA0213D254;
	Tue, 23 Apr 2024 16:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713889425; cv=none; b=sGQ3nuiXnlB5XjKkVE+FuuSvWpobmHlaNNP0zFaSDqh8/JuuH5NBLR147nSnVdxG8n4GQakAgPgzniUTx/OLPGgjb7XegOxCyNljN6KBdfeZby7CIZ49i0V1F3Yewx/c32t9DihogdbKAxVhSkkWNxX4lRCsSLzeQvXElv9RvHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713889425; c=relaxed/simple;
	bh=w4YN+H4gxVX9bCiaMWUd1g2Z7829wyxFUEczrxYlHHs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OVVIhUx3m1rQlahzmiJqoD6LwHf4yRpEAtlc7mELY8UhoUo+oV71ptLDrGXo4QtRQEZDUWBC+57Up0PBPiqjO/4jvZB2TY8ds2eFZ0jPxqm+rLp1g1mIex0e+eeOTUpmcclLgD78PqKVNmcgPjVcF41tlUOQVUw1hF80GAw/rKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Ui2S+e8/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost.localdomain (unknown [4.155.48.122])
	by linux.microsoft.com (Postfix) with ESMTPSA id E383120FFC15;
	Tue, 23 Apr 2024 09:23:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E383120FFC15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1713889423;
	bh=GrfTFKMTYc6Wjy1jyI4qZjJ77SgqBxd4tOudBF1fvJM=;
	h=From:To:Cc:Subject:Date:From;
	b=Ui2S+e8/ZOoBfqQWBZGQFYfxPL50UYJviLZAhEGrWvpaqpNJBFVzBA65qc1L/E+WL
	 bfFnYSV8pL4M+PdsJm4oijDL+X3T1T6Ex1h2FUbiPPtyLkqSAqIao47Fs7WYdAUN4w
	 KKnqSbkTNJTeAyhzRPEg0BmyQ0g6J24G7jR4tA+k=
From: Beau Belgrave <beaub@linux.microsoft.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	dcook@linux.microsoft.com
Subject: [PATCH v2 0/2] tracing/user_events: Fix non-spaced field matching
Date: Tue, 23 Apr 2024 16:23:36 +0000
Message-Id: <20240423162338.292-1-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the ABI was updated to prevent same name w/different args, it
missed an important corner case when fields don't end with a space.
Typically, space is used for fields to help separate them, like
"u8 field1; u8 field2". If no spaces are used, like
"u8 field1;u8 field2", then the parsing works for the first time.
However, the match check fails on a subsequent register, leading to
confusion.

This is because the match check uses argv_split() and assumes that all
fields will be split upon the space. When spaces are used, we get back
{ "u8", "field1;" }, without spaces we get back { "u8", "field1;u8" }.
This causes a mismatch, and the user program gets back -EADDRINUSE.

Add a method to detect this case before calling argv_split(). If found
force a space after the field separator character ';'. This ensures all
cases work properly for matching.

I could not find an existing function to accomplish this, so I had to
hand code a copy with this logic. If there is a better way to achieve
this, I'm all ears.

This series also adds a selftest to ensure this doesn't break again.

With this fix, the following are all treated as matching:
u8 field1;u8 field2
u8 field1; u8 field2
u8 field1;\tu8 field2
u8 field1;\nu8 field2

V2 changes:
  Renamed fix_semis_no_space() to insert_space_after_semis().
  Have user_event_argv_split() return fast in no-split case.
  Pulled in Masami's shorter loop in insert_space_after_semis().

Beau Belgrave (2):
  tracing/user_events: Fix non-spaced field matching
  selftests/user_events: Add non-spacing separator check

 kernel/trace/trace_events_user.c              | 76 ++++++++++++++++++-
 .../selftests/user_events/ftrace_test.c       |  8 ++
 2 files changed, 83 insertions(+), 1 deletion(-)


base-commit: 0bbac3facb5d6cc0171c45c9873a2dc96bea9680
-- 
2.34.1


