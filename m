Return-Path: <linux-kernel+bounces-147698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9338A77EF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD512B2205A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C1113A260;
	Tue, 16 Apr 2024 22:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lNSjLpRh"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14483B185;
	Tue, 16 Apr 2024 22:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713307270; cv=none; b=ZpY+hXDRQ9SU3HRbGMmcoJVbHnJZrU9dZhpVy8abhmY/DZVkV/3vQVXLLKsRI05sg+qUsAPN3zG3X0fidPRomrhF+ltHes5QIFtWwD5UNXT+1Do/bETUUDEwqydgp9afv3bEL6BakjUjgPmjO4v3oxeLRrdrD+OKwQr6+jzlLls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713307270; c=relaxed/simple;
	bh=SdGKTCvRowhNJxr+bzEZa+IlrhiheIS8euVQLtIw0Qo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vu3YXD2w4yWs2oZwYu/OodGFsuSocKRwnVrnT37Vp25TO7kUpg7HUR6QzYG8WR/i9c5EvdUByOVi9pdVPH5e5/JvoXQ0utQge4zTFW7fx4ELIj6NjLDhiUxyio2alDAznbvxBFnyDzP4MO2swAJyfMo/VhPv/11UqqtyJ2K8+do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lNSjLpRh; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost.localdomain (unknown [4.155.48.117])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2CF8620FD422;
	Tue, 16 Apr 2024 15:41:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2CF8620FD422
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1713307269;
	bh=+sP+L3AzA/ELT2/LLBPfQCFsuQ9bBl7MY+RkhoYAtDA=;
	h=From:To:Cc:Subject:Date:From;
	b=lNSjLpRhqUiV9VRg2ydcMf4diFtWXzGGV9QAVCXVmCfoPsSmWtJGvdNCFCvdmKmTZ
	 pVNZO6eFDehbOUpHs7SfLdsgwlWfHSZRIfSsVtU22RPCpbXjgQQChm2nGqIPs3Ockc
	 mHHZJi0L0vTWXHYBy4a0txjhU1pl+O+tIVTRaCfY=
From: Beau Belgrave <beaub@linux.microsoft.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	dcook@linux.microsoft.com
Subject: [PATCH 0/2] tracing/user_events: Fix non-spaced field matching
Date: Tue, 16 Apr 2024 22:41:00 +0000
Message-Id: <20240416224102.734-1-beaub@linux.microsoft.com>
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

Beau Belgrave (2):
  tracing/user_events: Fix non-spaced field matching
  selftests/user_events: Add non-spacing separator check

 kernel/trace/trace_events_user.c              | 88 ++++++++++++++++++-
 .../selftests/user_events/ftrace_test.c       |  8 ++
 2 files changed, 95 insertions(+), 1 deletion(-)


base-commit: 0bbac3facb5d6cc0171c45c9873a2dc96bea9680
-- 
2.34.1


