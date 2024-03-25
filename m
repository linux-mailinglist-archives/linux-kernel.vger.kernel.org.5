Return-Path: <linux-kernel+bounces-117741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A43188AEFB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 193FD1FA74BF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BA785955;
	Mon, 25 Mar 2024 18:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixlys0Fv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4324839E1;
	Mon, 25 Mar 2024 18:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711392129; cv=none; b=bjcb0DmLIAm78cJGspaJ8Sw03C0CdrrrHLtXcS0Xh8zsgIMZgTqb55776DtHaK6Yct+C+EEHlh/glYz3szBUXzzQ8JgjBmmjYhSdEKj8loImupwBDXs5puXZwoRd0zv8Kvcu/zrxeOFQwNxoUpqiQmZZFK/iOTkWM8iRIQKTsSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711392129; c=relaxed/simple;
	bh=0vGqEsBz6kkNYMQIbmmcvc1xkmF5mwH8qDi9HlBTkJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MLIyiGu+lYz9dfaRAhDu/Ifruw774jZ/x4GdbLYA5A6voExYSzzaREebBaWPvlABtAaiQMl2SEIbyjHgG4++9AmcDOV733cvCBRwFFFx5rgKhlzkMot9eLZSLPIPurX30koUEsQHR5CPGOaMAfW66Af+Grcj7wB63Di9UAwADXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixlys0Fv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18283C433F1;
	Mon, 25 Mar 2024 18:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711392128;
	bh=0vGqEsBz6kkNYMQIbmmcvc1xkmF5mwH8qDi9HlBTkJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ixlys0FvPCjjjZBr1Qs/lEGMZqYVEM+XiVzLoQ7H5oI72By/NxK2ZcTz0CU8Ch15l
	 +K4lW0o/ay78ArqVnDSDhDh++clj3uJ2vjjcXt5SC82Y7J/m+jdXZyZuehSWA+t9ki
	 6mRXTPJW4w1oX6ONyVYBE4xSFXKWCW+lWcvabLstDowPzZrUw1f12U0MSVGbAvIszp
	 iALYaGNhutZ6ullydsOxkWsK13m1TAaOzsRiJdOiGXprNc/HqQOGCEX5xue3X/tyDn
	 wCrhnpUICngyLiGIrywWLEx/Eiq4VBuYgJn2tzfmOKI3ieU1Er70wP8FwqUveBLBqE
	 uCE3An6XRbqZA==
From: Stephen Boyd <sboyd@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	patches@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	Taniya Das <quic_tdas@quicinc.com>,
	Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v2 5/5] clk: Get runtime PM before walking tree for clk_summary
Date: Mon, 25 Mar 2024 11:41:59 -0700
Message-ID: <20240325184204.745706-6-sboyd@kernel.org>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
In-Reply-To: <20240325184204.745706-1-sboyd@kernel.org>
References: <20240325184204.745706-1-sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to the previous commit, we should make sure that all devices are
runtime resumed before printing the clk_summary through debugfs. Failure
to do so would result in a deadlock if the thread is resuming a device
to print clk state and that device is also runtime resuming in another
thread, e.g the screen is turning on and the display driver is starting
up. We remove the calls to clk_pm_runtime_{get,put}() in this path
because they're superfluous now that we know the devices are runtime
resumed. This also squashes a bug where the return value of
clk_pm_runtime_get() wasn't checked, leading to an RPM count underflow
on error paths.

Fixes: 1bb294a7981c ("clk: Enable/Disable runtime PM for clk_summary")
Cc: Taniya Das <quic_tdas@quicinc.com>
Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index c69de47afaba..3539675ea846 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3318,9 +3318,7 @@ static void clk_summary_show_subtree(struct seq_file *s, struct clk_core *c,
 {
 	struct clk_core *child;
 
-	clk_pm_runtime_get(c);
 	clk_summary_show_one(s, c, level);
-	clk_pm_runtime_put(c);
 
 	hlist_for_each_entry(child, &c->children, child_node)
 		clk_summary_show_subtree(s, child, level + 1);
@@ -3330,11 +3328,15 @@ static int clk_summary_show(struct seq_file *s, void *data)
 {
 	struct clk_core *c;
 	struct hlist_head **lists = s->private;
+	int ret;
 
 	seq_puts(s, "                                 enable  prepare  protect                                duty  hardware                            connection\n");
 	seq_puts(s, "   clock                          count    count    count        rate   accuracy phase  cycle    enable   consumer                         id\n");
 	seq_puts(s, "---------------------------------------------------------------------------------------------------------------------------------------------\n");
 
+	ret = clk_pm_runtime_get_all();
+	if (ret)
+		return ret;
 
 	clk_prepare_lock();
 
@@ -3343,6 +3345,7 @@ static int clk_summary_show(struct seq_file *s, void *data)
 			clk_summary_show_subtree(s, c, 0);
 
 	clk_prepare_unlock();
+	clk_pm_runtime_put_all();
 
 	return 0;
 }
@@ -3390,8 +3393,14 @@ static int clk_dump_show(struct seq_file *s, void *data)
 	struct clk_core *c;
 	bool first_node = true;
 	struct hlist_head **lists = s->private;
+	int ret;
+
+	ret = clk_pm_runtime_get_all();
+	if (ret)
+		return ret;
 
 	seq_putc(s, '{');
+
 	clk_prepare_lock();
 
 	for (; *lists; lists++) {
@@ -3404,6 +3413,7 @@ static int clk_dump_show(struct seq_file *s, void *data)
 	}
 
 	clk_prepare_unlock();
+	clk_pm_runtime_put_all();
 
 	seq_puts(s, "}\n");
 	return 0;
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


