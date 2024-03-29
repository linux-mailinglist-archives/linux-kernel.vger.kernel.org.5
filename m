Return-Path: <linux-kernel+bounces-124498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B098918F0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D788F1C24C28
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E41913EFE4;
	Fri, 29 Mar 2024 12:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evZd6Szs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B549013E89F;
	Fri, 29 Mar 2024 12:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715242; cv=none; b=aJLiRhpJPSXzznL6e9NImBSomzbRBTChC4iY5vxp6cpsXhhJ5iMwLHaW8CIjtPKW0HGoDDVm/4TRZ16IPeIj02Za0UT3AY2L8xFqGRyJ7z3i1GIR0OD3P6h3tP5Syy1Ot98UHSZS6vF+H4Z4XBCFWB6X1p5XpdrBn2Ud0cSeRNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715242; c=relaxed/simple;
	bh=clxWihJjspTTiqyEKqg1yvayyGIOfGSuJL9pp69ouIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q8RJdWxSBNYOvAcxmJ3tS5yTY7wuVCKDg8CVSJ/93kTyTkTE/c8YCPq25laNIksbB2tdYTNtHzkduG8qf39pH7wYEg2CHNJfQVPfpDSpcz+5BvMUR4I7MnFW+Zv2viveAwYrqe39RkUiMeI+jbbMqyV8xDxpJkU3t1nXhNi0hr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evZd6Szs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC6D8C433F1;
	Fri, 29 Mar 2024 12:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715242;
	bh=clxWihJjspTTiqyEKqg1yvayyGIOfGSuJL9pp69ouIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=evZd6SzsMh2UU68WNXFky0gXs6fPlPVD8r8159+gD/1CP/yvpyouP6UeE8FUIHWS/
	 7Z8jKFRS9OfzxTuqtlwSsjyLvJ5T84n1tnT2t29ttMiDNxG+AD0ROrPRi7CpfNiDKQ
	 iHGXTipWFruwQmk2Zt5EP8DtwPBMtiD3TTu4C/fLKu9dNKFfWV9ffC7wOnsSiCE98W
	 oCxm3+S9l0K4NlJvNy+E4bXLyJWzzWpbayFQDpx2kZdYPS3H5XFxTgGmFzyNuSxyui
	 MHPI7mxgBbJHB8yt+58oXM4Y1hU0ZX4s+y70205ylSqaOfDQKsbQs0bgvgBPOAdfrm
	 VaFCJ09VQ9Yvw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: John Ogness <john.ogness@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.8 17/68] printk: For @suppress_panic_printk check for other CPU in panic
Date: Fri, 29 Mar 2024 08:25:13 -0400
Message-ID: <20240329122652.3082296-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122652.3082296-1-sashal@kernel.org>
References: <20240329122652.3082296-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: John Ogness <john.ogness@linutronix.de>

[ Upstream commit 0ab7cdd00491b532591ef065be706301de7e448f ]

Currently @suppress_panic_printk is checked along with
non-matching @panic_cpu and current CPU. This works
because @suppress_panic_printk is only set when
panic_in_progress() is true.

Rather than relying on the @suppress_panic_printk semantics,
use the concise helper function other_cpu_in_progress(). The
helper function exists to avoid open coding such tests.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240207134103.1357162-7-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/printk/printk.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index f2444b581e16c..d9f20d222293b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2270,8 +2270,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 	if (unlikely(suppress_printk))
 		return 0;
 
-	if (unlikely(suppress_panic_printk) &&
-	    atomic_read(&panic_cpu) != raw_smp_processor_id())
+	if (unlikely(suppress_panic_printk) && other_cpu_in_panic())
 		return 0;
 
 	if (level == LOGLEVEL_SCHED) {
-- 
2.43.0


