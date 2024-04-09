Return-Path: <linux-kernel+bounces-137050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F7389DB9E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7C87B272D4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E80B132C28;
	Tue,  9 Apr 2024 14:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kROJxz2H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6551311B9;
	Tue,  9 Apr 2024 14:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712671288; cv=none; b=pvQFcG8Bf6egaWtiHSbYfIaOtEiE74K54QyPfN+SY1ToQ3ZY0aKLnOFBrJfiXdMJBauFjO0xQSxjOSGFp/Q+vcWAZou9rdppscriwelBFT8IweUJ8Nth8ykaL6h4eTFAptAtQVntsrsXFuax6zFt7l1vtqxSfq96hnulINbyo78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712671288; c=relaxed/simple;
	bh=pzK3De1dss+tVtAMUbtIdEjmw37wYh3hyKahO2Wukx4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K8Ya5jHkE2TEDUcs4dF2eOgVrp1d/e+4IQxQaeT234MgMEJU+6zRGRH8bXKQhoB/v+hs4WYA5GmyDIntR75lF4gZMBa80bl6QyqSe//YxXWIAHQuk2HKTXICcoibRpu4Ce7ty81o19THA+oSZmp1oKF65GSKaDAdUX78gdc+8mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kROJxz2H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7EB6C433C7;
	Tue,  9 Apr 2024 14:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712671288;
	bh=pzK3De1dss+tVtAMUbtIdEjmw37wYh3hyKahO2Wukx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kROJxz2HYgYmtGzuLOF1DPUe3tsYi9DEJ86893KsN4RG8ZJ2ez8cLLlpXAt1q+/Kl
	 qsw9cy559op7Gxv7hDeh2gK/p4ba26iuHzPTC7VRjy8fdJqsEeWuiV5tQ46ZllP7S9
	 ZbUqQqTcngs3Ytvsbwu6cLLEvXW7Nxt/JPx3GQl+ZFB1AvwyGc2YMLAo/hvg8tvBen
	 9+cEIqTiHYc4GkmUn3bcMfpPwm+rwip2PT02QzrvVG9nPIOB5mO9PSmbiNRWl9VXLs
	 FleNYGV2Q6GW30vC1shIToVxt1l6zXaHmiQ47V5iFp8JJYeekoGWzq1qZ5bqNjGgJK
	 yhlh3nw+JpfcQ==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	"Richard Russon" <ldm@flatcap.org>,
	Jens Axboe <axboe@kernel.dk>,
	Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Lin Ming <ming.m.lin@intel.com>,
	Alexey Starikovskiy <astarikovskiy@suse.de>,
	linux-ntfs-dev@lists.sourceforge.net,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 4/5] [v2] blktrace: convert strncpy() to strscpy_pad()
Date: Tue,  9 Apr 2024 16:00:57 +0200
Message-Id: <20240409140059.3806717-5-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240409140059.3806717-1-arnd@kernel.org>
References: <20240409140059.3806717-1-arnd@kernel.org>
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
v2: actually use padding version of strscpy.
---
 kernel/trace/blktrace.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index d5d94510afd3..8fd292d34d89 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -524,8 +524,7 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	if (!buts->buf_size || !buts->buf_nr)
 		return -EINVAL;
 
-	strncpy(buts->name, name, BLKTRACE_BDEV_SIZE);
-	buts->name[BLKTRACE_BDEV_SIZE - 1] = '\0';
+	strscpy_pad(buts->name, name, BLKTRACE_BDEV_SIZE);
 
 	/*
 	 * some device names have larger paths - convert the slashes
-- 
2.39.2


