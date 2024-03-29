Return-Path: <linux-kernel+bounces-124562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4478919F5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47EE21F25E57
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2D4153505;
	Fri, 29 Mar 2024 12:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxHoIsVh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732FD152E0D;
	Fri, 29 Mar 2024 12:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715414; cv=none; b=pXl2BzvbYIOYCse0NTKz5+NDP8416ispmM0ip9NOEtGF+AaHwgISwiRsjZQItNtAYQ+9dpbrFsNG/SPax/qwMCsddL8nAvy+oc8BF9X9gmKbtqQmHuor23jOrfzyj/vo9Pss3kD0janWP4IMzIZT2nX9/X1ckgN3/1ZANqsB9Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715414; c=relaxed/simple;
	bh=0EtcZnQ2ML1W/UpP30qzVQ2kdJfgXO/n9Svx2XlLXWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cO48rhets1WyY4oN1SFjb7sqqULtL7mKIhii0uI5SmfcolWEmXA9l6KM3pt5pDNFcrOkbscNlhsC0G7pcmBu1nXT8u0AkFCKxhW6K2xzUUGs1+RhK5d4CDutB7iv5IeoYCRjfEM6XPT+q2N3u8VshcfAHa/4a80RbCNGFt475aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxHoIsVh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC09C433C7;
	Fri, 29 Mar 2024 12:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715414;
	bh=0EtcZnQ2ML1W/UpP30qzVQ2kdJfgXO/n9Svx2XlLXWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sxHoIsVhyf284hqlEZ8iTGbN3bciYGGlvmXih21cnhOTZrLj7iyz8T6we6ew6ZYu+
	 Tsn13YH8ByQ+PnwiUyu+qzcuoX8ZDWnjIK0pacg0cW/z5ky3fkRtTsobACswxpq9/O
	 +SoTFwKGmWGXAss5LHJO1aXKe6nmQzfpDUmYDB2pIlNlcunu0IQU00YHuFt1liuz9x
	 wBWFlMxXWoKJ5pG8ScxAAZcoXLOOaATJoy3YDvZXUp2W0s741LJlEC7m9MD0QNMRe3
	 YAdoN2iI8ykzWItdJgqM4LxqbpAIJ2TqsizT66LpyNHx1QOMenWdNqtmiIdNknT33l
	 jmP6Ac1/zdtFA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: John Ogness <john.ogness@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.6 11/52] printk: For @suppress_panic_printk check for other CPU in panic
Date: Fri, 29 Mar 2024 08:28:41 -0400
Message-ID: <20240329122956.3083859-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122956.3083859-1-sashal@kernel.org>
References: <20240329122956.3083859-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
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
index 0b3af1529778c..9ca10507f7c47 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2274,8 +2274,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 	if (unlikely(suppress_printk))
 		return 0;
 
-	if (unlikely(suppress_panic_printk) &&
-	    atomic_read(&panic_cpu) != raw_smp_processor_id())
+	if (unlikely(suppress_panic_printk) && other_cpu_in_panic())
 		return 0;
 
 	if (level == LOGLEVEL_SCHED) {
-- 
2.43.0


