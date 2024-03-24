Return-Path: <linux-kernel+bounces-116141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7082B8896BC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B8D428AE1D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA273AFAC9;
	Mon, 25 Mar 2024 03:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSkINt1F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9755C600;
	Sun, 24 Mar 2024 23:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323689; cv=none; b=cUEgSZTacsTptTY08dGpi45BD1adGdCciXXeFuqVvucndCZ4Q3QLAMdv2hrGTzdyQTFLKvSymN6ydhcQHJVLkrOQhSJW9gDvQ9kXeeF5P19FuVMjw/D8djsJVrYtntrL3RS+/Cklr/BM6mptkmMt0tCrVpS8UdeL8qrYiTTU4mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323689; c=relaxed/simple;
	bh=WpIpVWQpJ5OjInFNBU0qyU6PNSvlKenQXTz605Sz9kY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AnEUySkjbQPhaDWUL6PnGrxyazPN6r3k8+qsUZKhUyxIFYiwcT2uFXE7SK/FyHLKxzljyci7OB7sq0mDRxjyF+JuZN9PgW4esg3I/wq6wVAca+yDm2LrI7vLAZL0HSx7RygD/j7O5iY/Qln0uNLIR2dIOLaItRbQCpm6QqvAE3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSkINt1F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41DF8C433C7;
	Sun, 24 Mar 2024 23:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323688;
	bh=WpIpVWQpJ5OjInFNBU0qyU6PNSvlKenQXTz605Sz9kY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jSkINt1Ffow3wKqTEyBqkdvOAQCdymNczqnQGYxGwiIY53MsZqFj/lJm/kXTKUxZi
	 SggnJHvXKZ8jS0t94IohkzDzEboCzVVPkfKy2vOdaF0WOMA7v9B3ZNxQG2tJOlvLDW
	 dvHo80ChkUCPk2YcgrF6obl67oi1SS4MT1sKTY9Dc8JVzdU9Ow05kwISfdtNRmDZ5L
	 iA8kKlad/62n0lyF0XfpYxQGg8WeJDoc0vxcsxH96TkJqbMoMpcVSElqTfdEXb2+f6
	 lGzj6Iij3C3fB0OpekbcznV/K4jNF9Dv267ToUgpCb8OfZH5DPVXAt6NU+FDmRJ6QQ
	 kl22OExkMuDCQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 060/238] printk: Add panic_in_progress helper
Date: Sun, 24 Mar 2024 19:37:28 -0400
Message-ID: <20240324234027.1354210-61-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Stephen Brennan <stephen.s.brennan@oracle.com>

[ Upstream commit 77498617857f68496b360081dde1a492d40c28b2 ]

This will be used help avoid deadlocks during panics. Although it would
be better to include this in linux/panic.h, it would require that header
to include linux/atomic.h as well. On some architectures, this results
in a circular dependency as well. So instead add the helper directly to
printk.c.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20220202171821.179394-2-stephen.s.brennan@oracle.com
Stable-dep-of: d04d5882cd67 ("printk: Disable passing console lock owner completely during panic()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/printk/printk.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 17a310dcb6d96..94af80b7fa9b5 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -258,6 +258,11 @@ static void __up_console_sem(unsigned long ip)
 }
 #define up_console_sem() __up_console_sem(_RET_IP_)
 
+static bool panic_in_progress(void)
+{
+	return unlikely(atomic_read(&panic_cpu) != PANIC_CPU_INVALID);
+}
+
 /*
  * This is used for debugging the mess that is the VT code by
  * keeping track if we have the console semaphore held. It's
-- 
2.43.0


