Return-Path: <linux-kernel+bounces-116027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C8888950B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA0341F23B6D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E7326B80A;
	Mon, 25 Mar 2024 03:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8/O3aTR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF37175C8E;
	Sun, 24 Mar 2024 23:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323390; cv=none; b=cGwnlPKLvBdatKG4nf6IHhzb0SYRfIznWj6EN5GBSWlUDa8Ul1kV1HUHykptxylG1Mb0W0WM8gC6w3S8MNCuwhsgnGnJX77VrnTg3afTsv6baxwXjUbtYaq8pjCNwR+aLqEH+OqNEw5A0eLVOTN4RkO3XxiF91tcgSnG8qn8pBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323390; c=relaxed/simple;
	bh=uyYm/hTPynukJH3N+FZgPpV/0Ja5FnJGYAm2qYYs7Qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hhd68pIQpx1hAmmGz/mSrKBi/q0egW9SPlJXbhbS+d/QKaKl2IY/CQ36pa9BKREvGMcozFSDXfKa3kkY67jg9dRRMSA828vr29P0r9BHP+6wHvljljwl+vPaA34Kjqdw63FOe8QlTf338BGpGExnojJz2rKuf9Sgfm3Ps2LzP54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8/O3aTR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55CCEC43390;
	Sun, 24 Mar 2024 23:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323390;
	bh=uyYm/hTPynukJH3N+FZgPpV/0Ja5FnJGYAm2qYYs7Qo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B8/O3aTRSkKRi9YNVzlYRQGwm71/oUb8nrEZ9pilMtJqKQJEjEwre5ojmILFv6LeN
	 qXUrZmercaIa4ClnMBS1KrQYY5RlVF8G1VYNDti/+qRNRNCrmaLNY2TPOzn+IVuXT0
	 TBJyXZT3w4Opl5yT1+4kNHkf1fph/Ht0C/5Fr8/5q7AoUrHFaQI4DaDiUYTucutSW6
	 kWLxt16PrjCs/P3a22PNnQc3c663z0sOSOvXELSRQ3p3kKFnuCq7eJxIQdA6bsL+no
	 BcFZDgv9lA7qs+7LT5jyKFPwxgLPlFufYNGLHfzqvd+8ZlIO2TDMx2pQ6uSxCCE2LA
	 m5BBeDdKmMvUg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 090/317] printk: Add panic_in_progress helper
Date: Sun, 24 Mar 2024 19:31:10 -0400
Message-ID: <20240324233458.1352854-91-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index 8b110b245d92c..de44ccf9743c1 100644
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


