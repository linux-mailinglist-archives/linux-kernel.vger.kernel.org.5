Return-Path: <linux-kernel+bounces-123023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD029890128
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE10E1C2359F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0041A12DD9F;
	Thu, 28 Mar 2024 14:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYCMzsrE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E34129E81;
	Thu, 28 Mar 2024 14:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711634815; cv=none; b=n9uQjWh+xVopXwWZTLfgiKbBy2OgeDbbqkYLMHF4HWdKtpk5o9E6Mpua/mWZnFUkZ6Tlhp49PeAQCnJ9YdQRbbv8pVcaWk2S6RtmPZfoH8lv07TSZTrpjW3PHf7VWsvSKef7dNWltZ+pNmE29vDcqGwf/5hpnnshH5J0o7dD2p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711634815; c=relaxed/simple;
	bh=4Sl2+ylJNPrkTlbZJE1y57+3AaBXLpboKEKujg0bFD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R8WuLBFMcPJLl6cA4d4KEJJObFirVt7s+YkCpcagp+UqoIijukZQED0AOLENZMDjWjKRuePSNCS7LVR0cwrlBzxKR+RpkaryYcr3aIDsD5Q/3T00pPIgCOtJak4X+0PkpXvgFvyrffzzqPMjuaItXw//X7C7/SecbAPGggJlrzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYCMzsrE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC22C433C7;
	Thu, 28 Mar 2024 14:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711634814;
	bh=4Sl2+ylJNPrkTlbZJE1y57+3AaBXLpboKEKujg0bFD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FYCMzsrEVcyxP1XJhQaxTBt5DaBA2wyIYnrE2OsH3WaOj1FvDey9aFrzZt+gSz7k7
	 z0SUHERlLXNrgM/t0uMzYS8iMEXh9K3FJA+WUPlNG9AuANTMdfHy7G6ObmmlUaEncx
	 g5bFeK3k200QYAg0ehIgZXN1WAcFtAhXEloKn6p8DPumCHxhJzLvdIeOx2pWWjgskr
	 84m6zeMItrJBAOtuwQRr01nSH6aH8kXra7LQKqhEw53WiqsGNKfIpqx8sQAYUlWPg7
	 hGDg++GOtZH7XAAAB08NWysoOetgdxL4fJcnq2yDXY6RGd2Pg0B9O+5Tk32VsvtUQD
	 PD90IojI+UJ0Q==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-block@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 08/11] blktrace: convert strncpy() to strscpy_pad()
Date: Thu, 28 Mar 2024 15:04:52 +0100
Message-Id: <20240328140512.4148825-9-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240328140512.4148825-1-arnd@kernel.org>
References: <20240328140512.4148825-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

gcc-9 warns about a possibly non-terminated string copy:

kernel/trace/blktrace.c: In function 'do_blk_trace_setup':
kernel/trace/blktrace.c:527:2: error: 'strncpy' specified bound 32 equals destination size [-Werror=stringop-truncation]

Newer versions are fine here because they see the following explicit
nul-termination. Using strscpy_pad() avoids the warning and
simplifies the code a little. The padding helps  give a clean
buffer to userspace.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/trace/blktrace.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index d5d94510afd3..95a00160d465 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -524,8 +524,7 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	if (!buts->buf_size || !buts->buf_nr)
 		return -EINVAL;
 
-	strncpy(buts->name, name, BLKTRACE_BDEV_SIZE);
-	buts->name[BLKTRACE_BDEV_SIZE - 1] = '\0';
+	strscpy(buts->name, name, BLKTRACE_BDEV_SIZE);
 
 	/*
 	 * some device names have larger paths - convert the slashes
-- 
2.39.2


